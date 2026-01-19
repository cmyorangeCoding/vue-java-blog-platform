import { createRouter, createWebHistory } from 'vue-router'
import Home from '../views/Home.vue'
import { isLogin } from '../utils/auth'

// 登录拦截
const requireAuth = (to, from, next) => {
  if (isLogin()) {
    next()
  } else {
    next('/login')
  }
}

const routes = [
  { path: '/', component: Home },
  { path: '/login', component: () => import('../views/Login.vue') },
  { path: '/register', component: () => import('../views/Register.vue') },
  { path: '/article/:id', component: () => import('../views/ArticleDetail.vue') },
  { path: '/article/create', component: () => import('../views/ArticleCreate.vue'), beforeEnter: requireAuth },
  { path: '/article/edit/:id', component: () => import('../views/ArticleEdit.vue'), beforeEnter: requireAuth },
  { path: '/my-center', component: () => import('../views/MyCenter.vue'), beforeEnter: requireAuth }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router