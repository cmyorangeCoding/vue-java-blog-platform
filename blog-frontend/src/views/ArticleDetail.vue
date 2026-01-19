<template>
  <div class="article-detail">
    <div class="github-card" style="max-width: 800px; margin: 0 auto;">
      <!-- 文章内容 -->
      <div v-loading="loading" v-if="article && Object.keys(article).length">
        <h1 class="article-title" style="margin-bottom: 1rem;">{{ article.title }}</h1>
        <p style="color: #6b7280; margin-bottom: 2rem; padding-bottom: 1rem; border-bottom: 1px solid var(--github-border); display:flex; align-items:center; gap:0.75rem;">
          <img :src="normalizeUrl(article.authorAvatar || defaultAvatar)" alt="avatar" style="width:36px; height:36px; border-radius:50%; object-fit:cover;">
          <span style="color:#000; font-weight:700;">{{ article.authorName || getArticleAuthorName(article) }}</span>
          <span style="color:#6b7280;">| 发布时间：{{ formatTime(article.createTime) }} | 分类：{{ getCategoryName(article.categoryId) }}</span>
        </p>
        <div class="article-content" style="line-height: 1.8; font-size: 1rem; margin-bottom: 2rem;" v-html="formatContent(article.content)"></div>
        <!-- 点赞/收藏 -->
        <div class="article-actions" style="display: flex; gap: 2rem; margin-bottom: 2rem; padding-bottom: 1rem; border-bottom: 1px solid var(--github-border);">
          <button class="github-btn" @click="handleLike" :style="{ color: isLike ? 'var(--github-danger)' : '' }">
            👍 {{ likeCount }}
          </button>
          <button class="github-btn" @click="handleCollect" :style="{ color: isCollect ? 'var(--github-primary)' : '' }">
            ⭐ {{ collectCount }}
          </button>
          <button class="github-btn danger" v-if="isAuthor" @click="handleDelete">删除文章</button>
          <button class="github-btn" v-if="isAuthor" @click="handleEdit">编辑文章</button>
        </div>
        <!-- 评论区 -->
        <div class="comment-section">
          <div class="card-header">评论区 ({{ commentList.length }})</div>
          <!-- 新增评论 -->
          <el-form v-if="isLogin" :model="commentForm" style="margin: 1rem 0;">
            <el-form-item>
              <el-input
                v-model="commentForm.content"
                type="textarea"
                :rows="3"
                placeholder="请输入评论"
              ></el-input>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" class="github-btn primary" @click="handleAddComment">发布评论</el-button>
            </el-form-item>
          </el-form>
          <p v-else style="color: #6b7280; margin: 1rem 0;">
            <router-link to="/login" style="color: var(--github-primary);">登录</router-link> 后可发表评论
          </p>
          <!-- 评论列表（递归渲染） -->
          <div>
            <template v-for="c in commentList" :key="c.id">
              <CommentItem :comment="c" :level="0" />
            </template>
          </div>
        </div>
      </div>
      <div v-else style="padding:2rem;text-align:center;color:#6b7280;">
        该文章不存在或已被删除。
      </div>
    </div>
  </div>
</template>
<script setup>
import { ref, onMounted, computed, reactive, h } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import { getArticleDetail, deleteArticle } from '../api/article'
import { getCategoryList } from '../api/category'
import { toggleLike, getLikeCount, checkLike } from '../api/like'
import { toggleCollect, getCollectCount, checkCollect } from '../api/collect'
import { addComment, getCommentList, deleteComment, replyComment } from '../api/comment'
import { getUser, isLogin } from '../utils/auth'

// 默认头像（SVG data URL）
const defaultAvatar = 'data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 24 24" fill="%23d1d5db"><rect width="100%" height="100%" rx="4" ry="4" fill="%23e5e7eb"/><g fill="%239ca3af"><circle cx="12" cy="8" r="3"/><path d="M12 14c-4 0-6 2-6 4v1h12v-1c0-2-2-4-6-4z"/></g></svg>'

const router = useRouter()
const route = useRoute()
const loading = ref(false)
const article = ref({})
const categoryList = ref([])
const likeCount = ref(0)
const collectCount = ref(0)
const isLike = ref(false)
const isCollect = ref(false)
const commentList = ref([])
const commentForm = ref({
  content: ''
})
// 回复管理：记录当前正在回复的评论ID及每个评论的回复内容
const replyToId = ref(null)
const replyMap = reactive({})

const handleReplyClick = (id) => {
  if (!isLoginState.value) {
    ElMessage.warning('请先登录')
    router.push('/login')
    return
  }
  replyToId.value = id
  replyMap[id] = replyMap[id] || ''
}

const handleSubmitReply = async (parentId) => {
  try {
    const articleId = article.value.id
    const content = (replyMap[parentId] || '').trim()
    if (!content) {
      ElMessage.warning('请输入回复内容')
      return
    }
    await replyComment(articleId, parentId, content)
    ElMessage.success('回复成功')
    replyMap[parentId] = ''
    replyToId.value = null
    // 刷新评论列表
    const commentRes = await getCommentList(articleId)
    commentList.value = commentRes.data
  } catch (e) {
    ElMessage.error('回复失败')
  }
}

// 递归渲染评论项（使用 render 函数以便递归）
const CommentItem = {
  name: 'CommentItem',
  props: {
    comment: { type: Object, required: true },
    level: { type: Number, default: 0 }
  },
  setup(props) {
    return () => {
      const c = props.comment
      const indent = { marginLeft: `${props.level * 20}px`, marginBottom: '12px' }
      const avatarSrc = normalizeUrl(c.commenterAvatar || c.authorAvatar || defaultAvatar)
      const authorText = c.commenterName || c.authorName || c._authorName || getCommentUserName(c)

      const header = h('div', { style: { display: 'flex', justifyContent: 'space-between' } }, [
        h('div', { style: { display: 'flex', gap: '0.75rem', alignItems: 'flex-start' } }, [
          h('img', { src: avatarSrc, alt: 'avatar', style: 'width:28px; height:28px; border-radius:50%; object-fit:cover; margin-top:4px;' }),
          h('div', null, [
            h('p', { style: 'font-weight:600; margin:0;' }, authorText),
            h('p', { style: 'margin-top:0.5rem;' }, c.content),
            h('p', { style: 'color:#6b7280; font-size:0.875rem; margin-top:0.5rem;' }, formatTime(c.createTime)),
            h('div', null, [
              h('a', { style: 'cursor:pointer;color:var(--github-primary);margin-right:8px;', onClick: () => handleReplyClick(c.id) }, '回复')
            ])
          ])
        ]),
        String(c.userId) === String(currentUserId.value) ? h('a', { class: 'text-danger-link', style: 'cursor:pointer;', onClick: () => handleDeleteComment(c.id) }, '删除') : null
      ])

      const replyArea = replyToId.value === c.id ? h('div', { style: 'margin-top:8px; margin-left:34px;' }, [
        h('textarea', { value: replyMap[c.id] || '', placeholder: '请输入回复', onInput: (e) => { replyMap[c.id] = e.target.value }, style: 'width:100%; min-height:72px; padding:8px; border:1px solid var(--github-border); border-radius:4px;' }),
        h('div', { style: 'margin-top:8px; display:flex; gap:8px;' }, [
          h('button', { class: 'github-btn primary', onClick: () => handleSubmitReply(c.id), style: 'background:var(--github-primary); color:white; padding:6px 12px; border-radius:6px; border:none;' }, '提交回复'),
          h('button', { class: 'github-btn', onClick: () => { replyToId.value = null } }, '取消')
        ])
      ]) : null

      const childrenNodes = (c.children && c.children.length) ? c.children.map(child => h(CommentItem, { comment: child, level: props.level + 1 })) : null

      return h('div', { style: indent }, [ header, replyArea, childrenNodes ])
    }
  }
}

// 当前登录用户信息
const currentUser = computed(() => getUser())
const isLoginState = computed(() => isLogin())
const currentUserId = computed(() => currentUser.value?.id || '')
const isAuthor = computed(() => article.value.userId === currentUserId.value)

// 格式化时间
const formatTime = (time) => {
  return new Date(time).toLocaleString()
}

// 获取分类名称
const getCategoryName = (categoryId) => {
  const category = categoryList.value.find(item => item.id === categoryId)
  return category ? category.name : '未分类'
}

import { normalizeUrl } from '../utils/url'
// 格式化文章内容：将 Markdown 图片语法转换为 img，并换行转 br
const formatContent = (content) => {
  if (!content) return ''
  // 转换 Markdown 图片语法 ![alt](url) -> <img src="url" />
  let s = content.replace(/!\[[^\]]*\]\(([^)]+)\)/g, (m, src) => {
    const n = normalizeUrl(src)
    return `<img src="${n}" style="max-width:100%;" />`
  })
  // 再处理换行
  s = s.replace(/\n/g, '<br>')
  return s
}

// 获取评论用户名（兼容多种后端返回结构）
// 实现放在下方，优先使用后端返回的 `commenterName`

const getCommentUserName = (c) => {
  if (!c) return '用户'
  if (c.commenterName) return c.commenterName
  if (c.authorName) return c.authorName
  if (c.user) return c.user.username || c.user.nickName || c.user.name || `用户${c.user.id || ''}`
  if (c.username) return c.username
  if (c.userName) return c.userName
  if (c.nickName) return c.nickName
  // 如果是当前登录用户的评论，优先显示当前用户信息里的用户名
  if (String(c.userId) === String(currentUserId.value) && currentUser.value && currentUser.value.username) {
    return currentUser.value.username
  }
  return `用户${c.userId || ''}`
}

// 加载文章数据
const loadData = async () => {
  loading.value = true
  try {
    const articleId = route.params.id
    // 并行加载数据
    const [articleRes, categoryRes, likeCountRes, collectCountRes] = await Promise.all([
      getArticleDetail(articleId),
      getCategoryList(),
      getLikeCount(articleId),
      getCollectCount(articleId)
    ])
    article.value = articleRes.data || {}
    categoryList.value = categoryRes.data
    likeCount.value = likeCountRes.data
    collectCount.value = collectCountRes.data

    // 登录用户检查点赞/收藏状态
    if (isLoginState.value) {
      const [likeRes, collectRes] = await Promise.all([
        checkLike(articleId),
        checkCollect(articleId)
      ])
      isLike.value = likeRes.data
      isCollect.value = collectRes.data
    }

    // 加载评论列表
    const commentRes = await getCommentList(articleId)
    commentList.value = commentRes.data

    // 作者信息（authorName / authorAvatar）由文章接口直接返回，前端无需再通过 token 请求用户信息
  } catch (e) {
    ElMessage.error('加载文章失败')
  } finally {
    loading.value = false
  }
}

// 点赞/取消点赞
const handleLike = async () => {
  if (!isLoginState.value) {
    ElMessage.warning('请先登录')
    router.push('/login')
    return
  }
  try {
    const articleId = article.value.id
    await toggleLike(articleId)
    isLike.value = !isLike.value
    likeCount.value = isLike.value ? likeCount.value + 1 : likeCount.value - 1
  } catch (e) {
    ElMessage.error('操作失败')
  }
}

// 收藏/取消收藏
const handleCollect = async () => {
  if (!isLoginState.value) {
    ElMessage.warning('请先登录')
    router.push('/login')
    return
  }
  try {
    const articleId = article.value.id
    await toggleCollect(articleId)
    isCollect.value = !isCollect.value
    collectCount.value = isCollect.value ? collectCount.value + 1 : collectCount.value - 1
  } catch (e) {
    ElMessage.error('操作失败')
  }
}

// 编辑文章
const handleEdit = () => {
  router.push(`/article/edit/${article.value.id}`)
}

// 删除文章
const handleDelete = async () => {
  try {
    await ElMessageBox.confirm('确定删除这篇文章吗？', '提示', { type: 'warning' })
    await deleteArticle(article.value.id)
    ElMessage.success('删除成功')
    router.push('/my-center')
  } catch (e) {
    ElMessage.info('已取消删除')
  }
}

// 新增评论（处理器，调用 api/comment.addComment）
const handleAddComment = async () => {
  if (!commentForm.value.content) {
    ElMessage.warning('请输入评论内容')
    return
  }
  try {
    const articleId = article.value.id
    await addComment(articleId, commentForm.value.content)
    ElMessage.success('评论发布成功')
    commentForm.value.content = ''
    // 重新加载评论列表
    const commentRes = await getCommentList(articleId)
    commentList.value = commentRes.data
  } catch (e) {
    ElMessage.error('发布失败')
  }
}

// 删除评论（处理器，调用 api/comment.deleteComment）
const handleDeleteComment = async (id) => {
  try {
    await ElMessageBox.confirm('确定删除这条评论吗？', '提示', { type: 'warning' })
    await deleteComment(id)
    ElMessage.success('删除成功')
    // 重新加载评论列表
    const commentRes = await getCommentList(article.value.id)
    commentList.value = commentRes.data
  } catch (e) {
    ElMessage.info('已取消删除')
  }
}

onMounted(() => {
  loadData()
})
</script>
<style scoped>
.article-detail {
  padding: 2rem 0;
}
</style>
