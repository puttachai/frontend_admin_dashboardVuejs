import { createRouter, createWebHistory } from 'vue-router'
// import HomeView from '../views/HomeView.vue'
import DashboardView from '../views/DashboardView.vue'
import RegisterView from '../views/RegisterView.vue'
import ShowDataEmpView from '../views/ShowDataEmpView.vue'
import TechStackView from '../views/TechStackView.vue'
import CreateSaleList from '../views/CreateSaleListView.vue'
import CustomerView from '../views/CustomerView.vue'

import AuthLayout from '../components/AuthLayout.vue'
import SinginForm from '../components/SinginForm.vue'
import SignupForm from '../components/SignupForm.vue'
// import { useRoute } from 'vue-router'
// import { computed } from 'vue'

// const route = useRoute();

// const isAuthLayout = computed(() => {
//   return route.meta && route.meta.layout === 'auth'
// })

// console.log('Check isAuthLayout: ', isAuthLayout);



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
          // meta: { layout: 'auth' }, // ไม่ให้สืบทอดคลาสจากหน้า App
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
      path: '/customer',
      name: 'customer',
      meta: { requiresAuth: true }, //  ต้องทำการ login ก่อน
      // การแบ่งโค้ดตามระดับของ route
      // โค้ดนี้จะสร้างไฟล์แยก (เช่น About.[hash].js) สำหรับเส้นทางนี้โดยเฉพาะ
      // ซึ่งจะโหลดไฟล์นั้นแบบ lazy-load (โหลดเมื่อมีการเข้า route นั้นเท่านั้น)
      component: CustomerView,
    },
      
    {
      path: '/createsalelist',
      name: 'createsalelist',
      meta: { requiresAuth: true }, //  ต้องทำการ login ก่อน
      // การแบ่งโค้ดตามระดับของ route
      // โค้ดนี้จะสร้างไฟล์แยก (เช่น About.[hash].js) สำหรับเส้นทางนี้โดยเฉพาะ
      // ซึ่งจะโหลดไฟล์นั้นแบบ lazy-load (โหลดเมื่อมีการเข้า route นั้นเท่านั้น)
      component: CreateSaleList,
    },

    {
      path: '/saleList',
      name: 'saleList',
      component: CreateSaleList, // หรือไฟล์ Vue ที่เกี่ยวข้อง
      meta: { requiresAuth: true },
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
