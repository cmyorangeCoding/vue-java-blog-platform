<template>
  <div class="login">
    <div class="github-card" style="max-width: 480px; margin: 2rem auto;">
      <div class="card-header">用户登录</div>
      <el-form :model="form" :rules="rules" ref="formRef" label-width="80px">
        <el-form-item label="用户名" prop="username">
          <el-input v-model="form.username" placeholder="请输入用户名"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input v-model="form.password" type="password" placeholder="请输入密码"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" class="github-btn primary" style="width: 100%;" @click="handleLogin">
            登录
          </el-button>
        </el-form-item>
      </el-form>
      <p style="text-align: center; margin-top: 1rem;">
        还没有账号？<router-link to="/register" style="color: var(--github-primary);">立即注册</router-link>
      </p>
    </div>
  </div>
</template>
<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { login } from '../api/user'
import { setUser, setToken } from '../utils/auth'

const router = useRouter()
const formRef = ref(null)
const form = ref({
  username: '',
  password: ''
})

const rules = ref({
  username: [{ required: true, message: '请输入用户名', trigger: 'blur' }],
  password: [{ required: true, message: '请输入密码', trigger: 'blur' }]
})

const handleLogin = async () => {
  try {
    await formRef.value.validate()
    const res = await login(form.value)
        if (res.code === 200) {
      // 存储用户信息和Token
      setUser(res.data.user)
      setToken(res.data.token)
      ElMessage.success('登录成功')
      router.push('/')
    } else {
      ElMessage.error(res.msg)
    }
  } catch (e) {
    if (e.response) {
      ElMessage.error(e.response.data.msg || '登录失败')
    } else {
      ElMessage.error('网络异常，请重试')
    }
  }
}
</script>
<style scoped>
.login {
  padding: 2rem 0;
  min-height: calc(100vh - 80px);
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>
