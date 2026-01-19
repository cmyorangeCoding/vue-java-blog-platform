package com.blog.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import java.util.Date;
import java.util.List;

@Data
@TableName("article_comment")
public class ArticleComment {
    @TableId(type = IdType.AUTO)
    private Long id;
    private Long articleId;
    private Long userId;
    private String content;
    private Date createTime;
    /** 父评论ID（0=顶级评论） */
    private Long parentId;

    private String commenterName;
    private String commenterAvatar;

    /** 子评论列表（嵌套用） */
    private List<ArticleComment> children;
}