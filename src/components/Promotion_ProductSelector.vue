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
              <th class=" px-4 py-2 border min-w-[250px]">ชื่อสินค้า (ERP)</th> <!-- w-[300px]-->
              <th class="px-4 border min-w-[220px] text-left">
                <div class="flex gap-1 items-stretch">
                  <input type="text" v-model="keyword_promotion_product_no" placeholder="ค้นหา สินค้าโปรโมชั่น"
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

          <tbody v-if="noCustomerSelected && !isLoading">
            <tr>
              <td colspan="10" class="py-10 text-center text-gray-500">
                โปรดทำการเลือก ร้านค้าของลูกค้าก่อนทำรายการ
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
            <!-- index -->
            <template v-for="(row) in pagedItemsWithHeaders"
              :key="row.isHeader ? 'header-' + row.pro_activity_id : row.id">
              <tr v-if="row.isHeader" class="bg-blue-100">
                <td colspan="11" class="p-2">
                  <div class="flex justify-start gap-6 items-center w-full">
                    <span class="font-semibold text-blue-700">{{ row.promotionTitle }}</span>

                    <div class="inline-flex items-center gap-2 bg-green-500 text-white rounded-lg px-1 py-1 shadow">
                      <button @click="decrementPromotionSet(row.pro_activity_id)"
                        class="w-6 h-6 text-sm font-bold bg-green-600 hover:bg-green-700 rounded">-</button>

                      <span class="px-1 text-sm font-medium">{{ clickCountByPromotion[row.pro_activity_id] || 0
                      }} เซ็ต</span>

                      <button @click="handlePromotionSet(row.pro_activity_id)"
                        class="w-6 h-6 text-sm font-bold bg-green-600 hover:bg-green-700 rounded">+</button>
                    </div>
                  </div>
                </td>
              </tr>

              <tr v-else>
                <td class="px-4 py-2 border text-center">
                  <!-- :value="row.id" -->
                  <input type="checkbox" v-model="selectedIds" :value="`${row.pro_activity_id}-${row.id}`"
                    @change="handleCheckboxChange(row, $event)" />
                </td>
                <td class="px-4 py-4 border text-center">
                  <img :src="row.image || BASE_URL_IMAGE + row.image" class="w-10 h-10 rounded-full mx-auto" />
                </td>
                <td class="px-4 py-2 border">{{ row.pro_erp_title || row.title }}</td>
                <td class="px-4 py-2 border">{{ row.activity_code ?? 'ไม่มีข้อมูล' }}</td>
                <td class="px-4 py-2 border">{{ row.goods_id }}</td>
                <td class="px-4 text-gray-700 py-2 border text-center">
                  <input type="number" class="w-16 px-2 py-1 text-gray-700 border rounded text-center"
                    v-model.number="row.amount" :min="0" :max="row.stock" @keypress="onlyNumberInput($event)"
                    @blur="onAmountBlur(row)" @input="validateAmount(row)" placeholder="0" />
                </td>
                <td class="px-4 py-2 border">{{ row.stock }}</td>
                <td class="px-4 py-2 border">{{ row.sn ?? '-' }}</td>
                <td class="px-4 py-2 border">{{ row.goods_sku_text ?? '-' }}</td>
                <td class="px-4 py-2 border">{{ row.price ?? '-' }}</td>
                <td class="px-4 py-2 border">{{ row.units ?? '-' }}</td>
              </tr>
            </template>
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
// , reactive
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

// const getLevelSS = JSON.parse(localStorage.getItem('selectDataCustomer'));

// const getLevel = getLevelSS?.data2?.level ?? 0;

// reactive state
const keyword = ref('')
const searchTimer = ref(null)

const noCustomerSelected = ref(false);
const tableData = ref([])

const total = ref(0)
const pageCurrent = ref(1)
const pageSize = ref(10)

const selectedIds = ref([])
// const dataselect = ref([])
const error = ref('')

// const keyword_sku_no = ref('');
// const dataselectsku_no = ref([]);
const promotionProducts = ref([]);

const keyword_promotion_product_no = ref('');
const dataselectpromotion_no = ref([]);

// const Apipromotion = ref([]);

// const activity_title = ref('');

const memberType = ref('');

// const amount = ref(0);

// เก็บจำนวนสะสม full ของแต่ละ promotionId (ถ้ามีหลายโปร)
const conditionPriceMap = ref({});

// เก็บจำนวนครั้งที่กดแต่ละ promotion
const clickCountByPromotion = ref({});
const totalFullByPromotion = ref({});  // ยังคงใช้สำหรับคำนวณยอดเต็ม

// const clickCount = reactive({});

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
// const isAllSelected = computed(() =>
//   paginatedPromotion.value.every(item => selectedIds.value.includes(item.id))
// )

// เช็คว่าตอนนี้สินค้าได้ถูกเลือกเป็นรายการอะไรบ้าง

watch(selectedIds, (newVal) => {
  console.log("ติ๊กเลือกแล้ว:", newVal);

  const filteredIds = [];
  let removedByStock = []; // 🟡 เก็บเฉพาะที่ถูกตัดออกเพราะ stock หมด

  newVal.forEach(id => {
    let activityId, productId;

    if (Array.isArray(id)) {
      id = id.join("-");
    }

    if (typeof id === "object" && id !== null) {
      if (id.activityId && id.productId) {
        id = `${id.activityId}-${id.productId}`;
      } else {
        console.warn("⚠️ id เป็น object แต่ไม่มี activityId/productId:", id);
        return;
      }
    }

    if (typeof id === "string") {
      [activityId, productId] = id.split("-");
    } else {
      console.warn("⚠️ id ไม่ใช่ string:", id);
      return;
    }

    const product = tableData.value.find(
      p => p.pro_activity_id == activityId && p.id == productId
    );

    if (!product) {
      console.log("❌ ไม่เจอสินค้า:", { activityId, productId });
      return;
    }

    if (product.stock <= 0) {
      console.log("⚠️ สินค้าหมดสต็อก:", product);
      removedByStock.push(id); // ✅ เก็บว่าอันนี้ถูกลบเพราะ stock
      return;
    }

    filteredIds.push(id);
  });

  // ✅ update selectedIds แค่ตอนมีสินค้าที่ถูกลบเพราะ stock
  if (removedByStock.length > 0) {
    console.log("🟡 มีการลบสินค้าออกเพราะสต็อกหมด", {
      'ก่อนหน้า': newVal,
      'หลังกรอง': filteredIds,
      'ที่ถูกลบเพราะ stock': removedByStock,
    });

    selectedIds.value = filteredIds;

    Swal.fire({
      icon: "warning",
      title: "สินค้าในสต็อกหมด",
      text: "สินค้าที่เลือกมีบางรายการหมดสต็อกและถูกลบออกจากรายการ",
    });
  }
});



// watch(selectedIds, (newVal) => {
//   // กรองเอา id ของสินค้าที่ stock > 0 เท่านั้น
//   const filteredIds = newVal.filter(id => {
//     const product = tableData.value.find(p => p.id === id);
//     return product && product.stock > 0;
//   });

//   // ถ้า filteredIds ไม่ตรงกับ selectedIds แปลว่า มีสินค้าหมด stock ให้ลบออก
//   if (filteredIds.length !== newVal.length) {
//     selectedIds.value = filteredIds; // อัปเดต selectedIds ใหม่
//     Swal.fire({
//       icon: "warning",
//       title: "สินค้าในสต็อกหมด",
//       text: "สินค้าที่เลือกมีบางรายการหมดสต็อกและถูกลบออกจากรายการ",
//     });
//   }

//   const selectedPromotionProducts = tableData.value.filter(p =>
//     filteredIds.includes(p.id)
//   );
//   console.log("สินค้าที่เลือกอยู่ตอนนี้:", selectedPromotionProducts);
// });


// watch(selectedIds, (newVal) => {
//   const selectedPromotionProducts = tableData.value.filter(p =>
//     newVal.includes(p.id)
//   );
//   console.log("สินค้าที่เลือกอยู่ตอนนี้:", selectedPromotionProducts);
// });

// watch(pageSize, (newVal) => {
//   if (newVal !== 10) {
//     pageSize.value = 10;
//   }
// });

// 1. เก็บเฉพาะรายการสินค้า (ไม่ใช่ header) เพื่อ paginate
const onlyItems = computed(() => {
  return groupedTableData.value.filter(item => !item.isHeader);
});

// 2. paginate เฉพาะรายการสินค้า
const pagedItems = computed(() => {
  const start = (pageCurrent.value - 1) * pageSize.value;
  const end = start + pageSize.value;
  return onlyItems.value.slice(start, end);
});

// 3. สร้าง array ใหม่สำหรับแสดงในตาราง แทรก header ก่อนรายการ item ของกลุ่มนั้นๆ
const pagedItemsWithHeaders = computed(() => {
  // เก็บ header ที่ถูกแทรกไปแล้ว (เพื่อไม่ให้ซ้ำ)
  const insertedHeaders = new Set();

  // สร้างผลลัพธ์ใหม่
  const result = [];

  // เราต้องรู้ว่าแต่ละ item อยู่ในกลุ่ม promotion ไหน
  // สมมติ item มี pro_activity_id เป็น group id
  for (const item of pagedItems.value) {
    const groupId = item.pro_activity_id;

    if (!insertedHeaders.has(groupId)) {
      // แทรก header ก่อนกลุ่มสินค้านี้
      const headerTitle = promotionTitleMap.value[groupId] || "โปรโมชั่นไม่ระบุ";
      result.push({
        isHeader: true,
        pro_activity_id: groupId,
        promotionTitle: headerTitle,
      });
      insertedHeaders.add(groupId);
    }
    // แทรก item ต่อไป
    result.push(item);
  }

  return result;
});

const isAllSelected = computed(() => {
  // เอาเฉพาะ item ในหน้า (ไม่ใช่ header)
  const itemsOnPage = pagedItemsWithHeaders.value.filter(item => !item.isHeader);
  return itemsOnPage.length > 0 && itemsOnPage.every(item => selectedIds.value.includes(item.id));
});


function toggleSelectAll(event) {
  const checked = event.target.checked;

  // const pageIds = pagedItems.value.map(item => item.id);

  // เลือกเฉพาะ item ที่ stock > 0 เพื่อเอา id ไปติ๊ก
  const pageIds = [];
  pagedItems.value.forEach(item => {
    if (item.stock > 0) {
      if (checked) {
        item.amount = 1; // กำหนดจำนวนเป็น 1
      } else {
        item.amount = 0; // ถ้าไม่ติ๊กตั้ง amount เป็น 0
      }
      pageIds.push(item.id);
    } else {
      // stock ≤ 0 ข้ามเลย ไม่ติ๊ก และ amount = 0
      item.amount = 0;
    }
  });

  if (checked) {

    console.log('Check pagedItems.value:', pagedItems.value)
    // ติ๊กทั้งหมดที่ stock > 0
    selectedIds.value = Array.from(new Set([...selectedIds.value, ...pageIds]));

    // ติ๊กทั้งหมดในหน้า (รวมกับรายการที่เลือกก่อนหน้าแล้ว)
    // selectedIds.value = Array.from(new Set([...selectedIds.value, ...pageIds]));
    // pagedItems.value.forEach(item => {
    //   if (!item.amount || item.amount === 0) item.amount = 1;
    // });

  } else {
    console.log('🚫 Deselected selectedIds:', pageIds);
    // ยกเลิกติ๊กทั้งหมดในหน้า
    // ยกเลิกติ๊กทั้งหมดที่ stock > 0
    selectedIds.value = selectedIds.value.filter(id => !pageIds.includes(id));
    // selectedIds.value = selectedIds.value.filter(id => !pageIds.includes(id));
    // pagedItems.value.forEach(item => {
    //   item.amount = 0;
    // });
  }
}

// // function เลือกสินค้าทั้งหมด
// function toggleSelectAll(event) {
//   if (event.target.checked) {
//     const pageIds = [];
//     paginatedPromotion.value.forEach(item => {
//       if (item.stock > 0) {
//         item.amount = 1; // กำหนดจำนวนให้เท่ากับ stock
//         pageIds.push(item.pro_sku_price_id);    // เพิ่มเฉพาะ id ที่ stock > 0
//         // pageIds.push(item.id);    // เพิ่มเฉพาะ id ที่ stock > 0
//       } else {
//         item.amount = 0; // ถ้า stock ≤ 0 ให้ใส่เป็น 0
//       }
//     });


//     selectedIds.value = [...new Set([...selectedIds.value, ...pageIds])];

//     console.log('✅ Check paginatedPromotion.value : ', paginatedPromotion.value);
//   } else {
//     console.log('✅ toggleSelectAll selectedIds (stock > 0 only):', pageIds);
//     const pageIds = paginatedPromotion.value.map(item => item.pro_sku_price_id);
//     // const pageIds = paginatedPromotion.value.map(item => item.id);
//     selectedIds.value = selectedIds.value.filter(pro_sku_price_id => !pageIds.includes(pro_sku_price_id));
//     // selectedIds.value = selectedIds.value.filter(id => !pageIds.includes(id));
//     console.log('🚫 Deselected selectedIds:', pageIds);

//     // เคลียร์ amount ตอนยกเลิกติ๊ก ถ้าต้องการ
//     paginatedPromotion.value.forEach(item => {
//       item.amount = 0;
//     });
//   }
// }




async function getPromotionProducts() {
  isLoading.value = true;

  const gettoken = localStorage.getItem('token');

  const requests = props.selectedPromotion.map(async promo => {
    const activity_id = promo.pro_m_id;

    try {
      const response = await axios.post(
        // manual pageSize = 500
        // `${BASE_URL}/goods2/activitybackend?activity_id=${activity_id}&page=1&pageSize=100&proid=&keywords=`,
        `${BASE_URL}/goods2/activitybackendV2?activity_id=${activity_id}&page=1&pageSize=100&proid=&keywords=`,
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
      // const conditionPriceList  = activityData.activity_sku_price.condition_price || [];

      // รวม condition_price ของ sku ทั้งหมด
      const allConditionPrices = skuList.flatMap(sku => sku.condition_price || []);

      // เก็บ condition_price แยกตาม activity_id ไว้ใน map เพื่อเรียกใช้งานทีหลังได้
      conditionPriceMap.value[activity_id] = allConditionPrices;

      return skuList.map(sku => ({
        ...sku,
        activity_id: activityData.id || 0, // 1167
        pro_activity_id: activityData.id || 0, // 1167
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



// สร้าง map pro_activity_id => promotionTitle จาก props.selectedPromotion
const promotionTitleMap = computed(() => {
  const map = {};
  props.selectedPromotion.forEach(promo => {
    map[promo.pro_m_id] = promo.pro_m_title || promo.title || "โปรโมชั่นไม่ระบุ";
  });
  return map;
});

const groupedTableData = computed(() => {
  const groups = {};

  tableData.value.forEach(item => {
    const groupId = item.pro_activity_id;
    if (!groups[groupId]) {
      groups[groupId] = {
        promotionTitle: promotionTitleMap.value[groupId] || "โปรโมชั่นไม่ระบุ",
        pro_activity_id: groupId,
        items: []
      };
    }
    groups[groupId].items.push(item);
  });

  const result = [];
  Object.values(groups).forEach(group => {
    result.push({
      isHeader: true,
      promotionTitle: group.promotionTitle,
      pro_activity_id: group.pro_activity_id
    });
    result.push(...group.items);
  });

  return result;
});


// function handlePromotionSet(activityId) {
//   const conditionPrices = conditionPriceMap.value[activityId] || [];
//   const fullStr = conditionPrices[0]?.full || "0";
//   const fullNum = Number(fullStr);

//   if (isNaN(fullNum)) {
//     console.log("ค่า full ไม่ใช่ตัวเลข:", fullStr);
//     return;
//   }

//   // 1) อัปเดตจำนวนครั้งที่กด
//   clickCountByPromotion.value[activityId] =
//     (clickCountByPromotion.value[activityId] || 0) + 1;

//   // 2) อัปเดตยอดรวมเต็ม (fullNum * จำนวนครั้ง)
//   totalFullByPromotion.value[activityId] =
//     (totalFullByPromotion.value[activityId] || 0) + fullNum;

//   console.log(`Promotion ${activityId} → Click count = ${clickCountByPromotion.value[activityId]}, Total full = ${totalFullByPromotion.value[activityId]}`);


//   // 3) อัปเดตจำนวนสินค้าในตาราง
//   tableData.value.forEach(item => {
//     if (item.pro_activity_id === activityId && item.stock > 0) {
//       const oldItem = props.selectProducts_old.find(p =>
//         p.pro_activity_id === item.pro_activity_id &&
//         p.pro_sku_price_id === item.id
//       );
//       const oldAmount = oldItem ? Number(oldItem.pro_quantity || oldItem.pro_goods_num || 0) : 0;

//       // คำนวณจำนวนที่จะใส่ใหม่
//       const desiredAmount = totalFullByPromotion.value[activityId];
//       const maxAllowAmount = Math.max(item.stock - oldAmount, 0);

//       if (desiredAmount > maxAllowAmount) {
//         Swal.fire({
//           icon: 'warning',
//           title: 'จำนวนสินค้าเกินสต๊อก',
//           text: `คุณเลือกสินค้าเกินกว่าสต๊อกที่มีอยู่ (${desiredAmount}/${item.stock})`
//         });
//         item.amount = maxAllowAmount;
//       } else {
//         item.amount = desiredAmount;
//       }

//       if (!selectedIds.value.includes(item.id)) {
//         selectedIds.value.push(item.id);
//       }
//     }
//   });

//   // 3) อัปเดตจำนวนสินค้าในตาราง
//   // tableData.value.forEach(item => {
//   //   if (item.pro_activity_id === activityId && item.stock > 0) {
//   //     if (!selectedIds.value.includes(item.id)) selectedIds.value.push(item.id);
//   //     item.amount = totalFullByPromotion.value[activityId];
//   //   }
//   // });

// }

function handlePromotionSet(activityId) {
  const conditionPrices = conditionPriceMap.value[activityId] || [];
  const fullStr = conditionPrices[0]?.full || "0";
  const fullNum = Number(fullStr);

  if (isNaN(fullNum) || fullNum <= 0) {
    console.log("ค่า full ไม่ถูกต้อง:", fullStr);
    return;
  }

  // คำนวณจำนวนสูงสุดที่สามารถเพิ่มได้จาก stock
  let totalAvailableStock = 0;
  tableData.value.forEach(item => {
    if (item.pro_activity_id === activityId) {
      const oldItem = props.selectProducts_old.find(p =>
        p.pro_activity_id === item.pro_activity_id &&
        p.pro_sku_price_id === item.id
      );
      const oldAmount = oldItem ? Number(oldItem.pro_quantity || oldItem.pro_goods_num || 0) : 0;
      const currentAmount = Number(item.amount || 0);
      const remainingStock = Math.max(item.stock - oldAmount, 0);
      totalAvailableStock += remainingStock - currentAmount;
    }
  });

  // ตรวจสอบว่ามี stock เหลือพอสำหรับ fullNum หรือไม่
  if (totalAvailableStock < fullNum) {
    Swal.fire({
      icon: 'warning',
      title: 'สต๊อกสินค้าไม่เพียงพอ',
      text: `ไม่สามารถเพิ่มเซ็ตได้อีก เพราะเกินจำนวนสต๊อกที่มีอยู่`
    });
    return; // ❌ หยุดการเพิ่ม set
  }

  // ✅ เพิ่มจำนวน set ได้
  clickCountByPromotion.value[activityId] =
    (clickCountByPromotion.value[activityId] || 0) + 1;

  totalFullByPromotion.value[activityId] =
    (totalFullByPromotion.value[activityId] || 0) + fullNum;

  console.log(`Promotion ${activityId} → Click count = ${clickCountByPromotion.value[activityId]}, Total full = ${totalFullByPromotion.value[activityId]}`);

  // 🔄 อัปเดตจำนวนสินค้าในตาราง
  tableData.value.forEach(item => {
    if (item.pro_activity_id === activityId && item.stock > 0) {
      const oldItem = props.selectProducts_old.find(p =>
        p.pro_activity_id === item.pro_activity_id &&
        p.pro_sku_price_id === item.id
      );
      const oldAmount = oldItem ? Number(oldItem.pro_quantity || oldItem.pro_goods_num || 0) : 0;
      const maxAllowAmount = Math.max(item.stock - oldAmount, 0);
      const desiredAmount = totalFullByPromotion.value[activityId];

      item.amount = desiredAmount > maxAllowAmount ? maxAllowAmount : desiredAmount;

       // เลือกเฉพาะตัวแรกของโปรนั้น
      // ใช้ key ที่ unique ต่อโปร
      const uniqueKey = `${activityId}-${item.id}`;

      const alreadySelectedForThisPromo = selectedIds.value.includes(uniqueKey);

      if (!alreadySelectedForThisPromo) {
        selectedIds.value.push(uniqueKey);
      }

      // if (!selectedIds.value.includes(item.id)) {
      //   selectedIds.value.push(item.id);
      // }
    }
  });
}

function decrementPromotionSet(activityId) {
  const currentClick = clickCountByPromotion.value[activityId] || 0;
  // const currentFull = totalFullByPromotion.value[activityId] || 0;

  if (currentClick <= 0) return; // ไม่มีให้ลด

  const fullStr = conditionPriceMap.value[activityId]?.[0]?.full || "0";
  const fullNum = Number(fullStr);

  if (isNaN(fullNum) || fullNum <= 0) {
    console.warn("ค่า full ไม่ถูกต้อง:", fullStr);
    return;
  }

  // 1) ลดจำนวนครั้ง
  clickCountByPromotion.value[activityId] = currentClick - 1;

  // 2) ลดยอดรวมเต็ม
  // totalFullByPromotion.value[activityId] = currentFull - fullNum;
  totalFullByPromotion.value[activityId] =
    Math.max((totalFullByPromotion.value[activityId] || 0) - fullNum, 0);

  console.log(`Promotion ${activityId} → Click count = ${clickCountByPromotion.value[activityId]}, Total full = ${totalFullByPromotion.value[activityId]}`);

    tableData.value.forEach(item => {
    if (item.pro_activity_id === activityId && item.stock > 0) {
      // ❗ แก้ตรงนี้ → ลดทีละ fullNum ไม่ให้ติดลบ
      item.amount = Math.max((item.amount || 0) - fullNum, 0);

      const uniqueKey = `${activityId}-${item.id}`;

      if (item.amount <= 0) {
        // ถ้าเหลือ 0 → เอาออกจาก selectedIds
        selectedIds.value = selectedIds.value.filter(id => id !== uniqueKey);
      } else {
        // ถ้ายังมีอยู่ → ensure ว่าอยู่ใน selectedIds
        if (!selectedIds.value.includes(uniqueKey)) {
          selectedIds.value.push(uniqueKey);
        }
      }
    }
  });

   // ถ้า set ลดจนเหลือ 0 → reset ค่า
  // if (clickCountByPromotion.value[activityId] <= 0) {
  //   totalFullByPromotion.value[activityId] = 0;

  //   tableData.value.forEach(item => {
  //     if (item.pro_activity_id === activityId) {
  //       item.amount = 0;
  //       const uniqueKey = `${activityId}-${item.id}`;
  //       selectedIds.value = selectedIds.value.filter(id => id !== uniqueKey);
  //     }
  //   });

  //   return; // ออกเลย ไม่ต้องคำนวณต่อ
  // }

  // // 3) อัปเดตจำนวนสินค้าในตาราง
  //   tableData.value.forEach(item => {
  //     if (item.pro_activity_id === activityId && item.stock > 0) {
  //       item.amount = totalFullByPromotion.value[activityId];
  //       const uniqueKey = `${activityId}-${item.id}`;
  //       if (!selectedIds.value.includes(uniqueKey)) {
  //         selectedIds.value.push(uniqueKey);
  //       }
  //     }
  //   });
  // tableData.value.forEach(item => {
  //   if (item.pro_activity_id === activityId && item.stock > 0) {
  //     // ถ้ายังมีจำนวนเต็มให้แสดง
  //     if (totalFullByPromotion.value[activityId] > 0) {
  //       item.amount = totalFullByPromotion.value[activityId];

  //       // เพิ่มเข้า selectedIds ถ้ายังไม่มี
  //       const uniqueKey = `${activityId}-${item.id}`;
  //       if (!selectedIds.value.includes(uniqueKey)) {
  //         selectedIds.value.push(uniqueKey);
  //       }
  //     } else {
  //       // ถ้าเหลือ 0 ให้เคลียร์ออก ไม่ต้องแจ้งเตือนว่า stock หมด
  //       item.amount = 0;

  //       // เอาออกจาก selectedIds ด้วย
  //       const uniqueKey = `${activityId}-${item.id}`;
  //       selectedIds.value = selectedIds.value.filter(id => id !== uniqueKey);
  //     }
  //   }
  // });

  // 3) อัปเดตจำนวนสินค้าในตาราง
  // tableData.value.forEach(item => {
  //   if (item.pro_activity_id === activityId && item.stock > 0) {
  //     if (!selectedIds.value.includes(item.id)) selectedIds.value.push(item.id);
  //     item.amount = totalFullByPromotion.value[activityId];
  //   }
  // });
}


// เฝ้าดู tableData ทุกตัว amount ถ้า amount > 0 แต่ยังไม่ได้ติ๊ก checkbox ก็ให้ติ๊ก
// watch(tableData, (newTableData) => {
//   newTableData.forEach(item => {
//     if (item.stock === 0) {
//       // ถ้า stock = 0 ให้แน่ใจว่าไม่ถูกเลือก
//       selectedIds.value = selectedIds.value.filter(id => id !== item.id);
//       item.amount = 0;
//       return;
//     }

//     if (item.amount > 0 && !selectedIds.value.includes(item.id)) {
//       selectedIds.value.push(item.id);
//       console.log(`🟢 Auto select item id=${item.id} because amount > 0`);
//     } else if (item.amount === 0 && selectedIds.value.includes(item.id)) {
//       // ถ้าลบจำนวน = 0 แล้วก็ยกเลิกติ๊ก checkbox
//       selectedIds.value = selectedIds.value.filter(id => id !== item.id);
//       console.log(`🔴 Auto deselect item id=${item.id} because amount = 0`);
//     }
//   });
// }, { deep: true });

watch(tableData, (newTableData) => {
  newTableData.forEach(item => {
    if (item.amount > 0) {
      // **เพิ่มเช็ค stock ก่อน**
      if (item.stock > 0 && !selectedIds.value.includes(item.id)) {
        selectedIds.value.push(item.id);
      } else if (item.stock === 0 && selectedIds.value.includes(item.id)) {
        selectedIds.value = selectedIds.value.filter(id => id !== item.id);
        item.amount = 0;
      }
    } else if (item.amount === 0 && selectedIds.value.includes(item.id)) {
      selectedIds.value = selectedIds.value.filter(id => id !== item.id);
    }
  });
}, { deep: true });

// ปรับฟังก์ชัน handleCheckboxChange
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
    if (!selectedIds.value.includes(item.id)) {
      selectedIds.value.push(item.id);
    }

    if (!item.amount || item.amount === 0) {
      item.amount = 1; // กำหนดจำนวนเป็น 1 ถ้ายังไม่กำหนด
    }

  } else {
    selectedIds.value = selectedIds.value.filter(id => id !== item.id);
    item.amount = 0;
  }
}

function updateClickCountByPromotion(activityId) {
  const fullNum = Number(conditionPriceMap.value[activityId]?.[0]?.full || 1);
  if (fullNum <= 0) return;

  // หา total amount ของสินค้าทั้งหมดใน promotion นี้
  const totalAmount = tableData.value
    .filter(item => item.pro_activity_id === activityId)
    .reduce((sum, item) => sum + (Number(item.amount) || 0), 0);

  // คำนวณ click count = จำนวนเต็มของ full
  clickCountByPromotion.value[activityId] = Math.floor(totalAmount / fullNum);
}

// เรียกฟังก์ชันนี้ทุกครั้งที่ user blur ช่องจำนวน หรือ input
// function onAmountBlur(item) {
//   if (!item.amount || item.amount <= 0) {
//     // ลบออกจาก selectedIds
//     selectedIds.value = selectedIds.value.filter(id => id !== item.id);
//   } else {
//     if (!selectedIds.value.includes(item.id)) {
//       selectedIds.value.push(item.id);
//     }
//   }

//   // อัปเดต click count ของ promotion ตามจำนวนที่กรอก
//   updateClickCountByPromotion(item.pro_activity_id);
// }

function onAmountBlur(item) {
  if (!item.amount || item.amount === 0 || item.amount === '') {
    // ถ้า amount เป็น 0 หรือว่าง ให้เอา id ออกจาก selectedIds
    selectedIds.value = selectedIds.value.filter(id => id !== item.id);
  } else {
    // ถ้า amount > 0 และยังไม่ได้เลือก checkbox ให้เพิ่ม id
    if (!selectedIds.value.includes(item.id)) {
      selectedIds.value.push(item.id);
    }
  }
  // อัปเดต click count ของ promotion ตามจำนวนที่กรอก
  updateClickCountByPromotion(item.pro_activity_id);
}


function onlyNumberInput(event) {
  const key = event.key;
  // อนุญาตเฉพาะตัวเลข 0-9 เท่านั้น
  if (!/^\d$/.test(key)) {
    event.preventDefault();
  }
}


function validateAmount(item) {

  const oldItem = props.selectProducts_old.find(p =>
    p.pro_activity_id === item.activity_id &&
    p.pro_sku_price_id === item.id
  );

  const oldAmount = oldItem ? Number(oldItem.pro_quantity || oldItem.pro_goods_num || 0) : 0;
  const newAmount = Number(item.amount || 0);
  const stock = Number(item.stock || 0);

  const total = oldAmount + newAmount;

   // เช็คกรณีเลือกเกิน stock เท่านั้น
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

    // ✅ อัปเดต selectedIds อย่างมีเงื่อนไข
  const uniqueKey = `${item.activity_id}-${item.id}`;

  // ติ๊ก checkbox อัตโนมัติ
  if (item.amount > 0) {
    if (!selectedIds.value.includes(uniqueKey)) {
      selectedIds.value.push(uniqueKey);
    }
  } else {
    // ถ้าใส่ 0 หรือลบออก ให้เอาออกจาก selectedIds
    selectedIds.value = selectedIds.value.filter(id => id !== uniqueKey);
  }
  // if (item.amount > 0) {
  //   if (!selectedIds.value.includes(item.id)) {
  //     selectedIds.value.push(item.id);
  //   }
  // } else {
  //   // ถ้าใส่ 0 หรือลบออก ให้เอาออกจาก selectedIds
  //   selectedIds.value = selectedIds.value.filter(id => id !== item.id);
  // }

}

function searchPromotion_no() {


  if (keyword_promotion_product_no.value.trim()) {

    isLoading.value = true;

    const kw = keyword.value.trim().toLowerCase();
    const promoNo = keyword_promotion_product_no.value.trim().toLowerCase();

    console.log('promotionProducts.value: ', promotionProducts.value)

    console.log('keyword promoNo: ', promoNo)
    console.log('tableData.value: ', tableData.value)

    // กรองข้อมูล promotionProducts ตามเงื่อนไข AND
    const filtered = promotionProducts.value.filter(item => {
      const title = item.title ? item.title.toLowerCase() : '';
      const erp_title = item.erp_title ? item.erp_title.toLowerCase() : '';
      const activityCode = item.activity_code ? item.activity_code.toLowerCase() : '';
      const sn = item.sn ? item.sn.toLowerCase() : '';
      const goods_sku_text = item.goods_sku_text ? item.goods_sku_text.toLowerCase() : '';

      console.log('title: ', title)

      // ตรวจสอบว่า title ต้องมี keyword อยู่ (includes) แต่ activity_code ต้องตรงเป๊ะกับ promoNo
      const matchKeyword = kw ? title.includes(kw) || erp_title.includes(kw) : true;
      // const matchKeyword = kw ? erp_title.includes(kw) : true;
      const matchPromoNo = promoNo ? title.includes(promoNo) || erp_title.includes(promoNo) || activityCode.includes(promoNo) || sn.includes(promoNo) || goods_sku_text.includes(promoNo) : true;
      // const matchPromoNo = promoNo ? activityCode === promoNo : true;

      console.log('matchKeyword: ', matchKeyword)
      console.log('matchPromoNo: ', matchPromoNo)

      return matchKeyword && matchPromoNo;
    });

    console.log('filtered:', filtered);

    tableData.value = filtered;

    dataselectpromotion_no.value = filtered;
    tableData.value = [...filtered];
    total.value = filtered.length;
    pageSize.value = (total.value < pageSize.value)
      ? total.value
      : parseInt(pageSize.value);

    pageCurrent.value = 1; // รีเซ็ตไปหน้าแรก

    console.log('tableData.value:', tableData.value);

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

    // กำหนด ให้ pageSize มีค่า default = 10 1 หน้า แล้วทำการเรียกฟังก์ชัน SearchPromotionSubmit
    // โดยมีเงื่อนไขว่า ถ้าค่าตัวของฟังก์ชัน searchPromotion_no ที่ keyword_promotion_no เป็นค่าว่าง ให้เข้าเงื่อนไขนี้
    pageSize.value = 10;

    SearchPromotionSubmit();

    isLoading.value = false;

  }
}



async function SearchPromotionSubmit() {
  clearTimeout(searchTimer.value);

  isLoading.value = true;

  const getLevelSS = JSON.parse(localStorage.getItem('selectDataCustomer'));
  // const getLevel = getLevelSS?.data2?.level ?? 0;

  memberType.value= getLevelSS?.data2?.level_name ?? '';

  console.log("ประเภทสมาชิกที่ได้จาก level: ", memberType.value);

  // เช็กว่ามีการเลือกร้านค้าหรือยัง
  if (!getLevelSS?.data2) {
    noCustomerSelected.value = true;
    tableData.value = [];
    isLoading.value = false; // ปิด loading
    return; // ออกจากฟังก์ชันเลย
  } else {
    noCustomerSelected.value = false;
  }

  // if (getLevel === 0) {
  //   memberType.value = 'Member End User';
  // } else if (getLevel === 1) {
  //   memberType.value = 'Member A';
  // } else if (getLevel === 7) {
  //   memberType.value = 'Member B';
  // } else if (getLevel === 10) {
  //   memberType.value = 'Member A+';
  // } else {
  //   memberType.value = 'Unknown Member';
  // }

  if (!keyword.value.trim()) {
    try {
      // แทนที่ API ด้วยการใช้ข้อมูลจาก getPromotionProducts()
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

      pageCurrent.value = 1; // รีเซ็ตไปหน้าแรก

      isLoading.value = false;

    } catch (err) {
      console.error("❌ SearchPromotionSubmit error:", err);
      isLoading.value = false;
    } finally {
      // ปิด loading ไม่ว่าจะพบข้อมูลหรือไม่
      isLoading.value = false;
    }

  } else {
    try {
      isLoading.value = true;
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
      pageCurrent.value = 1; // รีเซ็ตไปหน้าแรก

      isLoading.value = false;

    } catch (err) {
      console.error("❌ SearchPromotionSubmit error:", err);
      isLoading.value = false;
    } finally {
      // ✅ ปิด loading ไม่ว่าจะพบข้อมูลหรือไม่
      isLoading.value = false;
    }
  }
}




async function confirmSelection() {

  // activity_code :"P02-ZZ-9999"
  // activity_id :1178

  // ✅ ใช้งานได้เลยโดยไม่ต้อง .value
  console.log('🔥 selectedProducts_old:', props.selectProducts_old);

  // ✅ ถ้าต้องการเก็บในตัวแปร
  // const get_productOld = props.selectedProducts_old;
  // console.log('🎯 get_productOld:', get_productOld);

  // const get_productOld = (props.selectProducts_old || []).map(p => p);

  // const get_productOld_raw = (props.selectProducts_old || []).map(p => ({ ...p }));
  // let get_productOld_raw = (props.selectProducts_old || []).map(p => ({
  //   ...p,
  //   pro_sku_price_id: p.pro_id,
  //   pro_units: p.pro_unit,
  //   pro_image: p.pro_images,
  //   pro_goods_price: p.pro_unit_price

  // }));

  // console.log('🎯 get_productOld:', get_productOld_raw);

  let get_productOld_raw = (props.selectProducts_old || []).map(p => ({
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

  // ✅ ตรวจสอบว่ามีสินค้าใดใน get_productOld_raw ที่ไม่มี stock
  // const missingStock = get_productOld_raw.some(x => x.stock == null || undefined);
  // if (missingStock) {
  //   console.warn('ขาด stock, เรียก API ดึง stock');
  //   // รอรับ array ใหม่ แล้วไปแทนที่ get_productOld_raw
  //   try {
  //   const result = await submittedProduct_Stock(get_productOld_raw);
  //   get_productOld_raw = Array.isArray(result) ? result : [];
  // } catch (error) {
  //   console.error('เกิดข้อผิดพลาดขณะดึง stock:', error);
  //   get_productOld_raw = [];
  // }
  //   // get_productOld_raw = await submittedProduct_Stock(get_productOld_raw);
  //   // console.log('🎯 get_productOld_raw:', get_productOld_raw);
  // }
  // const isMissingStock = get_productOld_raw.some(item => item.stock === undefined || item.stock === null);

  // // ✅ ถ้ามีสินค้าใดไม่มี stock → เรียก API ดึงข้อมูลใหม่
  // if (isMissingStock) {
  //   console.warn('📦 บางรายการไม่มีข้อมูล stock → เรียก API ดึงข้อมูลสต๊อก');

  //   // 🔁 เรียก API เพื่อดึง stock (สมมุติว่าคุณมีฟังก์ชัน loadStockData อยู่แล้ว)
  //   await submittedProduct_Stock(get_productOld_raw);

  //   return; // ❌ หยุดการทำงานต่อจนกว่าจะได้ข้อมูล stock
  // }

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


  const sum_products = [
    ...(Array.isArray(get_productOld_raw) ? get_productOld_raw : []),
    ...selectedPromotionProducts
  ];

  // const sum_products = [...get_productOld_raw, ...selectedPromotionProducts];

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

  // const productErrors = [];

  // const grouped = groupBy(sum_products, item => `${item.pro_activity_id}_${item.pro_sku_price_id}`);
  // const groupedArray = Object.values(grouped);

  // // 🔁 รวมสินค้า "ธรรมดา" กับ "โปรโมชัน" ที่เป็นสินค้าเดียวกัน (pro_sku_price_id ตรงกัน)
  // const mergedProductsMap = new Map();

  // const hasPromo = (data) =>
  //   data.pro_activity_id !== undefined &&
  //   data.pro_activity_id !== null &&
  //   data.pro_activity_id !== 0 &&
  //   data.pro_activity_id !== "0";

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
  //       // (!existing.pro_activity_id && item.pro_activity_id) ||
  //       // (existing.pro_activity_id && !item.pro_activity_id)
  //       (hasPromo(existing) && !hasPromo(item)) ||
  //       (!hasPromo(existing) && hasPromo(item))
  //     ) {
  //       // รวมจำนวน
  //       const totalQty =
  //         (Number(existing.pro_goods_num) || 0) +
  //         (Number(item.pro_goods_num) || 0);

  //       // คัดลอกค่าโดยอิงจากตัวที่เป็นโปรโมชันไว้เป็นหลัก
  //       // const promoData = existing.pro_activity_id ? existing : item;
  //       const promoData = hasPromo(item) ? item : existing;

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

  // 👇 ใช้ grouped เดิมเพื่อส่งข้อมูลต่อ
  // const grouped = groupBy(sum_products, item => `${item.pro_activity_id}_${item.pro_sku_price_id}`);
  // const groupedArray = Object.values(grouped);
  // console.log('🔹 grouped:', grouped);
  // console.log('🔹 groupedArray:', groupedArray);

  // 🔄 ใช้ mergedProducts แทน sum_products
  // const grouped = groupBy(mergedProducts, item => `${item.pro_activity_id}_${item.pro_sku_price_id}`);

  // ใช้ได้
  // สร้าง grouped ทั้งหมดจาก sum_products
  const grouped = groupBy(sum_products, item => `${item.pro_activity_id}_${item.pro_sku_price_id}`);

  // แยก grouped สำหรับ last_quantity เก็บจาก selectedPromotionProducts (รายการเพิ่มใหม่)
  const groupedLastQuantity = groupBy(selectedPromotionProducts, item => `${item.pro_activity_id}_${item.pro_sku_price_id}`);
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
  });

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

  console.log('✅ สินค้าทั้งหมดผ่านการตรวจสอบ stock');

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
  console.log('✅ Grouped  result groupedArray:', groupedLastQuantity);
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
      const datasumdiscount = response.data.data;

      console.log("Check Value data:", data);

      // แยกข้อมูลออกเป็น 3 ก้อน
      // const items = data.filter(item => item?.pro_goods_id !== 0 && !item?.pro_title && item?.note === 'รายการ');
      // const gifts = data.filter(item => item?.pro_goods_id !== 0 && item?.pro_title && item?.note === 'ของแถม');
      // const promotions = data.filter(item => item?.pro_goods_id === 0 && item?.pro_title && item?.note === 'โปรโมชั่น');

      // ใช้ได้
      // แยกข้อมูลออกเป็น 3 ก้อน //  ,
      // const items = data.filter(item => item.pro_goods_id !== 0 && item?.ML_Note === 'item' || item?.ML_Note === 'itemmonth');
      // const gifts = data.filter(item => item.pro_goods_id !== 0 && item?.ML_Note === 'zengsopng_day');
      const items = data.filter(item => item.pro_goods_id !== 0 && item?.ML_Note === 'item' || item?.ML_Note === 'itemmonth');
      const gifts = data.filter(item => item.pro_goods_id !== 0 && item?.ML_Note === 'zengsopng_day' || item?.ML_Note === 'zengsopng_month');
      const promotions = data.filter(item => item.pro_activity_id !== 0 && item?.ML_Note === 'promotion_day' || item?.ML_Note === 'promotion_month');
      // const promotionsmonth = data.filter(item => item.pro_activity_id !== 0 && item?.ML_Note === 'promotion_month');
      // const giftsmonth = data.filter(item => item.pro_goods_id !== 0 && item?.ML_Note === 'zengsopng_month');

      const emitTitles = newproduct.map(p => ({
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

      emit('selectPromotionProducts', {
        // emit('select-promotion_products', {
        // ใช้ได้
        items,
        gifts,
        promotions,
        // promotionsmonth,
        // giftsmonth,
        emitTitles,
        datasumdiscount
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

    // const apiData = response.data.data.products || [];

    // console.log("✅ apiData from API:", apiData);

    // // แปลง apiData เป็นก้อนข้อมูลตามที่ต้องการ
    // const processed = apiData.map(item => {
    //   const activityId = item.st === false ? 0 : Number(item.pro_activity_id);
    //   const proSku = item.pro_sku_price_id;
    //   const matchedTitle = rawProducts.find(p =>
    //     p.pro_goods_id == item.pro_goods_id &&
    //     p.pro_sku_price_id == proSku
    //   ) || {};

    //   // กรอง FinalGifts / FinalPromotions ตามเงื่อนไขเดิม
    //   const FinalGifts = apiData.filter(g =>
    //     g.pro_activity_id === activityId && g.st === item.st && g.ML_Note.startsWith('zeng')
    //   );
    //   const FinalPromotions = apiData.filter(promo =>
    //     promo.st === item.st &&
    //     (item.st ? promo.pro_activity_id === activityId : true) &&
    //     promo.ML_Note.startsWith('promotion')
    //   );

    //   return {
    //     item_id: 0,
    //     pro_id: proSku,
    //     activity_id: activityId,
    //     pro_activity_id: item.pro_activity_id,
    //     pro_goods_id: item.pro_goods_id,
    //     st: item.st,
    //     pro_erp_title:
    //       matchedTitle.pro_erp_title === 0
    //         ? matchedTitle.pro_title
    //         : matchedTitle.pro_erp_title || item.pro_erp_title || '',
    //     pro_title: matchedTitle.pro_title || item.pro_title || '',
    //     pro_unit_price: item.pro_goods_price || '',
    //     pro_goods_sku_text: item.pro_goods_sku_text || '',
    //     pro_sn: matchedTitle.pro_sn || item.pro_sn || '',
    //     prosn: item.prosn || '',
    //     pro_images: item.pro_image || '',
    //     pro_quantity: item.pro_goods_num || 0,
    //     pro_goods_num: item.pro_goods_num || 0,
    //     pro_units: matchedTitle.pro_units || item.pro_units || '',
    //     pro_stock: item.stock || 0,
    //     pro_sku_price_id: proSku,
    //     gifts: FinalGifts,
    //     promotions: FinalPromotions
    //   };
    // });

    // console.log("📋 รายการสินค้าในตาราง:", processed);
    // emit('close'); //

    // // return processed;
    // return Array.isArray(processed) ? processed : [];



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

      // ทำการตรวจสอบข้อมูลที่ได้รับกลับมา
      // if (data.length > 0) {
      //   Swal.fire({
      //     title: 'สำเร็จ',
      //     text: 'ข้อมูลถูกส่งกลับไปยังหน้าหลักเรียบร้อยแล้ว',
      //     icon: 'success',
      //   });

      // } else {
      //   Swal.fire({
      //     title: 'ไม่มีสินค้า',
      //     text: 'ไม่พบสินค้าที่เลือกในระบบ!',
      //     icon: 'warning',
      //   });
      // }

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

              // gifts: gifts != item.pro_activity_id ? promotionActivityId : gifts,
              // promotions: promotions != item.pro_activity_id ? promotionActivityId : promotions,

              // กรองเฉพาะของที่ activity_id ตรงกัน
              gifts: FinalGifts,
              promotions: FinalPromotions,

              // gifts: gifts.filter(gift => gift.pro_activity_id === item.pro_activity_id),
              // promotions: promotions.filter(promo => promo.pro_activity_id === item.pro_activity_id)

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


      // console.log("📋 รายการสินค้าในตาราง:", selectedProducts);
      //  emit('close'); //

      // emit('selectPromotionProducts', {
      //   // emit('select-promotion_products', {
      //   // ใช้ได้
      //   items,
      //   gifts,
      //   promotions,
      //   emitTitles
      // });

      // emit('close'); //



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
//         getProduct(1);
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


<!-- <button @click="handlePromotionSet(row.pro_activity_id)"
    class="ml-2 px-2 py-1 bg-green-500 text-white rounded flex items-center gap-2">
    <span @click.stop="decrementPromotionSet(row.pro_activity_id)" class="cursor-pointer select-none">-</span>
      <span>{{ clickCountByPromotion[row.pro_activity_id] || 0 }}</span>
    <span @click.stop="handlePromotionSet(row.pro_activity_id)" class="cursor-pointer select-none">+</span>
  </button> -->




<!-- // function handlePromotionSet(activityId) {
//   const conditionPrices = conditionPriceMap.value[activityId] || [];

//   // สมมติเอา full ของ item แรกมาใช้ (ปรับตามต้องการ)
//   const fullStr = conditionPrices[0]?.full || "0";
//   const fullNum = Number(fullStr);

//   if (isNaN(fullNum)) {
//     console.log("ค่า full ไม่ใช่ตัวเลข:", fullStr);
//     return;
//   }

//   // เก็บจำนวนสะสมแบบเดิม
//   const currentTotal = totalFullByPromotion.value[activityId] || 0;

//   // บวกเพิ่ม
//   const newTotal = currentTotal + fullNum;

//   totalFullByPromotion.value[activityId] = newTotal;

//   console.log(`Promotion ID: ${activityId} full สะสม = ${newTotal}`);

//   // ตัวอย่าง: อัพเดตจำนวนสินค้าทั้งกลุ่มให้เท่ากับ newTotal
//   tableData.value.forEach(item => {
//     if (item.pro_activity_id === activityId) {
//       if (item.stock > 0) {
//         if (!selectedIds.value.includes(item.id)) selectedIds.value.push(item.id);
//         item.amount = newTotal;
//       }
//     }
//   });
// } -->

<!--
  // // บวกเพิ่มทีละ 1 ชุด
  // const currentTotal = totalFullByPromotion.value[activityId] || 0;
  // const newTotal = currentTotal + fullNum;  // เพิ่มทีละ 1

  // totalFullByPromotion.value[activityId] = newTotal;

  // console.log(`Promotion ID: ${activityId} full สะสม = ${newTotal}`);

  // tableData.value.forEach(item => {
  //   if (item.pro_activity_id === activityId) {
  //     if (item.stock > 0) {
  //       if (!selectedIds.value.includes(item.id)) selectedIds.value.push(item.id);
  //       item.amount = newTotal;
  //     }
  //   }
  // }); -->


<!-- // function toggleSelectAll(event) {
//   if (event.target.checked) {
//     const pageIds = paginatedPromotion.value.map(item => item.id)
//     selectedIds.value = [...new Set([...selectedIds.value, ...pageIds])]

//     console.log('toggleSelectAll selectedIds:', pageIds);
//   } else {
//     const pageIds = paginatedPromotion.value.map(item => item.id)
//     selectedIds.value = selectedIds.value.filter(id => !pageIds.includes(id))
//     console.log('Error selectedIds:', pageIds);
//   }
// } -->


<!--

// function handleCheckboxChange(item, event) {
//   if (event.target.checked) {
//     // ติ๊กเลือก
//      console.log(`✅ Selected item:`, item)
//     selectedIds.value.push(item.id)

//         // บังคับให้ค่าในตารางเปลี่ยนทันที
//         // 1) บังคับให้ amount = 1
//     if (!item.amount || item.amount === 0) {
//       item.amount = 1;
//     }

//     // เก็บ id
//     if (!selectedIds.value.includes(item.id)) {
//       selectedIds.value.push(item.id);
//     }

//      // เก็บ object ไว้ใน selectedProducts
//     if (!selectedProducts.value.find(p => p.id === item.id)) {
//       selectedProducts.value.push({ ...item})
//       // selectedProducts.value.push(item)    // เอา item ตรงๆ มาเก็บ ไม่ต้อง ...item
//     }

//   } else {
//     // ยกเลิก
//     console.log(`❌ Deselected item:`, item)
//     item.amount = 0;
//     selectedIds.value = selectedIds.value.filter(id => id !== item.id)
//     selectedProducts.value = selectedProducts.value.filter(p => p.id !== item.id)
//   }
// }



// function handleCheckboxChange(item, event) {
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
// } -->




<!-- // function decrementPromotionSet(activityId) {
//   if (!totalFullByPromotion.value[activityId]) return;
//   let current = totalFullByPromotion.value[activityId];
//   if (current > 0) {
//     totalFullByPromotion.value[activityId] = current - 1;
//   }
//   // อัปเดต tableData ตามจำนวนใหม่ได้ถ้าต้องการ (คล้าย handlePromotionSet)
//   tableData.value.forEach(item => {
//     if (item.pro_activity_id === activityId) {
//       if (item.stock > 0) {
//         if (!selectedIds.value.includes(item.id)) selectedIds.value.push(item.id);
//         item.amount = totalFullByPromotion.value[activityId];
//       }
//     }
//   });
// } -->




<!-- // const searchPromotion_no = async () => {
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

 -->



<!-- //page = 1
// async function getPromotionProducts() {
//   isLoading.value = true;

//   const gettoken = localStorage.getItem('token');

//   const requests = props.selectedPromotion.map(async promo => {
//     const activity_id = promo.pro_m_id;

//     try {
//       const response = await axios.post(
//         // manual pageSize = 500
//         `${BASE_URL}/goods2/activitybackend?activity_id=${activity_id}&page=1&pageSize=500&proid=&keywords=`,
//         {},
//         {
//           headers: {
//             'Content-Type': 'application/json',
//             token: gettoken
//           }
//         }
//       );

//       const activityData = response.data.data;

//       console.log("✅ ดึงข้อมูลโปรโมชันทั้งหมด:", activityData);

//       const skuList = activityData.activity_sku_price || [];

//       return skuList.map(sku => ({
//         ...sku,
//         activity_id: activityData.id || 0, // 1167
//         pro_activity_id: activityData.id || 0, // 1167
//         goods_id: sku.goods_id, // 13872
//         pro_sku_price_id: sku.sku_price_id, // 50983
//         erp_title: sku.erp_title, // "ADAPTER SET AG-201 FOR TYPE C TO LIGHTNING PD 20W BLUE DP"
//         title: sku.title, // ชุดอะแดปเตอร์เซ็ต AG-201 (20W)
//         image: sku.image, // /uploads/20240201/eaf550db288e6e947c8b3e70753f6a28.
//         goods_price: sku.goods_price, // "215.00"

//         activity_code: activityData.activity_code, // x
//         pro_m_code: activityData.activity_code, // x
//         pro_acm_id: activityData.id, // x
//         sn: sku.sn, // x
//         goods_sku_text: sku.goods_sku_text, // x
//         units: sku.units // x
//       }));
//     } catch (err) {
//       console.error(`❌ Error loading products for activity_id=${activity_id}`, err);
//       return []; // ถ้า error ให้ส่ง array ว่าง
//     }
//   });

//   // ส่งทุก request พร้อมกัน
//   const allResultsArrays = await Promise.all(requests);
//   const allResults = allResultsArrays.flat(); // รวมทุก array เข้าเป็น array เดียว

//   tableData.value = allResults;
//   promotionProducts.value = allResults;
//   total.value = allResults.length;

//   console.log("✅ ดึงข้อมูลสินค้าครบทั้งหมด:", allResults);
//   isLoading.value = false;
// } -->



<!-- <tbody v-if="!isLoading">
    <tr v-for="(row, index) in groupedTableData" :key="index">

      <template v-if="row.isHeader">
        <td colspan="11" class="px-2 py-3 bg-blue-100 text-start">
          {{ row.promotionTitle }}
          <div
            class="ml-2 px-4 py-1 bg-gradient-to-r from-green-500 to-green-600 text-white rounded-xl inline-flex items-center gap-3 shadow-lg">
            <span @click="decrementPromotionSet(row.pro_activity_id)"
              class="cursor-pointer select-none text-lg font-bold hover:text-yellow-300 transition-colors">-</span>

            <span class="text-md font-semibold">{{ clickCountByPromotion[row.pro_activity_id] || 0 }}
              เซ็ต</span>

            <span @click="handlePromotionSet(row.pro_activity_id)"
              class="cursor-pointer select-none text-lg font-bold hover:text-yellow-300 transition-colors">+</span>
          </div>

        </td>
      </template>


      <template v-else>
        <td class="px-4 py-2 border text-center">
          <input type="checkbox" v-model="selectedIds" :value="row.id"
            @change="handleCheckboxChange(row, $event)" />
        </td>
        <td class="px-4 py-4 border text-center">
          <img :src="row.image || BASE_URL_IMAGE + row.image" class="w-10 h-10 rounded-full mx-auto" />
        </td>
        <td class="px-4 py-2 border">{{ row.pro_erp_title || row.title }}</td>
        <td class="px-4 py-2 border">{{ row.activity_code ?? 'ไม่มีข้อมูล' }}</td>
        <td class="px-4 py-2 border">{{ row.goods_id }}</td>

        <td class="px-4 text-gray-700 py-2 border text-center">

          <input type="number" class="w-16 px-2 py-1 text-gray-700 border rounded text-center"
            v-model.number="row.amount" :min="0" :max="row.stock" @keypress="onlyNumberInput($event)"
            @blur="onAmountBlur(row)" @input="validateAmount(row)" placeholder="0" />
        </td>
        <td class="px-4 py-2 border">{{ row.stock }}</td>
        <td class="px-4 py-2 border">{{ row.sn ?? '-' }}</td>
        <td class="px-4 py-2 border">{{ row.goods_sku_text ?? '-' }}</td>
        <td class="px-4 py-2 border">{{ row.price ?? '-' }}</td>
        <td class="px-4 py-2 border">{{ row.units ?? '-' }}</td>
      </template>
    </tr>
  </tbody> -->
