package com.blog.common;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

// 只保留 @Configuration，删掉 @EnableWebSecurity，不加载 Security 拦截链
@Configuration
public class Security {

    // 仅保留密码加密功能
    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }
}