package com.blog.dto;

import lombok.Data;
import java.util.Date;

/**
 * 收藏文章列表返回DTO
 */
@Data
public class ArticleCollectDTO {
    // 文章ID
    private Long articleId;
    // 文章标题
    private String title;
    // 文章内容（可选，若前端只需要标题可注释）
    private String content;
    // 文章分类ID
    private Long categoryId;
    // 收藏时间（区分文章创建时间，更贴合收藏场景）
    private Date collectTime;
    // 文章创建时间（可选）
    private Date articleCreateTime;
}