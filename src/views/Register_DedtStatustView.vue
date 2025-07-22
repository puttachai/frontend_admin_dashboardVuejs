<template>
    <div class="min-h-screen flex items-center justify-center bg-gray-100 py-12 px-4 sm:px-6 lg:px-8">
        <div class="max-w-4xl w-full bg-white p-8 rounded-2xl shadow-lg">

            <!-- Logo and Title -->
            <div class="text-center mb-4">
                <img src="../assets/logo.svg" alt="Logo" class="mx-auto h-16">
                <!-- <h2 class="text-3xl font-extrabold text-gray-900">GEKKO</h2>
                <p class="text-blue-500 text-sm tracking-wide uppercase">Shop</p> -->
                <p class="mt-1 text-xl text-gray-700">Register Debt collection</p>
            </div>

            <div class="md:col-span-2 mb-2 pb-2">
                <label class="block text-sm font-medium text-gray-700">Upload Image</label>
                <input type="file" accept="image/*" @change="handleImageUpload" class="mt-1 block w-full cursor-pointer rounded-md border text-sm text-gray-500 file:mr-4 file:mb-4
                file:cursor-pointer file:rounded-md file:border-0 file:text-sm file:font-semibold 
                file:bg-purple-50 file:text-purple-700 hover:file:bg-purple-100" />
            </div>

            <!-- แสดงภาพที่อัปโหลด -->
            <div class="md:col-span-2 mb-4 pb-4" v-if="previewImage">
                <p class="text-sm text-gray-500 mb-2">Preview:</p>
                <img :src="previewImage" alt="Uploaded Image"
                    class="object-cover rounded-md border w-[100px] h-[100px]" />
            </div>

            <!-- Form Fields -->
            <form class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                    <label class="block text-sm font-medium text-gray-700">Employee ID</label>
                    <input type="text" readonly v-model="formData.emp_ids"
                        class="mt-1 block w-full rounded-md border-gray-300 bg-gray-50 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700">Full Name</label>
                    <input type="text" v-model="formData.fullName"
                        class="mt-1 block w-full rounded-md border-gray-300 bg-gray-50 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700">Email</label>
                    <input type="email" v-model="formData.email"
                        class="mt-1 block w-full rounded-md border-gray-300 bg-gray-50 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700">Password</label>
                    <input type="password" v-model="formData.password"
                        class="mt-1 block w-full rounded-md border-gray-300 bg-gray-50 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700">Address</label>
                    <input type="text" v-model="formData.address"
                        class="mt-1 block w-full rounded-md border-gray-300 bg-gray-50 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700">Confirm Password</label>
                    <input type="password" v-model="formData.confirmPassword"
                        class="mt-1 block w-full rounded-md border-gray-300 bg-gray-50 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700">Department</label>
                    <input type="text" v-model="formData.department"
                        class="mt-1 block w-full rounded-md border-gray-300 bg-gray-50 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700">Phone</label>
                    <input type="text" v-model="formData.phone"
                        class="mt-1 block w-full rounded-md border-gray-300 bg-gray-50 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700">Start Date</label>
                    <input type="date" v-model="formData.start_work"
                        class="mt-1 block w-full rounded-md border-gray-300 bg-gray-50 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700">Salary</label>
                    <input type="text" v-model="formData.salary"
                        class="mt-1 block w-full rounded-md border-gray-300 bg-gray-50 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                </div>

                <!-- <div>
                    <label class="block text-sm font-medium text-gray-700">Status</label>
                    <input type="text" v-model="formData.status"
                        class="mt-1 block w-full rounded-md border-gray-300 bg-gray-50 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                </div> -->

                <!-- <div class="md:col-span-2">
                    <label class="block text-sm font-medium text-gray-700">Salary</label>
                    <input type="text" v-model="formData.salary"
                        class="mt-1 block w-full rounded-md border-gray-300 bg-gray-50 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                </div> -->

                <div class="md:col-span-2 mt-4">
                    <button type="submit" @click="register"
                        class="w-full bg-purple-700 text-white py-2 px-4 rounded-md hover:bg-purple-800 transition">Register
                    </button>
                </div>
            </form>
        </div>
    </div>
</template>

<script>
export default {
    name: 'SignupForm'
};
</script>

<script setup>

// const setValueForm =

import { ref, onMounted, watch } from 'vue';
import axios from 'axios';
import Swal from 'sweetalert2';

const BASE_URL = import.meta.env.VITE_API_URL_LOCAL;
// const BASE_URL = import.meta.env.VITE_API_URL;

const formData = ref({
    emp_ids: '',
    fullName: '',
    email: '',
    password: '',
    confirmPassword: '',
    phone: '',
    address: '',
    department: '',
    salary: '',
    status: 'Active',
    start_work: '',
    image: null, // เพิ่ม image ไว้เก็บไฟล์
});

const register = async () => {
    // if (formData.value.password !== formData.value.confirmPassword) {
    //     alert('Passwords do not match!')
    //     return
    // }

    // สร้างรหัสใหม่ก่อนส่ง
    formData.value.emp_ids = generateEmpId();

    const payload = new FormData();
    for (const key in formData.value) {
        console.log(`Appending ${key}:`, formData.value[key]); // ✅ เพิ่มบรรทัดนี้
        payload.append(key, formData.value[key]);
    }
    
    payload.append('status', formData.value.status || 'Active'); // เพิ่มบรรทัดนี้หลัง loop

    console.log("Form Data", formData.value);

    console.log("Log value payload:",payload);

    try {

        // const response = await axios.post('http://localhost/register.php', formData.value)
        const response = await axios.post(`${BASE_URL}/api_admin_dashboard/backend/api/register.php`, payload, {
            headers: {
                'Content-Type': 'multipart/form-data',
            },
        });

        const resData = typeof response.data === 'string' ? JSON.parse(response.data) : response.data;
            Swal.fire({
              title:'สมัครสมาชิกสำเร็จ',
              text: resData.message ||'อนุมัติการเป็นสมาชิก',
              icon:'success',
            });
        // alert(resData.message);

        console.log("Log value response:",response);
        // alert(response.data.message)

    } catch (err) {
        console.error("Full error:", err); // ✅ เพิ่ม log
        const message = err.response?.data?.message || err.message || 'Unknown error';
        alert('Error: ' + message);
        Swal.fire({
              title:'สมัครสมาชิกไม่สำเร็จ',
              text: message ||'โปรดลองใหม่ภายหลัง',
              icon:'error',
        });
    }
}

    const generateEmpId = () => {
        // สุ่มเลข 6 หลัก เช่น 000123
        return Math.floor(100000 + Math.random() * 900000).toString();
    };

    // โหลดค่าจาก localStorage ตอน mounted
    onMounted(() => {
        const saved = localStorage.getItem('signupForm')
        if (saved) {
            formData.value = JSON.parse(saved)
        } 
        // else {
        //     formData.value.emp_ids = generateEmpId(); // สร้างรหัสใหม่เมื่อยังไม่มี
        // }
    })

    // ทุกครั้งที่ formData เปลี่ยน จะเซฟลง localStorage
    watch(formData, (newValue) => {
        localStorage.setItem('signupForm', JSON.stringify(newValue))
    }, { deep: true })


    // previewImage ทันทีที่ upload 
    const previewImage = ref(null);

    const handleImageUpload = (event) => {
    const file = event.target.files[0];
    if (file && file.type.startsWith("image/")) {
        const reader = new FileReader();
        reader.onload = (e) => {
        previewImage.value = e.target.result; // base64 image preview
        };
        reader.readAsDataURL(file);

        // ถ้าต้องการส่งภาพพร้อม formData:
        formData.value.image = file; // เก็บไฟล์ไว้สำหรับ POST
    } else {
        previewImage.value = null;
        alert("Please select a valid image file.");
    }
    };


</script>

<style scoped>
/* Optional custom styles */
input {
    padding: 4px;
    width: 100%;
    height: 30px;
}
</style>