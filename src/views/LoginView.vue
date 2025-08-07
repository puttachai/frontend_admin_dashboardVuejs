<template>
  <div class="min-h-screen bg-gradient-to-br from-orange-400 to-red-500 flex items-center justify-center relative overflow-hidden font-sans">
    <div class="absolute right-4 top-4 text-white rotate-90 tracking-widest font-semibold text-sm">
      DESIGN D POWER 
    </div>

    <div class="max-w-7xl w-full mx-auto flex flex-col md:flex-row items-center justify-between p-8 gap-10">
      <!-- Left Content -->
      <div class="text-white max-w-lg space-y-6 animate-fade-in">
        <h1 class="text-4xl md:text-5xl font-extrabold leading-tight">D-Power IT Technology</h1>
        <p class="text-sm md:text-base">
          บริษัทผู้ผลิตและจัดจำหน่ายสินค้าไอที อิเล็กทรอนิกส์ และ Gadget 
          และขอต้อนรับสู่ระบบ Dashboard เพื่อจัดการข้อมูลและสร้างรายการขาย.
        </p>

        <transition name="expand">
          <div v-show="showMore" class="bg-white bg-opacity-10 p-4 rounded-lg text-sm overflow-hidden transition-all duration-500 ease-in-out">
            บริษัท ดีเพาเวอร์ ไอที เทคโนโลยี เป็นบริษัทผู้ผลิตและจัดจำหน่ายสินค้าประเภทไอที อิเล็กทรอนิกส์ อุปกรณ์เสริมโทรศัพท์มือถือทุกประเภท รวมถึงอะไหล่ต่างๆ และสินค้าในกลุ่ม gadget สินค้าของเรามีหลากหลายมากมาพร้อมตอบสนองลูกค้าทุกไลฟ์สไตล์ ทุกช่องทาง ไม่ว่าจะเป็นทางออนไลน์ Modern Trade ร้านค้าต่างๆ รวมไปถึงงานแฟร์ที่เราได้มีส่วนร่วมในทุกคร้่ง<br><br>
            ตัวอย่างสินค้าที่เป็นที่รู้จักของเราเช่น แบตเตอรี่ ลำโพงบลูทูธ หูฟัง สายชาร์จ Power bank, Adapter, USB
          </div>
        </transition>

        <button @click="toggleInfo" class="mt-2 px-6 py-2 bg-white text-orange-600 font-semibold rounded-full shadow-lg hover:bg-gray-100 transition transform hover:scale-105">
          {{ showMore ? 'ซ่อนข้อมูล' : 'อ่านเพิ่มเติม' }}
        </button>
      </div>

      <!-- Right Login Form -->
      <div class="bg-white p-10 rounded-3xl shadow-2xl w-full max-w-sm transform hover:scale-[1.02] transition duration-500">
        <div class="flex flex-col items-center mb-6">
          <div class="text-3xl font-bold text-orange-500 mb-1">Welcome, Admin</div>
          <p class="text-sm text-gray-500 text-center">
            เข้าสู่ระบบเพื่อจัดการข้อมูลการขาย โปรโมชั่น และดูภาพรวมระบบ D-Power Dashboard
          </p>
        </div>

        <form @submit.prevent="handleLogin" class="space-y-5">
            
          <div class="relative">
            <input
              type="text"
              placeholder="ชื่อผู้ใช้งาน"
              v-model="username"
              class="peer w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-orange-400 focus:outline-none placeholder-transparent"
            />
            <!-- <label class="absolute left-4 top-2 text-sm text-gray-500 peer-placeholder-shown:top-3 peer-placeholder-shown:text-base peer-placeholder-shown:text-gray-400 transition-all">
              ชื่อผู้ใช้งาน
            </label> -->
          </div>

          <div class="relative">
            <input
              type="password"
              placeholder="รหัสผ่าน"
              v-model="password"
              class="peer w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-orange-400 focus:outline-none placeholder-transparent"
            />
            <!-- <label class="absolute left-4 top-2 text-sm text-gray-500 peer-placeholder-shown:top-3 peer-placeholder-shown:text-base peer-placeholder-shown:text-gray-400 transition-all">
              รหัสผ่าน
            </label> -->
          </div>

          <div class="flex items-center space-x-2">
            <input
              type="checkbox"
              id="rememberMe"
              v-model="rememberMe"
              class="w-4 h-4 text-orange-500 border-gray-300 rounded focus:ring-orange-400"
            />
            <label for="rememberMe" class="text-sm text-gray-600">จำฉันไว้</label>
          </div>


          <button
            type="submit"
            :disabled="isLoading"
            class="w-full bg-orange-500 hover:bg-orange-600 text-white font-bold py-2 rounded-lg shadow-md transition-transform hover:scale-[1.02] disabled:opacity-50 disabled:cursor-not-allowed"
          >
            <span v-if="!isLoading">LOGIN</span>
            <span v-else>กำลังเข้าสู่ระบบ...</span>
          </button>

          <!-- <button
            type="submit"
            class="w-full bg-orange-500 hover:bg-orange-600 text-white font-bold py-2 rounded-lg shadow-md transition-transform hover:scale-[1.02]"
          >
            LOGIN
          </button> -->

          <div class="text-center text-sm text-gray-400">หรือเข้าสู่ระบบด้วยวิธีอื่น</div>
          <div class="flex justify-center">
            <svg class="w-6 h-6 text-orange-500 animate-bounce" fill="none" stroke="currentColor" stroke-width="2"
              viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M19 9l-7 7-7-7" />
            </svg>
          </div>

        </form>


      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import Swal from 'sweetalert2'
import axios from 'axios'
import { useRouter } from 'vue-router'


const BASE_URL = import.meta.env.VITE_API_URL;
console.log("Show BASE_URL: ", BASE_URL);

const username = ref('')
const password = ref('')
const customer = ref('')

const showMore = ref(false)

const customer_id = ref('')
const customer_no = ref('')

const error = ref('')
const router = useRouter()

const isLoading = ref(false)
const rememberMe = ref(false)

const toggleInfo = () => {
  showMore.value = !showMore.value
}


// โหลดค่าที่เคยจำไว้ (ตอน mounted)
onMounted(() => {
  const remembered = localStorage.getItem("remember_me") === "true";
  const rememberedUsername = localStorage.getItem("remembered_username") || '';
  const rememberedPassword = localStorage.getItem("remembered_password") || '';

  if (remembered) {
    username.value = rememberedUsername;
    password.value = rememberedPassword;
    rememberMe.value = true;
  }
});


const handleLogin = async () => {
  if (isLoading.value) return; // ป้องกันการกดซ้ำ


   isLoading.value = true;

  try {
    console.log("Show BASE_URL try: ", BASE_URL);
    const response = await axios.post(`${BASE_URL}/user/accountLogin4`, {
      account: username.value,
      password: password.value,
      customer: '',
      version: '2.0.2',
      //
    }, {
      // withCredentials: true,
      headers: {
        'Content-Type': 'application/json'
      }
    });

    console.log("Show Data: ", response);
    console.log("Show response.data.data.data2: ", response.data.data.data2);

    if (response.data.code == 1) {

      const userInfo = response.data.data.data.data2[0];
      const groupVal = userInfo.groups; // ตัวเลขเดี่ยว เช่น 10
      const groupArr = [parseInt(groupVal)]; // แปลงเป็น array [10]

      console.log("Show groupStr: ", groupVal);
      console.log("Show groupArr: ", groupArr);

      // เคลียร์ role เก่า
      localStorage.removeItem("role_admin");
      localStorage.removeItem("role_fa");
      localStorage.removeItem("role_product");
      localStorage.removeItem("role_crm");

      // เซ็ต role ใหม่
      const isAdmin = groupArr.includes(1);
      const isFa = groupArr.includes(3);
      const isProduct = groupArr.includes(7);
      const isCrm = groupArr.includes(10);

      console.log("Show isCrm: ", isCrm);

      if (isAdmin) localStorage.setItem("role_admin", "true");
      if (isFa) localStorage.setItem("role_fa", "true");
      if (isProduct) localStorage.setItem("role_product", "true");
      if (isCrm) localStorage.setItem("role_crm", "true");

      const getrole_crm = localStorage.getItem('role_crm');
      console.log("Show getrole_crm: ", getrole_crm);

      // บันทึกสถานะ login
      localStorage.setItem('isAuthenticated', 'true');
      localStorage.setItem('customer_id', customer_id.value);  //23
      localStorage.setItem('customer_no', customer_no.value); //"AP00025202"
      localStorage.setItem('account', username.value);
      localStorage.setItem('password', password.value);
      localStorage.setItem('token', response.data.data.token || '');
      localStorage.setItem('level', response.data.data.level || '');

      // บันทึกหรือเคลียร์การจดจำ
      if (rememberMe.value) {
        localStorage.setItem("remember_me", "true");
        localStorage.setItem("remembered_username", username.value);
        localStorage.setItem("remembered_password", password.value);
      } else {
        localStorage.removeItem("remember_me");
        localStorage.removeItem("remembered_username");
        localStorage.removeItem("remembered_password");
      }

      // แจ้งเตือน login สำเร็จ
      Swal.fire({
        title: 'ล็อกอินสำเร็จ',
        icon: 'success',
        timer: 1500,
        showConfirmButton: false,
      });

      // 👉 ตรวจเงื่อนไข redirect
      if (isCrm || isProduct || isFa || isAdmin) {
        router.push("/customer");
      } else {
        router.push("/dashboard");
      }
    }


  } catch (err) {
    error.value = err.response?.data?.message || 'Server error'
    Swal.fire({
      title: 'ไม่สามารถเชื่อมต่อกับ API Server ได้',
      text: error.value || 'โปรดลองใหม่ภายหลัง',
      icon: 'error',
    });
  } finally {
    isLoading.value = false; // เปิดให้กดได้อีกครั้ง
  }
}

</script>


<style scoped>
body {
  font-family: 'Inter', sans-serif;
}

@keyframes fade-in {
  0% {
    opacity: 0;
    transform: translateY(10px);
  }
  100% {
    opacity: 1;
    transform: translateY(0);
  }
}
.animate-fade-in {
  animation: fade-in 1s ease-out;
}

.expand-enter-active,
.expand-leave-active {
  transition: all 0.5s ease-in-out;
  max-height: 500px;
  opacity: 1;
}
.expand-enter-from,
.expand-leave-to {
  max-height: 0;
  opacity: 0;
  overflow: hidden;
}
</style>
