import { createApp } from 'vue'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import App from './App.vue'
import router from './router'
import './assets/style/globle.css'
import './assets/style/github.css'

const app = createApp(App)
app.use(router)
app.use(ElementPlus)
app.mount('#app')