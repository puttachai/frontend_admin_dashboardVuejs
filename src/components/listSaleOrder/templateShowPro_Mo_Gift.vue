  <!-- แสดงรายการสินค้า -->
            <!-- 👉 Group by pro_activity_id -->
            <template
              v-for="(group, activityId) in groupByActivityId(selectedProducts)"
              :key="activityId"
            >
              <!-- 🔁 Loop สินค้าในกลุ่มนั้น -->
              <template v-for="(product, index) in group" :key="product.pro_id">
                <!-- 🔳 สินค้า -->
                <tr class="text-center bg-white">
                  <td class="px-4 py-2 border">{{ product.pro_id }}</td>
                  <td class="px-4 py-2 border">
                    <template v-if="product.pro_images">
                      <img
                        :src="
                          product.pro_images.startsWith('http')
                            ? product.pro_images
                            : BASE_URL_IMAGE + product.pro_images
                        "
                        class="w-10 h-10 rounded-full mx-auto"
                      />
                    </template>
                    <template v-else>
                      <span class="material-icons text-gray-400 text-4xl">broken_image</span>
                    </template>
                  </td>
                  <td class="px-4 py-2 border">
                    {{ product.pro_erp_title == 0 ? product.pro_title : product.pro_erp_title }}
                  </td>
                  <td class="px-4 py-2 border">{{ product.pro_goods_sku_text || "-" }}</td>
       
                  <td class="px-4 py-2 border">
                    <!-- @input="validateQuantity(product)" @blur="onQuantityChange(product, index)", @blur="onQuantityChange(product)" = ต้องคลิกพื้นที่ว่างถึงจะไป , v-model.number="product.pro_quantity" @input="onQuantityChange($event,product)-->
                    <input
                      type="number"
                      :min="1"
                      :max="product.pro_stock"
                      step="1"
                      @blur="onQuantityBlur(product)"
                      v-model="product.pro_quantity"
                      @input="onQuantityChange($event, product)"
                      :disabled="isReadOnly"
                      class="w-full px-2 py-1 border rounded"
                    />
                  </td>
 
                  <td class="px-4 py-2 border">{{ product.pro_unit_price }}</td>
                  <td class="px-4 py-2 border">{{ product.discount || 0 }}</td>
                  <td class="px-4 py-2 border">{{ totalprice(product) }}</td>
         
                  <!-- ใช้ได้ -->
                  <td
                    class="px-4 py-2 border"
                    :class="{
                      'text-red-500 cursor-pointer hover:text-red-700': !isReadOnly,
                      'text-gray-400 cursor-not-allowed': isReadOnly,
                    }"
                    @click="!isReadOnly && removeProduct(index, activityId)"
                  >
                    ลบ
                  </td>
                </tr>
              </template>

              <!-- 🟦 โปรโมชั่น (มินิมอล + ลูกเล่นไอคอน) -->
              <tr
                v-if="group[0].promotions && group[0].promotions.length > 0"
                class="bg-blue-50 hover:bg-blue-100 transition-colors duration-300"
              >
                <td colspan="9" class="px-6 py-4 border rounded-md">
                  <div class="flex items-center space-x-2 text-blue-800 font-medium">
                    <svg
                      class="w-5 h-5 text-blue-600"
                      fill="none"
                      stroke="currentColor"
                      stroke-width="2"
                      viewBox="0 0 24 24"
                    >
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        d="M13 16h-1v-4h-1m2-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
                      />
                    </svg>
                    <span>โปรโมชั่น</span>
                  </div>
                  <ul class="list-disc list-inside ml-6 mt-2 text-sm text-gray-700">
                    <li v-for="(promotion, promoIndex) in group[0].promotions" :key="promoIndex">
                      {{ promotion.title }}
                    </li>
                  </ul>
                </td>
              </tr>

              <!-- 🟨 ของแถม (มินิมอล + รูปภาพ + ฟีล modern card) -->
              <tr
                v-if="group[0].gifts && group[0].gifts.length > 0"
                class="bg-yellow-50 hover:bg-yellow-100 transition-colors duration-300"
              >
                <td colspan="9" class="px-6 py-4 border rounded-md">
                  <div class="flex items-center space-x-2 text-yellow-800 font-medium">
                    <svg
                      class="w-5 h-5 text-yellow-600"
                      fill="none"
                      stroke="currentColor"
                      stroke-width="2"
                      viewBox="0 0 24 24"
                    >
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        d="M12 8c-1.1 0-2 .9-2 2m4 0a2 2 0 00-2-2m0 4a2 2 0 002-2m-4 0a2 2 0 012-2m0 4a2 2 0 01-2-2m8-6H4a2 2 0 00-2 2v12a2 2 0 002 2h16a2 2 0 002-2V8l-6-6z"
                      />
                    </svg>
                    <span>ของแถม</span>
                  </div>
                  <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4 mt-4">
                    <div
                      v-for="(gift, giftIndex) in group[0].gifts"
                      :key="giftIndex"
                      class="flex items-center bg-white shadow-sm rounded-lg p-2 border border-gray-200"
                    >
                      <img
                        v-if="gift.pro_image"
                        :src="
                          gift.pro_image.startsWith('http')
                            ? gift.pro_image
                            : BASE_URL_IMAGE + gift.pro_image
                        "
                        class="w-12 h-12 object-cover rounded mr-4"
                        alt="gift image"
                      />
                      <div class="text-sm text-gray-800">
                        <div class="font-semibold">{{ gift.title }}</div>
                        <div class="text-gray-500">จำนวน: {{ gift.pro_goods_num }}</div>
                      </div>
                    </div>
                  </div>
                </td>
              </tr>
            </template>