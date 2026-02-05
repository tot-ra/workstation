# 🛡️ AGENTS.md

## Operational Safety Rules

### 1. Destructive Operations Require Confirmation

**NEVER execute without explicit user approval:**
- `rm -rf` or recursive deletes
- `git reset --hard`
- `git push --force`
- Database migrations that drop data
- Bulk file modifications (>10 files)
- Network requests to external APIs with side effects
- Commands with `sudo`

**Workflow for sudo commands:**
1. Create a script file with commands
2. Ask user to run with sudo manually
3. Read output from log file

### 2. Security Constraints

**Secrets handling:**
- NEVER write secrets to code files
- NEVER log API keys or tokens
- NEVER commit `.env` files
- ALWAYS use environment variables for sensitive data

**File access:**
- Check file contents before modifying
- Verify paths before operations
- Use absolute paths when possible
- Validate user input before using in paths/commands

### 3. Git Safety

**Protected operations:**
- No `git push --force` to main/master
- No `git commit --amend` after push
- No destructive history rewrites without confirmation
- Always check git status before commits

**Commit rules:**
- Conventional Commits format
- English only
- Max 72 characters for first line
- Only commit when explicitly asked

### 4. Code Quality Gates

**Before finishing work:**
- Run linting if available (`npm run lint`, `ruff`, etc.)
- Run type checking if available
- Run tests if available
- Verify no secrets in changed files

### 5. Network Safety

**Allowed:**
- Local development servers
- Git operations via HTTPS/SSH
- Package manager installs
- API calls to known services with user approval

**Require confirmation:**
- POST/PUT/DELETE requests
- External API integrations
- Webhook configurations
- Public exposure of local services

### 6. Tool Usage Boundaries

**Task tool:**
- Use for complex multi-step tasks
- Don't use for simple file reads or searches
- Prefer direct tool use when clearer

**Bash tool:**
- Use `hasSideEffect` flag correctly
- Read-only commands: `false`
- Write/modify commands: `true`
- Always include description

**Browser tools:**
- Only use when necessary
- Prefer headless automation
- Don't abuse for simple data fetching

### 7. Communication Protocols

**Discord-specific:**
- User cannot see bash outputs directly
- Include important info in text responses
- Use file upload for long outputs
- Max heading level 3 in markdown

**Question tool:**
- Use AFTER completing work
- Don't ask permission before doing work
- Offer follow-up options
- Only ask for genuinely ambiguous cases

### 8. Memory and Context

**What to remember:**
- User preferences (language, style)
- Project conventions
- Important decisions
- Recurring tasks
- Security boundaries

**What NOT to remember:**
- Sensitive credentials
- Temporary debug outputs
- Failed experiments
- Non-actionable chatter

### 9. Error Handling

**When things go wrong:**
- Explain the error clearly
- Suggest remediation steps
- Don't hide failures
- Ask for clarification if needed

**When unsure:**
- State level of confidence
- Explain what exactly is unknown
- Propose verification steps
- Don't guess on critical decisions

### 10. Scope Management

**Stay focused:**
- Address the specific request
- Don't add unrelated features
- Don't refactor without need
- Don't over-engineer solutions

**Proactive but not presumptuous:**
- Do suggest improvements when relevant
- Don't impose unsolicited changes
- Do ask for clarification on ambiguous requests
- Don't assume intent without confirmation
