<template>
    <div class="p-6 min-w-full">
        <h1 class="text-2xl font-bold mb-4">รายชื่อพนักงานเร่งรัดหนี้สิน</h1>

         <div class="text-sm text-gray-500 mb-2">
                จำนวนพนักงานทั้งหมด: {{ employees.length }} คน
         </div>

        <div class="flex items-center justify-center mb-4 space-x-4">
          <!-- ปุ่มเพิ่มพนักงาน -->
          <router-link class="button" to="/registerdedtStatust">
            <button class="px-4 py-2 bg-purple-700 text-white rounded hover:bg-purple-800">
              เพิ่มพนักงานเร่งรัดหนี้สิน
            </button>
          </router-link>

          <!-- ช่องค้นหา -->
          <div class="flex-1 pb-1.5">
            <input
              v-model="searchQuery"
              type="text"
              placeholder="🔍 ค้นหา ชื่อ / อีเมล / เบอร์โทร / แผนก"
              class="w-full border border-gray-300 rounded-md px-4 py-2 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-500"
            />
          </div>
        </div>



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
                        <th class="px-2 py-1 border whitespace-nowrap">ชื่อลูกค้า</th>
                        <th class="px-2 py-1 border whitespace-nowrap">เบอร์โทรลูกค้า</th>
                        <!-- <th class="px-2 py-1 border whitespace-nowrap">เงินเดือน</th> -->
                        <th class="px-2 py-1 border whitespace-nowrap">สถานะ</th>
                        <!-- <th class="px-2 py-1 border whitespace-nowrap">เริ่มงาน</th> -->
                        <th class="px-2 py-1 border whitespace-nowrap">การจัดการ</th>
                    </tr>
                </thead>
                <tbody>
                  <!-- employees -->
                    <tr v-for="employee in filteredEmployees" :key="employee.id" class="text-center hover:bg-gray-50">
                        <td class="px-2 py-1 border">
                            <template v-if="employee.image_path">
                                <img :src="employee.image_path" alt="profile" class="w-8 h-8 rounded-full  max-w-[100px]" />
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
                        <!-- <td class="px-2 py-1 border whitespace-nowrap">{{ employee.customer_no || 'ไม่มีข้อมูล' }}</td> -->

                        <td class="px-2 py-1 border whitespace-nowrap min-w-[120px]">
                          <select class="border border-gray-300 rounded px-2 py-1 w-full">
                            <option
                              v-for="(customer, index) in employee.customers"
                              :key="index"
                              :value="customer.customer_no"
                            >
                              {{ customer.customer_no || 'ไม่มีข้อมูล' }}
                            </option>
                          </select>
                        </td>


                        <!-- <td class="px-2 py-1 border whitespace-nowrap ">{{ employee.nickname || 'ไม่มีข้อมูล' }}</td> -->
                        <td class="px-2 py-1 border whitespace-nowrap ">
                            <div v-if="employee.customers && employee.customers.length" class="flex flex-col space-y-1">
                              <div
                                v-for="(customer, index) in employee.customers"
                                :key="index"
                                class="relative group cursor-pointer"
                              >
                                <span class="hover:text-purple-600">
                                  {{ customer.nickname && customer.nickname.length > 20
                                      ? customer.nickname.substring(0, 20) + '...'
                                      : (customer.nickname || ',ไม่มีข้อมูล') }}
                                </span>

                                <!-- tooltip -->
                                <div
                                  v-if="customer.nickname"
                                  class="absolute z-10 hidden group-hover:block bg-gray-800 text-white text-xs rounded px-2 py-1 -top-8 left-0 max-w-xs whitespace-normal"
                                >
                                  {{ customer.nickname }}
                                </div>
                              </div>
                            </div>
                            <div v-else>ไม่มีข้อมูล</div>
                          </td>


                        <!-- <td class="px-2 py-1 border whitespace-nowrap">
                          <select class="border border-gray-300 rounded px-2 py-1 w-full">
                            <option
                              v-for="(customer, index) in employee.customers"
                              :key="index"
                              :value="customer.nickname"
                            >
                              {{ customer.nickname || 'ไม่มีข้อมูล' }}
                            </option>
                          </select>
                        </td> -->


                        <td class="px-2 py-1 border whitespace-nowrap  min-w-[120px]">
                          <select class="border border-gray-300 rounded px-2 py-1 w-full">
                            <option
                              v-for="(customer, index) in employee.customers"
                              :key="index"
                              :value="customer.customer_mobile"
                            >
                              {{ customer.customer_mobile || 'ไม่มีข้อมูล' }}
                            </option>
                          </select>
                        </td>


                        <!-- <td class="px-2 py-1 border whitespace-nowrap">{{ employee.mobile || employee.customer_mobile || 'ไม่มีข้อมูล' }}</td> -->
                        <!-- <td class="px-2 py-1 border whitespace-nowrap">{{ employee.salary }}</td> -->
                        <td class="px-2 py-1 border whitespace-nowrap">{{ employee.status }}</td>
                        <!-- <td class="px-2 py-1 border whitespace-nowrap">{{ employee.start_work }}</td> -->
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

                    <!-- ถ้าไม่มีข้อมูล -->
                    <tr v-if="filteredEmployees.length === 0">
                      <td colspan="11" class="text-center py-6 text-gray-500">
                        ไม่มีข้อมูล
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

import { ref, onMounted, computed  } from 'vue';
import axios from 'axios';
import Swal from 'sweetalert2';
import EditPopup from '@/components/EditPopup.vue';

const employees = ref([]);
const showPopup = ref(false);
const selectedEmployee = ref(null);

const searchQuery = ref(""); // ตัวแปรช่องค้นหา

const expandedEmployee = ref(null);

const BASE_URL_LOCAL = import.meta.env.VITE_API_URL_LOCAL;
// const BASE_URL_LOCAL = import.meta.env.VITE_API_URL;

onMounted(async () => {

    try {

        console.log("Log BASE_URL_LOCAL: ", BASE_URL_LOCAL);

        const respone = await axios.get(`${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/get_dataEmployee.php`,)

        let data = respone.data;

        // ดักข้อมูล customer ว่าง
        data = data.map(emp => {
            if (emp.customers && emp.customers.length) {
                emp.customers = emp.customers.map(cust => ({
                    customer_no: cust.customer_no || 'ไม่มีข้อมูล',
                    nickname: cust.nickname || 'ไม่มีข้อมูล',
                    customer_mobile: cust.customer_mobile || 'ไม่มีข้อมูล',
                    contact: cust.contact || 'ไม่มีข้อมูล',
                    // เพิ่ม field อื่น ๆ ตามต้องการ
                }));
            } else {
                // ถ้าไม่มี customer เลย ให้สร้าง array พร้อมค่า default
                emp.customers = [{
                    customer_no: 'ไม่มีข้อมูล',
                    nickname: 'ไม่มีข้อมูล',
                    customer_mobile: 'ไม่มีข้อมูล',
                    contact: 'ไม่มีข้อมูล',
                }];
            }
            return emp;
        });

        employees.value = data;

        // employees.value = respone.data;
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


// eslint-disable-next-line no-unused-vars
const toggleExpand = (employee) => {
  expandedEmployee.value =
    expandedEmployee.value === employee.id ? null : employee.id;
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


// ✅ Filter employees ตาม searchQuery
const filteredEmployees = computed(() => {
  const raw = searchQuery.value.trim().toLowerCase();
  if (!raw) return employees.value;

  return employees.value.filter((emp) => {
    const fullName = emp.full_name?.toLowerCase().trim() || "";
    const email = emp.email?.toLowerCase().trim() || "";
    const telephone = emp.telephone?.toLowerCase().trim() || "";
    const department = emp.department?.toLowerCase().trim() || "";
    const address = emp.address?.toLowerCase().trim() || "";
    const customerNo = emp.customer_no?.toLowerCase().trim() || "";
    const nickname = emp.nickname?.toLowerCase() || "";
    const customerMobile = emp.customer_mobile?.toLowerCase() || "";

    return (
      fullName.includes(raw) ||
      email.includes(raw) ||
      telephone.includes(raw) ||
      department.includes(raw) ||
      address.includes(raw) ||
      customerNo.includes(raw) ||
      nickname.includes(raw) ||
      customerMobile.includes(raw)
    );
  });
});


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
<!--

<td class="px-2 py-1 border whitespace-nowrap">
  <span
    @click="toggleExpand(employee)"
    class="cursor-pointer hover:text-purple-600"
  >
    {{ employee.nickname && employee.nickname.length > 20
        ? employee.nickname.substring(0, 20) + '...'
        : (employee.nickname || 'ไม่มีข้อมูล') }}
  </span>


  <div v-if="expandedEmployee === employee.id" class="mt-2">
    <textarea
      readonly
      class="w-64 border rounded p-2 text-xs"
      :value="employee.nickname"
    ></textarea>
    <button
      class="mt-1 text-blue-600 text-xs"
      @click="expandedEmployee = null"
    >
      ปิด
    </button>
  </div>
</td>

const toggleExpand = (employee) => {
  expandedEmployee.value =
    expandedEmployee.value === employee.id ? null : employee.id;
};

-->
