<template>
  <div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-[99]">
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
              <th class="px-4 py-2 border w-full min-w-[250px]">ชื่อสินค้า</th>
              <!-- <th class="px-4 py-2 border">สี</th> -->
              <th class="px-4 py-2  text-sm font-medium text-gray-600 relative">
                <!-- Input ช่องค้นหา -->
                <div class="flex gap-1">
                  <input type="text" v-model="keyword_sku_no" placeholder="ค้นหา Color, Model, Type"
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

          <!-- /isnotData && isLoading &&   -->
          <tbody v-if="tableData.length === 0">
            <tr>
              <td colspan="10" class="py-10 text-center text-gray-500">
                ไม่พบข้อมูล
              </td>
            </tr>
          </tbody>
          <tbody v-else-if="isLoading">
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
                <!-- v-model="selectedIds" :value="item.id" -->
                <!-- <input type="checkbox" v-model="selectedIds" :value="item.id" -->
                <input type="checkbox" :checked="selectedIds.includes(item.id)"
                  @change="handleCheckboxChange(item, $event)" />
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

              <td class="px-4  text-gray-700 py-2 border">{{  item.erp_title  }}</td> <!--+ ' ' + item.goods_sku_text ?? ''-->
              <!-- <td class="px-4 text-gray-700 py-2 border">{{  item.erp_title + ' ' + item.goods_sku_text ?? '' }}</td> -->
              <!-- <td class="px-4 text-gray-700 py-2 border">{{ item.erp_title }}</td> -->
              <!-- <td class="px-4 text-gray-700 py-2 border">{{ item.goods_sku_text ? item.goods_sku_text : 'ไม่มีสี' }}</td> -->
              <td class="px-2 py-1 border">
                <span :class="item.goods_sku_text
                  ? 'border border-blue-500 px-1 py-1 rounded text-xs text-blue-600 font-semibold'
                  : 'text-gray-500 italic'">
                  {{ item.goods_sku_text || 'ไม่มีสีหรือชนิดของข้อมูล' }}
                </span>
              </td>
              <!-- <td class="px-4 text-gray-700 py-2 border">{{ item.goods_sku_text ?? 'ไม่มีสี' }}</td> -->
              <td class="px-4 text-gray-700 py-2 border">{{ item.sn }}</td>
              <!-- <td class="px-4 py-2 border">{{ item.promotion }}</td> -->
              <!-- <td class="px-4 text-gray-700 py-2 border">{{ item.stock || 0 }}</td> -->
              <!-- <td class="px-4 text-gray-700 py-2 border">
              <input type="number" v-model.number="item.amount" min="1" placeholder="จำนวน"
                class="w-full px-2 py-1 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-purple-500" />
            </td> -->
              <td class="px-4 text-gray-700 py-2 border text-center">
                <!-- :max="item.stock" -->
                <input type="number" class="w-16 px-2 py-1 text-gray-700 border rounded text-center"

                  v-model.number="item.amount" :min="0" :max="item.stock" @keypress="onlyNumberInput($event)"
                  @input="validateAmount(item)" placeholder="0" />
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
// import { quantity } from 'chartist';

import { useRouter } from 'vue-router'

const router = useRouter()

const BASE_URL_IMAGE = import.meta.env.VITE_API_URL_IMAGE;
const BASE_URL = import.meta.env.VITE_API_URL;

const isLoading = ref(false) // สำหรับ loading spinner
const isnotData = ref(false) // สำหรับ loading spinner

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

// eslint-disable-next-line vue/no-dupe-keys
const total = ref(0)
// eslint-disable-next-line vue/no-dupe-keys
const pageCurrent = ref(1)
// eslint-disable-next-line vue/no-dupe-keys
const pageSize = ref(10)

const selectedIds = ref([])
// const allSelectedIds = ref([]); // ✅ เก็บ ID ของสินค้าทุกหน้าที่ถูกเลือก

const selectedProducts = ref([]); // ✅ เก็บสินค้าที่เลือกข้ามหน้า
// const showProductSelector = ref(false);

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

  SearchProducstSubmitFirst(); // โหลดสินค้าหน้าใหม่
  // SearchProducstSubmit(); // โหลดสินค้าหน้าใหม่
  emit('page-change', pageInfo.current);  // ส่ง event ให้ parent โหลดหน้าข้อมูลใหม่
}


// Checkbox logic เลือกสินค้าทั้งหมด
const isAllSelected = computed(() =>
  paginatedProducts.value.every(item => selectedIds.value.includes(item.id))
)

// เช็คว่าตอนนี้สินค้าได้ถูกเลือกเป็นรายการอะไรบ้าง
watch(selectedIds, (newVal) => {
  // const selectedProducts = paginatedProducts.value.filter(p =>
  const selectedProducts = tableData.value.filter(p =>
    // const selectedProducts = props.productList.filter(p =>
    newVal.includes(p.id)
  );
  console.log("สินค้าที่เลือกอยู่ตอนนี้:", selectedProducts);
});

// อัปเดต จำนวนสินค้าใน selectedProducts เมื่อ tableData เปลี่ยนแปลง
watch(tableData, (newTable) => {
  newTable.forEach(item => {
    watch(() => item.amount, val => {
      const sel = selectedProducts.value.find(p => p.id === item.id)
      if (sel) sel.amount = val
    })
  })
}, { immediate: true })


function toggleSelectAll(event) {
  console.log('✅ Check event:', event);

  if (event.target.checked) {
    const pageIds = [];
    paginatedProducts.value.forEach(item => {
      if (item.stock > 0) {
        item.amount = 1;
        pageIds.push(item.id);

        // ✅ เพิ่มสินค้าลง selectedProducts ถ้ายังไม่มี
        if (!selectedProducts.value.find(p => p.id === item.id)) {
          selectedProducts.value.push({ ...item });
        }
      } else {
        item.amount = 0;
      }
    });

    selectedIds.value = [...new Set([...selectedIds.value, ...pageIds])];

    console.log('✅ toggleSelectAll selectedIds (stock > 0 only):', pageIds);
  } else {
    const pageIds = paginatedProducts.value.map(item => item.id);
    selectedIds.value = selectedIds.value.filter(id => !pageIds.includes(id));

    // ✅ ลบออกจาก selectedProducts ด้วย
    selectedProducts.value = selectedProducts.value.filter(p => !pageIds.includes(p.id));

    console.log('🚫 Deselected selectedIds:', pageIds);

    paginatedProducts.value.forEach(item => {
      item.amount = 0;
    });
  }
}



// ใช้ได้ 100 %
function handleCheckboxChange(item, event) {

  // ถ้า stock = 0 ให้ยกเลิกการติ๊ก และไม่ทำอะไร
  if (item.stock === 0) {
    event.target.checked = false;
    item.amount = 0; // ป้องกัน amount ถูกเพิ่ม
    Swal.fire({
      icon: 'warning',
      title: 'รายการสินค้าหมด',
      text: `ไม่สามารถเลือก "${item.erp_title}" ได้ เนื่องจากสินค้าหมด`,
    });

    return;
  }

  if (event.target.checked) {
    // ติ๊กเลือก
    console.log(`✅ Selected item:`, item)
    selectedIds.value.push(item.id)

    // บังคับให้ค่าในตารางเปลี่ยนทันที
    // 1) บังคับให้ amount = 1
    if (!item.amount || item.amount === 0) {
      item.amount = 1;
    }


    // เก็บ id
    if (!selectedIds.value.includes(item.id)) {
      selectedIds.value.push(item.id);
    }

    // เก็บ object ไว้ใน selectedProducts
    if (!selectedProducts.value.find(p => p.id === item.id)) {
      selectedProducts.value.push({ ...item })
      // selectedProducts.value.push(item)    // เอา item ตรงๆ มาเก็บ ไม่ต้อง ...item
    }

  } else {
    // ยกเลิก
    console.log(`❌ Deselected item:`, item)
    item.amount = 0;
    selectedIds.value = selectedIds.value.filter(id => id !== item.id)
    selectedProducts.value = selectedProducts.value.filter(p => p.id !== item.id)
  }
}


function onlyNumberInput(event) {
  const key = event.key;
  // อนุญาตเฉพาะตัวเลข 0-9 เท่านั้น
  if (!/^\d$/.test(key)) {
    event.preventDefault();
  }
}

function validateAmount(item) {
   //Start แก้ไขปิดตัวของ ValidateAmount ได้
  // บังคับขอบเขต
  if (item.amount < 0) item.amount = 0
  if (item.amount > item.stock) item.amount = item.stock
  // End

  const isAlreadySelected = selectedIds.value.includes(item.id)

  if (item.amount > 0 && !isAlreadySelected) {
    // ถ้ายังไม่ถูกติ๊ก ให้ติ๊ก
    selectedIds.value.push(item.id)
    selectedProducts.value.push({ ...item })
    console.log(`🖊️ Auto-checked because amount>0:`, item)
  }

  //Start แก้ไขปิดตัวของ ValidateAmount ได้
  if (item.amount === 0 && isAlreadySelected) {
    // ถ้าลบเหลือ 0 ให้ยกเลิกติ๊ก
    selectedIds.value = selectedIds.value.filter(id => id !== item.id)
    selectedProducts.value = selectedProducts.value.filter(p => p.id !== item.id)
    console.log(`🗑️ Auto-unticked because amount=0:`, item)
  }
  //End

  // 2) อัปเดต amount ใน selectedProducts ด้วย
  const idx = selectedProducts.value.findIndex(p => p.id === item.id)
  if (idx !== -1) {
    selectedProducts.value[idx].amount = item.amount
  }
  console.log(`✅ Updated amount for ${item.erp_title}:`, item.amount)
}

const searchSku = async () => {
  clearTimeout(searchTimer.value);

  isLoading.value = true;
  isnotData.value = false;
  pageCurrent.value = 1;

  const gettoken = localStorage.getItem('token');
  console.log("gettoken:", gettoken);

  if (!keyword_sku_no.value.trim()) {

    if (!gettoken) {
      Swal.fire({
        toast: '❌ กรุณาทำการเลือกร้านค้าของลูกค้าก่อนทำการเพิ่มข้อมูล',
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

    try {
      // const response = await axios.post(`${BASE_URL}/Goods2/product`, {
      const response = await axios.post(`${BASE_URL}/Goods2/product2f`, {
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
      isLoading.value = false;
      isnotData.value = true;

    } catch (err) {0
      console.error("searchSku error:", err);
    }
  } else {
    try {

      if (!gettoken) {
        Swal.fire({
          toast: '❌ กรุณาทำการเลือกร้านค้าของลูกค้าก่อนทำการเพิ่มข้อมูล',
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

      isLoading.value = true;

      // const response = await axios.post(`${BASE_URL}/Goods2/product`, {
      const response = await axios.post(`${BASE_URL}/Goods2/product2f`, {
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

      isLoading.value = false;


    } catch (err) {
      console.error("searchSku error:", err);
      isLoading.value = false;

    }
  }
};

async function SearchProducstSubmit() {

  isLoading.value = true;

  const gettoken = localStorage.getItem('token');
  console.log("log value token:", gettoken);

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

    pageCurrent.value = 1;

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

      // const response = await axios.post(`${BASE_URL}/Goods2/product`, raw, {
      const response = await axios.post(`${BASE_URL}/Goods2/product2f`, raw, {
        headers: { 'Content-Type': 'application/json' }
      });

      // console.log("API Response ทั้งหมด:", response.data);
      // console.log("API Response ทั้งหมด:", response.data.data.data2);

      const searchProducts = response.data.data.data2;

      console.log("searchProducts:", searchProducts);


      // const getData



      if (response.data.code !== 1) {
        isLoading.value = false;
        console.log("if  isLoading.value = false;");
        // console.error("ค้นหาไม่สำเร็จ:", response.data.msg);
      }


      if (response.data.code === 1) {
        const data = response.data.data;
        const searchProducts = data.data2 || [];

        tableData.value = searchProducts;

        // hydrate ค่าเดิมเข้า tableData
        tableData.value.forEach(item => {
          const old = selectedProducts.value.find(p => p.id === item.id);
          if (old) {
            item.amount = old.amount;
            if (!selectedIds.value.includes(item.id)) {
              selectedIds.value.push(item.id);
            }
          }
        });
        // console.log("tableData หลัง hydrate:", tableData.value);
        // หลัง tableData.value = searchProducts;
        // tableData.value.forEach(item => {
        //   const old = selectedProducts.value.find(p => p.id === item.id)
        //   if (old) {
        //     item.amount = old.amount
        //     if (!selectedIds.value.includes(item.id)) {
        //       selectedIds.value.push(item.id)
        //     }
        //   }
        // })

        // tableData.value = searchProducts.map(item => ({
        //   ...item,
        //   imageLoaded: false
        // }));

        dataselect.value = searchProducts;
        total.value = data.item_count || 0;
        pageCurrent.value = 1;

        console.log("✅ ข้อมูล searchProducts:", searchProducts);

        // console.log('ข้อมูลที่ค้นเจอ:', data.data2);
        isLoading.value = false; // โหลดเสร็จ
      } else if (!gettoken) {

        console.log('check log token: ', gettoken);

        Swal.fire({
          toast: '❌ กรุณาทำการเลือกร้านค้าของลูกค้าก่อนทำการเพิ่มข้อมูล',
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
      pageCurrent.value = 1;

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

      // const response = await axios.post(`${BASE_URL}/Goods2/product`, raw, {
      const response = await axios.post(`${BASE_URL}/Goods2/product2f`, raw, {
        headers: { 'Content-Type': 'application/json' }
      });

      // console.log("API Response ทั้งหมด:", response.data);
      // console.log("API Response ทั้งหมด:", response.data.data.data2);

      const searchProducts = response.data.data.data2;

      console.log("searchProducts:", searchProducts);


      // const getData

      if (response.data.code !== 1 || response.data.msg === 'ตัวของ รายการสินค้ายังไม่ถูกเปิดขาย') {

        if(response.data.msg === 'ตัวของ รายการสินค้ายังไม่ถูกเปิดขาย'){
          Swal.fire({
            title: 'ค้นหาไม่สำเร็จ',
            text: response.data.msg || 'เกิดข้อผิดพลาด',
            icon: 'warning'
          });
          isLoading.value = false;
          pageCurrent.value = 1;
        }

        // isLoading.value = false;
        console.log("else  isLoading.value = false ssss;");
        isnotData.value = true;

        setTimeout(() => {
          total.value = [];
          pageCurrent.value = 1;
        }, 500);

        // console.error("massgae error:", response.data.msg);
      }

      if (response.data.code === 1) {
        const data = response.data.data;
        const searchProducts = data.data2 || [];

        tableData.value = searchProducts;

        // hydrate ค่าเดิมเข้า tableData
        tableData.value.forEach(item => {
          const old = selectedProducts.value.find(p => p.id === item.id);
          if (old) {
            item.amount = old.amount;
            if (!selectedIds.value.includes(item.id)) {
              selectedIds.value.push(item.id);
            }
          }
        });

        // tableData.value = searchProducts.map(item => ({
        //   ...item,
        //   imageLoaded: false
        // }));

        dataselect.value = searchProducts;
        total.value = data.item_count || 0;
        pageCurrent.value = 1;

        console.log("✅ ข้อมูล searchProducts:", searchProducts);

        // console.log('ข้อมูลที่ค้นเจอ:', data.data2);
        isLoading.value = false; // โหลดเสร็จ

      } else if (!gettoken) {

        console.log('check log token: ', gettoken);

        Swal.fire({
          toast: '❌ กรุณาทำการเลือกร้านค้าของลูกค้าก่อนทำการเพิ่มข้อมูล',
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

async function SearchProducstSubmitFirst() {

  isLoading.value = true;

  const gettoken = localStorage.getItem('token');
  console.log("log value token:", gettoken);

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

    // pageCurrent.value = 1;

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

      // const response = await axios.post(`${BASE_URL}/Goods2/product`, raw, {
      const response = await axios.post(`${BASE_URL}/Goods2/product2f`, raw, {
        headers: { 'Content-Type': 'application/json' }
      });

      // console.log("API Response ทั้งหมด:", response.data);
      // console.log("API Response ทั้งหมด:", response.data.data.data2);

      const searchProducts = response.data.data.data2;

      console.log("searchProducts:", searchProducts);


      // const getData

      if (response.data.code !== 1) {
        // isLoading.value = false;
        console.error("ค้นหาไม่สำเร็จ:", response.data.msg);
         isLoading.value = false;
        // return;
      }

      if (response.data.code === 1) {
        const data = response.data.data;
        const searchProducts = data.data2 || [];

        tableData.value = searchProducts;

        // hydrate ค่าเดิมเข้า tableData
        tableData.value.forEach(item => {
          const old = selectedProducts.value.find(p => p.id === item.id);
          if (old) {
            item.amount = old.amount;
            if (!selectedIds.value.includes(item.id)) {
              selectedIds.value.push(item.id);
            }
          }
        });
        // console.log("tableData หลัง hydrate:", tableData.value);
        // หลัง tableData.value = searchProducts;
        // tableData.value.forEach(item => {
        //   const old = selectedProducts.value.find(p => p.id === item.id)
        //   if (old) {
        //     item.amount = old.amount
        //     if (!selectedIds.value.includes(item.id)) {
        //       selectedIds.value.push(item.id)
        //     }
        //   }
        // })

        // tableData.value = searchProducts.map(item => ({
        //   ...item,
        //   imageLoaded: false
        // }));

        dataselect.value = searchProducts;
        total.value = data.item_count || 0;
        // pageCurrent.value = 1;

        console.log("✅ ข้อมูล searchProducts:", searchProducts);

        // console.log('ข้อมูลที่ค้นเจอ:', data.data2);
        isLoading.value = false; // โหลดเสร็จ
      } else if (!gettoken) {

        console.log('check log token: ', gettoken);

        Swal.fire({
          toast: '❌ กรุณาทำการเลือกร้านค้าของลูกค้าก่อนทำการเพิ่มข้อมูล',
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

      // const response = await axios.post(`${BASE_URL}/Goods2/product`, raw, {
      const response = await axios.post(`${BASE_URL}/Goods2/product2f`, raw, {
        headers: { 'Content-Type': 'application/json' }
      });

      // console.log("API Response ทั้งหมด:", response.data);
      // console.log("API Response ทั้งหมด:", response.data.data.data2);

      const searchProducts = response.data.data.data2;

      console.log("searchProducts:", searchProducts);


      // const getData

      if (response.data.code !== 1) {
        console.error("massgae error:", response.data.msg);
      }

      if (response.data.code === 1) {
        const data = response.data.data;
        const searchProducts = data.data2 || [];

        tableData.value = searchProducts;

        // hydrate ค่าเดิมเข้า tableData
        tableData.value.forEach(item => {
          const old = selectedProducts.value.find(p => p.id === item.id);
          if (old) {
            item.amount = old.amount;
            if (!selectedIds.value.includes(item.id)) {
              selectedIds.value.push(item.id);
            }
          }
        });

        // tableData.value = searchProducts.map(item => ({
        //   ...item,
        //   imageLoaded: false
        // }));

        dataselect.value = searchProducts;
        total.value = data.item_count || 0;
        // pageCurrent.value = 1;

        console.log("✅ ข้อมูล searchProducts:", searchProducts);

        // console.log('ข้อมูลที่ค้นเจอ:', data.data2);
        isLoading.value = false; // โหลดเสร็จ

      } else if (!gettoken) {

        console.log('check log token: ', gettoken);

        Swal.fire({
          toast: '❌ กรุณาทำการเลือกร้านค้าของลูกค้าก่อนทำการเพิ่มข้อมูล',
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

async function confirmSelection() {

  // ✅ ใช้งานได้เลยโดยไม่ต้อง .value
  console.log('🔥 selectedProducts_old:', props.selectProducts_old_month);

  let get_productOld_raw = (props.selectProducts_old_month || []).map(p => ({
    ...p,
    pro_sku_price_id: p.pro_id,
    pro_units: p.pro_unit,
    pro_image: p.pro_images,
    pro_goods_price: p.pro_unit_price

  }));

  // const get_productOld_raws = get_productOld_raw;

  console.log('🎯 get_productOld (ก่อนเช็ค stock):', get_productOld_raw);

  // ✅ ตรวจสอบว่ามีสินค้าใดใน get_productOld_raw ที่ไม่มี stock
  const missingStock = get_productOld_raw.some(x => x.pro_stock == null || x.pro_stock === undefined || x.pro_stock <= 0);

  if (missingStock) {
    console.warn('ขาด stock, เรียก API ดึง stock');

    try {
      const result = await submittedProduct_Stock(get_productOld_raw);

      console.log('result: ', result)
      get_productOld_raw = Array.isArray(result) ? result : [];

    } catch (error) {
      console.error('เกิดข้อผิดพลาดขณะดึง stock:', error);
      get_productOld_raw = []; // fallback ป้องกัน error ซ้ำ
    }
  }

  console.log('🎯 selectedProducts.value:', selectedProducts.value);

  const selectedProductsNew = selectedProducts.value.map(p => ({
    pro_activity_id: p.activity_id ?? 0,
    pro_goods_id: p.goods_id,
    pro_goods_price: p.price || p.goods_price,
    pro_sku_price_id: p.id,
    pro_goods_num: p.amount || 0,
    stock: p.stock || 0,
    pro_image: p.image,
    pro_erp_title: p.erp_title,
    pro_title: p.title,
    pro_code: p.activity_code || 0,
    pro_m_code: p.pro_m_code || 0,
    pro_sn: p.sn,
    pro_units: p.units,
  }));

  console.log('🎯🎯🎯 selectedProducts.value:', selectedProductsNew);

  // ใช้ได้
  // const selectedProducts = tableData.value
  //   .filter(p => selectedIds.value.includes(p.id))
  //   // .map(p => {
  //   .map(p => ({

  //     // return {
  //     pro_activity_id: p.activity_id ?? 0, // 1167
  //     // pro_id: p.activity_id, // 1167
  //     pro_goods_id: p.goods_id, // 13872
  //     pro_goods_price: p.price || p.goods_price, // "215.00"
  //     pro_sku_price_id: p.id, //sku_price_id // 50983
  //     pro_goods_num: p.amount || 0, // 1
  //     stock: p.stock || 0,
  //     // pro_quantity: p.quantity || 0, // 1
  //     pro_image: p.image, // /uploads/20240201/eaf550db288e6e947c8b3e70753f6a28.jpg
  //     pro_erp_title: p.erp_title, // "ADAPTER SET AG-201 FOR TYPE C TO LIGHTNING PD 20W BLUE DP"

  //     pro_title: p.title, // "ชุดอะแดปเตอร์เซ็ต AG-201 (20W)"
  //     pro_code: p.activity_code || 0, // x
  //     pro_m_code: p.pro_m_code || 0, // x
  //     // pro_goods_sku_text: p.goods_sku_text, //
  //     pro_sn: p.sn, //"2010102DP0057"
  //     pro_units: p.units, // "PCS"

  //   }));


  const sum_products = [
    ...(Array.isArray(get_productOld_raw) ? get_productOld_raw : []),
    ...selectedProductsNew
  ];

  // const sum_products = [...get_productOld_raw, ...selectedProducts];

  console.log('Check: sum_products', sum_products);

  function groupBy(arr, keyFn) {
    return arr.reduce((acc, item) => {
      const groupKey = typeof keyFn === 'function' ? keyFn(item) : item[keyFn];
      // const quantity = Number(item.pro_goods_num ?? item.pro_quantity ?? 0);

      // ดึงจำนวนสินค้า โดย fallback เป็น 0 และแปลงเป็น int
      const quantity =
        Number(item.pro_goods_num) || Number(item.pro_quantity) || 0;

      if (!acc[groupKey]) {
        // ✅ เปลี่ยนชื่อ pro_images → pro_image ที่นี่
        acc[groupKey] = {
          ...item,
          pro_goods_num: quantity,
          pro_quantity: quantity,
          last_quantity: quantity,
          pro_goods_id: item.pro_goods_id || item.goods_id, // pro_goods_id
          // last_quantity: 0, // เริ่มจาก 0 ก่อน
          pro_erp_title: item.pro_erp_title || item.erp_title || item.title,
          pro_image: item.pro_images || item.pro_image || '', // ✅ ตั้งชื่อใหม่
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



  // // 🔁 รวมสินค้า "ธรรมดา" กับ "โปรโมชัน" ที่เป็นสินค้าเดียวกัน (pro_sku_price_id ตรงกัน)
  // const mergedProductsMap = new Map();

  // // const hasPromo = (data) =>
  // //   data.pro_activity_id !== undefined &&
  // //   data.pro_activity_id !== null &&
  // //   data.pro_activity_id !== 0 &&
  // //   data.pro_activity_id !== "0";

  // // วน loop ทีละตัว
  // for (const item of sum_products) {
  //   const key = item.pro_sku_price_id;

  //   // เช็คว่าเจอสินค้านี้แล้วหรือยัง (จากธรรมดาหรือโปรฯ ก่อนหน้า)
  //   if (!mergedProductsMap.has(key)) {
  //     mergedProductsMap.set(key, { ...item }); // ถ้ายังไม่มีก็ set ใหม่เลย
  //   } else {
  //     const existing = mergedProductsMap.get(key);

  //     // ✅ เงื่อนไข: ถ้าอันหนึ่งเป็นสินค้าธรรมดา (ไม่มีโปร_activity_id) และอีกอันมี → ให้รวม
  //     if (
  //       (!existing.pro_activity_id && item.pro_activity_id) ||
  //       (existing.pro_activity_id && !item.pro_activity_id)
  //       // (hasPromo(existing) && !hasPromo(item)) ||
  //       // (!hasPromo(existing) && hasPromo(item))
  //     ) {
  //       // รวมจำนวน
  //       const totalQty =
  //         (Number(existing.pro_goods_num) || 0) +
  //         (Number(item.pro_goods_num) || 0);

  //       // คัดลอกค่าโดยอิงจากตัวที่เป็นโปรโมชันไว้เป็นหลัก
  //       const promoData = existing.pro_activity_id ? existing : item;
  //       // const promoData = hasPromo(item) ? item : existing;

  //       // ✅ บันทึกกลับโดยใช้ข้อมูลของโปรโมชัน พร้อมจำนวนรวม
  //       mergedProductsMap.set(key, {
  //         ...promoData,
  //         pro_goods_num: totalQty,
  //         pro_quantity: totalQty,
  //         last_quantity: Number(item.pro_goods_num || 0), // เก็บจำนวนของอันล่าสุด (ไว้เช็ค stock)
  //         st: true // ✔️ ให้เป็นสินค้าพร้อมโปร
  //       });
  //     } else {
  //       // ถ้าไม่เข้าเงื่อนไข (เป็นของประเภทเดียวกันทั้งคู่) ก็รวมจำนวนปกติ
  //       const totalQty =
  //         (Number(existing.pro_goods_num) || 0) +
  //         (Number(item.pro_goods_num) || 0);

  //       mergedProductsMap.set(key, {
  //         ...existing,
  //         pro_goods_num: totalQty,
  //         pro_quantity: totalQty
  //       });
  //     }
  //   }
  // }

  // // เปลี่ยนกลับเป็น array
  // const mergedProducts = Array.from(mergedProductsMap.values());

  // console.log('✅ 🔄 mergedProducts (หลังรวมสินค้าธรรมดา+โปร):', mergedProducts);


  ///////////////////////////////
  const productErrors = [];

  // สร้าง grouped ทั้งหมดจาก sum_products
  // const grouped = groupBy(mergedProducts, item => `${item.pro_activity_id}_${item.pro_sku_price_id}`); //
  const grouped = groupBy(sum_products, item => `${item.pro_activity_id}_${item.pro_sku_price_id}`); //

  // แยก grouped สำหรับ last_quantity เก็บจาก selectedProducts (รายการเพิ่มใหม่)
  const groupedLastQuantity = groupBy(selectedProductsNew, item => `${item.pro_activity_id}_${item.pro_sku_price_id}`); //
  console.log('🔹 grouped:', grouped);
  console.log('🔹 groupedArray:', groupedLastQuantity);

  // ✅ สร้าง validateGrouped ใหม่ โดยใช้ key เป็น pro_activity_id + pro_sku_price_id
  const validateGrouped = Object.values(
    sum_products.reduce((acc, item) => {
      const key = `${item.pro_activity_id}_${item.pro_sku_price_id}`;
      console.log('🔸 Reduce item:', item);
      if (!acc[key]) {
        acc[key] = {
          ...item,
          pro_goods_num: Number(item.pro_goods_num || item.pro_quantity) || 0
          // pro_quantity: Number(item.pro_goods_num || item.pro_quantity) || 0
        };
        console.log(`🟢 New key added: ${key}`, acc[key]);
      } else {
        acc[key].pro_goods_num += Number(item.pro_goods_num || item.pro_quantity) || 0;
        console.log(`🔁 Updated key: ${key}`, acc[key]);
      }
      return acc;
    }, {})
  );

  console.log('✅ validateGrouped:', validateGrouped);

  //ตรวจสอบ stock แยกตาม pro_activity_id + pro_sku_price_id
  validateGrouped.forEach(product => {
    const totalQuantity = product.pro_goods_num || 0;
    const stockAvailable = Number(product.pro_stock ?? product.stock ?? 0); // ใช้ pro_stock หรือ stock

    // const key = `${product.pro_activity_id}_${product.pro_sku_price_id}`;
    // const lastQuantity = grouped[key]?.last_quantity || 0;

    const key = `${product.pro_activity_id}_${product.pro_sku_price_id}`; // Key ซ้ำกันแต่ไม่เหมือนกันจริง
    // const key = `${product.pro_activity_id?.toString()}_${product.pro_sku_price_id?.toString()}`; //แก้เป็น string

    // ใช้ last_quantity จาก groupedLastQuantity แทน grouped
    const lastQuantity = groupedLastQuantity[key]?.last_quantity || 0;

    console.log(`🧮 Checking product: ${product.pro_erp_title || product.pro_title}`, {
      totalQuantity,
      stockAvailable,
      lastQuantity
    });

    //Start แก้ไขปิดตัวของ ValidateAmount ได้
    if (totalQuantity > stockAvailable) {
      // if (totalQuantity > stockAvailable) {
      productErrors.push({
        title: product.pro_erp_title || product.pro_title || '(ไม่มีชื่อ)',
        quantity: totalQuantity,
        quantity_plus: lastQuantity,
        stock: stockAvailable
      });
      console.warn('❌ Stock not enough:', product);
    }
    //End แก้ไขปิดตัวของ ValidateAmount ได้
  });

   //Start แก้ไขปิดตัวของ ValidateAmount ได้
  if (productErrors.length > 0) {
    const messages = productErrors.map(p =>
      `• ${p.title} (ขอเพิ่มล่าสุด: ${p.quantity_plus}, รวม: ${p.quantity}, คลังมี: ${p.stock})`
    ).join('<br>');

    Swal.fire({
      icon: 'error',
      title: 'สินค้าเกินจากสต๊อก',
      // text: 'กรุณาตรวจสอบรายการสินค้า:\n' + messages ,
      html: 'กรุณาตรวจสอบรายการสินค้า:<br>' + messages,
      confirmButtonText: 'ตกลง'
    });

    console.error('🛑 ส่งข้อมูลถูกยกเลิกเพราะสินค้าเกินสต๊อก');
    return; // ❌ หยุดการส่งข้อมูล
  }

  //End แก้ไขปิดตัวของ ValidateAmount ได้

  console.log('✅ สินค้าทั้งหมดผ่านการตรวจสอบ stock');

  const newproduct = [];

  Object.values(grouped).forEach(item => {
    newproduct.push(item);
  });


  console.log('✅ Grouped  resultnewproduct:', newproduct);
  console.log('✅ Grouped  result groupedArray:', groupedLastQuantity);

  // const selectedPromotionsInfo = props.selectedPromotion.map(p => ({

  //   pro_m_id: p.pro_m_id, //pro_m_id: 1176
  //   pro_m_title: p.pro_m_title,
  //   pro_acm_id: p.pro_acm_id,
  //   pro_m_images: p.pro_m_images,

  // }))


  // console.log("✅ selectedProducts ถูกแปลงแล้ว:", selectedProducts);
  // console.log("✅ selectedPromotionsInfo ถูกแปลงแล้ว:", selectedPromotionsInfo);

  console.log('Check: grouped 800 : ', newproduct);

  // return;

  SelectProductProMonth(newproduct);

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
      // console.error("ค้นหาสินค้าไม่สำเร็จ:", response.data.msg);
      console.error("massgae error:", response.data.msg);
    }

    if (response.data.code === 1) {
      const data = response.data.data.products || [];
      const datasumdiscount = response.data.data;

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
        stock: p.stock || 0,
        // stock: p.stock || 0,
      }));

      console.log("🤯🤯 Log emitTitles:", emitTitles);

      // const emitTitles = data.map(item => item.pro_title || item.pro_erp_title).join(', ');
      // ใช้ได้
      console.log("✅ Items:", items);
      console.log("✅ Gifts:", gifts);
      console.log("✅ Promotions:", promotions);

      // ใช้ได้
      console.log("🔁 Emit กลับไปหน้า parent:", { items, gifts, promotions, emitTitles, datasumdiscount });
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
        emitTitles,
        datasumdiscount
      });

      emit('close'); //

      isLoading.value = false; // โหลดเสร็จ
    } else if (!gettoken) {

      console.log('check log token: ', gettoken);

      Swal.fire({
        toast: '❌ กรุณาทำการเลือกร้านค้าของลูกค้าก่อนทำการเพิ่มข้อมูล',
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


async function submittedProduct_Stock(payload) {
  // async function submittedProduct(selectedProducts) {
  // isLoading.value = true; // เริ่มโหลด

  const gettoken = localStorage.getItem('token');
  // ดึงชื่อสินค้าทั้งหมดออกมา (เป็น array ของชื่อ)
  // const selectedTitles = selectedProducts.map(p => p.pro_title || p.pro_erp_title );

  console.log("grouped 823:", payload);
  // console.log("selectedProducts:", selectedProducts);

  // return;

  try {
    const response = await axios.post(
      `${BASE_URL}/cart_out/index`,
      {
        products: payload, // ส่งข้อมูลที่เลือกไปยัง API
        // products: selectedProducts, // ส่งข้อมูลที่เลือกไปยัง API
      },
      {

        headers: {
          'Content-Type': 'application/json',
          'token': gettoken
        }
      }
    );

    console.log("✅ Response from API:", response);

    // return;

    if (response.data.code !== 1) {
      throw new Error(response.data.message || 'API ดึง stock ผิดพลาด');
    }

    if (response.data.code === 1) {
      const data = response.data.data.products || [];

      console.log("Check Value data:", data);

      // ใช้ได้
      // แยกข้อมูลออกเป็น 3 ก้อน //  ,
      const items = data.filter(item => item.pro_goods_id !== 0 && item?.ML_Note === 'item' || item?.ML_Note === 'itemmonth');
      const gifts = data.filter(item => item.pro_goods_id !== 0 && item?.ML_Note === 'zengsopng_day' || item?.ML_Note === 'zengsopng_month');
      const promotions = data.filter(item => item.pro_activity_id !== 0 && item?.ML_Note === 'promotion_day' || item?.ML_Note === 'promotion_month');

      const emitTitles = payload.map(p => ({
        // const emitTitles = selectedProducts.map(p => ({
        pro_goods_id: p.pro_goods_id || 0,
        pro_activity_id: p.pro_activity_id || 0,
        pro_title: p.pro_title || '(ไม่มีชื่อ)', //p.pro_erp_title ||
        pro_erp_title: p.pro_erp_title || p.pro_title || '(ไม่มีชื่อ)',
        pro_goods_price: p.pro_goods_price || 0,
        pro_sku_price_id: p.pro_sku_price_id || 0,
        pro_sn: p.pro_sn || '',
        pro_units: p.pro_units || '',
        amount: p.pro_goods_num || 0,
        stock: p.stock || 0,
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

      console.log("📤 กำลัง selectPromotionProducts");

      const processedData = [];

      for (const item of items) {

        console.log("➡ กำลังวนลูปที่ item:", item);

        const activityId = item.st === false ? false : item.pro_activity_id;
        const matchedTitle = emitTitles.find(emit => emit.pro_goods_id == item.pro_goods_id && emit.pro_sku_price_id == item.pro_sku_price_id) || {};

        // const filteredGifts = gifts.filter(gift => gift.pro_activity_id !== item.pro_activity_id ? item.pro_activity_id : gift.pro_activity_id);
        // const filteredPromotions = promotions.filter(promo => promo.pro_activity_id !== item.pro_activity_id ? item.pro_activity_id : promo.pro_activity_id)

        const fullActivityGifts = gifts.filter(gift => gift.pro_activity_id === item.pro_activity_id && gift.st === item.st);
        const fullActivityPromotions = promotions.filter(promo => promo.pro_activity_id === item.pro_activity_id && promo.st === item.st)

        const FinalPromotions = promotions.filter(promo => {
          const stMatch = promo.st === item.st;

          if (item.st === true) {
            return stMatch && promo.pro_activity_id === item.pro_activity_id;
          } else {
            return stMatch;
          }
        });

        const FinalGifts = gifts.filter(gift => {
          const stMatch = gift.st === item.st;

          if (item.st === true) {
            return stMatch && gift.pro_activity_id === item.pro_activity_id;
          } else {
            return stMatch;
          }
        });


        const FinalGifts_Not_activuty = fullActivityGifts.filter(
          // gift => gift.pro_activity_id === item.pro_activity_id
          gift => gift.pro_activity_id === item.pro_activity_id && Boolean(gift.st) === Boolean(item.st)
          // gift => gift.pro_activity_id === promotionActivityId && gift.pro_sku_price_id == item.pro_sku_price_id
        );

        const FinalPromotions_Not_activuty = fullActivityPromotions.filter(
          // promo => promo.pro_activity_id === item.pro_activity_id
          promo => promo.pro_activity_id === item.pro_activity_id || promo.st !== item.st
        );
        // หา item ที่ pro_sn เดียวกันแต่ activity ต่างกัน
        const similarItem = tableData.value.find(sp =>
          sp.pro_sn === (matchedTitle.pro_sn || item.pro_sn) &&
          sp.activity_id !== activityId
        );

        const activity_id_ItemIsok = tableData.value.find(sp =>
          sp.pro_sn === (matchedTitle.pro_sn || item.pro_sn) &&
          sp.activity_id !== activityId &&
          sp.st === item.st
        );

        const activity_id_ItemIs_Not_ok = tableData.value.find(sp =>
          sp.pro_sn === (matchedTitle.pro_sn || item.pro_sn) &&
          sp.activity_id !== activityId &&
          sp.st !== item.st
        );

        //หา item ที่ activity_id เดียวกันและ st เหมือนกัน
        const alreadyExists = tableData.value.find(sp =>
          sp.pro_id === item.pro_sku_price_id &&
          sp.activity_id === activityId &&
          // sp.st === item.st
          sp.st === item.st
        );


        const caseType = (() => {
          if (tableData.value.length === 0) return 'EMPTY';
          if (activity_id_ItemIs_Not_ok) return 'ACTIVITY_ID_ITEM_IS_Not_OK';
          if (activity_id_ItemIsok) return 'ACTIVITY_ID_ITEM_ISOK';
          // if (similarItem || alreadyExists) return 'ACTIVITY_NOT_LOOP';
          if (alreadyExists) return 'EXISTS';
          if (similarItem) return 'SIMILAR_SN_DIFFERENT_ACTIVITY';


          return 'NEW';
        })();

        switch (caseType) {
          case 'EMPTY':
          case 'NEW':
            processedData.push({
              item_id: 0,
              pro_id: item.pro_sku_price_id,
              activity_id: activityId,
              pro_activity_id: item.pro_activity_id,
              pro_goods_id: item.pro_goods_id,
              // pro_activity_id: item.pro_activity_id,
              st: item.st,
              pro_erp_title: matchedTitle.pro_erp_title === 0 ? matchedTitle.pro_title : matchedTitle.pro_erp_title || item.pro_erp_title || '',
              pro_title: matchedTitle.pro_title,
              // pro_erp_title: matchedTitle.pro_erp_title && matchedTitle.pro_erp_title === 0 || item.pro_erp_title || '',
              pro_unit_price: item.pro_goods_price || '',
              pro_goods_sku_text: item.pro_goods_sku_text || '',
              pro_sn: matchedTitle.pro_sn || item.pro_sn || '',
              prosn: item.prosn || '',
              pro_images: item.pro_image || '',
              pro_quantity: item.pro_goods_num || 0,
              pro_goods_num: item.pro_goods_num || 0,
              pro_units: matchedTitle.pro_units || item.pro_units || '',
              stock: item.stock || 0,

              pro_sku_price_id: item.pro_sku_price_id,

              // กรองเฉพาะของที่ activity_id ตรงกัน
              gifts: FinalGifts,
              promotions: FinalPromotions,

            });
            console.log('NEW || EMPTY');
            break;

          case 'EXISTS':
            Object.assign(alreadyExists, {
              ...item,
              pro_id: item.pro_sku_price_id,
              activity_id: activityId,
              pro_quantity: item.pro_goods_num,
              pro_goods_num: item.pro_goods_num,
              gifts: FinalGifts,
              promotions: FinalPromotions

              // เพิ่มค่าอื่น ๆ ที่จำเป็น
            });

            console.log('EXISTS');

            Swal.fire({
              icon: 'info',
              title: 'เพิ่มจำนวนข้อมูลสินค้าสำเร็จ',
              text: `เพิ่มข้อมูลสินค้าเรียบร้อย ${matchedTitle.pro_erp_title || item.pro_title || ''}`,
            });
            processedData.push(alreadyExists);
            break;
          case 'ACTIVITY_ID_ITEM_ISOK':
            Object.assign(activity_id_ItemIsok, {
              ...item,
              pro_id: item.pro_sku_price_id,
              activity_id: activityId,
              pro_quantity: item.pro_goods_num,
              pro_goods_num: item.pro_goods_num,
              gifts: FinalGifts, //fullActivityGifts ||
              promotions: FinalPromotions, //
              // เพิ่มค่าอื่น ๆ ที่จำเป็น
            });

            console.log('ACTIVITY_ID_ITEM_ISOK');

            Swal.fire({
              icon: 'info',
              title: 'เพิ่มจำนวนข้อมูลสินค้าสำเร็จ',
              text: `เพิ่มข้อมูลสินค้าเรียบร้อย ${matchedTitle.pro_erp_title || item.pro_title || ''}`,
            });

            processedData.push(activity_id_ItemIsok);
            break;
          case 'ACTIVITY_ID_ITEM_IS_Not_OK':
            Object.assign(activity_id_ItemIs_Not_ok, {
              ...item,
              pro_id: item.pro_sku_price_id,
              activity_id: activityId,
              pro_quantity: item.pro_goods_num,
              pro_goods_num: item.pro_goods_num,
              gifts: FinalGifts_Not_activuty,
              promotions: FinalPromotions_Not_activuty,
              // เพิ่มค่าอื่น ๆ ที่จำเป็น
            });

            console.log('ACTIVITY_ID_ITEM_IS_Not_OK');

            Swal.fire({
              icon: 'info',
              title: 'เพิ่มจำนวนข้อมูลสินค้าสำเร็จ',
              text: `เพิ่มข้อมูลสินค้าเรียบร้อย ${matchedTitle.pro_erp_title || item.pro_title || ''}`,
            });

            processedData.push(activity_id_ItemIs_Not_ok);


            break;

        }
      }

      console.log('processedData: ', processedData);

      return processedData;

    } else {
      error.value = response.data.message || 'เกิดข้อผิดพลาด';
    }
  } catch (err) {
    error.value = err.message || 'โปรดลองใหม่ภายหลัง';
  } finally {
    // isLoading.value = false; // โหลดเสร็จ
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
  SearchProducstSubmitFirst(); // โหลดสินค้าทั้งหมดรอบแรก
  // SearchProducstSubmit(); // โหลดสินค้าทั้งหมดรอบแรก

  // if (props.selectProducts_old_month?.length) {
  //   selectedProducts.value = props.selectProducts_old_month.map(p => ({
  //     // ต้อง map ให้มีฟิลด์ id, amount, stock, units, price, erp_title, etc
  //     id: p.pro_sku_price_id,
  //     amount: p.pro_goods_num,
  //     stock: p.pro_stock,
  //     goods_id: p.pro_goods_id || p.goods_id,
  //     pro_goods_id: p.pro_goods_id || p.goods_id,
  //     units: p.pro_units,
  //     price: p.pro_unit_price,
  //     erp_title: p.pro_erp_title,
  //     sn: p.pro_sn,
  //     image: p.pro_image,
  //     title: p.pro_title,
  //     // …ใส่ field ที่คุณใช้ต่อไปใน confirmSelection() ให้ครบ
  //   }))
  //   // และให้ selectedIds สะท้อน id เหล่านั้นด้วย
  //   selectedIds.value = selectedProducts.value.map(p => p.id)
  // }



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



<!-- // function เลือกสินค้าทั้งหมด
// function toggleSelectAll(event) {

//   console.log('✅ Check event:', event);

//   if (event.target.checked) {
//     const pageIds = [];
//     paginatedProducts.value.forEach(item => {
//       if (item.stock > 0) {
//         item.amount = 1; // กำหนดจำนวนให้เท่ากับ stock
//         pageIds.push(item.id);    // เพิ่มเฉพาะ id ที่ stock > 0
//       } else {
//         item.amount = 0; // ถ้า stock ≤ 0 ให้ใส่เป็น 0
//       }
//     });


//     selectedIds.value = [...new Set([...selectedIds.value, ...pageIds])];

//     console.log('✅ toggleSelectAll selectedIds (stock > 0 only):', pageIds);
//   } else {
//     const pageIds = paginatedProducts.value.map(item => item.id);
//     selectedIds.value = selectedIds.value.filter(id => !pageIds.includes(id));
//     console.log('🚫 Deselected selectedIds:', pageIds);

//     // เคลียร์ amount ตอนยกเลิกติ๊ก ถ้าต้องการ
//     paginatedProducts.value.forEach(item => {
//       item.amount = 0;
//     });
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
// } -->


<!-- // function handleCheckboxChange(item, event) {
//   if (item.stock === 0) {
//     event.target.checked = false; // ยกเลิกติ๊ก
//     Swal.fire({
//       icon: 'warning',
//       title: 'รายการสินค้าหมด',
//       text: `ไม่สามารถเลือก "${item.erp_title}" ได้ เนื่องจากสินค้าหมด`,
//     });
//     return;
//   }

//   if (event.target.checked) {
//     if (!selectedIds.value.includes(item.id)) {
//       selectedIds.value.push(item.id);
//       if (!item.amount || item.amount === 0) {
//         item.amount = 1; // เพิ่มจำนวนถ้ายังไม่กำหนด
//       }
//     }
//   } else {
//     selectedIds.value = selectedIds.value.filter(id => id !== item.id);
//     item.amount = 0;
//   }
// }
 -->



<!--
// เคยใช้ได้
// function validateAmount(item) {
//   if (item.amount < 0) {
//     item.amount = 0;
//   } else if (item.amount > item.stock) {
//     item.amount = item.stock;
//   }

//   // logic ติ๊ก checkbox อัตโนมัติ
//   if (item.amount > 0) {
//     if (!selectedIds.value.includes(item.id)) {
//       selectedIds.value.push(item.id);
//     }
//   } else {
//     // ถ้าใส่ 0 หรือลบออก ให้เอาออกจาก selectedIds
//     selectedIds.value = selectedIds.value.filter(id => id !== item.id);
//   }

// } -->





<!-- // function confirmSelection() {

//   console.log('🔥 selectedProducts_old:', props.selectProducts_old_month);

//   const get_productOld_raw = (props.selectProducts_old_month || []).map(p => ({ ...p }));

//   console.log('🎯 get_productOld:', get_productOld_raw);

//   const selectedProducts = tableData.value
//     // const selectedProducts = props.productList
//     .filter(p => selectedIds.value.includes(p.id))
//     .map(p => ({
//       pro_activity_id: p.activity_id ?? 0, // 1167
//       pro_goods_id: p.goods_id, // pro_goods_id
//       pro_sku_price_id: p.id, // pro_sku_price_id
//       pro_erp_title: p.erp_title,
//       pro_title: p.title, // "ชุดอะแดปเตอร์เซ็ต AG-201 (20W)"
//       pro_sn: p.sn,
//       pro_image: p.image, // pro_image
//       pro_goods_num: p.amount || 0, // pro_goods_num
//       pro_quantity: p.amount || 0,

//       pro_goods_price: p.price, // "215.00"
//       pro_units: p.units,
//       stock: p.stock || 0,

//     }));


//   const sum_products = [...get_productOld_raw, ...selectedProducts];

//   console.log('Check: sum_products', sum_products);

//   function groupBy(arr, keyFn) {
//     return arr.reduce((acc, item) => {
//       const groupKey = typeof keyFn === 'function' ? keyFn(item) : item[keyFn];

//       // ดึงจำนวนสินค้า โดย fallback เป็น 0 และแปลงเป็น int
//       const quantity =
//         Number(item.pro_goods_num) || Number(item.pro_quantity) || 0;

//       if (!acc[groupKey]) {
//         // ✅ เปลี่ยนชื่อ pro_images → pro_image ที่นี่
//         acc[groupKey] = {
//           ...item,
//           pro_goods_num: quantity,
//           pro_quantity: quantity,
//           last_quantity: quantity,
//           // last_quantity: 0, // เริ่มจาก 0 ก่อน
//           pro_erp_title: item.pro_erp_title || item.erp_title || item.title,
//           pro_image: item.pro_images || item.pro_image || '', // ✅ ตั้งชื่อใหม่
//           pro_goods_price: item.pro_goods_price || item.pro_unit_price, // ✅ ตั้งชื่อใหม่
//           activity_id: item.activity_id || 0
//         };

//         // ❌ ลบ key เดิมถ้าไม่ต้องการให้ติดไปด้วย (เช่น pro_images)
//         delete acc[groupKey].pro_images;

//       } else {
//         // รวมจำนวนต่อจาก key เดิม
//         acc[groupKey].pro_goods_num =
//           Number(acc[groupKey].pro_goods_num) + quantity;
//         acc[groupKey].pro_quantity =
//           Number(acc[groupKey].pro_quantity) + quantity;
//       }

//       return acc;
//     }, {});
//   }

//   const productErrors = [];

//   const grouped = groupBy(sum_products, item => `${item.pro_activity_id}_${item.pro_sku_price_id}`);

//   // แยก grouped สำหรับ last_quantity เก็บจาก selectedProducts (รายการเพิ่มใหม่)
//   const groupedLastQuantity = groupBy(selectedProducts, item => `${item.pro_activity_id}_${item.pro_sku_price_id}`);
//   console.log('🔹 grouped:', grouped);
//   console.log('🔹 groupedArray:', groupedLastQuantity);

//   // ✅ สร้าง validateGrouped ใหม่ โดยใช้ key เป็น pro_activity_id + pro_sku_price_id
//   const validateGrouped = Object.values(
//     sum_products.reduce((acc, item) => {
//       const key = `${item.pro_activity_id}_${item.pro_sku_price_id}`;
//       console.log('🔸 Reduce item:', item);
//       if (!acc[key]) {
//         acc[key] = {
//           ...item,
//           pro_goods_num: Number(item.pro_goods_num || item.pro_quantity) || 0
//           // pro_quantity: Number(item.pro_goods_num || item.pro_quantity) || 0
//         };
//         console.log(`🟢 New key added: ${key}`, acc[key]);
//       } else {
//         acc[key].pro_goods_num += Number(item.pro_goods_num || item.pro_quantity) || 0;
//         console.log(`🔁 Updated key: ${key}`, acc[key]);
//       }
//       return acc;
//     }, {})
//   );

//   console.log('✅ validateGrouped:', validateGrouped);

//   //ตรวจสอบ stock แยกตาม pro_activity_id + pro_sku_price_id
//   validateGrouped.forEach(product => {
//     const totalQuantity = product.pro_goods_num || 0;
//     const stockAvailable = Number(product.pro_stock ?? product.stock ?? 0); // ใช้ pro_stock หรือ stock

//     // const key = `${product.pro_activity_id}_${product.pro_sku_price_id}`;
//     // const lastQuantity = grouped[key]?.last_quantity || 0;

//     const key = `${product.pro_activity_id}_${product.pro_sku_price_id}`;
//     // ใช้ last_quantity จาก groupedLastQuantity แทน grouped
//     const lastQuantity = groupedLastQuantity[key]?.last_quantity || 0;

//     console.log(`🧮 Checking product: ${product.pro_erp_title || product.pro_title}`, {
//       totalQuantity,
//       stockAvailable,
//       lastQuantity
//     });

//     if (totalQuantity > stockAvailable) {
//       productErrors.push({
//         title: product.pro_erp_title || product.pro_title || '(ไม่มีชื่อ)',
//         quantity: totalQuantity,
//         quantity_plus: lastQuantity,
//         stock: stockAvailable
//       });
//       console.warn('❌ Stock not enough:', product);
//     }
//   });

//   if (productErrors.length > 0) {
//     const messages = productErrors.map(p =>
//       `• ${p.title} (ขอเพิ่มล่าสุด: ${p.quantity_plus}, รวม: ${p.quantity}, คลังมี: ${p.stock})`
//     ).join('<br>');

//     Swal.fire({
//       icon: 'error',
//       title: 'สินค้าเกินจากสต๊อก',
//       // text: 'กรุณาตรวจสอบรายการสินค้า:\n' + messages ,
//       html: 'กรุณาตรวจสอบรายการสินค้า:<br>' + messages,
//       confirmButtonText: 'ตกลง'
//     });

//     console.error('🛑 ส่งข้อมูลถูกยกเลิกเพราะสินค้าเกินสต๊อก');
//     return; // ❌ หยุดการส่งข้อมูล
//   }

//   console.log('✅ สินค้าทั้งหมดผ่านการตรวจสอบ stock');

//   const newproduct = [];

//   Object.values(grouped).forEach(item => {
//     newproduct.push(item);
//   });


//   console.log('✅ Grouped  resultnewproduct:', newproduct);
//   console.log('✅ Grouped  result groupedArray:', groupedLastQuantity);

//   SelectProductProMonth(newproduct);

// } -->
