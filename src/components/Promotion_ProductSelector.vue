<template>
  <div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-[110]">
    <div class="bg-white z-20 rounded-lg shadow-lg p-6 w-[90%] max-w-6xl max-h-[90vh] overflow-y-auto">

      <!-- Search Section -->
      <div class="grid items-center ">
        <div class="flex items-center space-x-4">

          <!-- Search Icon -->
          <span class="material-icons text-gray-600" style="font-size: 28px;">search</span>
          <!-- Search Input -->
          <input
            class="w-full min-w-[200px] p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
            v-model="keyword" placeholder="ค้นหา..." @input="onInput" />
          <div>
            <button @click="$emit('close')" class="text-red-500 hover:text-gray-700 mb-16 text-4xl">&times;</button>
          </div>
        </div>

        <div class="flex flex-wrap md:flex-nowrap justify-between  items-center gap-4">

          <!-- เพิ่มปุ่มย้อนกลับ -->
          <button @click="goBackToPromotionSelector"
            class="text-purple-600 font-medium hover:text-purple-800 transition px-4 py-2 border  border-purple-600 hover:border-purple-600 rounded">
            ← ย้อนกลับ
          </button>

          <!-- Breadcrumb -->
          <!-- <nav class="text-sm text-gray-600 pb-4">
            <ul class="flex items-center space-x-1">
              <li>
                <router-link to="/dashboard" class="hover:text-purple-600 transition">Home</router-link>
                <span class="mx-1 text-gray-400">›</span>
              </li>
              <li>
                <router-link to="/createsalelist" @click.native="reloadPage"
                  class="text-purple-600 font-medium hover:text-purple-800 transition">
                  Create Sale List
                </router-link>
              </li>
            </ul>
          </nav> -->
        </div>
      </div>

      <div class="text-sm text-gray-500 mt-2">
        * สามารถค้นหาได้จากชื่อรายการสินค้าที่เข้าร่วมโปรโมชั่น, รหัสสินค้าที่ร่วมโปรโมชั่น
      </div>

      <!-- Header -->
      <div class="flex items-center mb-4 mt-2">
        <div class="flex-1">
          <h2 class="text-xl text-gray-700 font-bold">เลือกรายการสินค้าที่เข้าร่วมโปรโมชั่น</h2>
        </div>
        <div class="flex gap-4">
          <div class="text-sm font-semibold text-gray-500 mt-2">
            ประเภทสมาชิก: {{ memberType }}
          </div>
        </div>
      </div>

      <!-- Table Section -->
      <div class="overflow-x-auto mt-4">
        <table class="min-w-[1000px] w-full border text-sm">
          <thead class="bg-gray-100 text-gray-700">
            <tr>
              <th class="px-4 py-2 border text-center">
                <input type="checkbox" @change="toggleSelectAll" :checked="isAllSelected" />
              </th>
              <th class="px-4 py-2 border text-center">รูปภาพ</th>
              <th class=" px-4 py-2 border w-[500px]">ชื่อสินค้า (ERP)</th> <!-- w-[300px]-->
              <th class="px-4 border min-w-[220px] text-left">
                <div class="flex gap-1 items-stretch">
                  <input type="text" v-model="keyword_promotion_product_no" placeholder="ค้นหา โปรโมชั่น"
                    @focus="dropdownOpenIndex = 'header'" style="margin-top: 0 !important;"
                    class="flex-1 border border-gray-300 rounded-md focus:outline-none " />
                  <!--px-3 py-1.5 h-full h-full -->
                  <button @click="searchPromotion_no"
                    class="px-1.5 bg-blue-500 text-white rounded-md hover:bg-blue-600 whitespace-nowrap ">
                    ค้นหา
                  </button><!--px-3 py-1.5 -->
                </div>
              </th>

              <th class="px-4 py-2 border">รหัสสินค้า</th>
              <th class="px-4 py-2 border text-center">จำนวน</th>
              <th class="px-4 py-2 border text-center">คงเหลือ</th>
              <th class="px-4 py-2 border">หมายเลขซีเรียล</th>
              <th class="px-4 py-2 border">สี</th>
              <th class="px-4 py-2 border">ราคา</th>
              <th class="px-4 py-2 border">Units</th>
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
            <tr v-for="item in paginatedPromotion" :key="item.id + '-' + item.activity_id">
              <!-- <tr v-for="item in paginatedPromotion" :key="item.id"> -->
              <td class="px-4 py-2 border text-center">
                <input type="checkbox" v-model="selectedIds" :value="item.id" />
              </td>
              <td class="px-4 py-4 border text-center">
                <template v-if="item.image">
                  <img :src="item.image || BASE_URL_IMAGE + item.image" alt="product"
                    class="w-10 h-10 rounded-full mx-auto" />
                </template>
                <template v-else>
                  <span class="material-icons text-gray-400 text-4xl">broken_image</span>
                </template>
              </td>
              <td class="px-4 text-gray-700 py-2 border">{{ item.pro_erp_title || item.title }}

                <div type="text" class="w-60 text-center">

                </div>

              </td>
              <td class="px-4 text-gray-700 py-2 border">{{ item.activity_code ?? 'ไม่มีข้อมูล' }}</td>
              <td class="px-4 text-gray-700 py-2 border">{{ item.goods_id }}</td>
              <td class="px-4 text-gray-700 py-2 border text-center">
                <!-- max item.stock -->
                <input type="number" class="w-16 px-2 py-1 text-gray-700 border rounded text-center"
                  v-model.number="item.amount" :min="0" :max="item.stock" @input="validateAmount(item)"
                  placeholder="0" />
              </td>
              <td class="px-4 text-gray-700 py-2 border">{{ item.stock }}</td>
              <td class="px-4 text-gray-700 py-2 border">{{ item.sn ?? '-' }}</td>
              <td class="px-4 text-gray-700 py-2 border">{{ item.goods_sku_text ?? '-' }}</td>
              <td class="px-4 text-gray-700 py-2 border">{{ item.price ?? '-' }}</td>
              <td class="px-4 text-gray-700 py-2 border">{{ item.units ?? '-' }}</td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- Pagination -->
      <ConfigProvider :globalConfig="enConfig">
        <div class="w-fit mt-4">
          <!-- <div class="overflow-auto mt-4"> -->
          <pagination v-model:current="pageCurrent" v-model:page-size="pageSize" :total="total" show-page-size
            :prev-button-props="{ content: '⏪' }" :next-button-props="{ content: '⏩' }" @change="onPaginationChange" />
        </div>
      </ConfigProvider>

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

// const isLoading = ref(true) // สำหรับ loading spinner
const isLoading = ref(false); // หรือ true ถ้าต้องการให้เริ่มต้นแสดง
// const isLoading = ref(false); // หรือ true ถ้าต้องการให้เริ่มต้นแสดง

// const props = defineProps({
//   promotionList: Array,
//   pageCurrent: Number,
//   pageSize: Number,
//   total: Number
// })

const props = defineProps({
  selectedPromotion: {
    type: Array,
    required: true
  },
  selectProducts_old: {
    type: Array,
    required: false,
    default: () => []
  }
})



const emit = defineEmits(['close', 'selectPromotionProducts', 'page-change', 'go-back'])
// const emit = defineEmits(['close', 'select-promotion_products', 'page-change'])

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
const dataselect = ref([])
const error = ref('')

// const keyword_sku_no = ref('');
// const dataselectsku_no = ref([]);
const promotionProducts = ref([]);

const keyword_promotion_product_no = ref('');
const dataselectpromotion_no = ref([]);

const Apipromotion = ref([]);

// const activity_title = ref('');

const memberType = ref('');

const amount = ref(0);

// const paginatedPromotion = computed(() => {
//   return tableData.value;
// });

const paginatedPromotion = computed(() => {
  const start = (pageCurrent.value - 1) * pageSize.value;
  const end = start + pageSize.value;
  return tableData.value.slice(start, end);
});

function goBackToPromotionSelector() {
  emit('go-back')  // 🔁 แจ้ง parent ให้เปิด popup ตัวแรกอีกครั้ง
}

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
  const selectedPromotionProducts = tableData.value.filter(p =>
    newVal.includes(p.id)
  );
  console.log("สินค้าที่เลือกอยู่ตอนนี้:", selectedPromotionProducts);
});

// watch(pageSize, (newVal) => {
//   if (newVal !== 10) {
//     pageSize.value = 10;
//   }
// });

// function เลือกสินค้าทั้งหมด
function toggleSelectAll(event) {
  if (event.target.checked) {
    const pageIds = [];
    paginatedPromotion.value.forEach(item => {
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
    const pageIds = paginatedPromotion.value.map(item => item.id);
    selectedIds.value = selectedIds.value.filter(id => !pageIds.includes(id));
    console.log('🚫 Deselected selectedIds:', pageIds);

    // เคลียร์ amount ตอนยกเลิกติ๊ก ถ้าต้องการ
    paginatedPromotion.value.forEach(item => {
      item.amount = 0;
    });
  }
}

// function toggleSelectAll(event) {
//   if (event.target.checked) {
//     const pageIds = paginatedPromotion.value.map(item => item.id)
//     selectedIds.value = [...new Set([...selectedIds.value, ...pageIds])]

//     console.log('toggleSelectAll selectedIds:', pageIds);
//   } else {
//     const pageIds = paginatedPromotion.value.map(item => item.id)
//     selectedIds.value = selectedIds.value.filter(id => !pageIds.includes(id))
//     console.log('Error selectedIds:', pageIds);
//   }
// }

function validateAmount(item) {

  const oldItem = props.selectProducts_old.find(p =>
    p.pro_activity_id === item.activity_id &&
    p.pro_sku_price_id === item.id
  );

  const oldAmount = oldItem ? Number(oldItem.pro_quantity || oldItem.pro_goods_num || 0) : 0;
  const newAmount = Number(item.amount || 0);
  const stock = Number(item.stock || 0);

  const total = oldAmount + newAmount;

  if (total > stock) {
    Swal.fire({
      icon: 'warning',
      title: 'จำนวนสินค้าเกินสต๊อก',
      text: `คุณเลือกสินค้าเกินกว่าสต๊อกที่มีอยู่ (${total}/${stock})`
    });
    item.amount = stock - oldAmount > 0 ? stock - oldAmount : 0;
  }

  // if (item.amount < 0) {
  //   item.amount = 0;
  // } else if (item.amount > item.stock) {
  //   item.amount = item.stock;
  // }

  // ✅ เพิ่ม logic ติ๊ก checkbox อัตโนมัติ
  if (item.amount > 0) {
    if (!selectedIds.value.includes(item.id)) {
      selectedIds.value.push(item.id);
    }
  } else {
    // ถ้าใส่ 0 หรือลบออก ให้เอาออกจาก selectedIds
    selectedIds.value = selectedIds.value.filter(id => id !== item.id);
  }

}

function searchPromotion_no() {
  const kw = keyword.value.trim().toLowerCase();
  const promoNo = keyword_promotion_product_no.value.trim().toLowerCase();

  // กรองข้อมูล promotionProducts ตามเงื่อนไข AND
  const filtered = promotionProducts.value.filter(item => {
    const title = item.title ? item.title.toLowerCase() : '';
    const activityCode = item.activity_code ? item.activity_code.toLowerCase() : '';

    // ตรวจสอบว่า title ต้องมี keyword อยู่ (includes) แต่ activity_code ต้องตรงเป๊ะกับ promoNo
    const matchKeyword = kw ? title.includes(kw) : true;
    const matchPromoNo = promoNo ? activityCode === promoNo : true;

    return matchKeyword && matchPromoNo;
  });

  tableData.value = filtered;

  // ถ้าต้องการโชว์ว่าเจอแค่รายการเดียวหรือไม่
  if (filtered.length === 1) {
    console.log('พบรายการที่ตรงกันอย่างแม่นยำ 1 รายการ:', filtered[0]);
  } else if (filtered.length === 0) {
    console.log('ไม่พบรายการที่ตรงกัน');
  } else {
    console.log('พบหลายรายการ:', filtered.length);
  }
}


// const searchPromotion_no = async () => {
//   clearTimeout(searchTimer.value);

//   const getLevelSS = JSON.parse(localStorage.getItem('selectDataCustomer'));
//   const getLevel = getLevelSS?.data2?.level ?? 0;

//   if (getLevel === 0) {
//     memberType.value = 'Member End User';
//   } else if (getLevel === 1) {
//     memberType.value = 'Member A';
//   } else if (getLevel === 7) {
//     memberType.value = 'Member B';
//   } else if (getLevel === 10) {
//     memberType.value = 'Member A+';
//   } else {
//     memberType.value = 'Unknown Member';
//   }

//   try {
//     const keyword1 = keyword.value.trim().toLowerCase();
//     const keyword2 = keyword_promotion_product_no.value.trim().toLowerCase();

//     if (!promotionProducts.value || promotionProducts.value.length === 0) {
//       console.warn("⚠️ ไม่มีข้อมูล promotionProducts โปรดเรียก getPromotionProducts() ก่อน");
//       return;
//     }

//     let filteredResults = [];

//     if (!keyword1 && !keyword2) {
//       // ✅ ไม่มี keyword ใดเลย → แสดงทั้งหมด
//       filteredResults = promotionProducts.value;
//       pageSize.value = 10;
//     } else {
//       // ✅ มี keyword → กรอง
//       filteredResults = promotionProducts.value.filter((sku) =>
//         sku.title?.toLowerCase().includes(keyword1) ||
//         sku.erp_title?.toLowerCase().includes(keyword1) ||
//         sku.goods_sku_text?.toLowerCase().includes(keyword1) ||
//         sku.sn?.toLowerCase().includes(keyword1) ||
//         sku.activity_code?.toLowerCase().includes(keyword1) ||
//         sku.title?.toLowerCase().includes(keyword2) ||
//         sku.erp_title?.toLowerCase().includes(keyword2) ||
//         sku.goods_sku_text?.toLowerCase().includes(keyword2) ||
//         sku.sn?.toLowerCase().includes(keyword2)
//       );

//       pageCurrent.value = 1;
//       pageSize.value = 10; // ✅ default เสมอเป็น 10
//     }

//     tableData.value = filteredResults;
//     dataselectpromotion_no.value = filteredResults;
//     total.value = filteredResults.length;

//     console.log("🔍 [NO] ผลลัพธ์ที่ค้นหาได้:", filteredResults);

//   } catch (err) {
//     console.error("❌ searchPromotion_no error:", err);
//   }
// };




async function SearchPromotionSubmit() {
  clearTimeout(searchTimer.value);

  const getLevelSS = JSON.parse(localStorage.getItem('selectDataCustomer'));
  const getLevel = getLevelSS?.data2?.level ?? 0;

  if (getLevel === 0) {
    memberType.value = 'Member End User';
  } else if (getLevel === 1) {
    memberType.value = 'Member A';
  } else if (getLevel === 7) {
    memberType.value = 'Member B';
  } else if (getLevel === 10) {
    memberType.value = 'Member A+';
  } else {
    memberType.value = 'Unknown Member';
  }

  if (!keyword.value.trim()) {
    try {
      // ✅ แทนที่ API ด้วยการใช้ข้อมูลจาก getPromotionProducts()
      const keywordToSearch = keyword.value.trim().toLowerCase();

      if (!promotionProducts.value || promotionProducts.value.length === 0) {
        console.warn("⚠️ ไม่มีข้อมูล promotionProducts โปรดเรียก getPromotionProducts() ก่อน");
        return;
      }

      const filteredResults = promotionProducts.value.filter((sku) =>
        sku.title?.toLowerCase().includes(keywordToSearch) ||
        sku.erp_title?.toLowerCase().includes(keywordToSearch) ||
        sku.goods_sku_text?.toLowerCase().includes(keywordToSearch) ||
        sku.sn?.toLowerCase().includes(keywordToSearch) ||
        sku.activity_code?.toLowerCase().includes(keywordToSearch)
      );

      console.log("🔍 ผลลัพธ์ที่ค้นหาได้:", filteredResults);

      tableData.value = filteredResults;
      dataselectpromotion_no.value = filteredResults;
      total.value = filteredResults.length;
      pageSize.value = (total.value < pageSize.value)
        ? total.value
        : parseInt(pageSize.value);

    } catch (err) {
      console.error("❌ SearchPromotionSubmit error:", err);
    }

  } else {
    try {
      const keywordToSearch = keyword.value.trim().toLowerCase();

      if (!promotionProducts.value || promotionProducts.value.length === 0) {
        console.warn("⚠️ ไม่มีข้อมูล promotionProducts โปรดเรียก getPromotionProducts() ก่อน");
        return;
      }

      let filteredResults = [];

      if (keywordToSearch === "") {
        // ✅ ถ้าไม่มี keyword ให้แสดงผลทั้งหมด และ pageSize เป็น 10
        filteredResults = promotionProducts.value;
        pageSize.value = 10;
      } else {
        // ✅ ถ้ามี keyword ให้กรองข้อมูล
        filteredResults = promotionProducts.value.filter((sku) =>
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
      dataselectpromotion_no.value = filteredResults;
      total.value = filteredResults.length;

    } catch (err) {
      console.error("❌ SearchPromotionSubmit error:", err);
    }
  }
}


//page = 1
async function getPromotionProducts() {
  isLoading.value = true;

  const gettoken = localStorage.getItem('token');

  const requests = props.selectedPromotion.map(async promo => {
    const activity_id = promo.pro_m_id;

    try {
      const response = await axios.post(
        `${BASE_URL}/goods2/activitybackend?activity_id=${activity_id}&page=1&proid=&keywords=`,
        {},
        {
          headers: {
            'Content-Type': 'application/json',
            token: gettoken
          }
        }
      );

      const activityData = response.data.data;

      console.log("✅ ดึงข้อมูลโปรโมชันทั้งหมด:", activityData);

      const skuList = activityData.activity_sku_price || [];

      return skuList.map(sku => ({
        ...sku,
        activity_id: activityData.id || 0, // 1167
        goods_id: sku.goods_id, // 13872
        pro_sku_price_id: sku.sku_price_id, // 50983
        erp_title: sku.erp_title, // "ADAPTER SET AG-201 FOR TYPE C TO LIGHTNING PD 20W BLUE DP"
        title: sku.title, // ชุดอะแดปเตอร์เซ็ต AG-201 (20W)
        image: sku.image, // /uploads/20240201/eaf550db288e6e947c8b3e70753f6a28.
        goods_price: sku.goods_price, // "215.00" 

        activity_code: activityData.activity_code, // x
        pro_m_code: activityData.activity_code, // x
        pro_acm_id: activityData.id, // x
        sn: sku.sn, // x
        goods_sku_text: sku.goods_sku_text, // x
        units: sku.units // x
      }));
    } catch (err) {
      console.error(`❌ Error loading products for activity_id=${activity_id}`, err);
      return []; // ถ้า error ให้ส่ง array ว่าง
    }
  });

  // ส่งทุก request พร้อมกัน
  const allResultsArrays = await Promise.all(requests);
  const allResults = allResultsArrays.flat(); // รวมทุก array เข้าเป็น array เดียว

  tableData.value = allResults;
  promotionProducts.value = allResults;
  total.value = allResults.length;

  console.log("✅ ดึงข้อมูลสินค้าครบทั้งหมด:", allResults);
  isLoading.value = false;
}



function confirmSelection() {

  // activity_code :"P02-ZZ-9999"
  // activity_id :1178

  // ✅ ใช้งานได้เลยโดยไม่ต้อง .value
  console.log('🔥 selectedProducts_old:', props.selectProducts_old);

  // ✅ ถ้าต้องการเก็บในตัวแปร
  // const get_productOld = props.selectedProducts_old;
  // console.log('🎯 get_productOld:', get_productOld);

  // const get_productOld = (props.selectProducts_old || []).map(p => p);

  const get_productOld_raw = (props.selectProducts_old || []).map(p => ({ ...p }));

  console.log('🎯 get_productOld:', get_productOld_raw);

  // return;

  const selectedPromotionProducts = tableData.value
    .filter(p => selectedIds.value.includes(p.id))
    // .map(p => {
    .map(p => ({

      // 🔍 ดึง matchedPrice จาก condition_price ตามชื่อสมาชิก
      // const condPrice = p.condition_price?.[0]?.price || [];
      // const found = condPrice.find(priceItem => priceItem.name === memberType.value);
      // const matchedPrice = found ? found.price : '-';

      // return {
      pro_activity_id: p.activity_id, // 1167
      // pro_id: p.activity_id, // 1167
      pro_goods_id: p.goods_id, // 13872
      pro_goods_price: p.goods_price, // "215.00"
      pro_sku_price_id: p.id, //sku_price_id // 50983 
      pro_goods_num: p.amount || 0, // 1 
      stock: p.stock || 0,
      // pro_quantity: p.quantity || 0, // 1 
      pro_image: p.image, // /uploads/20240201/eaf550db288e6e947c8b3e70753f6a28.jpg   
      pro_erp_title: p.erp_title, // "ADAPTER SET AG-201 FOR TYPE C TO LIGHTNING PD 20W BLUE DP" 

      //
      pro_title: p.title, // "ชุดอะแดปเตอร์เซ็ต AG-201 (20W)"

      // 
      pro_code: p.activity_code, // x
      pro_m_code: p.pro_m_code, // x 
      // pro_goods_sku_text: p.goods_sku_text, // x
      pro_sn: p.sn, //"2010102DP0057" x
      pro_units: p.units, // "PCS" x
      // pro_goods_price: matchedPrice,
      // pro_goods_price: p.goods_price,
      // }

      // });
    }));



  const sum_products = [...get_productOld_raw, ...selectedPromotionProducts];

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

  // const productErrors = [];

  const grouped = groupBy(sum_products, item => `${item.pro_activity_id}_${item.pro_sku_price_id}`);
  const groupedArray = Object.values(grouped);



///////////////////////////////
// const productErrors = [];

// // 👇 ใช้ grouped เดิมเพื่อส่งข้อมูลต่อ
// const grouped = groupBy(sum_products, item => `${item.pro_activity_id}_${item.pro_sku_price_id}`);
// const groupedArray = Object.values(grouped);

// // ✅ สร้าง validateGrouped ใหม่ โดยใช้ key เป็น pro_activity_id + pro_sku_price_id
// const validateGrouped = Object.values(
//   sum_products.reduce((acc, item) => {
//     const key = `${item.pro_activity_id}_${item.pro_sku_price_id}`;
//     if (!acc[key]) {
//       acc[key] = {
//         ...item,
//         pro_quantity: Number(item.pro_quantity) || 0
//       };
//     } else {
//       acc[key].pro_quantity += Number(item.pro_quantity) || 0;
//     }
//     return acc;
//   }, {})
// );

// // ✅ ตรวจสอบ stock แยกตาม pro_activity_id + pro_sku_price_id
// validateGrouped.forEach(product => {
//   const totalQuantity = product.pro_quantity || 0;
//   const stockAvailable = Number(product.pro_stock ?? product.stock ?? 0); // ใช้ pro_stock หรือ stock

//   if (totalQuantity > stockAvailable) {
//     productErrors.push({
//       title: product.pro_erp_title || product.pro_title || '(ไม่มีชื่อ)',
//       quantity: totalQuantity,
//       stock: stockAvailable
//     });
//   }
// });

// if (productErrors.length > 0) {
//   const messages = productErrors.map(p =>
//     `• ${p.title} (ขอ: ${p.quantity}, คลังมี: ${p.stock})`
//   ).join('\n');

//   Swal.fire({
//     icon: 'error',
//     title: 'สินค้าเกินจากสต๊อก',
//     text: 'กรุณาตรวจสอบรายการสินค้า:\n' + messages,
//     confirmButtonText: 'ตกลง'
//   });

//   return; // ❌ หยุดการส่งข้อมูล
// }

// const productErrors = [];

// // 👇 ใช้ grouped เดิมเพื่อส่งข้อมูลต่อ (แต่เราจะกรองทีหลัง)
// const grouped = groupBy(sum_products, item => `${item.pro_activity_id}_${item.pro_sku_price_id}`);

// // ✅ สร้าง validateGrouped แยกตาม activity+sku_price_id
// const validateGrouped = Object.values(
//   sum_products.reduce((acc, item) => {
//     const key = `${item.pro_activity_id}_${item.pro_sku_price_id}`;
//     if (!acc[key]) {
//       acc[key] = {
//         ...item,
//         pro_quantity: Number(item.pro_quantity) || 0
//       };
//     } else {
//       acc[key].pro_quantity += Number(item.pro_quantity) || 0;
//     }
//     return acc;
//   }, {})
// );

// // ✅ ตรวจสอบ stock
// const errorKeys = new Set(); // 👉 สำหรับเก็บ key ของสินค้าที่เกิน stock

// validateGrouped.forEach(product => {
//   const key = `${product.pro_activity_id}_${product.pro_sku_price_id}`;
//   const totalQuantity = product.pro_quantity || 0;
//   const stockAvailable = Number(product.pro_stock ?? product.stock ?? 0);

//   if (totalQuantity > stockAvailable) {
//     errorKeys.add(key); // ❗ เก็บ key ไว้ใช้กรอง newproduct ทีหลัง

//     productErrors.push({
//       title: product.pro_erp_title || product.pro_title || '(ไม่มีชื่อ)',
//       quantity: totalQuantity,
//       stock: stockAvailable
//     });
//   }
// });

// // ❗ ถ้ามี error → alert แล้ว return
// if (productErrors.length > 0) {
//   const messages = productErrors.map(p =>
//     `• ${p.title} (ขอ: ${p.quantity}, คลังมี: ${p.stock})`
//   ).join('\n');

//   Swal.fire({
//     icon: 'error',
//     title: 'สินค้าเกินจากสต๊อก',
//     text: 'กรุณาตรวจสอบรายการสินค้า:\n' + messages,
//     confirmButtonText: 'ตกลง'
//   });

//   return; // ❌ หยุดการส่งข้อมูล
// }

  // // เช็กยอดรวมกับ stock
  // groupedArray.forEach(product => {
  //   const totalQuantity = Number(product.pro_quantity) || 0;
  //   const stockAvailable = Number(product.stock) || 0;

  //   if (totalQuantity > stockAvailable) {
  //     productErrors.push({
  //       title: product.pro_erp_title || product.pro_title || '(ไม่มีชื่อ)',

  //       quantity: totalQuantity,
  //       stock: stockAvailable
  //     });
  //   }
  // });

  // if (productErrors.length > 0) {
  //   const messages = productErrors.map(p =>
  //     `• ${p.title} (ขอ: ${p.quantity}, คลังมี: ${p.stock})`
  //   ).join('\n');

  //   Swal.fire({
  //     icon: 'error',
  //     title: 'สินค้าเกินจากสต๊อก',
  //     text: 'กรุณาตรวจสอบรายการสินค้า:\n' + messages,
  //     confirmButtonText: 'ตกลง'
  //   });

  //   return; // ❌ หยุดการส่งข้อมูล
  // }

  const newproduct = [];

  Object.values(grouped).forEach(item => {
    newproduct.push(item);
  });


  console.log('✅ Grouped  resultnewproduct:', newproduct);
  console.log('✅ Grouped  result groupedArray:', groupedArray);
  // console.log('✅ Grouped  result groupedArray:', groupedArray);



  // console.log('Check: selectedPromotionProducts',selectedPromotionProducts);


  // const invalidProducts = grouped.filter(a => a.pro_goods_num < 1);
  // // const invalidProducts = selectedPromotionProducts.filter(a => a.pro_goods_num < 1);


  // console.log('Check invalidProducts', invalidProducts);

  // if (invalidProducts.length > 0) {
  //   const invalidNames = invalidProducts.map(n => `• ${n.pro_title || pro_erp_title} จำนวน: ${n.pro_goods_num} `).join('\n');
  //   Swal.fire({
  //     icon: 'warning',
  //     title: 'พบสินค้าที่จำนวนไม่ถูกต้อง ❌',
  //     html: `กรุณาตรวจสอบจำนวนสินค้าให้ถูกต้องก่อนดำเนินการ:<br><pre>${invalidNames}</pre>`
  //   });
  //   return; // ❌ ยกเลิกการส่ง
  // }

  const selectedPromotionsInfo = props.selectedPromotion.map(p => ({

    pro_m_id: p.pro_m_id, //pro_m_id: 1176
    pro_m_title: p.pro_m_title,
    pro_acm_id: p.pro_acm_id,
    pro_m_images: p.pro_m_images,

  }))


  console.log("✅ selectedPromotionProducts ถูกแปลงแล้ว:", selectedPromotionProducts);
  console.log("✅ selectedPromotionsInfo ถูกแปลงแล้ว:", selectedPromotionsInfo);

  console.log('Check: grouped 800 : ', newproduct);

  // return;

  submittedProduct(newproduct);
  // submittedProduct(selectedPromotionProducts);
  // emit('select-promotion_products', {
  //   products: selectedPromotionProducts,
  //   promotions: selectedPromotionsInfo

  // });
  // emit('close');
}


async function submittedProduct(newproduct) {
  // async function submittedProduct(selectedProducts) {
  // isLoading.value = true; // เริ่มโหลด

  const gettoken = localStorage.getItem('token');
  // ดึงชื่อสินค้าทั้งหมดออกมา (เป็น array ของชื่อ)
  // const selectedTitles = selectedProducts.map(p => p.pro_title || p.pro_erp_title );

  console.log("grouped 823:", newproduct);
  // console.log("selectedProducts:", selectedProducts);

  // return;

  try {
    const response = await axios.post(
      `${BASE_URL}/cart_out/index`,
      {
        products: newproduct, // ส่งข้อมูลที่เลือกไปยัง API
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

    if (response.data.code === 1) {
      const data = response.data.data.products || [];

      console.log("Check Value data:", data);

      // แยกข้อมูลออกเป็น 3 ก้อน
      // const items = data.filter(item => item?.pro_goods_id !== 0 && !item?.pro_title && item?.note === 'รายการ');
      // const gifts = data.filter(item => item?.pro_goods_id !== 0 && item?.pro_title && item?.note === 'ของแถม');
      // const promotions = data.filter(item => item?.pro_goods_id === 0 && item?.pro_title && item?.note === 'โปรโมชั่น');

      // ใช้ได้
      // แยกข้อมูลออกเป็น 3 ก้อน //  ,  
      const items = data.filter(item => item.pro_goods_id !== 0 && item?.ML_Note === 'item' || item?.ML_Note === 'itemmonth');
      const gifts = data.filter(item => item.pro_goods_id !== 0 && item?.ML_Note === 'zengsopng_day' || item?.ML_Note === 'zengsopng_month');
      const promotions = data.filter(item => item.pro_activity_id !== 0 && item?.ML_Note === 'promotion_day' || item?.ML_Note === 'promotion_month');

      const emitTitles = newproduct.map(p => ({
        // const emitTitles = selectedProducts.map(p => ({
        pro_goods_id: p.pro_goods_id || 0,
        pro_activity_id: p.pro_activity_id || 0,
        pro_title: p.pro_erp_title || p.pro_title || '(ไม่มีชื่อ)',
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

      emit('selectPromotionProducts', {
        // emit('select-promotion_products', {
        // ใช้ได้
        items,
        gifts,
        promotions,
        emitTitles
      });

      emit('close'); // 

      // dataselect.value = data.data.products || [];
      // tableData.value = [...dataselect.value];
      // total.value = data.item_count || dataselect.value.length;
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
    SearchPromotionSubmit();
  }, 500); // รอให้พิมพ์เสร็จ 0.5 วิค่อยเรียก
}

onMounted(() => {
  SearchPromotionSubmit(); // โหลดสินค้าทั้งหมดรอบแรก
  // getPromotion();
  getPromotionProducts(); // โหลดสินค้าจากโปรโมชั่น
  console.log("props test Log :", props);
});


</script>


<!-- /* <style scoped>

.xl-size{
  width: 500px !important; 
}

</style> */ -->


<!-- // async function submittedProduct(selectedProducts) {
  //   const gettoken = localStorage.getItem('token');
  
  //   try {
  //     const response = await axios.post(
  //       `${BASE_URL}/cart_out/index`,
  //       { products: selectedProducts },
  //       { headers: { 'Content-Type': 'application/json', 'token': gettoken } }
  //     );
  
  //     console.log("✅ Response from API:", response);
  
  //     if (response.data.code === 1) {
  //       const data = response.data.data.products || [];
  
  //       console.log("Check Value data:", data);
  
  //       // สร้าง emitTitles (ข้อมูลจาก selectedProducts)
  //       const emitTitles = selectedProducts.map(p => ({
  //         pro_goods_id: p.pro_goods_id || 0,
  //         pro_activity_id: p.pro_activity_id || 0,
  //         pro_erp_title: p.pro_title || p.pro_erp_title || '(ไม่มีชื่อ)',
  //         pro_goods_price: p.pro_goods_price || 0,
  //         pro_sn: p.pro_sn || '',
  //         pro_units: p.pro_units || '',
  //       }));
  
  //       // จัดกลุ่มข้อมูลตาม pro_activity_id
  //       const groupedData = data.reduce((acc, item) => {
  //         const activityId = item.pro_activity_id;
  
  //         if (!acc[activityId]) {
  //           acc[activityId] = {
  //             items: [],
  //             gifts: [],
  //             promotions: [],
  //             emitTitles: emitTitles.filter(e => e.pro_activity_id === activityId) // 🟢 เพิ่ม emitTitles ที่ตรงกัน
  //           };
  //         }
  
  //         if (item.note === 'รายการ') {
  //           acc[activityId].items.push(item);
  //         } else if (item.note === 'ของแถม') {
  //           acc[activityId].gifts.push(item);
  //         } else if (item.note === 'โปรโมชั่น') {
  //           acc[activityId].promotions.push(item);
  //         }
  
  //         return acc;
  //       }, {});
  
  //       console.log("🔁 Grouped Data with emitTitles:", groupedData);
  
  //       emit('selectPromotionProducts', groupedData);
  //       emit('close');
  //     } else {
  //       Swal.fire({
  //         title: 'เกิดข้อผิดพลาด',
  //         text: response.data.message || 'โปรดลองใหม่ภายหลัง',
  //         icon: 'error',
  //       });
  //     }
  //   } catch (err) {
  //     console.error("❌ Error in submittedProduct:", err);
  //     Swal.fire({
  //       title: 'เกิดข้อผิดพลาด',
  //       text: err.message || 'โปรดลองใหม่ภายหลัง',
  //       icon: 'error',
  //     });
  //   }
  // } -->


<!-- 
// async function SearchPromotionSubmit() {
  //   clearTimeout(searchTimer.value);
  
  
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
  
  
  //   if (!keyword.value.trim()) {
  
  //     try {
  
  //       const gettoken = localStorage.getItem('token');
  //       console.log("log value token:", gettoken);
  
  
  //       const requests = props.selectedPromotion.map(async promo => {
  //         const activity_id = promo.pro_m_id;
  
  //         const response = await axios.post(
  //           `${BASE_URL}/goods2/activitybackend?activity_id=${activity_id}&page=1&proid=&keywords=${keyword.value}`,
  //           {},
  //           {
  //             headers: {
  //               'Content-Type': 'application/json',
  //               token: gettoken
  //             }
  //           }
  //         );
  
  //         console.log("IF searchSku response:", response);
  
  //         // const activityData = response.data.data;
  
  //         if (response.data.code === 1) {
  //           const rawData = response.data.data;
  
  //           console.log("rawData:", rawData);
  
  
  //           const keywordToSearch = keyword.value.trim().toLowerCase();
  
  //           const filtered = rawData.filter((item) =>
  //             item.title?.toLowerCase().includes(keywordToSearch) ||
  //             item.erp_title?.toLowerCase().includes(keywordToSearch) ||
  //             item.activity_code?.toLowerCase().includes(keywordToSearch) ||
  //             item.activity_id?.toLowerCase().includes(keywordToSearch) ||
  //             item.note?.toLowerCase().includes(keywordToSearch) ||
  //             item.ML_Note?.toLowerCase().includes(keywordToSearch)
  //           );
  
  //           console.log("Filtered promotions:", filtered);
  
  //           dataselectpromotion_no.value = filtered;
  //           tableData.value = [...filtered];
  //           total.value = filtered.length;
  //           pageSize.value = (total.value < pageSize.value)
  //             ? total.value
  //             : parseInt(pageSize.value);
  //         }
  
  
  //       });
  
  //       // ส่งทุก request พร้อมกัน
  
  //       const allResultsArrays = await Promise.all(requests);
  //       const allResults = allResultsArrays.flat(); // รวมทุก array เข้าเป็น array เดียว
  
  //       tableData.value = allResults;
  
  
  //       // const gettoken = localStorage.getItem('token');
  //       // console.log("log value token:", gettoken);
  
  //       // // ?from=specialprice
  //       // const response = await axios.post(
  //       //   `${BASE_URL}/goods2/activityList`,
  //       //   {
  //       //     version: '2.0.2',
  //       //     // keywords: keyword.value,
  //       //     keywords: keyword.value,
  //       //     level: getLevel
  //       //   }, //  body 
  //       //   {
  //       //     params: {
  //       //       "from": "specialprice"
  //       //     },
  //       //     headers: {
  //       //       'Content-Type': 'application/json',
  //       //       'token': gettoken
  //       //     }
  //       //   }
  //       // );
  
  //       // // const response = await axios.post(`${BASE_URL}/Goods2/product`, {
  //       // //   version: '2.0.2',
  //       // //   pageSize: pageSize.value,
  //       // //   pageCurrent: pageCurrent.value,
  //       // //   keywords: keyword_promotion_product_no.value,
  //       // //   level: getLevel
  //       // // });
  
  //       // console.log("IF searchSku response:", response);
  //       // // console.log("IF searchSku total:", response.data.data.item_count);
  
  //       // if (response.data.code === 1) {
  //       //   const rawData = response.data.data;
  
  //       //   // 🧠 ฟิลเตอร์โปรโมชั่นจาก keyword_promotion_product_no หรือ keyword ที่พิมพ์
  //       //   const keywordToSearch = keyword.value.trim().toLowerCase();
  
  //       //   const filtered = rawData.filter((item) =>
  //       //     item.title.toLowerCase().includes(keywordToSearch)
  //       //   );
  
  //       //   console.log("Filtered promotions:", filtered);
  
  //       //   dataselectpromotion_no.value = filtered;
  //       //   tableData.value = [...filtered];
  //       //   total.value = filtered.length;
  //       //   pageSize.value = (total.value < pageSize.value)
  //       //     ? total.value
  //       //     : parseInt(pageSize.value);
  //       // }
  
  //       ///////////////////////////////////
  
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
  
  //       const gettoken = localStorage.getItem('token');
  //       console.log("log value token:", gettoken);
  
  
  //       const requests = props.selectedPromotion.map(async promo => {
  //         const activity_id = promo.pro_m_id;
  
  //         const response = await axios.post(
  //           `${BASE_URL}/goods2/activitybackend?activity_id=${activity_id}&page=1&proid=&keywords=${keyword.value}`,
  //           {},
  //           {
  //             headers: {
  //               'Content-Type': 'application/json',
  //               token: gettoken
  //             }
  //           }
  //         );
  
  //         console.log("IF searchSku response:", response);
  
  //         // const activityData = response.data.data;
  
  //         if (response.data.code === 1) {
  //           const rawData = response.data.data;
  
  //           console.log("rawData:", rawData);
  
  
  //           const keywordToSearch = keyword.value.trim().toLowerCase();
  
  //           const filtered = rawData.filter((item) =>
  //             item.title?.toLowerCase().includes(keywordToSearch) ||
  //             item.erp_title?.toLowerCase().includes(keywordToSearch) ||
  //             item.activity_code?.toLowerCase().includes(keywordToSearch) ||
  //             item.activity_id?.toLowerCase().includes(keywordToSearch) ||
  //             item.note?.toLowerCase().includes(keywordToSearch) ||
  //             item.ML_Note?.toLowerCase().includes(keywordToSearch)
  //           );
  
  
  //           console.log("Filtered promotions:", filtered);
  
  //           dataselectpromotion_no.value = filtered;
  //           tableData.value = [...filtered];
  //           total.value = filtered.length;
  //           pageSize.value = (total.value < pageSize.value)
  //             ? total.value
  //             : parseInt(pageSize.value);
  //         }
  
  
  //       });
  
  //       // ส่งทุก request พร้อมกัน
  //       const allResultsArrays = await Promise.all(requests);
  //       const allResults = allResultsArrays.flat(); // รวมทุก array เข้าเป็น array เดียว
  
  //       tableData.value = allResults;
  
  //       // ?from=specialprice
  //       // const response = await axios.post(
  //       //   `${BASE_URL}/goods2/activitybackend?activity_id=${activity_id}&page=1&proid=&keywords=`,
  //       //   {
  //       //     version: '2.0.2',
  //       //     pageSize: pageSize.value,
  //       //     pageCurrent: pageCurrent.value,
  //       //     // keywords: keyword.value,
  //       //     keywords: keyword.value + '$_' + keyword_promotion_product_no.value + '_$',
  //       //     level: getLevel
  //       //   }, //  body 
  //       //   {
  //       //     params: {
  //       //       "from": "specialprice"
  //       //     },
  //       //     headers: {
  //       //       'Content-Type': 'application/json',
  //       //       'token': gettoken
  //       //     }
  //       //   }
  //       // );
  
  
  //     } catch (err) {
  //       console.error("searchSku error:", err);
  //     }
  //     //satisfies
  //   }
  // }; -->

<!-- // async function getPromotionProducts() {
  //   // async function getPromotion(page = 1) {
  //   isLoading.value = true; // เริ่มโหลด
  
  //   const gettoken = localStorage.getItem('token');
  
  //   // เตรียมการดึงสินค้าทั้งหมดที่เกี่ยวข้องกับแต่ละโปรโมชั่น
  //   const allResults = [];
  
  
  //   for (const promo of props.selectedPromotion) {
  //     const activity_id = promo.pro_m_id;
  //     // const activity_title = promo.pro_m_title;
  
  
  //     console.log("Check Value activity_id: ", activity_id);
  
  //     try {
  //       const response = await axios.post(
  //         `${BASE_URL}/goods2/activitybackend?activity_id=${activity_id}&page=1&proid=&keywords=`,
  //         {},
  //         {
  //           headers: {
  //             'Content-Type': 'application/json',
  //             token: gettoken
  //           }
  //         }
  //       );
  
  
  //       console.log("Check Value response: ", response.data.data);
  
  //       const activityData = response.data.data
  
  //       const skuList = activityData.activity_sku_price || [];
  
  //       for (const sku of skuList) {
  //         allResults.push({
  //           ...sku,
  
  //           // 🔄 ใช้ข้อมูลหลักจาก sku และ activityData
  //           goods_id: sku.goods_id,
  //           erp_title: sku.erp_title,
  //           image: sku.image,
  //           activity_code: activityData.activity_code,
  //           pro_m_code: activityData.activity_code,
  //           pro_acm_id: activityData.activity_code,
  //           sn: sku.sn,
  //           goods_sku_text: sku.goods_sku_text,
  //           price: sku.price,
  //           units: sku.units,
  
  //           // ❌ ไม่ใส่ condition_price อีกต่อไป
  //         });
  //       }
  
  //     } catch (err) {
  //       console.error(`❌ Error loading products for activity_id=${activity_id}`, err);
  //     }
  //   }
  
  //   // กำหนดค่าเข้า tableData เพื่อแสดงผล
  //   tableData.value = allResults;
  
  //   promotionProducts.value = allResults;
  //   total.value = allResults.length;
  
  //   console.log("Check Value tableData || allResult :", tableData.value);
  //   isLoading.value = false; // เริ่มโหลด
  // } -->

<!-- // const detailList = activityData.activity_detail_discounts || [];

// for (const detail of detailList) {

//   const skuPrice = detail.sku_price || [];

//   for (const sku of skuPrice) {

//     const condPrice = sku.condition_price?.[0]?.price || [];
//     const found = condPrice.find(priceItem => priceItem.name === memberType.value);
//     // const matchedPrice = found ? found.price : '-';
//       // ถ้าเจอราคาแบบสมาชิก → ใช้ราคานั้น, ถ้าไม่เจอ → fallback เป็น sku.price
//     const matchedPrice = found?.price ?? sku.price ?? '-';

//     allResults.push({
//       ...sku,

//       goods_id: detail.goods_id,
//       erp_title: detail.erp_title,
//       image: sku.image,
//       activity_code: activityData.activity_code,
//       pro_m_code: activityData.activity_code,
//       pro_acm_id: activityData.activity_code,

//       // sn: detail.sn,
//       // price: detail.price,
//       // units: detail.units
//       sn: sku.sn,
//       goods_sku_text: sku.goods_sku_text,
//       price: matchedPrice,
//       // price: sku.price ,
//       units: sku.units,

//       // ✅ เพิ่มเข้าไปเพื่อเอาไว้แยกตามประเภทสมาชิก
//       condition_price: sku.condition_price || [],

//       // matchedPrice:matchedPrice,

//     })
//   }

// }

// ✅ ดึงเฉพาะสินค้าที่เข้าร่วม
// const promotion_products = activityData.activity_detail_discounts || [];

// if (response.data.code === 1 && Array.isArray(promotion_products)) {
//   allResults.push(...promotion_products);
// } -->

<!-- // const response = await axios.post(
  //   `${BASE_URL}/goods2/activity`, // <-- URL
  //   {}, // <-- ไม่มี body, ใส่ {} เปล่าไว้
  //   {
  //     params: {
  //       activity_id: "1167",
  //       page: "1",
  //       proid: "",
  //       keywords: "",
  //     },
  //     headers: {
  //       token: gettoken  // <-- ส่ง token แบบ custom key
  //     }
  //   }
  // );
 -->
