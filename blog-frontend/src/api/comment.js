import service from './request'

// 新增评论
export const addComment = (articleId, content) => service.post(`/article/comment/add/${articleId}`, { content })

// 删除评论
export const deleteComment = (id) => service.delete(`/article/comment/delete/${id}`)

// 获取评论列表
export const getCommentList = (articleId) => service.get(`/article/comment/list/${articleId}`, { skipAuth: true })

// 回复评论
export const replyComment = (articleId, parentId, content) => service.post(`/article/comment/reply/${articleId}/${parentId}`, { content })