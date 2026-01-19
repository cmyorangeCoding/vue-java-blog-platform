package com.blog.controller;

import com.blog.common.Result;
import com.blog.config.TokenUtils;
import com.blog.dto.ArticleCollectDTO;
import com.blog.service.ArticleCollectService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@RestController
@RequestMapping("/article/collect")
public class ArticleCollectController {

    @Resource
    private ArticleCollectService articleCollectService;

    /**
     * 取消收藏/收藏
     * @param articleId
     * @param request
     * @return
     */
    @PostMapping("/toggle/{articleId}")
    public Result<Boolean> toggleCollect(@PathVariable Long articleId, HttpServletRequest request) {
        Long userId = TokenUtils.getUserIdFromToken(request);
        if (userId == null) {
            return Result.error("请先登录或Token无效");
        }
        boolean success = articleCollectService.toggleCollect(articleId, userId);
        return Result.success(success);
    }

    /**
     * 获取收藏数
     * @param articleId
     * @return
     */
    @GetMapping("/count/{articleId}")
    public Result<Integer> getCollectCount(@PathVariable Long articleId) {
        int count = articleCollectService.getCollectCount(articleId);
        return Result.success(count);
    }

    /**
     * 检查是否收藏
     * @param articleId
     * @param request
     * @return
     */
    @GetMapping("/check/{articleId}")
    public Result<Boolean> checkCollect(@PathVariable Long articleId, HttpServletRequest request) {
        Long userId = TokenUtils.getUserIdFromToken(request);
        if (userId == null) {
            return Result.error("请先登录或Token无效");
        }
        boolean isCollect = articleCollectService.checkCollect(articleId, userId);
        return Result.success(isCollect);
    }

    /**
     * 获取当前用户收藏的文章列表
     * @param request
     * @return
     */
    @GetMapping("/list")
    public Result<List<ArticleCollectDTO>> getCollectArticleList(HttpServletRequest request) {
        Long userId = TokenUtils.getUserIdFromToken(request);
        if (userId == null) {
            return Result.error("请先登录或Token无效");
        }
        List<ArticleCollectDTO> collectList = articleCollectService.getCollectArticleList(userId);
        return Result.success(collectList);
    }

    // 兼容前端原路径 /article/collect/list/{userId}（可选，避免前端改路径）
    @GetMapping("/list/{userId}")
    public Result<List<ArticleCollectDTO>> getCollectArticleListByUserId(@PathVariable Long userId) {
        List<ArticleCollectDTO> collectList = articleCollectService.getCollectArticleList(userId);
        return Result.success(collectList);
    }
}