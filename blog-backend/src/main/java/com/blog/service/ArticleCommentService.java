package com.blog.service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.blog.entity.ArticleComment;
import com.blog.mapper.ArticleCommentMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ArticleCommentService extends ServiceImpl<ArticleCommentMapper, ArticleComment> {

    @Resource
    private ArticleCommentMapper articleCommentMapper;


    /**
     * 新增顶级评论
     * @param articleId
     * @param userId
     * @param content
     * @return
     */
    public boolean addComment(Long articleId, Long userId, String content) {
        ArticleComment comment = new ArticleComment();
        comment.setArticleId(articleId);
        comment.setUserId(userId);
        comment.setContent(content);
        comment.setParentId(0L); // 顶级评论父ID为0
        return save(comment);
    }

    /**
     * 回复评论
     * @param articleId
     * @param userId
     * @param content
     * @param parentId
     * @return
     */
    public boolean replyComment(Long articleId, Long userId, String content, Long parentId) {
        // 校验父评论是否存在
        if (parentId == 0 ) {
            throw new RuntimeException("被回复的评论不存在");
        }
        ArticleComment comment = new ArticleComment();
        comment.setArticleId(articleId);
        comment.setUserId(userId);
        comment.setContent(content);
        comment.setParentId(parentId); // 绑定父评论ID
        return save(comment);
    }

    /**
     * 仅本人可删，删主评论时连带删所有子评论
     *
     * @param id
     * @param userId
     * @return
     */
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteComment(Long id, Long userId) {
        // 1. 查询要删除的评论
        ArticleComment targetComment = lambdaQuery()
                .select(ArticleComment::getId, ArticleComment::getUserId, ArticleComment::getArticleId)
                .eq(ArticleComment::getId, id)
                .one();

        // 2. 校验评论是否存在
        if (targetComment == null) {
            throw new RuntimeException("评论不存在");
        }

        // 3. 核心：仅评论发布者本人可删
        if (!targetComment.getUserId().equals(userId)) {
            throw new RuntimeException("只能删除自己发布的评论");
        }

        // 4. 递归删除所有子评论
        deleteChildComments(id);

        // 5. 删除当前评论
        return removeById(id);
    }

    /**
     * 递归删除所有子评论
     *
     * @param parentId
     */
    // 修复后的私有辅助方法：只查数据库真实存在的字段
    private void deleteChildComments(Long parentId) {
        // 只查article_comment表的真实字段
        List<ArticleComment> childComments = lambdaQuery()
                .select(ArticleComment::getId, ArticleComment::getParentId) // 只查需要的字段
                .eq(ArticleComment::getParentId, parentId)
                .list();
        // 递归删子评论
        for (ArticleComment child : childComments) {
            deleteChildComments(child.getId());
            removeById(child.getId());
        }
    }

    /**
     * HashMap实现嵌套评论查询
     * @param articleId
     * @return
     */
    public List<ArticleComment> getCommentList(Long articleId) {
        // 1. 查询该文章所有评论（扁平列表，关联user表查头像/名称）
        List<ArticleComment> allComments = articleCommentMapper.selectCommentListByArticleId(articleId);
        if (allComments.isEmpty()) {
            return new ArrayList<>();
        }

        // 2. ID → 评论对象（快速查找父评论）
        Map<Long, ArticleComment> commentMap = new HashMap<>(allComments.size());
        for (ArticleComment comment : allComments) {
            comment.setChildren(new ArrayList<>()); // 初始化子评论列表
            commentMap.put(comment.getId(), comment);
        }

        // 3. 挂靠父子关系
        List<ArticleComment> topComments = new ArrayList<>();
        for (ArticleComment comment : allComments) {
            Long parentId = comment.getParentId();
            if (parentId == 0) {
                // 父ID=0 → 顶级评论
                topComments.add(comment);
            } else {
                // 父ID≠0 → 挂载到父评论的children列表
                ArticleComment parentComment = commentMap.get(parentId);
                if (parentComment != null) {
                    parentComment.getChildren().add(comment);
                }
            }
        }

        return topComments;
    }
}