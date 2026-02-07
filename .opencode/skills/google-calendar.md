# Google Calendar MCP Integration

Инструкции по работе с Google Calendar через MCP (Model Context Protocol).

## Доступные календари

Календари хранятся в переменной окружения `GOOGLE_CALENDAR_IDS` или в файле `~/.config/google-calendar/calendars.json`.

Чтобы увидеть все доступные календари:
```
mcp_google-calendar_list-calendars
```

Пример календарей:
| ID | Название | Назначение |
|----|----------|------------|
| `primary` | **Основной** | Личные события, встречи, митапы |
| `{calendar_id_1}` | **Распорядок дня** | Регулярные рутинные события |
| `{calendar_id_2}` | **Семейный общий** | События касающиеся семьи |
| `{calendar_id_3}` | **Работа** | Рабочие события |

## Когда какой календарь использовать

- **Личные встречи, митапы, консультации** → `primary`
- **Ежедневные рутины, расписание дня** → Распорядок дня
- **Что-то связанное с семьей** → Семейный общий
- **Рабочие созвоны, митинги** → Работа

## Основные операции

### Получить текущее время (ВСЕГДА делать первым!)
```
mcp_google-calendar_get-current-time
```

### Посмотреть события
```
mcp_google-calendar_list-events
  calendarId: "primary"  # или конкретный ID
  timeMin: "2026-02-04T00:00:00"
  timeMax: "2026-02-10T23:59:59"
  fields: ["description", "attendees"]  # для деталей
```

### Поиск событий по тексту
```
mcp_google-calendar_search-events
  calendarId: ["primary", "work"]  # можно несколько
  query: "meetup"
  timeMin: "2026-02-01T00:00:00"
  timeMax: "2026-03-01T00:00:00"
```

### Создать событие
```
mcp_google-calendar_create-event
  calendarId: "primary"
  summary: "Название события"
  start: "2026-02-10T14:00:00"
  end: "2026-02-10T15:00:00"
  location: "Tallinn"  # опционально
  description: "Описание"  # опционально
  timeZone: "Europe/Tallinn"
```

### Создать событие на весь день
```
mcp_google-calendar_create-event
  calendarId: "primary"
  summary: "День рождения"
  start: "2026-02-10"
  end: "2026-02-11"  # следующий день (exclusive)
```

### Обновить событие
```
mcp_google-calendar_update-event
  calendarId: "primary"
  eventId: "event_id_here"
  summary: "Новое название"
  start: "2026-02-10T15:00:00"  # новое время
```

### Удалить событие
```
mcp_google-calendar_delete-event
  calendarId: "primary"
  eventId: "event_id_here"
```

### Проверить свободное время
```
mcp_google-calendar_get-freebusy
  calendars: [{"id": "primary"}, {"id": "work"}]
  timeMin: "2026-02-10T09:00:00"
  timeMax: "2026-02-10T18:00:00"
```

## Важные правила

1. **Всегда вызывай `get-current-time` первым** - чтобы знать текущую дату/время
2. **Таймзона** - по умолчанию `Europe/Tallinn`
3. **Формат дат** - ISO 8601 (`2026-02-04T14:00:00`)
4. **Для событий на весь день** - используй только дату (`2026-02-04`)
5. **End date для all-day** - exclusive, т.е. указывай следующий день

## Примеры использования

### Что у меня сегодня?
```
1. get-current-time
2. list-events(calendarId: "primary", timeMin: today_start, timeMax: today_end)
```

### Когда я свободен на этой неделе?
```
1. get-current-time
2. get-freebusy(calendars: [primary, work], timeMin: week_start, timeMax: week_end)
```

## Получение calendar ID

Для получения ID конкретного календаря:
1. Открой Google Calendar в браузере
2. Найди нужный календарь в левой панели
3. Нажми на три точки → "Настройки"
4. В разделе "Интеграция календаря" найди "Calendar ID"

Или используй MCP команду `list-calendars` для просмотра всех доступных календарей.

## Настройка аутентификации

OAuth credentials должны быть в файле, указанном в переменной `GOOGLE_OAUTH_CREDENTIALS`:
```bash
GOOGLE_OAUTH_CREDENTIALS="/path/to/client_secret.json"
```

Создайте OAuth 2.0 credentials в Google Cloud Console:
1. Google Cloud Console → APIs & Services → Credentials
2. Create credentials → OAuth client ID → Desktop app
3. Скачайте JSON и сохраните как `client_secret.json`
4. При первом запуске выполнится авторизация
