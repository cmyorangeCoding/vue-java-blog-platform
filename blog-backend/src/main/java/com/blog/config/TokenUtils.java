package com.blog.config;

import io.jsonwebtoken.Claims;
import javax.servlet.http.HttpServletRequest;

/**
 * Token通用解析工具类（所有接口复用）
 */
public class TokenUtils {

    /**
     * 从请求头解析Token，返回userId
     * @return 解析成功返回userId，失败返回null
     */
    public static Long getUserIdFromToken(HttpServletRequest request) {
        // 1. 从请求头拿Token
        String token = request.getHeader("Authorization");
        if (token == null || token.trim().isEmpty()) {
            return null;
        }

        // 2. 处理Bearer前缀
        if (token.startsWith("Bearer ")) {
            token = token.substring(7).trim();
        }

        // 3. 解析Token
        try {
            Claims claims = JwtUtil.parseToken(token);
            return Long.parseLong(claims.getSubject());
        } catch (Exception e) {
            return null; // 解析失败返回null
        }
    }
}