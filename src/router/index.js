import { createRouter, createWebHistory } from "vue-router";
// import HomeView from '../views/HomeView.vue'
import DashboardView from "../views/DashboardView.vue";
import RegisterView from "../views/RegisterView.vue";
import RegisterDedtStatustView from "../views/Register_DedtStatustView.vue";
import ShowDataEmpView from "../views/ShowDataEmpView.vue";
import TechStackView from "../views/TechStackView.vue";
import CreateSaleList from "../views/CreateSaleListView.vue";
import CustomerView from "../views/CustomerView.vue";

import SaleOrderList from "@/views/SaleOrderList.vue";
import SaleOrderDetail from "../components/listSaleOrder/SaleOrderDetailView.vue";
import Print from "../components/listSaleOrder/PrintView.vue";

// import ActivityLogView from "../views/ActivityLogView.vue";

import LoginForm from "../views/LoginView.vue";

// import AuthLayout from "../components/AuthLayout.vue";
// import SinginForm from "../components/SinginForm.vue";
// import SignupForm from "../components/SignupForm.vue";
import Swal from "sweetalert2";
// import { useRoute } from 'vue-router'
// import { computed } from 'vue'

// const route = useRoute();

// const isAuthLayout = computed(() => {
//   return route.meta && route.meta.layout === 'auth'
// })

// console.log('Check isAuthLayout: ', isAuthLayout);

const getCustomer_id = localStorage.getItem("selectDataCustomerRow");

console.log("Check getCustomer_id: ", getCustomer_id);

const customerData = JSON.parse(getCustomer_id);

if (Array.isArray(getCustomer_id)) {
  customerData.array.forEach(item, (index) => {
    console.log(`🟢 Row ${index + 1}`, item);
    // เช่น เข้าถึงฟิลด์ชื่อ
    console.log("ชื่อ:", item.name);
  });
} else {
  console.log("ไม่ใช่ Array:", customerData);
}

// const customer_id = customerData.customer_id;

// const router = createRouter({
//   history: createWebHistory(import.meta.env.BASE_URL),
const routes = [
  {
    path: "/",
    redirect: "/login",
    // redirect: "/singin",
  },

  {
    path: "/login",
    name: "login",
    component: LoginForm,
  },

  // {
  //   path: "/singin",
  //   component: AuthLayout,
  //   meta: { requiresAuth: true }, //  // พึ่งเพิ่มใหม่ไม่ได้ใช้แล้ว
  //   children: [
  //     {
  //       path: "",
  //       name: "singin",
  //       component: SinginForm,
  //       meta: { requiresAuth: true }, //  // พึ่งเพิ่มใหม่ไม่ได้ใช้แล้ว
  //     },
  //   ],
  // },
  // {
  //   path: "/singin",
  //   component: AuthLayout,
  //   meta: { requiresAuth: true }, //  // พึ่งเพิ่มใหม่ไม่ได้ใช้แล้ว
  //   children: [
  //     {
  //       path: "",
  //       name: "singin",
  //       meta: { requiresAuth: true }, // // พึ่งเพิ่มใหม่ไม่ได้ใช้แล้ว
  //       component: SinginForm,
  //     },
  //   ],
  // },
  // {
  //   path: "/signup",
  //   component: AuthLayout, // พึ่งเพิ่มใหม่ไม่ได้ใช้แล้ว
  //   meta: { requiresAuth: true }, //  ต้องทำการ login ก่อน
  //   children: [
  //     {
  //       path: "",
  //       name: "signup",
  //       meta: { requiresAuth: true }, // // พึ่งเพิ่มใหม่ไม่ได้ใช้แล้ว
  //       component: SignupForm,
  //       // meta: { layout: 'auth' }, // ไม่ให้สืบทอดคลาสจากหน้า App
  //     },
  //   ],
  // },

  {
    path: "/dashboard",
    name: "dashboard",
    meta: { requiresAuth: true }, //  ต้องทำการ login ก่อน
    // การแบ่งโค้ดตามระดับของ route
    // โค้ดนี้จะสร้างไฟล์แยก (เช่น About.[hash].js) สำหรับเส้นทางนี้โดยเฉพาะ
    // ซึ่งจะโหลดไฟล์นั้นแบบ lazy-load (โหลดเมื่อมีการเข้า route นั้นเท่านั้น)
    component: DashboardView,
  },
  {
    path: "/register",
    name: "register",
    meta: { requiresAuth: true }, //  ต้องทำการ login ก่อน
    // การแบ่งโค้ดตามระดับของ route
    // โค้ดนี้จะสร้างไฟล์แยก (เช่น About.[hash].js) สำหรับเส้นทางนี้โดยเฉพาะ
    // ซึ่งจะโหลดไฟล์นั้นแบบ lazy-load (โหลดเมื่อมีการเข้า route นั้นเท่านั้น)
    component: RegisterView,
  },
  // new
  {
    path: "/registerdedtStatust",
    name: "registerdedtStatust",
    meta: { requiresAuth: true }, //  ต้องทำการ login ก่อน
    // การแบ่งโค้ดตามระดับของ route
    // โค้ดนี้จะสร้างไฟล์แยก (เช่น About.[hash].js) สำหรับเส้นทางนี้โดยเฉพาะ
    // ซึ่งจะโหลดไฟล์นั้นแบบ lazy-load (โหลดเมื่อมีการเข้า route นั้นเท่านั้น)
    component: RegisterDedtStatustView,
  },
  {
    path: "/showdataemp",
    name: "showdataemp",
    meta: { requiresAuth: true }, //  ต้องทำการ login ก่อน
    // การแบ่งโค้ดตามระดับของ route
    // โค้ดนี้จะสร้างไฟล์แยก (เช่น About.[hash].js) สำหรับเส้นทางนี้โดยเฉพาะ
    // ซึ่งจะโหลดไฟล์นั้นแบบ lazy-load (โหลดเมื่อมีการเข้า route นั้นเท่านั้น)
    component: ShowDataEmpView,
  },
  {
    path: "/showdataemp",
    name: "showdataemp",
    meta: { requiresAuth: true }, //  ต้องทำการ login ก่อน
    // การแบ่งโค้ดตามระดับของ route
    // โค้ดนี้จะสร้างไฟล์แยก (เช่น About.[hash].js) สำหรับเส้นทางนี้โดยเฉพาะ
    // ซึ่งจะโหลดไฟล์นั้นแบบ lazy-load (โหลดเมื่อมีการเข้า route นั้นเท่านั้น)
    component: ShowDataEmpView,
  },

  {
    path: "/techstack",
    name: "techstack",
    meta: { requiresAuth: true }, //  ต้องทำการ login ก่อน
    // การแบ่งโค้ดตามระดับของ route
    // โค้ดนี้จะสร้างไฟล์แยก (เช่น About.[hash].js) สำหรับเส้นทางนี้โดยเฉพาะ
    // ซึ่งจะโหลดไฟล์นั้นแบบ lazy-load (โหลดเมื่อมีการเข้า route นั้นเท่านั้น)
    component: TechStackView,
  },

  {
    path: "/customer",
    name: "customer",
    meta: { requiresAuth: true }, //  ต้องทำการ login ก่อน
    // การแบ่งโค้ดตามระดับของ route
    // โค้ดนี้จะสร้างไฟล์แยก (เช่น About.[hash].js) สำหรับเส้นทางนี้โดยเฉพาะ
    // ซึ่งจะโหลดไฟล์นั้นแบบ lazy-load (โหลดเมื่อมีการเข้า route นั้นเท่านั้น)
    component: CustomerView,
  },

  {
    path: "/createsalelist",
    name: "createsalelist",
    meta: { requiresAuth: true }, //  ต้องทำการ login ก่อน
    // การแบ่งโค้ดตามระดับของ route
    // โค้ดนี้จะสร้างไฟล์แยก (เช่น About.[hash].js) สำหรับเส้นทางนี้โดยเฉพาะ
    // ซึ่งจะโหลดไฟล์นั้นแบบ lazy-load (โหลดเมื่อมีการเข้า route นั้นเท่านั้น)
    component: CreateSaleList,
  },


  {
    // path: '/print-order', // รับ ID ใบสั่งซื้อด้วย
    path: '/print-order/:id', // รับ ID ใบสั่งซื้อด้วย
    name: 'PrintOrder',
    meta: { requiresAuth: true }, //  ต้องทำการ login ก่อน
    component: Print,
  },

  {
    path: "/saleList",
    name: "saleList",
    component: CreateSaleList, // หรือไฟล์ Vue ที่เกี่ยวข้อง
    meta: { requiresAuth: true },
  },

  {
    path: "/saleorder",
    name: "saleorder",
    component: SaleOrderList,
    // component: () => import('../views/SaleOrderList.vue'),
    meta: { requiresAuth: true },
  },
  // {
  //   path: '/saleorder/:id',
  //   name: 'saleorderdetail',
  //   component: () => import('../components/listSaleOrder/SaleOrderDetailView.vue'),
  //   meta: { requiresAuth: true }
  // },
  {
    path: "/sale-order/:id",
    name: "saleorderdetail",
    component: SaleOrderDetail, // <-- ปรับ path ให้ตรงกับไฟล์ของคุณ
    // component: () => import('@/views/SaleOrderDetail.vue')  // <-- ปรับ path ให้ตรงกับไฟล์ของคุณ
    meta: { requiresAuth: true },
  },

  {
    path: "/about",
    name: "about",
    meta: { requiresAuth: true }, //  ต้องทำการ login ก่อน
    // การแบ่งโค้ดตามระดับของ route
    // โค้ดนี้จะสร้างไฟล์แยก (เช่น About.[hash].js) สำหรับเส้นทางนี้โดยเฉพาะ
    // ซึ่งจะโหลดไฟล์นั้นแบบ lazy-load (โหลดเมื่อมีการเข้า route นั้นเท่านั้น)
    component: () => import("../views/AboutView.vue"),
  },

  // {
  //   path: "/activity-log",
  //   name: "activitylog",
  //   component: ActivityLogView,
  //   meta: { requiresAuth: true },
  // },

  // กัน user ที่เข้า url ที่ไม่มีอยู่จริงหรือหน้าที่ยังไม่ได้ทำการ login และกลับไปหน้า login
  {
    path: "/:pathMatch(.*)*",
    redirect: "/singin",
  },

  // {
  //   path: '/:pathMatch(.*)*',
  //   name: 'NotFound',
  //   component: () => import('../views/NotFound.vue')  // หรือหน้าแสดงว่าไม่พบหน้าเว็บ
  // },
];

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes,
});

// ถ้าไม่ได้ login โดยไม่มี token จะไม่สามารถเข้าถึงเนื้อหาในหน้า DashBoard
// router.beforeEach((to, from, next) => {
//   const isAuthenticated = localStorage.getItem('isAuthenticated') === 'true'
//   if (to.meta.requiresAuth && !isAuthenticated) {
//     next('/')
//   } else {
//     next()
//   }
// })

// ✅ ⬇️ วางไว้ที่นี่ หลังสร้าง router แล้ว
router.beforeEach((to, from, next) => {

// const orderStore = useOrderStore()

  const isAuthenticated = localStorage.getItem("isAuthenticated") === "true";
  const customerRaw = localStorage.getItem("selectDataCustomerRow");

  // ตรวจสอบสิทธิ์
  const isAdmin = localStorage.getItem("role_admin") === "true";
  const isFa = localStorage.getItem("role_fa") === "true";
  const isProduct = localStorage.getItem("role_product") === "true";
  const isCrm = localStorage.getItem("role_crm") === "true";

  // localStorage.removeItem('crm_account');

  // const permission = localStorage.getItem('permission');
  const crm_account = localStorage.getItem("crm_account");
  const fa_account = localStorage.getItem("fa_account");

  console.log(
    "Check crm_account: " + crm_account ||
      "ไม่เจอ crm_account" + "Check fa_account: " + fa_account ||
      "ไม่เจอ fa_account"
  );

  let customer_id = null;
  // let permissionData = null;

  try {
    const customerData = JSON.parse(customerRaw);
    // const permissionData = JSON.parse(permission);
    customer_id = customerData?.customer_id;
    console.log("check customer_id : ", customer_id);
    // console.log('check permissionData : ', permissionData);
  } catch (err) {
    console.warn("❌ JSON parse failed:", err);
  }

  if (to.meta.requiresAuth && !isAuthenticated) {
    return next("/");
  }

  // ❗ ป้องกันเข้า /createsalelist ถ้าไม่มี customer_id
  if (to.name === "createsalelist" && !customer_id) {
    // alert('กรุณาเลือกข้อมูลลูกค้าก่อนเข้าสร้างรายการขาย');
    Swal.fire({
      title: "กรุณาเลือกร้านค้าของลูกค้า",
      text: "กรุณาเลือกข้อมูลลูกค้าก่อนเข้าสร้างรายการขาย",
      icon: "error",
    });
    return next("/customer");
  }

  // ใช้ได้แต่ตัวเก่า ซับซ้อนเกินไป
  // if (crm_account === "crm" && to.name === "saleorder") {
  //   Swal.fire({
  //     title: "ไม่มีสิทธิเข้าถึง",
  //     text: "บัญชีของคุณไม่ได้รับอนุญาติให้เข้าถึงหน้านี้",
  //     icon: "warning",
  //   });
  //   return next("/dashboard");
  // }


  // ต้องใช้
  // กลุ่ม sale กับ product ห้ามเข้า /saleorder
  // if ((isCrm || isProduct) && to.name === "saleorder") {
  //   Swal.fire({
  //     title: "ไม่มีสิทธิเข้าถึง",
  //     text: "คุณไม่ได้รับอนุญาตให้เข้าถึงหน้านี้",
  //     icon: "warning",
  //   });
  //   return next("/dashboard");
  // }



  //   if(to.name === 'saleList' && !customer_id && !order_id){
  //     Swal.fire({
  //       title: 'ไม่มีข้อมูล',
  //       text: 'ไม้สารมารถเข้าได้จาก รายการสั่งซื้อของลูกค้ารายการนี้',
  //       icon: 'error',
  //   });
  // return next('/createsalelist');
  //   }

  next(); // ✅ ผ่านทุกเงื่อนไข
});

// ✅ แล้ว export router

export default router;
