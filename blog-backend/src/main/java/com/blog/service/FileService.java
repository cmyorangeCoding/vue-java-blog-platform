package com.blog.service;

import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import com.aliyun.oss.model.CannedAccessControlList;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.blog.entity.File;
import com.blog.mapper.FileMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.InputStream;
import java.util.Date;
import java.util.UUID;

@Slf4j
@Service
public class FileService extends ServiceImpl<FileMapper, File> {

    @Value("${aliyun.oss.endpoint}")
    private String endpoint;
    @Value("${aliyun.oss.accessKeyId}")
    private String accessKeyId;
    @Value("${aliyun.oss.accessKeySecret}")
    private String accessKeySecret;
    @Value("${aliyun.oss.bucketName}")
    private String bucketName;
    @Value("${aliyun.oss.prefix:blog/}")
    private String prefix;

    @Resource
    private FileMapper fileMapper;

    /**
     * 上传头像
     * @param file
     * @param userId
     * @return
     */
    public String uploadAvatar(MultipartFile file, Long userId) {
        // 不管是否匿名，强制调用upload并插入file表
        return upload(file, "AVATAR", userId, null, false);
    }

    /**
     * 上传文章图片
     * @param file
     * @param userId
     * @param articleId
     * @return
     */
    public String uploadArticleImage(MultipartFile file, Long userId, Long articleId) {
        // 文章图片必须有userId
        return upload(file, "ARTICLE", userId, articleId, false);
    }


    /**
     * 核心 upload 方法
     * @param file
     * @param type
     * @param userId
     * @param articleId
     * @param isAnonymous
     * @return
     */
    private String upload(MultipartFile file, String type, Long userId, Long articleId, boolean isAnonymous) {
        try {
            // 1. 校验文件
            if (file.isEmpty()) throw new IllegalArgumentException("文件为空");
            String originalFilename = file.getOriginalFilename();
            String ext = originalFilename.substring(originalFilename.lastIndexOf("."));
            String fileName = prefix + type + "/" + UUID.randomUUID() + ext;

            // 2. 上传到OSS
            OSS ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);
            InputStream inputStream = file.getInputStream();
            ossClient.putObject(bucketName, fileName, inputStream);
            // 强制设置文件为公共读
            ossClient.setObjectAcl(bucketName, fileName, CannedAccessControlList.PublicRead);
            inputStream.close();
            ossClient.shutdown();

            // 3. 拼接正确URL
            String url = "https://" + bucketName + "." + endpoint + "/" + fileName;
            url = url.replaceAll("https://+", "https://"); // 去重

            // 4. 强制插入file表
            File fileEntity = new File();
            fileEntity.setUrl(url);
            fileEntity.setType(type);
            fileEntity.setUserId(userId); // 这里的userId是前端注册后传的user.id
            fileEntity.setArticleId(articleId);
            fileEntity.setCreateTime(new Date());
            fileMapper.insert(fileEntity); // 强制写入file表

            return url;
        } catch (Exception e) {
            log.error("上传失败", e);
            throw new RuntimeException("文件上传失败");
        }
    }
}