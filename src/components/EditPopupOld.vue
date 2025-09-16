<!-- components/EditPopup.vue -->
<template>
  <div v-if="visible" class="fixed inset-0 z-50 bg-black bg-opacity-50 flex justify-center items-center">
    <div class="bg-white p-6 rounded shadow-md w-full max-w-xl">
      <h2 class="text-xl font-bold mb-4">แก้ไขข้อมูลพนักงาน</h2>
      <form @submit.prevent="confirmSubmitEdit">
        <div class="grid grid-cols-2 gap-4">

          <div>
            <label>แก้ไขรูปภาพ</label>
            <input type="file" @change="handleImageChange" accept="image/*" class="w-full border p-2 rounded" />
            <div v-if="previewImage" class="mt-2">
              <img :src="previewImage" alt="Preview" class="h-24 object-cover rounded border" />
            </div>
          </div>

          <div>
            <label>ชื่อพนักงาน</label>
            <input v-model="form.full_name" class="w-full border p-2 rounded"  />
          </div>
          <div>
            <label>อีเมล</label>
            <input v-model="form.email" class="w-full border p-2 rounded"  />
          </div>
          <div>
            <label>โทรศัพท์</label>
            <input v-model="form.telephone" class="w-full border p-2 rounded"  />
          </div>
          <div>
            <label>ที่อยู่</label>
            <input v-model="form.address" class="w-full border p-2 rounded"  />
          </div>
          <div>
            <label>ตำแหน่ง</label>
            <input v-model="form.department" class="w-full border p-2 rounded"  />
          </div>
          <!-- <div>
            <label>เงินเดือน</label>
            <input v-model="form.salary" type="number" class="w-full border p-2 rounded"  />
          </div> -->

          <div>
            <label>สถานะ</label>
            <select v-model="form.status" class="w-full border p-2 rounded">
              <option>Normal</option>
              <option>Active</option>
              <option>Inactive</option>
              <option>Abnormal</option>
            </select>
          </div>

          <!-- <div>
            <label>เริ่มงาน</label>
            <input v-model="form.start_work" type="date" class="w-full border p-2 rounded" required />
          </div> -->
        </div>

        <div class="flex justify-end mt-6 space-x-4">
          <button @click="closePopup" type="button" class="px-4 py-2 bg-gray-500 text-white rounded">ยกเลิก</button>
          <button type="submit" class="px-4 py-2 bg-blue-600 text-white rounded">บันทึก</button>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup>
import { reactive, watch } from 'vue';
// eslint-disable-next-line no-unused-vars
import { toRaw } from 'vue';
import { ref } from 'vue';

import axios from 'axios';
import Swal from 'sweetalert2';

const BASE_URL = import.meta.env.VITE_API_URL_LOCAL;

const props = defineProps({
  employee: Object,
  visible: Boolean
});
const emit = defineEmits(['close', 'updated']);

const form = reactive({ ...props.employee });
console.log("log form: ", form);

watch(() => props.employee, (newVal) => {
  Object.assign(form, newVal);
});

const closePopup = () => {
  emit('close');
};

// เพิ่ม ref สำหรับเก็บรูปใหม่และ preview
const selectedImage = ref(null);
const previewImage = ref(null);

// ฟังก์ชันจัดการรูป
const handleImageChange = (e) => {
  const file = e.target.files[0];
  if (file) {
    selectedImage.value = file;
    previewImage.value = URL.createObjectURL(file);
  }
};


const confirmSubmitEdit = async () => {
  const result = await Swal.fire({
    title: 'ยืนยันการแก้ไขข้อมูล',
    text: 'คุณต้องการแก้ไขข้อมูลจริงหรือไม่?',
    icon: 'question',
    showCancelButton: true,
    confirmButtonText: 'ใช่, แก้ไขเลย',
    cancelButtonText: 'ยกเลิก',
  });

  if (result.isConfirmed) {

    try {

      Swal.fire({
        title: 'แก้ไขสำเร็จ',
        icon: 'success',
        timer: 2000,              // หน่วงเวลา 2 วินาที
        showConfirmButton: false, // ไม่แสดงปุ่ม OK
      });

      // const payload = toRaw(form);
      // console.log("log payload: ",payload);

      const formData = new FormData();

      // ใส่ข้อมูลใน form
      for (const key in form) {
        if (form[key] !== null && form[key] !== undefined) {
          formData.append(key, form[key]);
        }
      }

      // ใส่ไฟล์รูปถ้ามีการเลือก
      if (selectedImage.value) {
        formData.append('image', selectedImage.value);
      }

      const response = await axios.post(`${BASE_URL}/api_admin_dashboard/backend/api/Update_Employee.php`, formData,
        { headers: { 'Content-Type': 'multipart/form-data' } });
      emit('updated', response.data); // อัพเดตข้อมูลใหม่ไปยัง parent

      console.log("Log response: ", response.data);
      closePopup();

    } catch (error) {
      console.error('Error updating employee:', error);
      Swal.fire('เกิดข้อผิดพลาด', 'ไม่สามารถแก้ไขรายการได้', 'error');
    }

  } else {
    // กดยกเลิก ไม่ทำอะไร
    console.log('ยกเลิกการแก้ไข');
  }
}

</script>
