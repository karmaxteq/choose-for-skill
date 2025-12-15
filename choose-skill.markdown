# 方式1: 使用 killall（推荐）

killall "Claude Code" 2>/dev/null || killall "claude" 2>/dev/null

# 方式2: 强制退出所有相关进程

ps aux | grep -i "claude" | grep -v grep | awk '{print $2}' | xargs kill -9 2>/dev/null

# 方式3: 使用 pkill

pkill -f "claude-code" || pkill -f "claude"

## 编程模式与语言实践

* `error-handling-patterns`: 跨 Python/TS/Go/Rust 的异常体系、Result 模式、重试、断路器、降级等健壮性范式。
  * https://skillsmp.com/skills/wshobson-agents-plugins-developer-essentials-skills-error-handling-patterns-skill-md
* `typescript-write`: 快速编写 TypeScript 代码的结构与示例指引。
* https://skillsmp.com/skills/metabase-metabase-claude-skills-typescript-write-skill-md
* google-gemini-embeddings：生产级嵌入 API，批量与 REST 模式
  * https://skillsmp.com/skills/jezweb-claude-skills-skills-google-gemini-embeddings-skill-md

## 数据库与查询

* `postgresql-table-design`: PostgreSQL 表设计规范、类型选择、约束/索引、分区与演进注意事项。
* https://skillsmp.com/skills/wshobson-agents-plugins-database-design-skills-postgresql-skill-md
* `sql-optimization-patterns`: EXPLAIN 分析、索引策略、N+1 消除、分页/聚合/子查询优化与监控脚本。
  * https://skillsmp.com/skills/wshobson-agents-plugins-developer-essentials-skills-sql-optimization-patterns-skill-md
* database-migration ：使用零停机策略、数据转换和回滚程序跨ORM和平台执行数据库迁移。在迁移数据库、更改架构、执行数据转换或实施零停机部署策略时使用
* https://skillsmp.com/skills/wshobson-agents-plugins-framework-migration-skills-database-migration-skill-md

## 后端框架与 AI 应用

* `fastapi-templates`: 生产级 FastAPI 脚手架（异步、DI、仓储/服务分层、JWT 安全、测试基座）。
* https://skillsmp.com/skills/wshobson-agents-plugins-api-scaffolding-skills-fastapi-templates-skill-md
* `backend-dev-guidelines`: 后端开发综合基线（架构/领域划分、接口规范、性能与安全、配套资源）。
* https://skillsmp.com/skills/langfuse-langfuse-claude-skills-backend-dev-guidelines-skill-md
* `langchain-architecture`: LangChain 代理/记忆/检索/RAG 与工具集成模式，含性能与回调监控实践。
  * https://skillsmp.com/skills/wshobson-agents-plugins-llm-application-dev-skills-langchain-architecture-skill-md

## 测试与质量

* `webapp-testing`: 基于 Playwright 的本地 Web 自动化测试思路与脚本入口（with_server 管理多服务）。
* https://skillsmp.com/skills/anthropics-skills-skills-webapp-testing-skill-md
* `typescript-review`: TypeScript 代码审查要点与常见问题检查。
* https://skillsmp.com/skills/metabase-metabase-claude-skills-typescript-review-skill-md
* `code-review-excellence`: 高质量 Code Review 清单、示例反馈模板、语言专项检查项。
  * https://skillsmp.com/skills/wshobson-agents-plugins-developer-essentials-skills-code-review-excellence-skill-md
* systematic-debugging：系统化根因调试流程与仪表化模式
  * https://skillsmp.com/skills/obra-superpowers-skills-systematic-debugging-skill-md
* test-driven-development：严格 TDD 循环与示例
  * https://skillsmp.com/skills/obra-superpowers-skills-test-driven-development-skill-md

## 交付与运维

* `deployment-pipeline-design`: 多阶段 CI/CD 设计、审批闸口、滚动/蓝绿/金丝雀策略与回滚范式。
* https://skillsmp.com/skills/wshobson-agents-plugins-cicd-automation-skills-deployment-pipeline-design-skill-md
* `changelog-generator`: 生成和维护变更日志的流程与模板，支持发布节奏管理。
* https://skillsmp.com/skills/davila7-claude-code-templates-cli-tool-components-skills-development-changelog-generator-skill-md
* `git-advanced-workflows`: 交互式 rebase、cherry-pick、bisect、worktree、reflog 等高级 Git 工作流。
  * https://skillsmp.com/skills/wshobson-agents-plugins-developer-essentials-skills-git-advanced-workflows-skill-md
* sveltia-cms：静态站点 CMS 集成与 OAuth Worker 部署
  * https://skillsmp.com/skills/jezweb-claude-skills-skills-sveltia-cms-skill-md

## 成本与效率优化

* `cost-optimization`: 云资源/服务成本分析、压降策略与可视化跟踪。
* https://skillsmp.com/skills/wshobson-agents-plugins-cloud-infrastructure-skills-cost-optimization-skill-md

## MCP / 插件与命令开发

* `mcp-builder`: MCP 服务器设计流程、工具命名、错误可诊断性与 Python/TS 落地参考。
* https://skillsmp.com/skills/anthropics-skills-skills-mcp-builder-skill-md
* `mcp-integration`: 在 Claude Code 插件中集成 MCP（.mcp.json / plugin.json 配置、类型选择、鉴权与安全范围）。
* https://skillsmp.com/skills/anthropics-claude-code-plugins-plugin-dev-skills-mcp-integration-skill-md
* `command-development`: Slash 命令结构、前言字段、动态参数/文件引用、Bash 执行与组织策略。
* https://skillsmp.com/skills/anthropics-claude-code-plugins-plugin-dev-skills-command-development-skill-md
* `command-name`: 命名规范与 minimal/standard/advanced 级命令示例，便于统一风格。
* https://skillsmp.com/skills/anthropics-claude-code-plugins-plugin-dev-skills-plugin-structure-skill-md
* `hook-development`: PreToolUse/Stop 等事件 Hook 的 prompt/command 形态、匹配器、超时与安全校验模式。
* https://skillsmp.com/skills/anthropics-claude-code-plugins-plugin-dev-skills-hook-development-skill-md
* `skill-creator` / `skill-development` / `skill-writer`: 编写和打包 SKILL 的流程、触发描述写法、渐进披露、校验与示例模板。
  * https://skillsmp.com/skills/anthropics-skills-skills-skill-creator-skill-md
  * https://skillsmp.com/skills/anthropics-claude-code-plugins-plugin-dev-skills-skill-development-skill-md
  * https://skillsmp.com/skills/pytorch-pytorch-claude-skills-skill-writer-skill-md

## 规则与模式识别

* `rule-identifier`: 规则提取/归类/匹配模式库，可用于构建策略或校验逻辑（偏工程逻辑类需求）。
* https://skillsmp.com/skills/anthropics-claude-code-plugins-hookify-skills-writing-rules-skill-md

## UI与设计

* `brand-guidelines`: 品牌语调、色彩、排版规范。
* https://skillsmp.com/skills/anthropics-claude-cookbooks-skills-custom-skills-applying-brand-guidelines-skill-md
* `canvas-design`: 画布字体与视觉素材集合。
* https://skillsmp.com/skills/anthropics-skills-skills-canvas-design-skill-md
* `frontend-design`: 前端设计原则与可复用组件思路。
* https://skillsmp.com/skills/anthropics-claude-code-plugins-frontend-design-skills-frontend-design-skill-md
* react-modernization：React 升级、Hooks 迁移、并发特性采用
  * https://skillsmp.com/skills/wshobson-agents-plugins-framework-migration-skills-react-modernization-skill-md
