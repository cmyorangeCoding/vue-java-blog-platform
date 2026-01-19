package com.blog.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import java.util.Date;

@Data
@TableName("article")
public class Article {
    @TableId(type = IdType.AUTO)
    private Long id;
    private String title;
    private String content;
    private Long categoryId;
    @TableField("user_id")
    private Long userId;
    private Date createTime;
    private Date updateTime;

    //作者用户名，非数据库字段
    @TableField(exist = false)
    private String authorName;
    @TableField(exist = false)
    private String authorAvatar;
}