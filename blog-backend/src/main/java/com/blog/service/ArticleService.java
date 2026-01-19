package com.blog.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.blog.dto.ArticleQueryDTO;
import com.blog.entity.*;
import com.blog.mapper.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ArticleService extends ServiceImpl<ArticleMapper, Article> {

    @Resource
    private ArticleMapper articleMapper;
    @Resource
    private ArticleTagMapper articleTagMapper;
    @Resource
    private ArticleCommentMapper articleCommentMapper;
    @Resource
    private ArticleLikeMapper articleLikeMapper;
    @Resource
    private ArticleCollectMapper articleCollectMapper;
    @Resource
    private FileMapper fileMapper;

    /**
     * 核心分页查询
     * @param queryDTO
     * @return
     */
    public Page<Article> getArticlesByCondition(ArticleQueryDTO queryDTO) {
        Page<Article> page = new Page<>(queryDTO.getPageNum(), queryDTO.getPageSize());
        return articleMapper.selectArticlesByCondition(page, queryDTO);
    }

    /**
     * 按照用户查所有文章
     * @param userId
     * @return
     */
    public List<Article> getArticlesByUserId(Long userId) {
        ArticleQueryDTO queryDTO = new ArticleQueryDTO();
        queryDTO.setUserId(userId);
        queryDTO.setPageNum(1);
        queryDTO.setPageSize(Integer.MAX_VALUE); // 查全量
        Page<Article> page = getArticlesByCondition(queryDTO);
        return page.getRecords();
    }

    /**
     * 单篇文章详情
     * @param id
     * @return
     */
    public Article getArticleDetailById(Long id) {
        return articleMapper.selectArticleDetailById(id);
    }


    /**
     * 创建文章（插入文章和插入文章Tag）
     * @param article
     * @param tagIds
     * @return
     */
    @Transactional
    public boolean createArticle(Article article, Long[] tagIds) {
        int rows = articleMapper.insertWithUserId(article);
        boolean success = rows > 0;

        if (success && tagIds != null && tagIds.length > 0) {
            for (Long tagId : tagIds) {
                ArticleTag articleTag = new ArticleTag();
                articleTag.setArticleId(article.getId());
                articleTag.setTagId(tagId);
                articleTagMapper.insert(articleTag);
            }
        }
        return success;
    }

    /**
     * 修改文章
     * @param article
     * @param userId
     * @return
     */
    @Transactional
    public boolean updateArticle(Article article, Long userId) {
        Article oldArticle = getById(article.getId());
        if (oldArticle == null) {
            throw new RuntimeException("文章不存在");
        }
        if (!oldArticle.getUserId().equals(userId)) {
            throw new RuntimeException("无权限修改");
        }
        return updateById(article);
    }

    /**
     * 删除文章（删除图片，评论，文章Tag，收藏）
     * @param id
     * @param userId
     * @return
     */
    @Transactional
    public boolean deleteArticle(Long id, Long userId) {
        Article article = getById(id);
        if (article == null) {
            throw new RuntimeException("文章不存在");
        }
        if (!article.getUserId().equals(userId)) {
            throw new RuntimeException("无权限删除");
        }

        fileMapper.delete(new QueryWrapper<File>().eq("article_id", id));
        articleCommentMapper.delete(new QueryWrapper<ArticleComment>().eq("article_id", id));
        articleLikeMapper.delete(new QueryWrapper<ArticleLike>().eq("article_id", id));
        articleCollectMapper.delete(new QueryWrapper<ArticleCollect>().eq("article_id", id));
        articleTagMapper.delete(new QueryWrapper<ArticleTag>().eq("article_id", id));

        return removeById(id);
    }
}