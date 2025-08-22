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
            <router-link class="button" to="/createsalelist" @click.native.prevent="forceReload">
                <span class="material-icons">assignment_add</span>
                <span class="text">สร้างรายการขาย</span>
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
            
            <!-- <router-link class="button" to="/">
                <span class="material-icons">home</span>
                <span class="text">home</span>
            </router-link> -->
            <!-- <router-link class="button" to="/dashboard">
                <span class="material-icons">space_dashboard</span>
                <span class="text">แดชบอร์ด</span>
                
            </router-link> -->
            <!-- <span class="text">Dashboard</span> -->
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

        </div>

        <div class="flex flex_x"></div>

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

    </aside>
</template>

<script setup>

import { ref } from 'vue';
import { useRouter, useRoute } from 'vue-router';

const router = useRouter();
const route = useRoute();

const is_expanded = ref(localStorage.getItem("is_expanded") === "true");

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
aside {
    position: fixed;
    // top: 0;
    // left: 0;
    // height: 100vh;
    // z-index: 50;
    top: 4rem;
    /* ✅ กำหนดให้ไม่ทับ navbar */
    left: 0;
    height: calc(100vh - 4rem);
    /* ✅ ลดความสูงลงจาก navbar */
    // z-index: 40; /* ต่ำกว่า navbar ที่ z-50 */
    z-index: 55;
    display: flex;
    flex-direction: column;
    width: calc(2rem + 32px);
    // min-height: 100vh;
    overflow: hidden;
    padding: 1rem;

    background-color: var(--dark);
    color: var(--light);

    transition: 0.2s ease-out;
    // transform: translateX(0); // แสดงปกติ

    .flex_x {
        flex: 1 1 0;
    }

    .logo {
        // display: flex;
        // margin-bottom: 1rem;
        // margin-bottom: 1.4rem;
        // margin-bottom: -0.5rem;

        .box-cursor {
            display: flex;
            margin-bottom: -0.5rem;

            img {
                width: 2rem;
                // cursor: pointer;
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

            //ปรับสีตอนชี้ iconพร้อมขยับทางแกน x
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

    //ปรับสี menu และขนาดเป็นใหญ่ทั้งหมด
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

                // &.router-link-exact-active {
                //     border-right: 5px solid var(--primary);
                // }
            }

            &.router-link-exact-active {
                border-right: 5px solid var(--primary);
            }
        }
    }

    &.is-expanded {
        // ขนาดที่ set ไว้ใน main 
        width: 240px;
        // width: var(--sidebar-width);

        .menu-toggle-wrap {
            top: -3rem;

            .menu-toggle {
                transform: rotate(-180deg); // หมุน 180oc
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

    &.sidebar-hidden {
        // transform: translateX(-100%);
    }

    @media (max-width: 430px) {

        // margin-left: 0rem;

    }

    @media (max-width: 768px) {
        // position: relative;
        position: fixed;
        // width: var(--sidebar-width); // หรือจะใช้ full width ก็ได้
        // z-index: 15;
        z-index: 99;
    }

}
</style>
