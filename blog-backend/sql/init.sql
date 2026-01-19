/*
 Navicat Premium Dump SQL

 Source Server         : cmy1
 Source Server Type    : MySQL
 Source Server Version : 80041 (8.0.41)
 Source Host           : localhost:3306
 Source Schema         : blog

 Target Server Type    : MySQL
 Target Server Version : 80041 (8.0.41)
 File Encoding         : 65001

 Date: 19/01/2026 15:06:39
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` bigint NULL DEFAULT NULL,
  `user_id` bigint NOT NULL,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `category_id`(`category_id` ASC) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `article_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `article_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES (26, 'Java中ArrayList和LinkedList的性能对比分析', '在Java开发中，ArrayList和LinkedList作为常用集合类，底层分别基于数组和双向链表实现，这直接导致二者在增删改查操作中的性能差异。本文通过实际测试案例，分析遍历、插入、删除等场景下的性能表现，总结出ArrayList适合随机访问、LinkedList适合频繁增删的适用场景，同时分享了项目中选择集合类的实战判断技巧。\n![图片](/oss/blog/ARTICLE/dfa4d81e-8b11-48a9-9308-0bdeddfd4984.jpg)\n', 4, 25, '2026-01-05 09:26:56', '2026-01-05 09:26:57');
INSERT INTO `article` VALUES (27, 'Vue3组合式API的实战使用技巧', 'Vue3的组合式API相比选项式API，在代码组织和复用性上实现了质的提升。本文从setup语法糖、ref与reactive的响应式区别、生命周期钩子的替换方式入手，结合电商首页开发案例，讲解组合式API在组件封装、状态管理中的实际应用，帮助前端开发者快速上手Vue3项目。\n![图片](/oss/blog/ARTICLE/dee231e7-2a59-4313-9b75-ab0c4bf97df6.webp)\n', 4, 25, '2026-01-05 09:29:10', '2026-01-05 09:29:11');
INSERT INTO `article` VALUES (28, '独居生活的小确幸，把出租屋变成温馨小家', '毕业后来到陌生城市独居，从最初的手忙脚乱到如今把出租屋打理得井井有条，我总结了不少实用技巧：用平价的ins风软装打造温馨角落，利用抽屉分隔盒解决收纳难题，搭配一人食的简易菜谱让三餐有滋有味，独居生活也能充满烟火气和幸福感。\n![图片](/oss/blog/ARTICLE/cac390b1-f0ab-454b-8b39-28d6d0f57ecf.png)\n', 5, 24, '2026-01-05 09:36:23', '2026-01-05 09:36:25');
INSERT INTO `article` VALUES (29, '家常菜教程，超下饭的番茄牛腩做法', '番茄牛腩是一道老少皆宜的家常菜，做法简单却美味十足。先将牛腩冷水焯水去血沫，用冰糖炒出糖色后翻炒牛腩，加开水炖至软烂，最后放入番茄炖煮收汁，酸甜浓郁的汤汁拌米饭，一次能吃两大碗。文中还分享了用高压锅缩短炖煮时间、加番茄酱提升风味的小窍门。\n![图片](/oss/blog/ARTICLE/41614ff3-3e13-4104-9fe7-f73d3aaba923.jpg)\n', 9, 24, '2026-01-05 09:38:26', '2026-01-05 09:38:28');
INSERT INTO `article` VALUES (30, 'LOL手游新赛季上分技巧，辅助位的游走思路', 'LOL手游新赛季更新后，辅助位的玩法迎来不少变化。本文针对软辅（娜美、娑娜）和硬辅（锤石、布隆）的特点，讲解对线期的消耗技巧、游走的时机选择（如打野刷野间隙、中路推线时），以及团战中的保护和开团思路，帮助辅助玩家轻松冲上钻石段位。\n![图片](/oss/blog/ARTICLE/818a2ce2-01cf-4295-a717-fcf872902f9f.jpg)\n', 8, 26, '2026-01-05 09:40:54', '2026-01-05 09:40:56');
INSERT INTO `article` VALUES (31, '城市探店记，藏在老巷子里的宝藏咖啡馆', '周末闲逛老城区，在一条深巷里发现了一家小众手冲咖啡馆。店内是复古原木装修，老板会根据顾客口味推荐咖啡豆，我尝试了埃塞俄比亚的耶加雪菲，果酸清新、回甘悠长，搭配一块海盐巴斯克蛋糕，在慵懒的午后度过了惬意的时光，也感受到了老城区独有的慢节奏。\n![图片](/oss/blog/ARTICLE/67df0a99-a4a9-4b89-8951-85b0e13a1f5d.png)\n', 9, 27, '2026-01-05 09:45:42', '2026-01-05 09:45:44');
INSERT INTO `article` VALUES (32, '5本提升认知的好书，读完刷新思维方式', '这半年读完的书中，有5本彻底改变了我的思维方式：《认知觉醒》理清了学习的底层逻辑，《置身事内》让我看懂中国经济的运行规律，《蛤蟆先生去看心理医生》教会我与自己和解，《穷查理宝典》和《原则》则提供了多元的思考框架，每一本都值得反复品读。\n![图片](/oss/blog/ARTICLE/d173d27a-b4c9-4773-8000-0e431342731b.png)\n', 7, 28, '2026-01-05 09:50:33', '2026-01-05 09:51:23');
INSERT INTO `article` VALUES (33, '职场副业新思路，利用技术做接单小项目', '程序员想通过副业增加收入，接单做小项目是不错的选择。本文分享在猪八戒网、程序员客栈等平台接单的技巧，从简单的企业官网开发、微信小程序定制入手，讲解项目报价、需求沟通和交付验收的注意事项，让你利用业余时间实现技术变现。', 6, 29, '2026-01-05 09:54:20', '2026-01-05 09:54:20');
INSERT INTO `article` VALUES (34, '新手摄影技巧，用手机拍出氛围感街拍', '不用单反，手机也能拍出好看的街拍。本文分享几个实用技巧：利用清晨或傍晚的黄金光线拍摄，采用三分构图法突出主体，通过抓拍捕捉街头的自然瞬间，还推荐了醒图、Snapseed等修图APP的调色参数，让新手也能轻松拍出氛围感街拍作品。\n![图片](/oss/blog/ARTICLE/449f60f9-7533-447b-a463-ab638938c79d.jpg)\n', 5, 30, '2026-01-05 09:56:34', '2026-01-05 09:57:07');
INSERT INTO `article` VALUES (35, '居家绿植养护指南，新手也能养活的6种绿植', '想给家里添生机又怕养死绿植？这6种绿植特别适合新手：绿萝好养活还能净化空气，龟背竹颜值高且耐阴，多肉、吊兰、虎皮兰耐旱易打理，琴叶榕则是居家软装的好搭档。本文详细讲解每种绿植的浇水、光照和施肥技巧，让你的绿植茁壮成长。\n![图片](/oss/blog/ARTICLE/e0bffc1e-5c15-43d2-a1b3-b389be78aad5.jpg)\n', 5, 31, '2026-01-05 10:00:06', '2026-01-05 10:00:08');
INSERT INTO `article` VALUES (36, '前端工程化之Git提交规范的落地实践', '良好的Git提交规范能大幅提升团队协作效率，本文分享在前端项目中落地Conventional Commits规范的全过程：通过husky配置提交钩子，结合commitlint实现提交信息校验，搭配cz-git打造交互式提交流程，让团队的版本管理更规范、提交记录更具可读性。\n![图片](/oss/blog/ARTICLE/a1bbd168-a29a-418b-86d3-876e5244e108.webp)\n', 4, 25, '2026-01-05 10:02:05', '2026-01-05 10:02:06');
INSERT INTO `article` VALUES (37, '职场面试的STAR法则，让你的回答更有逻辑', '面试中如何清晰讲述项目经历？STAR法则是核心技巧。S（情境）说明项目背景，T（任务）明确个人职责，A（行动）描述解决问题的方法，R（结果）展示工作成果。本文结合技术岗面试案例，拆解STAR法则在项目描述、问题解决等场景的使用细节，帮你在面试中脱颖而出。\n![图片](/oss/blog/ARTICLE/6b5ac637-19eb-431b-a93b-35649abaf321.jpg)\n', 6, 29, '2026-01-05 10:03:44', '2026-01-05 10:03:45');
INSERT INTO `article` VALUES (38, '2025年必追的5部高分剧，剧情反转停不下来', '年末盘点，这5部高分剧让我熬夜追完：悬疑剧《隐秘的角落2》延续前作的烧脑风格，职场剧《前途》真实还原互联网行业的生存现状，古装剧《长安三万里》的服化道和剧情双在线，科幻剧《星际边界》的世界观设定新颖，温情剧《人间小事》则用细节治愈人心。\n![图片](/oss/blog/ARTICLE/7d05168b-2898-452d-8697-a5382050150c.jpg)\n\n![图片](/oss/blog/ARTICLE/06f44795-88d4-4a58-b1b9-d65c0e009ae2.jpeg)\n', 8, 24, '2026-01-05 10:05:12', '2026-01-05 20:58:19');
INSERT INTO `article` VALUES (39, '原神枫丹版本新角色解析，水神芙宁娜实战攻略', '原神枫丹版本的核心角色芙宁娜上线后，成为水系队伍的强力核心。本文从天赋机制、圣遗物搭配（如千岩牢固、沉沦之心）、武器选择（静水流涌之辉、祭礼残章）和队伍配队（纯水队、胡行芙钟）四个方面，详细解析芙宁娜的实战玩法，还分享了零命和满命的不同培养思路。\n\n![图片](/oss/blog/ARTICLE/2321a257-817a-4cb4-ac48-dacc3812fd35.jpg)\n', 8, 26, '2026-01-05 10:06:50', '2026-01-05 10:07:26');
INSERT INTO `article` VALUES (40, '咖啡入门指南，认识不同种类的咖啡豆', '刚接触咖啡的人常被各类咖啡豆名称困扰，本文从咖啡豆的产地（埃塞俄比亚、哥伦比亚、巴西）、处理法（水洗、日晒、蜜处理）和风味特点入手，讲解阿拉比卡与罗布斯塔豆的区别，还推荐了适合新手的曼特宁、蓝山咖啡豆，帮你找到自己喜欢的口味。\n![图片](/oss/blog/ARTICLE/9c012105-ada7-4bf2-a4a7-959a38f7d8b6.jpg)\n', 9, 27, '2026-01-05 10:09:32', '2026-01-05 10:09:34');

-- ----------------------------
-- Table structure for article_collect
-- ----------------------------
DROP TABLE IF EXISTS `article_collect`;
CREATE TABLE `article_collect`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `article_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_article_user`(`article_id` ASC, `user_id` ASC) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `article_collect_ibfk_1` FOREIGN KEY (`article_id`) REFERENCES `article` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `article_collect_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article_collect
-- ----------------------------
INSERT INTO `article_collect` VALUES (16, 35, 27, '2026-01-05 10:11:11');
INSERT INTO `article_collect` VALUES (17, 29, 27, '2026-01-05 10:12:34');
INSERT INTO `article_collect` VALUES (18, 34, 24, '2026-01-05 10:13:59');
INSERT INTO `article_collect` VALUES (19, 36, 29, '2026-01-05 10:17:07');
INSERT INTO `article_collect` VALUES (21, 31, 31, '2026-01-05 10:18:26');
INSERT INTO `article_collect` VALUES (22, 38, 31, '2026-01-05 10:20:06');
INSERT INTO `article_collect` VALUES (23, 34, 31, '2026-01-05 10:21:21');
INSERT INTO `article_collect` VALUES (24, 31, 24, '2026-01-05 19:23:37');
INSERT INTO `article_collect` VALUES (26, 40, 31, '2026-01-08 08:49:05');
INSERT INTO `article_collect` VALUES (27, 40, 24, '2026-01-18 15:52:41');

-- ----------------------------
-- Table structure for article_comment
-- ----------------------------
DROP TABLE IF EXISTS `article_comment`;
CREATE TABLE `article_comment`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `article_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父评论ID（0为顶级评论）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `article_id`(`article_id` ASC) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `article_comment_ibfk_1` FOREIGN KEY (`article_id`) REFERENCES `article` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `article_comment_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article_comment
-- ----------------------------
INSERT INTO `article_comment` VALUES (1, 31, 24, '问问博主在哪里？', '2026-01-06 11:28:35', 0);
INSERT INTO `article_comment` VALUES (3, 31, 27, '藏在老城区书院街的深巷里啦，导航搜巷陌咖啡就能找到～', '2026-01-06 12:00:15', 1);
INSERT INTO `article_comment` VALUES (4, 31, 31, '我也要去！！！', '2026-01-06 12:00:52', 3);
INSERT INTO `article_comment` VALUES (5, 31, 31, '感谢博主，😘', '2026-01-06 12:01:46', 0);
INSERT INTO `article_comment` VALUES (6, 40, 31, '对咖啡豆完全不了解，感谢科普！', '2026-01-06 12:02:36', 0);
INSERT INTO `article_comment` VALUES (7, 38, 31, '好看！！！', '2026-01-06 12:02:51', 0);
INSERT INTO `article_comment` VALUES (9, 40, 24, '我也是天天喝瑞幸（哭', '2026-01-06 12:06:53', 6);
INSERT INTO `article_comment` VALUES (10, 39, 24, '👌', '2026-01-06 12:07:38', 0);
INSERT INTO `article_comment` VALUES (11, 35, 24, '喜欢你的博客，交个朋友吧！', '2026-01-06 12:08:22', 0);
INSERT INTO `article_comment` VALUES (12, 38, 24, '有品啊！', '2026-01-06 12:08:53', 7);
INSERT INTO `article_comment` VALUES (13, 36, 24, '误入（）', '2026-01-06 12:09:28', 0);
INSERT INTO `article_comment` VALUES (14, 36, 29, '感谢科普。', '2026-01-06 12:10:15', 0);
INSERT INTO `article_comment` VALUES (15, 33, 29, '怎么没什么热度啊。。。', '2026-01-06 12:10:57', 0);
INSERT INTO `article_comment` VALUES (17, 36, 25, '😘', '2026-01-06 12:13:37', 14);
INSERT INTO `article_comment` VALUES (18, 36, 25, '哈哈，有兴趣来学啊。', '2026-01-06 12:13:59', 13);
INSERT INTO `article_comment` VALUES (19, 39, 25, '好久没玩了', '2026-01-06 12:14:36', 0);
INSERT INTO `article_comment` VALUES (20, 37, 25, '还好早就辞职单干了嘿嘿', '2026-01-06 12:15:38', 0);
INSERT INTO `article_comment` VALUES (21, 35, 31, '好呀！嘿嘿', '2026-01-06 12:17:21', 11);
INSERT INTO `article_comment` VALUES (22, 34, 31, '拍的好美。。。震撼', '2026-01-06 12:18:12', 0);
INSERT INTO `article_comment` VALUES (24, 34, 24, '你怎么也在这？', '2026-01-06 12:19:17', 22);
INSERT INTO `article_comment` VALUES (25, 32, 31, '感觉自己好没有文化/(ㄒoㄒ)/~~', '2026-01-08 08:05:27', 0);
INSERT INTO `article_comment` VALUES (26, 40, 31, '好\n', '2026-01-08 08:49:12', 0);
INSERT INTO `article_comment` VALUES (27, 40, 31, '哈哈', '2026-01-08 08:49:23', 9);

-- ----------------------------
-- Table structure for article_like
-- ----------------------------
DROP TABLE IF EXISTS `article_like`;
CREATE TABLE `article_like`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `article_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_article_user`(`article_id` ASC, `user_id` ASC) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `article_like_ibfk_1` FOREIGN KEY (`article_id`) REFERENCES `article` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `article_like_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article_like
-- ----------------------------
INSERT INTO `article_like` VALUES (12, 29, 27, '2026-01-05 10:12:35');
INSERT INTO `article_like` VALUES (13, 35, 27, '2026-01-05 10:12:47');
INSERT INTO `article_like` VALUES (14, 34, 24, '2026-01-05 10:13:58');
INSERT INTO `article_like` VALUES (15, 38, 24, '2026-01-05 10:15:10');
INSERT INTO `article_like` VALUES (16, 37, 24, '2026-01-05 10:15:22');
INSERT INTO `article_like` VALUES (17, 36, 29, '2026-01-05 10:17:07');
INSERT INTO `article_like` VALUES (19, 31, 31, '2026-01-05 10:18:25');
INSERT INTO `article_like` VALUES (20, 38, 31, '2026-01-05 10:20:05');
INSERT INTO `article_like` VALUES (21, 39, 31, '2026-01-05 10:20:15');
INSERT INTO `article_like` VALUES (23, 31, 24, '2026-01-05 19:23:35');
INSERT INTO `article_like` VALUES (24, 32, 24, '2026-01-05 19:45:14');
INSERT INTO `article_like` VALUES (25, 40, 24, '2026-01-05 20:47:45');
INSERT INTO `article_like` VALUES (27, 32, 31, '2026-01-06 12:03:00');
INSERT INTO `article_like` VALUES (28, 39, 24, '2026-01-06 12:07:08');
INSERT INTO `article_like` VALUES (29, 37, 29, '2026-01-06 12:09:54');
INSERT INTO `article_like` VALUES (30, 33, 29, '2026-01-06 12:10:43');
INSERT INTO `article_like` VALUES (31, 34, 29, '2026-01-06 12:12:08');
INSERT INTO `article_like` VALUES (32, 26, 29, '2026-01-06 12:12:32');
INSERT INTO `article_like` VALUES (33, 36, 31, '2026-01-07 10:31:47');
INSERT INTO `article_like` VALUES (34, 34, 31, '2026-01-07 11:16:26');
INSERT INTO `article_like` VALUES (36, 33, 31, '2026-01-07 23:00:18');
INSERT INTO `article_like` VALUES (37, 40, 31, '2026-01-08 08:49:03');

-- ----------------------------
-- Table structure for article_tag
-- ----------------------------
DROP TABLE IF EXISTS `article_tag`;
CREATE TABLE `article_tag`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `article_id` bigint NOT NULL,
  `tag_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_article_tag`(`article_id` ASC, `tag_id` ASC) USING BTREE,
  INDEX `tag_id`(`tag_id` ASC) USING BTREE,
  CONSTRAINT `article_tag_ibfk_1` FOREIGN KEY (`article_id`) REFERENCES `article` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `article_tag_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article_tag
-- ----------------------------
INSERT INTO `article_tag` VALUES (16, 26, 6);
INSERT INTO `article_tag` VALUES (17, 26, 9);
INSERT INTO `article_tag` VALUES (18, 26, 10);
INSERT INTO `article_tag` VALUES (19, 27, 7);
INSERT INTO `article_tag` VALUES (20, 27, 8);
INSERT INTO `article_tag` VALUES (22, 28, 11);
INSERT INTO `article_tag` VALUES (21, 28, 19);
INSERT INTO `article_tag` VALUES (24, 29, 11);
INSERT INTO `article_tag` VALUES (23, 29, 15);
INSERT INTO `article_tag` VALUES (25, 30, 17);
INSERT INTO `article_tag` VALUES (26, 30, 18);
INSERT INTO `article_tag` VALUES (27, 31, 12);
INSERT INTO `article_tag` VALUES (28, 31, 22);
INSERT INTO `article_tag` VALUES (30, 32, 11);
INSERT INTO `article_tag` VALUES (29, 32, 14);
INSERT INTO `article_tag` VALUES (31, 33, 20);
INSERT INTO `article_tag` VALUES (32, 34, 11);
INSERT INTO `article_tag` VALUES (33, 34, 23);
INSERT INTO `article_tag` VALUES (35, 35, 11);
INSERT INTO `article_tag` VALUES (34, 35, 25);
INSERT INTO `article_tag` VALUES (36, 36, 8);
INSERT INTO `article_tag` VALUES (37, 36, 9);
INSERT INTO `article_tag` VALUES (38, 37, 13);
INSERT INTO `article_tag` VALUES (39, 37, 20);
INSERT INTO `article_tag` VALUES (40, 38, 16);
INSERT INTO `article_tag` VALUES (41, 39, 17);
INSERT INTO `article_tag` VALUES (42, 39, 18);
INSERT INTO `article_tag` VALUES (44, 40, 12);
INSERT INTO `article_tag` VALUES (43, 40, 22);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (4, '技术博客', '2025-12-30 20:57:33');
INSERT INTO `category` VALUES (5, '生活随笔', '2025-12-30 20:57:33');
INSERT INTO `category` VALUES (6, '职场经验', '2025-12-30 20:57:33');
INSERT INTO `category` VALUES (7, '读书分享', '2025-12-30 20:57:33');
INSERT INTO `category` VALUES (8, '影视游戏', '2025-12-30 20:57:33');
INSERT INTO `category` VALUES (9, '美食探店', '2025-12-30 20:57:33');
INSERT INTO `category` VALUES (10, '旅行见闻', '2025-12-30 20:57:33');

-- ----------------------------
-- Table structure for file
-- ----------------------------
DROP TABLE IF EXISTS `file`;
CREATE TABLE `file`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint NULL DEFAULT NULL,
  `article_id` bigint NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  INDEX `article_id`(`article_id` ASC) USING BTREE,
  CONSTRAINT `file_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `file_ibfk_2` FOREIGN KEY (`article_id`) REFERENCES `article` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 74 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of file
-- ----------------------------
INSERT INTO `file` VALUES (38, 'https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/67fa0760-a2fa-4c0b-8790-02757b3b82b9.jpg', 'AVATAR', 24, NULL, '2026-01-05 09:08:35');
INSERT INTO `file` VALUES (40, 'https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/2359a402-e768-442a-9012-b69b9664500a.jpg', 'AVATAR', 25, NULL, '2026-01-05 09:10:50');
INSERT INTO `file` VALUES (41, 'https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/ARTICLE/dfa4d81e-8b11-48a9-9308-0bdeddfd4984.jpg', 'ARTICLE', 25, 26, '2026-01-05 09:26:58');
INSERT INTO `file` VALUES (42, 'https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/ARTICLE/dee231e7-2a59-4313-9b75-ab0c4bf97df6.webp', 'ARTICLE', 25, 27, '2026-01-05 09:29:12');
INSERT INTO `file` VALUES (43, 'https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/ARTICLE/cac390b1-f0ab-454b-8b39-28d6d0f57ecf.png', 'ARTICLE', 24, 28, '2026-01-05 09:36:25');
INSERT INTO `file` VALUES (44, 'https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/ARTICLE/41614ff3-3e13-4104-9fe7-f73d3aaba923.jpg', 'ARTICLE', 24, 29, '2026-01-05 09:38:29');
INSERT INTO `file` VALUES (46, 'https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/97b82dd5-2a35-4e8c-8f2a-3cce9a1b5466.jpg', 'AVATAR', 26, NULL, '2026-01-05 09:40:05');
INSERT INTO `file` VALUES (47, 'https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/ARTICLE/818a2ce2-01cf-4295-a717-fcf872902f9f.jpg', 'ARTICLE', 26, 30, '2026-01-05 09:40:57');
INSERT INTO `file` VALUES (49, 'https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/0bdd07a0-b54d-413e-a975-6f00c6759f68.jpg', 'AVATAR', 27, NULL, '2026-01-05 09:44:33');
INSERT INTO `file` VALUES (50, 'https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/ARTICLE/67df0a99-a4a9-4b89-8951-85b0e13a1f5d.png', 'ARTICLE', 27, 31, '2026-01-05 09:45:44');
INSERT INTO `file` VALUES (54, 'https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/d075b5e0-2349-46d4-aa70-6deaae9ba4b3.jpg', 'AVATAR', 28, NULL, '2026-01-05 09:49:24');
INSERT INTO `file` VALUES (55, 'https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/ARTICLE/1ca1c7f1-ca8e-447a-adb8-c4201c42fb21.png', 'ARTICLE', 28, 32, '2026-01-05 09:50:39');
INSERT INTO `file` VALUES (56, 'https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/ARTICLE/d173d27a-b4c9-4773-8000-0e431342731b.png', 'ARTICLE', 28, 32, '2026-01-05 09:51:01');
INSERT INTO `file` VALUES (58, 'https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/e4f51478-696f-4865-b720-a2cd26fd2f47.jpg', 'AVATAR', 29, NULL, '2026-01-05 09:53:15');
INSERT INTO `file` VALUES (60, 'https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/f7bba78a-cc6e-40ba-8491-7eb8fa037067.jpg', 'AVATAR', 30, NULL, '2026-01-05 09:55:48');
INSERT INTO `file` VALUES (61, 'https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/ARTICLE/ced2870e-a72f-457d-a77a-b69aa526fcb7.jpg', 'ARTICLE', 30, 34, '2026-01-05 09:56:42');
INSERT INTO `file` VALUES (62, 'https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/ARTICLE/449f60f9-7533-447b-a463-ab638938c79d.jpg', 'ARTICLE', 30, 34, '2026-01-05 09:57:02');
INSERT INTO `file` VALUES (65, 'https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/c7eb242a-72e2-4271-890a-67fa5991f68b.jpg', 'AVATAR', 31, NULL, '2026-01-05 09:59:23');
INSERT INTO `file` VALUES (66, 'https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/ARTICLE/e0bffc1e-5c15-43d2-a1b3-b389be78aad5.jpg', 'ARTICLE', 31, 35, '2026-01-05 10:00:08');
INSERT INTO `file` VALUES (67, 'https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/ARTICLE/a1bbd168-a29a-418b-86d3-876e5244e108.webp', 'ARTICLE', 25, 36, '2026-01-05 10:02:07');
INSERT INTO `file` VALUES (68, 'https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/ARTICLE/6b5ac637-19eb-431b-a93b-35649abaf321.jpg', 'ARTICLE', 29, 37, '2026-01-05 10:03:46');
INSERT INTO `file` VALUES (69, 'https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/ARTICLE/7d05168b-2898-452d-8697-a5382050150c.jpg', 'ARTICLE', 24, 38, '2026-01-05 10:05:14');
INSERT INTO `file` VALUES (70, 'https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/ARTICLE/af1ba12d-f39f-42f4-b6ba-22a31bd1f4e5.webp', 'ARTICLE', 26, 39, '2026-01-05 10:06:52');
INSERT INTO `file` VALUES (71, 'https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/ARTICLE/2321a257-817a-4cb4-ac48-dacc3812fd35.jpg', 'ARTICLE', 26, 39, '2026-01-05 10:07:14');
INSERT INTO `file` VALUES (72, 'https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/ARTICLE/9c012105-ada7-4bf2-a4a7-959a38f7d8b6.jpg', 'ARTICLE', 27, 40, '2026-01-05 10:09:35');
INSERT INTO `file` VALUES (73, 'https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/ARTICLE/06f44795-88d4-4a58-b1b9-d65c0e009ae2.jpeg', 'ARTICLE', 24, 38, '2026-01-05 20:58:16');

-- ----------------------------
-- Table structure for operate_log
-- ----------------------------
DROP TABLE IF EXISTS `operate_log`;
CREATE TABLE `operate_log`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `operate_user` int NULL DEFAULT NULL COMMENT '操作人ID',
  `operate_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作的类名',
  `method_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作的方法名',
  `method_params` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '方法参数',
  `return_value` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '返回值',
  `cost_time` bigint NULL DEFAULT NULL COMMENT '操作耗时(毫秒)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of operate_log
-- ----------------------------
INSERT INTO `operate_log` VALUES (1, 23, '2026-01-05 08:43:33', 'com.blog.controller.ArticleController', 'deleteArticle', '[24, org.apache.catalina.connector.RequestFacade@bf21207]', '{\"code\":200,\"data\":true,\"msg\":\"操作成功\"}', 478);
INSERT INTO `operate_log` VALUES (2, 23, '2026-01-05 08:44:03', 'com.blog.controller.UserController', 'logout', '[org.apache.catalina.connector.RequestFacade@bf21207]', '{\"code\":200,\"data\":true,\"msg\":\"操作成功\"}', 139);
INSERT INTO `operate_log` VALUES (3, 0, '2026-01-05 08:44:17', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=江晏, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/5f0ae908-da7a-4758-93f5-1eb532cafc71.jpg\",\"createTime\":1767439031000,\"id\":22,\"updateTime\":1767439031000,\"username\":\"江晏\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyMiIsImlhdCI6MTc2NzU3Mzg1NywiZXhwIjoxNzY3NjYwMjU3fQ.-rQv3pTfvc8jDDeURnoaEPnJ8jMLkGF29gJoH-7KdtA\"},\"msg\":\"操作成功\"}', 135);
INSERT INTO `operate_log` VALUES (4, 22, '2026-01-05 08:44:21', 'com.blog.controller.UserController', 'logout', '[org.apache.catalina.connector.RequestFacade@bf21207]', '{\"code\":200,\"data\":true,\"msg\":\"操作成功\"}', 64);
INSERT INTO `operate_log` VALUES (5, 0, '2026-01-05 09:08:35', 'com.blog.controller.UserController', 'register', '[RegisterRequest(username=cmy, password=cmy260401, avatar=https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/67fa0760-a2fa-4c0b-8790-02757b3b82b9.jpg)]', '{\"code\":200,\"data\":true,\"msg\":\"操作成功\"}', 148);
INSERT INTO `operate_log` VALUES (6, 0, '2026-01-05 09:08:38', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=cmy, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/67fa0760-a2fa-4c0b-8790-02757b3b82b9.jpg\",\"createTime\":1767575315000,\"id\":24,\"updateTime\":1767575315000,\"username\":\"cmy\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyNCIsImlhdCI6MTc2NzU3NTMxNywiZXhwIjoxNzY3NjYxNzE3fQ.GJiLzw3oRSzRT6-eQ5EA3F12p7s6_ivCanP-Lmfe9co\"},\"msg\":\"操作成功\"}', 118);
INSERT INTO `operate_log` VALUES (7, 0, '2026-01-05 09:10:50', 'com.blog.controller.UserController', 'register', '[RegisterRequest(username=小乐学编程, password=cmy260401, avatar=https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/2359a402-e768-442a-9012-b69b9664500a.jpg)]', '{\"code\":200,\"data\":true,\"msg\":\"操作成功\"}', 147);
INSERT INTO `operate_log` VALUES (8, 0, '2026-01-05 09:10:54', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=小乐学编程, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/2359a402-e768-442a-9012-b69b9664500a.jpg\",\"createTime\":1767575450000,\"id\":25,\"updateTime\":1767575450000,\"username\":\"小乐学编程\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyNSIsImlhdCI6MTc2NzU3NTQ1NCwiZXhwIjoxNzY3NjYxODU0fQ.KD18S-zxe_zbDwdZd3K8zudGjmZF8lNQ-lUoCz3KGWI\"},\"msg\":\"操作成功\"}', 133);
INSERT INTO `operate_log` VALUES (9, 25, '2026-01-05 09:26:56', 'com.blog.controller.ArticleController', 'createArticle', '[ArticleRequest(id=null, title=Java中ArrayList和LinkedList的性能对比分析, content=在Java开发中，ArrayList和LinkedList作为常用集合类，底层分别基于数组和双向链表实现，这直接导致二者在增删改查操作中的性能差异。本文通过实际测试案例，分析遍历、插入、删除等场景下的性能表现，总结出ArrayList适合随机访问、LinkedList适合频繁增删的适用场景，同时分享了项目中选择集合类的实战判断技巧。, categoryId=4, tagIds=[6, 9, 10]), org.apache.catalina.connector.RequestFacade@39af8e3d]', '{\"code\":200,\"data\":26,\"msg\":\"操作成功\"}', 38);
INSERT INTO `operate_log` VALUES (10, 25, '2026-01-05 09:26:58', 'com.blog.controller.ArticleController', 'updateArticle', '[ArticleRequest(id=26, title=Java中ArrayList和LinkedList的性能对比分析, content=在Java开发中，ArrayList和LinkedList作为常用集合类，底层分别基于数组和双向链表实现，这直接导致二者在增删改查操作中的性能差异。本文通过实际测试案例，分析遍历、插入、删除等场景下的性能表现，总结出ArrayList适合随机访问、LinkedList适合频繁增删的适用场景，同时分享了项目中选择集合类的实战判断技巧。\n![图片](/oss/blog/ARTICLE/dfa4d81e-8b11-48a9-9308-0bdeddfd4984.jpg)\n, categoryId=4, tagIds=[6, 9, 10]), org.apache.catalina.connector.RequestFacade@39af8e3d]', '{\"code\":200,\"data\":true,\"msg\":\"操作成功\"}', 15);
INSERT INTO `operate_log` VALUES (11, 25, '2026-01-05 09:29:11', 'com.blog.controller.ArticleController', 'createArticle', '[ArticleRequest(id=null, title=Vue3组合式API的实战使用技巧, content=Vue3的组合式API相比选项式API，在代码组织和复用性上实现了质的提升。本文从setup语法糖、ref与reactive的响应式区别、生命周期钩子的替换方式入手，结合电商首页开发案例，讲解组合式API在组件封装、状态管理中的实际应用，帮助前端开发者快速上手Vue3项目。, categoryId=4, tagIds=[7, 8]), org.apache.catalina.connector.RequestFacade@328d43]', '{\"code\":200,\"data\":27,\"msg\":\"操作成功\"}', 18);
INSERT INTO `operate_log` VALUES (12, 25, '2026-01-05 09:29:12', 'com.blog.controller.ArticleController', 'updateArticle', '[ArticleRequest(id=27, title=Vue3组合式API的实战使用技巧, content=Vue3的组合式API相比选项式API，在代码组织和复用性上实现了质的提升。本文从setup语法糖、ref与reactive的响应式区别、生命周期钩子的替换方式入手，结合电商首页开发案例，讲解组合式API在组件封装、状态管理中的实际应用，帮助前端开发者快速上手Vue3项目。\n![图片](/oss/blog/ARTICLE/dee231e7-2a59-4313-9b75-ab0c4bf97df6.webp)\n, categoryId=4, tagIds=[7, 8]), org.apache.catalina.connector.RequestFacade@328d43]', '{\"code\":200,\"data\":true,\"msg\":\"操作成功\"}', 13);
INSERT INTO `operate_log` VALUES (13, 0, '2026-01-05 09:29:41', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=cmy, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/67fa0760-a2fa-4c0b-8790-02757b3b82b9.jpg\",\"createTime\":1767575315000,\"id\":24,\"updateTime\":1767575315000,\"username\":\"cmy\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyNCIsImlhdCI6MTc2NzU3NjU4MCwiZXhwIjoxNzY3NjYyOTgwfQ.nu1pIdZ67HuvXrKR4fmmA-p0rAr4gXsMDQfwL2j6XX8\"},\"msg\":\"操作成功\"}', 116);
INSERT INTO `operate_log` VALUES (14, 24, '2026-01-05 09:36:24', 'com.blog.controller.ArticleController', 'createArticle', '[ArticleRequest(id=null, title=独居生活的小确幸，把出租屋变成温馨小家, content=毕业后来到陌生城市独居，从最初的手忙脚乱到如今把出租屋打理得井井有条，我总结了不少实用技巧：用平价的ins风软装打造温馨角落，利用抽屉分隔盒解决收纳难题，搭配一人食的简易菜谱让三餐有滋有味，独居生活也能充满烟火气和幸福感。, categoryId=5, tagIds=[19, 11]), org.apache.catalina.connector.RequestFacade@4803dea1]', '{\"code\":200,\"data\":28,\"msg\":\"操作成功\"}', 17);
INSERT INTO `operate_log` VALUES (15, 24, '2026-01-05 09:36:25', 'com.blog.controller.ArticleController', 'updateArticle', '[ArticleRequest(id=28, title=独居生活的小确幸，把出租屋变成温馨小家, content=毕业后来到陌生城市独居，从最初的手忙脚乱到如今把出租屋打理得井井有条，我总结了不少实用技巧：用平价的ins风软装打造温馨角落，利用抽屉分隔盒解决收纳难题，搭配一人食的简易菜谱让三餐有滋有味，独居生活也能充满烟火气和幸福感。\n![图片](/oss/blog/ARTICLE/cac390b1-f0ab-454b-8b39-28d6d0f57ecf.png)\n, categoryId=5, tagIds=[19, 11]), org.apache.catalina.connector.RequestFacade@4803dea1]', '{\"code\":200,\"data\":true,\"msg\":\"操作成功\"}', 14);
INSERT INTO `operate_log` VALUES (16, 24, '2026-01-05 09:38:27', 'com.blog.controller.ArticleController', 'createArticle', '[ArticleRequest(id=null, title=家常菜教程，超下饭的番茄牛腩做法, content=番茄牛腩是一道老少皆宜的家常菜，做法简单却美味十足。先将牛腩冷水焯水去血沫，用冰糖炒出糖色后翻炒牛腩，加开水炖至软烂，最后放入番茄炖煮收汁，酸甜浓郁的汤汁拌米饭，一次能吃两大碗。文中还分享了用高压锅缩短炖煮时间、加番茄酱提升风味的小窍门。, categoryId=9, tagIds=[15, 11]), org.apache.catalina.connector.RequestFacade@bf21207]', '{\"code\":200,\"data\":29,\"msg\":\"操作成功\"}', 18);
INSERT INTO `operate_log` VALUES (17, 24, '2026-01-05 09:38:29', 'com.blog.controller.ArticleController', 'updateArticle', '[ArticleRequest(id=29, title=家常菜教程，超下饭的番茄牛腩做法, content=番茄牛腩是一道老少皆宜的家常菜，做法简单却美味十足。先将牛腩冷水焯水去血沫，用冰糖炒出糖色后翻炒牛腩，加开水炖至软烂，最后放入番茄炖煮收汁，酸甜浓郁的汤汁拌米饭，一次能吃两大碗。文中还分享了用高压锅缩短炖煮时间、加番茄酱提升风味的小窍门。\n![图片](/oss/blog/ARTICLE/41614ff3-3e13-4104-9fe7-f73d3aaba923.jpg)\n, categoryId=9, tagIds=[15, 11]), org.apache.catalina.connector.RequestFacade@bf21207]', '{\"code\":200,\"data\":true,\"msg\":\"操作成功\"}', 17);
INSERT INTO `operate_log` VALUES (18, 0, '2026-01-05 09:40:05', 'com.blog.controller.UserController', 'register', '[RegisterRequest(username=游戏补给站, password=cmy260401, avatar=https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/97b82dd5-2a35-4e8c-8f2a-3cce9a1b5466.jpg)]', '{\"code\":200,\"data\":true,\"msg\":\"操作成功\"}', 151);
INSERT INTO `operate_log` VALUES (19, 0, '2026-01-05 09:40:08', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=游戏补给站, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/97b82dd5-2a35-4e8c-8f2a-3cce9a1b5466.jpg\",\"createTime\":1767577205000,\"id\":26,\"updateTime\":1767577205000,\"username\":\"游戏补给站\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyNiIsImlhdCI6MTc2NzU3NzIwOCwiZXhwIjoxNzY3NjYzNjA4fQ.QtMEpS8LrK1kkuuVIs5Bg2WaTX8EtFXwhllqIzi38xA\"},\"msg\":\"操作成功\"}', 121);
INSERT INTO `operate_log` VALUES (20, 26, '2026-01-05 09:40:54', 'com.blog.controller.ArticleController', 'createArticle', '[ArticleRequest(id=null, title=LOL手游新赛季上分技巧，辅助位的游走思路, content=LOL手游新赛季更新后，辅助位的玩法迎来不少变化。本文针对软辅（娜美、娑娜）和硬辅（锤石、布隆）的特点，讲解对线期的消耗技巧、游走的时机选择（如打野刷野间隙、中路推线时），以及团战中的保护和开团思路，帮助辅助玩家轻松冲上钻石段位。, categoryId=8, tagIds=[17, 18]), org.apache.catalina.connector.RequestFacade@39af8e3d]', '{\"code\":200,\"data\":30,\"msg\":\"操作成功\"}', 13);
INSERT INTO `operate_log` VALUES (21, 26, '2026-01-05 09:40:57', 'com.blog.controller.ArticleController', 'updateArticle', '[ArticleRequest(id=30, title=LOL手游新赛季上分技巧，辅助位的游走思路, content=LOL手游新赛季更新后，辅助位的玩法迎来不少变化。本文针对软辅（娜美、娑娜）和硬辅（锤石、布隆）的特点，讲解对线期的消耗技巧、游走的时机选择（如打野刷野间隙、中路推线时），以及团战中的保护和开团思路，帮助辅助玩家轻松冲上钻石段位。\n![图片](/oss/blog/ARTICLE/818a2ce2-01cf-4295-a717-fcf872902f9f.jpg)\n, categoryId=8, tagIds=[17, 18]), org.apache.catalina.connector.RequestFacade@39af8e3d]', '{\"code\":200,\"data\":true,\"msg\":\"操作成功\"}', 8);
INSERT INTO `operate_log` VALUES (22, 0, '2026-01-05 09:44:32', 'com.blog.controller.UserController', 'register', '[RegisterRequest(username=阿南逛吃记, password=cmy260401, avatar=https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/0bdd07a0-b54d-413e-a975-6f00c6759f68.jpg)]', '{\"code\":200,\"data\":true,\"msg\":\"操作成功\"}', 132);
INSERT INTO `operate_log` VALUES (23, 0, '2026-01-05 09:44:35', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=阿南逛吃记, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/0bdd07a0-b54d-413e-a975-6f00c6759f68.jpg\",\"createTime\":1767577473000,\"id\":27,\"updateTime\":1767577473000,\"username\":\"阿南逛吃记\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyNyIsImlhdCI6MTc2NzU3NzQ3NSwiZXhwIjoxNzY3NjYzODc1fQ.ljvCUtaDA484IOkz7jDEs_GA90fNS0z46O0tGFJgpcY\"},\"msg\":\"操作成功\"}', 113);
INSERT INTO `operate_log` VALUES (24, 27, '2026-01-05 09:45:42', 'com.blog.controller.ArticleController', 'createArticle', '[ArticleRequest(id=null, title=城市探店记，藏在老巷子里的宝藏咖啡馆, content=周末闲逛老城区，在一条深巷里发现了一家小众手冲咖啡馆。店内是复古原木装修，老板会根据顾客口味推荐咖啡豆，我尝试了埃塞俄比亚的耶加雪菲，果酸清新、回甘悠长，搭配一块海盐巴斯克蛋糕，在慵懒的午后度过了惬意的时光，也感受到了老城区独有的慢节奏。, categoryId=9, tagIds=[12, 22]), org.apache.catalina.connector.RequestFacade@bf21207]', '{\"code\":200,\"data\":31,\"msg\":\"操作成功\"}', 17);
INSERT INTO `operate_log` VALUES (25, 27, '2026-01-05 09:45:44', 'com.blog.controller.ArticleController', 'updateArticle', '[ArticleRequest(id=31, title=城市探店记，藏在老巷子里的宝藏咖啡馆, content=周末闲逛老城区，在一条深巷里发现了一家小众手冲咖啡馆。店内是复古原木装修，老板会根据顾客口味推荐咖啡豆，我尝试了埃塞俄比亚的耶加雪菲，果酸清新、回甘悠长，搭配一块海盐巴斯克蛋糕，在慵懒的午后度过了惬意的时光，也感受到了老城区独有的慢节奏。\n![图片](/oss/blog/ARTICLE/67df0a99-a4a9-4b89-8951-85b0e13a1f5d.png)\n, categoryId=9, tagIds=[12, 22]), org.apache.catalina.connector.RequestFacade@bf21207]', '{\"code\":200,\"data\":true,\"msg\":\"操作成功\"}', 12);
INSERT INTO `operate_log` VALUES (26, 0, '2026-01-05 09:49:24', 'com.blog.controller.UserController', 'register', '[RegisterRequest(username=海阔天空, password=cmy260401, avatar=https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/d075b5e0-2349-46d4-aa70-6deaae9ba4b3.jpg)]', '{\"code\":200,\"data\":true,\"msg\":\"操作成功\"}', 141);
INSERT INTO `operate_log` VALUES (27, 0, '2026-01-05 09:49:27', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=海阔天空, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/d075b5e0-2349-46d4-aa70-6deaae9ba4b3.jpg\",\"createTime\":1767577764000,\"id\":28,\"updateTime\":1767577764000,\"username\":\"海阔天空\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyOCIsImlhdCI6MTc2NzU3Nzc2NywiZXhwIjoxNzY3NjY0MTY3fQ.tQxBIncZ6szQ5MmMvpFAgjmn9jiRlJNxq9eqQH1o3xc\"},\"msg\":\"操作成功\"}', 122);
INSERT INTO `operate_log` VALUES (28, 28, '2026-01-05 09:50:34', 'com.blog.controller.ArticleController', 'createArticle', '[ArticleRequest(id=null, title=5本提升认知的好书，读完刷新思维方式, content=这半年读完的书中，有5本彻底改变了我的思维方式：《认知觉醒》理清了学习的底层逻辑，《置身事内》让我看懂中国经济的运行规律，《蛤蟆先生去看心理医生》教会我与自己和解，《穷查理宝典》和《原则》则提供了多元的思考框架，每一本都值得反复品读。, categoryId=7, tagIds=[14, 11]), org.apache.catalina.connector.RequestFacade@bf21207]', '{\"code\":200,\"data\":32,\"msg\":\"操作成功\"}', 17);
INSERT INTO `operate_log` VALUES (29, 28, '2026-01-05 09:51:24', 'com.blog.controller.ArticleController', 'updateArticle', '[ArticleRequest(id=32, title=5本提升认知的好书，读完刷新思维方式, content=这半年读完的书中，有5本彻底改变了我的思维方式：《认知觉醒》理清了学习的底层逻辑，《置身事内》让我看懂中国经济的运行规律，《蛤蟆先生去看心理医生》教会我与自己和解，《穷查理宝典》和《原则》则提供了多元的思考框架，每一本都值得反复品读。\n![图片](/oss/blog/ARTICLE/d173d27a-b4c9-4773-8000-0e431342731b.png)\n, categoryId=7, tagIds=[14, 11]), org.apache.catalina.connector.RequestFacade@39af8e3d]', '{\"code\":200,\"data\":true,\"msg\":\"操作成功\"}', 14);
INSERT INTO `operate_log` VALUES (30, 0, '2026-01-05 09:53:15', 'com.blog.controller.UserController', 'register', '[RegisterRequest(username=职场小tip, password=cmy260401, avatar=https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/e4f51478-696f-4865-b720-a2cd26fd2f47.jpg)]', '{\"code\":200,\"data\":true,\"msg\":\"操作成功\"}', 141);
INSERT INTO `operate_log` VALUES (31, 0, '2026-01-05 09:53:18', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=职场小tip, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/e4f51478-696f-4865-b720-a2cd26fd2f47.jpg\",\"createTime\":1767577995000,\"id\":29,\"updateTime\":1767577995000,\"username\":\"职场小tip\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyOSIsImlhdCI6MTc2NzU3Nzk5NywiZXhwIjoxNzY3NjY0Mzk3fQ.YuGbF07QgZC0DOynEinuyHC4lc6EaekS_0F3eVXeHjY\"},\"msg\":\"操作成功\"}', 114);
INSERT INTO `operate_log` VALUES (32, 29, '2026-01-05 09:54:20', 'com.blog.controller.ArticleController', 'createArticle', '[ArticleRequest(id=null, title=职场副业新思路，利用技术做接单小项目, content=程序员想通过副业增加收入，接单做小项目是不错的选择。本文分享在猪八戒网、程序员客栈等平台接单的技巧，从简单的企业官网开发、微信小程序定制入手，讲解项目报价、需求沟通和交付验收的注意事项，让你利用业余时间实现技术变现。, categoryId=6, tagIds=[20]), org.apache.catalina.connector.RequestFacade@328d43]', '{\"code\":200,\"data\":33,\"msg\":\"操作成功\"}', 17);
INSERT INTO `operate_log` VALUES (33, 0, '2026-01-05 09:55:47', 'com.blog.controller.UserController', 'register', '[RegisterRequest(username=定格晨昏, password=cmy260401, avatar=https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/f7bba78a-cc6e-40ba-8491-7eb8fa037067.jpg)]', '{\"code\":200,\"data\":true,\"msg\":\"操作成功\"}', 143);
INSERT INTO `operate_log` VALUES (34, 0, '2026-01-05 09:55:50', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=定格晨昏, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/f7bba78a-cc6e-40ba-8491-7eb8fa037067.jpg\",\"createTime\":1767578148000,\"id\":30,\"updateTime\":1767578148000,\"username\":\"定格晨昏\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzMCIsImlhdCI6MTc2NzU3ODE1MCwiZXhwIjoxNzY3NjY0NTUwfQ.xcU5117Po07sxXVFYw6WKPB1_RznDA4u0LQIGLc-dSo\"},\"msg\":\"操作成功\"}', 118);
INSERT INTO `operate_log` VALUES (35, 30, '2026-01-05 09:56:34', 'com.blog.controller.ArticleController', 'createArticle', '[ArticleRequest(id=null, title=新手摄影技巧，用手机拍出氛围感街拍, content=不用单反，手机也能拍出好看的街拍。本文分享几个实用技巧：利用清晨或傍晚的黄金光线拍摄，采用三分构图法突出主体，通过抓拍捕捉街头的自然瞬间，还推荐了醒图、Snapseed等修图APP的调色参数，让新手也能轻松拍出氛围感街拍作品。, categoryId=5, tagIds=[11, 23]), org.apache.catalina.connector.RequestFacade@bf21207]', '{\"code\":200,\"data\":34,\"msg\":\"操作成功\"}', 14);
INSERT INTO `operate_log` VALUES (36, 30, '2026-01-05 09:57:08', 'com.blog.controller.ArticleController', 'updateArticle', '[ArticleRequest(id=34, title=新手摄影技巧，用手机拍出氛围感街拍, content=不用单反，手机也能拍出好看的街拍。本文分享几个实用技巧：利用清晨或傍晚的黄金光线拍摄，采用三分构图法突出主体，通过抓拍捕捉街头的自然瞬间，还推荐了醒图、Snapseed等修图APP的调色参数，让新手也能轻松拍出氛围感街拍作品。\n![图片](/oss/blog/ARTICLE/449f60f9-7533-447b-a463-ab638938c79d.jpg)\n, categoryId=5, tagIds=[11, 23]), org.apache.catalina.connector.RequestFacade@586062d5]', '{\"code\":200,\"data\":true,\"msg\":\"操作成功\"}', 12);
INSERT INTO `operate_log` VALUES (37, 0, '2026-01-05 09:59:23', 'com.blog.controller.UserController', 'register', '[RegisterRequest(username=lucky, password=cmy260401, avatar=https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/c7eb242a-72e2-4271-890a-67fa5991f68b.jpg)]', '{\"code\":200,\"data\":true,\"msg\":\"操作成功\"}', 136);
INSERT INTO `operate_log` VALUES (38, 0, '2026-01-05 09:59:25', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=lucky, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/c7eb242a-72e2-4271-890a-67fa5991f68b.jpg\",\"createTime\":1767578363000,\"id\":31,\"updateTime\":1767578363000,\"username\":\"lucky\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzMSIsImlhdCI6MTc2NzU3ODM2NSwiZXhwIjoxNzY3NjY0NzY1fQ.nUQNhJbLD3n_JRUsMQ8A2c2lx-7VJ1Z2kistlkyuc-4\"},\"msg\":\"操作成功\"}', 116);
INSERT INTO `operate_log` VALUES (39, 31, '2026-01-05 10:00:07', 'com.blog.controller.ArticleController', 'createArticle', '[ArticleRequest(id=null, title=居家绿植养护指南，新手也能养活的6种绿植, content=想给家里添生机又怕养死绿植？这6种绿植特别适合新手：绿萝好养活还能净化空气，龟背竹颜值高且耐阴，多肉、吊兰、虎皮兰耐旱易打理，琴叶榕则是居家软装的好搭档。本文详细讲解每种绿植的浇水、光照和施肥技巧，让你的绿植茁壮成长。, categoryId=5, tagIds=[25, 11]), org.apache.catalina.connector.RequestFacade@586062d5]', '{\"code\":200,\"data\":35,\"msg\":\"操作成功\"}', 12);
INSERT INTO `operate_log` VALUES (40, 31, '2026-01-05 10:00:08', 'com.blog.controller.ArticleController', 'updateArticle', '[ArticleRequest(id=35, title=居家绿植养护指南，新手也能养活的6种绿植, content=想给家里添生机又怕养死绿植？这6种绿植特别适合新手：绿萝好养活还能净化空气，龟背竹颜值高且耐阴，多肉、吊兰、虎皮兰耐旱易打理，琴叶榕则是居家软装的好搭档。本文详细讲解每种绿植的浇水、光照和施肥技巧，让你的绿植茁壮成长。\n![图片](/oss/blog/ARTICLE/e0bffc1e-5c15-43d2-a1b3-b389be78aad5.jpg)\n, categoryId=5, tagIds=[25, 11]), org.apache.catalina.connector.RequestFacade@586062d5]', '{\"code\":200,\"data\":true,\"msg\":\"操作成功\"}', 14);
INSERT INTO `operate_log` VALUES (41, 0, '2026-01-05 10:01:23', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=小乐学编程, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/2359a402-e768-442a-9012-b69b9664500a.jpg\",\"createTime\":1767575450000,\"id\":25,\"updateTime\":1767575450000,\"username\":\"小乐学编程\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyNSIsImlhdCI6MTc2NzU3ODQ4MiwiZXhwIjoxNzY3NjY0ODgyfQ.D2ayfYa6Tgvov7Bz4suqLtvKOlrMyJxpFuHg4IvlNxw\"},\"msg\":\"操作成功\"}', 121);
INSERT INTO `operate_log` VALUES (42, 25, '2026-01-05 10:02:05', 'com.blog.controller.ArticleController', 'createArticle', '[ArticleRequest(id=null, title=前端工程化之Git提交规范的落地实践, content=良好的Git提交规范能大幅提升团队协作效率，本文分享在前端项目中落地Conventional Commits规范的全过程：通过husky配置提交钩子，结合commitlint实现提交信息校验，搭配cz-git打造交互式提交流程，让团队的版本管理更规范、提交记录更具可读性。, categoryId=4, tagIds=[8, 9]), org.apache.catalina.connector.RequestFacade@586062d5]', '{\"code\":200,\"data\":36,\"msg\":\"操作成功\"}', 16);
INSERT INTO `operate_log` VALUES (43, 25, '2026-01-05 10:02:07', 'com.blog.controller.ArticleController', 'updateArticle', '[ArticleRequest(id=36, title=前端工程化之Git提交规范的落地实践, content=良好的Git提交规范能大幅提升团队协作效率，本文分享在前端项目中落地Conventional Commits规范的全过程：通过husky配置提交钩子，结合commitlint实现提交信息校验，搭配cz-git打造交互式提交流程，让团队的版本管理更规范、提交记录更具可读性。\n![图片](/oss/blog/ARTICLE/a1bbd168-a29a-418b-86d3-876e5244e108.webp)\n, categoryId=4, tagIds=[8, 9]), org.apache.catalina.connector.RequestFacade@586062d5]', '{\"code\":200,\"data\":true,\"msg\":\"操作成功\"}', 11);
INSERT INTO `operate_log` VALUES (44, 0, '2026-01-05 10:02:52', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=职场小tip, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/e4f51478-696f-4865-b720-a2cd26fd2f47.jpg\",\"createTime\":1767577995000,\"id\":29,\"updateTime\":1767577995000,\"username\":\"职场小tip\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyOSIsImlhdCI6MTc2NzU3ODU3MiwiZXhwIjoxNzY3NjY0OTcyfQ.ov1IikaA3wa-gZka315lxv3myBFHlJI75C2HnLLl4I8\"},\"msg\":\"操作成功\"}', 122);
INSERT INTO `operate_log` VALUES (45, 29, '2026-01-05 10:03:44', 'com.blog.controller.ArticleController', 'createArticle', '[ArticleRequest(id=null, title=职场面试的STAR法则，让你的回答更有逻辑, content=面试中如何清晰讲述项目经历？STAR法则是核心技巧。S（情境）说明项目背景，T（任务）明确个人职责，A（行动）描述解决问题的方法，R（结果）展示工作成果。本文结合技术岗面试案例，拆解STAR法则在项目描述、问题解决等场景的使用细节，帮你在面试中脱颖而出。, categoryId=6, tagIds=[13, 20]), org.apache.catalina.connector.RequestFacade@bf21207]', '{\"code\":200,\"data\":37,\"msg\":\"操作成功\"}', 13);
INSERT INTO `operate_log` VALUES (46, 29, '2026-01-05 10:03:46', 'com.blog.controller.ArticleController', 'updateArticle', '[ArticleRequest(id=37, title=职场面试的STAR法则，让你的回答更有逻辑, content=面试中如何清晰讲述项目经历？STAR法则是核心技巧。S（情境）说明项目背景，T（任务）明确个人职责，A（行动）描述解决问题的方法，R（结果）展示工作成果。本文结合技术岗面试案例，拆解STAR法则在项目描述、问题解决等场景的使用细节，帮你在面试中脱颖而出。\n![图片](/oss/blog/ARTICLE/6b5ac637-19eb-431b-a93b-35649abaf321.jpg)\n, categoryId=6, tagIds=[13, 20]), org.apache.catalina.connector.RequestFacade@bf21207]', '{\"code\":200,\"data\":true,\"msg\":\"操作成功\"}', 12);
INSERT INTO `operate_log` VALUES (47, 0, '2026-01-05 10:04:37', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=cmy, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/67fa0760-a2fa-4c0b-8790-02757b3b82b9.jpg\",\"createTime\":1767575315000,\"id\":24,\"updateTime\":1767575315000,\"username\":\"cmy\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyNCIsImlhdCI6MTc2NzU3ODY3NiwiZXhwIjoxNzY3NjY1MDc2fQ.gSHgEl2K14LP5rhlkgBfugA1Sfr9PDSmXzVsC_kJBsE\"},\"msg\":\"操作成功\"}', 116);
INSERT INTO `operate_log` VALUES (48, 24, '2026-01-05 10:05:13', 'com.blog.controller.ArticleController', 'createArticle', '[ArticleRequest(id=null, title=2025年必追的5部高分剧，剧情反转停不下来, content=年末盘点，这5部高分剧让我熬夜追完：悬疑剧《隐秘的角落2》延续前作的烧脑风格，职场剧《前途》真实还原互联网行业的生存现状，古装剧《长安三万里》的服化道和剧情双在线，科幻剧《星际边界》的世界观设定新颖，温情剧《人间小事》则用细节治愈人心。, categoryId=8, tagIds=[16]), org.apache.catalina.connector.RequestFacade@bf21207]', '{\"code\":200,\"data\":38,\"msg\":\"操作成功\"}', 13);
INSERT INTO `operate_log` VALUES (49, 24, '2026-01-05 10:05:14', 'com.blog.controller.ArticleController', 'updateArticle', '[ArticleRequest(id=38, title=2025年必追的5部高分剧，剧情反转停不下来, content=年末盘点，这5部高分剧让我熬夜追完：悬疑剧《隐秘的角落2》延续前作的烧脑风格，职场剧《前途》真实还原互联网行业的生存现状，古装剧《长安三万里》的服化道和剧情双在线，科幻剧《星际边界》的世界观设定新颖，温情剧《人间小事》则用细节治愈人心。\n![图片](/oss/blog/ARTICLE/7d05168b-2898-452d-8697-a5382050150c.jpg)\n, categoryId=8, tagIds=[16]), org.apache.catalina.connector.RequestFacade@bf21207]', '{\"code\":200,\"data\":true,\"msg\":\"操作成功\"}', 10);
INSERT INTO `operate_log` VALUES (50, 0, '2026-01-05 10:05:53', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=游戏补给站, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/97b82dd5-2a35-4e8c-8f2a-3cce9a1b5466.jpg\",\"createTime\":1767577205000,\"id\":26,\"updateTime\":1767577205000,\"username\":\"游戏补给站\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyNiIsImlhdCI6MTc2NzU3ODc1MiwiZXhwIjoxNzY3NjY1MTUyfQ.wwp00GDYCj3PLDIxpxVSJtf7Iim_Z1FxWICb3HYaIOI\"},\"msg\":\"操作成功\"}', 119);
INSERT INTO `operate_log` VALUES (51, 26, '2026-01-05 10:06:51', 'com.blog.controller.ArticleController', 'createArticle', '[ArticleRequest(id=null, title=原神枫丹版本新角色解析，水神芙宁娜实战攻略, content=原神枫丹版本的核心角色芙宁娜上线后，成为水系队伍的强力核心。本文从天赋机制、圣遗物搭配（如千岩牢固、沉沦之心）、武器选择（静水流涌之辉、祭礼残章）和队伍配队（纯水队、胡行芙钟）四个方面，详细解析芙宁娜的实战玩法，还分享了零命和满命的不同培养思路。, categoryId=8, tagIds=[17, 18]), org.apache.catalina.connector.RequestFacade@4803dea1]', '{\"code\":200,\"data\":39,\"msg\":\"操作成功\"}', 13);
INSERT INTO `operate_log` VALUES (52, 26, '2026-01-05 10:06:52', 'com.blog.controller.ArticleController', 'updateArticle', '[ArticleRequest(id=39, title=原神枫丹版本新角色解析，水神芙宁娜实战攻略, content=原神枫丹版本的核心角色芙宁娜上线后，成为水系队伍的强力核心。本文从天赋机制、圣遗物搭配（如千岩牢固、沉沦之心）、武器选择（静水流涌之辉、祭礼残章）和队伍配队（纯水队、胡行芙钟）四个方面，详细解析芙宁娜的实战玩法，还分享了零命和满命的不同培养思路。\n![图片](/oss/blog/ARTICLE/af1ba12d-f39f-42f4-b6ba-22a31bd1f4e5.webp)\n, categoryId=8, tagIds=[17, 18]), org.apache.catalina.connector.RequestFacade@4803dea1]', '{\"code\":200,\"data\":true,\"msg\":\"操作成功\"}', 11);
INSERT INTO `operate_log` VALUES (53, 26, '2026-01-05 10:07:27', 'com.blog.controller.ArticleController', 'updateArticle', '[ArticleRequest(id=39, title=原神枫丹版本新角色解析，水神芙宁娜实战攻略, content=原神枫丹版本的核心角色芙宁娜上线后，成为水系队伍的强力核心。本文从天赋机制、圣遗物搭配（如千岩牢固、沉沦之心）、武器选择（静水流涌之辉、祭礼残章）和队伍配队（纯水队、胡行芙钟）四个方面，详细解析芙宁娜的实战玩法，还分享了零命和满命的不同培养思路。\n\n![图片](/oss/blog/ARTICLE/2321a257-817a-4cb4-ac48-dacc3812fd35.jpg)\n, categoryId=8, tagIds=[18, 17]), org.apache.catalina.connector.RequestFacade@4803dea1]', '{\"code\":200,\"data\":true,\"msg\":\"操作成功\"}', 21);
INSERT INTO `operate_log` VALUES (54, 0, '2026-01-05 10:08:25', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=阿南逛吃记, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/0bdd07a0-b54d-413e-a975-6f00c6759f68.jpg\",\"createTime\":1767577473000,\"id\":27,\"updateTime\":1767577473000,\"username\":\"阿南逛吃记\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyNyIsImlhdCI6MTc2NzU3ODkwNSwiZXhwIjoxNzY3NjY1MzA1fQ.udopWcQDYhYop0I7o_S1R8g5Sxt2IP7LFYMp5o7zQT0\"},\"msg\":\"操作成功\"}', 114);
INSERT INTO `operate_log` VALUES (55, 27, '2026-01-05 10:09:33', 'com.blog.controller.ArticleController', 'createArticle', '[ArticleRequest(id=null, title=咖啡入门指南，认识不同种类的咖啡豆, content=刚接触咖啡的人常被各类咖啡豆名称困扰，本文从咖啡豆的产地（埃塞俄比亚、哥伦比亚、巴西）、处理法（水洗、日晒、蜜处理）和风味特点入手，讲解阿拉比卡与罗布斯塔豆的区别，还推荐了适合新手的曼特宁、蓝山咖啡豆，帮你找到自己喜欢的口味。, categoryId=9, tagIds=[22, 12]), org.apache.catalina.connector.RequestFacade@328d43]', '{\"code\":200,\"data\":40,\"msg\":\"操作成功\"}', 12);
INSERT INTO `operate_log` VALUES (56, 27, '2026-01-05 10:09:35', 'com.blog.controller.ArticleController', 'updateArticle', '[ArticleRequest(id=40, title=咖啡入门指南，认识不同种类的咖啡豆, content=刚接触咖啡的人常被各类咖啡豆名称困扰，本文从咖啡豆的产地（埃塞俄比亚、哥伦比亚、巴西）、处理法（水洗、日晒、蜜处理）和风味特点入手，讲解阿拉比卡与罗布斯塔豆的区别，还推荐了适合新手的曼特宁、蓝山咖啡豆，帮你找到自己喜欢的口味。\n![图片](/oss/blog/ARTICLE/9c012105-ada7-4bf2-a4a7-959a38f7d8b6.jpg)\n, categoryId=9, tagIds=[22, 12]), org.apache.catalina.connector.RequestFacade@328d43]', '{\"code\":200,\"data\":true,\"msg\":\"操作成功\"}', 12);
INSERT INTO `operate_log` VALUES (57, 0, '2026-01-05 10:13:42', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=cmy, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/67fa0760-a2fa-4c0b-8790-02757b3b82b9.jpg\",\"createTime\":1767575315000,\"id\":24,\"updateTime\":1767575315000,\"username\":\"cmy\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyNCIsImlhdCI6MTc2NzU3OTIyMSwiZXhwIjoxNzY3NjY1NjIxfQ.VOP3IMw-H7-o9PlIQCm0QsWVhQQQxxOwxwSCjMgwVWU\"},\"msg\":\"操作成功\"}', 118);
INSERT INTO `operate_log` VALUES (58, 0, '2026-01-05 10:14:23', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=阿南逛吃记, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/0bdd07a0-b54d-413e-a975-6f00c6759f68.jpg\",\"createTime\":1767577473000,\"id\":27,\"updateTime\":1767577473000,\"username\":\"阿南逛吃记\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyNyIsImlhdCI6MTc2NzU3OTI2MiwiZXhwIjoxNzY3NjY1NjYyfQ.aFzpf-34-tFLvXNlJR_C8R5X1IHWAgbeDJBLD2MTkwc\"},\"msg\":\"操作成功\"}', 119);
INSERT INTO `operate_log` VALUES (59, 0, '2026-01-05 10:14:46', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=cmy, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/67fa0760-a2fa-4c0b-8790-02757b3b82b9.jpg\",\"createTime\":1767575315000,\"id\":24,\"updateTime\":1767575315000,\"username\":\"cmy\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyNCIsImlhdCI6MTc2NzU3OTI4NiwiZXhwIjoxNzY3NjY1Njg2fQ.PrsTVr8UluA1xSuPq-2P7E2t3YadaXD6FcQfRqyBJaI\"},\"msg\":\"操作成功\"}', 132);
INSERT INTO `operate_log` VALUES (60, 0, '2026-01-05 10:16:21', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=职场小tip, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/e4f51478-696f-4865-b720-a2cd26fd2f47.jpg\",\"createTime\":1767577995000,\"id\":29,\"updateTime\":1767577995000,\"username\":\"职场小tip\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyOSIsImlhdCI6MTc2NzU3OTM4MSwiZXhwIjoxNzY3NjY1NzgxfQ.VW8s1nW4bQnj8NyMxp-PZ7lozMu_QGuEZESmg-Kq2Is\"},\"msg\":\"操作成功\"}', 112);
INSERT INTO `operate_log` VALUES (61, 0, '2026-01-05 10:17:33', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=lucky, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/c7eb242a-72e2-4271-890a-67fa5991f68b.jpg\",\"createTime\":1767578363000,\"id\":31,\"updateTime\":1767578363000,\"username\":\"lucky\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzMSIsImlhdCI6MTc2NzU3OTQ1MywiZXhwIjoxNzY3NjY1ODUzfQ.Z8e7STahNctVQt3LgwgyEb-lPCmCBP3D5GQDJzZLYiE\"},\"msg\":\"操作成功\"}', 120);
INSERT INTO `operate_log` VALUES (62, 0, '2026-01-05 10:46:51', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=cmy, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/67fa0760-a2fa-4c0b-8790-02757b3b82b9.jpg\",\"createTime\":1767575315000,\"id\":24,\"updateTime\":1767575315000,\"username\":\"cmy\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyNCIsImlhdCI6MTc2NzU4MTIxMSwiZXhwIjoxNzY3NjY3NjExfQ.ZAV7iMTQOHoBOxRp85L5hMm-6VDlOU-Ja2pdLBotF8Q\"},\"msg\":\"操作成功\"}', 114);
INSERT INTO `operate_log` VALUES (63, 0, '2026-01-05 11:14:11', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=cmy, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/67fa0760-a2fa-4c0b-8790-02757b3b82b9.jpg\",\"createTime\":1767575315000,\"id\":24,\"updateTime\":1767575315000,\"username\":\"cmy\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyNCIsImlhdCI6MTc2NzU4Mjg1MSwiZXhwIjoxNzY3NjY5MjUxfQ.YlAQbWmFGtK3I8lqdGDMT-WRaH59k5w-DkDvRx9BFhU\"},\"msg\":\"操作成功\"}', 127);
INSERT INTO `operate_log` VALUES (64, 0, '2026-01-05 19:19:15', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=lucky, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/c7eb242a-72e2-4271-890a-67fa5991f68b.jpg\",\"createTime\":1767578363000,\"id\":31,\"updateTime\":1767578363000,\"username\":\"lucky\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzMSIsImlhdCI6MTc2NzYxMTk1NSwiZXhwIjoxNzY3Njk4MzU1fQ.pppr7pfTHFcWnpX35A_GTWzOJGkIlVVbhlZldVCUWoM\"},\"msg\":\"操作成功\"}', 153);
INSERT INTO `operate_log` VALUES (65, 0, '2026-01-05 19:19:23', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=lucky, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/c7eb242a-72e2-4271-890a-67fa5991f68b.jpg\",\"createTime\":1767578363000,\"id\":31,\"updateTime\":1767578363000,\"username\":\"lucky\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzMSIsImlhdCI6MTc2NzYxMTk2MywiZXhwIjoxNzY3Njk4MzYzfQ.Lu56BE34EQQyuoCiY_ddkVFCGUHbeU64LJer3Kq6BhM\"},\"msg\":\"操作成功\"}', 106);
INSERT INTO `operate_log` VALUES (66, 0, '2026-01-05 19:20:49', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=lucky, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/c7eb242a-72e2-4271-890a-67fa5991f68b.jpg\",\"createTime\":1767578363000,\"id\":31,\"updateTime\":1767578363000,\"username\":\"lucky\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzMSIsImlhdCI6MTc2NzYxMjA0OCwiZXhwIjoxNzY3Njk4NDQ4fQ.3X70UvIcNEeshvSXnFaIby7XRCAssyJn21sij2OjhxY\"},\"msg\":\"操作成功\"}', 113);
INSERT INTO `operate_log` VALUES (67, 0, '2026-01-05 19:23:19', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=cmy, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/67fa0760-a2fa-4c0b-8790-02757b3b82b9.jpg\",\"createTime\":1767575315000,\"id\":24,\"updateTime\":1767575315000,\"username\":\"cmy\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyNCIsImlhdCI6MTc2NzYxMjE5OSwiZXhwIjoxNzY3Njk4NTk5fQ.MB7BWmhOYcC2N_l3BiFojTBM9NzaI3x0u9d-qNobklI\"},\"msg\":\"操作成功\"}', 112);
INSERT INTO `operate_log` VALUES (68, 0, '2026-01-05 19:26:27', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=cmy, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/67fa0760-a2fa-4c0b-8790-02757b3b82b9.jpg\",\"createTime\":1767575315000,\"id\":24,\"updateTime\":1767575315000,\"username\":\"cmy\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyNCIsImlhdCI6MTc2NzYxMjM4NywiZXhwIjoxNzY3Njk4Nzg3fQ.FkA5z13voDP2JMdLxsc2TTXuxuMAugSS0OZ4UBLlwD4\"},\"msg\":\"操作成功\"}', 99);
INSERT INTO `operate_log` VALUES (69, 0, '2026-01-05 19:26:31', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=cmy, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/67fa0760-a2fa-4c0b-8790-02757b3b82b9.jpg\",\"createTime\":1767575315000,\"id\":24,\"updateTime\":1767575315000,\"username\":\"cmy\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyNCIsImlhdCI6MTc2NzYxMjM5MSwiZXhwIjoxNzY3Njk4NzkxfQ.Eso6r_lOhp9yYoZG4icE0Eay2JIj0OBj1lqkIPDo5fE\"},\"msg\":\"操作成功\"}', 127);
INSERT INTO `operate_log` VALUES (70, 0, '2026-01-05 20:47:30', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=cmy, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/67fa0760-a2fa-4c0b-8790-02757b3b82b9.jpg\",\"createTime\":1767575315000,\"id\":24,\"updateTime\":1767575315000,\"username\":\"cmy\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyNCIsImlhdCI6MTc2NzYxNzI0OSwiZXhwIjoxNzY3NzAzNjQ5fQ.DyOCgSLDqCVn5Ym-K0K09mGgEFQy-vL8TTzwjYf8tIg\"},\"msg\":\"操作成功\"}', 92);
INSERT INTO `operate_log` VALUES (71, 24, '2026-01-05 20:58:20', 'com.blog.controller.ArticleController', 'updateArticle', '[ArticleRequest(id=38, title=2025年必追的5部高分剧，剧情反转停不下来, content=年末盘点，这5部高分剧让我熬夜追完：悬疑剧《隐秘的角落2》延续前作的烧脑风格，职场剧《前途》真实还原互联网行业的生存现状，古装剧《长安三万里》的服化道和剧情双在线，科幻剧《星际边界》的世界观设定新颖，温情剧《人间小事》则用细节治愈人心。\n![图片](/oss/blog/ARTICLE/7d05168b-2898-452d-8697-a5382050150c.jpg)\n\n![图片](/oss/blog/ARTICLE/06f44795-88d4-4a58-b1b9-d65c0e009ae2.jpeg)\n, categoryId=8, tagIds=[]), org.apache.catalina.connector.RequestFacade@4a629457]', '{\"code\":200,\"data\":true,\"msg\":\"操作成功\"}', 3);
INSERT INTO `operate_log` VALUES (72, 0, '2026-01-06 08:46:01', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=lucky, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/c7eb242a-72e2-4271-890a-67fa5991f68b.jpg\",\"createTime\":1767578363000,\"id\":31,\"updateTime\":1767578363000,\"username\":\"lucky\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzMSIsImlhdCI6MTc2NzY2MDM2MSwiZXhwIjoxNzY3NzQ2NzYxfQ.x4NeKJKDVb0KHhSHzZSOVAUNz8UbZEk8wD8bJcjUL-8\"},\"msg\":\"操作成功\"}', 163);
INSERT INTO `operate_log` VALUES (73, 0, '2026-01-06 09:11:15', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=lucky, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/c7eb242a-72e2-4271-890a-67fa5991f68b.jpg\",\"createTime\":1767578363000,\"id\":31,\"updateTime\":1767578363000,\"username\":\"lucky\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzMSIsImlhdCI6MTc2NzY2MTg3NSwiZXhwIjoxNzY3NzQ4Mjc1fQ.LVb0TjESIJogZlIR4jRPhZnPn8W7YfzKXYMphPE7EnE\"},\"msg\":\"操作成功\"}', 158);
INSERT INTO `operate_log` VALUES (74, 0, '2026-01-06 09:35:05', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=cmy, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/67fa0760-a2fa-4c0b-8790-02757b3b82b9.jpg\",\"createTime\":1767575315000,\"id\":24,\"updateTime\":1767575315000,\"username\":\"cmy\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyNCIsImlhdCI6MTc2NzY2MzMwNSwiZXhwIjoxNzY3NzQ5NzA1fQ.VCLDJoAXaCE0AsKldxH13KNuR3HIl6FPJ7bU7Pk5JI8\"},\"msg\":\"操作成功\"}', 139);
INSERT INTO `operate_log` VALUES (75, 0, '2026-01-06 11:29:31', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=阿南逛吃记, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/0bdd07a0-b54d-413e-a975-6f00c6759f68.jpg\",\"createTime\":1767577473000,\"id\":27,\"updateTime\":1767577473000,\"username\":\"阿南逛吃记\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyNyIsImlhdCI6MTc2NzY3MDE3MSwiZXhwIjoxNzY3NzU2NTcxfQ.zzFb4bzAAfNqsAlqWqbvBn8-z-wausd2m6stl5uv-ag\"},\"msg\":\"操作成功\"}', 135);
INSERT INTO `operate_log` VALUES (76, 0, '2026-01-06 11:55:59', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=阿南逛吃记, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/0bdd07a0-b54d-413e-a975-6f00c6759f68.jpg\",\"createTime\":1767577473000,\"id\":27,\"updateTime\":1767577473000,\"username\":\"阿南逛吃记\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyNyIsImlhdCI6MTc2NzY3MTc1OSwiZXhwIjoxNzY3NzU4MTU5fQ.T04rCMnuXiSB0MHdeMpnBwDBz6mJ17NdaOmeryZDQE0\"},\"msg\":\"操作成功\"}', 145);
INSERT INTO `operate_log` VALUES (77, 0, '2026-01-06 12:00:38', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=lucky, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/c7eb242a-72e2-4271-890a-67fa5991f68b.jpg\",\"createTime\":1767578363000,\"id\":31,\"updateTime\":1767578363000,\"username\":\"lucky\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzMSIsImlhdCI6MTc2NzY3MjAzNywiZXhwIjoxNzY3NzU4NDM3fQ.k-7uKuMesKGeJ-75_RsFp9rgu9ISkOTfufFR3nATJsM\"},\"msg\":\"操作成功\"}', 139);
INSERT INTO `operate_log` VALUES (78, 0, '2026-01-06 12:05:26', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=cmy, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/67fa0760-a2fa-4c0b-8790-02757b3b82b9.jpg\",\"createTime\":1767575315000,\"id\":24,\"updateTime\":1767575315000,\"username\":\"cmy\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyNCIsImlhdCI6MTc2NzY3MjMyNiwiZXhwIjoxNzY3NzU4NzI2fQ.388MMWa2rQMYTYDBKKxYwM5T7kx8tDyYyc1s-mpvss8\"},\"msg\":\"操作成功\"}', 120);
INSERT INTO `operate_log` VALUES (79, 0, '2026-01-06 12:09:49', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=职场小tip, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/e4f51478-696f-4865-b720-a2cd26fd2f47.jpg\",\"createTime\":1767577995000,\"id\":29,\"updateTime\":1767577995000,\"username\":\"职场小tip\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyOSIsImlhdCI6MTc2NzY3MjU4OSwiZXhwIjoxNzY3NzU4OTg5fQ.EfS7fmWHpUXjQ0vzcM4qK5RirtelmqV_MldY78fAbTw\"},\"msg\":\"操作成功\"}', 136);
INSERT INTO `operate_log` VALUES (80, 0, '2026-01-06 12:12:51', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=小乐学编程, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/2359a402-e768-442a-9012-b69b9664500a.jpg\",\"createTime\":1767575450000,\"id\":25,\"updateTime\":1767575450000,\"username\":\"小乐学编程\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyNSIsImlhdCI6MTc2NzY3Mjc3MSwiZXhwIjoxNzY3NzU5MTcxfQ.-eT6UMzw1PfXi1XOtDbNSKHFbD3iwyyVwR6MSIgZIXA\"},\"msg\":\"操作成功\"}', 122);
INSERT INTO `operate_log` VALUES (81, 0, '2026-01-06 12:16:58', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=lucky, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/c7eb242a-72e2-4271-890a-67fa5991f68b.jpg\",\"createTime\":1767578363000,\"id\":31,\"updateTime\":1767578363000,\"username\":\"lucky\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzMSIsImlhdCI6MTc2NzY3MzAxOCwiZXhwIjoxNzY3NzU5NDE4fQ.uE1u3QOheCen-zOxBUQpCjvpTQZHmX5SG8rjd09ranY\"},\"msg\":\"操作成功\"}', 125);
INSERT INTO `operate_log` VALUES (82, 0, '2026-01-06 12:18:27', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=lucky, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/c7eb242a-72e2-4271-890a-67fa5991f68b.jpg\",\"createTime\":1767578363000,\"id\":31,\"updateTime\":1767578363000,\"username\":\"lucky\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzMSIsImlhdCI6MTc2NzY3MzEwNiwiZXhwIjoxNzY3NzU5NTA2fQ.8s9F-DNFdUTtgdHhVj6S_9-MFR_cQNN7rDRkCmUc00Y\"},\"msg\":\"操作成功\"}', 119);
INSERT INTO `operate_log` VALUES (83, 0, '2026-01-06 12:19:00', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=cmy, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/67fa0760-a2fa-4c0b-8790-02757b3b82b9.jpg\",\"createTime\":1767575315000,\"id\":24,\"updateTime\":1767575315000,\"username\":\"cmy\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyNCIsImlhdCI6MTc2NzY3MzE0MCwiZXhwIjoxNzY3NzU5NTQwfQ.FgKFz1IIpQOOrkOCp-2GbVPejujKcrPr_GF88_vAcYs\"},\"msg\":\"操作成功\"}', 120);
INSERT INTO `operate_log` VALUES (84, 0, '2026-01-07 09:34:35', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=lucky, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/c7eb242a-72e2-4271-890a-67fa5991f68b.jpg\",\"createTime\":1767578363000,\"id\":31,\"updateTime\":1767578363000,\"username\":\"lucky\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzMSIsImlhdCI6MTc2Nzc0OTY3NSwiZXhwIjoxNzY3ODM2MDc1fQ.O_tMuCpIwtHoc70BqurDzbrkJPuDiyp1IdG94Z741cc\"},\"msg\":\"操作成功\"}', 148);
INSERT INTO `operate_log` VALUES (85, 0, '2026-01-07 09:45:35', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=lucky, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/c7eb242a-72e2-4271-890a-67fa5991f68b.jpg\",\"createTime\":1767578363000,\"id\":31,\"updateTime\":1767578363000,\"username\":\"lucky\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzMSIsImlhdCI6MTc2Nzc1MDMzNSwiZXhwIjoxNzY3ODM2NzM1fQ.9776uW3saxYwsNob1KgbClubhkPKpF5FK1yBcCEv08s\"},\"msg\":\"操作成功\"}', 1266);
INSERT INTO `operate_log` VALUES (86, 0, '2026-01-07 09:54:40', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=lucky, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/c7eb242a-72e2-4271-890a-67fa5991f68b.jpg\",\"createTime\":1767578363000,\"id\":31,\"updateTime\":1767578363000,\"username\":\"lucky\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzMSIsImlhdCI6MTc2Nzc1MDg4MCwiZXhwIjoxNzY3ODM3MjgwfQ.DlpBb1V_tN_beMnuQcQ3DnCwR9NdF9eoO1qEczXWYyE\"},\"msg\":\"操作成功\"}', 145);
INSERT INTO `operate_log` VALUES (87, 0, '2026-01-07 11:26:41', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=lucky, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/c7eb242a-72e2-4271-890a-67fa5991f68b.jpg\",\"createTime\":1767578363000,\"id\":31,\"updateTime\":1767578363000,\"username\":\"lucky\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzMSIsImlhdCI6MTc2Nzc1NjQwMSwiZXhwIjoxNzY3ODQyODAxfQ.W-lu1uo8A62ijk1ZZhhWpVxBYcgzntXnU6DjubTphgk\"},\"msg\":\"操作成功\"}', 173);
INSERT INTO `operate_log` VALUES (88, 31, '2026-01-07 11:31:34', 'com.blog.controller.ArticleController', 'createArticle', '[ArticleRequest(id=null, title=111, content=1111111, categoryId=4, tagIds=[6]), org.apache.catalina.connector.RequestFacade@1dcc2a08]', '{\"code\":200,\"data\":41,\"msg\":\"操作成功\"}', 55);
INSERT INTO `operate_log` VALUES (89, 31, '2026-01-07 11:36:47', 'com.blog.controller.ArticleController', 'deleteArticle', '[41, org.apache.catalina.connector.RequestFacade@5b9effcc]', '{\"code\":200,\"data\":true,\"msg\":\"操作成功\"}', 77);
INSERT INTO `operate_log` VALUES (90, 0, '2026-01-07 12:22:00', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=lucky, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/c7eb242a-72e2-4271-890a-67fa5991f68b.jpg\",\"createTime\":1767578363000,\"id\":31,\"updateTime\":1767578363000,\"username\":\"lucky\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzMSIsImlhdCI6MTc2Nzc1OTcyMCwiZXhwIjoxNzY3ODQ2MTIwfQ.J6boHOxD5qvJb8Y09RoljPtcSK770BE4GBKvfLsk-78\"},\"msg\":\"操作成功\"}', 168);
INSERT INTO `operate_log` VALUES (91, 0, '2026-01-07 12:25:29', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=lucky, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/c7eb242a-72e2-4271-890a-67fa5991f68b.jpg\",\"createTime\":1767578363000,\"id\":31,\"updateTime\":1767578363000,\"username\":\"lucky\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzMSIsImlhdCI6MTc2Nzc1OTkyOSwiZXhwIjoxNzY3ODQ2MzI5fQ._F622QirItE9NTeft2Bwm-f5ZEFQkwNoy3XSuaWBkHM\"},\"msg\":\"操作成功\"}', 177);
INSERT INTO `operate_log` VALUES (92, 0, '2026-01-07 12:27:54', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=lucky, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/c7eb242a-72e2-4271-890a-67fa5991f68b.jpg\",\"createTime\":1767578363000,\"id\":31,\"updateTime\":1767578363000,\"username\":\"lucky\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzMSIsImlhdCI6MTc2Nzc2MDA3MywiZXhwIjoxNzY3ODQ2NDczfQ.g4ke6J8vSzS3SDw_O89WrXrlbWBTbMwVtuq_YDUOCEE\"},\"msg\":\"操作成功\"}', 120);
INSERT INTO `operate_log` VALUES (93, 0, '2026-01-07 16:04:17', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=lucky, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/c7eb242a-72e2-4271-890a-67fa5991f68b.jpg\",\"createTime\":1767578363000,\"id\":31,\"updateTime\":1767578363000,\"username\":\"lucky\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzMSIsImlhdCI6MTc2Nzc3MzA1NiwiZXhwIjoxNzY3ODU5NDU2fQ.klCAjp-NMpjImZL-J09Ep8D3j9Oofomx2Caw7gxeDKA\"},\"msg\":\"操作成功\"}', 136);
INSERT INTO `operate_log` VALUES (94, 0, '2026-01-07 16:11:46', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=lucky, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/c7eb242a-72e2-4271-890a-67fa5991f68b.jpg\",\"createTime\":1767578363000,\"id\":31,\"updateTime\":1767578363000,\"username\":\"lucky\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzMSIsImlhdCI6MTc2Nzc3MzUwNSwiZXhwIjoxNzY3ODU5OTA1fQ.h1TawhMIjByLLAuZPPjFF7ug8DeV9PnbevWTLcLYxK4\"},\"msg\":\"操作成功\"}', 113);
INSERT INTO `operate_log` VALUES (95, 0, '2026-01-07 16:43:30', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=lucky, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/c7eb242a-72e2-4271-890a-67fa5991f68b.jpg\",\"createTime\":1767578363000,\"id\":31,\"updateTime\":1767578363000,\"username\":\"lucky\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzMSIsImlhdCI6MTc2Nzc3NTQwOSwiZXhwIjoxNzY3ODYxODA5fQ.vvShwwTBXOHfJoRIAbWQyxr6e8oDeYD9ROPXlEk-Teo\"},\"msg\":\"操作成功\"}', 117);
INSERT INTO `operate_log` VALUES (96, 0, '2026-01-07 22:59:44', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=lucky, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/c7eb242a-72e2-4271-890a-67fa5991f68b.jpg\",\"createTime\":1767578363000,\"id\":31,\"updateTime\":1767578363000,\"username\":\"lucky\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzMSIsImlhdCI6MTc2Nzc5Nzk4MywiZXhwIjoxNzY3ODg0MzgzfQ.VmBfRY2Ek3644WopqKaJyVghxJWEb2Xb-mKT6hsMr9s\"},\"msg\":\"操作成功\"}', 159);
INSERT INTO `operate_log` VALUES (97, 0, '2026-01-08 08:48:55', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=lucky, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/c7eb242a-72e2-4271-890a-67fa5991f68b.jpg\",\"createTime\":1767578363000,\"id\":31,\"updateTime\":1767578363000,\"username\":\"lucky\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzMSIsImlhdCI6MTc2NzgzMzMzNCwiZXhwIjoxNzY3OTE5NzM0fQ.TQTbf2Gom5oDWsxqDopsm6LMw24wPIxosBuXWV_Sosc\"},\"msg\":\"操作成功\"}', 130);
INSERT INTO `operate_log` VALUES (98, 0, '2026-01-18 15:52:31', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=cmy, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/67fa0760-a2fa-4c0b-8790-02757b3b82b9.jpg\",\"createTime\":1767575315000,\"id\":24,\"updateTime\":1767575315000,\"username\":\"cmy\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyNCIsImlhdCI6MTc2ODcyMjc1MSwiZXhwIjoxNzY4ODA5MTUxfQ.D54YyXK7D8jnIf_sxuufhI0PzmzqP1DoQE8xnO-h3k8\"},\"msg\":\"操作成功\"}', 193);
INSERT INTO `operate_log` VALUES (99, 0, '2026-01-19 13:39:51', 'com.blog.controller.UserController', 'login', '[LoginRequest(username=cmy, password=cmy260401)]', '{\"code\":200,\"data\":{\"user\":{\"avatar\":\"https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/67fa0760-a2fa-4c0b-8790-02757b3b82b9.jpg\",\"createTime\":1767575315000,\"id\":24,\"updateTime\":1767575315000,\"username\":\"cmy\"},\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyNCIsImlhdCI6MTc2ODgwMTE5MCwiZXhwIjoxNzY4ODg3NTkwfQ.i7Mwyq4n6fFj-sCszGu5uOPGVJBKfiTe-UMINvrzqzs\"},\"msg\":\"操作成功\"}', 171);

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tag
-- ----------------------------
INSERT INTO `tag` VALUES (6, 'Java', '2025-12-30 20:57:33');
INSERT INTO `tag` VALUES (7, 'Vue', '2025-12-30 20:57:33');
INSERT INTO `tag` VALUES (8, '前端', '2025-12-30 20:57:33');
INSERT INTO `tag` VALUES (9, '后端', '2025-12-30 20:57:33');
INSERT INTO `tag` VALUES (10, '算法', '2025-12-30 20:57:33');
INSERT INTO `tag` VALUES (11, '日常', '2025-12-30 20:57:33');
INSERT INTO `tag` VALUES (12, '探店', '2025-12-30 20:57:33');
INSERT INTO `tag` VALUES (13, '面试', '2025-12-30 20:57:33');
INSERT INTO `tag` VALUES (14, '书单', '2025-12-30 20:57:33');
INSERT INTO `tag` VALUES (15, '家常菜', '2025-12-30 20:57:33');
INSERT INTO `tag` VALUES (16, '追剧', '2025-12-30 20:57:33');
INSERT INTO `tag` VALUES (17, '游戏', '2025-12-30 20:57:33');
INSERT INTO `tag` VALUES (18, '网游', '2025-12-30 20:57:33');
INSERT INTO `tag` VALUES (19, '独居', '2025-12-30 20:57:33');
INSERT INTO `tag` VALUES (20, '副业', '2025-12-30 20:57:33');
INSERT INTO `tag` VALUES (21, '露营', '2025-12-30 20:57:33');
INSERT INTO `tag` VALUES (22, '咖啡', '2025-12-30 20:57:33');
INSERT INTO `tag` VALUES (23, '摄影', '2025-12-30 20:57:33');
INSERT INTO `tag` VALUES (24, '手账', '2025-12-30 20:57:33');
INSERT INTO `tag` VALUES (25, '绿植', '2025-12-30 20:57:33');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (24, 'cmy', '$2a$10$JkuzuOCpiYnxzA6TQ1/DFO.GC7dSNUuPfIfKJ4cPQuVBZmLBP.81O', 'https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/67fa0760-a2fa-4c0b-8790-02757b3b82b9.jpg', '2026-01-05 09:08:35', '2026-01-05 09:08:35');
INSERT INTO `user` VALUES (25, '小乐学编程', '$2a$10$0ayXAhLoGVIbtKT9MKZ3C.FOeGeMSsdPHfIIJz8Wian9tP5iH3g5O', 'https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/2359a402-e768-442a-9012-b69b9664500a.jpg', '2026-01-05 09:10:50', '2026-01-05 09:10:50');
INSERT INTO `user` VALUES (26, '游戏补给站', '$2a$10$dJOYYui2yVIPIAThhX/vWOWkwj.NM8k1yYyWoXG/KN81CY/aBacGa', 'https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/97b82dd5-2a35-4e8c-8f2a-3cce9a1b5466.jpg', '2026-01-05 09:40:05', '2026-01-05 09:40:05');
INSERT INTO `user` VALUES (27, '阿南逛吃记', '$2a$10$c/kVW8g1MFt2HrMvObhiy.vkZd6Ol1N40hqkmoav5b7AW/fBmCFMG', 'https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/0bdd07a0-b54d-413e-a975-6f00c6759f68.jpg', '2026-01-05 09:44:33', '2026-01-05 09:44:33');
INSERT INTO `user` VALUES (28, '海阔天空', '$2a$10$Uym0TxQPGmbDwG1HBDDddO.89Ux1qlN20CHvEVCnwifnoDZ2D27Jq', 'https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/d075b5e0-2349-46d4-aa70-6deaae9ba4b3.jpg', '2026-01-05 09:49:24', '2026-01-05 09:49:24');
INSERT INTO `user` VALUES (29, '职场小tip', '$2a$10$7VOMaZ4uoIErqH6LG6t4pO.GWWpDJQ0HAAuOmxu9lp48otrbz/Rku', 'https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/e4f51478-696f-4865-b720-a2cd26fd2f47.jpg', '2026-01-05 09:53:15', '2026-01-05 09:53:15');
INSERT INTO `user` VALUES (30, '定格晨昏', '$2a$10$qrMd3U/Plo3F0aNIs.J3ZuLR02VHy8ST67I6rPCMSAkVzVNtoW25K', 'https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/f7bba78a-cc6e-40ba-8491-7eb8fa037067.jpg', '2026-01-05 09:55:48', '2026-01-05 09:55:48');
INSERT INTO `user` VALUES (31, 'lucky', '$2a$10$v19ZRyrJAyBPgHJNUZwVDetqkEzTOWaLgkJgL6EToFg6.ucxWVdC2', 'https://web-blog-cmy.https://oss-cn-beijing.aliyuncs.com/blog/AVATAR/c7eb242a-72e2-4271-890a-67fa5991f68b.jpg', '2026-01-05 09:59:23', '2026-01-05 09:59:23');

SET FOREIGN_KEY_CHECKS = 1;
