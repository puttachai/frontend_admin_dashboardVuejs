src/views/PrintOrder.vue
<template>
  <div class="print-container" ref="printArea">
    <div class="header">
      <img src="@/assets/logo.svg" class="logo" />
      <div class="company-info">
        <h2>บริษัท ตัวอย่าง จำกัด</h2>
        <p>257/1 ถ.รามคำแหง แขวงหัวหมาก เขตบางกะปิ กรุงเทพฯ 10240</p>
        <p>โทร. 0-2739-5900</p>
      </div>
    </div>

    <h3 class="doc-title">ใบสั่งซื้อ</h3>

    <!-- ข้อมูลผู้ขาย -->
    <div class="info-section">
      <div><strong>รหัสผู้ขาย:</strong> ก-0001</div>
      <div><strong>ชื่อผู้ติดต่อ:</strong> คุณธนานุ</div>
      <div><strong>ชื่อผู้ขาย:</strong> บริษัท แกรน อินเตอร์เทค จำกัด</div>
      <div><strong>ที่อยู่:</strong> 259/83 ซ.พิบูลย์คดี ถ.สุขาภิบาล1 เขตบางเขน กทม.</div>
      <!-- เพิ่มรายละเอียดตามต้องการ -->
    </div>

    <!-- ตารางสินค้า -->
    <table class="order-table">
      <thead>
        <tr>
          <th>รหัสสินค้า</th>
          <th>รายการ</th>
          <th>จำนวน</th>
          <th>หน่วยนับ</th>
          <th>ราคา/หน่วย</th>
          <th>ส่วนลด</th>
          <th>จำนวนเงิน</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="item in orderItems" :key="item.code">
          <td>{{ item.code }}</td>
          <td>{{ item.name }}</td>
          <td>{{ item.qty }}</td>
          <td>{{ item.unit }}</td>
          <td>{{ formatCurrency(item.unitPrice) }}</td>
          <td>{{ item.discount }}</td>
          <td>{{ formatCurrency(item.total) }}</td>
        </tr>
      </tbody>
    </table>

    <!-- สรุปราคา -->
    <div class="summary">
      <div>รวมเงิน: {{ formatCurrency(totalAmount) }}</div>
      <div>ส่วนลดสินค้า: {{ formatCurrency(discountTotal) }}</div>
      <div>เงินหลังหักส่วนลด: {{ formatCurrency(amountAfterDiscount) }}</div>
      <div>ภาษีมูลค่าเพิ่ม (7%): {{ formatCurrency(vatAmount) }}</div>
      <div><strong>จำนวนเงินทั้งสิ้น: {{ formatCurrency(grandTotal) }}</strong></div>
    </div>

    <!-- ปุ่มพิมพ์ -->
    <button class="no-print" @click="print">พิมพ์เอกสาร</button>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { onMounted } from 'vue'
import { useRoute } from 'vue-router'

const route = useRoute()


onMounted(() => {
  const orderId = route.params.id
  console.log('Order ID:', orderId)
  // ดึงข้อมูลใบสั่งซื้อจาก API โดยใช้ orderId
  // และเมื่อโหลดเสร็จ ให้เรียก window.print()
  window.print()
})

const orderItems = ref([
  {
    code: 'IC-0001',
    name: 'คอมพิวเตอร์ รุ่น SAMSUNG',
    qty: 10,
    unit: 'เครื่อง',
    unitPrice: 15000,
    discount: '3%',
    total: 145500,
  },
  {
    code: 'IC-0002',
    name: 'คอมพิวเตอร์',
    qty: 10,
    unit: 'เครื่อง',
    unitPrice: 12000,
    discount: '0%',
    total: 120000,
  },
  {
    code: 'IC-0003',
    name: 'คีย์บอร์ด',
    qty: 10,
    unit: 'อัน',
    unitPrice: 3000,
    discount: '0%',
    total: 30000,
  },
  {
    code: 'IC-0004',
    name: 'เครื่อง SCAN',
    qty: 10,
    unit: 'ตัว',
    unitPrice: 3000,
    discount: '0%',
    total: 30000,
  },
])

const totalAmount = computed(() => 345500)
const discountTotal = computed(() => 10365)
const amountAfterDiscount = computed(() => 335135)
const vatAmount = computed(() => 23459.45)
const grandTotal = computed(() => 358594.45)

const print = () => {
  window.print()
}

const formatCurrency = (num) => {
  return new Intl.NumberFormat('th-TH', {
    style: 'currency',
    currency: 'THB',
  }).format(num)
}
</script>

<style scoped>
@media print {
  .no-print {
    display: none;
  }
  body {
    margin: 0;
    font-size: 12px;
  }
  .print-container {
    padding: 0;
    page-break-after: auto;
  }
}

.print-container {
  padding: 20px;
  font-family: 'TH Sarabun New', sans-serif;
}

.header {
  display: flex;
  align-items: center;
  gap: 20px;
}
.logo {
  width: 80px;
}
.doc-title {
  text-align: center;
  margin: 20px 0;
}

.order-table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 10px;
}
.order-table th,
.order-table td {
  border: 1px solid #000;
  padding: 4px 8px;
  text-align: left;
}
.summary {
  margin-top: 20px;
  text-align: right;
}
</style>
