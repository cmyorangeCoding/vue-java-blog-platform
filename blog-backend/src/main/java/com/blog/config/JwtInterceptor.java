package com.blog.config;

import io.jsonwebtoken.Claims;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import java.io.PrintWriter;

@Component
public class JwtInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response,
                             Object handler) throws Exception {

        System.out.println("JWTInterceptor preHandle 执行了");

        if ("OPTIONS".equalsIgnoreCase(request.getMethod())) {
            return true;
        }

        String token = request.getHeader("Authorization");
        if (token == null || token.trim().isEmpty()) {
            response401(response, "请先登录");
            return false;
        }

        if (token.startsWith("Bearer ")) {
            token = token.substring(7).trim();
        }

        try {
            Claims claims = JwtUtil.parseToken(token);
            request.setAttribute("userId", Long.valueOf(claims.getSubject()));
            return true;
        } catch (Exception e) {
            response401(response, "登录失效，请重新登录");
            return false;
        }
    }

    private void response401(HttpServletResponse response, String msg) throws Exception {
        response.setStatus(401);
        response.setContentType("application/json;charset=utf-8");
        PrintWriter writer = response.getWriter();
        writer.write("{\"code\":401,\"msg\":\"" + msg + "\",\"data\":null}");
        writer.flush();
        writer.close();
    }
}
