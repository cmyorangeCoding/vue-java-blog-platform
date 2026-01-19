import { ref } from 'vue'

// 使用响应式 ref 保存当前用户，方便组件根据登录状态自动更新
const storedUser = (() => {
  try {
    const raw = localStorage.getItem('blog_user')
    return raw ? JSON.parse(raw) : null
  } catch (e) {
    return null
  }
})()

export const currentUser = ref(storedUser)

// 存储用户信息（同时更新 localStorage 与 reactive state）
export const setUser = (user) => {
  currentUser.value = user
  try {
    localStorage.setItem('blog_user', JSON.stringify(user))
  } catch (e) {
    // ignore
  }
}

// 获取用户信息（直接返回 reactive value）
export const getUser = () => currentUser.value

// 判断是否登录（依赖 reactive currentUser）
export const isLogin = () => !!currentUser.value

// 退出登录
export const logout = () => {
  currentUser.value = null
  try {
    localStorage.removeItem('blog_user')
    localStorage.removeItem('blog_token')
  } catch (e) {
    // ignore
  }
}

// 存储token
export const setToken = (token) => {
  try {
    localStorage.setItem('blog_token', token)
  } catch (e) {
    // ignore
  }
}

// 获取token
export const getToken = () => {
  try {
    return localStorage.getItem('blog_token')
  } catch (e) {
    return null
  }
}