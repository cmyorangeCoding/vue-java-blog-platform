package com.blog.service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.blog.dto.ArticleCollectDTO;
import com.blog.entity.ArticleCollect;
import com.blog.mapper.ArticleCollectMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ArticleCollectService extends ServiceImpl<ArticleCollectMapper, ArticleCollect> {

    @Resource
    private ArticleCollectMapper articleCollectMapper;

    /**
     * 收藏/取消收藏
     * @param articleId
     * @param userId
     * @return
     */
    @Transactional
    public boolean toggleCollect(Long articleId, Long userId) {
        LambdaQueryWrapper<ArticleCollect> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ArticleCollect::getArticleId, articleId)
                .eq(ArticleCollect::getUserId, userId);

        ArticleCollect existCollect = getOne(wrapper);
        if (existCollect != null) {
            // 取消收藏
            return removeById(existCollect.getId());
        } else {
            // 收藏
            ArticleCollect articleCollect = new ArticleCollect();
            articleCollect.setArticleId(articleId);
            articleCollect.setUserId(userId);
            return save(articleCollect);
        }
    }

    /**
     * 获取收藏数
     * @param articleId
     * @return
     */
    public int getCollectCount(Long articleId) {
        return articleCollectMapper.countByArticleId(articleId);
    }

    /**
     * 检查是否收藏
     * @param articleId
     * @param userId
     * @return
     */
    public boolean checkCollect(Long articleId, Long userId) {
        return articleCollectMapper.checkCollect(articleId, userId);
    }

    /**
     * 获取用户收藏的文章列表（返回自定义DTO）
     * @param userId
     * @return
     */
    public List<ArticleCollectDTO> getCollectArticleList(Long userId) {
        return articleCollectMapper.selectCollectArticleList(userId);
    }
}