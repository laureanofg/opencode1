#!/bin/bash

set -e

echo "Iniciando Claude-Mem..."
npx claude-mem start

echo "Iniciando OpenCode..."
exec opencode web --hostname 0.0.0.0 --port 4096
