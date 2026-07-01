#!/bin/bash
set -e

echo "=================================="
echo "Iniciando Claude-Mem..."
echo "=================================="

npx claude-mem start &
sleep 3

echo "=================================="
echo "Iniciando OpenCode..."
echo "=================================="

exec opencode web --hostname 0.0.0.0 --port 4096
