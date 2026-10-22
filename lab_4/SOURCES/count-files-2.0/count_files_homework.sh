#!/bin/bash

# Модифікація скрипта 2.0

CONFIG_FILE="/etc/count_files.conf"
if [ -f "$CONFIG_FILE" ]; then
. "$CONFIG_FILE"
fi

if [ "$1" = "-h" ]; then
echo "count_files [directory]"
echo "Без параметра буде братись DEFAULT_DIR з $CONFIG_FILE або /etc"
exit 0
fi

TARGET_DIR="${1:-${DEFAULT_DIR:-/etc}}"

if [ ! -d "$TARGET_DIR" ]; then
echo "Помилка: директорія $TARGET_DIR не існує"
exit 1
fi

read -p "Введіть розширення файлів: " EXTRA

count_items() {
    local dir=$1
    local type=$2
    find "$dir" -type "$type" 2>/dev/null | wc -l
}

files=$(count_items "$TARGET_DIR" "f")
dirs=$(count_items "$TARGET_DIR" "d")
links=$(count_items "$TARGET_DIR" "l")

extra_files=$(find "$TARGET_DIR" -type f -name "*.$EXTRA" 2>/dev/null | wc -l)

total=$(find "$TARGET_DIR" -type f -printf '%s\n' 2>/dev/null | awk '{sum+=$1} END {print sum+0}')

largest_file=$(find "$TARGET_DIR" -type f -printf '%s %p\n' 2>/dev/null | sort -nr | head -1)

echo "Статистика директорії $TARGET_DIR:"
echo "  Звичайні файли: $files"
echo "  Директорії: $((dirs - 1))"
echo "  Символічні посилання: $links"
echo "Файли з розширенням .$EXTRA: $extra_files"
echo "  -------------------------"
echo "  Разом (тільки файли): $files"
echo "Загальний розмір: $total  байт ($((total/1024)) КБ)"
echo "Найбільший шлях: $largest_file"
