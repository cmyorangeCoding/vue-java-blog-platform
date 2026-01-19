<template>
  <div class="home">
    <div class="github-card" style="max-width: 800px; margin: 0 auto;">
      <!-- 搜索与筛选栏：标题搜索、用户名搜索、分类、Tag -->
      <div class="filter-bar" style="display:flex; gap:1rem; margin-bottom:0.5rem; align-items:center; flex-wrap:wrap;">
        <div class="filter-left" style="display:flex; gap:0.75rem; align-items:center; width:100%;">
          <el-input v-model="searchQuery" placeholder="搜索：标题或用户名" clearable style="flex:1; min-width:260px;" @keyup.enter.native="onSearchEnter" @clear="handleInputClear"></el-input>
          <el-button class="github-btn primary" @click="onSearchClick">查询</el-button>
          <el-button class="github-btn secondary" @click="clearSearch" style="margin-left:6px;">清空</el-button>
        </div>
      </div>
      <div class="filter-row-secondary" style="display:flex; gap:0.75rem; margin-bottom:1rem; align-items:center;">
        <el-select v-model="selectedCategory" placeholder="分类" @change="handleCategoryChange" style="width:220px;">
          <el-option label="分类全部" :value="0"></el-option>
          <el-option v-for="item in categoryList" :key="item.id" :label="item.name" :value="item.id"></el-option>
        </el-select>
        <el-select v-model="selectedTag" placeholder="Tag" @change="handleTagChange" style="width:200px;">
          <el-option label="Tag全部" :value="0"></el-option>
          <el-option v-for="item in tagList" :key="item.id" :label="item.name" :value="item.id"></el-option>
        </el-select>
      </div>
      <!-- 文章列表 -->
      <div class="card-header card-header--accent">最新文章</div>
      <div v-loading="loading">
        <div v-for="article in articleList" :key="article.id" class="article-item" style="padding: 1rem 0; border-bottom: 1px solid var(--github-border);">
          <router-link :to="`/article/${article.id}`" class="article-title">{{ article.title }}</router-link>
          <div style="display:flex; align-items:center; gap:0.75rem; color: #6b7280; margin-top: 0.5rem;">
            <img :src="normalizeUrl(article.authorAvatar || defaultAvatar)" alt="avatar" style="width:28px; height:28px; border-radius:50%; object-fit:cover;">
            <div style="font-size:0.95rem;">
              <span style="color:#000; margin-right:6px;">{{ article.authorName || getArticleAuthorName(article) }}</span>
              <span style="color:#6b7280;">| 发布时间：{{ formatTime(article.createTime) }} | 分类：{{ getCategoryName(article.categoryId) }}</span>
            </div>
          </div>
        </div>
        <div v-if="articleList.length === 0" style="color: #6b7280; text-align: center; padding: 2rem;">
          暂无文章～
        </div>
        <div style="text-align:center; margin-top:1rem;">
              <el-pagination
                background
                :current-page="pageNum"
                :page-size="pageSize"
                :total="total"
                :page-sizes="[5,10,20]"
                layout="total, sizes, prev, pager, next, jumper"
                @current-change="handlePageChange"
                @size-change="handleSizeChange"
              />
        </div>
      </div>
    </div>
  </div>
</template>
<script setup>
import { ref, onMounted, computed } from 'vue'
import { getArticles, getArticlesByCategory, getArticlesByTag } from '../api/article'
import { getCategoryList } from '../api/category'
import { getTagList } from '../api/tag'
import { getUser } from '../utils/auth'
import { normalizeUrl } from '../utils/url'
import { ElMessage } from 'element-plus'

const loading = ref(false)
const defaultAvatar = 'data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 24 24" fill="%23d1d5db"><rect width="100%" height="100%" rx="4" ry="4" fill="%23e5e7eb"/><g fill="%239ca3af"><circle cx="12" cy="8" r="3"/><path d="M12 14c-4 0-6 2-6 4v1h12v-1c0-2-2-4-6-4z"/></g></svg>'
const articleList = ref([])
const categoryList = ref([])
const tagList = ref([])
const selectedCategory = ref(0)
const selectedTag = ref(0)
const searchQuery = ref('')
const pageNum = ref(1)
const pageSize = ref(10)
const total = ref(0)
const pages = ref(0)

// 格式化时间
const formatTime = (time) => {
  return new Date(time).toLocaleString()
}

// 获取分类名称
const getCategoryName = (categoryId) => {
  const list = Array.isArray(categoryList.value) ? categoryList.value : []
  const category = list.find(item => item.id === categoryId)
  return category ? category.name : '未分类'
}

// 加载基础数据
const loadBaseData = async () => {
  pageNum.value = 1
  loading.value = true
  try {
    const [categoryRes, tagRes, articleRes] = await Promise.all([
      getCategoryList(),
      getTagList(),
      // 使用新的通用分页接口，默认第一页每页10条
      getArticles({ pageNum: pageNum.value, pageSize: pageSize.value })
    ])

    // 兼容不同后端响应：分类/标签仍可能返回数组，文章接口返回分页对象
    const normalizeArray = (res) => {
      const d = res && (res.data !== undefined ? res.data : res)
      return Array.isArray(d) ? d : []
    }

    categoryList.value = normalizeArray(categoryRes)
    tagList.value = normalizeArray(tagRes)
    // 文章分页返回 { list, total, pageNum, pageSize, pages }
    const artData = articleRes && (articleRes.data !== undefined ? articleRes.data : articleRes)
    articleList.value = Array.isArray(artData.list) ? artData.list : (Array.isArray(artData) ? artData : [])
    total.value = artData.total || 0
    pages.value = artData.pages || 0
    pageNum.value = artData.pageNum || 1

    // 作者信息由后端直接返回（authorName / authorAvatar），无需前端再请求
  } catch (e) {
    console.error('加载数据失败：', e)
  } finally {
    loading.value = false
  }
}

// 按分类筛选（允许与 Tag 组合）
const handleCategoryChange = async () => {
  pageNum.value = 1
  await handleSearch()
}

// 按Tag筛选（允许与 分类 组合）
const handleTagChange = async () => {
  pageNum.value = 1
  await handleSearch()
}

// 作者信息由后端直接返回（authorName / authorAvatar）

// 搜索主函数：支持 title、username->userId、categoryId、tagId、分页
const handleSearch = async (append = false) => {
  loading.value = true
  try {
    const q = searchQuery.value && searchQuery.value.trim() ? searchQuery.value.trim() : undefined
    // 使用后端统一的 list 接口并传入 keyword（后端会把 keyword 匹配标题/用户名），同时传分类/Tag和分页
    const params = {
      keyword: q || undefined,
      categoryId: selectedCategory.value && selectedCategory.value !== 0 ? selectedCategory.value : undefined,
      tagId: selectedTag.value && selectedTag.value !== 0 ? selectedTag.value : undefined,
      pageNum: pageNum.value,
      pageSize: pageSize.value
    }

    const res = await getArticles(params)
    const d = res && (res.data !== undefined ? res.data : res)
    const list = Array.isArray(d.list) ? d.list : (Array.isArray(d) ? d : [])
    articleList.value = list
    total.value = d.total || 0
    pages.value = d.pages || 0
    pageNum.value = d.pageNum || pageNum.value
    // 作者信息由后端返回，前端无需额外解析
    
    // 说明：后端已合并用户名与标题匹配，前端不再同时调用两条接口或进行本地合并
  } catch (e) {
    console.error('搜索失败', e)
  } finally {
    loading.value = false
  }
}

// 分页切换
const handlePageChange = async (newPage) => {
  pageNum.value = newPage
  await handleSearch()
}

const handleSizeChange = async (newSize) => {
  pageSize.value = newSize
  pageNum.value = 1
  await handleSearch()
}

// 清空所有筛选并重新加载第一页文章
const clearSearch = async () => {
  searchQuery.value = ''
  selectedCategory.value = 0
  selectedTag.value = 0
  pageNum.value = 1
  pageSize.value = 10
  await loadBaseData()
}

// 输入框右侧的清除（×）按钮被点击时处理：仅在移动端触发完整的清空逻辑
const handleInputClear = async () => {
  try {
    if (typeof window !== 'undefined' && window.innerWidth <= 600) {
      await clearSearch()
    }
  } catch (e) {
    // ignore
  }
}

// 搜索触发器：点击或回车时先将页码设为1再搜索
const onSearchClick = async () => {
  pageNum.value = 1
  await handleSearch()
}

const onSearchEnter = async () => {
  pageNum.value = 1
  await handleSearch()
}

onMounted(() => {
  loadBaseData()
})

// 当前登录用户（用于在列表中优先显示本地用户名）
const currentUser = computed(() => getUser())
const currentUserId = computed(() => currentUser.value?.id || '')

// 获取文章作者名（兼容后端多种返回结构）
const getArticleAuthorName = (a) => {
  if (!a) return '用户'
  if (a.authorName) return a.authorName
  if (a.user) return a.user.username || a.user.nickName || a.user.name || `用户${a.user.id || ''}`
  if (a.username) return a.username
  if (a.userName) return a.userName
  if (String(a.userId) === String(currentUserId.value) && currentUser.value && currentUser.value.username) {
    return currentUser.value.username
  }
  return `用户${a.userId || ''}`
}
</script>
<style scoped>
.home {
  padding: 2rem 0;
}

.article-title {
  font-size: 1.1rem;
  font-weight: 600;
  color: var(--github-primary);
  text-decoration: none;
}

.article-title:hover {
  text-decoration: underline;
}
</style>
