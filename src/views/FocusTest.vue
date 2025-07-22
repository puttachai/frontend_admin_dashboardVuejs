<template>
  <div class="container">
    <h1 class="text-gray-700">🔍 ทดสอบ Focus / Visibility ด้วย Vue</h1>
    <p class="text-gray-700">ลองสลับแท็บ, ย่อหน้า, หรือเปลี่ยนแอป แล้วกลับมาดู log ด้านล่าง</p>
    <div class="log-box">
      <pre>{{ logText }}</pre>
    </div>
  </div>
</template>

<script>
export default {
  name: 'FocusTest',
  data() {
    return {
      logText: '🔄 รอเหตุการณ์...',
    };
  },
  methods: {
    appendLog(message) {
      const timestamp = new Date().toLocaleTimeString();
      this.logText += `\n[${timestamp}] ${message}`;
    },
    setupEventListeners() {
      window.addEventListener('blur', () => {
        this.appendLog('❌ blur: ผู้ใช้เปลี่ยนแอปหรือคลิกออก');
      });

      window.addEventListener('focus', () => {
        this.appendLog('✅ focus: ผู้ใช้กลับมาที่หน้าเว็บ');
      });

      document.addEventListener('visibilitychange', () => {
        if (document.hidden) {
          this.appendLog('🚫 visibilitychange: ผู้ใช้ซ่อนหน้า (อาจเปลี่ยนแท็บ)');
        } else {
          this.appendLog('👀 visibilitychange: กลับมาแสดงหน้าอีกครั้ง');
        }
      });
    }
  },
  mounted() {
    this.setupEventListeners();
  }
};
</script>

<style scoped>
.container {
  text-align: center;
  padding: 2rem;
  font-family: sans-serif;
}

.log-box {
  margin-top: 2rem;
  background: #f3f3f3;
  padding: 1rem;
  border-radius: 8px;
  text-align: left;
  white-space: pre-line;
}
</style>
