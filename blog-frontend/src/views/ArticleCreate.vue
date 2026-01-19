<template>
  <div class="article-create">
    <div class="github-card" style="max-width: 800px; margin: 0 auto;">
      <div class="card-header">创建文章</div>
      <el-form :model="form" :rules="rules" ref="formRef" label-width="80px">
        <el-form-item label="标题" prop="title">
          <el-input v-model="form.title" placeholder="请输入文章标题"></el-input>
        </el-form-item>
        <el-form-item label="分类" prop="categoryId">
          <el-select v-model="form.categoryId" placeholder="请选择分类">
            <el-option v-for="item in categoryList" :key="item.id" :label="item.name" :value="item.id"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="Tag">
          <el-select v-model="form.tagIds" multiple placeholder="请选择Tag">
            <el-option v-for="item in tagList" :key="item.id" :label="item.name" :value="item.id"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="内容" prop="content">
          <el-input
            v-model="form.content"
            type="textarea"
            :rows="15"
            placeholder="请输入文章内容"
          ></el-input>
        </el-form-item>
        <el-form-item label="上传图片">
          <el-upload
              class="upload-demo"
              action="#"
              :show-file-list="true"
              :http-request="handleUploadArticleImage"
              accept="image/*"
            >
            <el-button type="primary">点击上传</el-button>
          </el-upload>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" class="github-btn primary" @click="handleSubmit">提交</el-button>
          <el-button class="github-btn" @click="handleCancel">取消</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>
<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { createArticle, updateArticle } from '../api/article'
import { getCategoryList } from '../api/category'
import { getTagList } from '../api/tag'
import { uploadArticleImage } from '../api/file'
import { getUser } from '../utils/auth'

const router = useRouter()
const formRef = ref(null)
const categoryList = ref([])
const tagList = ref([])
const form = ref({
  title: '',
  content: '',
  categoryId: '',
  tagIds: []
})
const pendingFiles = ref([])

const rules = ref({
  title: [{ required: true, message: '请输入文章标题', trigger: 'blur' }],
  content: [{ required: true, message: '请输入文章内容', trigger: 'blur' }],
  categoryId: [{ required: true, message: '请选择分类', trigger: 'change' }]
})

// 加载分类和Tag
const loadBaseData = async () => {
  try {
    const [categoryRes, tagRes] = await Promise.all([
      getCategoryList(),
      getTagList()
    ])
    categoryList.value = categoryRes.data
    tagList.value = tagRes.data
  } catch (e) {
    ElMessage.error('加载基础数据失败')
  }
}

// 上传文章图片（处理器，调用 api/file 中的 uploadArticleImage）
const handleUploadArticleImage = async (options) => {
  try {
    // 如果当前还没有 articleId（创建流程），先将文件放入待上传队列，提交文章后再上传
    if (!form.value.id) {
      pendingFiles.value.push(options.file)
      // 标记上传成功给 el-upload，让文件显示在列表中
      options.onSuccess && options.onSuccess({})
      ElMessage.info('图片已加入待上传队列，提交文章后会自动上传')
      return
    }

    const formData = new FormData()
    formData.append('file', options.file)
    formData.append('articleId', form.value.id)
    const res = await uploadArticleImage(formData)
    console.log('uploadArticleImage response:', res)
    // 更稳健地从各种可能的返回结构中提取 URL
    const extractUrl = (r) => {
      if (!r) return null
      if (typeof r === 'string') return r
      if (r.url) return r.url
      if (r.path) return r.path
      if (r.fileUrl) return r.fileUrl
      if (r.data) return extractUrl(r.data)
      return null
    }
    const url = extractUrl(res)
    if (url) {
      // 规范化 url
      const { normalizeUrl } = await import('../utils/url')
      const n = normalizeUrl(url)
      form.value.content += `\n![图片](${n})\n`
      options.onSuccess && options.onSuccess({ url })
      ElMessage.success('图片上传成功')
    } else {
      console.error('uploadArticleImage: no url in response', res)
      options.onError && options.onError(new Error('无图片URL返回'))
      ElMessage.error('图片上传失败：未返回URL（详细见控制台）')
    }
  } catch (e) {
    console.error('uploadArticleImage error:', e)
    options.onError && options.onError(e)
    ElMessage.error('图片上传失败')
  }
}

// 提交文章
const handleSubmit = async () => {
  try {
    await formRef.value.validate()
    const res = await createArticle(form.value)
    if (res.code === 200) {
      // 解析返回的新文章 id
      const returned = res.data !== undefined ? res.data : res
      const newId = returned.id || (typeof returned === 'number' ? returned : null)
      if (newId) {
        form.value.id = newId
      }

      // 如果有待上传的图片，逐个上传并把图片插入内容，最后更新文章
      if (pendingFiles.value.length > 0 && form.value.id) {
        try {
          for (const file of pendingFiles.value) {
            const fd = new FormData()
            fd.append('file', file)
            fd.append('articleId', form.value.id)
            const upRes = await uploadArticleImage(fd)
            console.log('pending upload response:', upRes)
            // 解析 url
            const extractUrl = (r) => {
              if (!r) return null
              if (typeof r === 'string') return r
              if (r.url) return r.url
              if (r.path) return r.path
              if (r.fileUrl) return r.fileUrl
              if (r.data) return extractUrl(r.data)
              return null
            }
            const url = extractUrl(upRes)
            if (url) {
              const { normalizeUrl } = await import('../utils/url')
              const n = normalizeUrl(url)
              form.value.content += `\n![图片](${n})\n`
            }
          }
          // 清空队列
          pendingFiles.value = []
          // 更新文章内容
          await updateArticle(form.value)
        } catch (e) {
          console.error('上传待处理图片失败', e)
        }
      }

      ElMessage.success('文章创建成功')
      router.push('/my-center')
    } else {
      ElMessage.error(res.msg)
    }
  } catch (e) {
    if (e.response) {
      ElMessage.error(e.response.data.msg || '创建失败')
    } else {
      ElMessage.error('网络异常，请重试')
    }
  }
}

// 取消
const handleCancel = () => {
  router.back()
}

onMounted(() => {
  loadBaseData()
})
</script>
<style scoped>
.article-create {
  padding: 2rem 0;
}
</style>
