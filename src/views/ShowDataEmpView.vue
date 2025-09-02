<template>
    <div class="p-6 min-w-full">
        <h1 class="text-2xl font-bold mb-4">รายชื่อพนักงาน</h1>

        <router-link class="button" to="/registerdedtStatust">
            <button class="mb-4 px-4 py-2 bg-purple-700 text-white rounded hover:bg-purple-800">
                เพิ่มพนักงาน
            </button>
        </router-link>


        <div class="overflow-x-auto">
            <table class="min-w-full text-sm text-gray-700 border border-gray-200 bg-white">
                <thead class="bg-gray-100 text-gray-600">
                    <tr>
                        <th class="px-2 py-1 border whitespace-nowrap">รูป</th>
                        <th class="px-2 py-1 border whitespace-nowrap">ชื่อพนักงาน</th>
                        <th class="px-2 py-1 border whitespace-nowrap">อีเมล</th>
                        <th class="px-2 py-1 border whitespace-nowrap">โทรศัพท์</th>
                        <th class="px-2 py-1 border whitespace-nowrap">ที่อยู่</th>
                        <th class="px-2 py-1 border whitespace-nowrap">ตำแหน่ง</th>
                        <th class="px-2 py-1 border whitespace-nowrap">รหัสลูกค้า</th>
                        <th class="px-2 py-1 border whitespace-nowrap">เงินเดือน</th>
                        <th class="px-2 py-1 border whitespace-nowrap">สถานะ</th>
                        <th class="px-2 py-1 border whitespace-nowrap">เริ่มงาน</th>
                        <th class="px-2 py-1 border whitespace-nowrap">การจัดการ</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="employee in employees" :key="employee.id" class="text-center hover:bg-gray-50">
                        <td class="px-2 py-1 border">
                            <template v-if="employee.image_path">
                                <img :src="employee.image_path" alt="profile" class="w-8 h-8 rounded-full mx-auto" />
                            </template>
                            <template v-else>
                                <span class="material-icons text-gray-400 text-3xl">account_circle</span>
                            </template>
                        </td>
                        <td class="px-2 py-1 border whitespace-nowrap">{{ employee.full_name }}</td>
                        <td class="px-2 py-1 border whitespace-nowrap">{{ employee.email }}</td>
                        <td class="px-2 py-1 border whitespace-nowrap">{{ employee.telephone }}</td>
                        <td class="px-2 py-1 border">{{ employee.address }}</td>
                        <td class="px-2 py-1 border whitespace-nowrap">{{ employee.department }}</td>
                        <td class="px-2 py-1 border whitespace-nowrap">{{ employee.customer_no || 'ไม่มีข้อมูล' }}</td>
                        <td class="px-2 py-1 border whitespace-nowrap">{{ employee.salary }}</td>
                        <td class="px-2 py-1 border whitespace-nowrap">{{ employee.status }}</td>
                        <td class="px-2 py-1 border whitespace-nowrap">{{ employee.start_work }}</td>
                        <td class="px-2 py-1 border">
                            <div class="flex flex-col space-y-1 items-center">
                                <button @click="openEditPopup(employee)"
                                    class="bg-yellow-400 hover:bg-yellow-500 px-2 py-1 rounded text-white text-xs w-20">
                                    แก้ไข
                                </button>
                                <button @click="confirmDeleteEmployee(employee)"
                                    class="bg-red-500 hover:bg-red-600 px-2 py-1 rounded text-white text-xs w-20">
                                    ลบ
                                </button>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <EditPopup v-if="showPopup" :employee="selectedEmployee" :visible="showPopup" @close="closeEditPopup"
            @updated="updateEmployeeInList" />
    </div>
</template>

<script setup>
// ยังไม่ใส่ logic ดึงข้อมูล เพราะจะใช้ PHP เป็นตัวกลาง

import { ref, onMounted } from 'vue';
import axios from 'axios';
import Swal from 'sweetalert2';
import EditPopup from '@/components/EditPopup.vue';

const employees = ref([]);
const showPopup = ref(false);
const selectedEmployee = ref(null);

const BASE_URL_LOCAL = import.meta.env.VITE_API_URL_LOCAL;
// const BASE_URL_LOCAL = import.meta.env.VITE_API_URL;

onMounted(async () => {

    try {

        console.log("Log BASE_URL_LOCAL: ", BASE_URL_LOCAL);

        const respone = await axios.get(`${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/get_dataEmployee.php`,)
        employees.value = respone.data;
        console.log("Log respone: ", respone);
        console.log("Success Fully");

    } catch (error) {
        console.error('Error fetching employees:', error)
    }

});

const openEditPopup = (employee) => {
    selectedEmployee.value = { ...employee };
    showPopup.value = true;
};

const closeEditPopup = () => {
    showPopup.value = false;
};

// const updateEmployeeInList = (updatedData) => {
// const index = employees.value.findIndex(emp => emp.id === selectedEmployee.value.id);
//     if (index !== -1) {
//         employees.value[index] = { ...employees.value[index], ...updatedData };
//     }
// };
const updateEmployeeInList = async () => {
    const res = await axios.get(`${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/get_dataEmployee.php`);
    // employees.value = res.data.employees;
    employees.value = res.data;
    showPopup.value = false;
};


const confirmDeleteEmployee = async (employee) => {
    const result = await Swal.fire({
        title: 'ยืนยันการลบข้อมูล',
        text: 'คุณต้องการลบข้อมูลนี้จริงหรือไม่?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'ใช่, ลบเลย',
        cancelButtonText: 'ยกเลิก',
    });

    if (result.isConfirmed) {

        try {

            const response = await axios.post(`${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/Delete_Employee.php`, { id: employee.id });
            console.log("Log value response:", response);

            const resData = typeof response.data === 'string' ? JSON.parse(response.data) : response.data;

            if (resData.success) {
                // แสดงแจ้งเตือนลบสำเร็จ
                Swal.fire('ลบสำเร็จ!', resData.message, 'success');

                // อัพเดต employees list โดยลบ employee ที่ถูกลบออก
                employees.value = employees.value.filter(e => e.id !== employee.id);
            } else {
                Swal.fire('ลบไม่สำเร็จ', resData.message || 'เกิดข้อผิดพลาด', 'error');
            }

        } catch (error) {
            console.error('Error Delete employees:', error);
            Swal.fire('เกิดข้อผิดพลาด', 'ไม่สามารถลบข้อมูลได้', 'error');
        }

    } else {
        // กดยกเลิก ไม่ทำอะไร
        console.log('ยกเลิกการลบข้อมูล');
    }
}

</script>
