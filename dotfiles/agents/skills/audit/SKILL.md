---

name: audit
description: Assess security exposure in code, dependencies, and configuration, including Dependabot alerts. Use for security audits and vulnerability investigations, not general code review.
---

# Security Audit

Assess actual exposure with evidence. Audit only; do not fix issues, update dependencies, or mutate external records.

## Scope and baseline

1. Establish the target, requested scope, environment, and baseline. Default to the current working tree for a general audit; identify its revision and relevant local changes.
2. For a Dependabot alert, read `references/dependabot.md` and use its explicit main-branch baseline instead.
3. Identify relevant entry points, trust boundaries, sensitive assets, and attacker capabilities. State scope limits rather than implying a comprehensive audit.

## Investigate

1. Inspect authentication and authorization, input handling and injection, sensitive data exposure, dependency vulnerabilities, and security-sensitive configuration.
2. Trace suspected vulnerabilities from attacker-controlled input to the affected operation. Establish prerequisites, reachable code paths, and consequences.
3. For dependencies, verify the resolved version, affected range, direct or transitive relationship, runtime or build context, and exposure conditions. A scanner alert alone is not proof of exploitability; lack of an obvious import is not proof of safety.
4. Separate demonstrated vulnerabilities from plausible risks and missing evidence. Use authoritative advisories when available and cite them.
5. Prefer static inspection. Obtain approval before running scanners or repository code, explaining potential network access, data disclosure, and writes. Do not install tools, auto-fix, actively exploit targets, or probe production without specific authorization.
6. Never print secrets as evidence. Refer to the location and type of exposure without reproducing sensitive values.

## Output

- Findings first, ordered by severity, with affected locations, prerequisites, impact, evidence, and focused remediation.
- Distinguish confirmed vulnerabilities from unverified risks. Explain severity rather than inventing unsupported scores.
- State the audited scope and baseline, checks performed, limitations, and missing evidence.
- If no findings are identified, say so without claiming the target is secure.
- For Dependabot alerts, use the verdicts and output format in the reference.
