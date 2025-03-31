#!/bin/bash
for wf in ./workflows/*.json; do
    n8n import:workflow --input="$wf"
done

for cred in ./credentials/*.json; do
    n8n import:credentials --input="$cred"
done

echo "✅ Import completed!"
