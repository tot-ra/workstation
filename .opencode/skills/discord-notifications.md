# Уведомления в Discord через Kimaki

Используй `kimaki` для отправки уведомлений в Discord.

## Переменная окружения

ID канала берётся из переменной окружения `$DISCORD_CHANNEL_ID` (должна быть установлена в `.env` или окружении).

## Команда

```bash
npx -y kimaki send --channel "$DISCORD_CHANNEL_ID" --prompt "Сообщение" --notify-only
```

## Параметры

| Параметр | Описание |
|----------|----------|
| `--channel` | ID канала Discord (используй `$DISCORD_CHANNEL_ID`) |
| `--prompt` | Текст сообщения |
| `--notify-only` | Только отправить, без ожидания ответа |

## Примеры использования

### Простое уведомление
```bash
npx -y kimaki send --channel "$DISCORD_CHANNEL_ID" --prompt "Задача выполнена" --notify-only
```

### Уведомление с деталями
```bash
npx -y kimaki send --channel "$DISCORD_CHANNEL_ID" --prompt "Бэкап завершён: 150 файлов обработано" --notify-only
```

## Когда использовать

- Завершение долгих задач
- Напоминания по расписанию
- Оповещения об ошибках
- Результаты мониторинга
