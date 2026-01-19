package com.blog.service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.blog.entity.Category;
import com.blog.mapper.CategoryMapper;
import org.springframework.stereotype.Service;

@Service
public class CategoryService extends ServiceImpl<CategoryMapper, Category> {
}