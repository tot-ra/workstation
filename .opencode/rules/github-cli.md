# GitHub CLI (gh)

Используй `gh` для работы с GitHub: PR, issues, CI/CD, releases.

## Pull Requests

```bash
# Список PR
gh pr list

# Детали PR
gh pr view 123
gh pr view 123 --comments

# Создать PR
gh pr create --title "Title" --body "Description"

# Проверить статус CI
gh pr checks 123

# Комментарии PR через API
gh api repos/{owner}/{repo}/pulls/123/comments
```

## Issues

```bash
gh issue list
gh issue view 456
gh issue create --title "Bug" --body "Description"
```

## CI/CD (Actions)

```bash
# Список workflow runs
gh run list

# Детали run
gh run view 789

# Логи failed run
gh run view 789 --log-failed

# Перезапуск
gh run rerun 789
```

## Releases

```bash
gh release list
gh release view v1.0.0
```

## Полезные флаги

- `--json` - вывод в JSON для парсинга
- `--jq` - фильтрация JSON
- `-R owner/repo` - указать репозиторий

## Примеры

```bash
# PR с failed checks
gh pr checks 123 --json name,state --jq '.[] | select(.state=="FAILURE")'

# Последний failed workflow
gh run list --status failure --limit 1
```
