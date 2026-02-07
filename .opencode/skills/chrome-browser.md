# Управление Chrome браузером через MCP

## Автоматический запуск Chrome

Перед использованием MCP инструментов Chrome должен быть запущен с remote debugging. Скрипт автоматически проверит и запустит Chrome при необходимости.

### Проверить и запустить Chrome

```bash
# Проверить, запущен ли Chrome
if ! curl -s http://localhost:9222/json/version > /dev/null 2>&1; then
    echo "Chrome не запущен, запускаем..."
    ~/.local/bin/chrome-for-mcp &
    sleep 3
fi
# Теперь Chrome готов к использованию с MCP
```

Или используйте функцию-обёртку в агенте:

```
ensure_chrome_running() {
    if ! curl -s http://localhost:9222/json/version > /dev/null 2>&1; then
        ~/.local/bin/chrome-for-mcp &
        sleep 3
    fi
}
```

### Ручной запуск (если нужно)

```bash
~/.local/bin/chrome-for-mcp
```

Этот скрипт:
- Использует `dbus-launch` для корректной работы GUI
- Запускает Chromium через Flatpak
- Включает remote debugging на порту 9222

### Проверка подключения

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

### Полный автоматический workflow с запуском Chrome

```bash
# 1. Автоматически запустить Chrome если не запущен
if ! curl -s http://localhost:9222/json/version > /dev/null 2>&1; then
    ~/.local/bin/chrome-for-mcp &
    sleep 3
fi

# 2. Теперь можно использовать MCP инструменты
```

### Пошаговый workflow

1. **Проверить/запустить Chrome** — убедиться что порт 9222 доступен
2. Открыть страницу: `chrome-devtools_navigate_page`
3. Сделать снимок DOM: `chrome-devtools_take_snapshot`
4. Найти нужный элемент по uid в снимке
5. Взаимодействовать: `chrome-devtools_click`, `chrome-devtools_fill`
6. Проверить результат: `chrome-devtools_take_snapshot` или `chrome-devtools_take_screenshot`

## Troubleshooting

### Chrome не запускается или висит в состоянии загрузки

**❌ Неправильно — запускать напрямую через Flatpak:**
```bash
flatpak run org.chromium.Chromium
```
Это вызовет проблемы с DISPLAY и D-Bus, браузер может зависнуть при загрузке страниц.

**✅ Правильно — использовать скрипт:**
```bash
~/.local/bin/chrome-for-mcp
```

Скрипт автоматически:
- Устанавливает переменные окружения (DISPLAY, DBUS_SESSION_BUS_ADDRESS)
- Запускает dbus-launch для корректной работы GUI
- Подключает remote debugging на порту 9222

### Chrome не отображается (DISPLAY не установлен)
Если `echo $DISPLAY` показывает пустую строку:
```bash
export DISPLAY=:1
~/.local/bin/chrome-for-mcp
```

### MCP не подключается
1. Проверить, запущен ли Chrome с debugging:
   ```bash
   curl -s http://localhost:9222/json/version
   ```
2. Если нет ответа — перезапустить Chrome через скрипт:
   ```bash
   ~/.local/bin/chrome-for-mcp
   ```

### Страницы не загружаются
Убедиться, что Chrome запущен через `~/.local/bin/chrome-for-mcp`, а не напрямую через `flatpak run`.

## Программное использование с MCP

При использовании через MCP агента, добавьте автоматический запуск Chrome в начало задачи:

```
Before using any chrome-devtools tools, first ensure Chrome is running:
1. Check if Chrome is accessible: curl -s http://localhost:9222/json/version
2. If not, start it: ~/.local/bin/chrome-for-mcp &
3. Wait 3 seconds for Chrome to initialize
4. Then proceed with navigation and interaction
```

### Пример MCP-агента

```yaml
agent: browser-automation
steps:
  - name: Ensure Chrome is running
    command: |
      if ! curl -s http://localhost:9222/json/version > /dev/null 2>&1; then
        ~/.local/bin/chrome-for-mcp &
        sleep 3
      fi
  
  - name: Navigate to page
    tool: chrome-devtools_navigate_page
    args:
      type: url
      url: https://example.com
  
  - name: Take snapshot
    tool: chrome-devtools_take_snapshot
```
