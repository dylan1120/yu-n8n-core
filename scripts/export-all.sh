#!/bin/bash

echo "🔍 Extracting all workflow tags..."

# 匯出所有 workflow 到暫存檔
mkdir -p .tmp
n8n export:workflow --all --output=.tmp/all_workflows.json

# 取得所有 tags（去重）
TAGS=$(jq -r '.[].tags[]?.name' .tmp/all_workflows.json | sort | uniq)

echo "📁 Detected tags: $TAGS"
mkdir -p credentials

# 為每個 tag 匯出 workflows
for tag in $TAGS; do
  mkdir -p "workflows/$tag"
  echo "📦 Exporting workflows with tag: $tag"
  n8n export:workflow --output="workflows/$tag" --filter="tag=$tag"
done

n8n export:credentials --all --output=./credentials

# 清理暫存
rm -rf .tmp

echo "✅ Auto export by tag completed!"
