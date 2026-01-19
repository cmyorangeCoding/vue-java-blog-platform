import service from './request'

// 获取所有Tag
export const getTagList = () => service.get('/tag', { skipAuth: true })