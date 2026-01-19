import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import path from 'path'

export default defineConfig({
  plugins: [vue()],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, 'src')
    }
  },
  server: {
    host: true,
    port: 5173,
    open: true,
    cors: true,
    proxy: {
      // 将 /api 前缀代理到后端，避免浏览器 CORS 问题
      '/api': {
        target: 'http://localhost:8080',
        changeOrigin: true,
        // rewrite: (path) => path.replace(/^\/api/, ''),
        // 修复后端在未认证时返回的重定向（Location 指向后端域名）导致浏览器跨域问题
        // 通过在代理层监听响应并重写 Location 头，使其成为相对路径，从而由 Vite 代理处理
        configure: (proxy) => {
          proxy.on('proxyRes', (proxyRes) => {
            const loc = proxyRes.headers && proxyRes.headers['location']
            if (loc && typeof loc === 'string' && loc.startsWith('http')) {
              try {
                const url = new URL(loc)
                // 将绝对 Location 替换为相对路径
                proxyRes.headers['location'] = url.pathname + url.search + url.hash
              } catch (e) {
                // ignore
              }
            }
          })
        }
      }
      ,
      // 将 /oss 前缀代理到阿里云 OSS（用于前端将 OSS 完整域名替换为 /oss 的方案）
      // 请确保下面的 target 与你的 OSS 域名一致
      '/oss': {
        target: 'https://web-blog-cmy.oss-cn-beijing.aliyuncs.com',
        changeOrigin: true,
        secure: false,
        rewrite: (path) => path.replace(/^\/oss/, '')
      }
    }
  }
})