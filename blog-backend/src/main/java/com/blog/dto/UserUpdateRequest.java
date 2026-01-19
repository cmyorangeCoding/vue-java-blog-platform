package com.blog.dto;

import lombok.Data;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

/**
 * 用户信息修改请求DTO
 */
@Data
public class UserUpdateRequest {
    @NotBlank(message = "用户名不能为空")
    @Size(min = 2, max = 20, message = "用户名长度需在2-20之间")
    private String username; // 新用户名
    private String avatar; // 新头像URL
}