package com.blog.service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.blog.entity.ArticleLike;
import com.blog.mapper.ArticleLikeMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@Service
public class ArticleLikeService extends ServiceImpl<ArticleLikeMapper, ArticleLike> {

    @Resource
    private ArticleLikeMapper articleLikeMapper;

    /**
     * 点赞/取消点赞（先查后改）
     * @param articleId
     * @param userId
     * @return
     */
    @Transactional
    public boolean toggleLike(Long articleId, Long userId) {
        LambdaQueryWrapper<ArticleLike> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ArticleLike::getArticleId, articleId)
                .eq(ArticleLike::getUserId, userId);

        ArticleLike existLike = getOne(wrapper);
        if (existLike != null) {
            // 取消点赞
            return removeById(existLike.getId());
        } else {
            // 点赞
            ArticleLike articleLike = new ArticleLike();
            articleLike.setArticleId(articleId);
            articleLike.setUserId(userId);
            return save(articleLike);
        }
    }

    /**
     * 获取点赞数
     * @param articleId
     * @return
     */
    public int getLikeCount(Long articleId) {
        return articleLikeMapper.countByArticleId(articleId);
    }

    /**
     * 检查是否点赞
     * @param articleId
     * @param userId
     * @return
     */
    public boolean checkLike(Long articleId, Long userId) {
        return articleLikeMapper.checkLike(articleId, userId);
    }
}