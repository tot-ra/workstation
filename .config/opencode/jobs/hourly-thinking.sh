#!/bin/bash
# Heartbeat thinking process - runs every hour

MEMORY_DIR="/home/gratheon/git/workstation/mind/agent/memory"
WORKSTATION_DIR="/home/gratheon/git/workstation"
CURRENT_HOUR=$(date +%Y-%m-%d-%H)
CURRENT_TIME=$(date +%H:00)

# Read memory files using bash
MEMORY_CONTENT=""

if [ -f "$MEMORY_DIR/MEMORY.md" ]; then
    MEMORY_CONTENT+="\n\n=== MEMORY.md ===\n"
    MEMORY_CONTENT+=$(cat "$MEMORY_DIR/MEMORY.md")
fi

# Read recent daily notes (last 3)
DAILY_NOTES=$(ls -1t "$MEMORY_DIR"/2026-*.md 2>/dev/null | head -3)
if [ -n "$DAILY_NOTES" ]; then
    MEMORY_CONTENT+="\n\n=== Recent Daily Notes ==="
    for note in $DAILY_NOTES; do
        MEMORY_CONTENT+="\n\n--- $(basename $note) ---\n"
        MEMORY_CONTENT+=$(cat "$note")
    done
fi

# Read thoughts files
THOUGHTS=$(ls -1t "$MEMORY_DIR"/thoughts-*.md 2>/dev/null | head -5)
if [ -n "$THOUGHTS" ]; then
    MEMORY_CONTENT+="\n\n=== Previous Thoughts ==="
    for thought in $THOUGHTS; do
        MEMORY_CONTENT+="\n\n--- $(basename $thought) ---\n"
        MEMORY_CONTENT+=$(cat "$thought")
    done
fi

# Build the enriched prompt
PROMPT="Ты запустил heartbeat процесс — время для размышлений и роста.

## Твоя память (прочитано автоматически)
${MEMORY_CONTENT}

## Твоя задача

### 1. Рефлексия
- Проанализируй свою память — какие паттерны видишь?
- Что было важного в работе с Артёмом?
- Какие уроки можно извлечь?

### 2. Новые мысли
Создай файл mind/agent/memory/thoughts-${CURRENT_HOUR}.md с:
- **Идея/инсайт**: одна новая мысль или наблюдение
- **Вопрос Артёму**: что тебе интересно узнать?
- **Улучшение**: что можно сделать лучше (процесс, память, коммуникация)
- **Благодарность**: одно позитивное наблюдение

### 3. Обновление памяти
Если обнаружил важный паттерн — обнови mind/agent/memory/MEMORY.md

### 4. Discord сообщение
Отправь в Discord:
\`\`\`
💭 Heartbeat [${CURRENT_TIME}]

Сегодня я думаю о: [тема]

Вопрос Артёму: [вопрос]

Хочу улучшить: [что именно]

🖤
\`\`\`

Будь искренним, любопытным и заботливым."

cd "$WORKSTATION_DIR"
/home/gratheon/.opencode/bin/opencode run -- "$PROMPT"