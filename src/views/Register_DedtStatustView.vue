<template>
    <!-- <div class="min-h-screen flex items-center justify-center bg-gray-100 py-12 px-4 sm:px-6 lg:px-8">
        <div class="max-w-4xl w-full bg-white p-8 rounded-2xl shadow-lg"> -->

    <div class="min-h-screen bg-gray-100 py-12 px-4 sm:px-6 lg:px-8">

        <!-- Layout flex แยก sidebar กับฟอร์ม -->
        <!-- <div class="flex relative transition-all duration-300"> -->

        <div class="relative flex transition-all duration-300 max-w-6xl mx-auto space-x-6">
            <!-- ปุ่มเปิด Sidebar -->
            <!-- <button
                v-if="!showCustomerSidebar"
                @click="showCustomerSidebar = true"
                class="absolute left-0 top-1/2 -translate-y-1/2 z-20 bg-purple-600 text-white rounded-r-full px-3 py-2 shadow-lg hover:bg-purple-700 transition"
                >
                <ArrowRightIcon class="w-5 h-5" />
            </button> -->

            <!-- ปุ่มเปิด Sidebar พร้อม Tooltip -->
            <div class="relative group">
                <button v-if="!showCustomerSidebar" @click="showCustomerSidebar = true"
                    class="absolute left-0 top-1/2 -translate-y-1/2 z-20 bg-purple-600 text-white rounded-r-full px-3 py-2 shadow-lg hover:bg-purple-700 transition">
                    <ArrowRightIcon class="w-5 h-5" />
                </button>

                <!-- Tooltip -->
                <div v-if="!showCustomerSidebar"
                    class="absolute -left-36 top-1/2 -translate-y-1/2 bg-gray-800 text-white text-sm px-3 py-1 rounded-md shadow-lg opacity-0 group-hover:opacity-100 transition-opacity duration-300 pointer-events-none">
                    เลือกร้านค้าของลูกค้า
                </div>
            </div>
            <!-- Sidebar ลูกค้า -->
            <div class="transition-all duration-300 flex-shrink-0 bg-white shadow-lg rounded-l-xl"
                :class="showCustomerSidebar ? 'w-[400px]' : 'w-0'">
                <div v-show="showCustomerSidebar" class="h-full w-full">
                    <CustomerSidebar :show="showCustomerSidebar" @close="showCustomerSidebar = false"
                        @selected="handleCustomerSelected" />
                </div>
            </div>


            <div :class="[
                'bg-white p-8 rounded-2xl shadow-lg transition-all duration-300 flex-1',
                showCustomerSidebar ? 'ml-0' : ''
            ]">

             <!-- ปุ่มเลือกลูกค้า -->
                <button @click="toggleCustomerSidebar"
                    class="bg-purple-500 text-white px-4 py-2 rounded-md hover:bg-purple-700 transition">
                    <div class="flex items-center space-x-2 gap-2">
                        <component :is="showCustomerSidebar ? ArrowLeftIcon : ArrowRightIcon" class="w-5 h-5" />
                        {{ showCustomerSidebar ? 'ปิดการเลือกร้านค้า' : 'เลือกร้านค้าของลูกค้า' }}
                    </div>
                </button>


                <!-- Logo and Title -->
                <div class="text-center mb-4">
                    <img src="../assets/logo.svg" alt="Logo" class="mx-auto h-16">
                    <!-- <h2 class="text-3xl font-extrabold text-gray-900">GEKKO</h2>
                <p class="text-blue-500 text-sm tracking-wide uppercase">Shop</p> -->
                    <p class="mt-1 text-xl text-gray-700">Register</p>
                </div>
                <div class="md:col-span-2 mb-2 pb-2">
                    <label class="block text-sm font-medium text-gray-700">Upload Image</label>
                    <input type="file" accept="image/*" @change="handleImageUpload" class="mt-1 block w-full cursor-pointer rounded-md border text-sm text-gray-500 file:mr-4 file:mb-4
                file:cursor-pointer file:rounded-md file:border-0 file:text-sm file:font-semibold 
                file:bg-purple-50 file:text-purple-700 hover:file:bg-purple-100" />
                </div>

                <div class="md:col-span-2 pb-4">
                    <label class="block text-sm font-medium text-gray-700">ค้นหาลูกค้า (Customer)</label>
                    <input type="text" v-model="searchCustomer" @input="fetchCustomers" placeholder="ค้นหาชื่อลูกค้า..."
                        class="mt-1 block w-full rounded-md border shadow-sm " />
                    <ul v-if="customers.length > 0"
                        class="bg-white border max-h-40 overflow-y-auto mt-2 rounded-md shadow-md">
                        <li v-for="customer in customers" :key="customer.customer_no" @click="selectCustomer(customer)"
                            class="px-4 py-2 hover:bg-purple-100 cursor-pointer">
                            {{ customer.nickname }}
                        </li>
                    </ul>
                    <div v-if="selectedCustomer" class=" py-6 text-sm text-purple-700">
                        เลือกร้านค้า: {{ selectedCustomer.nickname }}
                    </div>
                </div>

                

                <!-- Sidebar ลูกค้า -->
                <!-- <CustomerSidebar
                :show="showCustomerSidebar"
                @close="showCustomerSidebar = false"
                @selected="handleCustomerSelected"
            /> -->

                <!-- แสดงภาพที่อัปโหลด -->
                <div class="md:col-span-2 mb-4 pb-4" v-if="previewImage">
                    <p class="text-sm text-gray-500 mb-2">Preview:</p>
                    <img :src="previewImage" alt="Uploaded Image"
                        class="object-cover rounded-md border w-[100px] h-[100px]" />
                </div>

                <!-- Form Fields -->
                <form class="grid grid-cols-1 md:grid-cols-2 gap-4" @submit.prevent="register">
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
                        <button type="submit"
                            class="w-full bg-purple-700 text-white py-2 px-4 rounded-md hover:bg-purple-800 transition">
                            Register
                        </button>

                        <!-- <button type="submit" @click="register"
                        class="w-full bg-purple-700 text-white py-2 px-4 rounded-md hover:bg-purple-800 transition">Register
                    </button> -->
                    </div>
                </form>


            </div>
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
import router from '@/router';
import CustomerSidebar from '@/components/customersidebar/CustomerSidebar.vue'; // ✅ import
import { ArrowRightIcon, ArrowLeftIcon} from '@heroicons/vue/24/solid';

const BASE_URL_LOCAL = import.meta.env.VITE_API_URL_LOCAL;
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
    customer_no: '', // ✅ เพิ่มฟิลด์ customer_no
});


const previewImage = ref(null);

const searchCustomer = ref('');
const customers = ref([]);

const selectedCustomer = ref(null);
const showCustomerSidebar = ref(false);


const openCustomerSidebar = () => showCustomerSidebar.value = true;
const handleCustomerSelected = (cust) => {
    selectedCustomer.value = cust;
    formData.value.customer_no = cust.customer_no;
};

const toggleCustomerSidebar = () => {
  showCustomerSidebar.value = !showCustomerSidebar.value;
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


const fetchCustomers = async () => {
    try {
        const payload = {
            account: 'crm020',
            password: 'crm020',
            customer: '',
            version: '2.0.2',
            pageCurrent: 1,
            keyword: searchCustomer.value,
            pageSize: 15,
        };

        const res = await axios.post(`${BASE_URL_LOCAL}/addons/shopro/user/accountLogin4`, payload, {
        // const res = await axios.post('https://tgsc.qifudaren.net/addons/shopro/user/accountLogin4', payload, {
            headers: { 'Content-Type': 'application/json' },
        });

        if (res.data?.code === 1) {
            customers.value = res.data.data.data2;
        } else {
            customers.value = [];
        }
    } catch (error) {
        console.error('เกิดข้อผิดพลาดในการค้นหาลูกค้า:', error);
        customers.value = [];
    }
};

const selectCustomer = (customer) => {
    selectedCustomer.value = customer;
    customers.value = []; // clear dropdown list
    formData.value.customer_no = customer.customer_no; // 👉 เก็บ customer_no ลง formData
};


const register = async () => {
    // if (formData.value.password !== formData.value.confirmPassword) {
    //     alert('Passwords do not match!')
    //     return
    // }

    // ✔️ ตรวจสอบรหัสผ่านตรงกัน
    if (formData.value.password !== formData.value.confirmPassword) {
        Swal.fire({
            icon: 'warning',
            title: 'รหัสผ่านไม่ตรงกัน',
            text: 'กรุณาตรวจสอบรหัสผ่านอีกครั้ง',
        });
        return;
    }

    // สร้างรหัสใหม่ก่อนส่ง
    console.log("ส่งไฟล์:", formData.value.image);
    console.log("ส่ง type:", typeof formData.value.image);

    formData.value.emp_ids = generateEmpId();

    const payload = new FormData();
    for (const key in formData.value) {
        payload.append(key, formData.value[key]);
        console.log(`Appending ${key}:`, formData.value[key]); // ✅ เพิ่มบรรทัดนี้
    }

    // 2. แนบรูปแยกต่างหาก หากมีรูปจริง
    // if (formData.value.image instanceof File) {
    //     payload.append('image', formData.value.image);
    // } else {
    //     console.warn("No image selected or invalid file");
    // }

    payload.append('status', formData.value.status || 'Active'); // เพิ่มบรรทัดนี้หลัง loop

    console.log("Form Data", formData.value);

    console.log("Log value payload:", payload);

    try {

        // const response = await axios.post('http://localhost/register.php', formData.value)
        const response = await axios.post(`${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/register_DedtStatust.php`, payload, {
            // const response = await axios.post(`${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/register.php`, payload, {
            headers: {
                'Content-Type': 'multipart/form-data',
            },
        });

        const resData = typeof response.data === 'string' ? JSON.parse(response.data) : response.data;

        if (response.data?.success) {
            Swal.fire({
                title: 'สมัครสมาชิกสำเร็จ',
                text: resData.message || 'อนุมัติการเป็นสมาชิก',
                icon: 'success',
            });
            // alert(resData.message);

            console.log("Log value response:", response);

            router.push('/showdataemp');

        } else {
            Swal.fire({
                title: 'สมัครสมาชิกไม่สำเร็จ',
                text: resData.message || 'ไม่อนุมัติการเป็นสมาชิก',
                icon: 'error',
            });
            // alert(resData.message);

            console.error("สมัครสมาชิกไม่สำเร็จ: ", resData.message);
        }


        // alert(response.data.message)

    } catch (err) {
        console.error("Full error:", err); // ✅ เพิ่ม log
        const message = err.response?.data?.message || err.message || 'Unknown error';
        alert('Error: ' + message);
        Swal.fire({
            title: 'สมัครสมาชิกไม่สำเร็จ',
            text: message || 'โปรดลองใหม่ภายหลัง',
            icon: 'error',
        });
    }
}

const generateEmpId = () => {
    // สุ่มเลข 6 หลัก เช่น 000123
    return Math.floor(100000 + Math.random() * 900000).toString();
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