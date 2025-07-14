// src/i18n.js
import { createI18n } from 'vue-i18n'

const messages = {
  th: {
    welcome: 'ยินดีต้อนรับเข้าสู่แดชบอร์ดผู้ดูแลระบบ',
    about: 'เกี่ยวกับ',
    signOut: 'ออกจากระบบ',
    // เพิ่มคำอื่นๆ ที่คุณใช้ในหน้าอื่น
  },
  en: {
    welcome: 'Welcome to Admin Dashboard',
    about: 'About',
    signOut: 'Sign out',
  },
  zh: {
    welcome: '欢迎来到管理仪表板',
    about: '关于',
    signOut: '退出',
  }
}

const i18n = createI18n({
  legacy: false,
  locale: 'th',           // เริ่มต้นเป็นภาษาไทย
  fallbackLocale: 'en',   // fallback ถ้าไม่เจอ key
  messages
})

export default i18n
