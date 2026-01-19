package com.blog.controller;

import com.blog.common.Result;
import com.blog.config.TokenUtils;
import com.blog.entity.ArticleComment;
import com.blog.service.ArticleCommentService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/article/comment")
public class ArticleCommentController {

    @Resource
    private ArticleCommentService articleCommentService;

    /**
     * 新增顶级评论
     * @param articleId
     * @param params
     * @param request
     * @return
     */
    @PostMapping("/add/{articleId}")
    public Result<Boolean> addComment(
            @PathVariable Long articleId,
            @RequestBody Map<String, String> params,
            HttpServletRequest request
    ) {
        // 从Token获取当前登录用户ID（你的TokenUtils已有该逻辑）
        Long userId = TokenUtils.getUserIdFromToken(request);
        if (userId == null) {
            return Result.error("请先登录");
        }
        String content = params.get("content");
        if (content == null || content.trim().isEmpty()) {
            return Result.error("评论内容不能为空");
        }
        boolean success = articleCommentService.addComment(articleId, userId, content);
        return success ? Result.success(true) : Result.error("评论发布失败");
    }

    /**
     * 回复评论
     * @param articleId
     * @param parentId
     * @param params
     * @param request
     * @return
     */
    @PostMapping("/reply/{articleId}/{parentId}")
    public Result<Boolean> replyComment(
            @PathVariable Long articleId,
            @PathVariable Long parentId,
            @RequestBody Map<String, String> params,
            HttpServletRequest request
    ) {
        Long userId = TokenUtils.getUserIdFromToken(request);
        if (userId == null) {
            return Result.error("请先登录");
        }
        String content = params.get("content");
        if (content == null || content.trim().isEmpty()) {
            return Result.error("回复内容不能为空");
        }
        try {
            boolean success = articleCommentService.replyComment(articleId, userId, content, parentId);
            return success ? Result.success(true) : Result.error("回复失败");
        } catch (RuntimeException e) {
            return Result.error(e.getMessage());
        }
    }

    /**
     * 删除评论
     * @param id
     * @param request
     * @return
     */
    @DeleteMapping("/delete/{id}")
    public Result<Boolean> deleteComment(
            @PathVariable Long id,
            HttpServletRequest request
    ) {
        Long userId = TokenUtils.getUserIdFromToken(request);
        if (userId == null) {
            return Result.error("请先登录");
        }
        try {
            boolean success = articleCommentService.deleteComment(id, userId);
            return success ? Result.success(true) : Result.error("删除失败");
        } catch (RuntimeException e) {
            return Result.error(e.getMessage());
        }
    }

    /**
     * 获取嵌套评论列表
     * @param articleId
     * @return
     */
    @GetMapping("/list/{articleId}")
    public Result<List<ArticleComment>> getCommentList(@PathVariable Long articleId) {
        List<ArticleComment> commentList = articleCommentService.getCommentList(articleId);
        return Result.success(commentList);
    }
}