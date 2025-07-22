<template>
  <div class="p-4">
    <h1 class="text-2xl font-bold mb-4">รายการคำสั่งซื้อ</h1>

    <!-- ด้านบนของตาราง -->
    <div class="mb-4">
      <input v-model="searchQuery" type="text" placeholder="🔍 ค้นหา หมายเลขสั่งซื้อ / รหัสลูกค้า / ชื่อร้าน"
        class="w-full border border-gray-300 rounded-md px-4 py-2 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-500" />
    </div>

    <div class="overflow-auto rounded-lg shadow-md">
      <table class="min-w-full text-sm text-left text-gray-700  ">
        <thead class="bg-gray-100 text-xs uppercase border">
          <tr>
            <th class="p-3 border">Id</th>
            <th class="p-3 border">หมายเลขสั่งซื้อ</th>
            <th class="p-3 border">รหัสลูกค้า</th>
            <th class="p-3 border">ชื่อร้าน</th>
            <th class="p-3 border">เบอร์โทรศัพท์</th>
            <th class="p-3 border text-right">จำนวนเงิน</th>
            <th class="p-3 border text-right">ยอดชำระ</th>
            <th class="p-3 border">เวลาสร้าง</th>
            <th class="p-3 border">สถานะประเภทหนี้</th>
            <th class="p-3 border">สถานะตรวจสอบ</th>
            <th class="p-3 border">การทำงาน</th>
          </tr>
        </thead>

        <tbody v-if="isLoading">
          <tr>
            <td colspan="11" class="py-10 text-center">
              <svg class="animate-spin h-8 w-8 text-blue-600 mx-auto" xmlns="http://www.w3.org/2000/svg" fill="none"
                viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8H4z"></path>
              </svg>
              <div class="mt-2 text-gray-500">กำลังโหลดข้อมูล...</div>
            </td>
          </tr>
        </tbody>

        <tbody v-if="!isLoading">
          <template v-for="order in filteredOrders" :key="order.id">
          <tr class="border-b hover:bg-gray-50">
          <!-- <tr v-for="order in filteredOrders" :key="order.id" class="border-b hover:bg-gray-50"> -->
            <!-- <tr v-for="order in saleOrders" :key="order.id" class="border-b hover:bg-gray-50"> -->
            <td class="p-3">{{ order.id }}</td>
            <td class="p-3">{{ order.sale_no }}</td>
            <td class="p-3">{{ order.customer_code }}</td>
            <td class="p-3">{{ order.shop_name }}</td>
            <td class="p-3">{{ order.mobile }}</td>
            <td class="p-3 text-right">{{ formatCurrency(order.total_amount) }}</td>
            <td class="p-3 text-right">{{ formatCurrency(order.total_paid) }}</td>
            <td class="p-3">{{ order.created_at }}</td>
            <td class="p-3 text-white" :class="{
              'bg-green-500': order.status === 'ตรวจสอบเรียบร้อย',
              'bg-yellow-500': order.status === 'รอตรวจสอบ',
              'bg-red-500': order.status === 'การตรวจสอบล้มเหลว',
              'bg-gray-800': order.status === 'ยังไม่ได้ตรวจสอบ',
              'bg-black': order.status === 'ยกเลิกคำสั่งซื้อ',
              // 'bg-green-500': order.status === 'เกินกำหนดชำระไม่เกิน 30 วัน', // ไม่เกิน 7 วัน 
              // 'bg-yellow-500': order.status === 'เกินกำหนดชำระกิน 30 วัน',
              // 'bg-red-500': order.status === 'เกินกำหนดชำระ 120 วัน', 
              // 'bg-gray-800': order.status === 'เกินกำหนดชำระ 180 วัน',
              // 'bg-black': order.status === 'ยกเลิกคำสั่งซื้อ'
            }">
              <span class="flex items-center space-x-1">
                <span class="w-2 h-2 rounded-full bg-white"></span>
                <span>{{ getDisplayStatus(order.status) }}</span>
              </span>
            </td>

            <td class="p-3">
              <!-- :class="order.status === 'ยังไม่ได้ตรวจสอบ' ? 'bg-gray-500' : 'bg-green-500'" -->
              <span class="flex items-center space-x-1">
                <span class="w-2 h-2 rounded-full" :class="{
                  'bg-gray-500': order.status === 'ยังไม่ได้ตรวจสอบ',
                  'bg-green-500': order.status === 'ตรวจสอบเรียบร้อย',
                  'bg-red-500': order.status === 'การตรวจสอบล้มเหลว'
                }"></span>
                <span>{{ order.status }}</span>
              </span>
            </td>
            <td class="p-3">
              <router-link :to="{ name: 'saleorderdetail', params: { id: order.sale_no } }">
                <button class="px-4 py-1 bg-blue-500 text-white rounded hover:bg-blue-600 text-sm">
                  ตรวจสอบ
                </button>
              </router-link>
            </td>
          </tr>

          <!-- ✅ แถวรายละเอียดเพิ่มเติม (ถ้ามีข้อมูลพ่วง) -->
          <tr v-if="order.extra_details" class="bg-blue-50">
            <td colspan="11" class="p-4 text-sm text-gray-700 border">
              <!-- คุณสามารถปรับให้แสดงเป็นตาราง หรือข้อความ หรือ card ได้ -->
              <div>
                <strong>ข้อมูลเพิ่มเติม:</strong>
                <ul class="list-disc ml-6 mt-2">
                  <li v-for="(item, index) in order.extra_details" :key="index">{{ item }}</li>
                </ul>
              </div>
            </td>
          </tr>
          </template>
        </tbody>
      </table>
    </div>

    <!-- pagination -->
    <div class="flex justify-between items-center mt-4">
      <span>Showing {{ filteredOrders.length }} of {{ totalRows }} rows</span>
      <div class="space-x-2">
        <button :disabled="currentPage === 1" @click="goToPage(currentPage - 1)"
          class="px-4 py-1 bg-gray-200 rounded">Prev</button>
        <span>หน้า {{ currentPage }} / {{ totalPages }}</span>
        <button :disabled="currentPage === totalPages" @click="goToPage(currentPage + 1)"
          class="px-4 py-1 bg-gray-200 rounded">Next</button>
      </div>
    </div>

    <!-- pagination -->
    <!-- <div class="flex justify-between items-center mt-4"> -->
    <!-- <span>Showing {{ saleOrders.length }} of {{ totalRows }} rows</span> -->
    <!-- <span>Showing {{ filteredOrders.length }} of {{ totalRows }} rows</span> -->
    <!-- Pagination UI -->
    <!-- คุณสามารถเพิ่ม Tailwind pagination component ที่นี่ -->
    <!-- </div> -->
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import axios from 'axios'

// const BASE_URL = import.meta.env.VITE_API_URL
const BASE_URL = import.meta.env.VITE_API_URL_LOCAL

const saleOrders = ref([])

const totalRows = ref(0)
const currentPage = ref(1)
const limit = 10

const searchQuery = ref('') // <- ช่องค้นหา
const isLoading = ref(false); // หรือ true ถ้าต้องการให้เริ่มต้นแสดง


const formatCurrency = (value) =>
  Number(value).toLocaleString(undefined, {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
  })



const getDisplayStatus = (status) => {
  switch (status) {
    case 'ตรวจสอบเรียบร้อย': return 'เกินกำหนดชำระไม่เกิน 30 วัน'; // เขียว
    case 'รอตรวจสอบ': return 'เกินกำหนดชำระกิน 30 วัน'; // เหลือง
    case 'การตรวจสอบล้มเหลว': return 'เกินกำหนดชำระ 120 วัน'; // แดง
    case 'ยังไม่ได้ตรวจสอบ': return 'เกินกำหนดชำระ 180 วัน'; // ดำ
    case 'ยกเลิกคำสั่งซื้อ': return 'ถูกยกเลิก';
    default: return status;
  }
}


const filteredOrders = computed(() => {

  const raw = searchQuery.value.trim()
  if (!raw) return saleOrders.value

  const keyword = raw.toLowerCase()
  const parts = keyword.split(/\s+/) // แยกด้วยช่องว่าง

  return saleOrders.value.filter(order => {
    const saleNo = order.sale_no?.toLowerCase().trim() || ''
    const customerCode = order.customer_code?.toLowerCase().trim() || ''
    const shopName = order.shop_name?.toLowerCase().trim() || ''
    const mobile = order.mobile?.toLowerCase().trim() || ''
    const createdAt = order.created_at?.toLowerCase().trim() || ''

    // เงื่อนไข: ตรวจทีละ keyword
    return parts.every(part => {
      const isoDate = convertThaiDateToISO(part)
      return (
        saleNo.includes(part) ||
        customerCode.includes(part) ||
        shopName.includes(part) ||
        mobile.includes(part) ||
        (isoDate && createdAt.includes(isoDate)) ||
        createdAt.includes(part) // เผื่อ user พิมพ์ yyyy-mm-dd โดยตรง
      )
    })
  })
})

function convertThaiDateToISO(dateStr) {
  const parts = dateStr.trim().split(/[-/]/)
  if (parts.length !== 3) return null

  let [day, month, year] = parts.map(p => parseInt(p, 10))

  // ตรวจสอบว่าเป็นตัวเลขทั้งหมด
  if (isNaN(day) || isNaN(month) || isNaN(year)) return null

  if (year > 2400) year -= 543

  const dateObj = new Date(year, month - 1, day)

  // ตรวจสอบว่าเป็น valid date
  if (isNaN(dateObj.getTime())) return null

  return dateObj.toISOString().split('T')[0] // yyyy-mm-dd
}


// ดึงข้อมูลหน้าปัจจุบัน
async function fetchPage(page = 1) {
  isLoading.value = true
  try {
    const res = await axios.get(
      `${BASE_URL}/api_admin_dashboard/backend/api/list_sale_orders/get_list_sale_order.php`,
      { params: { page, limit } }
    )

    console.log('Check Log res :', res);

    if (res.data.success) {

      // console.log('Check Log res.data :',res.data);
      saleOrders.value = res.data.data.list_order.map(item => ({
        id: item.id,
        sale_no: item.document_no,
        customer_code: item.customer_code,
        shop_name: item.full_name,
        mobile: item.phone,
        total_amount: item.final_total_price,
        total_paid: item.final_total_price,
        status: item.status,
        created_at: item.created_at,
        // ตัวอย่าง mock data
        extra_details: item.extra_list || [
          `รหัสสินค้า: ${item.id}-A`,
          `ยอดคงเหลือ: 100.00`,
          `หมายเหตุ: ตรวจสอบแล้ว`
        ]
      }))

      console.log('Check Log saleOrders.value :', saleOrders.value);

      totalRows.value = res.data.data.total
      currentPage.value = page
    }
  } catch (e) {
    console.error(e)
  } finally {
    isLoading.value = false
  }
}

onMounted(() => fetchPage(1))



const totalPages = computed(() =>
  Math.ceil(totalRows.value / limit)
)

function goToPage(page) {
  if (page < 1 || page > totalPages.value) return
  fetchPage(page)
}


</script>

<!-- 
// filter ตามคำค้นหา
// const filteredOrders = computed(() => {
//   if (!searchQuery.value.trim()) return saleOrders.value

//   const keyword = searchQuery.value.toLowerCase()
//   return saleOrders.value.filter(order =>
//     order.sale_no?.toLowerCase().includes(keyword) ||
//     order.customer_code?.toLowerCase().includes(keyword) ||
//     order.shop_name?.toLowerCase().includes(keyword) || 
//     order.mobile?.toLowerCase().includes(keyword)
//   )
// }) -->



<!-- // const filteredOrders = computed(() => {
//   if (!searchQuery.value.trim()) return saleOrders.value
//   const kw = searchQuery.value.toLowerCase()
//   return saleOrders.value.filter(o =>
//     [o.sale_no, o.customer_code, o.shop_name, o.mobile, o.created_at]
//       .some(str => str.toLowerCase().includes(kw))
//   )
// }) -->




<!-- 
// onMounted(async () => {
//   try {

//     isLoading.value = true;

//     const response = await axios.get(`${BASE_URL}/api_admin_dashboard/backend/api/list_sale_orders/get_list_sale_order.php`)
//     console.log('Check log responseData:', response.data.data.list_order);

//     saleOrders.value = (response.data.data.list_order || []).map(item => ({
//       id: item.id,
//       sale_no: item.document_no,
//       customer_code: item.customer_code,
//       shop_name: item.full_name,
//       mobile: item.phone,
//       total_amount: item.final_total_price,
//       total_paid: item.final_total_price,
//       status: item.status,
//       created_at: item.created_at
//     }));

//     // saleOrders.value = response.data.data.list_order || []
//     totalRows.value = response.data.total || response.data.data.list_order.length

//     isLoading.value = false;
//   } catch (error) {
//     console.error('❌ Failed to load sale orders:', error)
//   }
// }); -->
