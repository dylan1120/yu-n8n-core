#!/bin/bash

# 檢查是否有輸入 tag 名稱
if [ -z "$1" ]; then
  echo "❗ 請提供要匯出的 tag 名稱："
  echo "用法：bash scripts/export-by-tag.sh <tag-name>"
  exit 1
fi

TAG=$1
DIR="workflows/$TAG"

mkdir -p "$DIR"

echo "📦 Exporting workflows with tag: $TAG..."
n8n export:workflow --output="$DIR" --filter="tag=$TAG"

echo "✅ Export completed to $DIR/"
