# 🌟 vue-java-blog-platform

一个功能完整、前后端分离的全栈博客系统，  
基于 **Vue3 + Vite + Java** 技术栈开发，为 **大二课程设计作品**。

---

## ✨ 项目亮点

- 🎯 **前后端分离架构**：前端负责渲染交互，后端专注业务逻辑，解耦设计便于独立迭代与部署  
- 🔒 **完善的安全机制**：JWT 无状态认证 + Spring Security + Interceptor 权限拦截  
- 💬 **深度互动体验**：支持多级嵌套评论、文章点赞与收藏  
  - 评论结构基于 `HashMap + ArrayList + 递归` 实现  
- 📝 **可追溯操作日志**：基于 AOP 记录用户敏感操作，便于排查与审计  
- 🖼️ **云端图片存储**：集成阿里云 OSS，支持文章配图与用户头像上传  
- 🔍 **高效内容检索**：支持按分类 / 标签 / 关键词筛选文章

---

## 🛠️ 技术栈 & 版本明细

### 后端（Maven）

| 依赖名称 | 版本 | 备注 |
| :--- | :--- | :--- |
| Spring Boot Starter Parent | 2.4.5 | 父工程，统一依赖版本 |
| MyBatis Spring Boot Starter | 2.2.2 | ORM |
| MyBatis-Plus Boot Starter | 3.4.2 | MyBatis 增强 |
| MySQL Connector/J | runtime | 数据库驱动 |
| PageHelper Spring Boot Starter | 1.4.2 | 分页插件 |
| 阿里云 OSS SDK | 3.15.1 | 云存储 |
| JJWT | 0.11.5 | JWT 生成与校验 |
| Hutool All | 5.8.22 | 工具类库 |
| FastJSON | 1.2.77 | JSON 处理 |
| JUnit | 3.8.1 | 单元测试 |
| Lombok | 父工程版本 | 简化实体类 |
| Spring Security / AOP / Validation | 2.4.5 | 安全、切面、参数校验 |

---

### 前端（npm）

| 依赖名称 | 版本 | 备注 |
| :--- | :--- | :--- |
| Vue | 3.3.4 | 前端核心框架 |
| Vue Router | 4.2.4 | 路由管理 |
| Axios | 1.4.0 | HTTP 请求 |
| Element Plus | 2.3.8 | UI 组件库 |
| Vite | 4.4.4 | 构建工具 |
| @vitejs/plugin-vue | 4.2.3 | Vue 插件 |
| 项目类型 | ES Module | 模块化规范 |

---

## 📋 功能清单

### 🔐 用户模块
- [x] 注册 / 登录 / 退出
- [x] 个人信息编辑（头像、用户名）
- [x] 我的文章 / 我的收藏
- [ ] 密码修改（待拓展）

### 📝 文章模块
- [x] 文章发布 / 编辑 / 删除
- [x] 分类与标签管理
- [x] 文章列表分页展示
- [x] 按分类 / 标签 / 关键词检索

### 💬 互动模块
- [x] 点赞 / 取消点赞
- [x] 收藏 / 取消收藏
- [x] 多级嵌套评论与回复
- [ ] 用户关注与私信（待拓展）

---

## 🎨 项目大体展示

### 游客页面

#### 首页
<img width="1830" height="939" alt="3a8f54859f5e65cc9c58774f50401b8" src="https://github.com/user-attachments/assets/24acf0f3-e3e9-46d6-b716-aa4863ad1f3a" />

<img width="1818" height="907" alt="d807cb6b6d53a54ab2276156b69ccb2" src="https://github.com/user-attachments/assets/53625b7f-52d2-4bd0-899c-40d857e748da" />

#### 注册页面
<img width="1801" height="916" alt="395e959764e4255104a1da138d02c73" src="https://github.com/user-attachments/assets/20599f6d-60e9-4312-92e5-58eb9fae4f9a" />

#### 登录页面
<img width="1822" height="908" alt="da53ecbf0f2c02cef682d6c5f9577ae" src="https://github.com/user-attachments/assets/8d295f68-9416-4e30-bf8b-137a4caf669e" />

### 用户页面

#### 文章详情
<img width="1830" height="924" alt="1275aeacb512d9efa2947a56693847e" src="https://github.com/user-attachments/assets/8f2cc562-73e2-4d3a-8c2a-62724e44d06b" />

<img width="1814" height="930" alt="20be5c1f6eff9345c9242b952cc34b6" src="https://github.com/user-attachments/assets/669d4914-4e21-4b0f-a71d-f0175fa4a89c" />

#### 个人中心
<img width="1830" height="923" alt="419035c8462fe23d1fa62ce17b8f443" src="https://github.com/user-attachments/assets/ba643921-a910-4225-942c-8b5fcd02bcd9" />

#### 创建文章
<img width="1822" height="921" alt="e023828bfc9eb758d2ef779d2a0a26f" src="https://github.com/user-attachments/assets/da5e0aff-cd94-4bb1-a01f-9f2db418ef19" />

---

## 🚀 快速启动

### 环境准备
1. **JDK 8+**
2. **MySQL 8.0+**
3. **Node.js 18+**

---

### 后端启动

1. 创建数据库 `blog`
2. 执行 `blog-backend/sql/init.sql`
3. 修改 `application.yml`，配置数据库与 OSS
4. 启动 `BlogApplication.java`

后端访问地址：
http://localhost:8080

---

### 前端启动

```bash
cd blog-frontend
npm install
npm run dev
```

前端访问地址：
http://localhost:5173

---

## 📝 开发日志

项目完成时间：2026 年 1 月  
核心功能开发周期：3 天  
后端架构与业务逻辑独立设计  
开发过程中借助 AI 工具（GPT、豆包）辅助方案设计与编码优化
前端框架自主搭建，完成完整前后端闭环

---
