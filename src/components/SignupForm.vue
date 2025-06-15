<template>
    <div class="w-full md:w-1/2 p-10">
      <h4 class="text-2xl font-semibold text-center">Sign Up for an Account</h4>
      <p class="text-center text-gray-500 mb-8">
        Let's get you all set up so you can start creating your <br />
        first onboarding experience
      </p>
  
      <div class="max-w-md mx-auto space-y-4">
        <form @submit.prevent="handleSubmit" class="max-w-md mx-auto space-y-4">
        <div class="flex space-x-4">
          <input type="text" name="firstname" v-model="firstname" placeholder="First Name" class="w-1/2 px-4 py-2 border rounded-md" />
          <input type="text" name="lastname" v-model="lastname" placeholder="Last Name" class="w-1/2 px-4 py-2 border rounded-md" />
        </div>
        <input type="email" name="email" v-model="email" placeholder="Email" class="w-full px-4 py-2 border rounded-md" />
        <input type="password" name="password" v-model="password" placeholder="Password" class="w-full px-4 py-2 border rounded-md" />
  
        <div class="flex justify-between items-center text-sm">
          <label class="flex items-center">
            <input type="checkbox" v-model="accepted" class="mr-2" /> I Accept AAE
          </label>
          <span class="text-blue-500">Terms & Conditions</span>
        </div>
  
        <button class="w-full bg-blue-500 text-white py-2 rounded-md">Sign up</button>
      </form>
      </div>
    </div>
  </template>
  
<script>
import axios from 'axios';
import Swal from 'sweetalert2';

// const BASE_URL= import.meta.env.VITE_API_URL;

  export default {
    data(){
      return{
        firstname:'',
        lastname:'',
        email: '',
        password: '',
        accepted: false
      }
    },
    methods: {

      generateEmpId() {
        // สุ่มเลข 6 หลัก (string)
        return Math.floor(100000 + Math.random() * 900000).toString();
      },

      async handleSubmit() {

        if(!this.firstname || !this.lastname || !this.email || !this.password || !this.accepted){
          // alert('Please fill in all fields.');
          Swal.fire({
            title:'กรอกข้อมูลแบบฟอร์มไม่ครบ',
            text:'โปรดกรอกข้อมูลในการสมัครให้ครบถ้วน',
            icon:'warning',
          });
          return;
        }

        const full_name = `${this.firstname} ${this.lastname}`;
        const emp_ids = this.generateEmpId();

        const payload = {
          full_name,
          email: this.email,
          password: this.password,
          emp_ids // ส่ง emp_id ไปด้วย
        };

        try {
          
          // const response = await axios.post(`${BASE_URL}/api_admin_dashboard/backend/api/signupMain.php`, payload);
          const response = await axios.post('/api/api/signupMain.php', payload);
          const result = response.data;

          console.log("Log Value Result: ",result);

          if(result.success){
            Swal.fire({
              title:'สมัครสมาชิกสำเร็จ',
              text: `รหัสพนักงานของคุณคือ: ${emp_ids} โปรดรอการอนุมัติการเป็นสมาชิก`,
              icon:'success',
            });
          } else {
            Swal.fire({
              title:'สมัครสมาชิกไม่สำเร็จ',
              text: result.message || 'โปรดลองใหม่ภายหลัง',
              icon:'error',
            });
          }

        } catch (error) {
          console.error(error);
          Swal.fire('Error submitting form.', 'error')
        }

      }
    }

  }
</script>

<!-- 
<template>
  <div class="w-full md:w-1/2 p-10">
    <h4 class="text-2xl font-semibold text-center">Sign Up for an Account</h4>
    <p class="text-center text-gray-500 mb-8">
      Let's get you all set up so you can start creating your <br />
      first onboarding experience
    </p>

    <div class="max-w-md mx-auto space-y-4">
      <form @submit.prevent="handleSubmit" class="space-y-4">
        <div class="flex space-x-4">
          <input type="text" name="firstname" v-model="firstname" placeholder="First Name" class="w-1/2 px-4 py-2 border rounded-md" />
          <input type="text" name="lastname" v-model="lastname" placeholder="Last Name" class="w-1/2 px-4 py-2 border rounded-md" />
        </div>
        <input type="email" name="email" v-model="email" placeholder="Email" class="w-full px-4 py-2 border rounded-md" />
        <input type="password" v-model="password" placeholder="Password" class="w-full px-4 py-2 border rounded-md" />

        <div class="flex justify-between items-center text-sm">
          <label class="flex items-center">
            <input type="checkbox" v-model="accepted" class="mr-2" /> I Accept AAE
          </label>
          <span class="text-blue-500">Terms & Conditions</span>
        </div>

        <button class="w-full bg-blue-500 text-white py-2 rounded-md">Sign up</button>
      </form>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import Swal from 'sweetalert2';

export default {
  data() {
    return {
      firstname: '',
      lastname: '',
      email: '',
      password: '',
      accepted: false
    };
  },
  methods: {
    async handleSubmit() {
      if (!this.firstname || !this.lastname || !this.email || !this.password) {
        Swal.fire({
          title: 'กรอกข้อมูลแบบฟอร์มไม่ครบ',
          text: 'โปรดกรอกข้อมูลในการสมัครให้ครบถ้วน',
          icon: 'warning'
        });
        return;
      }

      const full_name = `${this.firstname} ${this.lastname}`;
      const payload = {
        full_name,
        email: this.email,
        password: this.password
      };

      try {
        const response = await axios.post("http://localhost/api_admin_dashboard/singupMain.php", payload);
        const result = response.data;

        if (result.success) {
          Swal.fire({
            title: 'สมัครสมาชิกสำเร็จ',
            text: 'โปรดรอการอนุมติการเป็นสมาชิก',
            icon: 'success'
          });
        } else {
          Swal.fire({
            title: 'สมัครสมาชิกไม่สำเร็จ',
            text: result.message || 'โปรดลองใหม่ภายหลัง',
            icon: 'error'
          });
        }

      } catch (error) {
        console.error(error);
        Swal.fire({
          title: 'เกิดข้อผิดพลาด',
          text: 'ไม่สามารถเชื่อมต่อกับเซิร์ฟเวอร์ได้',
          icon: 'error'
        });
      }
    }
  }
};
</script> -->
