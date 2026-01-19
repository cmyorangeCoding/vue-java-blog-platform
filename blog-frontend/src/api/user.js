import service from './request'

// 注册
export const register = (data) => service.post('/user/register', data)

// 登录
export const login = (data) => service.post('/user/login', data)

// 获取用户信息
export const getUserInfo = (id) => service.get(`/user/${id}`)

// 获取公开用户信息（跳过鉴权），后端若允许匿名访问可返回基本用户名
export const getUserInfoPublic = (id) => service.get(`/user/${id}`, { skipAuth: true })
// 更新用户信息（用户名/头像）
export const updateUserInfo = (data) => service.put('/user/update', data)

// 注销账号
export const logout = () => service.delete('/user/logout')

// 按用户名搜索用户（后端需实现 /user/search?username=xxx）
export const searchUserByName = (username) => service.get('/user/search', { params: { username }, skipAuth: true })