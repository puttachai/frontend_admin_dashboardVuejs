<script setup>
import { RouterLink, RouterView } from 'vue-router'
import { useRoute } from 'vue-router'
// import HelloWorld from './components/HelloWorld.vue'
import Navbar from './components/Navbar.vue'
import FooterComponent from './components/FooterComponent.vue'
import Sidebar from './components/Sidebar.vue'
// import LoginView from './views/LoginView.vue'

const route = useRoute()
const hideLayout = ['singin', 'signup']

</script>

<template>

<div class="Container min-h-screen">
    <div v-if="!hideLayout.includes(route.name)">
      <Navbar />
    </div>

    <div class="flex min-h-screen">
      <div class="mysidebar">
        <div v-if="!hideLayout.includes(route.name)" class="mysidebar2"> <!-- mysidebar -->
          <Sidebar />
        </div>

        <main class="content "> 
          <RouterView /><!--content-->
        </main>
        
      </div>
    </div>
    

    <FooterComponent v-if="!hideLayout.includes(route.name)" />
</div>


</template>

<style scoped>

/* * {
  box-sizing: border-box;
  font-family: 'Fira sans', sans-serif;
} */

body {
  background: var(--light);
  height: 200vh;
}

ิีbutton{
  cursor: pointer;
  appearance: none;
  border: none;
  outline: none;
  background: none;
}

.mysidebar{
  padding: 0;
  margin: 0;
  display: flex; 
  flex: 1;
  overflow: hidden;
  min-height: 0; 
}
.mysidebar2{

  display: flex; 

}

/* Sidebar จะมี width คงที่ */
.content {
  flex: 1;
  /* padding: 1rem; */
  overflow: auto;
}

main{
    flex: 1 1 0;
    /* padding: 2rem; */

    @media (max-width: 768px) {
      /* padding-left: 6rem; */

    }
}

</style>


<!-- 
<div class="Container min-h-screen"> <!-- min-h-screen 

  <div class="">
    <Navbar />
  </div>

  <div class="flex min-h-screen"> <!-- min-h-screen 

    <div class="mysidebar">

      <Sidebar />
      <!-- <header>
        <img alt="Vue logo" class="logo" src="@/assets/logo.svg" width="125" height="125" />

        <div class="wrapper">
          <HelloWorld msg="You did it!" />

          <nav>
            <RouterLink to="/">Home</RouterLink>
            <RouterLink to="/about">About</RouterLink>
          </nav>
        </div>
      </header> 

      <main class="content">
        <RouterView />
      </main>
       <RouterView /> 

    </div>

  </div>


  <FooterComponent />

</div> -->