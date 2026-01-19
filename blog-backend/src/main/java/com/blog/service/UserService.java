package com.blog.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.blog.dto.RegisterRequest;
import com.blog.dto.UserUpdateRequest;
import com.blog.entity.Article;
import com.blog.entity.File;
import com.blog.entity.User;
import com.blog.mapper.FileMapper;
import com.blog.mapper.UserMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Slf4j
@Service
public class UserService extends ServiceImpl<UserMapper, User> {

    @Resource
    private UserMapper userMapper;
    @Resource
    private FileMapper fileMapper;
    @Resource
    private ArticleService articleService;

    private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    /**
     * 注册
     * @param request
     * @return
     */
    public boolean register(RegisterRequest request) {
        User user = new User();
        user.setUsername(request.getUsername());
        user.setPassword(passwordEncoder.encode(request.getPassword()));
        user.setAvatar(request.getAvatar());
        user.setCreateTime(new Date());
        user.setUpdateTime(new Date());
        userMapper.insert(user);

        try {
            File fileEntity = new File();
            fileEntity.setUrl(user.getAvatar());
            fileEntity.setType("AVATAR");
            fileEntity.setUserId(user.getId());
            fileEntity.setCreateTime(new Date());
            fileMapper.insert(fileEntity);
        } catch (Exception e) {
            log.error("同步file表失败", e);
        }
        return true;
    }

    /**
     * 登录
     * @param username
     * @param password
     * @return
     */
    public User login(String username, String password) {
        User user = userMapper.selectByUsername(username);
        if (user == null) {
            throw new RuntimeException("用户名不存在");
        }
        if (!passwordEncoder.matches(password, user.getPassword())) {
            throw new RuntimeException("密码错误");
        }
        return user;
    }

    /**
     * 修改用户信息
     * @param userId
     * @param request
     * @return
     */
    @Transactional
    public boolean updateUserInfo(Long userId, UserUpdateRequest request) {
        // 1. 校验用户是否存在
        User user = getById(userId);
        if (user == null) {
            throw new RuntimeException("用户不存在");
        }

        // 2. 更新用户名
        user.setUsername(request.getUsername());
        user.setUpdateTime(new Date());

        // 3. 更新头像（如果传了新头像）
        if (request.getAvatar() != null && !request.getAvatar().isEmpty()) {
            user.setAvatar(request.getAvatar());
            // 新增新头像记录到file表
            File newAvatar = new File();
            newAvatar.setUrl(request.getAvatar());
            newAvatar.setType("AVATAR");
            newAvatar.setUserId(userId);
            newAvatar.setCreateTime(new Date());
            fileMapper.insert(newAvatar);
        }

        // 4. 更新用户表
        return updateById(user);
    }

    /**
     * 注销账号
     * @param userId
     * @return
     */
    @Transactional
    public boolean logout(Long userId) {
        // 1. 校验用户是否存在
        User user = getById(userId);
        if (user == null) {
            throw new RuntimeException("用户不存在");
        }

        // 2. 查询用户所有文章并删除（调用ArticleService的删除方法，自动级联删评论/点赞/收藏/文件）
        List<Article> userArticles = articleService.getArticlesByUserId(userId);
        for (Article article : userArticles) {
            articleService.deleteArticle(article.getId(), userId);
        }

        // 3. 删除用户的头像文件记录
        fileMapper.delete(new LambdaQueryWrapper<File>().eq(File::getUserId, userId).eq(File::getType, "AVATAR"));

        // 4. 删除用户本身
        return removeById(userId);
    }
}