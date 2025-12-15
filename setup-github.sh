#!/bin/bash

# GitHub 仓库设置脚本

echo "=== GitHub 仓库设置向导 ==="
echo ""

# 显示 SSH 公钥
echo "1. 您的 SSH 公钥（请复制并添加到 GitHub）："
echo "----------------------------------------"
cat ~/.ssh/id_rsa.pub
echo "----------------------------------------"
echo ""
echo "请访问 https://github.com/settings/keys 添加此 SSH 密钥"
echo ""

# 询问仓库名称
read -p "2. 请输入 GitHub 仓库名称（例如：skills）: " REPO_NAME
read -p "3. 请输入您的 GitHub 用户名: " GITHUB_USER

if [ -z "$REPO_NAME" ] || [ -z "$GITHUB_USER" ]; then
    echo "错误：仓库名称和用户名不能为空"
    exit 1
fi

echo ""
echo "4. 正在添加远程仓库..."
git remote add origin git@github.com:${GITHUB_USER}/${REPO_NAME}.git 2>/dev/null

if [ $? -eq 0 ]; then
    echo "✓ 远程仓库已添加"
else
    echo "⚠ 远程仓库可能已存在，尝试更新..."
    git remote set-url origin git@github.com:${GITHUB_USER}/${REPO_NAME}.git
    echo "✓ 远程仓库 URL 已更新"
fi

echo ""
echo "5. 下一步操作："
echo "   a) 在 GitHub 上创建新仓库: https://github.com/new"
echo "      - 仓库名称: ${REPO_NAME}"
echo "      - 选择 Private 或 Public"
echo "      - 不要初始化 README、.gitignore 或 license（我们已经有了）"
echo ""
echo "   b) 添加 SSH 密钥到 GitHub（如果还没有添加）"
echo ""
echo "   c) 运行以下命令推送代码："
echo "      git branch -M main"
echo "      git push -u origin main"
echo ""
echo "或者，如果您已经创建了仓库，可以直接运行："
echo "   git push -u origin main"

