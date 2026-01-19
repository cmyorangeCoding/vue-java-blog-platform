import service from './request'

// 点赞/取消点赞
export const toggleLike = (articleId) => service.post(`/article/like/toggle/${articleId}`)

// 获取点赞数
export const getLikeCount = (articleId) => service.get(`/article/like/count/${articleId}`)

// 检查是否点赞
export const checkLike = (articleId) => service.get(`/article/like/check/${articleId}`)