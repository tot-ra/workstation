# Git Commits

## Conventional Commits

All commit messages must be in **English** and follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <description>

[optional body]
```

## Types

| Type | Description |
|------|-------------|
| `feat` | New feature |
| `fix` | Bug fix |
| `docs` | Documentation only |
| `style` | Formatting, no code change |
| `refactor` | Code change, no feature/fix |
| `perf` | Performance improvement |
| `test` | Adding/fixing tests |
| `chore` | Maintenance, deps, configs |
| `ci` | CI/CD changes |
| `revert` | Revert previous commit |

## Rules

- **Language**: English only
- **Description**: lowercase, imperative mood ("add" not "added")
- **Length**: max 72 characters for first line
- **Scope**: optional, indicates area (e.g., `feat(api): ...`)
- **Breaking changes**: add `!` after type or `BREAKING CHANGE:` in body

## Examples

```bash
# Feature
feat(auth): add OAuth2 login support

# Bug fix
fix(parser): handle empty input correctly

# Breaking change
feat(api)!: change response format to JSON

# With body
fix(db): resolve connection timeout issue

Increased pool size and added retry logic.
Closes #123
```

## Bad Examples

```bash
# Wrong: not English
❌ feat: добавлен новый компонент

# Wrong: not imperative
❌ feat: added new feature

# Wrong: too vague
❌ fix: bug fix

# Wrong: no type
❌ update readme
```
