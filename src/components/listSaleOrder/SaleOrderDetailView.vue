<template>
    <div class="p-6">
      <h2 class="text-xl font-semibold mb-4">รายละเอียดคำสั่งซื้อ ID: {{ orderId }}</h2>
  
      <div v-if="orderDetail" class="space-y-2 bg-white p-4 rounded shadow">
        <p><strong>ชื่อร้าน:</strong> {{ orderDetail.shop_name }}</p>
        <p><strong>รหัสลูกค้า:</strong> {{ orderDetail.customer_code }}</p>
        <p><strong>เบอร์โทร:</strong> {{ orderDetail.mobile }}</p>
        <p><strong>ยอดสั่งซื้อ:</strong> {{ formatCurrency(orderDetail.total_amount) }}</p>
        <p><strong>สถานะ:</strong> {{ orderDetail.status }}</p>
        <p><strong>วันที่สร้าง:</strong> {{ orderDetail.created_at }}</p>
  
        <!-- รายการสินค้า -->
        <div class="mt-4">
          <h3 class="font-semibold mb-2">สินค้าในคำสั่งซื้อ</h3>
          <ul class="list-disc list-inside">
            <li v-for="item in orderDetail.items" :key="item.id">
              {{ item.pro_name }} - {{ item.qty }} ชิ้น
            </li>
          </ul>
        </div>
      </div>
  
      <div v-else class="text-gray-500">กำลังโหลดข้อมูล...</div>
    </div>
  </template>
  
  <script setup>
  import { ref, onMounted } from 'vue'
  import { useRoute } from 'vue-router'
  import axios from 'axios'
  
  const route = useRoute()
  const orderId = route.params.id
  const BASE_URL = import.meta.env.VITE_API_URL
  
  const orderDetail = ref(null)
  
  const formatCurrency = (value) =>
    Number(value).toLocaleString(undefined, {
      minimumFractionDigits: 2,
      maximumFractionDigits: 2,
    })
  
  onMounted(async () => {
    try {
      const res = await axios.get(`${BASE_URL}/api_admin_dashboard/backend/api/get_sale_order_detail.php?id=${orderId}`)
      orderDetail.value = res.data
    } catch (err) {
      console.error('❌ Load detail failed:', err)
    }
  })
  </script>
  