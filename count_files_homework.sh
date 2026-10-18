#!/bin/bash

# Модифікація скрипта

TARGET_DIR="${1:-/etc}"

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

echo "Статистика директорії $TARGET_DIR:"
echo "  Звичайні файли: $files"
echo "  Директорії: $((dirs - 1))"
echo "  Символічні посилання: $links"
echo "Файли з розширенням .$EXTRA: $extra_files"
echo "  -------------------------"
echo "  Разом (тільки файли): $files"
echo "Загальний розмір: $total  байт ($((total/1024)) КБ)"
