# Claude Code Skills Collection

一个包含 31 个专业开发技能的 Claude Code 插件集合，涵盖从后端开发到前端设计、从数据库优化到 DevOps 的完整开发生命周期。

## 📋 目录

- [项目简介](#项目简介)
- [功能特性](#功能特性)
- [项目结构](#项目结构)
- [快速开始](#快速开始)
- [Skills 列表](#skills-列表)
- [配置说明](#配置说明)
- [使用指南](#使用指南)
- [故障排除](#故障排除)
- [技术细节](#技术细节)
- [贡献指南](#贡献指南)
- [许可证](#许可证)

## 🎯 项目简介

本项目是一个 Claude Code 插件集合，包含 31 个精心组织的开发技能（Skills），这些技能可以帮助 Claude Code 更好地理解和执行各种开发任务。所有技能都从 GitHub 仓库自动拉取并部署到本地 Claude Code 环境。

### 主要特点

- ✅ **31 个专业技能**：覆盖全栈开发的各个方面
- ✅ **自动部署**：一键脚本自动从 GitHub 拉取并部署
- ✅ **持续更新**：支持从远程仓库自动更新到最新版本
- ✅ **本地 Marketplace**：创建本地插件市场，方便管理
- ✅ **完整验证**：包含部署验证和故障排除工具

## ✨ 功能特性

### 核心功能

1. **自动化部署**
   - 从 GitHub 仓库自动拉取最新技能
   - 自动生成插件配置文件
   - 自动注册到 Claude Code

2. **本地 Marketplace**
   - 创建本地插件市场
   - 支持插件版本管理
   - 自动发现和加载技能

3. **完整验证**
   - 部署后自动验证
   - 检查文件格式和完整性
   - 验证注册状态

### 技能分类

- **编程语言与框架**：TypeScript、FastAPI、React 等
- **数据库**：PostgreSQL、SQL 优化、数据库迁移
- **开发实践**：TDD、代码审查、错误处理
- **DevOps**：CI/CD、部署管道、Git 工作流
- **插件开发**：MCP 集成、命令开发、Hook 开发
- **设计**：前端设计、品牌指南、Canvas 设计

## 📁 项目结构

```
skills/
├── choose/                          # Skills 源文件夹
│   ├── applying-brand-guidelines/   # 品牌指南应用
│   ├── backend-dev-guidelines/      # 后端开发指南
│   ├── command-development/         # 命令开发
│   ├── mcp-integration/             # MCP 集成
│   ├── skill-development/           # 技能开发
│   └── ...                          # 其他 25 个技能
├── deploy-skills.sh                 # 主部署脚本
├── clean-cache.sh                   # 缓存清理脚本
├── choose-skill.markdown            # 技能索引文档
└── LICENSE                          # 许可证文件
```

### 部署后的目录结构

```
~/.claude/plugins/cache/choose-local-marketplace/
├── .claude-plugin/
│   └── marketplace.json             # Marketplace 配置文件
└── choose-skills/
    └── 0.1.0/
        ├── .claude-plugin/
        │   └── plugin.json          # 插件清单文件
        └── skills/                  # 所有技能目录
            ├── applying-brand-guidelines/
            ├── backend-dev-guidelines/
            └── ...                  # 其他技能
```

## 🚀 快速开始

### 前置要求

- **Claude Code**：已安装 Claude Code 应用
- **Git**：用于从 GitHub 拉取代码
- **Bash**：用于运行部署脚本（macOS/Linux 自带，Windows 需要 Git Bash 或 WSL）
- **Python 3**：用于 JSON 处理和验证

### 跨平台兼容性

脚本支持以下平台：

- ✅ **macOS**：完全支持
- ✅ **Linux**：完全支持
- ⚠️ **Windows**：需要 Git Bash 或 WSL（Windows Subsystem for Linux）

**注意**：脚本会自动检测 Claude Code 的安装位置，如果安装在非标准位置，请设置 `CLAUDE_PLUGINS_DIR` 环境变量。

### 安装步骤

1. **克隆或下载项目**

   ```bash
   git clone <repository-url>
   cd skills
   ```

2. **运行部署脚本**

   ```bash
   chmod +x deploy-skills.sh
   ./deploy-skills.sh
   ```

3. **重启 Claude Code**

   - 完全退出 Claude Code 应用（不是只关闭窗口）
   - 重新启动 Claude Code

4. **启用插件**

   - 打开 Claude Code
   - 输入 `/plugin` 打开插件设置
   - 切换到 "Installed" 或 "Marketplaces" 标签页
   - 找到 `choose-skills` 插件并启用

### 验证安装

运行验证脚本（如果存在）：

```bash
./verify-deployment.sh
```

或者手动检查：

```bash
# 检查插件目录
ls ~/.claude/plugins/cache/choose-local-marketplace/choose-skills/0.1.0/

# 检查 plugin.json
cat ~/.claude/plugins/cache/choose-local-marketplace/choose-skills/0.1.0/.claude-plugin/plugin.json | python3 -m json.tool

# 检查 marketplace 注册
cat ~/.claude/plugins/known_marketplaces.json | python3 -m json.tool
```

## 📚 Skills 列表

### 编程模式与语言实践

- **`error-handling-patterns`**：跨 Python/TS/Go/Rust 的异常体系、Result 模式、重试、断路器、降级等健壮性范式
- **`typescript-write`**：快速编写 TypeScript 代码的结构与示例指引
- **`typescript-review`**：TypeScript 代码审查要点与常见问题检查

### 数据库与查询

- **`postgresql-table-design`**：PostgreSQL 表设计规范、类型选择、约束/索引、分区与演进注意事项
- **`sql-optimization-patterns`**：EXPLAIN 分析、索引策略、N+1 消除、分页/聚合/子查询优化与监控脚本
- **`database-migration`**：使用零停机策略、数据转换和回滚程序跨 ORM 和平台执行数据库迁移

### 后端框架与 AI 应用

- **`fastapi-templates`**：生产级 FastAPI 脚手架（异步、DI、仓储/服务分层、JWT 安全、测试基座）
- **`backend-dev-guidelines`**：后端开发综合基线（架构/领域划分、接口规范、性能与安全、配套资源）
- **`langchain-architecture`**：LangChain 代理/记忆/检索/RAG 与工具集成模式，含性能与回调监控实践

### 测试与质量

- **`webapp-testing`**：基于 Playwright 的本地 Web 自动化测试思路与脚本入口
- **`code-review-excellence`**：高质量 Code Review 清单、示例反馈模板、语言专项检查项
- **`systematic-debugging`**：系统化根因调试流程与仪表化模式
- **`test-driven-development`**：严格 TDD 循环与示例

### 交付与运维

- **`deployment-pipeline-design`**：多阶段 CI/CD 设计、审批闸口、滚动/蓝绿/金丝雀策略与回滚范式
- **`changelog-generator`**：生成和维护变更日志的流程与模板，支持发布节奏管理
- **`git-advanced-workflows`**：交互式 rebase、cherry-pick、bisect、worktree、reflog 等高级 Git 工作流
- **`sveltia-cms`**：静态站点 CMS 集成与 OAuth Worker 部署

### 成本与效率优化

- **`cost-optimization`**：云资源/服务成本分析、压降策略与可视化跟踪

### MCP / 插件与命令开发

- **`mcp-builder`**：MCP 服务器设计流程、工具命名、错误可诊断性与 Python/TS 落地参考
- **`mcp-integration`**：在 Claude Code 插件中集成 MCP（.mcp.json / plugin.json 配置、类型选择、鉴权与安全范围）
- **`command-development`**：Slash 命令结构、前言字段、动态参数/文件引用、Bash 执行与组织策略
- **`command-name`**：命名规范与 minimal/standard/advanced 级命令示例，便于统一风格
- **`hook-development`**：PreToolUse/Stop 等事件 Hook 的 prompt/command 形态、匹配器、超时与安全校验模式
- **`skill-creator`** / **`skill-development`** / **`skill-writer`**：编写和打包 SKILL 的流程、触发描述写法、渐进披露、校验与示例模板

### 规则与模式识别

- **`rule-identifier`**：规则提取/归类/匹配模式库，可用于构建策略或校验逻辑（偏工程逻辑类需求）

### UI 与设计

- **`applying-brand-guidelines`**：品牌语调、色彩、排版规范
- **`canvas-design`**：画布字体与视觉素材集合
- **`frontend-design`**：前端设计原则与可复用组件思路
- **`react-modernization`**：React 升级、Hooks 迁移、并发特性采用

## ⚙️ 配置说明

### 部署脚本配置

#### 基本配置

编辑 `deploy-skills.sh` 文件中的配置变量：

```bash
# GitHub 仓库配置
GITHUB_REPO="https://github.com/karmaxteq/choose-for-skill.git"
REPO_BRANCH="main"
SKILLS_FOLDER="choose"

# 插件配置
PLUGIN_NAME="choose-skills"
MARKETPLACE_NAME="choose-local-marketplace"
PLUGIN_VERSION="0.1.0"
```

#### 自定义 Claude Code 插件目录

如果 Claude Code 安装在非标准位置，可以通过环境变量自定义：

```bash
# 设置自定义路径
export CLAUDE_PLUGINS_DIR="/path/to/claude/plugins"

# 然后运行脚本
./deploy-skills.sh
```

脚本会自动检测以下常见位置：
- `$HOME/.claude/plugins`（macOS/Linux 标准位置）
- `$HOME/Library/Application Support/Claude/plugins`（macOS 替代路径）
- `$HOME/.config/claude/plugins`（Linux 替代路径）

如果都找不到，脚本会尝试创建默认路径。

### 部署位置

插件默认部署到：

```
~/.claude/plugins/cache/choose-local-marketplace/choose-skills/0.1.0/
```

### 配置文件说明

#### `plugin.json`

插件清单文件，位于每个插件目录的 `.claude-plugin/` 子目录中：

```json
{
  "name": "choose-skills",
  "version": "0.1.0",
  "description": "Skills collection from GitHub...",
  "repository": "https://github.com/karmaxteq/choose-for-skill.git",
  "skills": [
    "./skills/applying-brand-guidelines",
    "./skills/backend-dev-guidelines",
    ...
  ]
}
```

#### `marketplace.json`

Marketplace 配置文件，位于 marketplace 根目录的 `.claude-plugin/` 子目录中：

```json
{
  "name": "choose-local-marketplace",
  "owner": {
    "name": "Local Developer",
    "email": "local@example.com"
  },
  "metadata": {
    "description": "Local skills bundle from GitHub...",
    "version": "0.1.0"
  },
  "plugins": [
    {
      "name": "choose-skills",
      "version": "0.1.0",
      "description": "...",
      "source": "./choose-skills/0.1.0",
      "strict": false
    }
  ]
}
```

**重要提示**：`marketplace.json` 中**不应该**包含 `skills` 字段，skills 应该从插件的 `plugin.json` 中读取。

## 📖 使用指南

### 更新 Skills

要更新到最新版本，只需重新运行部署脚本：

```bash
./deploy-skills.sh
```

脚本会自动：
1. 从 GitHub 拉取最新代码
2. 覆盖现有插件目录
3. 更新配置文件
4. 重新注册插件

### 清理缓存

如果需要清理所有缓存并重新部署：

```bash
./clean-cache.sh
./deploy-skills.sh
```

### 检查部署状态

检查插件是否正确部署：

```bash
# 检查插件目录
ls -la ~/.claude/plugins/cache/choose-local-marketplace/choose-skills/0.1.0/skills/

# 检查技能数量
find ~/.claude/plugins/cache/choose-local-marketplace/choose-skills/0.1.0/skills -name "SKILL.md" | wc -l

# 检查 JSON 格式
cat ~/.claude/plugins/cache/choose-local-marketplace/choose-skills/0.1.0/.claude-plugin/plugin.json | python3 -m json.tool
```

## 🔧 故障排除

### 问题：Git 拉取失败

**症状**：脚本在拉取 GitHub 代码时失败

**解决方案**：
- 检查网络连接
- 确认 GitHub 仓库地址正确
- 检查是否有访问权限
- 尝试手动访问仓库 URL

### 问题：插件未在 Claude Code 中显示

**症状**：部署成功但在 Claude Code 中看不到插件

**解决方案**：

1. **确认已完全重启 Claude Code**
   ```bash
   # 完全退出应用
   killall "Claude Code" 2>/dev/null || killall "claude" 2>/dev/null
   # 重新启动
   ```

2. **检查插件目录**
   ```bash
   ls ~/.claude/plugins/cache/choose-local-marketplace/choose-skills/0.1.0
   ```

3. **检查 plugin.json 格式**
   ```bash
   cat ~/.claude/plugins/cache/choose-local-marketplace/choose-skills/0.1.0/.claude-plugin/plugin.json | python3 -m json.tool
   ```

4. **检查插件注册**
   ```bash
   cat ~/.claude/plugins/installed_plugins.json | python3 -c "import json,sys; d=json.load(sys.stdin); print(json.dumps(d.get('plugins', {}).get('choose-skills@choose-local-marketplace', []), indent=2))"
   ```

5. **检查 marketplace 注册**
   ```bash
   cat ~/.claude/plugins/known_marketplaces.json | python3 -m json.tool
   ```

6. **在 Claude Code 中检查**
   - 打开插件设置 (`/plugin`)
   - 切换到 "Installed" 或 "Marketplaces" 标签页
   - 查找 `choose-skills` 插件

### 问题：Marketplace 未注册

**症状**：`known_marketplaces.json` 为空或缺少条目

**解决方案**：

运行修复脚本（如果存在）：
```bash
./fix-marketplace.sh
```

或手动更新：
```bash
python3 << EOF
import json
import os
from datetime import datetime

known_file = os.path.expanduser("~/.claude/plugins/known_marketplaces.json")
marketplace_name = "choose-local-marketplace"
install_location = os.path.expanduser("~/.claude/plugins/cache/choose-local-marketplace")

os.makedirs(os.path.dirname(known_file), exist_ok=True)

if os.path.exists(known_file):
    with open(known_file, 'r') as f:
        data = json.load(f)
else:
    data = {}

data[marketplace_name] = {
    "source": {
        "source": "directory",
        "path": install_location
    },
    "installLocation": install_location,
    "lastUpdated": datetime.now().isoformat() + "Z"
}

with open(known_file, 'w') as f:
    json.dump(data, f, indent=2)

print("✓ Marketplace 已注册")
EOF
```

### 问题：插件显示但 skills 不可用

**症状**：插件已安装但 skills 无法使用

**解决方案**：
- 确认每个 skill 目录都包含 `SKILL.md` 文件
- 检查 `plugin.json` 中的 skills 数组是否包含所有 skills
- 验证技能路径是否正确（相对路径，以 `./skills/` 开头）
- 查看 Claude Code 的控制台日志（如果有）

### 问题：JSON 格式错误

**症状**：`plugin.json` 或 `marketplace.json` 格式无效

**解决方案**：
- 使用 Python 验证 JSON 格式：
  ```bash
  python3 -m json.tool < file.json
  ```
- 检查是否有未转义的特殊字符
- 确保使用 Python 生成 JSON（脚本已修复）

## 🔍 技术细节

### 部署流程

1. **从 GitHub 拉取**
   - 使用 Git sparse-checkout 只拉取 `choose` 文件夹
   - 支持指定分支（默认 `main`）

2. **创建目录结构**
   - 创建插件目录：`~/.claude/plugins/cache/{marketplace}/{plugin}/{version}/`
   - 创建 marketplace 目录：`~/.claude/plugins/cache/{marketplace}/.claude-plugin/`

3. **复制 Skills**
   - 遍历 `choose` 文件夹下的所有子目录
   - 检查每个目录是否包含 `SKILL.md` 文件
   - 复制整个技能目录到插件目录

4. **生成配置文件**
   - 使用 Python 生成 `plugin.json`（确保 JSON 格式正确）
   - 使用 Python 生成 `marketplace.json`（不包含 skills 字段）

5. **注册插件**
   - 更新 `installed_plugins.json`
   - 更新 `known_marketplaces.json`

### 文件格式要求

#### plugin.json

- **位置**：`{plugin_dir}/.claude-plugin/plugin.json`
- **必需字段**：`name`
- **推荐字段**：`version`, `description`, `repository`, `skills`
- **skills 格式**：相对路径数组，如 `["./skills/skill-name"]`

#### marketplace.json

- **位置**：`{marketplace_dir}/.claude-plugin/marketplace.json`
- **必需字段**：`name`, `plugins`
- **重要**：plugins 数组中**不应该**包含 `skills` 字段

### 路径规则

- 所有路径必须相对于插件根目录
- Skills 路径必须以 `./skills/` 开头
- 不能使用绝对路径
- 支持相对路径引用

### 自动发现机制

Claude Code 自动发现和加载组件：

1. **Plugin manifest**：读取 `.claude-plugin/plugin.json` 当插件启用时
2. **Skills**：扫描 `skills/` 目录下的子目录，查找包含 `SKILL.md` 的目录
3. **Marketplace**：从 `known_marketplaces.json` 读取已注册的市场

## 🤝 贡献指南

### 添加新 Skill

1. 在 GitHub 仓库的 `choose` 文件夹下创建新的技能目录
2. 确保目录包含 `SKILL.md` 文件
3. 运行部署脚本自动拉取并部署

### 修改现有 Skill

1. 在 GitHub 仓库中修改对应的技能文件
2. 运行部署脚本更新到最新版本

### 报告问题

如果遇到问题，请提供以下信息：

- Claude Code 版本
- 操作系统和版本
- 错误消息或日志
- 部署脚本的输出
- 相关配置文件内容

## 📄 许可证

本项目遵循 [LICENSE](LICENSE) 文件中指定的许可证。

## 🔗 相关链接

- **GitHub 仓库**：https://github.com/karmaxteq/choose-for-skill
- **Claude Code 文档**：https://docs.anthropic.com/claude/docs/claude-code
- **Skills 市场**：https://skillsmp.com

## 📝 更新日志

### v0.1.0 (当前版本)

- ✅ 初始发布，包含 31 个专业技能
- ✅ 自动化部署脚本
- ✅ 本地 Marketplace 支持
- ✅ 完整的验证和故障排除工具

---

**注意**：本项目是一个 Claude Code 插件集合，所有技能都从 GitHub 仓库自动拉取。确保网络连接正常以便成功部署。

