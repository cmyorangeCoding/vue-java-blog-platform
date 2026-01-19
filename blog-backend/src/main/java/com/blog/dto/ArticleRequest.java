package com.blog.dto;

import lombok.Data;
import javax.validation.constraints.NotBlank;

@Data
public class ArticleRequest {
    private Long id;
    @NotBlank(message = "标题不能为空")
    private String title;
    @NotBlank(message = "内容不能为空")
    private String content;
    private Long categoryId;
    private Long[] tagIds;
}