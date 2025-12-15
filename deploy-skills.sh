#!/bin/bash

# Claude Code Skills 部署脚本
# 功能：从 GitHub 拉取 choose 文件夹并部署到 Claude Code 插件目录

set -euo pipefail

# 配置变量
GITHUB_REPO="https://github.com/karmaxteq/choose-for-skill.git"
REPO_BRANCH="main"
SKILLS_FOLDER="choose"
PLUGIN_NAME="choose-skills"
MARKETPLACE_NAME="choose-local-marketplace"
# 使用现有版本号，如果不存在则创建新版本
EXISTING_VERSION="0.1.0"
PLUGIN_VERSION="$EXISTING_VERSION"

# Claude Code 插件目录检测（支持环境变量覆盖）
# 允许通过环境变量 CLAUDE_PLUGINS_DIR 自定义路径
detect_claude_plugins_dir() {
    # 如果设置了环境变量，优先使用
    if [ -n "${CLAUDE_PLUGINS_DIR:-}" ]; then
        echo "$CLAUDE_PLUGINS_DIR"
        return 0
    fi
    
    # 尝试检测常见的安装位置
    local possible_paths=(
        "$HOME/.claude/plugins"
        "$HOME/Library/Application Support/Claude/plugins"  # macOS 替代路径
        "$HOME/.config/claude/plugins"  # Linux 替代路径
    )
    
    for path in "${possible_paths[@]}"; do
        if [ -d "$path" ]; then
            echo "$path"
            return 0
        fi
    done
    
    # 如果都找不到，使用默认路径（macOS/Linux 标准位置）
    echo "$HOME/.claude/plugins"
    return 1
}

# 检测并设置 Claude Code 插件目录
CLAUDE_PLUGINS_BASE=$(detect_claude_plugins_dir)
if [ ! -d "$CLAUDE_PLUGINS_BASE" ]; then
    warning "Claude Code 插件目录不存在: $CLAUDE_PLUGINS_BASE"
    info "将尝试创建目录..."
    mkdir -p "$CLAUDE_PLUGINS_BASE" || {
        error "无法创建目录: $CLAUDE_PLUGINS_BASE"
        error "请手动创建目录或设置环境变量 CLAUDE_PLUGINS_DIR"
        exit 1
    }
    success "已创建目录: $CLAUDE_PLUGINS_BASE"
fi

# 插件部署到 cache/marketplace 目录（Claude Code 的标准位置）
PLUGIN_DIR="$CLAUDE_PLUGINS_BASE/cache/$MARKETPLACE_NAME/$PLUGIN_NAME/$PLUGIN_VERSION"
TEMP_DIR=$(mktemp -d)

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印带颜色的消息
info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

success() {
    echo -e "${GREEN}✓${NC} $1"
}

warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

error() {
    echo -e "${RED}✗${NC} $1"
}

# 清理函数
cleanup() {
    if [ -d "$TEMP_DIR" ]; then
        info "清理临时文件..."
        rm -rf "$TEMP_DIR"
    fi
}

# 注册清理函数
trap cleanup EXIT

# 检查必要的工具
check_dependencies() {
    info "检查依赖工具..."
    
    if ! command -v git &> /dev/null; then
        error "Git 未安装，请先安装 Git"
        exit 1
    fi
    
    if ! command -v python3 &> /dev/null; then
        error "Python 3 未安装，请先安装 Python 3"
        exit 1
    fi
    
    # 验证 Claude Code 插件目录
    if [ ! -d "$CLAUDE_PLUGINS_BASE" ]; then
        error "Claude Code 插件目录不存在: $CLAUDE_PLUGINS_BASE"
        error "请确保 Claude Code 已安装，或设置环境变量 CLAUDE_PLUGINS_DIR"
        exit 1
    fi
    
    if [ ! -w "$CLAUDE_PLUGINS_BASE" ]; then
        error "Claude Code 插件目录不可写: $CLAUDE_PLUGINS_BASE"
        error "请检查目录权限"
        exit 1
    fi
    
    success "依赖检查通过"
    info "Claude Code 插件目录: $CLAUDE_PLUGINS_BASE"
}

# 从 GitHub 拉取 choose 文件夹
pull_from_github() {
    info "从 GitHub 拉取 choose 文件夹..."
    
    cd "$TEMP_DIR"
    
    # 初始化 git 仓库
    git init -q
    git remote add origin "$GITHUB_REPO" 2>/dev/null || git remote set-url origin "$GITHUB_REPO"
    
    # 启用 sparse-checkout 只拉取 choose 文件夹
    git config core.sparseCheckout true
    echo "$SKILLS_FOLDER/*" > .git/info/sparse-checkout
    
    # 拉取指定分支
    info "正在拉取 $REPO_BRANCH 分支..."
    if ! git pull origin "$REPO_BRANCH" -q --depth=1 2>&1; then
        error "从 GitHub 拉取失败，请检查网络连接"
        exit 1
    fi
    
    SKILLS_SOURCE_DIR="$TEMP_DIR/$SKILLS_FOLDER"
    
    if [ ! -d "$SKILLS_SOURCE_DIR" ]; then
        error "未找到 $SKILLS_FOLDER 文件夹"
        exit 1
    fi
    
    success "成功拉取 choose 文件夹"
}

# 创建插件目录结构
setup_plugin_structure() {
    info "创建插件目录结构..."
    
    # 如果目录已存在，先删除（包括符号链接）
    if [ -d "$PLUGIN_DIR" ]; then
        warning "插件目录已存在，将覆盖现有内容"
        # 先删除skills目录下的所有内容（包括符号链接）
        if [ -d "$PLUGIN_DIR/skills" ]; then
            rm -rf "$PLUGIN_DIR/skills"/*
        fi
        # 删除整个目录重新创建
        rm -rf "$PLUGIN_DIR"
    fi
    
    # 创建插件目录
    mkdir -p "$PLUGIN_DIR/.claude-plugin"
    mkdir -p "$PLUGIN_DIR/skills"
    
    # 创建 marketplace 根目录的 .claude-plugin 目录（用于存放 marketplace.json）
    local marketplace_root="$CLAUDE_PLUGINS_BASE/cache/$MARKETPLACE_NAME"
    mkdir -p "$marketplace_root/.claude-plugin"
    
    # 确保插件目录中不会有多余的 marketplace.json（这会导致冲突）
    if [ -f "$PLUGIN_DIR/.claude-plugin/marketplace.json" ]; then
        warning "删除插件目录中多余的 marketplace.json"
        rm -f "$PLUGIN_DIR/.claude-plugin/marketplace.json"
    fi
    
    success "插件目录结构已创建"
}

# 复制 skills 到插件目录
copy_skills() {
    info "复制 skills 到插件目录..."
    
    local skill_count=0
    
    # 遍历 choose 文件夹下的所有子目录
    for skill_dir in "$SKILLS_SOURCE_DIR"/*; do
        if [ -d "$skill_dir" ]; then
            local skill_name=$(basename "$skill_dir")
            
            # 检查是否包含 SKILL.md 文件
            if [ -f "$skill_dir/SKILL.md" ]; then
                info "  复制 skill: $skill_name"
                
                # 复制整个 skill 目录（使用 -L 跟随符号链接，确保复制实际文件）
                cp -rL "$skill_dir" "$PLUGIN_DIR/skills/"
                ((skill_count++))
            else
                warning "  跳过 $skill_name (未找到 SKILL.md)"
            fi
        fi
    done
    
    if [ $skill_count -eq 0 ]; then
        error "未找到任何有效的 skill"
        exit 1
    fi
    
    success "成功复制 $skill_count 个 skills"
}

# 生成 plugin.json
generate_plugin_json() {
    info "生成 plugin.json..."
    
    # 使用 Python 生成正确的 JSON 格式
    python3 << EOF
import json
import os
import glob

plugin_dir = "$PLUGIN_DIR"
plugin_name = "$PLUGIN_NAME"
plugin_version = "$PLUGIN_VERSION"
repo_url = "$GITHUB_REPO"

# 收集所有 skill 路径
skills = []
skills_dir = os.path.join(plugin_dir, "skills")
if os.path.exists(skills_dir):
    for skill_dir in glob.glob(os.path.join(skills_dir, "*")):
        if os.path.isdir(skill_dir) and os.path.exists(os.path.join(skill_dir, "SKILL.md")):
            skill_name = os.path.basename(skill_dir)
            skills.append(f"./skills/{skill_name}")

# 创建 plugin.json
plugin_json = {
    "name": plugin_name,
    "version": plugin_version,
    "description": "Skills collection from GitHub: Comprehensive set of development skills including TypeScript, FastAPI, error handling, code review, and more.",
    "repository": repo_url,
    "skills": skills
}

# 写入文件
plugin_json_path = os.path.join(plugin_dir, ".claude-plugin", "plugin.json")
os.makedirs(os.path.dirname(plugin_json_path), exist_ok=True)
with open(plugin_json_path, 'w') as f:
    json.dump(plugin_json, f, indent=2)

print(f"✓ plugin.json 已生成，包含 {len(skills)} 个 skills")
EOF
    
    success "plugin.json 已生成"
}

# 生成 marketplace.json（在 marketplace 根目录）
generate_marketplace_json() {
    info "生成 marketplace.json..."
    
    # 使用 Python 生成正确的 JSON 格式
    python3 << EOF
import json
import os
import glob

marketplace_root = os.path.expanduser("$CLAUDE_PLUGINS_BASE/cache/$MARKETPLACE_NAME")
marketplace_json_path = os.path.join(marketplace_root, ".claude-plugin", "marketplace.json")
plugin_dir = "$PLUGIN_DIR"
plugin_name = "$PLUGIN_NAME"
plugin_version = "$PLUGIN_VERSION"
marketplace_name = "$MARKETPLACE_NAME"

# 创建 marketplace.json
# 注意：marketplace.json 不应该包含 skills 字段，skills 应该从插件的 plugin.json 中读取
marketplace_json = {
    "name": marketplace_name,
    "owner": {
        "name": "Local Developer",
        "email": "local@example.com"
    },
    "metadata": {
        "description": "Local skills bundle from GitHub: karmaxteq/choose-for-skill",
        "version": plugin_version
    },
    "plugins": [
        {
            "name": plugin_name,
            "version": plugin_version,
            "description": "Skills collection from GitHub: Comprehensive set of development skills including TypeScript, FastAPI, error handling, code review, and more.",
            "source": f"./{plugin_name}/{plugin_version}",
            "strict": False
        }
    ]
}

# 写入文件
os.makedirs(os.path.dirname(marketplace_json_path), exist_ok=True)
with open(marketplace_json_path, 'w') as f:
    json.dump(marketplace_json, f, indent=2)

print(f"✓ marketplace.json 已生成")
EOF
    
    success "marketplace.json 已生成"
}

# 更新 installed_plugins.json（如果需要）
update_installed_plugins() {
    local installed_file="$CLAUDE_PLUGINS_BASE/installed_plugins.json"
    
    if [ -f "$installed_file" ]; then
        info "更新 installed_plugins.json..."
        
        # 使用 Python 更新 JSON 文件
        python3 << EOF
import json
import os
from datetime import datetime

installed_file = "$installed_file"
plugin_key = "$PLUGIN_NAME@$MARKETPLACE_NAME"
plugin_path = "$PLUGIN_DIR"

# 读取现有配置
if os.path.exists(installed_file):
    with open(installed_file, 'r') as f:
        data = json.load(f)
else:
    data = {"version": 2, "plugins": {}}

# 确保 plugins 字典存在
if "plugins" not in data:
    data["plugins"] = {}

# 更新或添加插件信息
plugin_info = {
    "scope": "local",  # 使用 'local' 而不是 'user'，与其他正常工作的插件一致
    "installPath": plugin_path,
    "version": "$PLUGIN_VERSION",
    "installedAt": datetime.now().isoformat() + "Z",
    "lastUpdated": datetime.now().isoformat() + "Z",
    "isLocal": True,
    "enabled": True
}

if plugin_key not in data["plugins"]:
    data["plugins"][plugin_key] = []

# 检查是否已存在相同路径的安装
existing = [p for p in data["plugins"][plugin_key] if p.get("installPath") == plugin_path]
if not existing:
    data["plugins"][plugin_key].append(plugin_info)
else:
    # 更新现有记录
    existing[0].update(plugin_info)

# 写回文件
with open(installed_file, 'w') as f:
    json.dump(data, f, indent=2)

print("✓ installed_plugins.json 已更新")
EOF
        
        success "插件注册信息已更新"
    else
        warning "installed_plugins.json 不存在，跳过更新"
    fi
    
    # 更新 known_marketplaces.json
    update_known_marketplaces
}

# 更新 known_marketplaces.json
update_known_marketplaces() {
    local known_file="$CLAUDE_PLUGINS_BASE/known_marketplaces.json"
    
    if [ ! -f "$known_file" ]; then
        mkdir -p "$(dirname "$known_file")"
        echo "{}" > "$known_file"
    fi
    
    info "更新 known_marketplaces.json..."
    
    python3 << EOF
import json
import os
from datetime import datetime

known_file = "$known_file"
marketplace_name = "$MARKETPLACE_NAME"
install_location = os.path.expanduser("$CLAUDE_PLUGINS_BASE/cache/$MARKETPLACE_NAME")

# 读取或创建
if os.path.exists(known_file):
    with open(known_file, 'r') as f:
        data = json.load(f)
else:
    data = {}

# 添加或更新 marketplace（使用正确的格式）
data[marketplace_name] = {
    "source": {
        "source": "directory",
        "path": install_location
    },
    "installLocation": install_location,
    "lastUpdated": datetime.now().isoformat() + "Z"
}
    
# 写回
with open(known_file, 'w') as f:
    json.dump(data, f, indent=2)
    
print("✓ 已更新 marketplace 配置")
EOF
    
    success "marketplace 配置已更新"
}

# 显示部署摘要
show_summary() {
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    success "部署完成！"
    echo ""
    info "插件位置: $PLUGIN_DIR"
    info "Skills 数量: $(ls -1 "$PLUGIN_DIR/skills" 2>/dev/null | wc -l | tr -d ' ')"
    echo ""
    echo "已部署的 skills:"
    for skill_dir in "$PLUGIN_DIR/skills"/*; do
        if [ -d "$skill_dir" ]; then
            echo "  • $(basename "$skill_dir")"
        fi
    done
    echo ""
    warning "重要提示:"
    warning "  1. 请完全重启 Claude Code 应用（不是只关闭窗口）"
    warning "  2. 重启后，在 Claude Code 设置中启用 '$PLUGIN_NAME' 插件"
    warning "  3. 如果插件仍未显示，请检查插件目录权限和 plugin.json 格式"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

# 主函数
main() {
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "  Claude Code Skills 部署脚本"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    
    check_dependencies
    pull_from_github
    setup_plugin_structure
    copy_skills
    generate_plugin_json
    generate_marketplace_json
    update_installed_plugins
    show_summary
}

# 运行主函数
main
