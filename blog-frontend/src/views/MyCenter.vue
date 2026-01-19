<template>
  <div class="my-center">
    <div class="github-card" style="max-width: 800px; margin: 0 auto;">
      <!-- 用户信息卡片 -->
      <div class="user-info" style="display: flex; gap: 2rem; margin-bottom: 2rem; padding-bottom: 2rem; border-bottom: 1px solid var(--github-border);">
        <div class="avatar" style="width: 100px; height: 100px; border-radius: 50%; overflow: hidden; border: 1px solid var(--github-border);">
          <img :src="normalizeUrl(userInfo.avatar) || 'https://picsum.photos/100/100'" alt="头像" style="width: 100%; height: 100%; object-fit: cover;">
        </div>
        <div class="user-detail">
          <div style="display:flex; gap:1rem; align-items:center;">
            <h3 style="font-size: 1.25rem; font-weight: 600; margin:0">{{ userInfo.username }}</h3>
            <el-button size="small" @click="toggleEdit">{{ editing ? '取消' : '编辑资料' }}</el-button>
            <el-button size="small" type="danger" @click="handleLogout">注销账号</el-button>
          </div>
          <p style="color: #6b7280; margin-top: 0.5rem;">注册时间：{{ formatTime(userInfo.createTime) }}</p>
          <p style="color: #6b7280; margin-top: 0.25rem;">我的文章数：{{ myArticleList.length }}</p>
          <!-- 编辑表单 -->
          <div v-if="editing" style="margin-top:1rem;">
            <el-form label-position="top">
              <el-form-item label="用户名">
                <el-input v-model="editForm.username"></el-input>
              </el-form-item>
              <el-form-item label="头像">
                <el-upload
                  :before-upload="(file) => { handleAvatarChange(file); return false }"
                  :show-file-list="false"
                >
                  <el-button size="mini">上传头像</el-button>
                </el-upload>
                <span style="margin-left: 0.5rem; color:#6b7280">已上传：{{ editForm.avatar ? '是' : '否' }}</span>
              </el-form-item>
              <el-form-item>
                <el-button type="primary" @click="handleSaveProfile" :loading="uploading">保存</el-button>
                <el-button @click="toggleEdit">取消</el-button>
              </el-form-item>
            </el-form>
          </div>
        </div>
      </div>
      <!-- 我的收藏列表 -->
      <div class="my-collects" style="margin-top: 2rem;">
        <div class="card-header">我的收藏</div>
        <div v-loading="loading" class="article-list">
          <div
            v-for="item in myCollectList"
            :key="item.id"
            class="article-item"
            style="display: flex; justify-content: space-between; align-items: center; padding: 0.75rem 0; border-bottom: 1px solid var(--github-border);"
          >
            <div style="flex: 1;">
              <router-link
                v-if="extractArticleId(item)"
                class="article-title"
                :to="`/article/${extractArticleId(item)}`"
              >
                {{ item.title || item.articleTitle || item.article?.title || '未命名文章' }}
              </router-link>
              <span v-else class="article-title">{{ item.title || item.articleTitle || item.article?.title || '未命名文章' }}</span>
              <p style="color: #6b7280; font-size: 0.875rem; margin-top: 0.25rem;">
                发布时间：{{ formatTime(item.createTime || item.articleCreateTime || (item.article && item.article.createTime)) }} | 分类：{{ getCategoryName(item.categoryId || item.articleCategoryId || (item.article && item.article.categoryId)) }}
              </p>
            </div>
          </div>
        </div>

        <div v-if="myCollectList.length === 0" style="color: #6b7280; text-align: center; padding: 2rem;">
          暂无收藏，去文章页看看吧～
        </div>
      </div>
      <!-- 我的文章列表 -->
      <div class="my-articles">
        <div class="card-header">我的文章</div>
        <el-button class="github-btn primary" style="margin-bottom: 1rem;" @click="goToCreateArticle">
          新建文章
        </el-button>
        
        <!-- 文章列表 -->
        <div v-loading="loading" class="article-list">
          <div 
            v-for="article in myArticleList" 
            :key="article.id" 
            class="article-item"
            style="display: flex; justify-content: space-between; align-items: center; padding: 0.75rem 0; border-bottom: 1px solid var(--github-border);"
          >
            <div style="flex: 1;">
              <a class="article-title" @click="goToArticleDetail(article.id)">{{ article.title }}</a>
              <p style="color: #6b7280; font-size: 0.875rem; margin-top: 0.25rem;">
                发布时间：{{ formatTime(article.createTime) }} | 分类：{{ getCategoryName(article.categoryId) }}
              </p>
            </div>
            <div style="display: flex; gap: 1rem;">
              <button class="github-btn" @click="goToEditArticle(article.id)">编辑</button>
              <button class="github-btn danger" @click="handleDeleteArticle(article.id)">删除</button>
            </div>
          </div>
        </div>
        
        <div v-if="myArticleList.length === 0" style="color: #6b7280; text-align: center; padding: 2rem;">
          暂无文章，快去创建你的第一篇文章吧～
        </div>

        <div style="text-align:center; margin-top:1rem;">
          <el-pagination
            background
            :current-page="myArticlePageNum"
            :page-size="myArticlePageSize"
            :total="myArticleTotal"
            :page-sizes="[5,10,20]"
            layout="total, sizes, prev, pager, next, jumper"
            @current-change="handleMyArticlesPageChange"
            @size-change="handleMyArticlesSizeChange"
          />
        </div>
      </div>
    </div>
  </div>
</template>
<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import { getUserInfo, updateUserInfo, logout as apiLogout } from '../api/user'
import { normalizeUrl } from '../utils/url'
import { getUserArticleList, deleteArticle } from '../api/article'
import { getUserCollectList } from '../api/collect'
import { getCategoryList } from '../api/category'
import { getUser, setUser, logout as authLogout } from '../utils/auth'
import { uploadAvatar } from '../api/file'

const router = useRouter()
const loading = ref(false)
const userInfo = ref({})
const myArticleList = ref([])
const myArticlePageNum = ref(1)
const myArticlePageSize = ref(10)
const myArticleTotal = ref(0)
const myArticlePages = ref(0)
const myCollectList = ref([])
const categoryList = ref([])
const editing = ref(false)
const editForm = ref({
  username: '',
  avatar: ''
})
const uploading = ref(false)

// 格式化时间
const formatTime = (time) => {
  return new Date(time).toLocaleString()
}

// 获取分类名称
const getCategoryName = (categoryId) => {
  const category = categoryList.value.find(item => item.id === categoryId)
  return category ? category.name : '未分类'
}

// 加载用户信息和文章
const loadData = async () => {
  loading.value = true
  try {
    const user = getUser()
    if (!user) {
      router.push('/login')
      return
    }
    // 1. 加载用户信息
    const userRes = await getUserInfo(user.id)
    userInfo.value = userRes.data
    // 初始化编辑表单
    editForm.value.username = userInfo.value.username || ''
    editForm.value.avatar = userInfo.value.avatar || ''
    // 2. 加载分类列表
    const categoryRes = await getCategoryList()
    categoryList.value = categoryRes.data
    // 3. 加载用户的文章（接口支持分页）
    await loadUserArticles(user.id, myArticlePageNum.value, myArticlePageSize.value)
    // 4. 加载用户的收藏（如果后端提供）
    try {
      const collectRes = await getUserCollectList(user.id)
      myCollectList.value = collectRes.data || []
    } catch (e) {
      // 如果后端无该接口，忽略错误
      myCollectList.value = []
    }
  } catch (e) {
    ElMessage.error('加载数据失败')
    console.error(e)
  } finally {
    loading.value = false
  }
}

// 跳转新建文章
const goToCreateArticle = () => {
  router.push('/article/create')
}

// 切换编辑模式
const toggleEdit = () => {
  editing.value = !editing.value
  if (!editing.value) {
    // 取消编辑，重置为当前用户信息
    editForm.value.username = userInfo.value.username || ''
    editForm.value.avatar = userInfo.value.avatar || ''
  }
}

// 头像上传处理（使用 uploadAvatar）
const handleAvatarChange = async (file) => {
  // file 是原生 file 对象
  const fd = new FormData()
  fd.append('file', file)
  uploading.value = true
  try {
    const res = await uploadAvatar(fd)
    const d = res && (res.data !== undefined ? res.data : res)
    // 后端应返回 avatar 字段或 URL 在 d.url / d.data
    const avatarUrl = d?.data || d?.url || d?.path || d?.avatar || d
    editForm.value.avatar = avatarUrl
    ElMessage.success('头像上传成功')
  } catch (e) {
    ElMessage.error('头像上传失败')
  } finally {
    uploading.value = false
  }
}

// 提交更新用户信息
const handleSaveProfile = async () => {
  try {
    const payload = {
      username: editForm.value.username,
      avatar: editForm.value.avatar
    }
    const res = await updateUserInfo(payload)
    if (res && res.code === 200) {
      ElMessage.success('资料更新成功')
      // 刷新用户信息并更新全局状态
      const user = getUser()
      const userRes = await getUserInfo(user.id)
      const fresh = userRes.data
      setUser(fresh)
      userInfo.value = fresh
      editing.value = false
    } else {
      ElMessage.error('更新失败')
    }
  } catch (e) {
    ElMessage.error('更新失败')
  }
}

// 注销账号处理
const handleLogout = async () => {
  try {
    await ElMessageBox.confirm('确定要注销账号吗？注销后将跳转为游客主页。', '确认注销', { type: 'warning' })
    await apiLogout()
    // 清本地登录信息
    authLogout()
    // 跳转到首页（游客）
    router.push('/')
  } catch (e) {
    // 取消或失败
  }
}

// 从不同后端返回结构中提取真实文章ID
const extractArticleId = (item) => {
  if (!item) return null
  return item.id || item.articleId || item.article_id || (item.article && item.article.id) || item.articleId || null
}

// 跳转文章详情（兼容收藏列表中可能的不同字段）
const goToArticleDetail = (idOrItem) => {
  let id = idOrItem
  if (typeof idOrItem === 'object') {
    id = extractArticleId(idOrItem)
  }
  if (!id) {
    ElMessage.error('无法识别文章ID')
    return
  }
  router.push(`/article/${id}`)
}

// 跳转编辑文章
const goToEditArticle = (id) => {
  router.push(`/article/edit/${id}`)
}

// 删除文章
const handleDeleteArticle = async (id) => {
  try {
    await ElMessageBox.confirm('确定删除这篇文章吗？删除后不可恢复！', '提示', { type: 'warning' })
    await deleteArticle(id)
    ElMessage.success('文章删除成功')
    // 重新加载文章列表
    const user = getUser()
    await loadUserArticles(user.id, myArticlePageNum.value, myArticlePageSize.value)
  } catch (e) {
    ElMessage.info('已取消删除')
  }
}

// 加载用户文章（分页）
const loadUserArticles = async (userId, page = 1, size = 10) => {
  loading.value = true
  try {
    const articleRes = await getUserArticleList(userId, page, size)
    const artData = articleRes && (articleRes.data !== undefined ? articleRes.data : articleRes)
    myArticleList.value = Array.isArray(artData.list) ? artData.list : (Array.isArray(artData) ? artData : [])
    myArticleTotal.value = artData.total || 0
    myArticlePages.value = artData.pages || 0
    myArticlePageNum.value = artData.pageNum || page
    myArticlePageSize.value = artData.pageSize || size
  } catch (e) {
    myArticleList.value = []
    myArticleTotal.value = 0
    myArticlePages.value = 0
  } finally {
    loading.value = false
  }
}

const handleMyArticlesPageChange = async (newPage) => {
  const user = getUser()
  myArticlePageNum.value = newPage
  await loadUserArticles(user.id, myArticlePageNum.value, myArticlePageSize.value)
}

const handleMyArticlesSizeChange = async (newSize) => {
  const user = getUser()
  myArticlePageSize.value = newSize
  myArticlePageNum.value = 1
  await loadUserArticles(user.id, myArticlePageNum.value, myArticlePageSize.value)
}

onMounted(() => {
  loadData()
})
</script>
<style scoped>
.my-center {
  padding: 2rem 0;
}

.article-title {
  font-weight: 600;
  color: var(--github-primary);
  text-decoration: none;
  font-size: 1rem;
}

.article-title:hover {
  text-decoration: underline;
}
</style>
