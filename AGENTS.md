## Git and GitHub workflow

### Branches

- Never commit to `main`. Work on a new branch for every task.
- Name branches `agent/$AGENT_NAME/<issue-number>-<short-slug>`,
  e.g. `agent/codex/42-fix-login-timeout`.
  Read `AGENT_NAME` from the environment; if it is unset, use your own name (`claude` or `codex`).
- If there is no issue, use `agent/$AGENT_NAME/<short-slug>`.

### Commits

- Subject line in the imperative mood, max 72 characters ("Fix login timeout", not "Fixed…").
- Reference the issue in the body: `Refs #42`.
- All commits must be signed. Never use `--no-gpg-sign`, `--no-verify`,
  or `-c commit.gpgsign=false`. If signing or a hook fails, stop and report the error.

### Pull requests

- Open PRs with `gh pr create --draft --label agent --reviewer @teopenna`.
- Write the body following `.github/pull_request_template.md` and fill in every section;
  pass it with `--body-file`. Write "None" rather than deleting a section.
- Put `Closes #<issue>` in the body when the PR fully resolves the issue.
- Never merge, approve, or mark your own PR as ready for review.
