package com.blog.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.blog.anno.Log;
import com.blog.common.Result;
import com.blog.config.TokenUtils;
import com.blog.dto.LoginRequest;
import com.blog.dto.RegisterRequest;
import com.blog.dto.UserUpdateRequest;
import com.blog.entity.File;
import com.blog.entity.User;
import com.blog.config.JwtUtil;
import com.blog.service.FileService;
import com.blog.service.UserService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/user")
public class UserController {

    @Resource
    private UserService userService;
    @Resource
    private FileService fileService;

    /**
     * 用户注册
     * @param request
     * @return
     */
    @Log
    @PostMapping("/register")
    public Result<Boolean> register(@Valid @RequestBody RegisterRequest request) {
        boolean success = userService.register(request);
        if (success) {
            fileService.remove(new LambdaQueryWrapper<File>().isNull(File::getUserId).eq(File::getType, "AVATAR"));
        }
        return Result.success(success);
    }

    /**
     * 用户登录
     * @param request
     * @return
     */
    @Log
    @PostMapping("/login")
    public Result<Map<String, Object>> login(@Valid @RequestBody LoginRequest request) {
        User user = userService.login(request.getUsername(), request.getPassword());
        String token = JwtUtil.generateToken(user.getId().toString());
        user.setPassword(null);

        Map<String, Object> result = new HashMap<>();
        result.put("token", token);
        result.put("user", user);
        return Result.success(result);
    }

    /**
     * 根据ID获取信息
     * @param id
     * @return
     */
    @GetMapping("/{id}")
    public Result<User> getUserInfo(@PathVariable Long id) {
        User user = userService.getById(id);
        if (user == null) {
            return Result.error("用户不存在");
        }
        user.setPassword(null);
        return Result.success(user);
    }

    /**
     * 修改用户信息
     * @param request
     * @param httpRequest
     * @return
     */
    @Log
    @PutMapping("/update")
    public Result<Boolean> updateUserInfo(
            @Valid @RequestBody UserUpdateRequest request,
            HttpServletRequest httpRequest
    ) {
        // 调用你的TokenUtils解析userId
        Long userId = TokenUtils.getUserIdFromToken(httpRequest);
        if (userId == null) {
            return Result.error(401, "登录失效，请重新登录");
        }
        boolean success = userService.updateUserInfo(userId, request);
        return Result.success(success);
    }

    /**
     * 注销账号
     * @param request
     * @return
     */
    @Log
    @DeleteMapping("/logout")
    public Result<Boolean> logout(HttpServletRequest request) {
        // 调用你的TokenUtils解析userId
        Long userId = TokenUtils.getUserIdFromToken(request);
        if (userId == null) {
            return Result.error(401, "登录失效，请重新登录");
        }
        boolean success = userService.logout(userId);
        return Result.success(success);
    }
}