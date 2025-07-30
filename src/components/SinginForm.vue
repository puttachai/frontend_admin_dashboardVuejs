<template>
  <div class="w-full md:w-1/2 p-10">
    <h4 class="text-2xl text-gray-500 font-semibold text-center">Login to Your Account</h4>
    <p class="text-center text-gray-500 mb-8">
      Log in to your account so you can continue building <br />
      and editing your onboarding flows
    </p>

    <form @submit.prevent="handleLogin" class="max-w-md mx-auto space-y-6">
      <input v-model="mobile" type="text" placeholder="Mobile" class="w-full px-4 py-2 border rounded-md"
        autocomplete="mobile" id="mobile" name="mobile" />
      <input v-model="password" type="password" placeholder="Password" class="w-full px-4 py-2 border rounded-md"
        autocomplete="current-password" id="password" name="password" />
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

// import { logActivity } from '@/services/activityLogger.js'
import Swal from 'sweetalert2'
// import { version } from 'node:os';

const BASE_URL = import.meta.env.VITE_API_URL;
console.log("Show BASE_URL: ", BASE_URL);

const mobile = ref('')
const password = ref('')
const customer = ref('')

const customer_id = ref('')
const customer_no = ref('')

const error = ref('')
const router = useRouter()

const handleLogin = async () => {
  try {
    console.log("Show BASE_URL try: ", BASE_URL);
    const response = await axios.post(`${BASE_URL}/user/accountLogin4`, {
      account: mobile.value,
      password: password.value,
      customer: '',
      version: '2.0.2',
      // mobile: mobile.value,
      // password: password.value
    }, {
      // withCredentials: true,
      headers: {
        'Content-Type': 'application/json'
      }
    });

    console.log("Show Data: ", response);
    console.log("Show response.data.data.data2: ", response.data.data.data2);

    if (response.data.code == 1) {
      // const groupStr = response.data.data.data2.groups || "";
      // const groupArr = groupStr.split(",").map(g => parseInt(g));
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
      localStorage.setItem('account', mobile.value);
      localStorage.setItem('password', password.value);
      localStorage.setItem('token', response.data.data.token || '');
      localStorage.setItem('level', response.data.data.level || '');

      // const getcustomer_id = localStorage.getItem('customer_id', customer_id.value)
      // const getcustomer_no = localStorage.getItem('customer_no', customer_no.value)

      // console.log('Check customer_id: ', getcustomer_id) 
      // console.log('Check customer_no: ', getcustomer_no)

      // แจ้งเตือน login สำเร็จ
      Swal.fire({
        title: 'ล็อกอินสำเร็จ',
        icon: 'success',
        timer: 1500,
        showConfirmButton: false,
      });

      // 👉 ตรวจเงื่อนไข redirect
      if (isCrm || isProduct) {
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
  }
}
</script>


<!-- ใช้ได้เลย แต่ไม่สมบูรณ์กำหนดสิทธิ -->
<!-- // if (response.data.code == 1) {

    //   Swal.fire({
    //     title: 'ล็อกอินสำเร็จ',
    //     icon: 'success',
    //     timer: 2000,              // หน่วงเวลา 2 วินาที
    //     showConfirmButton: false, // ไม่แสดงปุ่ม OK
    //   });

    //   if (crm_accountSet === 'crm') {
    //     // if (accountType === 'crm') {

    //     if (response.data.data.data.customer_count > 1) { // ถ้าใช่ CRM เข้าหน้า customer

    //       // บันทึก token หรือตั้งค่า authenticated 
    //       localStorage.setItem('isAuthenticated', 'true');
    //       console.log("Log Respone Data:", response.data.data.data);
    //       localStorage.setItem('account', mobile.value);
    //       localStorage.setItem('password', password.value);

    //       localStorage.setItem('msg', response.data.msg);

    //       const msg = localStorage.getItem('msg');
    //       // console.log('Log msg: ',msg);

    //       localStorage.setItem('crm_account', crm_accountSet);
    //       console.log('Check crm_accountSet customer_count > 1: ', crm_accountSet);

    //       // await logActivity('crm_accountSet Login สำเร็จ', 'SinginForm.vue');

    //       router.push('/customer');

    //     } else { // ถ้าไม่ใช่ CRM เข้าหน้า DashBoard

    //       // บันทึก token หรือตั้งค่า authenticated 
    //       localStorage.setItem('isAuthenticated', 'true');
    //       localStorage.setItem('token', response.data.data.token || '');
    //       localStorage.setItem('level', response.data.data.level || '');

    //       // const permissions_crm ='crm';
    //       // localStorage.setItem('permissions_crm', permissions_crm);

    //       localStorage.setItem('account', mobile.value);
    //       localStorage.setItem('password', password.value);

    //       const getToken = localStorage.getItem('token');
    //       console.log('Log getToken: ', getToken);

    //       localStorage.setItem('crm_account', crm_accountSet);
    //       console.log('Check crm_accountSet customer_count < 1: ', crm_accountSet);

    //       // await logActivity('customer Login สำเร็จ', 'SinginForm.vue');

    //       router.push('/dashboard');
    //     }
    //   } else if (fa_accountSet) {
    //     if (response.data.data.data.customer_count > 1) { // ถ้าใช่ CRM เข้าหน้า customer

    //       // บันทึก token หรือตั้งค่า authenticated 
    //       localStorage.setItem('isAuthenticated', 'true');
    //       console.log("Log Respone Data:", response.data.data.data);
    //       localStorage.setItem('account', mobile.value);
    //       localStorage.setItem('password', password.value);

    //       localStorage.setItem('msg', response.data.msg);

    //       const msg = localStorage.getItem('msg');
    //       // console.log('Log msg: ',msg);
    //       localStorage.setItem('fa_account', fa_accountSet);
    //       console.log('Check fa_accountSet customer_count > 1 : ', fa_accountSet);

    //       // await logActivity('fa_account Login สำเร็จ', 'SinginForm.vue');

    //       router.push('/customer');

    //     } else { // ถ้าไม่ใช่ CRM เข้าหน้า DashBoard

    //       // บันทึก token หรือตั้งค่า authenticated 
    //       localStorage.setItem('isAuthenticated', 'true');
    //       localStorage.setItem('token', response.data.data.token || '');
    //       localStorage.setItem('level', response.data.data.level || '');

    //       // const permissions_crm ='crm';
    //       // localStorage.setItem('permissions_crm', permissions_crm);

    //       localStorage.setItem('account', mobile.value);
    //       localStorage.setItem('password', password.value);

    //       const getToken = localStorage.getItem('token');
    //       console.log('Log getToken: ', getToken);

    //       localStorage.setItem('fa_account', fa_accountSet);
    //       console.log('Check fa_accountSet customer_count < 1: ', fa_accountSet);

    //       // await logActivity('customer Login สำเร็จ', 'SinginForm.vue');

    //       router.push('/dashboard');
    //     }
    //   }

    // } else {
    //   error.value = response.data.message || 'Login failed'
    //   Swal.fire({
    //     title: 'ล็อกอินไม่สำเร็จ',
    //     text: error.value || 'โปรดลองใหม่ภายหลัง',
    //     icon: 'error',
    //   });
    // } -->

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