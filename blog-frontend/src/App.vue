<template>
  <div id="app">
    <!-- PageLab 头部 -->
    <header class="github-header">
      <div class="header-content">
        <router-link to="/" class="logo pagelab-logo">
          <span class="pagelab-brand">PageLab</span>
          <span class="pagelab-slogan">让每一页都有力量</span>
        </router-link>
        <nav class="nav-links">
          <router-link to="/" class="nav-link">首页</router-link>
          <template v-if="isLoginState">
            <router-link to="/my-center" class="nav-link">个人中心</router-link>
            <router-link to="/article/create" class="nav-link">写文章</router-link>
            <a class="nav-link" @click="handleLogout">退出</a>
          </template>
          <template v-else>
            <router-link to="/login" class="nav-link">登录</router-link>
            <router-link to="/register" class="nav-link">注册</router-link>
          </template>

        </nav>
      </div>
    </header>
    <!-- 主体内容 -->
    <main class="container">
      <router-view />
    </main>
  </div>
</template>
<script setup>
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'
import { isLogin, logout } from './utils/auth'

const router = useRouter()
const isLoginState = computed(() => isLogin())

const handleLogout = () => {
  logout()
  router.push('/login')
}


</script>
<style>
#app {
  min-height: 100vh;
}

.pagelab-logo {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
}
.pagelab-brand {
  font-size: 24px;
  font-weight: 800;
  color: var(--pagelab-orange);
  line-height: 1;
}
.pagelab-slogan {
  font-size: 12px;
  color: #666666;
  font-style: italic;
  font-weight: 400;
  margin-top: 2px;
}
</style>
