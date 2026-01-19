import service from './request'

// 通用分页查询：/article/list
export const getArticles = (params = {}) => service.get('/article/list', { params, skipAuth: true })

// 按分类查询（支持分页）
export const getArticlesByCategory = (categoryId, pageNum = 1, pageSize = 10) =>
	service.get(`/article/category/${categoryId}`, { params: { pageNum, pageSize }, skipAuth: true })

// 按Tag查询（支持分页）
export const getArticlesByTag = (tagId, pageNum = 1, pageSize = 10) =>
	service.get(`/article/tag/${tagId}`, { params: { pageNum, pageSize }, skipAuth: true })

// 按用户查询（支持分页）
export const getUserArticleList = (userId, pageNum = 1, pageSize = 10) =>
	service.get(`/article/user/${userId}`, { params: { pageNum, pageSize } })

// 获取文章详情
export const getArticleDetail = (id) => service.get(`/article/${id}`, { skipAuth: true })

// 创建文章
export const createArticle = (data) => service.post('/article', data)

// 修改文章
export const updateArticle = (data) => service.put('/article', data)

// 删除文章
export const deleteArticle = (id) => service.delete(`/article/${id}`)