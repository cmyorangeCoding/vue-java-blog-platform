package com.blog.common;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(Exception.class)
    public Result<?> handleException(Exception e) {
        log.error("全局异常捕获：", e);
        if (e.getMessage().contains("401")) {
            return Result.error(401, "未登录或Token过期");
        }
        return Result.error("服务器内部错误：" + e.getMessage());
    }
}