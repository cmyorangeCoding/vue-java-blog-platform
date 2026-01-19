package com.blog.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.blog.entity.ArticleLike;
import org.apache.ibatis.annotations.Select;

public interface ArticleLikeMapper extends BaseMapper<ArticleLike> {

    /**
     * 统计点赞数
     * @param articleId
     * @return
     */
    @Select("SELECT COUNT(*) FROM article_like WHERE article_id = #{articleId}")
    int countByArticleId(Long articleId);

    /**
     * 检查是否点赞
     * @param articleId
     * @param userId
     * @return
     */
    default boolean checkLike(Long articleId, Long userId) {
        LambdaQueryWrapper<ArticleLike> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ArticleLike::getArticleId, articleId)
                .eq(ArticleLike::getUserId, userId);
        return selectCount(wrapper) > 0;
    }
}