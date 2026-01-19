import axios from 'axios'
import { getToken } from '../utils/auth'

// 创建axios实例
const service = axios.create({
  // 使用相对路径，使开发时通过 Vite proxy 转发到后端，避免浏览器 CORS
  baseURL: '/api',
  timeout: 5000
})

// 请求拦截器：添加Token
service.interceptors.request.use(
  (config) => {
    // 如果请求显式要求跳过鉴权（如注册时上传头像），则不注入 Authorization
    const token = getToken()
    if (!config.skipAuth && token) {
      config.headers.Authorization = token
    }
    return config
  },
  (error) => Promise.reject(error)
)

// 响应拦截器
service.interceptors.response.use(
  (response) => {
    const d = response.data
    // 兼容多种后端返回格式：
    // 1. 标准 { code, msg, data }
    // 2. 直接返回数据对象，如 { user, token } 或数组/对象
    if (d && typeof d === 'object') {
      if ('code' in d || 'data' in d) {
        return d
      }
      // 如果返回直接包含 token 或 user，包装为 { code:200, data: d }
      return { code: 200, msg: 'ok', data: d }
    }
    // 非对象（如纯文本），直接返回包装
    return { code: 200, msg: 'ok', data: d }
  },
  (error) => {
    // 只有在非跳过鉴权的请求上遇到 401 时才进行重定向
    if (error.response?.status === 401 && !error.config?.skipAuth) {
      window.location.href = '/login'
    }
    return Promise.reject(error)
  }
)

export default service