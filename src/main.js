import './assets/main.css'

import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import TDesign from 'tdesign-vue-next';
import 'tdesign-vue-next/es/style/index.css';
import i18n from './i18n'
import { createPinia } from 'pinia'

// นี่คือไฟล์ print.css ที่เราสร้าง
import '@/assets/print.css'

// import { ConfigProvider } from 'tdesign-vue-next'
// import enConfig from 'tdesign-vue-next/es/locale/en_US'

const app = createApp(App)

// ✅ สร้าง instance ของ Pinia ก่อนใช้
const pinia = createPinia()

app.use(router)

// app.use(ConfigProvider, { globalConfig: enConfig })

app.use(pinia) // ✅ ต้องมีบรรทัดนี้
app.use(TDesign);
app.use(i18n)
app.mount('#app')
