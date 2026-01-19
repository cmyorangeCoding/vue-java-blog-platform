package com.blog.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.blog.dto.ArticleQueryDTO;
import com.blog.entity.Article;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ArticleMapper extends BaseMapper<Article> {

    /**
     * 插入文章
     * @param article
     * @return
     */
    int insertWithUserId(Article article);

    /**
     * 多条件组合查询+分页
     * @param page
     * @param queryDTO
     * @return
     */
    Page<Article> selectArticlesByCondition(Page<Article> page, @Param("query") ArticleQueryDTO queryDTO);


    /**
     * 单篇文章详情
     * @param id
     * @return
     */
    Article selectArticleDetailById(@Param("id") Long id);


}