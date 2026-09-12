# AGENTS.md — creatrolex44111

Context for AI coding agents (Claude Code, Codex, opencode, Cursor, …) working in
this repo. Read this first.

## What this is
A legacy (2022) **one-shot bash utility** that creates a cross-account IAM role for the
Env0 SaaS (`Cloudnexa-Env0`): it generates a date-based external ID, substitutes it into
a trust policy, creates the role, sets an 8-hour session duration, and attaches managed
policies (`CloudWatchFullAccess`, `ReadOnlyAccess`, `EventBridgeFullAccess`). A
console-era script, not a module or a pipeline.

Current state: **parked**.

## Layout
- `env0/create.sh` — the script (`aws iam` CLI; reads `trust.json`).
- `env0/trust.json` — role trust policy; the literal string `externalid` is a placeholder
  that `create.sh` rewrites in place via `sed`.

## Commands
- Needs a local `aws` CLI with admin credentials in the target account, then:
  `cd env0 && bash create.sh`
- No test, lint, or CI setup.

## Gotchas
- The external ID is `env0<DDMM>` — it **rotates daily**. Re-running on a different day
  produces a different ID and rewrites `trust.json`, so the working tree goes dirty after
  every run. Don't commit the substituted values.
- `trust.json` trusts a **fixed third-party AWS account** (`913128560467`, Env0). Review
  before reuse; widening the trust or the policy set is a security decision.
- The script attaches broad AWS managed policies (CloudWatch/EventBridge **Full** access,
  ReadOnly) — not least-privilege. Prefer scoped policies if reviving.
- No error handling: `aws` failures don't stop the script, and `sed` rewrites the tracked
  `trust.json` rather than a temp copy.
- Workspace convention (see `~/.openclaw/workspace/AGENTS.md`): new AWS infra goes through
  Terraform applied by GitHub Actions. This repo predates that — port it rather than
  extending it.
