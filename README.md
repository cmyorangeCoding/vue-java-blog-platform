# 🌟 vue-java-blog-platform

一个功能完整、前后端分离的全栈博客系统，基于 Vue3 + Vite + Java 技术栈开发，为大二课程设计作品。

---

## ✨ 项目亮点
- 🎯 **前后端分离架构**：前端负责渲染交互，后端专注业务逻辑，解耦设计便于独立迭代与部署  
- 🔒 **完善的安全机制**：JWT 无状态认证 + Spring Security 密码加密 + Interceptor 权限拦截，保障接口安全  
- 💬 **深度互动体验**：支持多级嵌套评论、文章点赞与收藏，评论区采用 HashMap + ArrayList + 递归实现  
- 📝 **可追溯操作日志**：基于 AOP 记录用户敏感操作，便于问题排查与数据审计  
- 🖼️ **云端图片存储**：集成阿里云 OSS，实现文章配图与用户头像的云端上传与分发  
- 🔍 **高效内容检索**：支持按分类 / 标签 / 关键词快速筛选文章  

---

## 🛠️ 技术栈 & 版本明细

### 后端（Maven）
| 依赖名称 | 版本 | 备注 |
| --- | --- | --- |
| Spring Boot Starter Parent | 2.4.5 | 父工程，统一依赖版本 |
| MyBatis Spring Boot Starter | 2.2.2 | 数据访问基础依赖 |
| MyBatis-Plus Boot Starter | 3.4.2 | 增强 MyBatis 功能 |
| MySQL Connector/J | runtime | 数据库驱动 |
| PageHelper Spring Boot Starter | 1.4.2 | 分页插件 |
| 阿里云 OSS SDK | 3.15.1 | 云端图片存储 |
| JJWT | 0.11.5 | JWT 令牌生成与校验 |
| Hutool All | 5.8.22 | 工具类库 |
| FastJSON | 1.2.77 | JSON 处理 |
| JUnit | 3.8.1 | 单元测试 |
| Lombok | 父工程管理 | 简化实体类 |
| Spring Security / AOP / Validation | 2.4.5 | 安全、切面、校验 |

### 前端（npm）
| 依赖名称 | 版本 | 备注 |
| --- | --- | --- |
| Vue | 3.3.4 | 前端核心框架 |
| Vue Router | 4.2.4 | 路由管理 |
| Axios | 1.4.0 | HTTP 请求 |
| Element Plus | 2.3.8 | UI 组件库 |
| Vite | 4.4.4 | 构建工具 |
| @vitejs/plugin-vue | 4.2.3 | Vue 插件 |
| 模块规范 | ES Module | |

---

## 📋 功能清单

### 🔐 用户模块
- [x] 注册 / 登录 / 退出  
- [x] 个人信息编辑（头像、用户名）  
- [x] 我的文章 / 我的收藏  
- [ ] 密码修改（待拓展）

### 📝 文章模块
- [x] 发布 / 编辑 / 删除  
- [x] 分类与标签管理  
- [x] 分页展示  
- [x] 分类 / 标签 / 关键词检索  

### 💬 互动模块
- [x] 点赞 / 取消点赞  
- [x] 收藏 / 取消收藏  
- [x] 多级嵌套评论  
- [ ] 关注 / 私信（待拓展）

---

## 🎨 项目展示
> 界面截图（后续补充）

| 页面 | 截图 |
| --- | --- |
| 首页 | 待补充 |
| 个人中心 | 待补充 |
| 文章详情 | 待补充 |
| 写文章 | 待补充 |

---

## 🚀 快速启动

### 环境准备
1. JDK 8+  
2. MySQL 8.0+  
3. Node.js 18+  

### 后端启动
1. 创建数据库 `blog`  
2. 执行 `blog-backend/sql/init.sql`  
3. 修改 `application.yml`（数据库 & OSS 配置）  
4. 启动 `BlogApplication.java`  
   - http://localhost:8080  

### 前端启动
```bash
cd blog-frontend
npm install
npm run dev
前端访问地址：http://localhost:5173


##📝 开发日志

项目完成时间：2026 年 1 月
核心功能开发周期：3 天
后端架构与业务逻辑独立设计
开发过程中借助 AI 工具（GPT、豆包）辅助方案设计与编码优化
前端框架自主搭建，完成完整前后端闭环
