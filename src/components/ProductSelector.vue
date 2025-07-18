<template>
  <div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-[90]">
    <div class="bg-white z-20 rounded-lg shadow-lg p-6 w-[90%] max-w-6xl max-h-[90vh] overflow-y-auto">

      <!-- Search Section -->
      <div class="flex items-center space-x-4">
        <!-- Search Icon -->
        <span class="material-icons text-gray-600" style="font-size: 28px;">search</span>
        <!-- Search Input -->
        <input
          class="w-full p-2 text-gray-600 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
          v-model="keyword" placeholder="ค้นหา..." @input="onInput" confirm-type="search" />
        <div class="">
          <button @click="$emit('close')" class="text-red-500 hover:text-gray-700 mb-16 text-4xl">&times;</button>
        </div>
      </div>

      <div class="text-sm text-gray-500 mt-2">
        * สามารถ ค้นหาได้ ชื่อสินค้า, รหัสสินค้า
      </div>

      <!-- Header -->
      <div class="flex items-center mb-4">

        <div class="flex-1">
          <h2 class="text-xl text-gray-700 font-bold">เลือกสินค้าหลายรายการ</h2>
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

      <!-- Table -->
      <div class="overflow-x-auto mt-4">
        <table class="min-w-full border text-sm">
          <thead class="bg-gray-100 text-gray-700">
            <tr>
              <th class="px-4 py-2 border text-center">
                <input type="checkbox" @change="toggleSelectAll" :checked="isAllSelected" />
              </th>
              <!-- <th class="px-4 py-2 border">รูปภาพ</th>
            <th class="px-4 py-2 border">ชื่อสินค้า</th>
            <th class="px-4 py-2 border">คงเหลือ</th>
            <th class="px-4 py-2 border">พร้อมขาย</th>
            <th class="px-4 py-2 border">ราคาขาย</th> -->
              <th class="px-4 py-2 border">รูปภาพ</th>
              <th class="px-4 py-2 border">ชื่อสินค้า</th>
              <!-- <th class="px-4 py-2 border">สี</th> -->
              <th class="px-4 py-2  text-sm font-medium text-gray-600 relative">
                <!-- Input ช่องค้นหา -->
                <div class="flex gap-1">
                  <input type="text" v-model="keyword_sku_no" placeholder="ค้นหา สี"
                    @focus="dropdownOpenIndex = 'header'" style="margin-top: 0 !important;"
                    class="w-[170px]  py-1 border border-gray-300 rounded-md focus:outline-none" />
                  <!-- ปุ่มค้นหา -->
                  <button @click="searchSku" class="px-3 py-1 bg-blue-500 text-white rounded hover:bg-blue-600">
                    ค้นหา
                  </button>
                </div>
              </th>

              <th class="px-4 py-2 border">รหัสสินค้า</th>
              <th class="px-4 py-2 border">จำนวน</th>
              <th class="px-4 py-2 border">คงเหลือ</th>
              <!-- <th class="px-4 py-2 border">promotion</th> -->
              <th class="px-4 py-2 border">หน่วย</th>
              <th class="px-4 py-2 border">ราคาขาย</th>
            </tr>
          </thead>

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

          <tbody v-if="!isLoading">
            <tr v-for="item in paginatedProducts" :key="item.id">
              <td class="px-4 py-2 border text-center">
                <input type="checkbox" v-model="selectedIds" :value="item.id" />
              </td>
              <!-- @change="toggleSelectProduct(item.id, $event.target.checked)" , :checked="allSelectedIds.includes(item.id)"-->

              <td class="px-4 py-4 border text-center">
                <template v-if="item.image">
                  <img :src="BASE_URL_IMAGE + item.image" alt="products" class="w-10 h-10 rounded-full mx-auto">
                </template>
                <template v-else>
                  <span class="material-icons text-gray-400 text-4xl">broken_image</span>
                </template>
              </td>

              <td class="px-4 text-gray-700 py-2 border">{{ item.erp_title }}</td>
              <td class="px-4 text-gray-700 py-2 border">{{ item.goods_sku_text ?? 'ไม่มีสี' }}</td>
              <td class="px-4 text-gray-700 py-2 border">{{ item.sn }}</td>
              <!-- <td class="px-4 py-2 border">{{ item.promotion }}</td> -->
              <!-- <td class="px-4 text-gray-700 py-2 border">{{ item.stock || 0 }}</td> -->
              <!-- <td class="px-4 text-gray-700 py-2 border">
              <input type="number" v-model.number="item.amount" min="1" placeholder="จำนวน"
                class="w-full px-2 py-1 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-purple-500" />
            </td> -->
              <td class="px-4 text-gray-700 py-2 border text-center">
                <input type="number" class="w-16 px-2 py-1 text-gray-700 border rounded text-center"
                  v-model.number="item.amount" :min="0" :max="item.stock" @input="validateAmount(item)"
                  placeholder="0" />
              </td>
              <td class="px-4 text-gray-700 py-2 border">{{ item.stock }}</td>
              <td class="px-4 text-gray-700 py-2 border">{{ item.units }}</td>
              <td class="px-4 text-gray-700 py-2 border">{{ item.price }}</td>

              <!-- <td class="px-4 py-2 border">{{ item.pro_name }}</td>
            <td class="px-4 py-2 border">{{ item.pro_quantity }}</td>
            <td class="px-4 py-2 border">{{ item.pro_status }}</td>
            <td class="px-4 py-2 border">{{ item.pro_unit_price }}</td> -->
            </tr>
          </tbody>
        </table>

        <!-- Pagination -->
        <ConfigProvider :globalConfig="enConfig">
          <div class=" w-fit mt-4">
            <!-- v-model:page-size="pageSize" overflow-auto text-gray-600-->
            <pagination v-model:current="pageCurrent" v-model:page-size="pageSize" :total="total" show-page-size
              :prev-button-props="{ content: '⏪' }" :next-button-props="{ content: '⏩' }"
              @change="onPaginationChange" />
          </div>
        </ConfigProvider>


      </div>
      <!-- Confirm Button -->
      <div class="text-right mt-4">
        <button class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded" @click="confirmSelection">
          เลือกสินค้า
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


const BASE_URL_IMAGE = import.meta.env.VITE_API_URL_IMAGE;
const BASE_URL = import.meta.env.VITE_API_URL;

const isLoading = ref(false) // สำหรับ loading spinner

const props = defineProps({
  productList: Array,
  pageCurrent: Number,
  pageSize: Number,
  total: Number,

  selectProducts_old_month: {
    type: Array,
    required: false,
    default: () => []
  }
})




const emit = defineEmits(['close', 'select-products', 'page-change'])

const getLevelSS = JSON.parse(localStorage.getItem('selectDataCustomer'));

const getLevel = getLevelSS?.data2?.level ?? 0;

// reactive state
const keyword = ref('')
const searchTimer = ref(null)

const tableData = ref([])

const total = ref(0)
const pageCurrent = ref(1)
const pageSize = ref(10)

const selectedIds = ref([])
const allSelectedIds = ref([]); // ✅ เก็บ ID ของสินค้าทุกหน้าที่ถูกเลือก

const selectedProducts = ref([]);
const showProductSelector = ref(false);

const dataselect = ref([])
const error = ref('')

const keyword_sku_no = ref('');


const dataselectsku_no = ref([]);

const memberType = ref('');


const paginatedProducts = computed(() => {
  return tableData.value;
});

// const paginatedProducts = computed(() => {
//   const start = (pageCurrent.value - 1) * pageSize.value;
//   const end = start + pageSize.value;
//   return tableData.value.slice(start, end);
// });

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

  SearchProducstSubmit(); // โหลดสินค้าหน้าใหม่
  emit('page-change', pageInfo.current);  // ส่ง event ให้ parent โหลดหน้าข้อมูลใหม่
}


// Checkbox logic เลือกสินค้าทั้งหมด
const isAllSelected = computed(() =>
  paginatedProducts.value.every(item => selectedIds.value.includes(item.id))
)

// เช็คว่าตอนนี้สินค้าได้ถูกเลือกเป็นรายการอะไรบ้าง
watch(selectedIds, (newVal) => {
  const selectedProducts = tableData.value.filter(p =>
    // const selectedProducts = props.productList.filter(p =>
    newVal.includes(p.id)
  );
  console.log("สินค้าที่เลือกอยู่ตอนนี้:", selectedProducts);
});

// watch(pageSize, (newVal) => {
//   if (newVal !== 10) {
//     pageSize.value = 10;
//   }
// });

// function toggleSelectProduct(productId, checked) {
//   if (checked) {
//     if (!allSelectedIds.value.includes(productId)) {
//       allSelectedIds.value.push(productId);
//     }
//   } else {
//     allSelectedIds.value = allSelectedIds.value.filter(id => id !== productId);
//   }
// }

//
// function toggleSelectProduct(productId, checked) {
//   if (checked) {
//     if (!allSelectedIds.value.includes(productId)) {
//       allSelectedIds.value.push(productId);
//     }
//   } else {
//     allSelectedIds.value = allSelectedIds.value.filter(id => id !== productId);
//   }

//   // 👇 อัปเดต selectedIds ให้แสดงค่าบนหน้าปัจจุบันให้ตรงกับ allSelectedIds
//   const pageIds = paginatedProducts.value.map(item => item.id);
//   selectedIds.value = allSelectedIds.value.filter(id => pageIds.includes(id));
// }


// function toggleSelectAll(event) {
//   const pageIds = paginatedProducts.value.map(item => item.id);

//   if (event.target.checked) {
//     allSelectedIds.value = [...new Set([...allSelectedIds.value, ...pageIds])];
//   } else {
//     allSelectedIds.value = allSelectedIds.value.filter(id => !pageIds.includes(id));
//   }

//   // 👇 อัปเดต selectedIds เช่นเดียวกัน
//   selectedIds.value = allSelectedIds.value.filter(id => pageIds.includes(id));
// }

// function เลือกสินค้าทั้งหมด

// function เลือกสินค้าทั้งหมด
function toggleSelectAll(event) {
  if (event.target.checked) {
    const pageIds = [];
    paginatedProducts.value.forEach(item => {
      if (item.stock > 0) {
        item.amount = 1; // กำหนดจำนวนให้เท่ากับ stock
        pageIds.push(item.id);    // เพิ่มเฉพาะ id ที่ stock > 0
      } else {
        item.amount = 0; // ถ้า stock ≤ 0 ให้ใส่เป็น 0
      }
    });


    selectedIds.value = [...new Set([...selectedIds.value, ...pageIds])];

    console.log('✅ toggleSelectAll selectedIds (stock > 0 only):', pageIds);
  } else {
    const pageIds = paginatedProducts.value.map(item => item.id);
    selectedIds.value = selectedIds.value.filter(id => !pageIds.includes(id));
    console.log('🚫 Deselected selectedIds:', pageIds);

    // เคลียร์ amount ตอนยกเลิกติ๊ก ถ้าต้องการ
    paginatedProducts.value.forEach(item => {
      item.amount = 0;
    });
  }
}
// function toggleSelectAll(event) {
//   if (event.target.checked) {
//     const pageIds = paginatedProducts.value.map(item => item.id)
//     selectedIds.value = [...new Set([...selectedIds.value, ...pageIds])]

//     console.log('toggleSelectAll selectedIds:', pageIds);
//   } else {
//     const pageIds = paginatedProducts.value.map(item => item.id)
//     selectedIds.value = selectedIds.value.filter(id => !pageIds.includes(id))
//     console.log('Error selectedIds:', pageIds);
//   }
// }


// // function เลือกสินค้าทั้งหมด
// function toggleSelectAll(event) {
//   if (event.target.checked) {
//     const pageIds = paginatedProducts.value.map(item => item.id)
//     selectedIds.value = [...new Set([...selectedIds.value, ...pageIds])]

//     console.log('toggleSelectAll selectedIds:', pageIds);
//   } else {
//     const pageIds = paginatedProducts.value.map(item => item.id)
//     selectedIds.value = selectedIds.value.filter(id => !pageIds.includes(id))
//     console.log('Error selectedIds:', pageIds);
//   }
// }


function validateAmount(item) {
  if (item.amount < 0) {
    item.amount = 0;
  } else if (item.amount > item.stock) {
    item.amount = item.stock;
  }

  // logic ติ๊ก checkbox อัตโนมัติ
  if (item.amount > 0) {
    if (!selectedIds.value.includes(item.id)) {
      selectedIds.value.push(item.id);
    }
  } else {
    // ถ้าใส่ 0 หรือลบออก ให้เอาออกจาก selectedIds
    selectedIds.value = selectedIds.value.filter(id => id !== item.id);
  }

}


const searchSku = async () => {
  clearTimeout(searchTimer.value);

  if (!keyword_sku_no.value.trim()) {
    try {
      const response = await axios.post(`${BASE_URL}/Goods2/product`, {
        version: '2.0.2',
        pageSize: pageSize.value,
        pageCurrent: pageCurrent.value,
        keywords: keyword_sku_no.value,
        level: getLevel
      });

      console.log("IF searchSku response:", response);
      console.log("IF searchSku total:", response.data.data.item_count);

      if (response.data.code === 1) {
        total.value = response.data.data.item_count;
        dataselectsku_no.value = response.data.data.data2;
        tableData.value = [...dataselectsku_no.value];
        pageSize.value = (total.value < pageSize.value) ? total.value : parseInt(pageSize.value);
      }
    } catch (err) {
      console.error("searchSku error:", err);
    }
  } else {
    try {
      const response = await axios.post(`${BASE_URL}/Goods2/product`, {
        version: '2.0.2',
        pageSize: pageSize.value,
        pageCurrent: pageCurrent.value,
        // keywords: keyword_sku_no.value,
        keywords: keyword.value + '$_' + keyword_sku_no.value + '_$',
        level: getLevel,

      });

      console.log("ELSE searchSku response:", response);
      console.log("ELSE searchSku total:", response.data.data.item_count);

      if (response.data.code === 1) {
        total.value = response.data.data.item_count;
        dataselectsku_no.value = response.data.data.data2;
        tableData.value = [...dataselectsku_no.value];
      }
    } catch (err) {
      console.error("searchSku error:", err);
    }
  }
};

async function SearchProducstSubmit() {

  isLoading.value = true;

  const getLevelSS = JSON.parse(localStorage.getItem('selectDataCustomer'));

  const getLevel = getLevelSS?.data2?.level ?? 0;
  console.log("Log getLevel: ", getLevel);

  // แปลงค่า getLevel เป็นชื่อสมาชิก
  // let memberType = '';
  if (getLevel === 0) {
    memberType.value = 'Member Nuser';
  } else if (getLevel === 1) {
    memberType.value = 'Member A';
  } else if (getLevel === 7) {
    memberType.value = 'Member B';
  } else if (getLevel === 10) {
    memberType.value = 'Member A+';
  } else {
    memberType.value = 'Unknown Member'; // fallback กรณี level อื่น ๆ
  }

  console.log("ประเภทสมาชิกที่ได้จาก level: ", memberType.value);

  if (!keyword.value.trim()) {
    try {

      // isLoading.value = true; // เริ่มโหลด

      const raw = {
        // pageCurrent: pageCurrent.value,
        // keywords: keyword.value,
        // // keywords: keyword.value.trim(), // ตัด space หน้า-หลัง
        // level: '10',
        // pageSize: pageSize.value,
        pageCurrent: pageCurrent.value,
        pageSize: pageSize.value,
        keywords: keyword.value,
        level: getLevel
      };

      console.log('ส่งคำค้นหา:', raw);
      console.log('ส่ง payload ค้นหา:', JSON.stringify(raw, null, 2));

      const response = await axios.post(`${BASE_URL}/Goods2/product`, raw, {
        headers: { 'Content-Type': 'application/json' }
      });

      // console.log("API Response ทั้งหมด:", response.data);
      // console.log("API Response ทั้งหมด:", response.data.data.data2);

      const searchProducts = response.data.data.data2;

      console.log("searchProducts:", searchProducts);


      // const getData

      if (response.data.code !== 1) {
        console.error("ค้นหาไม่สำเร็จ:", response.data.msg);
      }

      if (response.data.code === 1) {
        const data = response.data.data;
        const searchProducts = data.data2 || [];

        const keywordToSearch = keyword.value.trim().toLowerCase();

        if (!searchProducts || searchProducts.length === 0) {
          console.warn("⚠️ ไม่มีข้อมูล searchProducts โปรดเรียก getPromotionProducts() ก่อน");
          return;
        }

        let filteredResults = [];

        if (keywordToSearch === "") {
          // ✅ ถ้าไม่มี keyword ให้แสดงผลทั้งหมด และ pageSize เป็น 10
          filteredResults = searchProducts;
          pageSize.value = 10;
        } else {
          // ✅ ถ้ามี keyword ให้กรองข้อมูล
          filteredResults = searchProducts.filter((sku) =>
            sku.title?.toLowerCase().includes(keywordToSearch) ||
            sku.erp_title?.toLowerCase().includes(keywordToSearch) ||
            sku.goods_sku_text?.toLowerCase().includes(keywordToSearch) ||
            sku.sn?.toLowerCase().includes(keywordToSearch) ||
            sku.activity_code?.toLowerCase().includes(keywordToSearch)
          );

          // ✅ ปรับ pageSize ไม่ให้เกินจำนวนผลลัพธ์
          // pageSize.value = (filteredResults.length < pageSize.value)
          //   ? filteredResults.length
          //   : parseInt(pageSize.value);

          // ✅ แทนด้วยการกำหนด pageCurrent กลับไปหน้าแรกแทน
          // pageCurrent.value = 1;
        }

        console.log("🔍 ผลลัพธ์ที่ค้นหาได้:", filteredResults);

        tableData.value = filteredResults;
        dataselect.value = filteredResults;
        total.value = filteredResults.length;

        // dataselect.value = searchProducts;
        // total.value = data.item_count || 0;

        console.log("✅ ข้อมูล searchProducts:", filteredResults);

        // console.log('ข้อมูลที่ค้นเจอ:', data.data2);
        isLoading.value = false; // โหลดเสร็จ
      } else {
        error.value = response.data.message || 'เกิดข้อผิดพลาด';
        Swal.fire({
          title: 'ค้นหาไม่สำเร็จ',
          text: error.value,
          icon: 'error'
        });
        // isLoading.value = false;
      }
    } catch (err) {
      Swal.fire({
        title: 'เกิดข้อผิดพลาด',
        text: err.message || 'โปรดลองใหม่ภายหลัง',
        icon: 'error'
      });
      // isLoading.value = false;
    }
  } else {
    try {

      // isLoading.value = true; // เริ่มโหลด

      const raw = {
        // pageCurrent: pageCurrent.value,
        // keywords: keyword.value,
        // // keywords: keyword.value.trim(), // ตัด space หน้า-หลัง
        // level: '10',
        // pageSize: pageSize.value,
        pageCurrent: pageCurrent.value,
        pageSize: pageSize.value,
        keywords: keyword.value,
        level: getLevel
      };

      console.log('ส่งคำค้นหา:', raw);
      console.log('ส่ง payload ค้นหา:', JSON.stringify(raw, null, 2));

      const response = await axios.post(`${BASE_URL}/Goods2/product`, raw, {
        headers: { 'Content-Type': 'application/json' }
      });

      // console.log("API Response ทั้งหมด:", response.data);
      // console.log("API Response ทั้งหมด:", response.data.data.data2);

      const searchProducts = response.data.data.data2;

      console.log("searchProducts:", searchProducts);


      // const getData

      if (response.data.code !== 1) {
        console.error("ค้นหาไม่สำเร็จ:", response.data.msg);
      }

      if (response.data.code === 1) {
        const data = response.data.data;
        const searchProducts = data.data2 || [];

        // tableData.value = searchProducts;

        // tableData.value = searchProducts.map(item => ({
        //   ...item,
        //   imageLoaded: false
        // }));

        const keywordToSearch = keyword.value.trim().toLowerCase();

        if (!searchProducts || searchProducts.length === 0) {
          console.warn("⚠️ ไม่มีข้อมูล promotionProducts โปรดเรียก getPromotionProducts() ก่อน");
          return;
        }

        const filteredResults = searchProducts.filter((product) =>
          product.title?.toLowerCase().includes(keywordToSearch) ||
          product.erp_title?.toLowerCase().includes(keywordToSearch) ||
          product.goods_sku_text?.toLowerCase().includes(keywordToSearch) ||
          product.sn?.toLowerCase().includes(keywordToSearch) ||
          product.activity_code?.toLowerCase().includes(keywordToSearch)
        );

        console.log("🔍 ผลลัพธ์ที่ค้นหาได้:", filteredResults);

        tableData.value = filteredResults;
        dataselect.value = filteredResults;
        total.value = filteredResults.length;
        pageSize.value = (total.value < pageSize.value)
          ? total.value
          : parseInt(pageSize.value);

        // dataselect.value = searchProducts;
        // total.value = data.item_count || 0;

        console.log("✅ ข้อมูล searchProducts:", searchProducts);

        // console.log('ข้อมูลที่ค้นเจอ:', data.data2);
        isLoading.value = false; // โหลดเสร็จ
      } else {
        error.value = response.data.message || 'เกิดข้อผิดพลาด';
        Swal.fire({
          title: 'ค้นหาไม่สำเร็จ',
          text: error.value,
          icon: 'error'
        });
        // isLoading.value = false;
      }
    } catch (err) {
      Swal.fire({
        title: 'เกิดข้อผิดพลาด',
        text: err.message || 'โปรดลองใหม่ภายหลัง',
        icon: 'error'
      });
      // isLoading.value = false;
    }
  }
}

function confirmSelection() {
  // const selectedProducts = tableData.value
  // const selectedProducts = props.productList
  // .filter(p => selectedIds.value.includes(p.id))
  // .map(p => ({
  //   pro_id: p.id,
  //   pro_erp_title: p.erp_title,
  //   pro_sn: p.sn,
  //   pro_images: p.image,
  //   pro_quantity: p.amount || 1, // ใช้ amount ถ้าไม่มีให้ใช้ 1
  //   pro_unit_price: p.price,
  //   pro_unit: p.units,
  //   // qty: 1,
  //   // discount: p.discount
  // }));

  // const selectedProducts = props.productList.filter(p =>
  //   allSelectedIds.value.includes(p.id)
  // );

  console.log('🔥 selectedProducts_old:', props.selectProducts_old_month);

  // ✅ ถ้าต้องการเก็บในตัวแปร
  // const get_productOld = props.selectedProducts_old;
  // console.log('🎯 get_productOld:', get_productOld);

  // const get_productOld = (props.selectProducts_old || []).map(p => p);

  const get_productOld_raw = (props.selectProducts_old_month || []).map(p => ({ ...p }));

  console.log('🎯 get_productOld:', get_productOld_raw);

  const selectedProducts = tableData.value
    // const selectedProducts = props.productList
    .filter(p => selectedIds.value.includes(p.id))
    .map(p => ({
      pro_activity_id: p.activity_id ?? 0, // 1167
      pro_goods_id: p.goods_id, // pro_goods_id
      pro_sku_price_id: p.id, // pro_sku_price_id
      // pro_code: p.activity_code, // x
      pro_erp_title: p.erp_title,
      pro_title: p.title, // "ชุดอะแดปเตอร์เซ็ต AG-201 (20W)"
      pro_sn: p.sn,
      pro_image: p.image, // pro_image
      pro_goods_num: p.amount || 0, // pro_goods_num
      pro_quantity: p.amount || 0,
      // pro_goods_price: p.price, // pro_goods_price
      pro_goods_price: p.price, // "215.00"
      pro_units: p.units,
      stock: p.stock || 0,
      // pro_m_code: p.pro_m_code, // x 
      // pro_goods_sku_text: p.goods_sku_text,
      // promotions: p.promotions || [],
      // gifts: p.gifts || [],
      // st: p.st ?? 0

    }));


  const sum_products = [...get_productOld_raw, ...selectedProducts];

  console.log('Check: sum_products', sum_products);




  function groupBy(arr, keyFn) {
    return arr.reduce((acc, item) => {
      const groupKey = typeof keyFn === 'function' ? keyFn(item) : item[keyFn];

      // ดึงจำนวนสินค้า โดย fallback เป็น 0 และแปลงเป็น int
      const quantity =
        Number(item.pro_goods_num) || Number(item.pro_quantity) || 0;

      if (!acc[groupKey]) {
        // ✅ เปลี่ยนชื่อ pro_images → pro_image ที่นี่
        acc[groupKey] = {
          ...item,
          pro_goods_num: quantity,
          pro_quantity: quantity,
          pro_image: item.image || item.pro_image || '', // ✅ ตั้งชื่อใหม่
          pro_goods_price: item.pro_goods_price || item.pro_unit_price, // ✅ ตั้งชื่อใหม่
          activity_id: item.activity_id || 0
        };

        // ❌ ลบ key เดิมถ้าไม่ต้องการให้ติดไปด้วย (เช่น pro_images)
        delete acc[groupKey].pro_images;

      } else {
        // รวมจำนวนต่อจาก key เดิม
        acc[groupKey].pro_goods_num =
          Number(acc[groupKey].pro_goods_num) + quantity;
        acc[groupKey].pro_quantity =
          Number(acc[groupKey].pro_quantity) + quantity;
      }

      return acc;
    }, {});
  }


  const grouped = groupBy(sum_products, item => `${item.pro_activity_id}_${item.pro_sku_price_id}`);
  const groupedArray = Object.values(grouped);


  const newproduct = [];

  Object.values(grouped).forEach(item => {
    newproduct.push(item);
  });


  console.log('✅ Grouped  resultnewproduct:', newproduct);
  console.log('✅ Grouped  result groupedArray:', groupedArray);
  // const selectedProducts = tableData.value
  //   .filter(p => selectedIds.value.includes(p.id))
  //   .map(p => ({
  //     pro_id: p.id,
  //     pro_erp_title: p.erp_title,
  //     pro_sn: p.sn,
  //     pro_images: p.image,
  //     pro_quantity: p.amount || 1, // ใช้ amount ถ้าไม่มีให้ใช้ 1
  //     pro_unit_price: p.price,
  //     pro_unit: p.units,
  //   }));


  // console.log("✅ รวมสินค้าทุกหน้าที่เลือก:", selectedProducts);

  // return;

  SelectProductProMonth(newproduct);

  // emit("select-products", selectedProducts); // ✅ ส่งกลับไปหน้า parent
  // console.log("✅ SelectedProducts ถูกแปลงแล้ว:", selectedProducts);
  // emit('select-products', selectedProducts);
  // emit('close');
}

async function SelectProductProMonth(newproduct) {

  isLoading.value = true;

  const gettoken = localStorage.getItem('token');
  console.log('Log Value gettoken: ', gettoken);
  console.log('Log Value ProductWithMonth: ', newproduct);

  // return;

  try {

    const response = await axios.post(
      `${BASE_URL}/cart_out/index`,
      {
        products: newproduct, // ส่งข้อมูลที่เลือกไปยัง API
      },
      {

        headers: {
          'Content-Type': 'application/json',
          'token': gettoken
        }
      }
    );

    console.log("✅ Response from API:", response);

    // const getData

    if (response.data.code !== 1) {
      console.error("ค้นหาสินค้าไม่สำเร็จ:", response.data.msg);
    }

    if (response.data.code === 1) {
      const data = response.data.data.products || [];

      tableData.value = data;
      console.log("Check Value tableData.value:", tableData.value);

      // tableData.value = searchProducts.map(item => ({
      //   ...item,
      //   imageLoaded: false
      // }));

      const items = data.filter(item => item.pro_goods_id !== 0 && item?.ML_Note === 'item' || item?.ML_Note === 'itemmonth');
      const gifts = data.filter(item => item.pro_goods_id !== 0 && item?.ML_Note === 'zengsopng_day' || item?.ML_Note === 'zengsopng_month');
      const promotions = data.filter(item => item.pro_activity_id !== 0 && item?.ML_Note === 'promotion_day' || item?.ML_Note === 'promotion_month');

      const emitTitles = newproduct.map(p => ({
        pro_goods_id: p.pro_goods_id || 0,
        pro_activity_id: p.pro_activity_id || 0,
        pro_title: p.pro_title || p.pro_erp_title || '(ไม่มีชื่อ)',
        pro_erp_title: p.pro_erp_title || '(ไม่มีชื่อ)',
        pro_goods_price: p.pro_goods_price || 0,
        pro_sn: p.pro_sn || '',
        // pro_sn: p.pro_sn || '',
        // pro_units: p.pro_units || '',
        pro_units: p.pro_unit || '',
        amount: p.pro_goods_num || 0,
        stock: p.pro_stock || 0,
        // stock: p.stock || 0,
      }));

      console.log("🤯🤯 Log emitTitles:", emitTitles);

      // const emitTitles = data.map(item => item.pro_title || item.pro_erp_title).join(', ');
      // ใช้ได้
      console.log("✅ Items:", items);
      console.log("✅ Gifts:", gifts);
      console.log("✅ Promotions:", promotions);

      // ใช้ได้
      console.log("🔁 Emit กลับไปหน้า parent:", { items, gifts, promotions, emitTitles });
      // console.log("🔁 Emit กลับไปหน้า parent:", { items, itemsMonth, giftsDay, giftsMonth, promotionsDay, promotionsMonth});
      // ส่งข้อมูลกลับไปยังหน้าหลัก

      // ทำการตรวจสอบข้อมูลที่ได้รับกลับมา
      if (data.length > 0) {
        Swal.fire({
          title: 'สำเร็จ',
          text: 'ข้อมูลถูกส่งกลับไปยังหน้าหลักเรียบร้อยแล้ว',
          icon: 'success',
        });

      } else {
        Swal.fire({
          title: 'ไม่มีสินค้า',
          text: 'ไม่พบสินค้าที่เลือกในระบบ!',
          icon: 'warning',
        });
      }

      console.log("📤 กำลัง emit selectPromotionProducts");

      // return;

      emit('selectProductsWithMonth', {
        // emit('select-promotion_products', {
        // ใช้ได้
        items,
        gifts,
        promotions,
        emitTitles
      });

      emit('close'); // 

      isLoading.value = false; // โหลดเสร็จ
    } else {
      error.value = response.data.message || 'เกิดข้อผิดพลาด';
      Swal.fire({
        title: 'ค้นหาไม่สำเร็จ',
        text: error.value,
        icon: 'error'
      });
      // isLoading.value = false;
    }
  } catch (err) {
    Swal.fire({
      title: 'เกิดข้อผิดพลาด',
      text: err.message || 'โปรดลองใหม่ภายหลัง',
      icon: 'error'
    });
    // isLoading.value = false;
  }
}



// function mounted() {
//         this.getProduct(1);
//     }
function onInput() {
  clearTimeout(searchTimer.value);
  searchTimer.value = setTimeout(() => {
    SearchProducstSubmit();
  }, 500); // รอให้พิมพ์เสร็จ 0.5 วิค่อยเรียก
}

onMounted(() => {
  SearchProducstSubmit(); // โหลดสินค้าทั้งหมดรอบแรก

  // tableData.value = props.productList.map(item => ({
  //   ...item,
  //   amount: item.amount || 1
  // }))
});


</script>


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
  //   SearchProducstSubmit()
  
  // } -->


<!-- // ฟังก์ชันเรียก API
// async function SearchProducstSubmit() {
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