package com.blog.aop;

import com.alibaba.fastjson.JSONObject;
import com.blog.config.TokenUtils; // 引入Token工具类
import com.blog.entity.OperateLog;
import com.blog.mapper.OperateLogMapper;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;
import java.util.Arrays;

@Slf4j
@Component
@Aspect
public class LogAspect {

    @Autowired
    private HttpServletRequest request;

    @Autowired
    private OperateLogMapper operateLogMapper;

    @Around("@annotation(com.blog.anno.Log)")
    public Object around(ProceedingJoinPoint joinPoint) throws Throwable {
        // 1. 复用TokenUtils获取用户ID
        Long userId = TokenUtils.getUserIdFromToken(request);
        //解析失败时设为0
        Integer operateUser = (userId == null) ? 0 : userId.intValue();

        // 2. 原有日志字段记录逻辑
        LocalDateTime operateTime = LocalDateTime.now();
        String className = joinPoint.getTarget().getClass().getName();
        String methodName = joinPoint.getSignature().getName();
        Object[] args = joinPoint.getArgs();
        String methodParams = Arrays.toString(args);
        String returnValue = null;
        Long costTime = 0L;

        // 3. 执行目标方法
        Object result = null;
        try {
            long begin = System.currentTimeMillis();
            result = joinPoint.proceed(); // 执行删除文章等核心逻辑
            long end = System.currentTimeMillis();
            costTime = end - begin;
            returnValue = JSONObject.toJSONString(result);
        } catch (Throwable e) {
            log.error("目标方法执行失败", e);
            returnValue = "方法执行异常：" + e.getMessage();
            throw e; // 抛出异常，让全局异常处理器处理
        }

        //4. 插入日志
        try {
            OperateLog operateLog = new OperateLog(
                    null, operateUser, operateTime, className,
                    methodName, methodParams, returnValue, costTime
            );
            operateLogMapper.insert(operateLog);
            log.info("AOP记录操作日志成功：{}", operateLog);
        } catch (Exception e) {
            log.error("插入操作日志失败（不影响核心业务）：{}", e.getMessage(), e);
        }

        return result;
    }
}