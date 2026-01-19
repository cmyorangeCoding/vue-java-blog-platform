package com.blog.controller;

import com.blog.common.Result;
import com.blog.service.FileService;
import com.blog.config.TokenUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/file")
public class FileController {

    @Resource
    private FileService fileService;

    /**
     * 匿名上传头像（注册用）
     * @param file
     * @return
     */
    @PostMapping("/avatar/anonymous")
    public Result<String> uploadAvatarAnonymous(@RequestParam("file") MultipartFile file) {
        if (file.isEmpty()) {
            return Result.error(400, "上传的头像文件不能为空");
        }
        try {
            // 传null，注册成功后用user.id补全
            String url = fileService.uploadAvatar(file, null);
            return Result.success(url);
        } catch (Exception e) {
            return Result.error(500, "头像上传失败：" + e.getMessage());
        }
    }

    /**
     * 登录上传头像（登录用）
     * @param file
     * @param request
     * @return
     */
    @PostMapping("/avatar")
    public Result<String> uploadAvatar(@RequestParam("file") MultipartFile file, HttpServletRequest request) {
        if (file.isEmpty()) {
            return Result.error(400, "上传的头像文件不能为空");
        }
        try {
            Long userId = TokenUtils.getUserIdFromToken(request); // 从Token拿userId
            String url = fileService.uploadAvatar(file, userId);
            return Result.success(url);
        } catch (Exception e) {
            return Result.error(500, "头像上传失败：" + e.getMessage());
        }
    }

    /**
     * 上传文章图片
     * @param file
     * @param articleId
     * @param request
     * @return
     */
    @PostMapping("/article")
    public Result<String> uploadArticleImage(
            @RequestParam("file") MultipartFile file,
            @RequestParam("articleId") Long articleId, // 前端必须传articleId
            HttpServletRequest request
    ) {
        if (file.isEmpty()) {
            return Result.error(400, "上传的文章图片不能为空");
        }
        try {
            Long userId = TokenUtils.getUserIdFromToken(request); // 从Token拿userId
            // 传给Service：userId + articleId
            String url = fileService.uploadArticleImage(file, userId, articleId);
            return Result.success(url);
        } catch (Exception e) {
            return Result.error(500, "文章图片上传失败：" + e.getMessage());
        }
    }
}