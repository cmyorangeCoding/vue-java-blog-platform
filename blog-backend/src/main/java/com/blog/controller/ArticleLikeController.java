package com.blog.controller;

import com.blog.common.Result;
import com.blog.config.TokenUtils;
import com.blog.service.ArticleLikeService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/article/like")
public class ArticleLikeController {

    @Resource
    private ArticleLikeService articleLikeService;

    /**
     * 点赞/取消点赞
     * @param articleId
     * @param request
     * @return
     */
    @PostMapping("/toggle/{articleId}")
    public Result<Boolean> toggleLike(@PathVariable Long articleId, HttpServletRequest request) {
        Long userId = TokenUtils.getUserIdFromToken(request);
        if (userId == null) {
            return Result.error("请先登录或Token无效");
        }
        boolean success = articleLikeService.toggleLike(articleId, userId);
        return Result.success(success);
    }

    /**
     * 获取点赞数
     * @param articleId
     * @return
     */
    @GetMapping("/count/{articleId}")
    public Result<Integer> getLikeCount(@PathVariable Long articleId) {
        int count = articleLikeService.getLikeCount(articleId);
        return Result.success(count);
    }

    /**
     * 检查是否点赞
     * @param articleId
     * @param request
     * @return
     */
    @GetMapping("/check/{articleId}")
    public Result<Boolean> checkLike(@PathVariable Long articleId, HttpServletRequest request) {
        Long userId = TokenUtils.getUserIdFromToken(request);
        if (userId == null) {
            return Result.error("请先登录或Token无效");
        }
        boolean isLike = articleLikeService.checkLike(articleId, userId);
        return Result.success(isLike);
    }
}