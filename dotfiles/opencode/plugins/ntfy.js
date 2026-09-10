const eventDetails = {
	"session.idle": {
		title: "OpenCode completed",
		message: "A session is waiting for your next instruction.",
		tags: "white_check_mark",
		priority: "default",
	},
	"session.error": {
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
	"permission.updated": {
		title: "OpenCode permission needed",
		message: "A session is waiting for permission.",
		tags: "lock",
		priority: "high",
	},
	"question.asked": {
		title: "OpenCode question",
		message: "A session is waiting for your answer.",
		tags: "question",
		priority: "high",
	},
};

const deduplicationWindowMs = 30_000;

export const NtfyNotifications = async () => {
	const topic = process.env.OPENCODE_NTFY_TOPIC;
	if (!topic) return {};

	const server = (process.env.OPENCODE_NTFY_URL ?? "https://ntfy.sh").replace(
		/\/$/,
		"",
	);
	const token = process.env.OPENCODE_NTFY_TOKEN;
	const sent = new Map();

	return {
		event: async ({ event }) => {
			const details = eventDetails[event.type];
			if (!details) return;

			const sessionID = event.properties?.sessionID ?? "global";
			const key = `${event.type}:${sessionID}`;
			const now = Date.now();
			if (now - (sent.get(key) ?? 0) < deduplicationWindowMs) return;
			sent.set(key, now);

			try {
				await fetch(`${server}/${encodeURIComponent(topic)}`, {
					method: "POST",
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
		},
	};
};
