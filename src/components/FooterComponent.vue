<template>
  <footer class="bg-gray-50 text-center py-8 border-t rounded-lg border-gray-200">
    <p class="text-gray-600 text-sm">
      © Copyright 2025 | D-Power | All Rights Reserved | Designed & Developed by D-Power | Powered by
      <a href="https://vuejs.org/" target="_blank" class="text-blue-600 hover:underline">
        VueJs.com
      </a>
    </p>
  </footer>
</template>

<script>
export default {
  name: 'FooterComponent',
}
</script>

<style scoped>
footer {
  margin-left: 4rem;

  @media (max-width: 431px) {

    margin-left: 0rem;

  }

}
</style>