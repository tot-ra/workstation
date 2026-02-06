# Управление периодическими задачами (opencode-scheduler)

Система для автоматического выполнения задач по расписанию с использованием systemd timers.

## Быстрый старт

```bash
# Просмотр задач
opencode list-jobs
systemctl --user list-timers | grep opencode

# Создание задачи
opencode schedule-job --name "my-task" --schedule "0 9 * * *" --prompt "Выполнить задачу"

# Управление
systemctl --user start opencode-job-<name>.timer    # Запустить
systemctl --user enable opencode-job-<name>.timer   # Автозапуск
systemctl --user status opencode-job-<name>.timer   # Статус
opencode delete-job <name>                          # Удалить
```

## Формат расписания (cron)

```
* * * * *
│ │ │ │ └─── День недели (0-7)
│ │ │ └───── Месяц (1-12)
│ │ └─────── День месяца (1-31)
│ └───────── Час (0-23)
└─────────── Минута (0-59)
```

| Расписание | Описание |
|------------|----------|
| `0 9 * * *` | Каждый день в 9:00 |
| `0 17 * * 5` | Пятница в 17:00 |
| `0 20 * * 0` | Воскресенье в 20:00 |
| `0 19 15 * *` | 15-го числа в 19:00 |
| `0 */6 * * *` | Каждые 6 часов |

## Структура файлов

Задачи хранятся в `~/.config/systemd/user/`:

**Таймер** (`opencode-job-<name>.timer`):
```ini
[Unit]
Description=Timer for: my-task

[Timer]
OnCalendar=*-*-* 09:00:00
Persistent=true

[Install]
WantedBy=timers.target
```

**Сервис** (`opencode-job-<name>.service`):
```ini
[Unit]
Description=OpenCode Job: my-task

[Service]
Type=oneshot
WorkingDirectory=/home/gratheon/git/project
ExecStart=/bin/bash -c '/home/gratheon/.opencode/bin/opencode run -- "Ваш промпт"'
StandardOutput=append:/home/gratheon/.config/opencode/logs/my-task.log
StandardError=append:/home/gratheon/.config/opencode/logs/my-task.log

[Install]
WantedBy=default.target
```

## Отладка

```bash
# Логи
journalctl --user -u opencode-job-<name>.service -n 50

# Ручной запуск
systemctl --user start opencode-job-<name>.service

# Перезагрузка конфигурации
systemctl --user daemon-reload
systemctl --user restart opencode-job-<name>.timer
```

## Лучшие практики

- **Именование**: `daily-backup`, `weekly-report` вместо `job1`, `task2`
- **Логи**: Всегда указывайте `StandardOutput/Error` с путём к логу
- **Пути**: Используйте абсолютные пути (`/home/gratheon/...`, не `~/...`)
- **Промпты**: Для сложных промптов используйте `ExecStart=/bin/bash -c '...'`
- **Скрипты**: Для сложной логики создавайте отдельный `.sh` скрипт в `~/.config/opencode/jobs/`

## Создание задачи со скриптом

Для сложных задач (чтение файлов, обработка данных) создайте bash-скрипт:

```bash
# 1. Создайте скрипт
mkdir -p ~/.config/opencode/jobs
cat > ~/.config/opencode/jobs/my-task.sh << 'SCRIPT'
#!/bin/bash
# Описание задачи

WORK_DIR="/home/gratheon/git/project"
cd "$WORK_DIR"

# Чтение файлов с пробелами в именах
FILES=$(find "$WORK_DIR" -name "*.md" -type f 2>/dev/null | head -5)
CONTENT=""
while IFS= read -r file; do
    CONTENT+="\n\n--- $(basename "$file") ---\n"
    CONTENT+=$(cat "$file")
done <<< "$FILES"

# Формирование промпта через heredoc (избегает проблем с кавычками)
PROMPT=$(cat <<EOF
Проанализируй файлы:
${CONTENT}

Сделай выводы.
EOF
)

/home/gratheon/.opencode/bin/opencode run -- "$PROMPT"
SCRIPT

chmod +x ~/.config/opencode/jobs/my-task.sh

# 2. Создайте сервис вручную
cat > ~/.config/systemd/user/opencode-job-my-task.service << 'EOF'
[Unit]
Description=OpenCode Job: my-task

[Service]
Type=oneshot
ExecStart=/home/gratheon/.config/opencode/jobs/my-task.sh
StandardOutput=append:/home/gratheon/.config/opencode/logs/my-task.log
StandardError=append:/home/gratheon/.config/opencode/logs/my-task.log

[Install]
WantedBy=default.target
EOF

# 3. Создайте таймер
cat > ~/.config/systemd/user/opencode-job-my-task.timer << 'EOF'
[Unit]
Description=Timer for: my-task

[Timer]
OnCalendar=*-*-* 09:00:00
Persistent=true

[Install]
WantedBy=timers.target
EOF

# 4. Активируйте
systemctl --user daemon-reload
systemctl --user enable opencode-job-my-task.timer
systemctl --user start opencode-job-my-task.timer
```

## Важные нюансы bash-скриптов

### 1. Обработка файлов с пробелами
```bash
# ❌ Неправильно — разбивает по пробелам
for file in $FILES; do cat "$file"; done

# ✅ Правильно — сохраняет целостность имён
while IFS= read -r file; do cat "$file"; done <<< "$FILES"
```

### 2. Спецсимволы в промптах
```bash
# ❌ Неправильно — скобки () интерпретируются bash
PROMPT="Текст (с скобками)"

# ✅ Правильно — используйте heredoc
PROMPT=$(cat <<EOF
Текст (с скобками)
EOF
)
```

### 3. Проверка синтаксиса
```bash
bash -n ~/.config/opencode/jobs/my-task.sh
echo $?  # 0 = OK
```

## Устранение неполадок

```bash
# Проверка синтаксиса
systemd-analyze --user verify opencode-job-<name>.service

# Таймер не стартует
systemctl --user daemon-reload
systemctl --user enable opencode-job-<name>.timer
systemctl --user start opencode-job-<name>.timer
```

## Ссылки

- [systemd.timer](https://www.freedesktop.org/software/systemd/man/systemd.timer.html)
- [crontab.guru](https://crontab.guru/)
