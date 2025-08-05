<template>
  <div class="print-container " ref="printArea">
    <!-- HEADER -->
    <div class="header">
      <img src="@/assets/logo.svg" class="logo" />
      <div class="company-info">
        <h2>บริษัท ดี เพาเวอร์ ไอที เทคโนโลยี จำกัด</h2>
        <p>2เลขที่ 11 ซอยราษฎร์พัฒนา 16 แขวงราษฎร์พัฒนา </p>
        <p>เขตสะพานสูง กรุงเทพมหานคร 10240</p>
        <p>โทร. 02 084 9977 | เลขประจำตัวผู้เสียภาษี: 00000000000</p>
      </div>
    </div>

    <!-- TITLE -->
    <h1 class="doc-title">ใบสั่งขาย / Sales Order</h1>

    <!-- SELLER INFO -->
    <div class="info-section">
      <div><strong>รหัสลูกค้า:</strong> ก-0001</div>
      <div><strong>ชื่อลูกค้า:</strong> บริษัท แกรน อินเตอร์เทค จำกัด</div>
      <div><strong>ผู้ติดต่อ:</strong> คุณธนานุ</div>
      <div><strong>ที่อยู่:</strong> 259/83 ซ.พิบูลย์คดี ถ.สุขาภิบาล1 เขตบางเขน กทม.</div>
      <div><strong>วันที่สั่งซื้อ:</strong> {{ new Date().toLocaleDateString('th-TH') }}</div>
    </div>

    <!-- PRODUCT TABLE -->
    <table class="order-table">
      <thead>
        <tr>
          <th>ลำดับ</th>
          <th>รหัสสินค้า</th>
          <th>รายการ</th>
          <th>จำนวน</th>
          <th>หน่วย</th>
          <th>ราคา/หน่วย</th>
          <th>ส่วนลด</th>
          <th>รวม</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(item, index) in orderItems" :key="item.code">
          <td>{{ index + 1 }}</td>
          <td>{{ item.code }}</td>
          <td>{{ item.name }}</td>
          <td class="text-right">{{ item.qty }}</td>
          <td>{{ item.unit }}</td>
          <td class="text-right">{{ formatCurrency(item.unitPrice) }}</td>
          <td class="text-right">{{ item.discount }}</td>
          <td class="text-right">{{ formatCurrency(item.total) }}</td>
        </tr>
      </tbody>
    </table>

    <!-- SUMMARY -->
    <div class="summary">
      <div><strong>รวมเงิน:</strong> {{ formatCurrency(totalAmount) }}</div>
      <div><strong>ส่วนลด:</strong> {{ formatCurrency(discountTotal) }}</div>
      <div><strong>รวมหลังหักส่วนลด:</strong> {{ formatCurrency(amountAfterDiscount) }}</div>
      <div><strong>ภาษีมูลค่าเพิ่ม (7%):</strong> {{ formatCurrency(vatAmount) }}</div>
      <div class="grand-total"><strong>จำนวนเงินทั้งสิ้น:</strong> {{ formatCurrency(grandTotal) }}</div>
    </div>

    <!-- SIGNATURE -->
    <div class="signature-section">
      <div>
        <p>.............................................</p>
        <p>ผู้จัดทำ</p>
      </div>
      <div>
        <p>.............................................</p>
        <p>ผู้มีอำนาจลงนาม</p>
      </div>
    </div>

    <!-- BUTTON -->
    <div class="no-print">
      <button @click="print" class="print-button">พิมพ์เอกสาร</button>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRoute } from 'vue-router'

const route = useRoute()

onMounted(() => {
  const orderId = route.params.id
  console.log('Order ID:', orderId)
  window.print()
})

const orderItems = ref([
  { code: 'IC-0001', name: 'คอมพิวเตอร์ SAMSUNG', qty: 10, unit: 'เครื่อง', unitPrice: 15000, discount: '3%', total: 145500 },
  { code: 'IC-0002', name: 'คอมพิวเตอร์', qty: 10, unit: 'เครื่อง', unitPrice: 12000, discount: '0%', total: 120000 },
  { code: 'IC-0003', name: 'คีย์บอร์ด', qty: 10, unit: 'อัน', unitPrice: 3000, discount: '0%', total: 30000 },
  { code: 'IC-0004', name: 'เครื่อง SCAN', qty: 10, unit: 'ตัว', unitPrice: 3000, discount: '0%', total: 30000 },
])

const totalAmount = computed(() => 345500)
const discountTotal = computed(() => 10365)
const amountAfterDiscount = computed(() => 335135)
const vatAmount = computed(() => 23459.45)
const grandTotal = computed(() => 358594.45)

const print = () => window.print()

const formatCurrency = (num) => new Intl.NumberFormat('th-TH', {
  style: 'currency',
  currency: 'THB',
}).format(num)
</script>

<style scoped>
.print-container {
  padding: 32px;
  font-family: 'TH Sarabun New', sans-serif;
  font-size: 16px;
  color: #000;
}

.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-bottom: 2px solid #000;
  padding-bottom: 12px;
}
.logo {
  width: 100px;
}
.company-info {
  text-align: right;
}

.doc-title {
  text-align: center;
  margin: 20px 0;
  font-size: 22px;
  font-weight: bold;
  border-bottom: 1px solid #ccc;
  padding-bottom: 10px;
}

.info-section {
  margin-bottom: 20px;
  line-height: 1.6;
}

.order-table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 10px;
}
.order-table th,
.order-table td {
  border: 1px solid #000;
  padding: 6px 8px;
  font-size: 14px;
}
.order-table th {
  background-color: #f0f0f0;
  text-align: center;
}
.order-table td.text-right {
  text-align: right;
}

.summary {
  margin-top: 20px;
  text-align: right;
  font-size: 16px;
}
.grand-total {
  font-size: 18px;
  font-weight: bold;
  margin-top: 10px;
}

.signature-section {
  display: flex;
  justify-content: space-between;
  margin-top: 60px;
  padding: 0 40px;
}
.signature-section p {
  text-align: center;
  margin: 4px 0;
}

.print-button {
  margin-top: 20px;
  padding: 8px 20px;
  background-color: #2563eb;
  color: white;
  border: none;
  font-size: 16px;
  cursor: pointer;
  border-radius: 6px;
}

/* @media print {
  .no-print {
    display: none;
  }
  .print-container {
    padding: 10mm;
  }
} */

 @page {
  size: A4;
  margin: 10mm;
}

@media screen {
  .print-container {
    max-width: 800px;
    margin: auto;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    background: white;
    margin-top: 3rem;
    margin-bottom: 3rem;
  }
}

@media print {
  body * {
    visibility: hidden !important;
    height: 0 !important;
    overflow: hidden !important;
  }

  .print-container, .print-container * {
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



</style>
