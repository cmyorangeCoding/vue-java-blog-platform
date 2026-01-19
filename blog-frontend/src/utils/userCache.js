import { getUserInfo } from '../api/user'

// 简单的用户信息缓存：根据 userId 拉取并缓存用户名
const nameCache = new Map()
const inflight = new Map()

const pickNameFromUser = (u) => {
  if (!u) return null
  return u.username || u.userName || u.nickName || u.name || (u.id ? `用户${u.id}` : null)
}

export const resolveUserName = async (objOrId) => {
  if (!objOrId) return '用户'

  // 如果传入的是对象并包含用户对象
  if (typeof objOrId === 'object') {
    // article.user 或 comment.user
    if (objOrId.user) {
      const n = pickNameFromUser(objOrId.user)
      if (n) return n
    }
    // 直接包含 username/userName/nickName
    const direct = pickNameFromUser(objOrId)
    if (direct) return direct
    // 尝试取 userId 字段
    const id = objOrId.userId || objOrId.user_id || objOrId.uid || objOrId.user?.id
    if (id) return await resolveUserName(id)
    return '用户'
  }

  // 如果是数字或字符串 id
  const idStr = String(objOrId)
  if (nameCache.has(idStr)) return nameCache.get(idStr)
  if (inflight.has(idStr)) return inflight.get(idStr)

  const p = (async () => {
    try {
      const res = await getUserInfo(idStr)
      const u = res && (res.data !== undefined ? res.data : res)
      const n = pickNameFromUser(u) || `用户${idStr}`
      nameCache.set(idStr, n)
      return n
    } catch (e) {
      const fallback = `用户${idStr}`
      nameCache.set(idStr, fallback)
      return fallback
    } finally {
      inflight.delete(idStr)
    }
  })()

  inflight.set(idStr, p)
  return p
}

export const clearUserCache = () => {
  nameCache.clear()
  inflight.clear()
}

export default {
  resolveUserName,
  clearUserCache
}
