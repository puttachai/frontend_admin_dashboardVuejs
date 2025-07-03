<template>
  <div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
    <div class="bg-white z-20 rounded-lg shadow-lg p-6 w-[90%] max-w-6xl max-h-[90vh] overflow-y-auto">

      <!-- Search Section -->
      <div class="flex items-center space-x-4">
        <!-- Search Icon -->
        <span class="material-icons text-gray-600" style="font-size: 28px;">search</span>
        <!-- Search Input -->
        <input class="w-full p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
          v-model="keyword" placeholder="ค้นหา..." @input="onInput" confirm-type="search" />
      </div>

      <div class="text-sm text-gray-500 mt-2">
        * สามารถ ค้นหาได้ ชื่อรายการสินค้าที่เข้าร่วมโปรโมชั่น, รหัสสินค้าที่ร่วมโปรโมชั่น
      </div>

      <!-- Header -->
      <div class="flex items-center mb-4">

        <div class="flex-1">
          <h2 class="text-xl font-bold">เลือกรายการสินค้าที่เข้าร่วมโปรโมชั่น</h2>
        </div>

        <div class="flex gap-4">
          <div class="text-sm font-semibold text-gray-500 mt-2">
            ประเภทสมาชิก: {{ memberType }}
          </div>
          <!-- แสดงว่าเป็น level อะไร -->
          <div class="">
            <button @click="$emit('close')" class="text-red-500 hover:text-gray-700 text-2xl">&times;</button>
          </div>
        </div>

      </div>



      <!-- Table -->
      <table class="min-w-full border text-sm">
        <thead class="bg-gray-100 text-gray-700">
          <tr>
            <!-- ช่องเลือกทั้งหมด -->
            <th class="px-4 py-2 border text-center">
              <input type="checkbox" @change="toggleSelectAll" :checked="isAllSelected" />
            </th>

            <!-- รูปภาพสินค้า -->
            <th class="px-4 py-2 border text-center">รูปภาพ</th>
            <th class="px-4 py-2 border">ชื่อสินค้า (ERP)</th>
            <!-- ช่องค้นหาชื่อโปรโมชั่น -->
            <th class="px-4 py-2 border w-[200px] text-left">
              <div class="flex gap-1">
                <input type="text" v-model="keyword_promotion_no" placeholder="ค้นหา โปรโมชั่น"
                  @focus="dropdownOpenIndex = 'header'"
                  class="w-full px-2 py-1 border border-gray-300 rounded-md focus:outline-none" />
                <button @click="searchPromotion_no" class="px-3 py-1 bg-blue-500 text-white rounded hover:bg-blue-600">
                  ค้นหา
                </button>
              </div>
            </th>

            <!-- ข้อมูลที่ต้องการแสดง -->

            <th class="px-4 py-2 border">รหัสสินค้า</th>
            <!-- <th class="px-4 py-2 border">Activity Code</th> -->
            <th class="px-4 py-2 border text-center">จำนวน</th>
            <!-- <th class="px-4 py-2 border">Goods Price</th> -->
            <th class="px-4 py-2 border">หมายเลขซีเรียล</th>
            <th class="px-4 py-2 border">สี</th>
            <th class="px-4 py-2 border">ราคา</th>
            <th class="px-4 py-2 border">Units</th>
            <!-- <th class="px-4 py-2 border">โปรโมชั่นที่เลือก</th> -->
          </tr>
        </thead>

        <!-- Loading Spinner -->
        <!-- <div v-if="isLoading" class="flex justify-center items-center h-40">
          <svg class="animate-spin h-8 w-8 text-blue-600" xmlns="http://www.w3.org/2000/svg" fill="none"
            viewBox="0 0 24 24">
            <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
            <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8H4z">
            </path>
          </svg>
        </div> -->

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

        <tbody v-if="!isLoading">
          <tr v-for="item in paginatedPromotion" :key="item.id">
            <!-- เช็คบ็อกซ์ -->
            <td class="px-4 py-2 border text-center">
              <input type="checkbox" v-model="selectedIds" :value="item.id" />
            </td>

            <!-- รูปภาพ -->
            <td class="px-4 py-4 border text-center">
              <template v-if="item.image">
                <!-- BASE_URL_IMAGE +  -->
                <img :src="item.image" alt="product" class="w-10 h-10 rounded-full mx-auto" />
              </template>
              <template v-else>
                <span class="material-icons text-gray-400 text-4xl">broken_image</span>
              </template>
            </td>

            <!-- ค้นหาด้วยรหัสโปรโมชั่น -->
            <td class="px-4 py-2 border">{{ item.title }}</td>
            <td class="px-4 py-2 border">{{ item.activity_code ?? 'ไม่มีข้อมูล' }}</td>

            <!-- ข้อมูลจาก API -->
            <!-- <td class="px-4 py-2 border">{{ item.title }}</td> -->
            <td class="px-4 py-2 border">{{ item.goods_id }}</td>
            <td class="px-4 py-2 border text-center">
              <input type="number" min="1" class="w-16 px-2 py-1 border rounded text-center"
                v-model.number="item.quantity" placeholder="0" />
              <!-- @input="onQuantityChange(item)" -->
            </td>
            <!-- <td class="px-4 py-2 border">{{ item.activity_code }}</td> -->
            <!-- <td class="px-4 py-2 border">{{ item.goods_price ?? '-'}}</td> -->
            <td class="px-4 py-2 border">{{ item.sn ?? '-' }}</td>
            <td class="px-4 py-2 border">{{ item.goods_sku_text ?? '-' }}</td>
            <td class="px-4 py-2 border">{{ item.price ?? '-' }}</td>
            <!-- <td class="px-4 py-2 border">{{ item.price ?? '-' }}</td> -->
            <td class="px-4 py-2 border">{{ item.units ?? '-' }}</td>
            <!-- <td class="px-4 py-2 border">โปรโมชั่น: <span v-for="(promo, index) in props.selectedPromotion"
                :key="promo.pro_m_id">
                {{ promo.pro_m_title }}<span v-if="index < props.selectedPromotion.length - 1">, </span>
              </span></td> -->
          </tr>
        </tbody>
      </table>


      <!-- Pagination -->
      <ConfigProvider :globalConfig="enConfig">
        <div class="overflow-auto mt-4">
          <!-- v-model:page-size="pageSize" -->
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
  }
})



const emit = defineEmits(['close', 'select-promotion_products', 'page-change'])

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

const keyword_promotion_no = ref('');
const dataselectpromotion_no = ref([]);

const Apipromotion = ref([]);

// const activity_title = ref('');

const memberType = ref('');

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

    // activity_code :"P02-ZZ-9999"
    // activity_id :1178

    const selectedPromotionProducts = tableData.value
      .filter(p => selectedIds.value.includes(p.id))
      .map(p => {

        // 🔍 ดึง matchedPrice จาก condition_price ตามชื่อสมาชิก
        // const condPrice = p.condition_price?.[0]?.price || [];
        // const found = condPrice.find(priceItem => priceItem.name === memberType.value);
        // const matchedPrice = found ? found.price : '-';

        return {
          pro_id: p.id,
          pro_title: p.title,
          pro_code: p.activity_code,
          pro_m_code: p.pro_m_code,
          pro_goods_price: p.price,
          // pro_goods_price: matchedPrice,
          // pro_goods_price: p.goods_price,
          pro_goods_sku_text: p.goods_sku_text,
          pro_quantity: p.quantity || 0,
          pro_sn: p.sn,
          pro_units: p.units,
          pro_acm_id: p.activity_id,
          pro_images: p.image,
        };

      });

    const selectedPromotionsInfo = props.selectedPromotion.map(p => ({

      pro_m_id: p.pro_m_id, //pro_m_id: 1176
      pro_m_title: p.pro_m_title,
      pro_acm_id: p.pro_acm_id,
      pro_m_images: p.pro_m_images,

    }))

    console.log("✅ selectedPromotionProducts ถูกแปลงแล้ว:", selectedPromotionProducts);
    console.log("✅ selectedPromotionsInfo ถูกแปลงแล้ว:", selectedPromotionsInfo);

    emit('select-promotion_products', {
      products: selectedPromotionProducts,
      promotions: selectedPromotionsInfo

    });
    emit('close');
  }

  const searchPromotion_no = async () => {
    clearTimeout(searchTimer.value);

    if (!keyword_promotion_no.value.trim()) {
      try {


        const gettoken = localStorage.getItem('token');
        console.log("log value token:", gettoken);

        // ?from=specialprice
        const response = await axios.post(
          `${BASE_URL}/goods2/activityList`,
          {
            version: '2.0.2',
            // keywords: keyword.value,
            keywords: keyword_promotion_no.value,
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
        console.log("IF searchSku total:", response.data.data.item_count);

        if (response.data.code === 1) {
          total.value = response.data.data.item_count;
          dataselectpromotion_no.value = response.data.data.data2;
          tableData.value = [...dataselectpromotion_no.value];
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
          // keywords: dataselectpromotion_no.value,
          keywords: keyword.value + '$_' + keyword_promotion_no.value + '_$',
          level: getLevel,

        });

        console.log("ELSE searchSku response:", response);
        console.log("ELSE searchSku total:", response.data.data.item_count);

        if (response.data.code === 1) {
          total.value = response.data.data.item_count;
          dataselectpromotion_no.value = response.data.data.data2;
          tableData.value = [...dataselectpromotion_no.value];
        }
      } catch (err) {
        console.error("searchSku error:", err);
      } satisfies
    }
  };

  //SearchPromotionSubmit
  async function SearchPromotionSubmit() {

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

    try {

      const gettoken = localStorage.getItem('token');
      console.log("log value token:", gettoken);

      // ?from=specialprice
      const response = await axios.post(
        `${BASE_URL}/goods2/activityList`,
        {
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

      const searchPromotion = response.data.data;

      console.log("searchProducts:", searchPromotion);


      // const getData

      if (response.data.code !== 1) {
        console.error("ค้นหาไม่สำเร็จ:", response.data.msg);
      }

      if (response.data.code === 1) {
        const data = response.data;

        // const searchPromotion = data.data.length || 0;
        // tableData.value = searchPromotion;

        const searchPromotion = data.data.data2 || [];
        dataselect.value = [...searchPromotion]; //
        tableData.value = [...searchPromotion]; // 
        total.value = data.data.item_count || searchPromotion.length;

        // tableData.value = searchProducts.map(item => ({
        //   ...item,
        //   imageLoaded: false
        // }));

        // dataselect.value = searchPromotion;
        // total.value = data.data || 0;

        console.log("✅ ข้อมูล searchPromotion:", searchPromotion);

        // console.log('ข้อมูลที่ค้นเจอ:', data.data2);
        // isLoading.value = false; // โหลดเสร็จ
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
        const skuList = activityData.activity_sku_price || [];

        return skuList.map(sku => ({
          ...sku,
          goods_id: sku.goods_id,
          erp_title: sku.erp_title,
          image: sku.image,
          activity_code: activityData.activity_code,
          pro_m_code: activityData.activity_code,
          pro_acm_id: activityData.activity_code,
          sn: sku.sn,
          goods_sku_text: sku.goods_sku_text,
          price: sku.price,
          units: sku.units
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
