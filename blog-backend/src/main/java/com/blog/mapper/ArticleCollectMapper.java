package com.blog.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.blog.dto.ArticleCollectDTO;
import com.blog.entity.ArticleCollect;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface ArticleCollectMapper extends BaseMapper<ArticleCollect> {

    /**
     * 统计收藏数
     * @param articleId
     * @return
     */
    @Select("SELECT COUNT(*) FROM article_collect WHERE article_id = #{articleId}")
    int countByArticleId(Long articleId);

    /**
     * 检查是否收藏
     * @param articleId
     * @param userId
     * @return
     */
    default boolean checkCollect(Long articleId, Long userId) {
        LambdaQueryWrapper<ArticleCollect> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ArticleCollect::getArticleId, articleId)
                .eq(ArticleCollect::getUserId, userId);
        return selectCount(wrapper) > 0;
    }

    /**
     * 查询用户收藏的文章列表（关联article表，返回DTO）
     * @param userId
     * @return
     */
    @Select("SELECT a.id as articleId, a.title, a.content, a.category_id as categoryId, a.create_time as articleCreateTime, ac.create_time as collectTime " +
            "FROM article_collect ac " +
            "LEFT JOIN article a ON ac.article_id = a.id " +
            "WHERE ac.user_id = #{userId} " +
            "ORDER BY ac.create_time DESC")
    List<ArticleCollectDTO> selectCollectArticleList(Long userId);
}