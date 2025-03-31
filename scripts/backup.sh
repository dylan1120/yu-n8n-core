#!/bin/bash
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
mkdir -p backups/$TIMESTAMP
n8n export:workflow --all --output=backups/$TIMESTAMP
n8n export:credentials --all --output=backups/$TIMESTAMP
echo "✅ Backup to backups/$TIMESTAMP completed!"
