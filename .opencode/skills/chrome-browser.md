# Управление Chrome браузером через MCP

## Требования

Chrome должен быть запущен с remote debugging на порту 9222.

## Запуск Chrome

```bash
~/.local/bin/chrome-for-mcp
```

Этот скрипт:
- Использует `dbus-launch` для корректной работы GUI
- Запускает Chromium через Flatpak
- Включает remote debugging на порту 9222

## Проверка подключения

```bash
curl -s http://localhost:9222/json/version
```

## Доступные MCP инструменты

### Навигация
- `chrome-devtools_list_pages` — список открытых вкладок
- `chrome-devtools_navigate_page` — перейти по URL
- `chrome-devtools_new_page` — открыть новую вкладку
- `chrome-devtools_close_page` — закрыть вкладку
- `chrome-devtools_select_page` — выбрать вкладку

### Взаимодействие со страницей
- `chrome-devtools_click` — клик по элементу (по uid)
- `chrome-devtools_fill` — ввод текста в поле
- `chrome-devtools_fill_form` — заполнить несколько полей формы
- `chrome-devtools_hover` — навести курсор на элемент
- `chrome-devtools_press_key` — нажать клавишу
- `chrome-devtools_drag` — перетащить элемент

### Снимки и скриншоты
- `chrome-devtools_take_snapshot` — текстовый снимок DOM (a11y tree)
- `chrome-devtools_take_screenshot` — скриншот страницы или элемента

### Сеть и консоль
- `chrome-devtools_list_network_requests` — список сетевых запросов
- `chrome-devtools_get_network_request` — детали запроса
- `chrome-devtools_list_console_messages` — сообщения консоли
- `chrome-devtools_get_console_message` — детали сообщения

### Эмуляция
- `chrome-devtools_emulate` — эмуляция устройства, сети, геолокации
- `chrome-devtools_resize_page` — изменить размер окна

### Выполнение скриптов
- `chrome-devtools_evaluate_script` — выполнить JavaScript на странице

### Диалоги и загрузка файлов
- `chrome-devtools_handle_dialog` — обработать alert/confirm/prompt
- `chrome-devtools_upload_file` — загрузить файл через input
- `chrome-devtools_wait_for` — ждать появления текста

### Производительность
- `chrome-devtools_performance_start_trace` — начать запись трейса
- `chrome-devtools_performance_stop_trace` — остановить запись
- `chrome-devtools_performance_analyze_insight` — анализ производительности

## Примеры использования

### Открыть страницу
```
chrome-devtools_navigate_page(type="url", url="https://example.com")
```

### Сделать снимок DOM
```
chrome-devtools_take_snapshot()
```

### Кликнуть по элементу
```
chrome-devtools_click(uid="1_5")
```

### Ввести текст
```
chrome-devtools_fill(uid="1_10", value="hello world")
```

### Сделать скриншот
```
chrome-devtools_take_screenshot(filePath="/tmp/screenshot.png")
```

## Workflow для автоматизации

1. Запустить Chrome: `~/.local/bin/chrome-for-mcp`
2. Открыть страницу: `chrome-devtools_navigate_page`
3. Сделать снимок DOM: `chrome-devtools_take_snapshot`
4. Найти нужный элемент по uid в снимке
5. Взаимодействовать: `chrome-devtools_click`, `chrome-devtools_fill`
6. Проверить результат: `chrome-devtools_take_snapshot` или `chrome-devtools_take_screenshot`

## Troubleshooting

### Chrome не запускается
Проверить, что DISPLAY установлен:
```bash
echo $DISPLAY
```

### MCP не подключается
1. Проверить, запущен ли Chrome с debugging:
   ```bash
   curl -s http://localhost:9222/json/version
   ```
2. Если нет ответа — перезапустить Chrome

### Страницы не загружаются
Убедиться, что Chrome запущен через `~/.local/bin/chrome-for-mcp`, а не напрямую через `flatpak run`.
