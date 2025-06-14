<template>
    <div class="px-6 py-10 bg-gray-50 min-h-screen">
      <div class="max-w-5xl mx-auto text-center">
        <h1 class="text-3xl md:text-4xl font-bold mb-4">My Tech Stack</h1>
        <p class="text-gray-600 mb-10">Technology I use to build projects</p>
  
        <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
          <div
            v-for="(tech, index) in techStack"
            :key="index"
            class="bg-white rounded-lg p-6 text-center border-2 border-transparent transition-all duration-300 hover:border-green-500 hover:shadow-xl group"
          >
            <div class="text-5xl mb-4">
              <i
                :class="tech.icon"
                v-if="tech.icon"
                :style="{ color: tech.color }"
              ></i>
              <img
                :src="tech.image"
                alt=""
                class="w-12 h-12 mx-auto"
                v-else
              />
            </div>
            <h3 class="text-lg font-semibold">{{ tech.name }}</h3>
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    name: "TechStack",
    data() {
      return {
        techStack: [
          { name: "JavaScript", icon: "fab fa-js-square", color: "#f7df1e" },
          { name: "PHP", icon: "fab fa-php", color: "#8892be" },
          { name: "HTML5", icon: "fab fa-html5", color: "#e34c26" },
          { name: "CSS3", icon: "fab fa-css3-alt", color: "#264de4" },
          { name: "Vue.js", icon: "fab fa-vuejs", color: "#42b883" },
          { name: "TailwindCSS", image: "https://www.svgrepo.com/show/374118/tailwind.svg" },
          { name: "SweetAlert2", image: "https://rohit-chouhan.gallerycdn.vsassets.io/extensions/rohit-chouhan/sweetalert2-snippet/1.1.2/1625627316335/Microsoft.VisualStudio.Services.Icons.Default" },
          { name: "Chart.js", image: "https://www.chartjs.org/media/logo-title.svg" }
        ]
      };
    }
  };
  </script>
  
  <style scoped>
  @import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css');
  
  /* เพิ่มเอฟเฟกต์เมื่อ hover ให้ดูเหมือนมีขอบวิ่ง */
  .group:hover {
    animation: borderPulse 1.5s infinite;
  }
  
  @keyframes borderPulse {
    0% {
      border-color: #22c55e;
    }
    50% {
      border-color: #4ade80;
    }
    100% {
      border-color: #22c55e;
    }
  }
  </style>
  