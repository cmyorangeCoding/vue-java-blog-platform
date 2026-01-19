import service from './request'

// 上传头像
// 可传入第二个参数 { skipAuth: true } 在注册流程中绕过鉴权（后端允许匿名上传）
export const uploadAvatar = (formData, config = {}) => service.post('/file/avatar', formData, { skipAuth: !!config.skipAuth })

// 上传文章图片的API
export const uploadArticleImage = (formData, articleId) => {
  // 把articleId加到FormData里
  formData.append('articleId', articleId);
  return service.post('/file/article', formData);
};

// 匿名上传头像（注册环节专用，后端需对应新增 /file/avatar/anonymous 接口）
export const uploadAvatarAnonymous = (formData) => service.post('/file/avatar/anonymous', formData, { skipAuth: true })

