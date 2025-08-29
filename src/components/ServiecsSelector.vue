<template>
  <div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-[99]">
    <div class="bg-white z-20 rounded-lg shadow-lg p-4 w-[90%] max-w-4xl max-h-[90vh] overflow-y-auto">

      <!-- Header -->
      <div class="flex justify-between items-center mb-4">
        <h2 class="text-xl font-bold text-gray-700">เลือกค่าบริการอื่นๆ</h2>
        <button @click="$emit('close')" class="text-red-500 hover:text-gray-700 text-3xl">&times;</button>
      </div>

      <!-- Search -->
      <div class="flex items-center space-x-3 mb-3">
        <span class="material-icons text-gray-600">search</span>
        <input
          v-model="keyword"
          @input="filterServices"
          class="w-full p-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
          placeholder="ค้นหาชื่อบริการ หรือ รหัสบริการ..."
        />
      </div>

      <!-- Table -->
      <div class="overflow-x-auto">
        <table class="min-w-full border text-sm">
          <thead class="bg-gray-100 text-gray-700">
            <tr>
              <th class="px-4 py-2 border text-center">
                <input type="checkbox" @change="toggleSelectAll" :checked="isAllSelected" />
              </th>
              <th class="px-4 py-2 border">รหัสบริการ</th>
              <th class="px-4 py-2 border">ชื่อค่าบริการ</th>
              <th class="px-4 py-2 border">จำนวน</th>
              <th class="px-4 py-2 border">ราคา</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="item in filteredServices" :key="item.id">
              <td class="px-4 py-2 border text-center">
                <input type="checkbox" v-model="selectedIds" :value="item.id" />
              </td>
              <td class="px-4 py-2 border">{{ item.service_code }}</td>
              <!-- <td class="px-4 py-2 border">{{ item.code }}</td> -->
              <td class="px-4 py-2 border">{{ item.service_name }}</td>
              <td class="px-4 py-2 border text-center">{{ item.qty }}</td>
              <td class="px-4 py-2 border text-center">
                <input
                  type="number"
                  v-model.number="item.price"
                  class="w-24 border rounded px-2 py-1 text-right"
                />
              </td>
            </tr>
            <tr v-if="filteredServices.length === 0">
              <td colspan="5" class="text-center py-4 text-gray-500">ไม่พบข้อมูล</td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- Confirm -->
      <div class="text-right mt-4">
        <button
          class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded"
          @click="confirmSelection">
          ตกลง
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>

import axios from "axios"
import { ref, computed, onMounted } from "vue" //, watch
import Swal from "sweetalert2"

const BASE_URL_LOCAL = import.meta.env.VITE_API_URL_LOCAL;

// defineProps({
//   show: Boolean,
//   // selectedServices: { type: Array, default: () => [] } // รับค่าเก่าจาก parent
//   selectedServices: Array
// })

// ประกาศ props ที่รับมาจาก Parent
const props = defineProps({
  productList: {
    type: Array,
    default: () => []
  },
  selectedServices: {
    type: Array,
    default: () => []
  }
})

const emit = defineEmits(["close", "select-services"])

const keyword = ref("")
const selectedIds = ref([])

const services = ref([])

// mock data
// const services = ref([
//   { id: 1, code: "S001", name: "ค่าบริการติดตั้ง", qty: 1, price: 500 },
//   { id: 2, code: "S002", name: "ค่าบริการขนส่ง", qty: 1, price: 300 },
//   { id: 3, code: "S003", name: "ค่าบริการซ่อมบำรุง", qty: 1, price: 800 },
//   { id: 4, code: "S004", name: "ค่าทำความสะอาด", qty: 1, price: 200 },
// ])

const filteredServices = ref([...services.value])

// computed
// ตรวจสอบ select all
const isAllSelected = computed(() =>
  filteredServices.value.length > 0 &&
  filteredServices.value.every(s => selectedIds.value.includes(s.id))
)

// methods
const fetchServicesFromApi = async () => {
  try {
    const res = await axios.get(`${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/sale_order/get_sale_order_service.php`) // ตัวอย่าง API
    console.log('Check res:', res.data);
    // services.value = res.data
    services.value = res.data.data;
    filteredServices.value = services.value
  } catch (err) {
    console.error("Error fetching services:", err)
  }
}

// const filterServices = () => {
//   const key = keyword.value.toLowerCase()
//   filteredServices.value = services.value.filter(
//     s => s.name.toLowerCase().includes(key) || s.code.toLowerCase().includes(key)
//   )
// }

const filterServices = () => {
  const key = keyword.value.toLowerCase()
  filteredServices.value = services.value.filter(
    s => s.service_name.toLowerCase().includes(key) || s.service_code.toLowerCase().includes(key)
  )
}

const toggleSelectAll = (event) => {
  if (event.target.checked) {
    selectedIds.value = filteredServices.value.map(s => s.id)
  } else {
    selectedIds.value = []
  }
}

// confirm
const confirmSelection = () => {
  // ดึง service ใหม่ที่เลือก
  let newSelected = services.value.filter(s => selectedIds.value.includes(s.id))

  // ตรวจสอบซ้ำกับ selectedServices เก่า
  const duplicates = newSelected.filter(s =>
    props.selectedServices.some(old => old.id === s.id)
  )

  if (duplicates.length > 0) {
    const names = duplicates.map(d => d.name).join(", ")
    Swal.fire({
      icon: "warning",
      title: "แจ้งเตือน",
      text: `คุณได้เลือกบริการ ${names} ไปแล้ว`,
    })
    return // ไม่ส่งข้อมูลกลับ parent
  }

  // merge service เก่าที่ไม่ได้เลือกใหม่
  props.selectedServices.forEach(oldService => {
    const idx = newSelected.findIndex(s => s.id === oldService.id)
    if (idx === -1) {
      newSelected.push({ ...oldService })
    }
  })

  // แปลงเป็น plain object
  const plainSelected = newSelected.map(s => JSON.parse(JSON.stringify(s)))

  emit("select-services", plainSelected)
  emit("close")
}



// นำ selectedServices ที่ส่งมาจาก parent มากำหนด selectedIds
onMounted(() => {
  // ถ้าอยากใช้ API จริงก็ uncomment
  fetchServicesFromApi();
  // console.log('Check filteredServices: ');
  // filteredServices.value = services.value
  // console.log('Check filteredServices: ', filteredServices.value);
  selectedIds.value = props.selectedServices.map(s => s.id)

})

// // ตรวจสอบการเลือกซ้ำ
// watch(selectedIds, (newVal, oldVal) => {
//   if (oldVal.length < newVal.length) {
//     // เลือกเพิ่ม
//     const addedId = newVal.find(id => !oldVal.includes(id))
//     const duplicate = props.selectedServices.find(s => s.id === addedId)
//     if (duplicate) {
//       // แจ้งเตือนถ้าเลือกซ้ำ
//       Swal.fire({
//         icon: "warning",
//         title: "แจ้งเตือน",
//         text: `คุณได้เลือกบริการ ${duplicate.name} ไปแล้ว`,
//       })
//       // เอา id ออกจาก selectedIds เพื่อไม่ให้ซ้ำ
//       selectedIds.value = oldVal
//     }
//   }
// })

</script>
