package com.blog.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.blog.anno.Log;
import com.blog.common.Result;
import com.blog.config.TokenUtils;
import com.blog.dto.ArticleQueryDTO;
import com.blog.dto.ArticleRequest;
import com.blog.entity.Article;
import com.blog.service.ArticleService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/article")
public class ArticleController {

    @Resource
    private ArticleService articleService;

    /**
     * 分页查询
     * @param queryDTO
     * @return
     */
    @GetMapping("/list")
    public Result<Map<String, Object>> getArticles(ArticleQueryDTO queryDTO) {
        // 强制分页：默认第1页，每页10条，限制最大页大小防止恶意查询
        if (queryDTO.getPageNum() == null || queryDTO.getPageNum() < 1) {
            queryDTO.setPageNum(1);
        }
        if (queryDTO.getPageSize() == null || queryDTO.getPageSize() < 1 || queryDTO.getPageSize() > 100) {
            queryDTO.setPageSize(100);
        }

        Page<Article> page = articleService.getArticlesByCondition(queryDTO);

        // 封装返回数据（只返回前端需要的字段，避免冗余）
        List<Map<String, Object>> records = page.getRecords().stream().map(article -> {
            Map<String, Object> map = new HashMap<>();
            map.put("id", article.getId());
            map.put("title", article.getTitle());
            map.put("userId", article.getUserId());
            map.put("createTime", article.getCreateTime());
            map.put("categoryId", article.getCategoryId());
            map.put("authorName", article.getAuthorName());
            map.put("authorAvatar", article.getAuthorAvatar());
            return map;
        }).collect(Collectors.toList());

        Map<String, Object> result = new HashMap<>();
        result.put("list", records);
        result.put("total", page.getTotal());    // 总条数
        result.put("pageNum", page.getCurrent());// 当前页
        result.put("pageSize", page.getSize());  // 页大小
        result.put("pages", page.getPages());    // 总页数
        return Result.success(result);
    }


    /**
     * 分类查询
     * @param categoryId
     * @param pageNum
     * @param pageSize
     * @return
     */
    @GetMapping("/category/{categoryId}")
    public Result<Map<String, Object>> getArticlesByCategory(
            @PathVariable Long categoryId,
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "10") Integer pageSize) {
        ArticleQueryDTO queryDTO = new ArticleQueryDTO();
        queryDTO.setCategoryId(categoryId);
        queryDTO.setPageNum(pageNum);
        queryDTO.setPageSize(pageSize);
        return getArticles(queryDTO);
    }

    /**
     * 标签查询
     * @param tagId
     * @param pageNum
     * @param pageSize
     * @return
     */
    @GetMapping("/tag/{tagId}")
    public Result<Map<String, Object>> getArticlesByTag(
            @PathVariable Long tagId,
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "10") Integer pageSize) {
        ArticleQueryDTO queryDTO = new ArticleQueryDTO();
        queryDTO.setTagId(tagId);
        queryDTO.setPageNum(pageNum);
        queryDTO.setPageSize(pageSize);
        return getArticles(queryDTO);
    }

    /**
     * 根据用户ID查文章(作者首页)
     * @param userId
     * @param pageNum
     * @param pageSize
     * @return
     */
    @GetMapping("/user/{userId}")
    public Result<Map<String, Object>> getArticlesByUserId(
            @PathVariable Long userId,
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "10") Integer pageSize) {
        ArticleQueryDTO queryDTO = new ArticleQueryDTO();
        queryDTO.setUserId(userId);
        queryDTO.setPageNum(pageNum);
        queryDTO.setPageSize(pageSize);
        return getArticles(queryDTO);
    }

    /**
     * 根据关键词查询
     * @param keyword
     * @param pageNum
     * @param pageSize
     * @return
     */
    @GetMapping("/search")
    public Result<Map<String, Object>> searchArticles(
            @RequestParam(required = false) String keyword,
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "10") Integer pageSize) {
        ArticleQueryDTO queryDTO = new ArticleQueryDTO();
        queryDTO.setKeyword(keyword);  // 传入通用关键词（匹配标题/用户名）
        queryDTO.setPageNum(pageNum);
        queryDTO.setPageSize(pageSize);
        return getArticles(queryDTO);  // 复用核心查询逻辑
    }

    // ========== 基础操作接口 ==========

    /**
     * 单篇文章详情
     * @param id
     * @return
     */
    @GetMapping("/{id}")
    public Result<Article> getArticleDetail(@PathVariable Long id) {
        Article article = articleService.getArticleDetailById(id);
        return Result.success(article);
    }

    /**
     * 创建文章
     * @param request
     * @param httpRequest
     * @return
     */
    @Log
    @PostMapping
    public Result<Long> createArticle(@RequestBody ArticleRequest request, HttpServletRequest httpRequest) {
        Long userId = TokenUtils.getUserIdFromToken(httpRequest);
        if (userId == null) {
            return Result.error("请先登录或Token无效");
        }

        Article article = new Article();
        article.setTitle(request.getTitle());
        article.setContent(request.getContent());
        article.setCategoryId(request.getCategoryId());
        article.setUserId(userId);

        articleService.createArticle(article, request.getTagIds());
        return Result.success(article.getId());
    }

    /**
     * 更新文章
     * @param request
     * @param httpRequest
     * @return
     */
    @Log
    @PutMapping
    public Result<Boolean> updateArticle(@RequestBody ArticleRequest request, HttpServletRequest httpRequest) {
        Long userId = TokenUtils.getUserIdFromToken(httpRequest);
        if (userId == null) {
            return Result.error("请先登录或Token无效");
        }
        Article article = new Article();
        article.setId(request.getId());
        article.setTitle(request.getTitle());
        article.setContent(request.getContent());
        article.setCategoryId(request.getCategoryId());

        boolean success = articleService.updateArticle(article, userId);
        return Result.success(success);
    }

    /**
     * 删除文章
     * @param id
     * @param httpRequest
     * @return
     */
    @Log
    @DeleteMapping("/{id}")
    public Result<Boolean> deleteArticle(@PathVariable Long id, HttpServletRequest httpRequest) {
        Long userId = TokenUtils.getUserIdFromToken(httpRequest);
        if (userId == null) {
            return Result.error("请先登录或Token无效");
        }
        boolean success = articleService.deleteArticle(id, userId);
        return Result.success(success);
    }
}