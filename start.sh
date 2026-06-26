#!/bin/bash

set -e

echo "=================================="
echo "Iniciando Claude-Mem..."
echo "=================================="

exec  npx claude-mem start || true

echo "=================================="
echo "Iniciando OpenCode..."
echo "=================================="

exec opencode web --hostname 0.0.0.0 --port 4096
