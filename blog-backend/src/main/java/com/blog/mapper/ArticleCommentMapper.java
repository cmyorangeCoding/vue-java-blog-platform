package com.blog.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.blog.entity.ArticleComment;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ArticleCommentMapper extends BaseMapper<ArticleComment> {



    List<ArticleComment> selectCommentListByArticleId(@Param("articleId") Long articleId);
}