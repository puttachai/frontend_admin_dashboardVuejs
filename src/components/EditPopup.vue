<!-- components/EditPopup.vue -->
<template>
  <div
    v-if="visible"
    class="fixed inset-0 z-[120] px-4 px-4 bg-black bg-opacity-50 flex justify-center items-center"
  >
    <div class="bg-white rounded shadow-md w-full max-w-5xl flex">
      <!-- Sidebar ร้านค้า -->
      <div
        class="transition-all duration-300 bg-white shadow-lg overflow-hidden"
        :class="showCustomerSidebar ? 'w-[300px]' : 'w-0'"
      >
        <div v-show="showCustomerSidebar" class="h-full w-full">
          <CustomerSidebar
            :show="showCustomerSidebar"
            @close="showCustomerSidebar = false"
            @selected="handleCustomerSelected"
          />
        </div>
      </div>

      <!-- Main Form -->
      <div class="flex-1 p-6">
        <!-- ปุ่มเปิด sidebar -->
        <button
          @click="toggleCustomerSidebar"
          class="mb-4 bg-purple-500 text-white px-4 py-2 rounded-md hover:bg-purple-700 transition flex items-center gap-2"
        >
          <component
            :is="showCustomerSidebar ? ArrowLeftIcon : ArrowRightIcon"
            class="w-5 h-5"
          />
          {{ showCustomerSidebar ? 'ปิดการเลือกร้านค้า' : 'เลือกร้านค้าของลูกค้า' }}
        </button>

        <h2 class="text-xl font-bold mb-4">แก้ไขข้อมูลพนักงาน</h2>

        <!-- แสดงร้านค้าที่เลือก -->
        <!-- <div v-if="selectedCustomer" class="py-2 text-sm text-purple-700">
          เลือกร้านค้า: {{ selectedCustomer.nickname }}
        </div> -->

        <div v-if="selectedCustomers.length" class="py-2 text-sm text-purple-700">
          เลือกร้านค้าแล้ว:
          <span v-for="cust in selectedCustomers" :key="cust.customer_no" class="mr-2">
            {{ cust.nickname }}
            <button @click="removeCustomer(cust.customer_no)" class="text-red-500">x</button>
          </span>
        </div>

        <!-- <div v-if="selectedCustomers.length" class="py-2 text-sm text-purple-700">
          เลือกร้านค้า:
          <span v-for="cust in selectedCustomers" :key="cust.customer_no" class="mr-2">
            {{ cust.nickname }}
            <button @click="removeCustomer(cust.customer_no)" class="text-red-500">x</button>
          </span>
        </div> -->

        <form @submit.prevent="confirmSubmitEdit" class="grid grid-cols-2 gap-4">
          <div>
            <label>แก้ไขรูปภาพ</label>
            <input
              type="file"
              @change="handleImageChange"
              accept="image/*"
              class="w-full border p-2 rounded"
            />
            <div v-if="previewImage" class="mt-2">
              <img
                :src="previewImage"
                alt="Preview"
                class="h-24 object-cover rounded border"
              />
            </div>
          </div>

          <div>
            <label>ชื่อพนักงาน</label>
            <input v-model="form.full_name" class="w-full border p-2 rounded" />
          </div>
          <div>
            <label>อีเมล</label>
            <input v-model="form.email" class="w-full border p-2 rounded" />
          </div>
          <div>
            <label>โทรศัพท์</label>
            <input v-model="form.telephone" class="w-full border p-2 rounded" />
          </div>
          <div>
            <label>ที่อยู่</label>
            <input v-model="form.address" class="w-full border p-2 rounded" />
          </div>
          <div>
            <label>ตำแหน่ง</label>
            <input v-model="form.department" class="w-full border p-2 rounded" />
          </div>
          <div>
            <label>สถานะ</label>
            <select v-model="form.status" class="w-full border p-2 rounded">
              <option>Normal</option>
              <option>Active</option>
              <option>Inactive</option>
              <option>Abnormal</option>
            </select>
          </div>
        </form>

        <div class="flex justify-end mt-6 space-x-4">
          <button
            @click="closePopup"
            type="button"
            class="px-4 py-2 bg-gray-500 text-white rounded"
          >
            ยกเลิก
          </button>
          <button
            @click="confirmSubmitEdit"
            type="submit"
            class="px-4 py-2 bg-blue-600 text-white rounded"
          >
            บันทึก
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { reactive, watch, ref } from 'vue';
import axios from 'axios';
import Swal from 'sweetalert2';
import { ArrowRightIcon, ArrowLeftIcon } from '@heroicons/vue/24/solid';
import CustomerSidebar from '@/components/customersidebar/CustomerSidebar.vue';

const BASE_URL = import.meta.env.VITE_API_URL_LOCAL;

// const selectedCustomers = ref([]); // <-- เปลี่ยนจาก selectedCustomer ตัวเดียว


const props = defineProps({
  employee: Object,
  visible: Boolean,
});


// แทนที่ selectedCustomers เดิม
const selectedCustomers = ref([...props.employee.customers || []]);

const emit = defineEmits(['close', 'updated']);

const form = reactive({ ...props.employee });
watch(
  () => props.employee,
  (newVal) => {
    // Object.assign(form, newVal);
    Object.assign(form, newVal);
    // อัปเดต selectedCustomers ทุกครั้งที่ employee เปลี่ยน
    selectedCustomers.value = [...newVal.customers || []];
  }
);

const closePopup = () => {
  emit('close');
};

// รูปภาพ
const selectedImage = ref(null);
const previewImage = ref(null);
const handleImageChange = (e) => {
  const file = e.target.files[0];
  if (file) {
    selectedImage.value = file;
    previewImage.value = URL.createObjectURL(file);
  }
};

// Sidebar
const showCustomerSidebar = ref(false);
const selectedCustomer = ref(null);

const toggleCustomerSidebar = () => {
  showCustomerSidebar.value = !showCustomerSidebar.value;
};

const handleCustomerSelected = (cust) => {
  // ถ้าเลือกหลายตัว
  console.log('Selected Customer:', cust);
  const exists = selectedCustomers.value.find(c => c.customer_no === cust.customer_no);

  if (!exists) selectedCustomers.value.push(cust); // เพิ่มเฉพาะตัวที่ยังไม่อยู่
};
// const handleCustomerSelected = (cust) => {
//   selectedCustomer.value = cust;
//   console.log('Selected Customer:', cust);
//   form.customer_no = cust.customer_no; // เก็บค่าลูกค้าใน form
// };

const removeCustomer = (customer_no) => {
  selectedCustomers.value = selectedCustomers.value.filter(c => c.customer_no !== customer_no);
};

// Submit
const confirmSubmitEdit = async () => {
  const result = await Swal.fire({
    title: 'ยืนยันการแก้ไขข้อมูล',
    text: 'คุณต้องการแก้ไขข้อมูลจริงหรือไม่?',
    icon: 'question',
    showCancelButton: true,
    confirmButtonText: 'ใช่, แก้ไขเลย',
    cancelButtonText: 'ยกเลิก',
  });

  if (!result.isConfirmed) return;

  try {
    Swal.fire({
      title: 'แก้ไขสำเร็จ',
      icon: 'success',
      timer: 2000,
      showConfirmButton: false,
    });

    const formData = new FormData();

    // field ที่ backend รองรับจริง
    const employeeFields = [
      'id','emp_ids','full_name','email','telephone','address','department',
      'salary','status','start_work'
    ];
    const customerFields = [ //'password',
      'adminid','account','nickname_admin','customer_id','nickname',
      'contact','mobile','customer_no','sale_no','groups','label','value','level'
    ];


    // 1) append employee fields
    employeeFields.forEach(f => {
      if (form[f] !== undefined && form[f] !== null) {
        formData.append(f, form[f]);
      }
      console.log('Log form[employeeFields]: ',form[f]);
    });

    // 2) append customer fields (rename ถ้าต้องการ)
      if (selectedCustomer.value) {
      customerFields.forEach(f => {
        if (selectedCustomer.value[f] !== undefined && selectedCustomer.value[f] !== null) {
          formData.append(f, selectedCustomer.value[f]);
          console.log('Log form[f selectedCustomer]: ', selectedCustomer.value[f]);
        }
      });

      // ส่ง customer_name ด้วย
      if (selectedCustomer.value.nickname) {
        formData.append("customer_name", selectedCustomer.value.nickname);
      }
    }



    // ส่งเป็น JSON array ของลูกค้า
    if (selectedCustomers.value.length) {
      formData.append('customers', JSON.stringify(selectedCustomers.value));
    }

    //  console.log('CHECK Log form selectedCustomer append: ', selectedCustomer.value);

    // if (selectedCustomer.value) {
    //   for (const key in selectedCustomer.value) {
    //     formData.append(key, selectedCustomer.value[key]);
    //   }
    // }

    // for (const key in form) {
    //   if (form[key] !== null && form[key] !== undefined) {
    //     formData.append(key, form[key]);
    //   }
    // }
    if (selectedImage.value) {
      formData.append('image', selectedImage.value);
    }

    const response = await axios.post(
      `${BASE_URL}/api_admin_dashboard/backend/api/Update_Employee.php`,
      formData,
      { headers: { 'Content-Type': 'multipart/form-data' } }
    );

    console.log('Log response: ', response.data);
    emit('updated', response.data);
    closePopup();
  } catch (error) {
    console.error('Error updating employee:', error);
    Swal.fire('เกิดข้อผิดพลาด', 'ไม่สามารถแก้ไขรายการได้', 'error');
  }
};
</script>
