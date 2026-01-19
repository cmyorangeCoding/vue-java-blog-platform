// 统一的 URL 规范化工具：
// - 修复重复的协议拼接（取最后一个 http(s):// 起点）
// - 将已知 OSS 域名替换为 /oss 前缀（配合 Vite proxy）
// - 处理以 // 开头或以 / 开头的相对路径
export function normalizeUrl(raw) {
  if (!raw) return ''
  let url = String(raw).trim()
  // 1) 规范斜杠
  url = url.replace(/\\/g, '/')

  // 2) 如果包含多次 http(s)://，取最后一次出现的起点，解决类似 "https://a.https://b/..." 的问题
  const idxHttp = Math.max(url.lastIndexOf('http://'), url.lastIndexOf('https://'))
  if (idxHttp >= 0) {
    url = url.substring(idxHttp)
  }

  // 3) 如果以 // 开头，补齐当前协议
  if (url.startsWith('//')) {
    url = window.location.protocol + url
  }

  // 4) 解析 URL 并对 OSS 域名做特殊处理（更宽松的匹配：包含 aliyuncs.com 或 oss-cn-）
  try {
    const u = new URL(url, window.location.origin)
    const host = (u.hostname || '').toLowerCase()
    if (host.includes('aliyuncs.com') || /oss-cn-/.test(host)) {
      // 使用 /oss 前缀，让 Vite proxy 转发到真实 OSS
      // 返回时只保留 pathname+search+hash，避免包含协议/主机名
      return '/oss' + u.pathname.replace(/\/+/g, '/') + (u.search || '') + (u.hash || '')
    }
    // 对于非 OSS 的绝对 URL，返回解析后的完整 URL（合并多重斜杠）
    if (/^https?:\/\//i.test(u.href)) {
      return u.href.replace(/([^:\/])\/\/+/, '$1/')
    }
  } catch (e) {
    // 无法用 URL 解析（可能是相对路径），继续下面处理
  }

  // 5) 如果以 / 开头，视为站内相对路径，拼接 origin
  if (url.startsWith('/')) {
    return window.location.origin + url.replace(/\/+/g, '/')
  }

  // 6) 兜底返回原始值（去除重复斜杠）
  return url.replace(/\/+/g, '/')
}
