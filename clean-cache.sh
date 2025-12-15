#!/bin/bash

# 清理 Claude Code 缓存和插件文件

set -euo pipefail

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  清理 Claude Code 缓存"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

MARKETPLACE_NAME="choose-local-marketplace"
PLUGIN_NAME="choose-skills"

# 1. 清理插件缓存目录
PLUGIN_CACHE="$HOME/.claude/plugins/cache/$MARKETPLACE_NAME"
if [ -d "$PLUGIN_CACHE" ]; then
    echo "删除插件缓存目录: $PLUGIN_CACHE"
    rm -rf "$PLUGIN_CACHE"
    echo "✓ 插件缓存已清理"
else
    echo "ℹ 插件缓存目录不存在，跳过"
fi

# 2. 清理插件注册信息（但保留其他插件）
INSTALLED_FILE="$HOME/.claude/plugins/installed_plugins.json"
if [ -f "$INSTALLED_FILE" ]; then
    echo ""
    echo "清理插件注册信息..."
    python3 << EOF
import json
import os

installed_file = "$INSTALLED_FILE"
plugin_key = "$PLUGIN_NAME@$MARKETPLACE_NAME"

if os.path.exists(installed_file):
    with open(installed_file, 'r') as f:
        data = json.load(f)
    
    if "plugins" in data and plugin_key in data["plugins"]:
        del data["plugins"][plugin_key]
        print(f"✓ 已删除插件注册: {plugin_key}")
    
    with open(installed_file, 'w') as f:
        json.dump(data, f, indent=2)
else:
    print("ℹ installed_plugins.json 不存在，跳过")
EOF
fi

# 3. 清理 marketplace 注册
KNOWN_FILE="$HOME/.claude/plugins/known_marketplaces.json"
if [ -f "$KNOWN_FILE" ]; then
    echo ""
    echo "清理 marketplace 注册..."
    python3 << EOF
import json
import os

known_file = "$KNOWN_FILE"
marketplace_name = "$MARKETPLACE_NAME"

if os.path.exists(known_file):
    with open(known_file, 'r') as f:
        data = json.load(f)
    
    if marketplace_name in data:
        del data[marketplace_name]
        print(f"✓ 已删除 marketplace 注册: {marketplace_name}")
    
    with open(known_file, 'w') as f:
        json.dump(data, f, indent=2)
else:
    print("ℹ known_marketplaces.json 不存在，跳过")
EOF
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "清理完成！"
echo ""
echo "现在可以运行 ./deploy-skills.sh 重新部署"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

