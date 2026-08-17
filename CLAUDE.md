## gstack (REQUIRED — global install)

**Before doing ANY work, verify gstack is installed:**

```bash
test -d ~/.claude/skills/gstack/bin && echo "GSTACK_OK" || echo "GSTACK_MISSING"
```

If GSTACK_MISSING: STOP. Do not proceed. Tell the user:

> gstack is required for all AI-assisted work in this repo.
> Install it (this project uses apratsunrthd's fork):
> ```bash
> git clone --single-branch --depth 1 https://github.com/apratsunrthd/gstack.git ~/.claude/skills/gstack
> cd ~/.claude/skills/gstack && ./setup --team
> ```
> Then restart your AI coding tool.

Do not skip skills, ignore gstack errors, or work around missing gstack.

Using gstack skills: After install, skills like /qa, /ship, /review, /investigate,
and /browse are available. Use /browse for all web browsing — never use
mcp__claude-in-chrome__* tools directly.

Available skills: /office-hours, /plan-ceo-review, /plan-eng-review, /plan-design-review,
/design-consultation, /design-shotgun, /design-html, /review, /ship, /land-and-deploy,
/canary, /benchmark, /browse, /connect-chrome, /qa, /qa-only, /design-review,
/setup-browser-cookies, /setup-deploy, /setup-gbrain, /retro, /investigate,
/document-release, /document-generate, /codex, /cso, /autoplan, /plan-devex-review,
/devex-review, /careful, /freeze, /guard, /unfreeze, /gstack-upgrade, /learn.

Use ~/.claude/skills/gstack/... for gstack file paths (the global install path).

## Standing commit + PR policy (REQUIRED)

Material changes in this repo always get committed to a non-main branch and
shipped via a pull request — done automatically, without asking per-instance.
Never commit directly to `main`, and never leave material changes sitting
uncommitted. This applies regardless of whether the work went through a
gstack skill (e.g. `/ship`) or was built directly — that distinction doesn't
matter. This supersedes the general default of asking before every commit;
this instruction is the standing authorization for the ordinary
branch → commit → push → PR path.

Exceptions: destructive or history-rewriting git operations (force-push,
`reset --hard`, amending pushed commits) still require explicit confirmation.
"Material" means real changes a user would want reviewed or preserved — not a
throwaway scratch file, a read-only investigation, or work explicitly framed
as exploratory/local-only.

A Stop-hook backstop (`.claude/hooks/no-commits-on-main.sh`, registered in
`.claude/settings.json`) blocks ending a session while this repo is left on
`main`/`master` with uncommitted or unpushed changes, so the policy holds
even if a session forgets it in prose.
