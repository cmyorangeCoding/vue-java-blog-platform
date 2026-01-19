import service from './request'

// 收藏/取消收藏
export const toggleCollect = (articleId) => service.post(`/article/collect/toggle/${articleId}`)

// 获取收藏数
export const getCollectCount = (articleId) => service.get(`/article/collect/count/${articleId}`)

// 检查是否收藏
export const checkCollect = (articleId) => service.get(`/article/collect/check/${articleId}`)

// 获取用户收藏列表：尝试多个可能的后端路径，兼容不同实现
export const getUserCollectList = async (userId) => {
	const paths = [
		`/article/collect/list/${userId}`,
		`/article/collect/user/${userId}`,
		`/collect/user/${userId}`,
		`/collect/list/${userId}`
	]
	for (const p of paths) {
		try {
			const res = await service.get(p)
			// 如果返回有效数据则直接返回（留给调用方解析 res.data）
			if (res && (res.code === 200 || res.data)) return res
		} catch (e) {
			// 尝试下一个路径
			console.debug(`getUserCollectList try ${p} failed:`, e.message || e)
		}
	}
	// 全部尝试失败，抛出以便上层处理
	return Promise.reject(new Error('无法获取用户收藏列表：后端无兼容接口'))
}