#!/bin/bash
# Pushes any local commits on this repo's main branch to GitHub, if there are any.
# Installed as a per-user launchd agent (see .launchagent/) so it fires on login
# and every few minutes while the Mac is awake — the goal is "push shortly after
# I open my laptop" without needing to remember to do it by hand.
cd "$(dirname "$0")" || exit 1
export PATH="/usr/local/bin:/opt/homebrew/bin:$PATH"
git fetch origin main --quiet 2>/dev/null
AHEAD=$(git rev-list --count origin/main..main 2>/dev/null)
if [ -n "$AHEAD" ] && [ "$AHEAD" -gt 0 ] 2>/dev/null; then
    echo "$(date): $AHEAD commit(s) ahead, pushing..."
    git push origin main
else
    echo "$(date): nothing to push"
fi
