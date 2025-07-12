<template>
  <div class="w-full md:w-1/2 p-10">
    <h4 class="text-2xl text-gray-500 font-semibold text-center">Login to Your Account</h4>
    <p class="text-center text-gray-500 mb-8">
      Log in to your account so you can continue building <br />
      and editing your onboarding flows
    </p>

    <form @submit.prevent="handleLogin" class="max-w-md mx-auto space-y-6">
      <input
        v-model="mobile"
        type="text"
        placeholder="Mobile"
        class="w-full px-4 py-2 border rounded-md"
        autocomplete="mobile" 
        id="mobile" 
        name="mobile"
      />
      <input
        v-model="password"
        type="password"
        placeholder="Password"
        class="w-full px-4 py-2 border rounded-md"
        autocomplete="current-password" 
        id="password" 
        name="password"
      />
      <button type="submit" class="w-full bg-blue-500 text-white py-2 rounded-md">
        Log in
      </button>
    </form>

    <p v-if="error" class="text-red-500 text-sm text-center mt-4">{{ error }}</p>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import axios from 'axios'
import { useRouter } from 'vue-router'
import Swal from 'sweetalert2'
// import { version } from 'node:os';

const BASE_URL = import.meta.env.VITE_API_URL;
console.log("Show BASE_URL: ",BASE_URL);

const mobile = ref('')
const password = ref('')
const customer = ref('')
const error = ref('')
const router = useRouter()

const handleLogin = async () => {
  try {
    console.log("Show BASE_URL try: ",BASE_URL);
    const response = await axios.post(`${BASE_URL}/user/accountLogin4`, {
        account: mobile.value,
        password: password.value,
        customer:'',
        version:'2.0.2',
      // mobile: mobile.value,
        // password: password.value
      },{
      // withCredentials: true,
      headers: {
        'Content-Type': 'application/json'
      }
    });

    console.log("Show Data: ",response);
    // console.log(response.data.data.data.data2[0].nickname_admin);

    if (response.data.code == 1) {

      Swal.fire({
        title:'ล็อกอินสำเร็จ',
        icon:'success',
        timer: 2000,              // หน่วงเวลา 2 วินาที
        showConfirmButton: false, // ไม่แสดงปุ่ม OK
      });

      if(response.data.data.data.customer_count >1 ){
          
      // บันทึก token หรือตั้งค่า authenticated 
      localStorage.setItem('isAuthenticated', 'true');
      console.log("Log Respone Data:",response.data.data.data);
      localStorage.setItem('account', mobile.value);
      localStorage.setItem('password', password.value);

      localStorage.setItem('msg', response.data.msg);

      const msg = localStorage.getItem('msg');
      // console.log('Log msg: ',msg);
      
      router.push('/customer');

      }else{
        
      // บันทึก token หรือตั้งค่า authenticated 
      localStorage.setItem('isAuthenticated', 'true');
      localStorage.setItem('token', response.data.data.token || '');
      localStorage.setItem('level', response.data.data.level || '');

      localStorage.setItem('account', mobile.value);
      localStorage.setItem('password', password.value);
      
      const getToken = localStorage.getItem('token');
      console.log('Log getToken: ',getToken);

      router.push('/dashboard');
      }

    } else {
      error.value = response.data.message || 'Login failed'
      Swal.fire({
        title:'ล็อกอินไม่สำเร็จ',
        text: error.value || 'โปรดลองใหม่ภายหลัง',
        icon:'error',
      });
    }
  } catch (err) {
    error.value = err.response?.data?.message || 'Server error'
    Swal.fire({
        title:'ไม่สามารถเชื่อมต่อกับ API Server ได้',
        text: error.value || 'โปรดลองใหม่ภายหลัง',
        icon:'error',
    });
  }
}
</script>


<!-- <template>
    <div class="w-full md:w-1/2 p-10">
      <h4 class="text-2xl font-semibold text-center">Login to Your Account</h4>
      <p class="text-center text-gray-500 mb-8">
        Log in to your account so you can continue building <br />
        and editing your onboarding flows
      </p>
  
      <div class="max-w-md mx-auto space-y-6">
        <input type="mobile" placeholder="mobile" class="w-full px-4 py-2 border rounded-md" />
        <input type="password" placeholder="Password" class="w-full px-4 py-2 border rounded-md" />
        <button class="w-full bg-blue-500 text-white py-2 rounded-md">Log in</button>
      </div>
    </div>
  </template>
   -->