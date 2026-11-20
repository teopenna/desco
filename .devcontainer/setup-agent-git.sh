#!/usr/bin/env bash
set -euo pipefail
AGENT_LOGIN="teopenna-agent"
AGENT_ID="358021140"   # from https://api.github.com/users/teopenna-agent

install -m 700 -d ~/.ssh
install -m 600 /run/agent-secrets/agent_ed25519 ~/.ssh/agent_ed25519

git config --global user.name  "$AGENT_LOGIN"
git config --global user.email "${AGENT_ID}+${AGENT_LOGIN}@users.noreply.github.com"
git config --global gpg.format ssh
git config --global user.signingkey ~/.ssh/agent_ed25519
git config --global commit.gpgsign true

gh auth setup-git   # git push/pull over HTTPS using GH_TOKEN

# Per-agent wrappers (added only once)
if ! grep -q '# agent-wrappers' ~/.zshrc 2>/dev/null; then
    cat >> ~/.zshrc <<'EOF'
    # agent-wrappers
    ccl() { AGENT_NAME=claude GIT_AUTHOR_NAME="teopenna-agent (claude)" GIT_COMMITTER_NAME="teopenna-agent (claude)" claude "$@"; }
    cx()  { AGENT_NAME=codex  GIT_AUTHOR_NAME="teopenna-agent (codex)"  GIT_COMMITTER_NAME="teopenna-agent (codex)"  codex --sandbox danger-full-access --ask-for-approval on-request "$@"; }
EOF
fi