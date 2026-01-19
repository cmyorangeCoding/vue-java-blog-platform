package com.blog.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.filter.HiddenHttpMethodFilter;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;


@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Autowired
    private JwtInterceptor jwtInterceptor;

    @Bean
    public HiddenHttpMethodFilter hiddenHttpMethodFilter() {
        return new HiddenHttpMethodFilter();
    }

    public WebConfig() {
        System.out.println("WebConfig 被加载了");
    }

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                .allowedOriginPatterns("*")
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
                .allowedHeaders("*")
                .allowCredentials(true)
                .maxAge(3600);
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(jwtInterceptor)
                // 拦截所有接口（相对于 context-path=/api 后的路径）
                .addPathPatterns("/**")
                // 放行路径
                .excludePathPatterns(
                        // 1. 登录注册
                        "/user/login",
                        "/user/register",
                        // 2. 匿名头像上传（注册用）
                        "/file/avatar/anonymous",
                        // 3. 游客可访问的文章查询接口
                        "/article/list",          // 条件分页查询
                        "/article/search",        // 关键词搜索
                        "/article/category/**",   // 分类查询（/article/category/1）
                        "/article/tag/**",        // 标签查询（/article/tag/1）
                        "/article/user/**",       // 作者文章列表（/article/user/1）
                        "/article/{id:[0-9]+}",   // 文章详情（/article/1）
                        // 4. 游客可访问的基础数据接口（分类、标签列表）
                        "/category",              // 所有分类
                        "/tag",                   // 所有标签
                        // 5. 点赞/收藏的统计和检查接口（游客可看数量、登录后才需拦截操作）
                        "/article/like/count/**", // 点赞数
                        "/article/collect/count/**", // 收藏数
                        // 6. 评论列表（游客可看，操作需登录拦截）
                        "/article/comment/list/**"
                );
    }
}
