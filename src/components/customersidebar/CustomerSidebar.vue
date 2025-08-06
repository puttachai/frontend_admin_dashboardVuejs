<!-- components/CustomerSidebar.vue -->
<!-- <template>
  <transition name="slide">
    <div
      v-if="show"
      class="fixed top-0 left-0 h-full w-80 bg-white shadow-lg z-50 p-4 border-r transition-transform"
    >
      <div class="flex justify-between items-center mb-4">
        <h2 class="text-lg font-bold text-purple-700">เลือกลูกค้า</h2>
        <button @click="close" class="text-gray-500 hover:text-red-500 text-xl">×</button>
      </div>

      <input
        type="text"
        v-model="search"
        @input="fetchCustomers"
        placeholder="ค้นหา..."
        class="w-full border px-3 py-2 rounded-md shadow-sm mb-3"
      />

      <ul v-if="customers.length" class="space-y-2 overflow-y-auto max-h-[400px]">
        <li
          v-for="cust in customers"
          :key="cust.customer_no"
          @click="selectCustomer(cust)"
          class="p-2 border rounded-md hover:bg-purple-100 cursor-pointer"
        >
          {{ cust.nickname }}
        </li>
      </ul>
    </div>
  </transition>
</template> -->

<template>
  <div v-show="show" class="h-full w-full p-4 overflow-y-auto">
    <div class="flex justify-between items-center mb-4">
      <h2 class="text-lg font-bold text-purple-700">เลือกลูกค้า</h2>
      <button @click="close" class="text-gray-500 hover:text-red-500 text-xl">×</button>
    </div>

    <input
      type="text"
      v-model="search"
      @input="onSearchInput"
      placeholder="ค้นหา..."
      class="w-full border px-3 py-2 rounded-md shadow-sm mb-3"
    />

    <div v-if="loading" class="text-sm text-gray-500 mb-2">กำลังค้นหา...</div>
    <div v-else-if="!customers.length" class="text-sm text-gray-400 mb-2">ไม่พบผลลัพธ์</div>

    <ul v-if="customers.length" class="space-y-2 overflow-y-auto max-h-full">
    <!-- <ul v-if="customers.length" class="space-y-2 overflow-y-auto max-h-[400px]"> -->
      <li
        v-for="cust in customers"
        :key="cust.customer_no"
        @click="selectCustomer(cust)"
        class="p-2 border rounded-md hover:bg-purple-100 cursor-pointer"
      >
        {{ cust.nickname }}
      </li>
    </ul>
  </div>
</template>

<script setup>
import { ref, watch, computed } from 'vue';
import axios from 'axios';
import { debounce } from 'lodash-es'; // ถ้า lodash-es ไม่พร้อมใช้ ให้เขียน debounce เล็กๆ เอง

const props = defineProps({
  show: { type: Boolean, required: true },
});
const emit = defineEmits(['close', 'selected']);

const search = ref('');
const customers = ref([]);
const loading = ref(false);

// ฟังก์ชัน fetch แบบแยก
const doFetch = async (keyword) => {
  try {
    loading.value = true;
    const payload = {
      account: 'crm020',
      password: 'crm020',
      customer: '',
      version: '2.0.2',
      pageCurrent: 1,
      keyword: keyword,
      pageSize: 15,
    };

    const res = await axios.post(
      'https://tgsc.qifudaren.net/addons/shopro/user/accountLogin4',
      payload,
      {
        headers: { 'Content-Type': 'application/json' },
      }
    );

    customers.value = res.data?.data?.data2 || [];
  } catch (err) {
    console.error('error loading customers:', err);
    customers.value = [];
  } finally {
    loading.value = false;
  }
};

// debounce เพื่อไม่ให้เรียกทุกตัวอักษรทันที
const onSearchInput = debounce(() => {
  doFetch(search.value.trim());
}, 300);

// เมื่อเปิด sidebar ให้โหลดครั้งแรก (ถ้า search ว่าง)
watch(
  () => props.show,
  (open) => {
    if (open) {
      // clear เก่า ๆ ถ้าต้องการ หรือโหลด default
      if (!search.value) doFetch('');
    }
  }
);

const close = () => emit('close');
const selectCustomer = (cust) => {
  emit('selected', cust);
  close();
};
</script>

<style scoped>
/* ไม่มี transition overlay แล้ว เลยไม่ต้องมี css เกี่ยวกับ slide */
</style>