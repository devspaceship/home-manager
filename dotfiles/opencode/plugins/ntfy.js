import { Plugin } from "@opencode/plugin";

const eventDetails = {
	"session.idle": {
		title: "OpenCode completed",
		message: "A session is waiting for your next instruction.",
		tags: "white_check_mark",
		priority: "default",
	},
	"session.execution.failed": {
		title: "OpenCode error",
		message: "A session encountered an error and needs attention.",
		tags: "warning",
		priority: "high",
	},
	"permission.asked": {
		title: "OpenCode permission needed",
		message: "A session is waiting for permission.",
		tags: "lock",
		priority: "high",
	},
	"form.created": {
		title: "OpenCode question",
		message: "A session is waiting for your answer.",
		tags: "question",
		priority: "high",
	},
};

const deduplicationWindowMs = 30_000;

export default Plugin.define({
	id: "ntfy-notifications",
	setup(ctx) {
		const topic = process.env.OPENCODE_NTFY_TOPIC;
		if (!topic) return;

		const server = (process.env.OPENCODE_NTFY_URL ?? "https://ntfy.sh").replace(
			/\/$/,
			"",
		);
		const token = process.env.OPENCODE_NTFY_TOKEN;
		const sent = new Map();
		const controller = new AbortController();

		void (async () => {
			for await (const event of ctx.event.subscribe({
				types: [
					"session.idle",
					"session.execution.failed",
					"permission.asked",
					"form.created",
				],
				signal: controller.signal,
			})) {
				const details = eventDetails[event.type];
				if (!details) continue;

				const sessionID =
					event.data.sessionID ?? event.data.form?.sessionID ?? "global";
				// Session-less forms are integration setup, not agent questions.
				if (event.type === "form.created" && !event.data.form?.sessionID)
					continue;
				const key = `${event.type}:${sessionID}`;
				const now = Date.now();
				if (now - (sent.get(key) ?? 0) < deduplicationWindowMs) continue;
				sent.set(key, now);

				try {
					await fetch(`${server}/${encodeURIComponent(topic)}`, {
						method: "POST",
						signal: controller.signal,
						headers: {
							Title: details.title,
							Message: details.message,
							Priority: details.priority,
							Tags: details.tags,
							...(token ? { Authorization: `Bearer ${token}` } : {}),
						},
					});
				} catch {
					// Notifications must not interrupt an OpenCode session.
				}
			}
		})().catch((error) => {
			if (!controller.signal.aborted)
				console.error("ntfy event subscription failed", error);
		});
		return () => controller.abort();
	},
});
