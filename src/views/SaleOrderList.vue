<template>
    <div class="p-4">
      <h1 class="text-2xl font-bold mb-4">รายการคำสั่งซื้อ</h1>
  
      <div class="overflow-auto rounded-lg shadow-md">
        <table class="min-w-full text-sm text-left text-gray-700 border ">
          <thead class="bg-gray-100 text-xs uppercase">
            <tr>
              <th class="p-3">Id</th>
              <th class="p-3">หมายเลขสั่งซื้อ</th>
              <th class="p-3">รหัสลูกค้า</th>
              <th class="p-3">ชื่อร้าน</th>
              <th class="p-3">Mobile</th>
              <th class="p-3 text-right">จำนวนเงิน</th>
              <th class="p-3 text-right">ยอดชำระ</th>
              <th class="p-3">เวลาสร้าง</th>
              <th class="p-3">สถานะ</th>
              <th class="p-3">การทำงาน</th>
            </tr>
          </thead>
          <tbody>
            <tr
              v-for="order in saleOrders"
              :key="order.id"
              class="border-b hover:bg-gray-50"
            >
              <td class="p-3">{{ order.id }}</td>
              <td class="p-3">{{ order.sale_no }}</td>
              <td class="p-3">{{ order.customer_code }}</td>
              <td class="p-3">{{ order.shop_name }}</td>
              <td class="p-3">{{ order.mobile }}</td>
              <td class="p-3 text-right">{{ formatCurrency(order.total_amount) }}</td>
              <td class="p-3 text-right">{{ formatCurrency(order.total_paid) }}</td>
              <td class="p-3">{{ order.created_at }}</td>
              <td class="p-3">
                <span class="flex items-center space-x-1">
                  <span
                    class="w-2 h-2 rounded-full"
                    :class="order.status === 'ยังไม่ได้ตรวจสอบ' ? 'bg-gray-500' : 'bg-green-500'"
                  ></span>
                  <span>{{ order.status }}</span>
                </span>
              </td>
              <td class="p-3">
                <router-link
                  :to="{ name: 'saleOrderDetail', params: { id: order.id } }"
                >
                  <button class="px-4 py-1 bg-blue-500 text-white rounded hover:bg-blue-600 text-sm">
                    ตรวจสอบ
                  </button>
                </router-link>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
  
      <!-- pagination -->
      <div class="flex justify-between items-center mt-4">
        <span>Showing {{ saleOrders.length }} of {{ totalRows }} rows</span>
        <!-- Pagination UI -->
        <!-- คุณสามารถเพิ่ม Tailwind pagination component ที่นี่ -->
      </div>
    </div>
  </template>
  
  <script setup>
  import { ref, onMounted } from 'vue'
  import axios from 'axios'
  
  const BASE_URL = import.meta.env.VITE_API_URL
  const saleOrders = ref([])
  const totalRows = ref(0)
  
  const formatCurrency = (value) =>
    Number(value).toLocaleString(undefined, {
      minimumFractionDigits: 2,
      maximumFractionDigits: 2,
    })
  
  onMounted(async () => {
    try {
      const response = await axios.get(`${BASE_URL}/api_admin_dashboard/backend/api/get_sale_orders.php`)
      saleOrders.value = response.data.orders || []
      totalRows.value = response.data.total || response.data.orders.length
    } catch (error) {
      console.error('❌ Failed to load sale orders:', error)
    }
  })
  </script>
  