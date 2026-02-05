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
