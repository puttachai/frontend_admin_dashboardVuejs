<template>
  <div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-[99]">
    <div class="bg-white z-20 rounded-lg shadow-lg p-4 w-[90%] max-w-6xl max-h-[90vh] overflow-y-auto">

      <!-- Search Section -->
      <div class="flex items-center space-x-4 ">
        <!-- Search Icon -->
        <span class="material-icons text-gray-600" style="font-size: 28px;">search</span>
        <!-- Search Input -->
        <input class="w-full p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
          v-model="keyword" placeholder="ค้นหา..." @input="onInput" confirm-type="search" />
        <div class="">
          <button @click="$emit('close')" class="text-red-500 hover:text-gray-700 mb-16 text-4xl">&times;</button>
        </div>
      </div>

      <div class="text-sm text-gray-500 mt-2">
        * สามารถ ค้นหาได้ ชื่อโปรโมชั่น, รหัสโปรโมชั่น
      </div>

      <!-- Header -->
      <div class="flex items-center mb-4">

        <div class="flex-1 ">
          <h2 class="text-xl text-gray-700 font-bold">เลือกรายการโปรโมชั่น</h2>
        </div>

        <div class="flex gap-4">
          <div class="text-sm font-semibold text-gray-500 mt-2">
            ประเภทสมาชิก: {{ memberType }}
          </div>
          <!-- แสดงว่าเป็น level อะไร -->
          <!-- <div class="">
            <button @click="$emit('close')" class="text-red-500 hover:text-gray-700 text-2xl">&times;</button>
          </div> -->
        </div>

      </div>

      <!-- <Promotion_ProductSelector v-if="showPromotionProductSelector" :selectedPromotion="selectedPromotion"
        @close="showPromotionProductSelector = false" @select-promotion="handleSelectedProducts" /> -->
      <Promotion_ProductSelector v-if="showPromotionProductSelector" :selectedPromotion="selectedPromotion"
        @close="showPromotionProductSelector = false" @select-promotion_products="handleSelectedProducts" />

      <!-- Table Section -->
      <div class="overflow-x-auto mt-4">
        <!-- Table -->
        <table class="min-w-[1000px] w-full border text-sm">
          <!-- <table class="min-w-full border text-sm"> -->
          <thead class="bg-gray-100 text-gray-700">
            <tr>

              <th class="px-4 py-2 border text-center">
                <input type="checkbox" @change="toggleSelectAll" :checked="isAllSelected" />
              </th>

              <th class="px-4 py-2 border">รูปภาพ</th>
              <th class="px-4 py-2 border">ชื่อโปรโมชั่น</th>
              <!-- <th class="px-4 py-2 border">สี</th> -->
              <th class="px-4 py-2 text-left text-sm font-medium text-gray-600 relative">
                <!-- Input ช่องค้นหา -->
                <div class="flex gap-1">
                  <input type="text" v-model="keyword_promotion_no" placeholder="ค้นหา โปรโมชั่น"
                    @focus="dropdownOpenIndex = 'header'" style="margin-top: 0 !important;"
                    class="w-full px-3 py-1 border border-gray-300 rounded-md focus:outline-none" />
                  <!-- ปุ่มค้นหา -->
                  <button @click="searchPromotion_no"
                    class="px-3 py-1 bg-blue-500 text-white rounded hover:bg-blue-600">
                    ค้นหา
                  </button>
                </div>
              </th>

              <th class="px-4 py-2 border w-[120px]">รหัสโปรโมชั่น</th>
              <th class="px-4 py-2 border w-[120px]">สมาชิก</th>
              <!-- <th class="px-4 py-2 border">รายละเอียด</th> -->
              <th v-if="false" class="px-4 py-2 border">promotion_Day||Months</th>
              <!-- <th class="px-4 py-2 border">หน่วย</th>
            <th class="px-4 py-2 border">ราคาขาย</th> -->
            </tr>
          </thead>

          <!-- ถ้ากำลังโหลด -->
          <tbody v-if="isLoading">
            <tr>
              <td colspan="10" class="py-10 text-center">
                <svg class="animate-spin h-8 w-8 text-blue-600 mx-auto" xmlns="http://www.w3.org/2000/svg" fill="none"
                  viewBox="0 0 24 24">
                  <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                  <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8H4z"></path>
                </svg>
                <div class="mt-2 text-gray-500">กำลังโหลดข้อมูล...</div>
              </td>
            </tr>
          </tbody>

          <tbody v-if="noCustomerSelected.length === 0 && !isLoading">
          <!-- <tbody v-if="paginatedPromotion.length === 0 && !isLoading"> -->
            <tr>
              <td colspan="10" class="py-10 text-center">
                <svg class="animate-spin h-8 w-8 text-blue-600 mx-auto" xmlns="http://www.w3.org/2000/svg" fill="none"
                  viewBox="0 0 24 24">
                  <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                  <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8H4z"></path>
                </svg>
                <div class="mt-2 text-gray-500">โปรดทำการเลือก ร้านค้าของลูกค้าก่อนทำรายการ</div>
              </td>
            </tr>
          </tbody>

          <tbody v-else-if="paginatedPromotion.length === 0 && !isLoading">
            <tr>
              <td colspan="10" class="py-10 text-center text-gray-500">
                ไม่พบข้อมูล
              </td>
            </tr>
          </tbody>

          <tbody v-if="!isLoading">
            <tr v-for="item in paginatedPromotion" :key="item.id">
              <td class="px-4 py-2 border text-center">
                <input type="checkbox" v-model="selectedIds" :value="item.id" />
              </td>

              <td class="px-4 py-4 border text-center">
                <template v-if="item.image && !item.isImage404">
                  <img
                    :src="BASE_URL_IMAGE + item.image"
                    alt="products"
                    class="w-10 h-10 rounded-full mx-auto"
                   @error="onImageError"
                  >
                </template>
                <template v-else>
                  <span class="material-icons text-gray-400 text-4xl">broken_image</span>
                </template>
              </td>

              <!-- <td class="px-4 py-4 border text-center">
                <template v-if="item.image">
                  <img :src="BASE_URL_IMAGE + item.image" alt="products" class="w-10 h-10 rounded-full mx-auto">
                </template>
                <template v-else>
                  <span class="material-icons text-gray-400 text-4xl">broken_image</span>
                </template>
              </td> -->

              <td class="px-4 text-gray-700 py-2 border">{{ item.title }}</td>

              <td class="px-4 text-gray-700 py-2 border">{{ item.activity_code ?? 'ไม่มีโปรโมชั่น' }}</td>

              <td class="px-4 text-gray-700 py-2 border">{{ item.activity_code }}</td>
              <td class="px-4 text-gray-700 py-2 border">{{ item.level }}</td>
              <!-- <td class="px-4 py-2 border">{{ item.titledetail }}</td> -->
              <td v-if="false" class="px-4 text-gray-700 py-2 border">{{ item.promotion_index }}</td>
              <!-- <td class="px-4 py-2 border">{{ item.units }}</td> -->
              <!-- <td class="px-4 py-2 border">{{ item.price }}</td> -->

              <!-- <td class="px-4 py-2 border">{{ item.pro_name }}</td>
            <td class="px-4 py-2 border">{{ item.pro_quantity }}</td>
            <td class="px-4 py-2 border">{{ item.pro_status }}</td>
            <td class="px-4 py-2 border">{{ item.pro_unit_price }}</td> -->
            </tr>
          </tbody>
        </table>
        <!-- Pagination -->
        <ConfigProvider :globalConfig="enConfig">
          <div class="w-fit mt-4 px-4 ">
            <!-- <div class="overflow-auto mt-4 "> -->
            <!-- v-model:page-size="pageSize" -->
            <pagination v-model:current="pageCurrent" v-model:page-size="pageSize" :total="total" show-page-size
              :prev-button-props="{ content: '⏪' }" :next-button-props="{ content: '⏩' }"
              @change="onPaginationChange" />
          </div>
        </ConfigProvider>
      </div>




      <!-- Confirm Button -->
      <div class="text-right mt-4">
        <button class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded" @click="confirmSelection">
          เลือกโปรโมชั่น
        </button>
      </div>
    </div>
  </div>



</template>

<script setup>
import { ref, computed, watch, onMounted } from 'vue'
// import { Pagination } from 'tdesign-vue-next'

import { Pagination, ConfigProvider } from 'tdesign-vue-next'
import enConfig from 'tdesign-vue-next/es/locale/en_US'
import Swal from 'sweetalert2';
import axios from 'axios';

import Promotion_ProductSelector from './Promotion_ProductSelector.vue' // ✅ import ให้ถูก path

import { useRouter } from 'vue-router'

const router = useRouter()

const BASE_URL_IMAGE = import.meta.env.VITE_API_URL_IMAGE;
const BASE_URL = import.meta.env.VITE_API_URL;

const isLoading = ref(false) // สำหรับ loading spinner
const noCustomerSelected = ref(false);
// const props = defineProps({
//   promotionList: Array,
//   pageCurrent: Number,
//   pageSize: Number,
//   total: Number
// })

const emit = defineEmits(['close', 'select-promotion', 'page-change'])

// const getLevelSS = JSON.parse(localStorage.getItem('selectDataCustomer'));

// const getLevel = getLevelSS?.data2?.level ?? 0;

const showPromotionProductSelector = ref(false)
const selectedPromotion = ref([])

// reactive state
const keyword = ref('')
const searchTimer = ref(null)

const tableData = ref([])

const total = ref(0)
const pageCurrent = ref(1)
const pageSize = ref(10)

const selectedIds = ref([])
// eslint-disable-next-line no-unused-vars
const dataselect = ref([])
// const error = ref('')

// const keyword_sku_no = ref('');
// const dataselectsku_no = ref([]);

const keyword_promotion_no = ref('');
const dataselectpromotion_no = ref([]);

const Apipromotion = ref([]);

const memberType = ref('');
//paginatedProduct
// const paginatedPromotion = computed(() => {
//   return tableData.value;
// });

const paginatedPromotion = computed(() => {
  const start = (pageCurrent.value - 1) * pageSize.value;
  const end = start + pageSize.value;
  return tableData.value.slice(start, end);
});


function onPaginationChange(pageInfo) {
  pageCurrent.value = pageInfo.current;

  // 🔒 บังคับให้ pageSize = 10 เสมอ
  if (pageInfo.pageSize > 10) {
    pageSize.value = 10;
  } else if (pageInfo.pageSize === 5) {
    pageSize.value = 5;
  } else {
    pageSize.value = pageInfo.pageSize;
  }

  // SearchPromotionSubmit(); // โหลดสินค้าหน้าใหม่
  emit('page-change', pageInfo.current);  // ส่ง event ให้ parent โหลดหน้าข้อมูลใหม่
}


// Checkbox logic เลือกสินค้าทั้งหมด
const isAllSelected = computed(() =>
  paginatedPromotion.value.every(item => selectedIds.value.includes(item.id))
)

// เช็คว่าตอนนี้สินค้าได้ถูกเลือกเป็นรายการอะไรบ้าง
watch(selectedIds, (newVal) => {
  const selectedProducts = tableData.value.filter(p =>
    newVal.includes(p.id)
  );
  console.log("โปรโมชั่นที่เลือกอยู่ตอนนี้:", selectedProducts);
});

// watch(pageSize, (newVal) => {
//   if (newVal !== 10) {
//     pageSize.value = 10;
//   }
// });

// function เลือกสินค้าทั้งหมด
function toggleSelectAll(event) {
  if (event.target.checked) {
    const pageIds = paginatedPromotion.value.map(item => item.id)
    selectedIds.value = [...new Set([...selectedIds.value, ...pageIds])]

    console.log('toggleSelectAll selectedIds:', pageIds);
  } else {
    const pageIds = paginatedPromotion.value.map(item => item.id)
    selectedIds.value = selectedIds.value.filter(id => !pageIds.includes(id))
    console.log('Error selectedIds:', pageIds);
  }
}



function confirmSelection() {

  if (selectedIds.value.length === 0) {
    Swal.fire({ text: '❌ กรุณาเลือกอย่างน้อย 1 โปรโมชั่น', icon: 'warning' });
    return;
  }

  const promotions = tableData.value
    .filter(p => selectedIds.value.includes(p.id))
    .map(p => ({
      pro_m_id: p.id,
      pro_m_title: p.title,
      pro_m_code: p.activity_code,
      // pro_acm_id: p.activity_id,
      pro_m_images: p.image,
    }));

  // openProductSelector(selectedPromotion);

  selectedPromotion.value = promotions;
  showPromotionProductSelector.value = true;

  console.log("✅ SelectedProducts ถูกแปลงแล้ว:", selectedPromotion);
  // emit('select-promotion', selectedPromotion);
  // ส่งไปให้ parent
  emit('select-promotion', selectedPromotion.value);
  emit('close');

}


async function searchPromotion_no() {

  isLoading.value = true;

  if(keyword_promotion_no.value.trim()){

    const kw = keyword.value.trim().toLowerCase();
    const promoNo = keyword_promotion_no.value.trim().toLowerCase();

    // เรียกกฟังก์ชัน getPromotion() เพื่อดึงข้อมูลโปรโมชั่นทั้งหมด ลง tableData.value ทุกครั้งที่ ค้นหา
    await getPromotion();

    console.log('keyword kw: ', kw)
    console.log('keyword promoNo: ', promoNo)
    console.log('tableData.value: ', tableData.value)

    // กรองข้อมูล promotionProducts ตามเงื่อนไข AND
    const filtered = tableData.value.filter(item => {
      const title = item.title ? item.title.toLowerCase() : '';
      const titledetail = item.title ? item.titledetail.toLowerCase() : '';
      // const erp_title = item.erp_title ? item.erp_title.toLowerCase() : ''; // || erp_title.includes(promoNo)
      const activityCode = item.activity_code ? item.activity_code.toLowerCase() : '';

      console.log('title: ', title);

      // ตรวจสอบว่า title ต้องมี keyword อยู่ (includes) แต่ activity_code ต้องตรงเป๊ะกับ promoNo
      // erp_title.includes(kw) ||
      const matchKeyword = kw ? title.includes(kw) ||  titledetail.includes(kw) : true;
      // const matchKeyword = kw ? erp_title.includes(kw) : true;
      const matchPromoNo = promoNo ? title.includes(promoNo) || activityCode.includes(promoNo) || titledetail.includes(promoNo) : true;
      // const matchPromoNo = promoNo ? activityCode === promoNo : true;

      console.log('matchKeyword: ', matchKeyword)
      console.log('matchPromoNo: ', matchPromoNo)

      return matchKeyword && matchPromoNo;
    });

    console.log('filtered:',filtered);

    tableData.value = filtered;

    dataselectpromotion_no.value = filtered;
          tableData.value = [...filtered];
          total.value = filtered.length;
          pageSize.value = (total.value < pageSize.value)
            ? total.value
            : parseInt(pageSize.value);

          pageCurrent.value = 1; // รีเซ็ตไปหน้าแรก
          pageSize.value = 10; // ปรับ pageSize เป็น 10 เสมอ

    console.log('tableData.value:',tableData.value);

    isLoading.value = false;

    // ถ้าต้องการโชว์ว่าเจอแค่รายการเดียวหรือไม่
    if (filtered.length === 1) {
      console.log('พบรายการที่ตรงกันอย่างแม่นยำ 1 รายการ:', filtered[0]);
    } else if (filtered.length === 0) {
      console.log('ไม่พบรายการที่ตรงกัน');
    } else {
      console.log('พบหลายรายการ:', filtered.length);
    }



  } else {

    isLoading.value = true;

    console.log('Check isLoading.value: ',isLoading.value)

    // กำหนด ให้ pageSize มีค่า default = 10 1 หน้า แล้วทำการเรียกฟังก์ชัน SearchPromotionSubmit
    // โดยมีเงื่อนไขว่า ถ้าค่าตัวของฟังก์ชัน searchPromotion_no ที่ keyword_promotion_no เป็นค่าว่าง ให้เข้าเงื่อนไขนี้
    pageSize.value = 10;

    SearchPromotionSubmit();
    isLoading.value = false;
  }
}

// const searchPromotion_no = async () => {
//   clearTimeout(searchTimer.value);

//   if (!keyword_promotion_no.value.trim()) {
//     try {

//       const gettoken = localStorage.getItem('token');
//       console.log("log value token:", gettoken);

//        if(!gettoken){
//           Swal.fire({
//               toast:'❌ กรุณาทำการเลือกร้านค้าของลูกค้าก่อนทำการเพิ่มข้อมูล',
//               title: '❌ กรุณาทำการเลือกร้านค้าของลูกค้าก่อนทำการเพิ่มข้อมูล',
//               text: 'ไปยังหน้าเลือกร้านค้าของลูกค้า ?',
//               icon: 'warning',
//               confirmButtonText: 'OK'
//             }).then(() => {
//               router.push('/customer'); // ไปยังหน้าของ customer
//             });
//             // selectcustomer.value = ; // ปิด popup เลือกร้านค้า
//             isLoading.value = false;
//             return;
//         }

//       // ?from=specialprice
//       const response = await axios.post(
//         `${BASE_URL}/goods2/activityList2`,
//         {
//           version: '2.0.2',
//           // keywords: keyword.value,
//           keywords: keyword_promotion_no.value,
//           level: getLevel
//         }, //  body
//         {
//           params: {
//             "from": "specialprice"
//           },
//           headers: {
//             'Content-Type': 'application/json',
//             'token': gettoken
//           }
//         }
//       );

//       // const response = await axios.post(`${BASE_URL}/Goods2/product`, {
//       //   version: '2.0.2',
//       //   pageSize: pageSize.value,
//       //   pageCurrent: pageCurrent.value,
//       //   keywords: keyword_promotion_no.value,
//       //   level: getLevel
//       // });

//       console.log("IF searchSku response:", response);
//       // console.log("IF searchSku total:", response.data.data.item_count);

//       if (response.data.code === 1) {
//         const rawData = response.data.data;

//         // 🧠 ฟิลเตอร์โปรโมชั่นจาก keyword_promotion_no หรือ keyword ที่พิมพ์
//         const keywordToSearch = keyword_promotion_no.value.trim().toLowerCase();

//         const filtered = rawData.filter((item) =>
//           item.title.toLowerCase().includes(keywordToSearch)
//         );

//         console.log("Filtered promotions:", filtered);

//         dataselectpromotion_no.value = filtered;
//         tableData.value = [...filtered];
//         total.value = filtered.length;
//         pageSize.value = (total.value < pageSize.value)
//           ? total.value
//           : parseInt(pageSize.value);
//       }

//       // if (response.data.code === 1) {
//       //   total.value = response.data.data.item_count;
//       //   dataselectpromotion_no.value = response.data.data.data2;
//       //   tableData.value = [...dataselectpromotion_no.value];
//       //   pageSize.value = (total.value < pageSize.value) ? total.value : parseInt(pageSize.value);
//       // }
//     } catch (err) {
//       console.error("searchSku error:", err);
//     }
//   } else {
//     try {
//       // const response = await axios.post(`${BASE_URL}/Goods2/product`, {
//       //   version: '2.0.2',
//       //   pageSize: pageSize.value,
//       //   pageCurrent: pageCurrent.value,
//       //   // keywords: dataselectpromotion_no.value,
//       //   keywords: keyword.value + '$_' + keyword_promotion_no.value + '_$',
//       //   level: getLevel,

//       // });

//       // console.log("ELSE searchSku response:", response);
//       // console.log("ELSE searchSku total:", response.data.data.item_count);

//       // if (response.data.code === 1) {
//       //   total.value = response.data.data.item_count;
//       //   dataselectpromotion_no.value = response.data.data.data2;
//       //   tableData.value = [...dataselectpromotion_no.value];
//       // }
//       const gettoken = localStorage.getItem('token');
//       console.log("log value token:", gettoken);

//        if(!gettoken){
//             Swal.fire({
//                 toast:'❌ กรุณาทำการเลือกร้านค้าของลูกค้าก่อนทำการเพิ่มข้อมูล',
//                 title: '❌ กรุณาทำการเลือกร้านค้าของลูกค้าก่อนทำการเพิ่มข้อมูล',
//                 text: 'ไปยังหน้าเลือกร้านค้าของลูกค้า ?',
//                 icon: 'warning',
//                 confirmButtonText: 'OK'
//               }).then(() => {
//                 router.push('/customer'); // ไปยังหน้าของ customer
//               });
//               // selectcustomer.value = ; // ปิด popup เลือกร้านค้า
//               isLoading.value = false;
//               return;
//           }

//       // ?from=specialprice
//       const response = await axios.post(
//         `${BASE_URL}/goods2/activityList2`,
//         {
//           version: '2.0.2',
//           pageSize: pageSize.value,
//           pageCurrent: pageCurrent.value,
//           // keywords: keyword.value,
//           keywords: keyword.value + '$_' + keyword_promotion_no.value + '_$',
//           level: getLevel
//         }, //  body
//         {
//           params: {
//             "from": "specialprice"
//           },
//           headers: {
//             'Content-Type': 'application/json',
//             'token': gettoken
//           }
//         }
//       );

//       // const response = await axios.post(`${BASE_URL}/Goods2/product`, {
//       //   version: '2.0.2',
//       //   pageSize: pageSize.value,
//       //   pageCurrent: pageCurrent.value,
//       //   keywords: keyword_promotion_no.value,
//       //   level: getLevel
//       // });

//       console.log("IF searchSku response:", response);
//       // console.log("IF searchSku total:", response.data.data.item_count);

//       if (response.data.code === 1) {
//         const rawData = response.data.data;

//         console.log("rawData:", rawData);

//         // 🧠 ฟิลเตอร์โปรโมชั่นจาก keyword_promotion_no หรือ keyword ที่พิมพ์
//         const keywordToSearch = keyword_promotion_no.value.trim().toLowerCase().split(/\s+/);

//         // const filtered = rawData.filter((item) =>
//         //   item.title.toLowerCase().includes(keywordToSearch)
//         // );
//         // const search = searchTerm.toLowerCase();
//         // const filtered = rawData.filter(item => item.activity_code?.toLowerCase().includes(keywordToSearch));

//         let filteredResults = [];

//         if (keywordToSearch === "") {
//           // ✅ ถ้าไม่มี keyword ให้แสดงผลทั้งหมด และ pageSize เป็น 10
//           filteredResults = promotionProducts.value;
//           pageSize.value = 10;
//         } else {
//           const filtered = rawData.filter(item =>
//             keywordToSearch.some(kw =>
//               item.title?.toLowerCase().includes(kw) ||
//               item.erp_title?.toLowerCase().includes(kw) ||
//               item.activity_code?.toLowerCase().includes(kw) ||
//               item.activity_id?.toString().toLowerCase().includes(kw) || // แปลงเป็น string เผื่อ activity_id เป็นตัวเลข
//               item.note?.toLowerCase().includes(kw) ||
//               item.ML_Note?.toLowerCase().includes(kw)
//             )
//           );
//         }

//         // const filtered = rawData.filter((item) =>
//         //   item.title?.toLowerCase().includes(keywordToSearch) ||
//         //   item.erp_title?.toLowerCase().includes(keywordToSearch) ||
//         //   item.activity_code?.toLowerCase().includes(keywordToSearch) ||
//         //   item.activity_id?.toLowerCase().includes(keywordToSearch) ||
//         //   item.note?.toLowerCase().includes(keywordToSearch) ||
//         //   item.ML_Note?.toLowerCase().includes(keywordToSearch)
//         // );

//         console.log("🔍 ผลลัพธ์ที่ค้นหาได้:", filteredResults);

//         tableData.value = filteredResults;
//         dataselectpromotion_no.value = filteredResults;
//         total.value = filteredResults.length;
//       }

//       //   console.log("Filtered promotions:", filtered);

//       //   dataselectpromotion_no.value = filtered;
//       //   tableData.value = [...filtered];
//       //   total.value = filtered.length;
//       //   pageSize.value = (total.value < pageSize.value)
//       //     ? total.value
//       //     : parseInt(pageSize.value);
//       // }

//       // if (response.data.code === 1) {
//       //   total.value = response.data.data.item_count;
//       //   dataselectpromotion_no.value = response.data.data.data2;
//       //   tableData.value = [...dataselectpromotion_no.value];
//       //   pageSize.value = (total.value < pageSize.value) ? total.value : parseInt(pageSize.value);
//       // }
//     } catch (err) {
//       console.error("searchSku error:", err);
//     }
//     //satisfies
//   }
// };


  // ฟังก์ชันสำหรับ handle รูป error
const onImageError = (event) => {
  event.target.src = '../src/assets/logos/logo.png' // ใส่ path รูป default ของคุณ
}


async function SearchPromotionSubmit() {
  clearTimeout(searchTimer.value);
  isLoading.value = true; // ✅ เริ่มโหลด

  pageSize.value = 10;

  const getLevelSS = JSON.parse(localStorage.getItem('selectDataCustomer'));

    // ✅ เช็กว่ามีการเลือกร้านค้าหรือยัง
  if (!getLevelSS?.data2) {
    noCustomerSelected.value = true;
    tableData.value = [];
    isLoading.value = false; // ปิด loading
    return; // ออกจากฟังก์ชันเลย
  } else {
    noCustomerSelected.value = false;
  }

  const getLevel = getLevelSS?.data2?.level ?? 0;
  console.log("Log getLevel: ", getLevel);

  memberType.value  = getLevelSS?.data2?.level_name ?? 0;


  // // แปลงค่า getLevel เป็นชื่อสมาชิก
  // // let memberType = '';
  // if (getLevel === 0) {
  //   memberType.value = 'Member End User';
  // } else if (getLevel === 1) {
  //   memberType.value = 'Member A';
  // } else if (getLevel === 7) {
  //   memberType.value = 'Member B';
  // } else if (getLevel === 10) {
  //   memberType.value = 'Member A+';
  // } else {
  //   memberType.value = 'Unknown Member'; // fallback กรณี level อื่น ๆ
  // }

  console.log("ประเภทสมาชิกที่ได้จาก level: ", memberType.value);


  if (!keyword.value.trim()) {

    try {

      const gettoken = localStorage.getItem('token');
      console.log("log value token:", gettoken);

      // ?from=specialprice
      const response = await axios.post(
        `${BASE_URL}/goods2/activityList2`,
        {
          version: '2.0.2',
          // keywords: keyword.value,
          keywords: keyword.value,
          level: getLevel
        }, //  body
        {
          params: {
            "from": "specialprice"
          },
          headers: {
            'Content-Type': 'application/json',
            'token': gettoken
          }
        }
      );

      // const response = await axios.post(`${BASE_URL}/Goods2/product`, {
      //   version: '2.0.2',
      //   pageSize: pageSize.value,
      //   pageCurrent: pageCurrent.value,
      //   keywords: keyword_promotion_no.value,
      //   level: getLevel
      // });

      console.log("IF searchSku response:", response);
      // console.log("IF searchSku total:", response.data.data.item_count);

      if (response.data.code === 1) {
        const rawData = response.data.data;

        // ฟิลเตอร์โปรโมชั่นจาก keyword_promotion_no หรือ keyword ที่พิมพ์
        const keywordToSearch = keyword.value.trim().toLowerCase();

        // const filtered = rawData.filter((item) =>
        //   item.title.toLowerCase().includes(keywordToSearch)
        // );

        // console.log("Filtered promotions:", filtered);

        // dataselectpromotion_no.value = filtered;
        // tableData.value = [...filtered];
        // total.value = filtered.length;
        // pageSize.value = (total.value < pageSize.value)
        //   ? total.value
        //   : parseInt(pageSize.value);

        // pageCurrent.value = 1; // รีเซ็ตไปหน้าแรก

        let filteredResults = [];
          if (keywordToSearch === "") {
            filteredResults = rawData;
          } else {
            filteredResults = rawData.filter((item) =>
              item.title?.toLowerCase().includes(keywordToSearch) ||
              item.erp_title?.toLowerCase().includes(keywordToSearch) ||
              item.activity_code?.toLowerCase().includes(keywordToSearch) ||
              item.activity_id?.toLowerCase().includes(keywordToSearch) ||
              item.note?.toLowerCase().includes(keywordToSearch) ||
              item.ML_Note?.toLowerCase().includes(keywordToSearch)
            );
          }

          console.log("🔍 ผลลัพธ์ที่ค้นหาได้fffffffffff:", filteredResults);

          tableData.value = filteredResults;
          dataselectpromotion_no.value = filteredResults;
          total.value = filteredResults.length;
          pageCurrent.value = 1;

          // ✅ ถ้าไม่พบข้อมูล
          if (filteredResults.length === 0) {
            console.log("ไม่พบข้อมูล");
          }


      }

      // if (response.data.code === 1) {
      //   total.value = response.data.data.item_count;
      //   dataselectpromotion_no.value = response.data.data.data2;
      //   tableData.value = [...dataselectpromotion_no.value];
      //   pageSize.value = (total.value < pageSize.value) ? total.value : parseInt(pageSize.value);
      // }
    } catch (err) {
      console.error("searchSku error:", err);
    } finally {
    // ✅ ปิด loading ไม่ว่าจะพบข้อมูลหรือไม่
    isLoading.value = false;
  }

  } else {
    try {

      const gettoken = localStorage.getItem('token');
      console.log("log value token:", gettoken);

      // ?from=specialprice
      const response = await axios.post(
        `${BASE_URL}/goods2/activityList2`,
        {
          version: '2.0.2',
          pageSize: pageSize.value,
          pageCurrent: pageCurrent.value,
          // keywords: keyword.value,
          keywords: keyword.value + '$_' + keyword_promotion_no.value + '_$',
          level: getLevel
        }, //  body
        {
          params: {
            "from": "specialprice"
          },
          headers: {
            'Content-Type': 'application/json',
            'token': gettoken
          }
        }
      );

      // const response = await axios.post(`${BASE_URL}/Goods2/product`, {
      //   version: '2.0.2',
      //   pageSize: pageSize.value,
      //   pageCurrent: pageCurrent.value,
      //   keywords: keyword_promotion_no.value,
      //   level: getLevel
      // });

      console.log("IF searchSku response:", response);
      // console.log("IF searchSku total:", response.data.data.item_count);

      if (response.data.code === 1) {
        const rawData = response.data.data;

        console.log("rawData:", rawData);

        // 🧠 ฟิลเตอร์โปรโมชั่นจาก keyword_promotion_no หรือ keyword ที่พิมพ์
        const keywordToSearch = keyword.value.trim().toLowerCase();

        // const filtered = rawData.filter((item) =>
        //   item.title.toLowerCase().includes(keywordToSearch)
        // );
        // const search = searchTerm.toLowerCase();
        // const filtered = rawData.filter(item => item.activity_code?.toLowerCase().includes(keywordToSearch));

        let filteredResults = [];

        if (keywordToSearch === "") {
          // ✅ ถ้าไม่มี keyword ให้แสดงผลทั้งหมด และ pageSize เป็น 10
          // eslint-disable-next-line no-undef
          filteredResults = promotionProducts.value;
          pageSize.value = 10;
        } else {
          // ✅ ถ้ามี keyword ให้กรองข้อมูล
          filteredResults = rawData.filter((item) =>
            item.title?.toLowerCase().includes(keywordToSearch) ||
            item.erp_title?.toLowerCase().includes(keywordToSearch) ||
            item.activity_code?.toLowerCase().includes(keywordToSearch) ||
            item.activity_id?.toLowerCase().includes(keywordToSearch) ||
            item.note?.toLowerCase().includes(keywordToSearch) ||
            item.ML_Note?.toLowerCase().includes(keywordToSearch)
          );
        }


        console.log("🔍 ผลลัพธ์ที่ค้นหาได้ssssss:", filteredResults);

         // ✅ ถ้าไม่พบข้อมูล
          if (filteredResults.length === 0) {
            console.log("ไม่พบข้อมูล");
          }

        tableData.value = filteredResults;
        dataselectpromotion_no.value = filteredResults;
        total.value = filteredResults.length;
        pageCurrent.value = 1; // รีเซ็ตไปหน้าแรก

      }

      //   dataselectpromotion_no.value = filtered;
      //   tableData.value = [...filtered];
      //   total.value = filtered.length;
      //   pageSize.value = (total.value < pageSize.value)
      //     ? total.value
      //     : parseInt(pageSize.value);
      // }

      // if (response.data.code === 1) {
      //   total.value = response.data.data.item_count;
      //   dataselectpromotion_no.value = response.data.data.data2;
      //   tableData.value = [...dataselectpromotion_no.value];
      //   pageSize.value = (total.value < pageSize.value) ? total.value : parseInt(pageSize.value);
      // }
    } catch (err) {
      console.error("searchSku error:", err);
    } finally {
    // ✅ ปิด loading ไม่ว่าจะพบข้อมูลหรือไม่
    isLoading.value = false;
  }
    //satisfies
  }
};

//page = 1
async function getPromotion(page = 1) {
  isLoading.value = true;

  try {

    const gettoken = localStorage.getItem('token');
    console.log("log value token:", gettoken);

    if (gettoken) {

      // ?from=specialprice
      const response = await axios.post(
        `${BASE_URL}/goods2/activityList2`,
        {}, //  body
        {
          params: {
            "from": "specialprice"
          },
          headers: {
            'Content-Type': 'application/json',
            'token': gettoken
          }
        }
      );

      console.log("log value data:", response.data);

      const data = response.data;

      // เก็บจำนวนโปรโมชั้นทั้งหมดจาก API
      total.value = data.data.length || 0;

      console.log('Log total.value:', total.value);

      // ถ้าอยากโหลดโปรโมชั้นทั้งหมดในรอบเดียว ให้ตั้ง pageSize = total แล้วโหลดใหม่
      // โหลดทั้งหมดในครั้งแรก
      // if (page === 1 && pageSize.value !== total.value) {
      //   pageSize.value = total.value;
      //   // เรียกโหลดใหม่อีกครั้ง
      //   return this.getPromotion(1);
      // }

      // เอาข้อมูลโปรโมชั้นที่ได้มาเก็บในตัวแปร
      Apipromotion.value = data.data || [];

      tableData.value = Apipromotion.value;
      pageCurrent.value = page;

      console.log('Loaded Promotion:', Apipromotion.value);
      // console.log('Total items:', this.totalItems);
      // isLoading.value = false;

    } else if (!gettoken) {
      // Swal.fire({ text: '❌ กรุณาทำการเลือกร้านค้าของลูกค้าก่อนทำการเพิ่มข้อมูล', icon: 'warning' });
      Swal.fire({
        toast:'❌ กรุณาทำการเลือกร้านค้าของลูกค้าก่อนทำการเพิ่มข้อมูล',
        title: '❌ กรุณาทำการเลือกร้านค้าของลูกค้าก่อนทำการเพิ่มข้อมูล',
        text: 'ไปยังหน้าเลือกร้านค้าของลูกค้า ?',
        icon: 'warning',
        confirmButtonText: 'OK'
      }).then(() => {
        router.push('/customer'); // ไปยังหน้าของ customer
      });
      // selectcustomer.value = ; // ปิด popup เลือกร้านค้า
      isLoading.value = false;
      return;
    }

    isLoading.value = false;

  } catch (err) {
    const message = err.response?.data?.message || err.message || 'Unknown error';
    Swal.fire({ text: message, icon: 'error' });
  }
}

// function mounted() {
//         this.getProduct(1);
//     }
function onInput() {
  clearTimeout(searchTimer.value);
  searchTimer.value = setTimeout(() => {
    SearchPromotionSubmit();
  }, 500); // รอให้พิมพ์เสร็จ 0.5 วิค่อยเรียก
}

// onMounted(() => {
//   // SearchPromotionSubmit(); // โหลดสินค้าทั้งหมดรอบแรก
//   getPromotion();
// });

onMounted(async () => {
  try {
    await SearchPromotionSubmit();
    await getPromotion();
    console.log("✅ เรียกฟังก์ชันทั้งสองแบบเรียงลำดับสำเร็จ");
  } catch (err) {
    console.error("❌ เกิดข้อผิดพลาดในการโหลดข้อมูล:", err);
  }
});

// เมื่อกดปุ่มเลือกโปรโมชั่น
// eslint-disable-next-line no-unused-vars
function openProductSelector(promotionList) {
  selectedPromotion.value = promotionList
  showPromotionProductSelector.value = true
}

// callback เมื่อลูกค้าเลือกสินค้าเสร็จ
function handleSelectedProducts(products) {
  console.log("✅ สินค้าที่เลือกจากโปรโมชั่น:", products)
  showPromotionProductSelector.value = false; // ✅ ปิด popup

}

</script>


<!--
//SearchPromotionSubmit
// async function SearchPromotionSubmit() {

//   const getLevelSS = JSON.parse(localStorage.getItem('selectDataCustomer'));

//   const getLevel = getLevelSS?.data2?.level ?? 0;
//   console.log("Log getLevel: ", getLevel);

//   // แปลงค่า getLevel เป็นชื่อสมาชิก
//   // let memberType = '';
//   if (getLevel === 0) {
//     memberType.value = 'Member End User';
//   } else if (getLevel === 1) {
//     memberType.value = 'Member A';
//   } else if (getLevel === 7) {
//     memberType.value = 'Member B';
//   } else if (getLevel === 10) {
//     memberType.value = 'Member A+';
//   } else {
//     memberType.value = 'Unknown Member'; // fallback กรณี level อื่น ๆ
//   }

//   console.log("ประเภทสมาชิกที่ได้จาก level: ", memberType.value);

//   try {

//     const gettoken = localStorage.getItem('token');
//     console.log("log value token:", gettoken);

//     // ?from=specialprice
//     const response = await axios.post(
//       `${BASE_URL}/goods2/activityList2`,
//       {
//         keywords: keyword.value,
//         level: getLevel
//       }, //  body
//       {
//         params: {
//           "from": "specialprice"
//         },
//         headers: {
//           'Content-Type': 'application/json',
//           'token': gettoken
//         }
//       }
//     );

//     const searchPromotion = response.data.data;

//     console.log("searchProducts:", searchPromotion);


//     // const getData

//     if (response.data.code !== 1) {
//       console.error("ค้นหาไม่สำเร็จ:", response.data.msg);
//     }

//     if (response.data.code === 1) {
//       const data = response.data;
//       // const searchPromotion = data.data.length || 0;

//       // tableData.value = searchPromotion;

//       const searchPromotion = data.data.data2 || []; // สมมุติว่า data2 คือตัว array ที่ใช้แสดงผล
//       tableData.value = [...searchPromotion];        // ยืนยันว่าเป็น array
//       total.value = searchPromotion.length;

//       // tableData.value = searchProducts.map(item => ({
//       //   ...item,
//       //   imageLoaded: false
//       // }));

//       dataselect.value = searchPromotion;
//       // total.value = data.data || 0;
//       // total.value = Array.isArray(result?.data?.list) ? result.data.list.length : 0;


//       console.log("✅ ข้อมูล searchPromotion:", searchPromotion);

//       // console.log('ข้อมูลที่ค้นเจอ:', data.data2);
//       // isLoading.value = false; // โหลดเสร็จ
//     } else {
//       error.value = response.data.message || 'เกิดข้อผิดพลาด';
//       Swal.fire({
//         title: 'ค้นหาไม่สำเร็จ',
//         text: error.value,
//         icon: 'error'
//       });
//       // isLoading.value = false;
//     }
//   } catch (err) {
//     Swal.fire({
//       title: 'เกิดข้อผิดพลาด',
//       text: err.message || 'โปรดลองใหม่ภายหลัง',
//       icon: 'error'
//     });
//     // isLoading.value = false;
//   }
// } -->


<!--

// const selectedPromotion = props.productList
// const promotions = tableData.value
//   .filter(p => selectedIds.value.includes(p.id))
//   .map(p => ({
//     pro_m_id: p.id,
//     pro_m_title: p.title,
//     // pro_erp_title: p.title,
//     pro_m_code: p.activity_code,
//     pro_m_images: p.image,

//     // pro_m_index: p.promotion_index,
//     // pro_unit_price: p.price,
//     // pro_unit: p.units,
//     // qty: 1,
//     // discount: p.discount
//   })); -->


<!-- // isLoading.value = true; // เริ่มโหลด

// const raw = {
//   // pageCurrent: pageCurrent.value,
//   // keywords: keyword.value,
//   // // keywords: keyword.value.trim(), // ตัด space หน้า-หลัง
//   // level: '10',
//   // pageSize: pageSize.value,
//   pageCurrent: pageCurrent.value,
//   pageSize: pageSize.value,
//   keywords: keyword.value,
//   level: getLevel
// };

// console.log('ส่งคำค้นหา:', raw);
// console.log('ส่ง payload ค้นหา:', JSON.stringify(raw, null, 2));

// const response = await axios.post(`${BASE_URL}/Goods2/product`, {
//   headers: { 'Content-Type': 'application/json' }
// }); -->


<!-- <td class="px-4 py-2 border">{{ item.pro_images }}</td>  , :src="item.image" -->
<!-- <td class="px-4 py-4 border text-center">
              <template v-if="item.image">
                <div class="relative w-10 h-10 mx-auto">
                  <img :src="BASE_URL_IMAGE + item.image" @load="item.imageLoaded = true" v-show="item.imageLoaded"
                    alt="products" class="w-10 h-10 rounded-full absolute inset-0" />
                  <div v-if="!item.imageLoaded" class="w-10 h-10 flex items-center justify-center">
                    <svg class="animate-spin h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" fill="none"
                      viewBox="0 0 24 24">
                      <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                      <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v4a4 4 0 00-4 4H4z" />
                    </svg>
                  </div>
                </div>
              </template>
              <template v-else>
                <span class="material-icons text-gray-400 text-4xl">broken_image</span>
              </template>
            </td> -->

<!-- Loading Spinner Overlay -->
<!-- <div v-if="isLoading" class="absolute inset-0 z-50 flex items-center justify-center bg-white bg-opacity-80">
    <svg class="animate-spin h-12 w-12 text-blue-600" xmlns="http://www.w3.org/2000/svg" fill="none"
      viewBox="0 0 24 24">
      <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
      <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v4a4 4 0 00-4 4H4z">
      </path>
    </svg>
  </div> -->


<!-- // Pagination logic
// const paginatedProducts = computed(() => {
//   const start = (pageCurrent.value - 1) * pageSize.value
//   // return props.productList.slice(start, start + pageSize.value)
//   return tableData.value.slice(start, start + pageSize.value)
// }) -->


<!-- // watch(() => props.productList, (newVal) => {
  //   // console.log('ProductSelector received productList:', newVal);
  //   if (newVal) {
  //     tableData.value = [...newVal]
  //     total.value = newVal.length
  //   }
  // }, { immediate: true }) -->


<!-- // function onInput() {
  //   // ยกเลิก timeout เก่าถ้ามี
  //   clearTimeout(this.searchTimer)
  //   // ตั้ง timeout ใหม่ รอ 500ms ถ้าไม่มีการพิมพ์เพิ่มถึงค่อยเรียก
  //   SearchPromotionSubmit()

  // } -->


<!-- // ฟังก์ชันเรียก API
// async function SearchPromotionSubmit() {
//   try {

//     // const raw = {
//     //     pageCurrent: 1,
//     //     keywords: '',
//     //     level: '10', // ได้ตอนเลือกร้านค้า
//     //     pageSize: 30
//     // };

//     const raw = {
//       // pageCurrent: 1,
//       // keywords: keyword.value,
//       // level: '10',
//       // pageSize: 30,
//       pageCurrent: page,
//       keywords: keyword.value, // ← ใช้ keyword ที่กรอกจริงๆ
//       level: '10',
//       pageSize: this.pageSize // this.pageSize เช่น 30, 50 หรือ item_count
//     };

//     console.log('🔎 Search Keyword Raw:', raw);

//     // raw },
//     const response = await axios.post(
//       `${BASE_URL}/Goods2/product`, raw ,
//       {
//         headers: { 'Content-Type': 'application/json' },
//       }
//     )

//     const data = response.data.data;

//       // เก็บจำนวนสินค้าทั้งหมดจาก API
//       this.totalItems = data.item_count || 0;

//       // ถ้าคุณอยากโหลดสินค้าทั้งหมดในรอบเดียว ให้ตั้ง pageSize = totalItems แล้วโหลดใหม่
//       // ตัวอย่าง: โหลดทั้งหมดในครั้งแรก
//       if (page === 1 && this.pageSize !== this.totalItems) {
//           this.pageSize = this.totalItems;
//           // เรียกโหลดใหม่อีกครั้ง
//           return this.getProduct(1);
//       }

//       // เอาข้อมูลสินค้าที่ได้มาเก็บในตัวแปร
//       this.Apiproducts = data.data2 || [];
//       this.pageCurrent = page;

//     console.log('Log responseData: ', response.data);

//     if (response.data.code === 1) {
//       const data = response.data.data.data;
//       tableData.value = data.data2;
//       dataselect.value = data.data2;
//       total.value = data.item_count;

//       console.log("✅ Search Result:", data.data2);
//     } else {
//       error.value = response.data.message || 'เกิดข้อผิดพลาด';
//       Swal.fire({
//         title: 'ค้นหาไม่สำเร็จ',
//         text: error.value,
//         icon: 'error',
//       });
//     }
//   } catch (err) {
//     Swal.fire({
//       title: 'เกิดข้อผิดพลาด',
//       text: err.message || 'โปรดลองใหม่ภายหลัง',
//       icon: 'error',
//     })
//   }
// } -->
