<template>

  <!-- กล่องรวม breadcrumb + action bar -->
  <div class="fixed top-16 left-16 right-0 bg-white rounded-lg p-4 shadow-lg z-50 responsive-action-bar">

    <!-- Breadcrumb + ActionBar inline -->
    <div class="flex flex-wrap md:flex-nowrap justify-between  items-center gap-4">

      <!-- Breadcrumb -->
      <nav class="text-sm text-gray-600">
        <ul class="flex items-center space-x-1">
          <li>
            <router-link to="/dashboard" class="hover:text-purple-600 transition">Home</router-link>
            <span class="mx-1 text-gray-400">›</span>
          </li>
          <li>
            <router-link to="/saleorder" class="hover:text-purple-600 transition">Sale Order List</router-link>
            <span class="mx-1 text-gray-400">›</span>
          </li>
          <li class="text-purple-600 font-medium">
            {{ printData.order.documentNo || "Loading..." }}
          </li>
    
        </ul>
      </nav>

      <button @click="print" class="bg-blue-600 hover:bg-blue-700 text-white py-2 px-6 rounded-md text-xs">
        พิมพ์เอกสาร
      </button>

    </div>
  </div>

  <div class="print-container bg-white shadow-lg rounded-xl p-10 font-sans text-gray-800 text-[15px] no-print-shadow"
    ref="printArea">

    <!-- class="page-section" -->
    <!-- ✅ Header (แสดงทุกหน้า) -->
    <!-- BUTTON -->
    <div class="no-print text-end mb-8">
      <button @click="print" class="bg-blue-600 hover:bg-blue-700 text-white py-2 px-6 rounded-md text-xs">
        พิมพ์เอกสาร
      </button>
    </div>

    <div v-for="(chunk, pageIndex) in paginatedItems" :key="pageIndex" class="print-page py-6 border-b border-gray-300"
      :class="{ 'print-page': pageIndex < paginatedItems.length - 1 }">
      <!-- HEADER -->
      <!-- ✅ Header (แสดงทุกหน้า) -->
      <div class="header-section shrink-0">

        <!-- LOGO + COMPANY INFO -->
        <div class="flex justify-between items-start border-b border-gray-300 pb-2">
          <img src="@/assets/logo.svg" class="w-12" />
          <div class="text-right text-sm">
            <h2 class="text-md font-bold">บริษัท ดี เพาเวอร์ ไอที เทคโนโลยี จำกัด</h2>
            <p>เลขที่ 11 ซอยราษฎร์พัฒนา 16 แขวงราษฎร์พัฒนา</p>
            <p>เขตสะพานสูง กรุงเทพมหานคร 10240</p>
            <p>โทร. 02 084 9977</p>
            <p>เลขประจำตัวผู้เสียภาษี: 00000000000</p>
          </div>
        </div>
      </div>

      <!-- BODY (เนื้อหา) -->
      <div class="flex-1 body-section my-4">
        <!-- TITLE -->
        <h1 class="text-center text-[15px] font-bold border-b border-gray-200 pb-4 mb-6">
          ใบสั่งขาย / Sales Order
        </h1>

        <!-- SELLER INFO -->
        <div class="info-section mb-4 ">
          <div class="flex justify-between text-xs">
            <div class="text-xs pb-1 pb-1">
              <strong>รหัสลูกค้า: </strong>{{ printData.order.customerCode }}
            </div>
            <div class="text-xs pb-1">
              <strong>เลขที่อ้างอิง: </strong>{{ printData.order.documentNo }}
            </div>
          </div>
          <!-- <div><strong>รหัสลูกค้า:</strong> ก-0001</div> -->
          <div class="text-xs pb-1"><strong>ชื่อลูกค้า: </strong>{{ printData.order.fullName }}</div>
          <div class="text-xs pb-1"><strong>ที่อยู่: </strong>{{ printData.order.address }}</div>
          <!-- <div><strong>ที่อยู่:</strong> 259/83 ซ.พิบูลย์คดี ถ.สุขาภิบาล1 เขตบางเขน กทม.</div> -->
          <div class="text-xs pb-1">
            <strong>วันที่สั่งซื้อ: </strong> {{ printData.order.sellDate }}
          </div>
          <!-- <div><strong>วันที่สั่งซื้อ:</strong> {{ new Date().toLocaleDateString("th-TH") }}</div> -->
        </div>

        <!-- PRODUCT TABLE -->
        <table class="w-full border border-gray-300 text-xs">
          <thead class="bg-gray-100 text-[10px] font-semibold">
            <tr>
              <th class="border border-gray-300 px-2 py-2 text-center">ลำดับ</th>
              <th class="border border-gray-300 px-2 py-2 text-left">รหัสสินค้า</th>
              <th class="border border-gray-300 px-2 py-2 text-left">รายการ</th>
              <th class="border border-gray-300 px-2 py-2 text-right">จำนวน</th>
              <th class="border border-gray-300 px-2 py-2 text-center">หน่วย</th>
              <th class="border border-gray-300 px-2 py-2 text-right">ราคา/หน่วย</th>
              <th class="border border-gray-300 px-2 py-2 text-right">ส่วนลด</th>
              <th class="border border-gray-300 px-2 py-2 text-right">รวม</th>
            </tr>
          </thead>
          <tbody>

            <template v-for="(item, index) in chunk" :key="index">
              <!-- สินค้าหลัก -->
              <tr :class="index % 2 === 0 ? 'bg-white' : 'bg-gray-50'" class="text-[10px] align-top">
                <td class="border border-gray-300 px-2 py-1 text-center">{{ pageIndex * 16 + index + 1 }}</td>
                <td class="border border-gray-300 px-2 py-1">{{ item.pro_sku_price_id }}</td>
                <td class="border border-gray-300 px-2 py-1">{{ item.pro_erp_title }} - {{ item.pro_goods_sku_text }}
                </td>
                <!-- <td class="border border-gray-300 px-2 py-1">{{ item.pro_erp_title - item.pro_goods_sku_text}}</td> -->
                <td class="border border-gray-300 px-2 py-1 text-right">{{ item.pro_goods_num }}</td>
                <td class="border border-gray-300 px-2 py-1 text-center">{{ item.pro_unit || '-' }}</td>
                <td class="border border-gray-300 px-2 py-1 text-right">{{ formatCurrency(item.pro_unit_price) }}</td>
                <td class="border border-gray-300 px-2 py-1 text-right">{{ item.discount || 0 }}</td>
                <td class="border border-gray-300 px-2 py-1 text-right">{{ formatCurrency(item.pro_total_price) }}</td>
              </tr>

              <!-- แสดงหัวข้อ "ของแถม" ถ้ามี -->
              <!-- ✅ เฉพาะหน้า "สุดท้าย" ให้แสดงของแถมรวม -->


            </template>
            <!-- ✅ เฉพาะหน้าสุดท้าย -->
            <tr v-if="isLastPage(pageIndex) && uniqueGifts.length > 0">
              <td colspan="8"
                class="border border-gray-300 bg-yellow-100 text-left px-2 py-1 font-semibold text-[12px]">
                🎁 รายการของแถม
              </td>
            </tr>
            <tr v-for="(gift, gIndex) in uniqueGifts" :key="'gift-unique-' + gIndex" v-if="isLastPage(pageIndex)"
              class="text-[11px] bg-yellow-50">
              <td class="border border-gray-300 px-2 py-1 text-center">{{ gIndex + 1 }}</td>
              <!-- <td class="border border-gray-300 px-2 py-1 text-center">-</td> -->
              <td class="border border-gray-300 px-2 py-1">{{ gift.pro_sku_price_id || '-' }}</td>
              <td class="border border-gray-300 px-2 py-1">{{ gift.title }} - {{ gift.pro_goods_sku_text }}</td>
              <td class="border border-gray-300 px-2 py-1 text-right">{{ gift.pro_goods_num }}</td>
              <!-- <td class="border border-gray-300 px-2 py-1 text-right">{{ gift.units }}</td> -->
              <td class="border border-gray-300 px-2 py-1 text-center">PCS</td>
              <td class="border border-gray-300 px-2 py-1 text-right">0.00</td>
              <td class="border border-gray-300 px-2 py-1 text-right">-</td>
              <td class="border border-gray-300 px-2 py-1 text-right">0.00</td>
            </tr>

          </tbody>


        </table>
      </div>

      <!-- SUMMARY + SIGNATURE เฉพาะหน้า "สุดท้าย"  text-[15px]-->
      <!-- ✅ Footer (แสดงทุกหน้า) -->

      <div v-if="isLastPage(pageIndex)" class="footer-section shrink-0">

        <!-- <div class="mt-6 text-right space-y-1">
        <div v-if="isVathidden" class="text-gray-700">
          มูลค่ารวมก่อนภาษี:
          <span class="ml-2 text-gray-700">
            {{
              netAmountBeforeVat.toLocaleString(undefined, {
                minimumFractionDigits: 2,
                maximumFractionDigits: 2,
              })
            }}
          </span>

        </div>

     
        <div class="text-gray-700 flex items-center justify-end">
          <input type="checkbox" v-model="isVathidden" id="vatCheckbox" :disabled="isReadOnly" class="mr-2" />
          <label for="vatCheckbox">แสดงภาษีมูลค่าเพิ่ม (7%) และมูลค่าก่อนภาษี</label>
        
          <span v-if="isVathidden" class="ml-2 text-gray-700">
            {{
              formatCurrency.toLocaleString(undefined, {
                minimumFractionDigits: 2,
                maximumFractionDigits: 2,
              })
            }}
            บาท
          </span>

        </div>

        <div v-if="!formData.deliveryFee === 0 " class="text-gray-700">
                    ค่าจัดส่ง:
                    <span class="ml-2 text-gray-700" >
                       {{ formData.deliveryFee ? formData.deliveryFee.toLocaleString(undefined, {
                            minimumFractionDigits: 2,
                            maximumFractionDigits: 2
                        }) : '0.00' }}
                    </span>
                </div>
                <div v-if="!formData.totalDiscount === 0" class="text-gray-700">
                    ส่วนลดท้ายบิล:
                    <span class="ml-2 text-gray-700" >
                       {{ formData.totalDiscount ? formData.totalDiscount.toLocaleString(undefined, {
                            minimumFractionDigits: 2,
                            maximumFractionDigits: 2
                        }) : '0.00' }}
                    </span>
                </div>

        <div class="text-xl font-bold text-purple-700 mt-2">
          มูลค่ารวมสุทธิ:
          <span class="ml-2 text-blue-600">
            {{
              formatCurrency.toLocaleString(undefined, {
                minimumFractionDigits: 2,
                maximumFractionDigits: 2,
              })
            }}
          </span>
    
        </div>
      </div> -->

        <div class="text-right space-y-1">
          <div v-if="isVathidden">
            <p>มูลค่ารวมก่อนภาษี: {{ formatCurrency(printData.order.price_before_tax) }} </p>
          </div>
          <div v-if="isVathidden">
            <p>ภาษีมูลค่าเพิ่ม (7%): {{ formatCurrency(printData.order.tax_value) }}</p>
          </div>
          <!-- v-if="!printData.order.deliveryFee === 0" -->
          <div class="mt-2">
            <p>ค่าจัดส่ง:
              {{ formatCurrency(printData.order.deliveryFee) }}</p>
          </div>
          <!-- v-if="!printData.order.deliveryFee === 0" -->
          <div class="mt-2">
            <p>ส่วนลดท้ายบิล:
              {{ formatCurrency(printData.order.totalDiscount) }}</p>
          </div>
          <div class="mt-2">
            <p>จำนวนเงินทั้งสิ้น:
              {{ formatCurrency(printData.order.final_total_price) }}</p>
          </div>
        </div>

        <!-- SIGNATURE -->
        <div class="signature flex justify-between mt-6 mb-6 px-12  pt-4">
          <div class="text-center mb-4">
            <p>.............................................</p>
            <p class="mt-1">ผู้จัดทำ</p>
          </div>
          <div class="text-center">
            <p>.............................................</p>
            <p class="mt-1">ผู้มีอำนาจลงนาม</p>
          </div>
        </div>
        <!-- แสดงหมายเลขหน้า -->
        <div>

        </div>
        <div class="text-xs text-right text-gray-500 mt-2"> 
          หน้าเอกสารที่ {{ pageIndex + 1 }} จากทั้งหมด {{ paginatedItems.length }} หน้า
        </div>

      </div>

      <!-- ถ้าไม่ใช่หน้าสุดท้าย ให้แสดงหมายเลขหน้าเล็กๆ -->
      <div v-else class="text-xs text-right text-gray-400 mt-2">
        หน้าเอกสารที่ {{ pageIndex + 1 }} จากทั้งหมด {{ paginatedItems.length }} หน้า
      </div>

    </div>

  </div>

</template>

<script setup>
import { ref, computed, onMounted } from "vue";
import { useRoute, useRouter } from "vue-router";
import Swal from "sweetalert2"; // ✅ อย่าลืม import

const route = useRoute();
const router = useRouter();


const isVathidden = ref(false); // เริ่มต้นให้ไม่แสดงภาษี
// const originalIsVathidden = ref(false); //

const ITEMS_PER_PAGE = 16;

// const isLastPage = (pageIndex) => pageIndex === paginatedItems.value.length - 1;
const isLastPage = (index) => index === paginatedItems.value.length - 1;

const printData = ref({
  order: {},
  productList: [],
  deliveryAddress: {},
  // … คุณจะมีฟิลด์อะไรบ้างก็เพิ่มเข้าไปตาม API
});

onMounted(() => {

  const orderId = route.params.id;
  console.log("Order ID:", orderId);

  // อ่านข้อมูลจาก sessionStorage
  const raw = sessionStorage.getItem("printData");
  if (raw) {
    const parsed = JSON.parse(raw);

    // ✅ เช็คว่า parsed มีข้อมูลหรือไม่
    if (
      !parsed ||
      !parsed.order ||
      !parsed.productList ||
      parsed.productList.length === 0
    ) {
      Swal.fire({
        icon: "error",
        title: "ไม่พบข้อมูลคำสั่งซื้อ",
        text: "โปรดตรวจสอบข้อมูลรายการคำสั่งซื้ออีกครั้ง",
        confirmButtonText: "กลับไปหน้ารายการคำสั่งซื้อ",
      }).then(() => {
        router.push({ name: "saleorder" });
      });
      return;
    }

    isVathidden.value = !!Number(parsed.order.vatVisible);

    // printData.value.order.vatVisible = parsed.order.vatVisible || false;

    Object.assign(printData.value, parsed);
    console.log("✅ Print Data:", printData.value);
  } else {
    // ✅ กรณีไม่มี key `printData` เลย
    Swal.fire({
      icon: "error",
      title: "ไม่พบข้อมูลคำสั่งซื้อ",
      text: "โปรดตรวจสอบข้อมูลรายการคำสั่งซื้ออีกครั้ง",
      confirmButtonText: "กลับไปหน้ารายการคำสั่งซื้อ",
    }).then(() => {
      router.push({ name: "saleorder" });
    });
  }
});

// onMounted(() => {

//   // อ่านข้อมูลจาก sessionStorage
//   const raw = sessionStorage.getItem("printData");
//   if (raw) {
//     Object.assign(printData.value, JSON.parse(raw));
//   }
//   console.log("Print Data:", printData.value);

//   // พิมพ์ทันที (ถ้าต้องการ)
//   // window.print();
// });

const paginatedItems = computed(() => {
  const products = printData.value?.productList || [];
  const gifts = uniqueGifts.value || [];
  const giftRows = gifts.length > 0 ? gifts.length + 1 : 0;
  const chunks = [];

  let i = 0;
  while (i < products.length) {
    chunks.push(products.slice(i, i + ITEMS_PER_PAGE));
    i += ITEMS_PER_PAGE;
  }

  if (chunks.length > 0 && giftRows > 0) {
    const lastChunk = chunks[chunks.length - 1];
    if (lastChunk.length + giftRows > ITEMS_PER_PAGE) {
      chunks.push([]);
    }
  } else if (gifts.length > 0) {
    chunks.push([]);
  }

  return chunks;
});

const chunkArray = (array, size) => {
  const chunks = [];
  for (let i = 0; i < array.length; i += size) {
    chunks.push(array.slice(i, i + size));
  }
  return chunks;
};

// const paginatedItems = computed(() => chunkArray(printData.value?.productList, 16));


const uniqueGifts = computed(() => {
  const giftMap = new Map();

  printData.value.productList.forEach((product) => {
    product.gifts?.forEach((gift) => {
      if (!giftMap.has(gift.id)) {
        giftMap.set(gift.id, gift);
      }
    });
  });

  return Array.from(giftMap.values());
});


const collectUniqueGifts = () => {
  const seen = new Set();
  const result = [];

  printData.value.productList.forEach(product => {
    product.gifts?.forEach(gift => {
      const uniqueKey = gift.id;
      if (!seen.has(uniqueKey)) {
        seen.add(uniqueKey);
        result.push(gift);
      }
    });
  });

  printData.value.gifts = result;
};

// เรียกใช้ตอนโหลดข้อมูล
onMounted(() => {
  collectUniqueGifts();
});

const print = () => window.print();

const formatCurrency = (num) =>
  new Intl.NumberFormat("th-TH", {
    style: "currency",
    currency: "THB",
  }).format(num);
</script>


<!-- 


// function groupByActivityId(products) {
//   return products.reduce((acc, item) => {
//     const promoId = item.promotions?.[0]?.pro_activity_id ?? null;
//     const promoSt = item.promotions?.[0]?.st ?? null;

//     let key, title;
//     if (promoId !== null) {
//       key = `promo-${promoId}-st${promoSt}`;
//       title = promoSt
//         ? `🔥 โปรโมชั่นรายวัน ${promoId}`
//         : `🎯 โปรโมชั่นรายเดือน ${promoId}`;
//     } else {
//       const pid = Number(item.pro_activity_id);
//       const st = item.st ? 1 : 0;
//       key = pid === 0
//         ? `monthly-st${st}`
//         : `invalid-activity`;
//       title = pid === 0
//         ? '🎯 โปรโมชั่นรายเดือน'
//         : '⚠️ โปรไม่เข้าเงื่อนไข';
//     }

//     if (!acc[key]) {
//       acc[key] = {
//         title,
//         items: [],
//         promotions: [],
//         gifts: []
//       };
//     }

//     acc[key].items.push(item);
//     if (item.promotions) acc[key].promotions.push(...item.promotions);
//     if (item.gifts) acc[key].gifts.push(...item.gifts);

//     return acc;
//   }, {});
// }

// const groupedProducts = computed(() => groupByActivityId(printData.value.productList));

// // แยกสินค้าโปรรายเดือนและรายวัน
// const monthlyProducts = computed(() => {
//   return printData.value.productList.filter(
//     (item) => item.pro_activity_id === 0 && item.st === 0
//   );
// });

// const dailyProducts = computed(() => {
//   return printData.value.productList.filter(
//     (item) => !(item.pro_activity_id === 0 && item.st === 0)
//   );
// });

// // แบ่งหน้าละ 10 รายการ (หรือปรับได้)
// function paginate(items, perPage = 10) {
//   const pages = [];
//   for (let i = 0; i < items.length; i += perPage) {
//     pages.push(items.slice(i, i + perPage));
//   }
//   return pages;
// }

// const monthlyPages = computed(() => paginate(monthlyProducts.value));
// const dailyPages = computed(() => paginate(dailyProducts.value));


// const paginatedItems = computed(() => chunkArray(orderItems.value, 10));

const print = () => window.print();

const formatCurrency = (num) =>
  new Intl.NumberFormat("th-TH", {
    style: "currency",
    currency: "THB",
  }).format(num);
</script>
 -->


<!-- <tbody>
            <!-- v-for="(item, index) in printData.productList" -->
<!--
            <tr
              v-for="(item, index) in chunk"
              :key="index"
              :class="index % 2 === 0 ? 'bg-white' : 'bg-gray-50'"
              class="text-[11px] align-top"
            >
              <!-- <td class="border border-gray-300 px-2 py-1 text-center">{{ index + 1 }}</td> 
              <td class="border border-gray-300 px-2 py-1 text-center">{{ pageIndex * 10 + index + 1 }}</td>
              <td class="border border-gray-300 px-2 py-1">{{ item.pro_sku_price_id }}</td>
              <td class="border border-gray-300 px-2 py-1">{{ item.pro_erp_title }}</td>
              <td class="border border-gray-300 px-2 py-1 text-right">{{ item.pro_goods_num }}</td>
              <td class="border border-gray-300 px-2 py-1 text-center">
                {{ item.pro_unit || "-" }}
              </td>
              <td class="border border-gray-300 px-2 py-1 text-right">
                {{ formatCurrency(item.pro_unit_price) }}
              </td>
              <td class="border border-gray-300 px-2 py-1 text-right">{{ item.pro_discount }}</td>
              <td class="border border-gray-300 px-2 py-1 text-right">
                {{ formatCurrency(item.pro_total_price) }}
              </td>
            </tr>
          </tbody> -->

<!-- const orderItems = ref([
  {
    code: "IC-0001",
    name: "คอมพิวเตอร์ SAMSUNG",
    qty: 10,
    unit: "เครื่อง",
    unitPrice: 15000,
    discount: "3%",
    total: 145500,
  },
  {
    code: "IC-0002",
    name: "คอมพิวเตอร์",
    qty: 10,
    unit: "เครื่อง",
    unitPrice: 12000,
    discount: "0%",
    total: 120000,
  },
  {
    code: "IC-0003",
    name: "คีย์บอร์ด",
    qty: 10,
    unit: "อัน",
    unitPrice: 3000,
    discount: "0%",
    total: 30000,
  },
  {
    code: "IC-0004",
    name: "เครื่อง SCAN",
    qty: 10,
    unit: "ตัว",
    unitPrice: 3000,
    discount: "0%",
    total: 30000,
  },
  {
    code: "IC-0001",
    name: "คอมพิวเตอร์ SAMSUNG",
    qty: 10,
    unit: "เครื่อง",
    unitPrice: 15000,
    discount: "3%",
    total: 145500,
  },
  {
    code: "IC-0002",
    name: "คอมพิวเตอร์",
    qty: 10,
    unit: "เครื่อง",
    unitPrice: 12000,
    discount: "0%",
    total: 120000,
  },
  {
    code: "IC-0003",
    name: "คีย์บอร์ด",
    qty: 10,
    unit: "อัน",
    unitPrice: 3000,
    discount: "0%",
    total: 30000,
  },
  {
    code: "IC-0004",
    name: "เครื่อง SCAN",
    qty: 10,
    unit: "ตัว",
    unitPrice: 3000,
    discount: "0%",
    total: 30000,
  },
  {
    code: "IC-0001",
    name: "คอมพิวเตอร์ SAMSUNG",
    qty: 10,
    unit: "เครื่อง",
    unitPrice: 15000,
    discount: "3%",
    total: 145500,
  },
  {
    code: "IC-0002",
    name: "คอมพิวเตอร์",
    qty: 10,
    unit: "เครื่อง",
    unitPrice: 12000,
    discount: "0%",
    total: 120000,
  },
  {
    code: "IC-0003",
    name: "คีย์บอร์ด",
    qty: 10,
    unit: "อัน",
    unitPrice: 3000,
    discount: "0%",
    total: 30000,
  },
  {
    code: "IC-0004",
    name: "เครื่อง SCAN",
    qty: 10,
    unit: "ตัว",
    unitPrice: 3000,
    discount: "0%",
    total: 30000,
  },
]); -->
<!-- <style scoped>
@page {
  size: A4;
  margin: 10mm;
}

@media print {
  .page-section {
    margin-bottom: 2rem;
  }

  .print-page {
    page-break-after: always;
  }
  body * {
    visibility: hidden !important;
    height: 0 !important;
    overflow: hidden !important;
  }
  .print-container,
  .print-container * {
    visibility: visible !important;
    height: auto !important;
    overflow: visible !important;
  }
  .print-container {
    position: absolute !important;
    top: 0;
    left: 0;
    width: 100%;
    padding: 10mm;
  }
  .no-print {
    display: none !important;
  }
}
</style> -->
