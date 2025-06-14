import { createRouter, createWebHistory } from 'vue-router'
// import HomeView from '../views/HomeView.vue'
import DashboardView from '../views/DashboardView.vue'
import RegisterView from '../views/RegisterView.vue'
import ShowDataEmpView from '../views/ShowDataEmpView.vue'
import TechStackView from '../views/TechStackView.vue'

import AuthLayout from '../components/AuthLayout.vue'
import SinginForm from '../components/SinginForm.vue'
import SignupForm from '../components/SignupForm.vue'

// const router = createRouter({
//   history: createWebHistory(import.meta.env.BASE_URL),
const routes = [

    {
      path: '/',
      redirect: '/singin',
    },
  
    {
      path: '/singin',
      component: AuthLayout,
      children: [
        {
          path: '',
          name: 'singin',
          component: SinginForm,
        },
      ],
    },
    {
      path: '/signup',
      component: AuthLayout,
      children: [
        {
          path: '',
          name: 'signup',
          component: SignupForm,
        },
      ],
    },
  
    {
      path: '/dashboard',
      name: 'dashboard',
      meta: { requiresAuth: true }, //  ต้องทำการ login ก่อน
      // การแบ่งโค้ดตามระดับของ route
      // โค้ดนี้จะสร้างไฟล์แยก (เช่น About.[hash].js) สำหรับเส้นทางนี้โดยเฉพาะ
      // ซึ่งจะโหลดไฟล์นั้นแบบ lazy-load (โหลดเมื่อมีการเข้า route นั้นเท่านั้น)
      component: DashboardView,
    },
    {
      path: '/register',
      name: 'register',
      meta: { requiresAuth: true }, //  ต้องทำการ login ก่อน
      // การแบ่งโค้ดตามระดับของ route
      // โค้ดนี้จะสร้างไฟล์แยก (เช่น About.[hash].js) สำหรับเส้นทางนี้โดยเฉพาะ
      // ซึ่งจะโหลดไฟล์นั้นแบบ lazy-load (โหลดเมื่อมีการเข้า route นั้นเท่านั้น)
      component: RegisterView,
    },
    {
      path: '/showdataemp',
      name: 'showdataemp',
      meta: { requiresAuth: true }, //  ต้องทำการ login ก่อน
      // การแบ่งโค้ดตามระดับของ route
      // โค้ดนี้จะสร้างไฟล์แยก (เช่น About.[hash].js) สำหรับเส้นทางนี้โดยเฉพาะ
      // ซึ่งจะโหลดไฟล์นั้นแบบ lazy-load (โหลดเมื่อมีการเข้า route นั้นเท่านั้น)
      component: ShowDataEmpView,
    },
    {
      path: '/showdataemp',
      name: 'showdataemp',
      meta: { requiresAuth: true }, //  ต้องทำการ login ก่อน
      // การแบ่งโค้ดตามระดับของ route
      // โค้ดนี้จะสร้างไฟล์แยก (เช่น About.[hash].js) สำหรับเส้นทางนี้โดยเฉพาะ
      // ซึ่งจะโหลดไฟล์นั้นแบบ lazy-load (โหลดเมื่อมีการเข้า route นั้นเท่านั้น)
      component: ShowDataEmpView,
    },

    {
      path: '/techstack',
      name: 'techstack',
      meta: { requiresAuth: true }, //  ต้องทำการ login ก่อน
      // การแบ่งโค้ดตามระดับของ route
      // โค้ดนี้จะสร้างไฟล์แยก (เช่น About.[hash].js) สำหรับเส้นทางนี้โดยเฉพาะ
      // ซึ่งจะโหลดไฟล์นั้นแบบ lazy-load (โหลดเมื่อมีการเข้า route นั้นเท่านั้น)
      component: TechStackView,
    },
      
    {
      path: '/about',
      name: 'about',
      meta: { requiresAuth: true }, //  ต้องทำการ login ก่อน
      // การแบ่งโค้ดตามระดับของ route
      // โค้ดนี้จะสร้างไฟล์แยก (เช่น About.[hash].js) สำหรับเส้นทางนี้โดยเฉพาะ
      // ซึ่งจะโหลดไฟล์นั้นแบบ lazy-load (โหลดเมื่อมีการเข้า route นั้นเท่านั้น)
      component: () => import('../views/AboutView.vue'),
    },

    // กัน user ที่เข้า url ที่ไม่มีอยู่จริงหรือหน้าที่ยังไม่ได้ทำการ login และกลับไปหน้า login
    {
      path: '/:pathMatch(.*)*',
      redirect: '/singin'
    },

    // {
    //   path: '/:pathMatch(.*)*',
    //   name: 'NotFound',
    //   component: () => import('../views/NotFound.vue')  // หรือหน้าแสดงว่าไม่พบหน้าเว็บ
    // },
    
  ]

  const router = createRouter({
    history: createWebHistory(import.meta.env.BASE_URL),
    routes,
  })
  

  // ถ้าไม่ได้ login โดยไม่มี token จะไม่สามารถเข้าถึงเนื้อหาในหน้า DashBoard
  router.beforeEach((to, from, next) => {
    const isAuthenticated = localStorage.getItem('isAuthenticated') === 'true'
    if (to.meta.requiresAuth && !isAuthenticated) {
      next('/')
    } else {
      next()
    }
  })
  

export default router
