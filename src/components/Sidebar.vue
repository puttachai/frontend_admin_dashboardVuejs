<!-- eslint-disable vue/multi-word-component-names -->
<!-- eslint-disable vue/no-deprecated-v-on-native-modifier -->
<template>
    <!-- <aside :class="{ 'is-expanded': is_expanded }"> -->
    <aside :class="`${is_expanded && 'is-expanded'}`">
        <!-- Sidebar -->
        <div class="logo ">
            <!-- <RouterLink to="/dashboard"> -->
            <RouterLink to="/createsalelist">
                <div class="box-cursor ">
                    <img src="../assets/logo.svg" class="" alt="Vue">
                    <!-- <h5>Admin Dashboard</h5> -->
                </div>
            </RouterLink>
        </div>

        <div class="menu-toggle-wrap">
            <button class="menu-toggle" @click="ToggleMenu">
                <span class="material-icons">keyboard_double_arrow_right</span>

            </button>
        </div>

        <h3>เมนู</h3>
        <!-- <h3>Menu</h3> -->
        <div class="menu">
            <!-- <router-link class="button" to="/createsalelist" @click.prevent="forceReload"> -->
            <!-- <router-link class="button" to="/createsalelist" @click.native.prevent="forceReload"> -->
                <!-- <span class="material-icons">assignment_add</span>
                <span class="text">สร้างรายการขาย</span>
            </router-link> -->
            <!-- สร้าง toast -->
            <router-link class="button" to="/createsalelist" id="createsalelist" @click.prevent="forceReload">
                <span class="material-icons">assignment_add</span>
                <span class="text">สร้างรายการขาย</span>

                 <!-- Toast -->
                <div
                    v-if="toast.show && toast.target === 'createsalelist'"
                    class="toast"
                >
                    <span class="material-icons bell">notifications</span>
                    <span>{{ toast.message }}</span>
                    <div class="progress-bar"></div>
                </div>

            </router-link>

            <router-link class="button" to="/customer">
                <span class="material-icons">person</span>
                <span class="text">ลูกค้า</span>
                <!-- <span class="text">Customer</span> -->
            </router-link>
             <router-link class="button" to="/saleorder">
                <span class="material-icons">receipt_long</span>
                <span class="text">รายการใบสั่งขาย</span>
                <!-- <span class="text">List Sale Order</span> -->
            </router-link>

            <router-link class="button" v-if="isFa || isAdmin" to="/saleorderapprove" id="saleorderapprove">
                <span class="material-icons">assignment_turned_in</span>
                <span class="text">อนุมัติใบสั่งขาย</span>

              <div
                  v-if="toast.show && toast.target === 'saleorderapprove'"
                  class="toast"
              >
                  <span class="material-icons bell">notifications</span>
                  <span>{{ toast.message }}</span>
                  <div class="progress-bar"></div>

              </div>

            </router-link>


            <!-- register -->
            <router-link class="button" to="/registerdedtStatust">
                <span class="material-icons">group</span>
                <span class="text">ลงทะเบียนผู้ใช้</span>
                <!-- <span class="text">Register</span> -->
            </router-link>
            <router-link class="button" to="/showdataemp">
                <span class="material-icons">list_alt</span>
                <span class="text">รายชื่อผู้ใช้และพนักงาน</span>
                <!-- <span class="text">List User Employee</span> -->
            </router-link>

        </div>

        <div class="flex flex_x"></div>

    </aside>
</template>

<script setup>

import { ref, onMounted  } from 'vue';
import { useRouter, useRoute } from 'vue-router';

const isAdmin = ref(localStorage.getItem('role_admin') === 'true');
const isFa = ref(localStorage.getItem('role_fa') === 'true');

// eslint-disable-next-line no-unused-vars
const router = useRouter();
const route = useRoute();

const is_expanded = ref(localStorage.getItem("is_expanded") === "true");

const toast = ref({
  show: false,
  message: '',
  target: '', // ปุ่มที่จะโชว์ toast
});

function showToastForUser() {
    // ตรวจสอบ role ของ user
    if (isFa.value) {
        toast.value = {
            show: true,
            message: 'รายการที่ต้องอนุมัติสำหรับ FA',
            target: 'saleorderapprove',
        };
    } else if (!isFa.value && !isAdmin.value) {
        toast.value = {
            show: true,
            message: 'สร้างรายการขายสำหรับ CRM',
            target: 'createsalelist',
        };
    }

    // ปิด toast หลัง 4 วินาที
    setTimeout(() => toast.value.show = false, 4000);
}

onMounted(() => {
    showToastForUser();
});


const ToggleMenu = () => {
    is_expanded.value = !is_expanded.value

    // set ค่าให้ตอนทำการรีเฟสหน้าจะไม่ทำการปิด sidebar
    localStorage.setItem("is_expanded", is_expanded.value);
}


function forceReload(event) {
    // เส้นทางลิงก์เป้าหมาย
    const targetHref = event.currentTarget.getAttribute('href');
    // เส้นทางปัจจุบัน + query string
    const currentFullPath = route.fullPath; // e.g. "/saleList?documentNo=H1-SO25680805-00006"



    // ถ้าเรากำลังอยู่ที่ saleList?... แล้วกดไป createsalelist ให้รีโหลดทั้งหน้า
    if (
        currentFullPath.startsWith('/saleList') ||  currentFullPath.startsWith('/createsalelist') &&
        targetHref === '/createsalelist'
    ) {
        event.preventDefault();               // ยกเลิกการทำงานของ router-link
        window.location.href = targetHref;    // บังคับให้โหลดใหม่ทั้งหน้า
        return;
    }

}

// const forceReload = (event) => {
//   const targetHref = event.currentTarget.getAttribute('href');

//   // ถ้าไม่ใช่หน้า /createsalelist ให้รีเฟรช
//   if (!targetHref.includes('/createsalelist')) {
//     event.preventDefault(); // ป้องกัน router-link ปกติ
//     window.location.href = targetHref; // รีโหลดหน้าใหม่
//   }
//   // ถ้าเป็น /createsalelist ให้ปล่อยให้ router-link ทำงานตามปกติ
// };

// const forceReload = (event) => {
//   event.preventDefault(); // ป้องกันไม่ให้ router-link ทำงาน
//   window.location.href = event.currentTarget.getAttribute('href'); // บังคับ reload ทั้งหน้า
// }

</script>

<style lang="scss" scoped>
// .material-symbols-outlined {
//   font-variation-settings:
//   'FILL' 0,
//   'wght' 400,
//   'GRAD' 0,
//   'opsz' 24;

// }
aside {
    position: fixed;
    /* top: 0; */
    /* left: 0; */
    /* height: 100vh; */
    /* z-index: 50; */
    top: 4rem;
    /* ✅ กำหนดให้ไม่ทับ navbar */
    left: 0;
    height: calc(100vh - 4rem);
    /* ✅ ลดความสูงลงจาก navbar */
    /* z-index: 40; */ /* ต่ำกว่า navbar ที่ z-50 */
    z-index: 55;
    display: flex;
    flex-direction: column;
    width: calc(2rem + 32px);
    /* min-height: 100vh; */
    overflow: hidden;
    padding: 1rem;

    background-color: var(--dark);
    color: var(--light);

    transition: 0.2s ease-out;
    /* transform: translateX(0); */ /* แสดงปกติ */

    .flex_x {
        flex: 1 1 0;
    }

    .logo {
        /* display: flex; */
        /* margin-bottom: 1rem; */
        /* margin-bottom: 1.4rem; */
        /* margin-bottom: -0.5rem; */

        .box-cursor {
            display: flex;
            margin-bottom: -0.5rem;

            img {
                width: 2rem;
                /* cursor: pointer; */
                position: static;
                z-index: 99;
            }
        }
    }

    .menu-toggle-wrap {
        display: flex;
        justify-content: flex-end;
        margin-bottom: 1rem;

        position: relative;
        top: 0;
        transition: 0.2s ease-out;

        .menu-toggle {
            transition: 0.2s ease-out;

            .material-icons {
                font-size: 2rem;
                color: var(--light);
            }

            /* ปรับสีตอนชี้ iconพร้อมขยับทางแกน x */
            &:hover {
                .material-icons {
                    color: var(--primary);
                    transform: translateX(0.5rem);
                }
            }
        }
    }

    h3,
    .button .text {
        opacity: 0;
        transition: 0.3s ease-out;
    }

    /* ปรับสี menu และขนาดเป็นใหญ่ทั้งหมด */
    h3 {
        color: var(--gray);
        font-size: 0.875rem;
        margin-bottom: 0.5rem;
        text-transform: uppercase;
    }

    .menu {
        margin: 0 -1rem;

        .button {
            display: flex;
            align-items: center;
            text-decoration: none;

            padding: 0.5rem 1rem;
            transition: 0.2s ease-out;

            .material-icons {
                font-size: 2rem;
                color: var(--light);
                margin-right: 1rem;
                transition: 0.2s ease-out;
            }

            .text {
                color: var(--light);
                transition: 0.2s ease-out;
            }

            &:hover,
            &.router-link-exact-active {
                background-color: var(--dark-alt);

                .material-icons .text {
                    color: var(--primary);
                }

                /* &.router-link-exact-active {
                    border-right: 5px solid var(--primary);
                } */
            }

            &.router-link-exact-active {
                border-right: 5px solid var(--primary);
            }
        }
    }

    &.is-expanded {
        /* ขนาดที่ set ไว้ใน main */
        width: 240px;
        /* width: var(--sidebar-width); */

        .menu-toggle-wrap {
            top: -3rem;

            .menu-toggle {
                transform: rotate(-180deg); /* หมุน 180oc */
            }
        }

        h3,
        .button .text {
            opacity: 1;
        }

        .botton {
            .material-icons {
                margin-right: 1rem;
            }
        }
    }

    /* &.sidebar-hidden {
        transform: translateX(-100%);
    } */

    @media (max-width: 430px) {
        // width: 100vw; /* เพิ่ม property จริงเพื่อไม่ให้ empty */
        /* margin-left: 0rem; */
    }

    @media (max-width: 768px) {
        /* position: relative; */
        position: fixed;
        /* width: var(--sidebar-width); */ /* หรือจะใช้ full width ก็ได้ */
        /* z-index: 15; */
        z-index: 99;
    }
}



/* New Styles */
/* ปรับขนาดไอคอนให้เล็กลงและจัดระยะ */
.menu .button {
    display: flex;
    align-items: center;
    gap: 10px; /* ระยะห่างระหว่างไอคอนกับข้อความ */
    padding: 8px 12px;
    border-radius: 6px;
    transition: background 0.2s;
}

.menu .button span.material-icons {
    font-size: 28px; /* ปรับขนาดไอคอนให้เล็กลง */
    color: #d7d7d7; /* สีไอคอน */
}

/* เมื่อ hover ที่เมนู */
.menu .button:hover {
    background-color: #f0f0f0;
}

/* ปรับข้อความให้สวยและไม่ใหญ่เกินไป */
.menu .button .text {
    font-size: 14px;
    font-weight: 500;
    color: #333;
}


// new toast style

.toast {
    position: fixed;
    left: 80px; /* ข้างปุ่ม */
    top: 20%;
    transform: translateY(-50%);
    background: #333;
    color: #fff;
    padding: 0.5rem 1rem;
    border-radius: 6px;
    white-space: nowrap;
    z-index: 9999;
    box-shadow: 0 4px 10px rgba(0,0,0,0.3);
    font-size: 13px;

    .progress-bar {
        position: absolute;
        bottom: 0;
        left: 0;
        height: 3px;
        background: #4caf50;
        animation: progress 4s linear forwards;
        width: 0;
        border-radius: 0 0 6px 6px;
    }

    // .bell {
    //   color: #FFD700; /* สีเหลืองทอง */
    //   font-size: 5px;
    // }

}

.bell {
  font-size: 23px !important; /* ปรับขนาดตามต้องการ เช่น 24px, 32px */
  color: #FFC107;  /* สีเหลือง */
  vertical-align: middle; /* จัดให้อยู่กึ่งกลางกับข้อความ */
}

@keyframes progress {
    from { width: 100%; }
    to { width: 0%; }
}


</style>

<!--

/* New Styles */
/* ปรับขนาดไอคอนให้เล็กลงและจัดระยะ */
.menu .button {
    display: flex;
    align-items: center;
    gap: 10px; /* ระยะห่างระหว่างไอคอนกับข้อความ */
    padding: 8px 12px;
    border-radius: 6px;
    transition: background 0.2s;
}

.menu .button span.material-icons {
    font-size: 28px; /* ปรับขนาดไอคอนให้เล็กลง */
    color: #d7d7d7; /* สีไอคอน */
}

/* เมื่อ hover ที่เมนู */
.menu .button:hover {
    background-color: #f0f0f0;
}

/* ปรับข้อความให้สวยและไม่ใหญ่เกินไป */
.menu .button .text {
    font-size: 14px;
    font-weight: 500;
    color: #333;
} -->


   <!-- <router-link class="button"
             v-if="isFa || isAdmin"
            to="/saleorderapprove">
                <span class="material-icons">assignment_turned_in</span>
                <span class="text">อนุมัติใบสั่งขาย</span>
            </router-link> -->

              <!-- <router-link class="button" to="/saleorderapprove">
                <span class="material-symbols-outlined">order_approve</span>
                <span class="text">อนุมัติใบสั่งขาย</span>

            </router-link> -->

            <!-- <router-link class="button" to="/">
                <span class="material-icons">home</span>
                <span class="text">home</span>
            </router-link> -->
            <!-- <router-link class="button" to="/dashboard">
                <span class="material-icons">space_dashboard</span>
                <span class="text">แดชบอร์ด</span>

            </router-link> -->
            <!-- <span class="text">Dashboard</span> -->


            <!-- <span class="text">Create a sales list</span> -->
            <!-- <router-link class="button" to="/createsalelist">
                <span class="material-icons">assignment_add</span>
                <span class="text">สร้างรายการขาย</span>
            </router-link> -->



            <!-- <router-link class="button" to="/createsalelist" @click.native="forceReload">
                <span class="material-icons">assignment_add</span>
                <span class="text">สร้างรายการขาย</span>
                 <span class="text">Create a sales list</span>
            </router-link> -->
            <!-- <router-link class="button" to="/activity-log">
                <span class="material-symbols-outlined">browse_activity</span>
                <span class="text">activitylog</span>
            </router-link> -->
            <!-- <router-link class="button" to="/about">
                <span class="material-icons">visibility</span>
                <span class="text">About</span>
            </router-link> -->



        <!-- <div class="menu">
            <router-link class="button" to="/techstack">
                <span class="material-icons">code</span>
                <span class="text">TeckStack</span>
            </router-link>
        </div> -->
        <!-- <div class="menu">
            <router-link class="button" to="/setting">
                <span class="material-icons">settings</span>
                <span class="text">Settings</span>
            </router-link>
        </div> -->
