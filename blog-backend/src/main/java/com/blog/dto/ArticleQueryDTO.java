package com.blog.dto;

import lombok.Data;

@Data
public class ArticleQueryDTO {
    // 原有字段
    private Integer pageNum = 1;    // 默认第1页
    private Integer pageSize = 10;  // 默认每页10条
    private String title;           // 标题模糊查询
    private Long categoryId;        // 分类ID
    private Long tagId;             // 标签ID
    private Long userId;            // 作者ID

    // 新增：通用搜索关键词（兼容标题/用户名）
    private String keyword;
}