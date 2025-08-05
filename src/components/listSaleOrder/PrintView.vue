<template>
  <div
    class="print-container bg-white shadow-lg rounded-xl p-10 font-sans text-gray-800 text-[15px]"
    ref="printArea"
  >
    <!-- class="page-section" -->
    <!-- ✅ Header (แสดงทุกหน้า) -->
    <!-- BUTTON -->
    <div class="no-print text-end mb-8">
      <button
        @click="print"
        class="bg-blue-600 hover:bg-blue-700 text-white py-2 px-6 rounded-md text-xs"
      >
        พิมพ์เอกสาร
      </button>
    </div>

    <div
      v-for="(chunk, pageIndex) in paginatedItems"
      :key="pageIndex"
      class="print-page"
      :class="{ 'print-page': pageIndex < paginatedItems.length - 1 }"
    >
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
          <div class="text-xs pb-1 pb-1"><strong>รหัสลูกค้า: </strong>{{ printData.order.customerCode }}</div>
          <div class="text-xs pb-1">
            <strong>เลขที่อ้างอิง: </strong>{{ printData.order.documentNo }}
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
          <thead class="bg-gray-100 text-[12px] font-semibold">
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
            <!-- v-for="(item, index) in printData.productList" -->
            <tr
              v-for="(item, index) in chunk"
              :key="index"
              :class="index % 2 === 0 ? 'bg-white' : 'bg-gray-50'"
              class="text-[11px] align-top"
            >
              <!-- <td class="border border-gray-300 px-2 py-1 text-center">{{ index + 1 }}</td> -->
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
          </tbody>
        </table>
      </div>

      <!-- SUMMARY + SIGNATURE เฉพาะหน้า "สุดท้าย"  text-[15px]-->
      <!-- ✅ Footer (แสดงทุกหน้า) -->
      <div class="footer-section shrink-0">
        <div class="text-right space-y-1">
          <div>
            <p>รวมเงิน: {{ formatCurrency(printData.order.price_before_tax) }} </p>
          </div>
          <!-- <div><strong>รวมเงิน:</strong> {{ formatCurrency(totalAmount) }}</div> -->
          <!-- <div><strong>ส่วนลด:</strong> {{ formatCurrency(discountTotal) }}</div> -->
          <!-- <div><strong>รวมหลังหักส่วนลด:</strong> {{ formatCurrency(amountAfterDiscount) }}</div> -->
          <div>
            <p>ภาษีมูลค่าเพิ่ม (7%): {{ formatCurrency(printData.order.tax_value) }}</p>
          </div>
          <!-- <div><strong>ภาษีมูลค่าเพิ่ม (7%):</strong> {{ formatCurrency(vatAmount) }}</div> -->
          <div class="mt-2">
            <!-- font-bold -->
            <p>จำนวนเงินทั้งสิ้น:
            {{ formatCurrency(printData.order.final_total_price) }}</p>
            <!-- <strong>จำนวนเงินทั้งสิ้น:</strong> {{ formatCurrency(grandTotal) }} -->
          </div>
        </div>
        <!-- SIGNATURE -->
        <div class="signature flex justify-between mt-6 mb-6 px-12 border-b border-gray-300 pt-4">
          <div class="text-center mb-4">
            <p>.............................................</p>
            <p class="mt-1">ผู้จัดทำ</p>
          </div>
          <div class="text-center">
            <p>.............................................</p>
            <p class="mt-1">ผู้มีอำนาจลงนาม</p>
          </div>
        </div>
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

const chunkArray = (array, size) => {
  const chunks = [];
  for (let i = 0; i < array.length; i += size) {
    chunks.push(array.slice(i, i + size));
  }
  return chunks;
};

const paginatedItems = computed(() => chunkArray(printData.value?.productList, 10));
// const paginatedItems = computed(() => chunkArray(orderItems.value, 10));

const print = () => window.print();

const formatCurrency = (num) =>
  new Intl.NumberFormat("th-TH", {
    style: "currency",
    currency: "THB",
  }).format(num);
</script>

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
