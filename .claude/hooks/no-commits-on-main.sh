#!/bin/bash
# Stop-hook backstop for the "always commit + PR, never commit to main" policy
# in CLAUDE.md. Blocks ending the session while material work is sitting
# uncommitted or unpushed directly on main/master in a GitHub repo.
set -euo pipefail

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  exit 0
fi

remote_url=$(git remote get-url origin 2>/dev/null || echo "")
if [[ "$remote_url" != *github.com* ]]; then
  exit 0
fi

branch=$(git branch --show-current 2>/dev/null || echo "")
if [[ "$branch" != "main" && "$branch" != "master" ]]; then
  exit 0
fi

dirty=$(git status --porcelain 2>/dev/null || echo "")
ahead=0
upstream=$(git rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null || echo "")
if [[ -n "$upstream" ]]; then
  ahead=$(git rev-list "$upstream..HEAD" 2>/dev/null | wc -l | tr -d ' ')
fi

if [[ -n "$dirty" || "$ahead" -gt 0 ]]; then
  reason="You're on $branch with uncommitted or unpushed changes in a GitHub repo. Per CLAUDE.md policy: branch off $branch, commit the material changes there, and open a PR — never leave work sitting on $branch. Do that now before stopping."
  printf '{"continue": false, "stopReason": %s, "systemMessage": "Blocked stop: uncommitted/unpushed work on %s — branch, commit, and open a PR first."}\n' \
    "$(printf '%s' "$reason" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))')" \
    "$branch"
  exit 0
fi

exit 0
