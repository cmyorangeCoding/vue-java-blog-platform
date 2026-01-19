🌟 vue-java-blog-platform

一个功能完整、前后端分离的全栈博客系统
基于 Vue3 + Vite + Java 技术栈开发
📚 大二课程设计作品

✨ 项目亮点

🎯 前后端分离架构：前端负责渲染交互，后端专注业务逻辑

🔒 完善的安全机制：JWT + Spring Security + Interceptor

💬 互动体验丰富：多级嵌套评论、点赞、收藏等

📝 AOP 操作日志：方便排查与审计

🖼️ 阿里云 OSS 集成：文章图片和用户头像上传支持

🔍 快速内容检索：按分类 / 标签 / 关键词筛选文章

🛠 技术栈 & 版本明细
后端（Maven）
依赖名称	版本	备注
Spring Boot	2.4.5	父工程
MyBatis / MyBatis-Plus	2.2.2 / 3.4.2	ORM
MySQL Connector/J	runtime	数据库
PageHelper	1.4.2	分页插件
阿里云 OSS SDK	3.15.1	云端存储
JJWT 系列	0.11.5	JWT 支持
Hutool All	5.8.22	工具库
FastJSON	1.2.77	JSON
Lombok / JUnit	—	简化开发与测试
Spring Security / AOP	2.4.5	安全与切面
前端（npm）
依赖名称	版本	备注
Vue	3.3.4	框架
Vue Router	4.2.4	路由
Axios	1.4.0	HTTP 请求
Element Plus	2.3.8	UI
Vite	4.4.4	打包工具
@vitejs/plugin-vue	4.2.3	Vue 插件
📋 功能清单
🔐 用户模块

注册 / 登录 / 退出

个人信息编辑（头像、用户名）

我的文章 / 我的收藏

密码修改（待拓展）

📝 文章模块

文章发布 / 编辑 / 删除

分类与标签管理

分页展示、分类 / 标签 / 关键词检索

💬 互动模块

点赞 / 取消点赞

收藏 / 取消收藏

多级嵌套评论与回复

用户关注与私信（待拓展）

🚀 快速启动
环境准备

JDK 17+

MySQL 8.0+

Node.js 18+

后端启动

创建数据库：blog_platform

执行初始化 SQL

修改 application.yml

启动后端服务

后端默认：http://localhost:8080

前端启动
cd blog-frontend
npm install
npm run dev


前端默认：http://localhost:5173

📝 开发日志

项目完成时间：2026 年 1 月

功能核心开发约 2 天

借助 AI 工具优化方案

前后端独立设计实现全栈闭环
