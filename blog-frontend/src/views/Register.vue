<template>
  <div class="register">
    <div class="github-card" style="max-width: 480px; margin: 2rem auto;">
      <div class="card-header">用户注册</div>
      <el-form :model="form" :rules="rules" ref="formRef" label-width="80px">
        <el-form-item label="用户名" prop="username">
          <el-input v-model="form.username" placeholder="请输入用户名"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input v-model="form.password" type="password" placeholder="请输入密码"></el-input>
        </el-form-item>
        <el-form-item label="确认密码" prop="checkPassword">
          <el-input v-model="form.checkPassword" type="password" placeholder="请确认密码"></el-input>
        </el-form-item>
        <el-form-item label="头像">
          <el-upload
            class="avatar-uploader"
            action="#"
            :show-file-list="false"
            :http-request="handleUploadAvatar"
            accept="image/*"
          >
            <!-- 关键：替换OSS域名为代理路径，解决跨域显示问题 -->
            <img 
              :src="normalizeUrl(form.avatar)" 
              class="avatar" 
            />
           
          </el-upload>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" class="github-btn primary" style="width: 100%;" @click="handleRegister">
            注册
          </el-button>
        </el-form-item>
      </el-form>
      <p style="text-align: center; margin-top: 1rem;">
        已有账号？<router-link to="/login" style="color: var(--github-primary);">立即登录</router-link>
      </p>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { register } from '../api/user'
// 1. 新增导入匿名上传接口
import { uploadAvatarAnonymous } from '../api/file'
import { setUser } from '../utils/auth'
import { formatOssUrl as normalizeUrl } from '../utils/formatUrl'

const router = useRouter()
const formRef = ref(null)
const form = ref({
  username: '',
  password: '',
  checkPassword: '',
  avatar: '' // 存储阿里云OSS的图片URL
})
const selectedFile = ref(null)

// 密码校验规则（保留）
const rules = ref({
  username: [{ required: true, message: '请输入用户名', trigger: 'blur' }],
  password: [{ required: true, message: '请输入密码', trigger: 'blur' }],
  checkPassword: [
    { required: true, message: '请确认密码', trigger: 'blur' },
    { validator: checkPassword, trigger: 'blur' }
  ]
})

// 密码一致性校验（保留）
function checkPassword(rule, value, callback) {
  if (value !== form.value.password) {
    callback(new Error('两次输入的密码不一致'))
  } else {
    callback()
  }
}

// 2. 重写头像上传方法：直接匿名上传到阿里云，不再本地预览
const handleUploadAvatar = async (options) => {
  const file = options.file
  selectedFile.value = file
  try {
    // 构建FormData
    const fd = new FormData()
    fd.append('file', file)
    // 调用匿名上传接口（后端新增的 /file/avatar/anonymous）
    const upRes = await uploadAvatarAnonymous(fd)
    if (upRes.code === 200) {
      // 保存阿里云返回的图片URL
      form.value.avatar = upRes.data
      // 告诉el-upload上传成功
      options.onSuccess && options.onSuccess({})
      ElMessage.success('头像上传成功')
    } else {
      throw new Error(upRes.msg || '头像上传失败')
    }
  } catch (e) {
    options.onError && options.onError(e)
    ElMessage.error('头像上传失败：' + e.message)
  }
}

// 3. 重写注册方法：携带头像URL注册，无需后续上传
const handleRegister = async () => {
  try {
    // 表单校验
    await formRef.value.validate()

    // 注册参数：新增avatar字段，传递阿里云图片URL
    const registerParams = {
      username: form.value.username,
      password: form.value.password,
      avatar: form.value.avatar // 关键：把OSS图片URL传给后端
    }

    // 调用注册接口
    const res = await register(registerParams)
    if (res.code === 200) {
      ElMessage.success('注册成功！请登录')
      // 跳转到登录页
      router.push('/login')
    } else {
      ElMessage.error(res.msg || '注册失败')
    }
  } catch (e) {
    // 统一异常处理
    if (e.response) {
      ElMessage.error(e.response.data.msg || '注册失败')
    } else if (e.message) {
      ElMessage.error(e.message)
    } else {
      ElMessage.error('网络异常，请重试')
    }
  }
}
</script>

<style scoped>
.register {
  padding: 2rem 0;
  min-height: calc(100vh - 80px);
  display: flex;
  align-items: center;
  justify-content: center;
}

.avatar-uploader .el-upload {
  border: 1px dashed var(--github-border);
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition: var(--el-transition-duration-fast);
}

.avatar-uploader .el-upload:hover {
  border-color: var(--github-primary);
}

.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  line-height: 178px;
  text-align: center;
}

.avatar {
  width: 178px;
  height: 178px;
  display: block;
}
</style>