<template>
  <div class="fixed inset-0 bg-black bg-opacity-40 flex items-center justify-center z-[99]">
    <div class="bg-white z-20 rounded-xl shadow-2xl p-6 w-[90%] max-w-5xl max-h-[90vh] overflow-y-auto transition-all duration-300">

      <!-- Header -->
      <div class="flex justify-between items-center mb-6 border-b pb-3">
        <h2 class="text-2xl font-bold text-gray-700 tracking-wide">✨ เลือกค่าบริการอื่นๆ</h2>
        <button @click="$emit('close')" class="text-red-500 hover:text-gray-700 text-4xl transition-transform duration-200 transform hover:rotate-90">&times;</button>
      </div>

      <!-- Search -->
      <div class="flex items-center space-x-3 mb-4">
        <span class="material-icons text-gray-600 text-2xl">search</span>
        <input
          v-model="keyword"
          @input="filterServices"
          class="w-full p-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-400 focus:shadow-lg transition-all duration-300 placeholder-gray-400"
          placeholder="ค้นหาชื่อบริการ หรือ รหัสบริการ..."
        />
      </div>

      <!-- Table -->
      <div class="overflow-x-auto">
        <table class="min-w-full border text-sm rounded-lg table-auto">
          <thead class="bg-gradient-to-r from-blue-100 to-blue-50 text-blue-700 font-bold uppercase tracking-wide">
            <tr>
              <th class="px-5 py-3 border text-center">
                <input type="checkbox" @change="toggleSelectAll" :checked="isAllSelected" class="accent-blue-500 w-5 h-5" />
              </th>
              <th class="px-5 py-3 border">รหัสบริการ</th>
              <th class="px-5 py-3 border">ชื่อค่าบริการ</th>
              <th class="px-5 py-3 border">จำนวน</th>
              <th class="px-5 py-3 border">ราคา</th>
            </tr>
          </thead>
          <tbody>
            <tr
              v-for="item in filteredServices"
              :key="item.id"
              class="transition-all duration-200 hover:bg-blue-50 hover:shadow-md cursor-pointer"
              :class="{'shadow-inner': item.price > 0, 'bg-gray-50': selectedIds.includes(item.id)}"
            >
            <!-- bg-green-50 | ^ -->
              <td class="px-4 py-2 border text-center">
                <input type="checkbox" v-model="selectedIds" :value="item.id" class="accent-green-500 w-5 h-5" />
              </td>
              <td class="px-4 py-2 border font-medium text-gray-700">{{ item.service_code }}</td>
              <td class="px-4 py-2 border text-gray-600">{{ item.service_name }}</td>
              <td class="px-4 py-2 border text-center font-semibold">{{ item.qty }}</td>
              <td class="px-4 py-2 border text-center">
                <input
                  type="text"
                  v-model="displayValues[item.id]"
                  class="w-28 border rounded-xl px-3 py-1 text-right font-medium focus:ring-2 focus:ring-green-400 focus:shadow-md transition-all duration-300"
                  :class="{' text-green-800': item.price > 0, 'bg-yellow-50': selectedIds.includes(item.id)}"
                  @input="onPriceInput($event, item)"
                  @blur="onPriceBlur(item)"
                />
              </td>
            </tr>
            <tr v-if="filteredServices.length === 0">
              <td colspan="5" class="text-center py-4 text-gray-500 italic">ไม่พบข้อมูล</td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- Confirm -->
      <div class="text-right mt-6">
        <button
          class="bg-gradient-to-r from-blue-500 to-blue-600 hover:from-blue-600 hover:to-blue-700 text-white px-6 py-3 rounded-xl shadow-xl hover:shadow-2xl transition-all duration-300 transform hover:scale-105"
          @click="confirmSelection">
         ตกลง
        </button>
      </div>
    </div>
  </div>
</template>



<script setup>

import axios from "axios"
import { ref, computed, onMounted, reactive } from "vue" //, watch
import Swal from "sweetalert2"

const BASE_URL_LOCAL = import.meta.env.VITE_API_URL_LOCAL;

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

// เก็บค่าที่แสดงผลแยกจากค่าจริง
const displayValues = reactive({})

// เก็บค่า default price จาก API
const defaultPrices = reactive({})

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

     // map ค่า price จาก DB ไปใส่ displayValues
    // services.value.forEach(s => {
    //   displayValues[s.id] = s.price ? formatPrice(s.price) : ""
    // })

    // ตอน fetchServicesFromApi map ค่า price จาก DB ไปใส่ displayValues
    services.value.forEach(s => {
      // แปลง price เป็น number และเก็บ default
      const priceNum = s.price !== null && s.price !== undefined ? Number(s.price) : 0
      s.price = priceNum
      displayValues[s.id] = formatPrice(priceNum)
      defaultPrices[s.id] = priceNum
    })

  } catch (err) {
    console.error("Error fetching services:", err)
  }
}


const filterServices = () => {
  const key = keyword.value.trim().toLowerCase()
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
    props.selectedServices.some(old => old.service_code === s.service_code)
  )

  // console.log(duplicates);

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

// const onPriceInput = (id) => {
//   if (!selectedIds.value.includes(id)) {
//     selectedIds.value.push(id)
//   }
// }


// ฟอร์แมตราคา
function formatPrice(value) {
  if (value === null || value === undefined || isNaN(value)) return ""
  return Number(value).toLocaleString(undefined, {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2
  })
}

// input event → ให้ลบได้อิสระ
function onPriceInput(event, service) {
  const raw = event.target.value.replace(/,/g, "") // เอาคอมม่าออก
  const num = parseFloat(raw).toFixed(2);

  if (isNaN(num)) {
    service.price = null // เก็บเป็น null
    displayValues[service.id] = "" // แสดงว่าง
  } else {
    service.price = num // เก็บค่าจริง
    displayValues[service.id] = raw // แสดงตามที่พิมพ์
  }

   // ✅ Auto check ถ้ากรอกเลข
  if (service.price > 0 && !selectedIds.value.includes(service.id)) {
    selectedIds.value.push(service.id)
  }
}

// blur event → ฟอร์แมต
function onPriceBlur(service) {
    const val = parseFloat(displayValues[service.id].replace(/,/g, ""))

    if (isNaN(val)) {
      // ถ้าไม่ใช่ number → reset เป็น default
      service.price = defaultPrices[service.id]
      displayValues[service.id] = formatPrice(defaultPrices[service.id])
    } else {
      // ถ้าใช่ number → format และเก็บเป็น number
      service.price = Number(val.toFixed(2))
      displayValues[service.id] = formatPrice(service.price)
    }

  // if (service.price != null) {
  //   displayValues[service.id] = formatPrice(service.price)
  // }
}


// นำ selectedServices ที่ส่งมาจาก parent มากำหนด selectedIds
onMounted(() => {
  // ถ้าอยากใช้ API จริงก็ uncomment
  fetchServicesFromApi();
  selectedIds.value = props.selectedServices.map(s => s.id)

})

</script>
