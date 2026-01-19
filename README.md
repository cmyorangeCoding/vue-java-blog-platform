🌟 vue-java-blog-platform

一个功能完整、前后端分离的全栈博客系统
基于 Vue3 + Vite + Java 技术栈 开发
📚 大二课程设计作品

✨ 项目亮点

🎯 前后端分离架构：前端负责渲染交互，后端专注业务逻辑，解耦设计，便于独立迭代与部署

🔒 完善的安全机制：JWT 无状态认证 + Spring Security 密码加密 + Interceptor 权限拦截

💬 深度互动体验：支持多级嵌套评论、文章点赞与收藏，评论区采用 HashMap + ArrayList + 递归实现高效数据结构

📝 可追溯操作日志：基于 AOP 记录用户敏感操作，便于问题排查与数据审计

🖼️ 云端图片存储：集成阿里云 OSS，实现文章配图与用户头像的云端上传与分发

🔍 高效内容检索：支持按分类、标签、关键词快速筛选文章，提升用户浏览体验

🛠️ 技术栈 & 版本明细
后端（Maven）
依赖名称	版本	备注
Spring Boot Starter Parent	2.4.5	父工程，统一依赖版本
MyBatis Spring Boot Starter	2.2.2	数据访问基础依赖
MyBatis-Plus Boot Starter	3.4.2	增强 MyBatis 功能
MySQL Connector/J	runtime	数据库驱动
PageHelper Spring Boot Starter	1.4.2	分页插件
阿里云 OSS SDK	3.15.1	云端图片存储
JJWT 系列依赖	0.11.5	JWT 令牌生成与校验
Hutool All	5.8.22	工具类库
FastJSON	1.2.77	JSON 序列化与反序列化
JUnit	3.8.1	单元测试框架
Lombok	父工程继承	简化实体类代码
Spring Security / AOP / Validation	2.4.5	安全、切面、参数校验
前端（npm）
依赖名称	版本	备注
Vue	3.3.4	前端核心框架
Vue Router	4.2.4	路由管理
Axios	1.4.0	HTTP 请求客户端
Element Plus	2.3.8	UI 组件库
Vite	4.4.4	构建工具
@vitejs/plugin-vue	4.2.3	Vite Vue 插件
项目类型	ES Module	模块化开发规范
📋 功能清单
🔐 用户模块

 注册 / 登录 / 退出

 个人信息编辑（头像、用户名）

 我的文章 / 我的收藏管理

 密码修改（待拓展）

📝 文章模块

 文章发布 / 编辑 / 删除

 分类与标签管理

 文章列表分页展示

 按分类 / 标签 / 关键词检索

💬 互动模块

 文章点赞 / 取消点赞

 文章收藏 / 取消收藏

 多级嵌套评论与回复

 用户关注与私信（待拓展）

🎨 项目展示

页面截图（后续补充）

页面	截图
首页	待补充
个人中心	待补充
文章详情	待补充
写文章	待补充
🚀 快速启动
环境准备

JDK 17+

MySQL 8.0+

Node.js 18+

后端启动

创建 MySQL 数据库：blog_platform

执行 blog-backend/sql/init.sql 初始化表结构与测试数据

修改 application.yml，配置数据库连接与阿里云 OSS

运行 BlogBackendApplication.java

后端服务地址：
http://localhost:8080

前端启动
cd blog-frontend
npm install
npm run dev


前端服务地址：
http://localhost:5173

📝 开发日志

项目完成时间：2026 年 1 月

核心功能开发周期：约 2 天

后端架构与业务逻辑独立设计

开发过程中借助 AI 工具（GPT、豆包）优化技术方案与编码细节

前端框架自主搭建，注重全栈闭环与交互完整性