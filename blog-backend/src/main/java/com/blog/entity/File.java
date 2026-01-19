package com.blog.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import java.util.Date;

@Data
@TableName("file")
public class File {
    @TableId(type = IdType.AUTO)
    private Long id;
    private String url;
    private String type;
    private Long userId;
    private Long articleId;
    private Date createTime;
}