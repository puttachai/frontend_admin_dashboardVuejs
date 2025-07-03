<template>
    <div class="p-6">
      <h2 class="text-2xl font-bold mb-2">ข้อมูลโปรโมชั่น</h2>
      <div v-if="promotion" class="mb-4">
        <p><strong>ชื่อโปรโมชั่น:</strong> {{ promotion.title }}</p>
        <p><strong>รายละเอียด:</strong> {{ promotion.titledetail }}</p>
        <p><strong>ช่วงเวลา:</strong> {{ promotion.starttime2 }} - {{ promotion.endtime2 }}</p>
        <img
          v-if="promotion.image"
          :src="'https://tgsc.qifudaren.net' + promotion.image"
          alt="promotion image"
          class="w-60 mt-2 rounded shadow"
        />
      </div>
  
      <h3 class="text-xl font-semibold mt-6 mb-2">สินค้าที่เข้าร่วม</h3>
      <table class="min-w-full border text-sm">
        <thead class="bg-gray-100">
          <tr>
            <th class="border px-4 py-2">รูปภาพ</th>
            <th class="border px-4 py-2">รหัสสินค้า</th>
            <th class="border px-4 py-2">Stock</th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="item in promotion.activity_detail_discounts"
            :key="item.goods_id"
          >
            <td class="border px-4 py-2 text-center">
              <img
                :src="item.sku_price[0]?.image"
                alt="product"
                class="w-16 h-16 mx-auto rounded"
                v-if="item.sku_price[0]?.image"
              />
              <span v-else>ไม่มีรูป</span>
            </td>
            <td class="border px-4 py-2 text-center">
              {{ item.goods_id }}
            </td>
            <td class="border px-4 py-2 text-center">
              {{ item.sku_price[0]?.stock ?? 'ไม่มีข้อมูล' }}
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </template>
  
  <script>
  import { ref, onMounted } from 'vue'
  
  export default {
    setup() {
      const promotion = ref(null)
  
      onMounted(async () => {
        try {
          const response = await fetch(
            'https://tgsc.qifudaren.net/addons/shopro/goods2/activity?activity_id=1167&page=1&proid=&keywords=',
            {
              method: 'POST',
              headers: {
                'Content-Type': 'application/json',
                // เพิ่ม token ถ้าจำเป็น
                // 'token': 'your-token-here'
              },
              body: JSON.stringify({})
            }
          )
  
          const result = await response.json()
          console.log('API result:', result)
          promotion.value = result.data
        } catch (err) {
          console.error('Fetch error:', err)
        }
      })
  
      return {
        promotion
      }
    }
  }
  </script>
  
  <style scoped>
  /* เพิ่ม styling ได้ตามต้องการ */
  </style>
  