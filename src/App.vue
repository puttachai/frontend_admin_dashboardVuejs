<script setup>
import { RouterLink, RouterView } from 'vue-router'
import { useRoute } from 'vue-router'
// import HelloWorld from './components/HelloWorld.vue'
import Navbar from './components/Navbar.vue'
import FooterComponent from './components/FooterComponent.vue'
import Sidebar from './components/Sidebar.vue'
// import LoginView from './views/LoginView.vue'

const route = useRoute()
const hideLayout = ['singin', 'signup', 'login']

</script>

<template>

  <div class="Container min-h-screen">
    <div v-if="!hideLayout.includes(route.name)">
      <!-- <Navbar /> -->
      <Navbar @toggle-sidebar="toggleSidebar" />
    </div>

    <div class="flex min-h-screen">
      <div class="mysidebar">
        <div v-if="!hideLayout.includes(route.name) && isSidebarVisible" class="mysidebar2"> <!-- mysidebar -->
          <!-- <Sidebar /> -->
          <Sidebar :class="{ 'sidebar-hidden': !isSidebarVisible }" />
        </div>

       <!-- ✅ แยกการใส่ class content ตามเงื่อนไข -->
      <main v-if="!hideLayout.includes(route.name)" class="content">
        <RouterView />
      </main>
      <main v-else>
        <RouterView />
      </main>

      </div>
    </div>


    <FooterComponent v-if="!hideLayout.includes(route.name)" />
  </div>


</template>

<!-- <script setup>

import enConfig from 'tdesign-vue-next/es/locale/en_US'
import { ConfigProvider } from 'tdesign-vue-next'

</script> -->

<script>

// import { ref } from 'vue'
import { ref, watch, onMounted } from 'vue'
import i18n from './i18n'

const isSidebarVisible = ref(true)

onMounted(() => {
  const savedLocale = localStorage.getItem('locale')
  if (savedLocale) {
    i18n.global.locale.value = savedLocale
  }
})

watch(() => i18n.global.locale.value, (newLocale) => {
  localStorage.setItem('locale', newLocale)
})

// Responsive check (auto hide on small screen)
if (window.innerWidth <= 430) {
  isSidebarVisible.value = false
}

function toggleSidebar() {
  isSidebarVisible.value = !isSidebarVisible.value
}

</script>

<style scoped>
/* * {
  box-sizing: border-box;
  font-family: 'Fira sans', sans-serif;
} */

body {
  background: var(--light);
  height: 200vh;
}

ิีbutton {
  cursor: pointer;
  appearance: none;
  border: none;
  outline: none;
  background: none;
}

.mysidebar {
  padding: 0;
  margin: 0;
  display: flex;
  flex: 1;
  overflow: hidden;
  min-height: 0;

}

.mysidebar2 {

  display: flex;

}

/* Sidebar จะมี width คงที่ */
.content {
  flex: 1;
  /* padding: 1rem; */
  overflow: auto;
  margin-left: calc(2rem + 32px);
  padding-top: 4rem;
  /* ✅ เผื่อ space จาก navbar */

  /* margin-left: 4rem; */

  /* ใช้ media query ที่ถูกต้อง */
  @media (max-width: 431px) {

    margin-left: 0 !important;
    /* margin-left: 0 !important; */
    /* ✅ ตั้งค่า margin-left เป็น 0 เมื่อหน้าจอเล็ก */
  }

}

main {
  flex: 1 1 0;
  /* padding: 2rem; */

  @media (max-width: 768px) {
    /* padding-left: 6rem; */

  }
}
</style>
