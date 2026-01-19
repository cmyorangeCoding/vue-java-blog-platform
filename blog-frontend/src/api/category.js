import service from './request'

// 获取所有分类
export const getCategoryList = () => service.get('/category', { skipAuth: true })