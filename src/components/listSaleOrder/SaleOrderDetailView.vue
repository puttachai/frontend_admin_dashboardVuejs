<template>
  <div
    class="mainbox flex flex-col in-h-screen items-center gap-4 justify-center bg-gray-100 py-8 px-4 sm:px-6 lg:px-8">
    <!-- กล่องรวม breadcrumb + action bar -->
    <div class="fixed top-16 left-16 right-0 bg-white rounded-lg p-4 shadow-lg z-50 responsive-action-bar">
      <!-- Breadcrumb + ActionBar inline -->
      <div class="flex flex-wrap md:flex-nowrap justify-between items-center gap-4">
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
              {{ currentDocumentNo || "Loading..." }}
            </li>
          </ul>
        </nav>

        <!-- Action Bar -->
        <div class="flex flex-wrap justify-end gap-3 responsive-action-buttons md:gap-4 md:flex-nowrap">
          <!-- ✅ ถ้าอนุมัติแล้ว -->
          <div v-if="approvedVoucherNo === 'ตรวจสอบเรียบร้อย'"
            class="flex items-center gap-2 bg-green-500 text-white py-2 px-4 md:px-6 text-sm md:text-base rounded-md hover:bg-green-700 transition duration-300 shadow hover:shadow-lg disabled:bg-white disabled:text-red-600 disabled:border disabled:border-green-500 disabled:cursor-not-allowed">
            <!-- เอกสาร: {{ documentNo_route_params }} ได้รับการอนุมัติแล้ว -->
            <span class="material-icons">add_task</span>
            <span> เอกสาร: {{ documentNo_route_params }} ได้รับการอนุมัติแล้ว </span>
          </div>



          <!-- ✅ ถ้ายังไม่อนุมัติ -->
          <button v-else-if="canApprove && isReadOnly" @click="saveDocument"
            class="flex items-center gap-2 bg-green-500 text-white py-2 px-4 md:px-6 text-sm md:text-base rounded-md hover:bg-green-700 transition duration-300 shadow hover:shadow-lg">
            <span class="material-icons">add_task</span>
            <span>อนุมัติเอกสาร</span>
          </button>

          <!--  v-else-if="canApprove && isReadOnly" @click="saveDocument" -->
          <!-- <button
            class="flex items-center gap-2 bg-green-500 text-white py-2 px-4 md:px-6 text-sm md:text-base rounded-md hover:bg-green-700 transition duration-300 shadow hover:shadow-lg">
            <span class="material-icons">add_task</span>
            <span>อนุมัติเอกสาร</span>
          </button> -->

          <!-- ปุ่มพิมพ์เอกสาร พร้อม icon -->
          <button
            class="no-print bg-blue-600 hover:bg-blue-700 text-white py-2 px-4 md:px-6 text-sm md:text-base rounded-md transition"
            @click="goToPrint">
            <div class="flex items-center justify-center gap-2">
              <span class="material-icons">print</span>
              <span>พิมพ์เอกสาร</span>
            </div>
          </button>

          <!-- <button class="no-print" @click="goToPrint">พิมพ์เอกสาร</button> -->

          <!-- <div v-if="approvedVoucherNo" class="text-green-600 font-semibold mt-2">
            ✅ เอกสารนี้ได้รับการอนุมัติแล้ว: {{ approvedVoucherNo }}
          </div> -->

          <!-- ปุ่ม แก้ไข (edit) -->
          <button v-if="canEdit && isReadOnly && approvedVoucherNo !== 'ตรวจสอบเรียบร้อย'" @click="enableEditMode"
            class="bg-yellow-500 items-center text-white py-2 px-4 md:px-6 text-sm md:text-base rounded-md hover:bg-yellow-600 transition">
            <div class="flex items-center justify-center gap-2">
              <span class="material-icons">edit</span>
              <span>แก้ไข</span>
            </div>
          </button>

          <!-- ปุ่ม บันทึกการแก้ไข (save edits) -->
          <button v-if="canEdit && !isReadOnly && formData.documentNo" @click="updateDocument"
            class="bg-green-600 text-white py-2 px-4 md:px-6 text-sm md:text-base rounded-md hover:bg-green-700 transition shadow hover:shadow-lg">
            <!-- บันทึกการแก้ไข -->
            <div class="flex items-center justify-center gap-2">
              <!-- <span class="material-icons">save</span> -->
              <span>บันทึกการแก้ไข</span>
            </div>
            <!-- <span class="material-icons">save</span>
            <span>บันทึกการแก้ไข</span> -->
          </button>

          <!-- ปุ่ม ยืนยันการบันทึก (lock) -->
          <!-- <button v-if="canEdit && !isReadOnly && formData.documentNo && !isConfirmed" @click="confirmFinalSave"
            class="bg-red-600 text-white py-2 px-4 md:px-6 text-sm md:text-base rounded-md hover:bg-red-700 transition">
            ยืนยันการบันทึก (ไม่สามารถแก้ไขได้อีก) -->

            <!-- <span class="material-icons">lock</span>
            <span>ยืนยันการบันทึก (ไม่สามารถแก้ไขได้อีก)</span> -->
            
          <!-- </button> -->
        </div>

        <!-- <div class="flex flex-wrap justify-end gap-3 responsive-action-buttons md:gap-4 md:flex-nowrap"> -->

        <!-- ปุ่ม บันทึก -->
        <!-- <button v-if="!isReadOnly && isCreatePage" @click="saveDocument" -->
        <!-- <button @click="saveDocument"
            class="flex items-center gap-2 bg-green-500 text-white py-2 px-4 md:px-6 text-sm md:text-base rounded-md hover:bg-green-700 transition duration-300 shadow hover:shadow-lg">
            <span class="material-icons">add_task</span>
            <span>อนุมัติเอกสาร</span>
          </button>
        </div> -->
      </div>
    </div>

    <!-- form รายการเอกสาร -->
    <div class="boxback w-full mt-20 gap-4 bg-white p-8 rounded-lg shadow-lg">
      <div>
        <!-- Logo and Title -->
        <div class="text-center mb-4">
          <img src="../../assets/logo.svg" alt="Logo" class="mx-auto h-16" />
          <p class="mt-1 text-xl text-gray-700">รายละเอียดคำสั่งซื้อ</p>
        </div>

        <div class="flex items-center gap-2 mb-4">
          <span class="material-icons text-purple-600">content_paste</span>
          <h1 class="text-xl text-gray-700">ข้อมูล</h1>
        </div>

        <!-- แสดงภาพที่อัปโหลด -->
        <!-- <div class="md:col-span-2 mb-4 pb-4" v-if="previewImage">
                  <p class="text-sm text-gray-500 mb-2">Preview:</p>
                  <img :src="previewImage" alt="Uploaded Image"
                      class="object-cover rounded-md border w-[100px] h-[100px]" />
              </div> -->

        <!-- แบบฟอร์มส่วนที่1  -->
        <form class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">รายการ *</label>
            <div>
              <input type="text" placeholder="รหัสรายการ" disabled v-model="formData.documentNo"
                class="border mt-1.5 block w-full text-gray-700 rounded-md border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
            </div>
          </div>

          <!-- <div>
                      <label class="block text-sm font-medium text-gray-700">วันที่</label>
                      <input type="date" v-model="formData.sellDate" disabled
                          class="border mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                  </div> -->

          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">วันที่</label>
            <div class="relative">
              <!-- Flatpickr Input -->
              <flat-pickr v-model="formData.sellDate" :config="dateConfig" disabled placeholder="เลือกวันที่"
                class="pl-4 pr-10 py-2 mt-1 w-full rounded-md border border-gray-300 text-gray-700 placeholder-gray-400 shadow-sm focus:ring-purple-500 focus:border-purple-500"></flat-pickr>

              <!-- Calendar Icon -->
              <span class="absolute inset-y-0 right-3 flex items-center pointer-events-none">
                <span class="material-icons text-gray-400 text-base">calendar_today</span>
              </span>
            </div>
          </div>

          <!-- เงื่อนไขแสดงเพิ่มเติม -->
          <div v-if="showMoreData" :key="showMoreData" class="md:col-span-2 grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label class="block text-sm font-medium text-gray-700">อ้างอิง</label>
              <input type="text" v-model="formData.reference" :readonly="isReadOnly"
                class="border text-gray-700 mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
            </div>

            <div>
              <label class="block text-sm font-medium text-gray-700">ช่องทางการขาย</label>
              <input type="text" v-model="formData.channel" :readonly="isReadOnly"
                class="border text-gray-700 mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
            </div>

            <div class="md:col-span-2">
              <label class="block text-sm font-medium text-gray-700">ประเภทภาษี</label>
              <input type="text" v-model="formData.taxType" :readonly="isReadOnly"
                class="border text-gray-700 mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
            </div>
          </div>
        </form>
        <!-- ปุ่ม Show More / Show Less , <button @click="showMoreData = !showMoreData" type="button" -->
        <button @click="toggleShowMoreData" type="button"
          class="mt-4 text-purple-600 hover:underline focus:outline-none">
          {{ showMoreData ? "แสดงน้อยลง ▲" : "แสดงเพิ่มเติม ▼" }}
        </button>
      </div>

      <!-- หัวข้อ "แบบฟอร์มลูกค้า" ด้านซ้าย และ "แบบฟอร์มสินค้า" ด้านขวา -->
      <div class="gap-6 items-start mt-4">
        <!-- แบบฟอร์มลูกค้า: อยู่ฝั่งซ้าย -->
        <div>
          <!-- หัวข้อ -->
          <div class="flex items-center gap-2 mb-4">
            <span class="material-icons text-blue-600">account_circle</span>
            <h1 class="text-xl text-gray-700">แบบฟอร์มลูกค้า</h1>
          </div>

          <!-- แบบฟอร์ม -->
          <form class="grid grid-cols-1 gap-4">
            <!-- แสดงเสมอ -->
            <div>
              <label class="block text-sm font-medium text-gray-700">ชื่อลูกค้า</label>
              <input type="text" placeholder="ชื่อ, รหัส" disabled v-model="formData.fullName"
                class="mt-1 block w-full text-gray-700 rounded-md border border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
              <p v-if="formTouched && errors.fullName" class="text-red-500 text-sm mt-1">
                {{ errors.fullName }}
              </p>
            </div>

            <div>
              <label class="block text-sm font-medium text-gray-700">รหัสลูกค้า</label>
              <input type="text" v-model="formData.customerCode" disabled
                class="mt-1 block w-full text-gray-700 rounded-md border border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
              <p v-if="formTouched && errors.customerCode" class="text-red-500 text-sm mt-1">
                {{ errors.customerCode }}
              </p>
            </div>

            <div class="">
              <label class="block text-sm font-medium text-gray-700">เบอร์โทรศัพท์ลูกค้า</label>
              <input type="text" v-model="formData.phone" :readonly="isReadOnly"
                class="mt-1 block w-full text-gray-700 rounded-md border border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
            </div>

            <!-- เงื่อนไขแสดงเพิ่มเติม -->
            <div v-if="showMore">


              <div class=""> <!-- mt-4 -->
                <label class="block text-sm font-medium text-gray-700">อีเมลลูกค้า</label>
                <input type="text" v-model="formData.email" :readonly="isReadOnly"
                  class="mt-1 block w-full text-gray-700 rounded-md border border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
              </div>

              <div class="mt-4">
                <label class="block text-sm font-medium text-gray-700">ที่อยู่ลูกค้า
                  <span class="text-red-500 text-xs">*</span>
                  <span class="text-red-500 text-xs">กรุณากรอกข้อมูลนี้ที่แบบฟอร์มที่ 3 ข้อมูลที่อยู่ผู้รับ</span>
                </label>
                <input type="text" v-model="formData.address" :readonly="isReadOnly"
                  class="mt-1 block w-full text-gray-700 rounded-md border border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                <!-- <p v-if="formTouched && errors.address" class="text-red-500 text-sm mt-1">{{
                                  errors.address }}</p> -->
              </div>
            </div>
          </form>

          <!-- ปุ่ม Show More / Show Less -->
          <button @click="showMore = !showMore" type="button"
            class="mt-4 text-purple-600 hover:underline focus:outline-none">
            {{ showMore ? "แสดงน้อยลง ▲" : "แสดงเพิ่มเติม ▼" }}
          </button>
          <p v-if="formTouched && errors.address" class="text-red-500 text-sm mt-1">
            {{ errors.address }}
          </p>
        </div>
      </div>
    </div>

    <!-- หน้าสินค้า -->
    <div class="w-full mx-auto p-6 bg-white rounded-lg shadow-md">
      <!-- Header -->
      <div class="flex justify-between items-center mb-4">
        <!-- ส่วนซ้าย ไอคอนและสินค้า -->
        <div class="flex items-center gap-2">
          <span class="material-icons text-purple-600">assignment_add</span>
          <h2 class="text-xl font-semibold text-gray-700">สินค้า</h2>
        </div>

        <!-- ส่วนขวา: ปุ่มต่าง ๆ -->
        <div class="hidden mdl:flex gap-2">
          <!-- <button @click="addProductRow" :disabled="isReadOnly"
                        class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700">
                        + เพิ่มแถวสินค้า
                    </button> -->
          <button @click="showProductSelector = true" :disabled="isReadOnly"
            class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">
            เลือกสินค้า
          </button>
          <button @click="showPromotionSelector = true" :disabled="isReadOnly"
            class="bg-yellow-500 text-white px-4 py-2 rounded hover:bg-yellow-700">
            เลือกโปรโมชั่น
          </button>
          <button @click="removeAllProducts" :disabled="isReadOnly"
            class="bg-red-600 text-white px-4 py-2 rounded hover:bg-red-700">
            ลบสินค้าที่เลือกทั้งหมด
          </button>
        </div>

        <!-- Dropdown สำหรับหน้าจอเล็ก -->
      </div>

      <!-- Popup Component -->
      <ProductSelector v-if="showProductSelector" :productList="Apiproducts" @close="showProductSelector = false"
        :selectProducts_old_month="selectedProducts" @selectProductsWithMonth="addSelectedProductsWithmonth" />
      <!-- <ProductSelector v-if="showProductSelector" :productList="Apiproducts" @close="showProductSelector = false" //
                @select-products="addSelectedProducts" /> -->

      <!--  ไม่ได้ใช้ สำรองไว้ตอนแก้ไขสินค้า  -->
      <!-- <ProductSelector v-if="showProductSelectoronly" :productList="Apiproducts"
        @close="showProductSelectoronly = false" @select-products="replaceProductInRow" /> -->

      <!-- :productList="Apipromotion" -->
      <PromotionSelector v-if="showPromotionSelector" @close="showPromotionSelector = false"
        @select-promotion="SelectedPromotion" />

      <!-- Popup ตัวที่สอง -->
      <Promotion_ProductSelector v-if="showPromotionProductSelector" :selectedPromotion="selectedPromotion"
        :selectProducts_old="selectedProducts" @close="showPromotionProductSelector = false"
        @selectPromotionProducts="handleSelectedPromotionProducts" @go-back="handleBackToPromotion" />

      <!-- Popup Component -->

      <div class="overflow-x-auto">
        <table class="min-w-full border text-sm">
          <thead class="bg-gray-100 text-gray-700">
            <tr class="text-center">
              <th class="px-4 py-2 border">รหัส</th>
              <th class="px-4 py-2 border">รูปภาพ</th>
              <th class="px-4 py-2 border">ชื่อสินค้า *</th>
              <th class="px-4 py-2 border">สี</th>
              <th class="px-4 py-2 border">จำนวน *</th>
              <!-- <th class="px-4 py-2 border">คงเหลือ *</th> -->
              <th class="px-4 py-2 border">มูลค่าต่อหน่วย *</th>
              <th class="px-4 py-2 border">ส่วนลดต่อหน่วย</th>
              <th class="px-4 py-2 border">รวม</th>
              <th class="px-4 py-2 border text-center">ลบ</th>
            </tr>
          </thead>

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

            <template v-for="(groupObj, activityKey) in groupByActivityId(selectedProducts)" :key="activityKey">
              <!-- 🧩 แสดงชื่อหัวแต่ละกลุ่มโปรโมชัน -->
              <tr>
                <td colspan="9" class="px-6 py-3 bg-gray-100 font-semibold text-left text-lg text-gray-800 border">
                  {{ groupObj.title }}
                </td>
              </tr>

              <!-- 🔁 สินค้าในแต่ละก้อน -->
              <template v-for="(product, index) in groupObj.items" :key="product.pro_id">
                <!-- ✅ Copy <tr> สินค้าเดิมของคุณมาใส่ตรงนี้ -->
                <!-- เช่น: -->
                <tr class="text-center bg-white">
                  <td class="px-4 py-2 border">{{ product.pro_id }}</td>
                  <td class="px-4 py-2 border">
                    <template v-if="product.pro_images">
                      <img
                        :src="product.pro_images.startsWith('http') ? product.pro_images : BASE_URL_IMAGE + product.pro_images"
                        class="w-10 h-10 rounded-full mx-auto" />
                    </template>
                    <template v-else>
                      <span class="material-icons text-gray-400 text-4xl">broken_image</span>
                    </template>
                  </td>
                  <td class="px-4 py-2 border">
                    {{ product.pro_erp_title === '0' ? product.pro_title : product.pro_erp_title ||
                      product.erp_title }}
                  </td>
                  <td class="px-4 py-2 border">{{ product.pro_goods_sku_text || '-' }}</td>
                  <td class="px-4 py-2 border">
                    <input type="number" :min="1" :max="product.pro_stock" step="1" @blur="onQuantityBlur(product)"
                      v-model="product.pro_quantity" @input="onQuantityChange($event, product)"
                      @keypress="onlyNumberInput($event)" :disabled="isReadOnly"
                      class="w-full px-2 py-1 border rounded" />
                  </td>
                  <td class="px-4 py-2 border">{{ Number(product.pro_goods_price || product.pro_unit_price).toLocaleString(undefined, {
                                            minimumFractionDigits: 2,
                                            maximumFractionDigits: 2
                                        })}}
                  </td>
                  <td class="px-4 py-2 border">{{ product.discount || 0 }}</td>
                  <td class="px-4 py-2 border">{{ Number(totalprice(product)).toLocaleString(undefined, {
                                            minimumFractionDigits: 2,
                                            maximumFractionDigits: 2
                                        })}} 
                  </td>
                  <td class="px-4 py-2 border" :class="{
                    'text-red-500 cursor-pointer hover:text-red-700': !isReadOnly,
                    'text-gray-400 cursor-not-allowed': isReadOnly
                  }" @click="!isReadOnly && removeProduct(index, activityKey)">
                    ลบ
                  </td>
                </tr>
                <!-- ❗ แจ้งเตือนเฉพาะกรณี: เป็นสินค้าจากโปรโมชั่นแต่ไม่เข้าเงื่อนไข -->
                <tr v-if="product.pro_activity_id != 0 && product.st == false">
                  <td colspan="9" class="px-6 py-3 bg-red-50 text-red-700 text-sm border-l-4 border-red-400">
                    ⚠️ สินค้านี้ถูกเลือกมาจากโปรโมชั่น แต่ยอดซื้อไม่เข้าเงื่อนไข
                    และจะไม่ถูกนำไปรวมคำนวณในโปรโมชั่นรายวัน
                  </td>
                </tr>

              </template>

              <!-- 🔽 แสดง Promotions ถ้ามี -->
              <tr v-if="groupObj.items[0].promotions && groupObj.items[0].promotions.length > 0"
                class="bg-blue-50 hover:bg-blue-100 transition-colors duration-300">
                <td colspan="9" class="px-6 py-4 border rounded-md">
                  <div class="flex items-center space-x-2 text-blue-800 font-medium">
                    <svg class="w-5 h-5 text-blue-600" fill="none" stroke="currentColor" stroke-width="2"
                      viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round"
                        d="M13 16h-1v-4h-1m2-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                    <span>โปรโมชั่น</span>
                  </div>
                  <ul class="list-disc list-inside ml-6 mt-2 text-sm text-gray-700">
                    <li v-for="(promotion, promoIndex) in groupObj.items[0].promotions" :key="promoIndex">
                      {{ promotion.title }}
                    </li>
                  </ul>
                </td>
              </tr>

              <!-- 🔽 แสดง Gifts ถ้ามี -->
              <tr v-if="groupObj.items[0].gifts && groupObj.items[0].gifts.length > 0"
                class="bg-yellow-50 hover:bg-yellow-100 transition-colors duration-300">
                <td colspan="9" class="px-6 py-4 border rounded-md">
                  <div class="flex items-center space-x-2 text-yellow-800 font-medium">
                    <svg class="w-5 h-5 text-yellow-600" fill="none" stroke="currentColor" stroke-width="2"
                      viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round"
                        d="M12 8c-1.1 0-2 .9-2 2m4 0a2 2 0 00-2-2m0 4a2 2 0 002-2m-4 0a2 2 0 012-2m0 4a2 2 0 01-2-2m8-6H4a2 2 0 00-2 2v12a2 2 0 002 2h16a2 2 0 002-2V8l-6-6z" />
                    </svg>
                    <span>ของแถม</span>
                  </div>
                  <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4 mt-4">
                    <div v-for="(gift, giftIndex) in groupObj.items[0].gifts" :key="giftIndex"
                      class="flex items-center bg-white shadow-sm rounded-lg p-2 border border-gray-200">
                      <img v-if="gift.pro_image"
                        :src="gift.pro_image.startsWith('http') ? gift.pro_image : BASE_URL_IMAGE + gift.pro_image"
                        class="w-12 h-12 object-cover rounded mr-4" alt="gift image" />
                      <div class="text-sm text-gray-800">
                        <div class="font-semibold">{{ gift.title }}</div>
                        <div class="font-semibold">{{ gift.color || gift.pro_goods_sku_text }}</div>
                        <div class="text-gray-500">จำนวน: {{ gift.pro_goods_num }}</div>
                      </div>
                    </div>
                  </div>
                </td>
              </tr>
            </template>

          </tbody>
        </table>
      </div>

      <!-- ช่องทางจัดส่ง -->
      <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mt-6">
        <div>
          <label class="block font-medium mb-1 text-gray-700">ช่องทางจัดส่ง
            <span class="text-red-500 text-xs">*</span>
            <span class="text-red-500 text-xs">จำเป็นต้องกรอกข้อมูลนี้</span>
          </label>
          <select v-model="formData.deliveryType" placeholder="ช่องทางจัดส่ง" :disabled="isReadOnly"
            style="margin: 0.4rem" class="w-full border px-3 py-2 rounded text-gray-700">
            <option value="">เลือกช่องทางจัดส่ง</option>
            <option>ไปรษณีย์</option>
            <!-- <option>ไปรษณีย์</option> -->
            <option>แมสเซนเจอร์</option>
            <option>ขนส่งเอกชน</option>
          </select>
          <p v-if="this.formTouched && errors.deliveryType" class="text-red-500 text-sm mt-1">
            {{ errors.deliveryType }}
          </p>
        </div>
        <div class="grid grid-cols-2 gap-4">
          <div>
            <label class="block font-medium mb-1 text-gray-700">ส่วนลด</label>
            <input type="text" v-model="formData.totalDiscount" :readonly="isReadOnly"
              class="w-full text-gray-700 border px-3 py-2 rounded text-gray-700" placeholder="จำนวนเงิน หรือ %" />
          </div>
          <div>
            <label class="block font-medium mb-1 text-gray-700">ค่าจัดส่ง</label>
            <input type="number" :min="0" v-model="formData.deliveryFee" :readonly="isReadOnly"
              class="w-full text-gray-700 border px-3 py-2 rounded text-gray-700" placeholder="ค่าจัดส่ง" />
          </div>
        </div>
      </div>

      <!-- หมายเหตุ -->
      <div class="mt-4">
        <label class="block font-medium mb-1 text-gray-700">หมายเหตุ</label>
        <textarea rows="3" v-model="formData.note" :readonly="isReadOnly"
          class="w-full border px-3 py-2 rounded text-gray-700"></textarea>
      </div>

      <!-- รายละเอียดคำสั่งงาน -->
      <div class="mt-4">
          <label class="block font-medium mb-1 text-gray-700">รายละเอียดคำสั่งงาน</label>
          <textarea rows="3" v-model="formData.workDetail" :readonly="isReadOnly"
              class="w-full border px-3 py-2 rounded text-gray-700"></textarea>
      </div>

      <div class="mt-6 text-right space-y-1">
        <!-- ซ่อนมูลค่ารวมก่อนภาษี เมื่อ isVatIncluded === true -->
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
          <!-- <span class="ml-2 text-gray-700">{{ Number(totalAmountBeforeDiscount).toLocaleString(undefined, {
                        minimumFractionDigits: 2, maximumFractionDigits: 2
                    }) }}</span> -->
        </div>

        <!-- :disabled="isReadOnly" -->
        <div class="text-gray-700 flex items-center justify-end">
          <input type="checkbox" v-model="isVathidden" id="vatCheckbox" :disabled="isReadOnly" class="mr-2" />
          <label for="vatCheckbox">แสดงภาษีมูลค่าเพิ่ม (7%) และมูลค่าก่อนภาษี</label>
          <!-- แสดงภาษีเมื่อ isVatIncluded === true -->
          <span v-if="isVathidden" class="ml-2 text-gray-700">
            {{
              vatAmount.toLocaleString(undefined, {
                minimumFractionDigits: 2,
                maximumFractionDigits: 2,
              })
            }}
            บาท
          </span>
          
        </div>

        <div v-if="!formData.deliveryFee === 0" class="text-gray-700">
          ค่าจัดส่ง:
          <span class="ml-2 text-gray-700">
            {{ formData.deliveryFee ? formData.deliveryFee.toLocaleString(undefined, {
              minimumFractionDigits: 2,
              maximumFractionDigits: 2
            }) : '0.00' }}
          </span>
        </div>
        <div v-if="!formData.totalDiscount === 0" class="text-gray-700">
          ส่วนลดท้ายบิล:
          <span class="ml-2 text-gray-700">
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
              grandTotal.toLocaleString(undefined, {
                minimumFractionDigits: 2,
                maximumFractionDigits: 2,
              })
            }}
          </span>
          
        </div>
      </div>
    </div>

    <!-- -ข้อมูลที่อยู่ผู้รับ  -->
    <div class="w-full mx-auto p-6 bg-white rounded-lg shadow-md space-y-8">
      <!-- กล่องหลัก แบ่งเป็น 2 ฝั่ง -->
      <div class="gap-8">
        <!-- ซ้าย: ข้อมูลที่อยู่ผู้รับ -->
        <div>
          <div class="flex items-center gap-2 mb-4">
            <span class="material-icons text-blue-600">contact_mail</span>
            <h2 class="text-lg font-semibold text-gray-800">ข้อมูลที่อยู่ผู้รับ</h2>
          </div>

          <div class="space-y-4">
            <div>
              <label class="text-sm text-gray-700 block mb-1">
                ชื่อผู้รับ
                <span class="text-red-500 text-xs ml-1">*</span>
                <span class="text-red-500 text-xs ml-1">จำเป็นต้องกรอกข้อมูลนี้</span>
              </label>
              <input type="text" v-model="formData.receiverName" :readonly="isReadOnly"
                class="w-full text-gray-700 border rounded px-3 py-2" />
              <p v-if="formTouched && errors.receiverName" class="text-red-500 text-sm mt-1">
                {{ errors.receiverName }}
              </p>
            </div>

            <!-- <div class="flex items-center gap-2 text-sm text-blue-600 cursor-pointer">
                          <span class="material-icons text-base">content_copy</span>
                          <span>คัดลอกจากข้อมูลลูกค้า</span>
                      </div> -->

            <div>
              <label class="text-sm text-gray-700 block mb-1">เบอร์โทรศัพท์ผู้รับ
                <span class="text-red-500 text-xs ml-1">*</span>
                <span class="text-red-500 text-xs ml-1">จำเป็นต้องกรอกข้อมูลนี้</span>
              </label>
              <input type="tel" v-model="formData.receiverPhone" :readonly="isReadOnly"
                class="w-full text-gray-700 border rounded px-3 py-2" />
              <p v-if="formTouched && errors.receiverPhone" class="text-red-500 text-sm mt-1">
                {{ errors.receiverPhone }}
              </p>
            </div>

            <!-- <div v-if="showMoreAdress"> -->
            <div>
              <label class="text-sm text-gray-700 block mb-1">อีเมลผู้รับ</label>
              <input type="email" v-model="formData.receiverEmail" :readonly="isReadOnly"
                class="w-full text-gray-700 border rounded px-3 py-2" />
            </div>

            <div class="mt-4">
              <label class="text-sm text-gray-700 block mb-1">ที่อยู่/จัดส่ง
                <span class="text-red-500 text-xs ml-1">*</span>
                <span class="text-red-500 text-xs ml-1">จำเป็นต้องกรอกข้อมูลนี้</span>
              </label>
              <textarea rows="4" v-model="formData.receiverAddress" :readonly="isReadOnly"
                class="w-full text-gray-700 border rounded px-3 py-2 resize-none">
          </textarea>
            </div>


            <div class="flex justify-end gap-4 mt-4">
              <!-- ปุ่ม popup ด้านล่างขวา -->
              <div class="bottom-6 right-6 z-50 justify-self-end">
                <button @click="showAddressPopupBase = true" :disabled="isReadOnly"
                  class="bg-green-600 text-white item-end px-6 py-3 rounded-lg shadow-lg hover:bg-green-700 transition">
                  + เลือกที่อยู่ / จัดส่ง เดิมที่มีอยู่
                </button>
              </div>

              <!-- ปุ่ม popup ด้านล่างขวา -->
              <div class="bottom-6 right-6 z-50 justify-self-end">
                <button @click="showAddressPopup = true" :disabled="isReadOnly"
                  class="bg-purple-600 text-white item-end px-6 py-3 rounded-lg shadow-lg hover:bg-purple-700 transition">
                  + เพิ่มที่อยู่ / จัดส่ง ใหม่
                </button>
              </div>

              <!-- ✅ แสดง Popup -->
              <DeliveryAddressPopup v-if="showAddressPopup" :existingAddress="selectedAddress"
                @close="showAddressPopup = false" @submitted="handleAddressSelected" />

              <DeliveryAddressPopupBase v-if="showAddressPopupBase" :existingAddressBase="selectedAddressBase"
                @close="showAddressPopupBase = false" :customerNo="formData.customerCode"
                @submitted="handleAddressSelectedBase" />

              <p v-if="formTouched && errors.receiverAddress" class="text-red-500 text-sm mt-1">
                {{ errors.receiverAddress }}
              </p>
            </div>

          </div>
        </div>

      </div>

      <!-- ขวา: ข้อมูลการจัดส่งสินค้า -->
      <div>
        <div class="flex items-center gap-2 mb-4">
          <span class="material-icons text-purple-600">local_shipping</span>
          <h2 class="text-lg font-semibold text-gray-800">ข้อมูลการจัดส่งสินค้า</h2>
        </div>

        <div class="space-y-4">
          <div>
            <label class="block text-sm font-medium text-gray-700">วันที่จัดส่ง</label>

            <div class="relative">
              <!-- Flatpickr Input -->
              <flat-pickr v-model="formData.deliveryDate" :config="dateConfig" :disabled="isReadOnly"
                class="cursor-pointer w-full text-gray-700 border rounded px-3 py-2"></flat-pickr>
              <!-- class="cursor-not-allowed pr-10 mt-1 pl-4 py-2 w-full border border-gray-300 rounded-lg shadow-sm focus:border-purple-500 focus:ring-purple-500 text-gray-700 placeholder-gray-400 bg-gray-100" /> -->

              <!-- Calendar Icon on the right -->
              <span class="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none"
                style="padding-top: 0.2rem">
                <span class="material-icons text-gray-400 text-base">calendar_today</span>
              </span>
            </div>
          </div>
          <p v-if="formTouched && errors.deliveryDate" class="text-red-500 text-sm mt-1">
            {{ errors.deliveryDate }}
          </p>

          <div>
            <label class="text-sm text-gray-700 block mb-1">Tracking No.
              <!-- <span class="text-red-500 text-xs ml-1">*</span>
              <span class="text-red-500 text-xs ml-1">จำเป็นต้องกรอกข้อมูลนี้</span> -->
            </label>
            <input type="text" v-model="formData.trackingNo" :readonly="isReadOnly"
              class="w-full text-gray-700 border rounded px-3 py-2" />
            <p v-if="formTouched && errors.trackingNo" class="text-red-500 text-sm mt-1">
              {{ errors.trackingNo }}
            </p>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div>
    <!-- Loading Overlay -->
    <div v-if="isLoading" class="fixed inset-0 bg-black bg-opacity-40 flex items-center justify-center z-50">
      <div class="text-center">
        <svg class="animate-spin h-10 w-10 text-blue-600 mx-auto" xmlns="http://www.w3.org/2000/svg" fill="none"
          viewBox="0 0 24 24">
          <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
          <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8H4z"></path>
        </svg>
        <div class="mt-2 text-white text-lg">กำลังโหลดข้อมูล...</div>
      </div>
    </div>
    <!--  END Loading Overlay -->
  </div>
</template>

<script>
import { ref, onMounted, watch } from "vue";
import axios from "axios";
import Swal from "sweetalert2";
import ProductSelector from "@/components/ProductSelector.vue";
import PromotionSelector from "@/components/PromotionSelector.vue";
import Promotion_ProductSelector from "@/components/Promotion_ProductSelector.vue";
import DeliveryAddressPopup from "@/components/DeliveryAddressPopup.vue";
import DeliveryAddressPopupBase from '@/components/DeliveryAddressPopupBase.vue'
// import ConfirmEditPopup from '@/components/saleOrder/ConfirmEditPopup.vue'
import qs from "qs";
import Flatpickr from "vue-flatpickr-component";
import "flatpickr/dist/flatpickr.css";

// ✅ import Thai locale
import { Thai } from "flatpickr/dist/l10n/th.js";
import flatpickr from "flatpickr";

import { sendToMacfive } from "@/services/macfiveService.js";

// ✅ ตั้งค่าภาษาไทยให้กับ flatpickr
flatpickr.localize(Thai);

const BASE_URL = import.meta.env.VITE_API_URL;
const BASE_URL_LOCAL = import.meta.env.VITE_API_URL_LOCAL;

console.log("BASE_URL_LOCAL:", BASE_URL_LOCAL);

const BASE_URL_MAC_FIVEL = import.meta.env.VITE_API_URL_MAC_FIVE;
const BASE_URL_AUTH = import.meta.env.VITE_API_URL_AUTH;
const BASE_URL_IMAGE = import.meta.env.VITE_API_URL_IMAGE;

export default {
  // name: 'SignupForm',
  components: {
    ProductSelector,
    PromotionSelector,
    Promotion_ProductSelector,
    DeliveryAddressPopup,
    DeliveryAddressPopupBase,
    "flat-pickr": Flatpickr,
    // ConfirmEditPopup
  },
  data() {
    return {
      approvedVoucherNo: "", // สำหรับเก็บเลขที่เอกสารที่อนุมัติแล้ว

      currentDocumentNo: "", // แสดง document_no ใน breadcrumb

      // documentNo_route_params: route.params.id,
      documentNo_route_params: "", // ตั้งไว้ก่อน

      isLoading: false, // สำหรับ loading spinner

      isVatIncluded: true, //  เริ่มต้นให้คิดภาษี

      isVathidden: false, //  เริ่มต้นให้คิดภาษี
      originalIsVathidden: false,

      // ตัวแปรควบคุม popup
      showAddressPopup: false, // ควบคุมการแสดง popup ที่อยู่]
      showAddressPopupBase: false, // ควบคุมการแสดง popup ที่อยู่]

      //  เก็บข้อมูลที่อยู่ที่เลือกจาก popup
      selectedAddress: [],
      selectedAddressBase: [],

      // … existing data …
      isReadOnly: true, // ใช้ควบคุมสถานะ readonly

      isConfirmed: false, // สำหรับควบคุมปุ่ม "ยืนยันการบันทึก"
      lockedDocumentNos: [], // เอกสารที่ถูกล็อก (เก็บใน LocalStorage หรือดึงจาก backend)

      errors: {}, // เก็บข้อผิดพลาดของฟอร์ม
      formTouched: false, // ค่าเริ่มต้น

      customerData: JSON.parse(localStorage.getItem("selectDataCustomer") || "null"),

      BASE_URL_IMAGE: import.meta.env.VITE_API_URL_IMAGE,

      selectedDate: "",
      // ✅ ตั้งค่ารูปแบบวันและปฏิทิน
      dateConfig: {
        dateFormat: "d/m/Y", // เช่น 01/07/2568
        // dateFormat: 'Y-m-d',
        locale: Thai, // ใช้ภาษาไทย
        // disabledMobile: true, // ปิดการเลื่อนเดือน
      },

      showMore: false, // ค่าเริ่มต้น

      showProductSelector: false,
      showPromotionSelector: false,
      showProductSelectoronly: false,

      showPromotionProductSelector: false,
      selectedPromotion: [],

      showConfirmEditPopup: false,
      popupFormData: [],

      Apiproducts: [], // เก็บข้อมูลสินค้าที่ได้จาก API

      pageSize: 30, // ค่าเริ่มต้น
      totalItems: 0, // ค่าเริ่มต้น

      showMoreData: false, // ค่าเริ่มต้น
      showMoreAdress: false, // ค่าเริ่มต้น

      isDropdownOpen: false, // ควบคุมการเปิด/ปิด Dropdown

      deliveryAddress: [], // 🏡 เก็บข้อมูลที่อยู่จาก so_delivery_address

      formData: {

        vatVisible: false, // ตัวนี้ไว้เก็บสถานะว่าติ๊กไว้หรือไม่

        listCode: "",
        sellDate: "",
        order_Id: "",
       
        sellDate: new Date(), // ✅ ใช้ Date object ตรง ๆ
        deliveryDate: new Date(), // ✅ ใช้ Date object ตรง ๆ
        // expireDate: '',
        reference: "" || "-",
        channel: "" || "-",
        taxType: "" || "-",

        fullName: "",
        customerCode: "",
        phone: "",
        email: "" || "-",
        address: "",
        receiverName: "",
        receiverPhone: "" || "-",
        receiverEmail: "" || "-",
        receiverAddress: "",
        note: "" || "-",
        workDetail: '' || '-',

        promotions: [], // เก็บรายการสินค้าที่เลือก
        gifts: [], // เก็บรายการของแถม

        // ใช้
        // deliveryDate: '',

        trackingNo: "",
        deliveryType: "",
        totalDiscount: "" || 0,

        deliveryFee: "",

        documentNo: "",

        pro_quantity: "" || 0,

        discount: "" || 0,

        // ... ของเดิมทั้งหมด
        price_before_tax: 0,
        tax_value: 0,
        price_with_tax: 0,
        // ... ต่อไป

        final_total_price: 0,

        // total_price: '' || 0,

        // product_name : product.pro_name,
        // qty: '',
        pro_erp_title: "",
        // pro_name: '',

        productList: [],

        warehouseCode: "H1",
        docType: "SO",
      },

      //form ที่โหลดมาตั้งต้นเพื่อเปรียบเทียบค่าว่ามีการเปลี่ยนแปลงก่อนอัปเดทไหม
      originalFormData: {},
      originalSelectedProducts: [],

      selectedProducts: [], // ค่าเริ่มต้นเป็น array ว่าง

      allSelectedPromotionProducts: [], // 🔁 รวมสินค้าที่เคยเลือกทั้งหมด
    };
  },

  async mounted() {
    const docNo = this.$route.params.id;

    console.log('Check mounted docNo:', docNo);

    this.documentNo_route_params = docNo;
    // ดึงค่าจาก URL param
    this.currentDocumentNo = `Sale Order: ${docNo}`;

    // loadDataDocument
    await this.loadDocumentData(this.documentNo_route_params);

    try {
      const res = await axios.get(
        `${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/document_running/get_approved_status.php?documentNo=${docNo}`
      );

      if (res.data.success && res.data.status) {
        const status = res.data.status;

        if (status === "ตรวจสอบเรียบร้อย") {
          this.approvedVoucherNo = status;
        } else {
          this.approvedVoucherNo = ""; // ยังไม่อนุมัติ
        }
      } else {
        this.approvedVoucherNo = "";
      }
    } catch (err) {
      console.error("โหลดสถานะล้มเหลว", err);
      this.approvedVoucherNo = "";
    }

  },

  watch: {
    // watch พารามิเตอร์ใน route เมื่อเปลี่ยน documentNo ให้โหลดข้อมูลใหม่
    '$route.params.id': {
      immediate: false,
      handler(newDocNo, oldDocNo) {
        if (newDocNo !== oldDocNo) {
          console.log('Route param changed:', newDocNo);
          console.log('Route param changed Old:', oldDocNo);

          this.documentNo_route_params = newDocNo;
          this.currentDocumentNo = `Sale Order: ${newDocNo}`;

          this.loadDocumentData(newDocNo);
       
        }
      }
    },

    // ของเดิมของคุณ
    isVatIncluded(newVal) {
      this.formData.taxType = newVal ? "รวมภาษี" : "ไม่รวมภาษี";
    }
  },

  
  // watch: {
  //   isVatIncluded(newVal) {
  //     this.formData.taxType = newVal ? "รวมภาษี" : "ไม่รวมภาษี";
  //   },
  // },

  computed: {
    totalAmountBeforeDiscount() {
      const subtotal = this.selectedProducts.reduce((sum, product) => {
        const qty = product.pro_quantity || 0;
        const price = product.pro_unit_price || 0;
        const discount = product.discount || 0;
        return sum + (qty * price - discount);
      }, 0);
      const deliveryFee = parseFloat(this.formData.deliveryFee) || 0;
      // const totalDiscount = parseFloat(this.formData.totalDiscount) || 0;
      const totalDiscount = Math.abs(parseFloat(this.formData.totalDiscount || 0)) || 0;
      const total = subtotal + deliveryFee - totalDiscount;
      return total < 0 ? 0 : total;
    },

    // ✅ แก้ไขให้เป็นราคารวมภาษีแล้ว
    grandTotal() {
      const grossAmount = this.totalAmountBeforeDiscount; // ราคารวมภาษีแล้ว

      if (this.isVatIncluded) {
        // ถ้าเป็นราคารวมภาษี ให้ return ยอดเต็ม
        return grossAmount;
      } else {
        // ถ้าไม่รวมภาษี ให้บวกแวท 7%
        return grossAmount * 1.07;
      }
    },

    // ✅ เพิ่ม computed สำหรับราคาก่อนภาษี (สำหรับแสดงผล)
    netAmountBeforeVat() {
      const grossAmount = this.totalAmountBeforeDiscount;

      if (this.isVatIncluded) {
        // ถ้าเป็นราคารวมภาษี ให้คำนวณราคาก่อนภาษี
        return grossAmount / 1.07;
      } else {
        // ถ้าไม่รวมภาษี ราคาก่อนภาษีคือยอดเต็ม
        return grossAmount;
      }
    },

    // ✅ เพิ่ม computed สำหรับยอดภาษี
    vatAmount() {
      if (this.isVatIncluded) {
        const grossAmount = this.totalAmountBeforeDiscount;
        return grossAmount - grossAmount / 1.07;
      } else {
        return this.totalAmountBeforeDiscount * 0.07;
      }
    },
   
    isCreatePage() {
      return this.$route.path === "/createsalelist";
    },
    visibleButtons() {
      const buttons = [];
      if (this.isReadOnly) buttons.push("edit");
      if (!this.isReadOnly && this.isCreatePage) buttons.push("save");
      if (!this.isReadOnly && this.formData.documentNo && !this.isCreatePage)
        buttons.push("update");
      return buttons;
    },

    isAdmin() {
      return localStorage.getItem("role_admin") === "true";
    },
    isFa() {
      return localStorage.getItem("role_fa") === "true";
    },
    isCrm() {
      return localStorage.getItem("role_crm") === "true";
    },
    canApprove() {
      // การเงิน (fa) หรือ Admin เท่านั้น
      return this.isFa || this.isAdmin;
    },
    canEdit() {
      // ฝ่ายขาย (crm) หรือ Admin เท่านั้น
      return this.isCrm || this.isAdmin;
    },
  },

  methods: {

    async goToPrint() {
     
      console.log("📄 ข้อมูลเอกสารที่โหลด:", this.formData);

      const printPayload = {
        order: this.formData,
        productList: this.selectedProducts,
        deliveryAddress: this.deliveryAddress,
      };

      // 2. เก็บข้อมูลลง sessionStorage
      //    เก็บเฉพาะ data.data (ที่มี order + productList ฯลฯ)
      sessionStorage.setItem(
        'printData',
        JSON.stringify(printPayload)
      );

      console.log("📦 ส่งข้อมูลที่จะพิมพ์ ไปยัง PrintView:", printPayload);

      // 3. เปิดแท็บใหม่ไปที่ /print-order
      const printUrl = `${window.location.origin}/print-order/${this.formData.order_Id}`;
      // const printUrl = `${window.location.origin}/print-order/${orderId}` 
      window.open(printUrl, '_blank') // เปิดแท็บใหม่
      // window.open('/print-order', '_blank');
    },

    enableEditMode() {
      // if (this.canEdit) {
      this.isReadOnly = false;
      // }
    },

    async loadDocumentData(documentNo_route_params) {
      try {
        this.isLoading = true;

        const response = await axios.get(
          `${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/sale_order/get_sale_order.php?documentNo=${documentNo_route_params}`
        );

        // const resData = JSON.parse(response.data);
        const resData = response.data;

        console.log("✅ Log :", resData);

        //console.log("😂 Log Value resData: ", resData.data);
        //console.log(JSON.parse(resData));
        if (resData.success) {
          // เติมข้อมูลลงใน formData โดยรักษาฟิลด์ที่ไม่ได้อยู่ใน API
          this.formData = {
            ...this.formData, // เก็บค่าฟิลด์เดิมที่ไม่ได้อยู่ใน API
            sellDate: resData.data.order.sell_date || "",
            order_Id: resData.data.order.id || "",
            listCode: resData.data.order.list_code || "",
            reference: resData.data.order.reference || "",
            channel: resData.data.order.channel || "",
            taxType: resData.data.order.tax_type || "",
            fullName: resData.data.order.full_name || "",
            customerCode: resData.data.order.customer_code || "",
            phone: resData.data.order.phone || "",
            email: resData.data.order.email || "",
            address: resData.data.order.address || "",
            receiverName: resData.data.order.receiver_name || "",
            receiverPhone: resData.data.order.receiver_phone || "",
            receiverEmail: resData.data.order.receiver_email || "",
            receiverAddress: resData.data.order.receiver_address || "",
            note: resData.data.order.note || "",
            workDetail: resData.data.order.work_detail || '',
            deliveryDate: resData.data.order.delivery_date || "",
            trackingNo: resData.data.order.tracking_no || "",
            deliveryType: resData.data.order.delivery_type || "",
            totalDiscount: resData.data.order.total_discount || 0,
            deliveryFee: resData.data.order.delivery_fee || 0,
            tax_value: resData.data.order.tax_value || 0,
            price_before_tax: resData.data.order.price_before_tax || 0,
            final_total_price: resData.data.order.final_total_price || 0,
            documentNo: resData.data.order.document_no || "",
            vatVisible: resData.data.order.vat_visible || false,


            //
            promotions: resData.data.promotions || [],
            gifts: resData.data.gifts || [],
          };

          this.isVathidden = !!Number(resData.data.order.vat_visible);
          this.originalIsVathidden = this.isVathidden; // เก็บค่าเดิมไว้เปรียบเทียบ

          console.log("📄 ข้อมูลเอกสารที่โหลด:", resData.data.productList);
          console.log("🔍 ก่อน map this.selectedProducts:", this.selectedProducts);

          this.selectedProducts = resData.data.productList.map((product) => {
            console.log("🛠️ กำลัง map product:", product); // 👈 log ตรงนี้เช็กแต่ละตัว

            const productObj = {

              item_id: product.id,
              pro_id: product.pro_sku_price_id,
              pro_sku_price_id: product.pro_sku_price_id,
              // pro_id: product.pro_id,
              pro_erp_title: product.pro_erp_title,
              pro_title: product.pro_title,
              pro_quantity: product.pro_goods_num,
              pro_goods_num: product.pro_goods_num,
              pro_goods_id: product.pro_goods_id,
              pro_unit_price: parseFloat(product.unit_price),
              // pro_goods_price: parseFloat(product.unit_price),
              pro_discount: parseFloat(product.discount),
              pro_total_price: parseFloat(product.total_price),
              st: product.st,
              pro_stock: product.stock || 0,
              pro_images: product.pro_image,
              prosn: product.sn,
              pro_sn: product.pro_sn,
              pro_unit: product.pro_units || "",
              // pro_unit: product.unit || '',
              activity_id: product.activity_id || 0,
              pro_activity_id: product.pro_activity_id || 0, // ✅ ใช้ชื่อนี้ให้ตรง backend
              pro_goods_sku_text: product.pro_goods_sku_text || "",
              // pro_sku_pricr_id: product.pro_sku_pricr_id || '',
              // promotions: matchedPromotions,
              // gifts: matchedGifts
              // ✅ ดึงจาก product โดยตรง
              // promotions: product.promotions || [],
              // gifts: product.gifts || [],
              // ✅ ดึงจาก product โดยตรง
              promotions: product.promotions || [],
              gifts: product.gifts || [],
            };

            console.log("🎁 productObj:", productObj); // <--- สำคัญ
            return productObj;
          });

          // ✅ เพิ่มข้อมูลที่อยู่จัดส่งลงใน data
          this.deliveryAddress = resData.data.deliveryAddress || {};

          console.log("📄 ข้อมูลเอกสารที่โหลด:", this.formData);
          console.log("🛒 รายการสินค้า:", this.selectedProducts);
          console.log("🛒 ข้อมูลที่อยู่จัดส่ง:", this.deliveryAddress);

          // ยังไม่ใช้
          this.originalFormData = JSON.parse(JSON.stringify(this.formData)); // deep copy
          this.originalSelectedProducts = JSON.parse(JSON.stringify(this.selectedProducts));

          this.isLoading = false;
        } else {
          Swal.fire({ text: resData.message, icon: "error" });
          console.log("resData1");
        }
      } catch (err) {
        const message =
          err.response?.data?.message || err.message || "เกิดข้อผิดพลาดในการโหลดข้อมูลเอกสาร";
        Swal.fire({ text: message, icon: "error" });
        console.log("resData2");
      }
    },

    SelectedPromotion(promotionData) {
      console.log("รับโปรโมชั่นจาก child:", promotionData);

      this.selectedPromotion = promotionData;
      this.showPromotionSelector = false;
      console.log("ปิด popup 1");

      setTimeout(() => {
        this.showPromotionProductSelector = true;
        console.log("เปิด popup 2");
      }, 100);
    },

    async submittedProduct() {

      try {
        const token = localStorage.getItem('token');

        if (!token) {

          console.error('Token not found in localStorage');
          
          Swal.fire({
            title: "กรุณาเลือกร้านค้าของลูกค้า",
            text: "กรุณาเลือกข้อมูลลูกค้าก่อนทำการแก้ไขข้อมูล",
            icon: "error",
          }).then((result) => {
            if (result.isConfirmed) {
              this.$router.push("/customer");
            }
          });

          return;
        }     

        console.log('Check: this.selectedProducts', this.selectedProducts);

        const productsForApi = this.selectedProducts.map(product => {
          // ตรวจสอบ pro_quantity/pro_goods_num ว่าว่างหรือไม่
          const qty = (product.pro_goods_num === '' || product.pro_goods_num == null)
            ? 1
            : Number(product.pro_goods_num);

          return {
            pro_activity_id: product.pro_activity_id || 0,
            pro_goods_id: product.pro_goods_id,
            pro_goods_price: parseFloat(product.pro_unit_price) || 0,
            pro_sku_price_id: product.pro_sku_price_id || product.pro_id || 0,
            pro_erp_title: product.pro_erp_title || '',
            pro_goods_num: qty,               // ใช้ qty ที่ตรวจสอบแล้ว
            pro_image: product.pro_images,
            pro_sn: product.pro_sn,
            pro_title: product.pro_title,
            pro_units: product.pro_units
          };
        });

        // 2) กรองทิ้งรายการที่ qty <= 0 (ไม่ควรมี แต่ป้องกันไว้)
        const validProducts = productsForApi.filter(p => p.pro_goods_num > 0);

        if (validProducts.length === 0) {
          console.log('⛔ ไม่มีสินค้าที่มีจำนวนที่ถูกต้อง ไม่เรียก API');
          return;
        }

        // ถ้าไม่มีสินค้า valid เลย → ไม่ต้องเรียก API
        if (validProducts.length === 0) {
          console.log('⛔ ไม่มีสินค้าที่มีจำนวนที่ถูกต้อง ไม่เรียก API');
          return;
        }

        const payload = { products: validProducts };

        // สร้าง payload จาก selectedProducts ทั้งหมด
        // const payload = {
        //   products: this.selectedProducts.map(product => ({
        //     pro_activity_id: product.pro_activity_id || 0,
        //     pro_goods_id: product.pro_goods_id,
        //     pro_goods_price: parseFloat(product.pro_unit_price) || 0,
        //     pro_sku_price_id: product.pro_sku_price_id || product.pro_id || 0,
        //     pro_erp_title: product.pro_erp_title || '',
        //     pro_goods_num: product.pro_quantity, // ส่งจำนวนล่าสุด
        //     pro_image: product.pro_images,
        //     pro_sn: product.pro_sn,
        //     pro_title: product.pro_title,
        //     pro_units: product.pro_units
        //   }))
        // };

        const response = await axios.post(
          `${BASE_URL}/cart_out/index`,
          payload,
          {
            headers: {
              'Content-Type': 'application/json',
              token: token,
            },
          }
        );

        console.log(' 🛑 response :', response);

        if (response.data.code === 1) {
          const data = response.data.data.products || [];
          console.log('API response products:', data);

          const datasumdiscount = response.data.data;

          console.log('API response datasumdiscount:', datasumdiscount);

          if (datasumdiscount.discount_month !== undefined || datasumdiscount.discount_day !== undefined) {
            const discountMonth = Math.abs(Number(datasumdiscount.discount_month) || 0);
            const discountDay = Math.abs(Number(datasumdiscount.discount_day) || 0);
            this.formData.totalDiscount = discountMonth + discountDay;
            console.log("🎯 รวมส่วนลดทั้งหมด:", this.formData.totalDiscount);
          } else {
            console.warn("⚠️ ไม่พบ discount_day หรือ discount_month ใน datasumdiscount:", datasumdiscount);
          }

          // ✅ วงเล็บให้ถูกต้องเพื่อไม่ให้ logic ผิด
          const items = data.filter(item =>
            (item?.ML_Note === 'item' || item?.ML_Note === 'itemmonth') &&
            item.pro_goods_id !== 0
          );

          const gifts = data.filter(item =>
            (item?.ML_Note === 'zengsopng_day' || item?.ML_Note === 'zengsopng_month') &&
            item.pro_goods_id !== 0
          );

          const promotions = data.filter(item =>
            (item?.ML_Note === 'promotion_day' || item?.ML_Note === 'promotion_month') &&
            item.pro_activity_id !== 0
          );

          // ✅ ผูกสินค้า + promotion + gift ตาม activity_id
          this.selectedProducts = this.selectedProducts.map((product) => {
            const matchedItem = items.find(item =>
              item.pro_goods_id == product.pro_goods_id &&
              (item.ML_Note === "item" || item.ML_Note === "itemmonth") &&
              item.pro_activity_id == product.pro_activity_id &&
              item.pro_sku_price_id == product.pro_sku_price_id
            );

            if (!matchedItem) return product;

            const activityId = matchedItem.st === false ? 0 : matchedItem.pro_activity_id;

            const FinalPromotions = promotions.filter(promo => {
              const stMatch = promo.st === matchedItem.st;

              if (matchedItem.st === true) {
                return stMatch && promo.pro_activity_id === matchedItem.pro_activity_id;
              } else {
                return stMatch;
              }
            });

            const FinalGifts = gifts.filter(gift => {
              const stMatch = gift.st === matchedItem.st;

              if (matchedItem.st === true) {
                return stMatch && gift.pro_activity_id === matchedItem.pro_activity_id;
              } else {
                return stMatch;
              }
            });

            return {
              ...product,
              ...matchedItem,
              activity_id: activityId,
              pro_activity_id: matchedItem.pro_activity_id,
              pro_unit_price: matchedItem.pro_goods_price,
              pro_unit: product.pro_unit || product.pro_units,
              pro_units: product.pro_units || product.pro_unit,
              promotions: FinalPromotions,
              gifts: FinalGifts
            };
          });

          console.log("📋 รายการสินค้าในตาราง:", this.selectedProducts);

        } else {
          alert(response.data.message || 'เกิดข้อผิดพลาด');
        }
      } catch (error) {
        alert('เกิดข้อผิดพลาดในการเชื่อมต่อ API');
        console.error(error);
      }
    },

    onlyNumberInput(event) {
      const key = event.key;
      // อนุญาตเฉพาะตัวเลข 0-9 เท่านั้น
      if (!/^\d$/.test(key)) {
        event.preventDefault();
      }
    },

    async onQuantityBlur(product) {
      // ถ้าเป็นค่าว่าง ไม่ต้องเรียก submittedProduct ทันที รอให้ผู้ใช้กรอกก่อน
      if (product.pro_quantity === '' || product.pro_quantity === null) {
        product.pro_quantity = 1;
        product.pro_goods_num = 1;
        // return;
        // รอสักเล็กน้อยก่อนเรียก (กันกรณีพิมพ์ยังไม่จบ)
        setTimeout(async () => {
          try {
            await this.submittedProduct();
          } catch (error) {
            console.error('Error submitting product after blur timeout:', error);
          }
        }, 400); // รอ 200ms
      } else {

        this.selectedProducts = this.selectedProducts.map(item => {
          if (
            item.pro_sku_price_id === product.pro_sku_price_id &&
            item.pro_activity_id === product.pro_activity_id
          ) {
            return {
              ...item,
              pro_goods_num: product.pro_quantity || 0,
              pro_quantity: product.pro_quantity || 0,
            };
          }
          return item; // คืนค่า item เดิมถ้าเงื่อนไขไม่ตรง
        });

        try {
          console.log('Nooooooooooooooooooooo');
          if (product.pro_quantity == '' || product.pro_quantity == null) {
            return; // ถ้าเป็นค่าว่าง ไม่ต้องเรียก submittedProduct ทันที รอให้ผู้ใช้กรอกก่อน
          } else {
            await this.submittedProduct();
          }
          // await this.submittedProduct();
        } catch (error) {
          console.error('Error submitting product on blur:', error);
        }
      }
      
    },

    async onQuantityChange(event, product) {
      let value = event.target.value;

      // อนุญาตให้ว่างได้ระหว่างพิมพ์
      if (value === '') {
        product.pro_quantity = '';
        // ยังไม่เรียก submittedProduct เพราะยังไม่ใช่ตัวเลขที่สมบูรณ์
        return;
      }
      console.log('Check value: ', value);
      // แปลงเป็นเลขจำนวนเต็ม
      value = Number(value);
      console.log('Check value: ', value);

      if (isNaN(value)) {

        // กรณีป้อนค่าไม่ใช่ตัวเลข เช่น '-' หรืออะไรที่ไม่ถูกต้อง
        product.pro_quantity = '';
        return;
      }

      // validate ขอบเขตจำนวน
      if (value < 1) {
        product.pro_quantity = 1;
      } else if (value > product.pro_stock) {
        console.log('Check pro_stock: ');
        product.pro_quantity = product.pro_quantity || product.pro_stock;
        product.pro_goods_num = product.pro_quantity
      } else {
        console.log('Check else pro_goods_num: ');
        product.pro_goods_num = value;
        product.pro_quantity = value;
      }

      console.log('Check product: ', product);
      console.log('Check product.pro_quantity: ', product.pro_quantity);

      console.log('Check product: ', product);


      try {
        console.log('Check product.pro_quantity: ', product.pro_quantity);
        console.log('Check product.pro_goods_num: ', product.pro_goods_num);
        console.log('Check this.selectedProducts: ', this.selectedProducts);


        // this.selectedProducts = this.selectedProducts.map(item => ({
        //     ...item,
        //     pro_goods_num: product.pro_goods_num || 0, // ใช้ค่าเดิมหรือ 0 หากไม่มี
        //     pro_quantity: product.pro_quantity || 0, // ใช้ pro_goods_num เป็นค่า pro_quantity
        // }));
        this.selectedProducts = this.selectedProducts.map(item => {
          if (
            item.pro_sku_price_id === product.pro_sku_price_id &&
            item.pro_activity_id === product.pro_activity_id
          ) {
            return {
              ...item,
              pro_goods_num: product.pro_quantity || 0, 
              // pro_goods_num: product.pro_goods_num || 0,
              pro_quantity: product.pro_quantity || 0,
            };
          }
          return item; // คืนค่า item เดิมถ้าเงื่อนไขไม่ตรง
        });
        // this.$forceUpdate();

        setTimeout(async () => {
          try {

            console.log('Check product.pro_quantity: ', product.pro_quantity);
            console.log('Check product.pro_goods_num: ', product.pro_goods_num);

            console.log('เรียก ฟังก์ชัน submittedProduct หลังจากเปลี่ยนแปลงจำนวนสินค้า');

            if (product.pro_quantity == '' || product.pro_quantity == null || product.pro_goods_num == '' || product.pro_goods_num == null) {

              console.log('Nooobbb');

              return; // ถ้าเป็นค่าว่าง ไม่ต้องเรียก submittedProduct ทันที รอให้ผู้ใช้กรอกก่อน
            } else if (product.pro_quantity != '' || product.pro_quantity != null || product.pro_goods_num != '' || product.pro_goods_num != null) {
              console.log('Yessssssssssssssssssss');
              await this.submittedProduct();
            }

          } catch (error) {
            console.error('Error submitting product after blur timeout:', error);
          }
        }, 400); // รอ 200ms

        // await this.submittedProduct();
      } catch (error) {
        console.error('Error submitting product:', error);
      }
    },

    //
    async addSelectedProductsWithmonth(payload) {
      console.log("📦 payload ที่ได้รับ ที่ได้รับจาก Promotion_ProductSelector:", payload);

      // this.selectedProducts = []; //

      const items = payload.items || [];
      // const gifts = payload.gifts || [];
      const giftsDay = payload.gifts || [];
      const promotions = payload.promotions || [];
      const emitTitles = payload.emitTitles || [];

      const datasumdiscount = payload.datasumdiscount || [];

      if (datasumdiscount.discount_month !== undefined || datasumdiscount.discount_day !== undefined) {
        const discountMonth = Math.abs(Number(datasumdiscount.discount_month) || 0);
        const discountDay = Math.abs(Number(datasumdiscount.discount_day) || 0);
        this.formData.totalDiscount = discountMonth + discountDay;
        console.log("🎯 รวมส่วนลดทั้งหมด:", this.formData.totalDiscount);
      } else {
        console.warn("⚠️ ไม่พบ discount_day หรือ discount_month ใน datasumdiscount:", datasumdiscount);
      }

      console.log("✅ payload:", payload);

      console.log("✅ Items:", items);
      console.log("✅ Gifts:", giftsDay);
      console.log("✅ Promotions:", promotions);
      console.log("✅ EmitTitles:", emitTitles);

      for (const item of items) {
        const activityId = item.st === false ? false : item.pro_activity_id;
        const matchedTitle =
          emitTitles.find((emit) => emit.pro_goods_id == item.pro_goods_id) || {};

        const filteredGifts = giftsDay.filter((gift) =>
          gift.pro_activity_id !== item.pro_activity_id
            ? item.pro_activity_id
            : gift.pro_activity_id
        );
        const filteredPromotions = promotions.filter((promo) =>
          promo.pro_activity_id !== item.pro_activity_id
            ? item.pro_activity_id
            : promo.pro_activity_id
        );

        const fullActivityGifts = giftsDay.filter(
          (gift) => gift.pro_activity_id === item.pro_activity_id && gift.st === item.st
        );
        const fullActivityPromotions = promotions.filter(
          (promo) => promo.pro_activity_id === item.pro_activity_id && promo.st === item.st
        );

        // const FinalGifts = filteredGifts.filter(
        //     // gift => gift.pro_activity_id === item.pro_activity_id
        //     gift => gift.pro_activity_id === item.pro_activity_id && gift.st === item.st
        //     // gift => gift.pro_activity_id === promotionActivityId && gift.pro_sku_price_id == item.pro_sku_price_id
        // );

        const FinalPromotions = promotions.filter((promo) => {
          const stMatch = promo.st === item.st;

          if (item.st === true) {
            return stMatch && promo.pro_activity_id === item.pro_activity_id;
          } else {
            return stMatch;
          }
        });

        const FinalGifts = giftsDay.filter((gift) => {
          const stMatch = gift.st === item.st;

          if (item.st === true) {
            return stMatch && gift.pro_activity_id === item.pro_activity_id;
          } else {
            return stMatch;
          }
        });

        const FinalGifts_Not_activuty = fullActivityGifts.filter(
          // gift => gift.pro_activity_id === item.pro_activity_id
          (gift) =>
            gift.pro_activity_id === item.pro_activity_id && Boolean(gift.st) === Boolean(item.st)
          // gift => gift.pro_activity_id === promotionActivityId && gift.pro_sku_price_id == item.pro_sku_price_id
        );

        const FinalPromotions_Not_activuty = fullActivityPromotions.filter(
          // promo => promo.pro_activity_id === item.pro_activity_id
          (promo) => promo.pro_activity_id === item.pro_activity_id || promo.st !== item.st
        );

        // ✅ แปลงให้เรียบร้อยก่อน
        item.pro_id = parseInt(item.pro_id) || 0;
        item.pro_sku_price_id = parseInt(item.pro_sku_price_id) || 0;
        item.st = Boolean(item.st);

        console.log("sss Chack item.st: ", item.st);

        const similarItem = this.selectedProducts.find(
          (sp) =>
            sp.pro_sn === (matchedTitle.pro_sn || item.pro_sn) && sp.activity_id !== activityId
        );

        const activity_id_ItemIsok = this.selectedProducts.find(
          (sp) =>
            sp.pro_sn === (matchedTitle.pro_sn || item.pro_sn) &&
            sp.activity_id !== activityId &&
            sp.st === item.st
        );

        const activity_id_ItemIs_Not_ok = this.selectedProducts.find(
          (sp) =>
            sp.pro_sn === (matchedTitle.pro_sn || item.pro_sn) &&
            sp.activity_id !== activityId &&
            Boolean(sp.st) !== Boolean(item.st)
        );

        //หา item ที่ activity_id เดียวกันและ st เหมือนกัน
        const alreadyExists = this.selectedProducts.find(
          (sp) =>
            sp.pro_id === item.pro_sku_price_id &&
            sp.activity_id === activityId &&
            // sp.st === item.st
            Boolean(sp.st) === Boolean(item.st)
        );

        console.log("✅ this.selectedProducts:", this.selectedProducts);
        console.log("✅ this.selectedProducts.length === 0:", this.selectedProducts.length === 0);
        console.log("✅ alreadyExists:", alreadyExists);
        console.log("✅ activity_id_ItemIs_Not_ok:", activity_id_ItemIs_Not_ok);
        console.log("✅ activity_id_ItemIsok:", activity_id_ItemIsok);

        const caseType = (() => {
          if (this.selectedProducts.length === 0) return "EMPTY";
          if (activity_id_ItemIs_Not_ok) return "ACTIVITY_ID_ITEM_IS_Not_OK";
          if (activity_id_ItemIsok) return "ACTIVITY_ID_ITEM_ISOK";
          if (similarItem) return "SIMILAR_SN_DIFFERENT_ACTIVITY";
          if (alreadyExists) return "EXISTS";
          return "NEW";
          // if (this.selectedProducts.length === 0) return "EMPTY";
          // if (activity_id_ItemIs_Not_ok) return "ACTIVITY_ID_ITEM_IS_Not_OK";
          // if (activity_id_ItemIsok) return "ACTIVITY_ID_ITEM_ISOK";
          // // if (similarItem || alreadyExists) return 'ACTIVITY_NOT_LOOP';
          // if (alreadyExists) return "EXISTS";
          // // if (similarItem) return "SIMILAR_SN_DIFFERENT_ACTIVITY";

          // return "NEW";
        })();

        switch (caseType) {
          case "EMPTY":
          case "NEW":
            this.selectedProducts.push({
              item_id: 0,
              pro_id: item.pro_sku_price_id,
              activity_id: activityId,
              pro_activity_id: item.pro_activity_id,
              pro_goods_id: item.pro_goods_id,
              // pro_activity_id: item.pro_activity_id,
              st: item.st,
              pro_erp_title:
                matchedTitle.pro_erp_title === 0
                  ? matchedTitle.pro_title
                  : matchedTitle.pro_erp_title || item.pro_erp_title || "",
              pro_title: matchedTitle.pro_title,
              // pro_erp_title: matchedTitle.pro_erp_title && matchedTitle.pro_erp_title === 0 || item.pro_erp_title || '',
              pro_unit_price: item.pro_goods_price || "",
              // pro_goods_sku_text: item.pro_goods_sku_text || "",
              pro_goods_sku_text: item.color || item.pro_goods_sku_text || '',
              pro_sn: matchedTitle.pro_sn || item.pro_sn || "",
              pro_images: item.pro_image || "",
              pro_quantity: item.pro_goods_num || 0,
              pro_units: matchedTitle.pro_units || item.pro_units || "",
              pro_stock: matchedTitle.stock || item.stock || 0,
              // pro_stock: matchedTitle.stock || 0,

              pro_sku_price_id: item.pro_sku_price_id,

              // gifts: giftsDay != item.pro_activity_id ? promotionActivityId : giftsDay,
              // promotions: promotions != item.pro_activity_id ? promotionActivityId : promotions,

              // กรองเฉพาะของที่ activity_id ตรงกัน
              gifts: FinalGifts,
              promotions: FinalPromotions,

              // gifts: giftsDay.filter(gift => gift.pro_activity_id === item.pro_activity_id),
              // promotions: promotions.filter(promo => promo.pro_activity_id === item.pro_activity_id)
            });
            console.log("NEW || EMPTY");
            break;

          case "SIMILAR_SN_DIFFERENT_ACTIVITY":
            // 1) เปลี่ยน activity_id ของรายการเดิมให้ตรงกับตัวใหม่
            Object.assign(similarItem, {
              activity_id: activityId,
              st: item.st,
              pro_goods_num: item.pro_goods_num,
              pro_quantity: item.pro_goods_num,
              pro_goods_sku_text: item.color || item.pro_goods_sku_text || '',
              // 2) อัปเดต promotions/gifts
              promotions: FinalPromotions,
              gifts: FinalGifts,
              // … field อื่นๆ ตามที่ต้องการ
            });
            console.log("SIMILAR_SN_DIFFERENT_ACTIVITY: ย้ายไป activity ใหม่ พร้อมโหลด promotions");
            Swal.fire({
              icon: "info",
              title: "อัปเดตโปรโมชั่นสำเร็จ",
              text: `ปรับข้อมูล ${matchedTitle.pro_erp_title || item.pro_title} เป็น st=${item.st}`,
              showConfirmButton: false,
              timer: 1500,
            });
            break;

          case "EXISTS":
            Object.assign(alreadyExists, {
              ...item,
              pro_id: item.pro_sku_price_id,
              activity_id: activityId,
              pro_quantity: item.pro_goods_num,
              pro_goods_num: item.pro_goods_num,
              pro_goods_sku_text: item.color || item.pro_goods_sku_text || '',
              gifts: FinalGifts,
              promotions: FinalPromotions,

              // เพิ่มค่าอื่น ๆ ที่จำเป็น
            });

            console.log("EXISTS");

            Swal.fire({
              icon: "info",
              title: "เพิ่มจำนวนข้อมูลสินค้าสำเร็จ",
              text: `เพิ่มข้อมูลสินค้าเรียบร้อย ${matchedTitle.pro_erp_title || item.pro_title || ""
                }`,
              showConfirmButton: false,
              timer: 2000, // ปิดอัตโนมัติใน 2 วินาที (2000 มิลลิวินาที)
              timerProgressBar: true,
            });
            break;
          case "ACTIVITY_ID_ITEM_ISOK":
            Object.assign(activity_id_ItemIsok, {
              ...item,
              pro_id: item.pro_sku_price_id,
              activity_id: activityId,
              pro_quantity: item.pro_goods_num,
              pro_goods_num: item.pro_goods_num,
              pro_goods_sku_text: item.color || item.pro_goods_sku_text || '',
              gifts: FinalGifts, //fullActivityGifts ||
              promotions: FinalPromotions, //
              // เพิ่มค่าอื่น ๆ ที่จำเป็น
            });

            console.log("ACTIVITY_ID_ITEM_ISOK");

            Swal.fire({
              icon: "info",
              title: "แทนที่ข้อมูลเดิม",
              text: `แทนที่ข้อมูลสินค้า ${matchedTitle.pro_title || item.pro_erp_title || ""}`,
            });
            break;
          case "ACTIVITY_ID_ITEM_IS_Not_OK":
            Object.assign(activity_id_ItemIs_Not_ok, {
              ...item,
              pro_id: item.pro_sku_price_id,
              activity_id: activityId,
              pro_quantity: item.pro_goods_num,
              pro_goods_num: item.pro_goods_num,
              pro_goods_sku_text: item.color || item.pro_goods_sku_text || '',
              gifts: FinalGifts_Not_activuty,
              promotions: FinalPromotions_Not_activuty,
              // เพิ่มค่าอื่น ๆ ที่จำเป็น
            });

            console.log("ACTIVITY_ID_ITEM_IS_Not_OK");

            Swal.fire({
              icon: "info",
              title: "แทนที่ข้อมูลเดิม",
              text: `แทนที่ข้อมูลสินค้า ${matchedTitle.pro_title || item.pro_erp_title || ""}`,
            });
            break;
        }
        // });
      }

      console.log("📋 รายการสินค้าในตาราง:", this.selectedProducts);
    },

    validateQuantity(product) {
      if (product.pro_quantity > product.pro_stock) {
        product.pro_quantity = product.pro_stock;
      } else if (product.pro_quantity < 1) {
        product.pro_quantity = 1;
      }
    },

    handleBackToPromotion() {
      this.showPromotionProductSelector = false;

      // 🔁 ใช้ delay เล็กน้อยเพื่อให้ UI สลับได้ลื่นขึ้น
      setTimeout(() => {
        this.showPromotionSelector = true;
      }, 100);
    },

    // //handleSelectedProducts
    async handleSelectedPromotionProducts(payload) {
      console.log("📦 payload ที่ได้รับ ที่ได้รับจาก Promotion_ProductSelector:", payload);

      this.selectedProducts = []; 

      const items = payload.items || [];
      // const gifts = payload.gifts || [];
      const giftsDay = payload.gifts || [];
      const promotions = payload.promotions || [];
      const emitTitles = payload.emitTitles || [];

      const datasumdiscount = payload.datasumdiscount || [];

      if (datasumdiscount.discount_month !== undefined || datasumdiscount.discount_day !== undefined) {
        const discountMonth = Math.abs(Number(datasumdiscount.discount_month) || 0);
        const discountDay = Math.abs(Number(datasumdiscount.discount_day) || 0);
        this.formData.totalDiscount = discountMonth + discountDay;
        console.log("🎯 รวมส่วนลดทั้งหมด:", this.formData.totalDiscount);
      } else {
        console.warn("⚠️ ไม่พบ discount_day หรือ discount_month ใน datasumdiscount:", datasumdiscount);
      }

      console.log("✅ payload:", payload);

      console.log("✅ Items:", items);
      console.log("✅ Gifts:", giftsDay);
      console.log("✅ Promotions:", promotions);
      console.log("✅ EmitTitles:", emitTitles);

      for (const item of items) {
        const activityId = item.st === false ? false : item.pro_activity_id; // true = 1508 And false = false
        const matchedTitle =
          emitTitles.find(
            (emit) =>
              emit.pro_goods_id == item.pro_goods_id &&
              emit.pro_sku_price_id == item.pro_sku_price_id
          ) || {};

        const filteredGifts = giftsDay.filter((gift) =>
          gift.pro_activity_id !== item.pro_activity_id
            ? item.pro_activity_id
            : gift.pro_activity_id
        );
        const filteredPromotions = promotions.filter((promo) =>
          promo.pro_activity_id !== item.pro_activity_id
            ? item.pro_activity_id
            : promo.pro_activity_id
        );

        const fullActivityGifts = giftsDay.filter(
          (gift) => gift.pro_activity_id === item.pro_activity_id && gift.st === item.st
        );
        const fullActivityPromotions = promotions.filter(
          (promo) => promo.pro_activity_id === item.pro_activity_id && promo.st === item.st
        );

        const FinalPromotions = promotions.filter((promo) => {
          const stMatch = promo.st === item.st;

          if (item.st === true) {
            return stMatch && promo.pro_activity_id === item.pro_activity_id;
          } else {
            return stMatch;
          }
        });

        const FinalGifts = giftsDay.filter((gift) => {
          const stMatch = gift.st === item.st;

          if (item.st === true) {
            return stMatch && gift.pro_activity_id === item.pro_activity_id;
          } else {
            return stMatch;
          }
        });

        const FinalGifts_Not_activuty = fullActivityGifts.filter(
          // gift => gift.pro_activity_id === item.pro_activity_id
          (gift) =>
            gift.pro_activity_id === item.pro_activity_id && Boolean(gift.st) === Boolean(item.st)
          // gift => gift.pro_activity_id === promotionActivityId && gift.pro_sku_price_id == item.pro_sku_price_id
        );

        const FinalPromotions_Not_activuty = fullActivityPromotions.filter(
          // promo => promo.pro_activity_id === item.pro_activity_id
          (promo) => promo.pro_activity_id === item.pro_activity_id || promo.st !== item.st
        );

        // ✅ แปลงให้เรียบร้อยก่อน
        item.pro_id = parseInt(item.pro_id) || 0;
        item.pro_sku_price_id = parseInt(item.pro_sku_price_id) || 0;

        // หา item ที่ pro_sn เดียวกันแต่ activity ต่างกัน
        const similarItem = this.selectedProducts.find(
          (sp) =>
            sp.pro_sn === (matchedTitle.pro_sn || item.pro_sn) && sp.activity_id !== activityId
        );

        const activity_id_ItemIsok = this.selectedProducts.find(
          (sp) =>
            sp.pro_sn === (matchedTitle.pro_sn || item.pro_sn) &&
            sp.activity_id !== activityId &&
            sp.st === item.st
        );

        const activity_id_ItemIs_Not_ok = this.selectedProducts.find(
          (sp) =>
            sp.pro_sn === (matchedTitle.pro_sn || item.pro_sn) &&
            sp.activity_id !== activityId &&
            sp.st !== item.st
        );

        // const matchedByActivityAndGoods = this.selectedProducts.find(
        //   (sp) =>
        //     parseInt(sp.pro_activity_id) === parseInt(item.pro_activity_id) &&
        //     parseInt(sp.pro_goods_id) === parseInt(item.pro_goods_id) &&
        //     Boolean(sp.st) === Boolean(item.st)
        // );

        const matchedByActivityAndGoods = this.selectedProducts.find((sp) => {
          const isMatch =
            parseInt(sp.pro_goods_id) === parseInt(item.pro_goods_id) &&
            parseInt(sp.pro_activity_id) === parseInt(item.pro_activity_id);
          // Boolean(sp.st) === Boolean(item.st);

          console.log("Check Match:", {
            old_goods_id: sp.pro_goods_id,
            new_goods_id: item.pro_goods_id,
            old_activity_id: sp.pro_activity_id,
            new_activity_id: item.pro_activity_id,
            // old_st: sp.st,
            new_st: item.st,
            result: isMatch,
          });

          return isMatch;
        });

        //หา item ที่ activity_id เดียวกันและ st เหมือนกัน
        // const alreadyExists = this.selectedProducts.find(
        //   (sp) =>
        //     sp.pro_id === item.pro_sku_price_id && // pro_id = 3640 And pro_sku_price_id = "3640"
        //     sp.activity_id === activityId && // activity_id = 1508 And activityId = 1508 || false
        //     // sp.st === item.st
        //     sp.st === item.st // false = false And true = true
        // );

        const alreadyExists = this.selectedProducts.find(
          (sp) =>
            parseInt(sp.pro_goods_id) === parseInt(item.pro_goods_id) &&
            parseInt(sp.pro_activity_id) === parseInt(item.pro_activity_id) &&
            Boolean(sp.st) === Boolean(item.st)
        );

        //หา item ที่ activity_id เดียวกันและ st เหมือนกัน
        const alreadyExists_not_st = this.selectedProducts.find(
          (sp) =>
            sp.pro_id === item.pro_sku_price_id && // pro_id = 3640 And pro_sku_price_id = "3640"
            sp.activity_id === activityId // activity_id = 1508 And activityId = 1508 || false
        );

        console.log("✅ this.selectedProducts:", this.selectedProducts);
        console.log("✅ this.selectedProducts.length === 0:", this.selectedProducts.length === 0);
        // console.log("✅ alreadyExists:", alreadyExists);
        console.log("✅ activity_id_ItemIs_Not_ok:", activity_id_ItemIs_Not_ok);
        console.log("✅ activity_id_ItemIsok:", activity_id_ItemIsok);

        const caseType = (() => {
          if (this.selectedProducts.length === 0) return "EMPTY";
          if (activity_id_ItemIs_Not_ok) return "ACTIVITY_ID_ITEM_IS_Not_OK";
          if (activity_id_ItemIsok) return "ACTIVITY_ID_ITEM_ISOK";
          if (similarItem) return "SIMILAR_SN_DIFFERENT_ACTIVITY";
          if (alreadyExists) return "EXISTS";
          return "NEW";
          // if (this.selectedProducts.length === 0) return "EMPTY";
          // if (matchedByActivityAndGoods) return "UPDATE_SAME_ITEM";
          // // if (alreadyExists) return "EXISTS";
          // if (alreadyExists_not_st) return "EXISTSNOTST";
          // if (activity_id_ItemIs_Not_ok) return "ACTIVITY_ID_ITEM_IS_Not_OK";
          // if (activity_id_ItemIsok) return "ACTIVITY_ID_ITEM_ISOK";
          // if (similarItem || alreadyExists) return 'ACTIVITY_NOT_LOOP';
          // if (similarItem) return "SIMILAR_SN_DIFFERENT_ACTIVITY";

          return "NEW";
        })();

        // console.log("🤐 Check caseType this.selectedProducts: ", this.selectedProducts);

        switch (caseType) {
          case "EMPTY":
          case "NEW":
            // this.selectedProducts = [];
            this.selectedProducts.push({
              item_id: 0,
              pro_id: item.pro_sku_price_id,
              activity_id: activityId,
              pro_activity_id: item.pro_activity_id,
              pro_goods_id: item.pro_goods_id,
              // pro_activity_id: item.pro_activity_id,
              st: item.st,
              pro_erp_title:
                matchedTitle.pro_erp_title === 0
                  ? matchedTitle.pro_title
                  : matchedTitle.pro_erp_title || item.pro_erp_title || "",
              pro_title: matchedTitle.pro_title,
              // pro_erp_title: matchedTitle.pro_erp_title && matchedTitle.pro_erp_title === 0 || item.pro_erp_title || '',
              pro_unit_price: item.pro_goods_price || "",
              // pro_goods_sku_text: item.pro_goods_sku_text || "",
              pro_goods_sku_text: item.color || item.pro_goods_sku_text || '',
              pro_sn: matchedTitle.pro_sn || item.pro_sn || "",
              prosn: item.prosn || "",
              pro_images: item.pro_image || "",
              pro_quantity: item.pro_goods_num || 0,
              pro_goods_num: item.pro_goods_num || 0,
              pro_units: matchedTitle.pro_units || item.pro_units || "",
              // pro_stock: matchedTitle.stock || 0,
              pro_stock: matchedTitle.stock || item.stock || 0,

              pro_sku_price_id: item.pro_sku_price_id,

              // gifts: giftsDay != item.pro_activity_id ? promotionActivityId : giftsDay,
              // promotions: promotions != item.pro_activity_id ? promotionActivityId : promotions,

              // กรองเฉพาะของที่ activity_id ตรงกัน
              gifts: FinalGifts,
              promotions: FinalPromotions,

              // gifts: giftsDay.filter(gift => gift.pro_activity_id === item.pro_activity_id),
              // promotions: promotions.filter(promo => promo.pro_activity_id === item.pro_activity_id)
            });
            console.log("NEW || EMPTY");
            break;

          case "SIMILAR_SN_DIFFERENT_ACTIVITY":
            // 1) เปลี่ยน activity_id ของรายการเดิมให้ตรงกับตัวใหม่
            Object.assign(similarItem, {
              activity_id: activityId,
              st: item.st,
              pro_goods_num: item.pro_goods_num,
              pro_quantity: item.pro_goods_num,
              pro_goods_sku_text: item.color || item.pro_goods_sku_text || '',
              // 2) อัปเดต promotions/gifts
              promotions: FinalPromotions,
              gifts: FinalGifts,
              // … field อื่นๆ ตามที่ต้องการ
            });
            console.log("SIMILAR_SN_DIFFERENT_ACTIVITY: ย้ายไป activity ใหม่ พร้อมโหลด promotions");
            Swal.fire({
              icon: "info",
              title: "อัปเดตโปรโมชั่นสำเร็จ",
              text: `ปรับข้อมูล ${matchedTitle.pro_erp_title || item.pro_title} เป็น st=${item.st}`,
              showConfirmButton: false,
              timer: 1500,
            });
            break;

          case "UPDATE_SAME_ITEM":
            Object.assign(matchedByActivityAndGoods, {
              ...item,
              pro_id: item.pro_sku_price_id,
              activity_id: activityId,
              pro_quantity: item.pro_goods_num,
              pro_goods_num: item.pro_goods_num,
              pro_goods_sku_text: item.color || item.pro_goods_sku_text || '',
              gifts: FinalGifts,
              promotions: FinalPromotions,
            });

            console.log("UPDATE_SAME_ITEM");

            Swal.fire({
              icon: "info",
              title: "อัปเดตรายการสำเร็จ",
              text: `อัปเดตข้อมูลสินค้า ${matchedTitle.pro_title || item.pro_erp_title || ""}`,
            });
            break;

          case "EXISTS":
            Object.assign(alreadyExists, {
              ...item,
              pro_id: item.pro_sku_price_id,
              activity_id: activityId,
              pro_quantity: item.pro_goods_num,
              pro_goods_num: item.pro_goods_num,
              pro_goods_sku_text: item.color || item.pro_goods_sku_text || '',
              gifts: FinalGifts,
              promotions: FinalPromotions,

              // เพิ่มค่าอื่น ๆ ที่จำเป็น
            });

            console.log("EXISTS");

            Swal.fire({
              icon: "info",
              title: "เพิ่มจำนวนข้อมูลสินค้าสำเร็จ",
              text: `เพิ่มข้อมูลสินค้าเรียบร้อย ${matchedTitle.pro_erp_title || item.pro_title || ""
                }`,
              showConfirmButton: false,
              timer: 2000, // ปิดอัตโนมัติใน 2 วินาที (2000 มิลลิวินาที)
              timerProgressBar: true,
            });
            break;

          case "alreadyExists_not_st":
            Object.assign(alreadyExists_not_st, {
              ...item,
              pro_id: item.pro_sku_price_id,
              activity_id: activityId,
              pro_quantity: item.pro_goods_num,
              pro_goods_num: item.pro_goods_num,
              pro_goods_sku_text: item.color || item.pro_goods_sku_text || '',
              gifts: FinalGifts,
              promotions: FinalPromotions,

              // เพิ่มค่าอื่น ๆ ที่จำเป็น
            });

            console.log("alreadyExists_not_st");

            Swal.fire({
              icon: "info",
              title: "เพิ่มจำนวนข้อมูลสินค้าสำเร็จ",
              text: `เพิ่มข้อมูลสินค้าเรียบร้อย ${matchedTitle.pro_erp_title || item.pro_title || ""
                }`,
              showConfirmButton: false,
              timer: 2000, // ปิดอัตโนมัติใน 2 วินาที (2000 มิลลิวินาที)
              timerProgressBar: true,
            });
            break;

          case "ACTIVITY_ID_ITEM_ISOK":
            Object.assign(activity_id_ItemIsok, {
              ...item,
              pro_id: item.pro_sku_price_id,
              activity_id: activityId,
              pro_quantity: item.pro_goods_num,
              pro_goods_num: item.pro_goods_num,
              pro_goods_sku_text: item.color || item.pro_goods_sku_text || '',
              gifts: FinalGifts, //fullActivityGifts ||
              promotions: FinalPromotions, //
              // เพิ่มค่าอื่น ๆ ที่จำเป็น
            });

            console.log("ACTIVITY_ID_ITEM_ISOK");

            Swal.fire({
              icon: "info",
              title: "แทนที่ข้อมูลเดิม",
              text: `แทนที่ข้อมูลสินค้า ${matchedTitle.pro_title || item.pro_erp_title || ""}`,
            });

            break;
          case "ACTIVITY_ID_ITEM_IS_Not_OK":
            Object.assign(activity_id_ItemIs_Not_ok, {
              ...item,
              pro_id: item.pro_sku_price_id,
              activity_id: activityId,
              pro_quantity: item.pro_goods_num,
              pro_goods_num: item.pro_goods_num,
              pro_goods_sku_text: item.color || item.pro_goods_sku_text || '',
              gifts: FinalGifts_Not_activuty,
              promotions: FinalPromotions_Not_activuty,
              // เพิ่มค่าอื่น ๆ ที่จำเป็น
            });

            console.log("ACTIVITY_ID_ITEM_IS_Not_OK");

            Swal.fire({
              icon: "info",
              title: "แทนที่ข้อมูลเดิม",
              text: `แทนที่ข้อมูลสินค้า ${matchedTitle.pro_title || item.pro_erp_title || ""}`,
            });
            break;
        }
      }

      console.log("📋 รายการสินค้าในตาราง:", this.selectedProducts);
    },

    async confirmFinalSave() {
      const result = await Swal.fire({
        title: "คุณแน่ใจหรือไม่?",
        text: "หลังจากยืนยัน จะไม่สามารถแก้ไขข้อมูลนี้ได้อีก",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "ยืนยัน",
        cancelButtonText: "ยกเลิก",
      });

      if (!result.isConfirmed) return;
      // if (result.isConfirmed) {
      const docNo = this.formData.documentNo;

      try {
        const lockResponse = await axios.post(
          `${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/document_running/lock_document.php`,
          // `${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/lock_document.php`,
          { documentNo: docNo }
        );

        const resData = lockResponse.data;

        console.log("🔒 Response จาก API lock_document:", resData);

        if (!lockResponse.data.success) {
          Swal.fire("ผิดพลาด", lockResponse.data.message, "error");
          return;
        }

        if (resData.success) {
          this.isReadOnly = true;
          this.isConfirmed = true;

          // กันย้อนแก้ในเครื่องนี้ (optional)
          const locked = JSON.parse(localStorage.getItem("lockedDocumentNos") || "[]");
          if (!locked.includes(docNo)) {
            locked.push(docNo);
            localStorage.setItem("lockedDocumentNos", JSON.stringify(locked));
          }

          Swal.fire("สำเร็จ!", "รายการถูกล็อกแล้ว", "success");
        } else {
          Swal.fire("ผิดพลาด", resData.message, "error");
        }
      } catch (err) {
        const message = err.response?.data?.message || err.message || "เกิดข้อผิดพลาด";
        Swal.fire("ผิดพลาด", message, "error");
      }
    },

    async validateForm() {
      this.formTouched = true; // ✅ เมื่อผู้ใช้กด "บันทึก" แล้วถือว่า touched
      this.errors = {}; // ล้างข้อผิดพลาดก่อนตรวจสอบใหม่
      let isValid = true;

      // ตรวจสอบฟิลด์ที่จำเป็น 'reference', 'channel', 'taxType',
      // const requiredFields = [
      //     'sellDate', 'fullName', 'customerCode', 'phone', 'address',
      //     'receiverName', 'receiverPhone', 'receiverEmail', 'receiverAddress',
      //     'deliveryDate', 'trackingNo', 'deliveryType'
      // ];
      const requiredFields = {
        sellDate: "วันที่ขาย",
        fullName: "ชื่อลูกค้า",
        customerCode: "รหัสลูกค้า",
        phone: "เบอร์โทร",
        // address: 'ที่อยู่',
        receiverName: "ชื่อผู้รับ",
        receiverPhone: "เบอร์ผู้รับ",
        // receiverEmail: 'อีเมลผู้รับ',
        receiverAddress: "ที่อยู่ผู้รับ",
        deliveryDate: "วันที่จัดส่ง",
        // trackingNo: 'เลขติดตาม',
        // deliveryType: 'ประเภทการจัดส่ง'
      };

      console.log("Log Value requiredFields: ", requiredFields);

      for (const [field, label] of Object.entries(requiredFields)) {
        const value = this.formData[field];
        if (!value || (typeof value === "string" && value.trim() === "")) {
          this.errors[field] = `กรุณากรอก${label}`;
          isValid = false;
          this.isLoading = false;
        }
        this.isLoading = false;
      }

      // ตรวจสอบรายการสินค้า
      if (this.selectedProducts.length === 0) {
        Swal.fire({
          text: "กรุณาเพิ่มสินค้าอย่างน้อย 1 รายการ",
          icon: "warning",
        });
        isValid = false;
      } else {
        for (const product of this.selectedProducts) {
          if (
            !product.pro_erp_title ||
            !product.pro_quantity ||
            product.pro_quantity <= 0 ||
            !product.pro_unit_price ||
            product.pro_unit_price <= 0
          ) {
            Swal.fire({
              text: "กรุณากรอกชื่อสินค้า, จำนวน, และมูลค่าต่อหน่วยให้ครบถ้วนและถูกต้องสำหรับทุกรายการสินค้า",
              icon: "warning",
            });
            isValid = false;
            this.isLoading = false;
            break;
          }
        }
      }

      return isValid;
    },

    async updateDocument() {
      console.log("Update existing document");

      const isValid = await this.validateForm();
      if (!isValid) {
        Swal.fire({
          icon: "error",
          title: "ไม่สามารถบันทึกได้",
          text: "กรุณากรอกข้อมูลให้ครบถ้วน",
        });
        return;
      }

      // 🔍 ตรวจสอบว่ามีการเปลี่ยนแปลงหรือไม่
      if (!this.isDataChanged()) {
        Swal.fire({
          icon: "info",
          title: "ไม่มีข้อมูลเปลี่ยนแปลง",
          text: "คุณยังไม่ได้แก้ไขข้อมูลใด ๆ",
        });
        return;
      }

      try {
        this.isLoading = true;

        this.formData.productList = this.selectedProducts.map((product) => {
          const total = this.totalprice(product);

          console.log("✅ check: product", product);

          return {
            item_id: product.item_id ?? 0, // ✅ ใส่ id เดิมถ้ามี
            pro_sku_price_id: product.pro_id, //46764
            // pro_id: product.pro_id,
            pro_erp_title: product.pro_erp_title, //
            pro_title: product.pro_title, //
            pro_quantity: product.pro_quantity, //3
            pro_goods_num: product.pro_quantity, // 3
            pro_unit_price: product.pro_unit_price, // "315.00"
            pro_goods_id: product.pro_goods_id,
            // pro_discount: this.formData.discount === 0 ? 0 : this.formData.discount,
            pro_total_price: total, // รวมราคาต่อสินค้า
            totalDiscount: this.formData.totalDiscount || 0, // รวมราคาต่อสินค้า
            pro_discount: this.formData.discount || 0, // รวมราคาต่อสินค้า
            pro_image: product.pro_images, //
            pro_goods_sku_text: product.pro_goods_sku_text || '',
            pro_sn: product.pro_sn, //
            prosn: product.prosn, //
            st: product.st,
            stock: product.pro_stock || product.stock,
            pro_units: product.pro_units, //
            activity_id: product.activity_id || product.pro_activity_id || 0, // เพิ่ม activity_id 0 ถ้าไม่มี
            pro_activity_id: product.pro_activity_id || 0, // เพิ่ม pro_activity_id ถ้ามี

          };
        });

        console.log("🔍sadsadsa log value this.productList:", this.formData.productList);

        this.formData.final_total_price = this.grandTotal;

        const { promotions, gifts } = this.extractPromotionsAndGifts();
        this.formData.promotions = promotions;
        this.formData.gifts = gifts;

        console.log("🔍sadsadsa log value promotions:", promotions);
        console.log("🔍sadsadsa log value gifts:", gifts);

        // **เพิ่มคำนวณภาษีและราคาก่อนส่ง**
        this.formData.price_before_tax = parseFloat(this.netAmountBeforeVat.toFixed(2));
        // this.formData.price_before_tax = parseFloat(this.totalAmountBeforeDiscount.toFixed(2));
        this.formData.tax_value = this.isVatIncluded ? parseFloat(this.vatAmount.toFixed(2)) : 0;
        // this.formData.tax_value = this.isVatIncluded ? parseFloat((this.totalAmountBeforeDiscount * 0.07).toFixed(2)) : 0;
        this.formData.price_with_tax = parseFloat(this.grandTotal.toFixed(2));
        // this.formData.price_with_tax = parseFloat(this.grandTotal);

        this.formData.final_total_price = parseFloat(this.grandTotal.toFixed(2));
        // this.formData.final_total_price = parseFloat(this.grandTotal);

        this.formData.vatVisible = this.isVathidden ? 1 : 0;

        const payload = new FormData();

        for (const key in this.formData) {
          if (key === "productList" || key === "promotions" || key === "gifts") {
            payload.append(key, JSON.stringify([...this.formData[key]]));
          } else {
            payload.append(key, this.formData[key]);
          }
        }

        // if (!this.formData.receiverName) {
        //   Swal.fire({
        //     icon: "warning",
        //     title: "กรุณาเลือกที่อยู่จัดส่ง",
        //   });
        //   return;
        // }

        const hasSelectedAddress = this.selectedAddress && Object.keys(this.selectedAddress).length > 0;
        const hasSelectedAddressBase = this.selectedAddressBase && Object.keys(this.selectedAddressBase).length > 0;
        const hasReceiverAddress = String(this.formData.receiverAddress || '').trim() !== '';

        if (!hasSelectedAddress && !hasSelectedAddressBase && !hasReceiverAddress) {
          console.log('ข้อมูลบางรายการไม่ครบ กรุณาเลือกที่อยู่จัดส่ง');
          Swal.fire({
            icon: 'warning',
            title: 'กรุณาเลือกที่อยู่จัดส่ง',
          });
          return;
        }

        // ✅ เพิ่ม selectedAddress เข้าไป
        payload.append(
          "deliveryAddress",
          JSON.stringify(this.selectedAddress || this.selectedAddressBase)
        );

        // console.log("🤯 Log Value payload: ", payload);

        // ✅ log payload ทั้งหมดแบบอ่านได้
        // console.log("📦🤯 Log payload entries:");
        // for (const [key, value] of payload.entries()) {
        //     console.log(`${key}:`, value);
        // }

        console.log("🛒 productList:", this.formData.productList);
        console.log("📦 gifts:", this.formData.gifts);
        console.log("🛒 payload:", payload);
        console.log(JSON.stringify(payload));

        // return;

        const response = await axios.post(
          // `https://backend2.d-power.online:56916/api_admin_dashboard/backend/api/sale_order/update_sale_order.php`,
          `${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/sale_order/update_sale_order.php`,
          // `${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/update_sale_order.php`,
          payload
        );

        const resData =
          typeof response.data === "string" ? JSON.parse(response.data) : response.data;

        console.log("🔍 Response จาก API:", resData);

        if (resData.success) {
          const order = resData.data.order;
            const productList = resData.data.productList;
            const promotions = resData.data.promotions;
            const gifts = resData.data.gifts;
            const deliveryAddress = resData.data.deliveryAddress;

            console.log("📄 order data:", order);
            console.log("🛒 productList:", productList);
            console.log("🎁 promotions:", promotions);
            console.log("🎁 gifts:", gifts);
            console.log("🏠 deliveryAddress:", deliveryAddress);

            // เติมข้อมูลลง formData
            const formdataapi = {
                ...this.formData,
                listCode: order.list_code || '',
                sellDate: order.sell_date || '',
                reference: order.reference || '',
                channel: order.channel || '',
                taxType: order.tax_type || '',
                fullName: order.full_name || '',
                customerCode: order.customer_code || '',
                phone: order.phone || '',
                email: order.email || '',
                address: order.address || '',
                receiverName: order.receiver_name || '',
                receiverPhone: order.receiver_phone || '',
                receiverEmail: order.receiver_email || '',
                receiverAddress: order.receiver_address || '',
                note: order.note || '',
                deliveryDate: order.delivery_date || '',
                trackingNo: order.tracking_no || '',
                deliveryType: order.delivery_type || '',
                totalDiscount: order.total_discount || 0,
                deliveryFee: order.delivery_fee || 0,
                final_total_price: order.final_total_price || 0,
                documentNo: order.document_no || '',
                vatVisible: order.vat_visible || 'ไม่มีค่าDCM',
                promotions: promotions || [],
                gifts: gifts || []
            };

            this.isVathidden = !!Number(order.vat_visible);
            this.originalIsVathidden = this.isVathidden;

            // map products
              const productListap = productList.map(product => {
                console.log("🛠️ map product:", product); // 🔹 log แต่ละ product ก่อน map
                return {
                    item_id: product.id,
                    pro_id: product.pro_sku_price_id,
                    pro_sku_price_id: product.pro_sku_price_id,
                    pro_erp_title: product.pro_name || product.pro_title || '',
                    pro_title: product.pro_title || '',
                    pro_quantity: product.qty || product.pro_goods_num || 0,
                    pro_goods_num: product.qty || product.pro_goods_num || 0,
                    pro_goods_id: product.pro_goods_id || 0,
                    pro_unit_price: parseFloat(product.unit_price || 0),
                    pro_discount: parseFloat(product.discount || 0),
                    pro_total_price: parseFloat(product.total_price || 0),
                    pro_images: product.pro_images || '',
                    prosn: product.sn || product.pro_sn || '',
                    pro_sn: product.sn || product.pro_sn || '',
                    st: product.st || false,
                    pro_stock: product.stock || 0,
                    pro_unit: product.unit || '',
                    activity_id: product.activity_id || 0,
                    pro_activity_id: product.pro_activity_id || 0,
                    pro_goods_sku_text: product.pro_goods_sku_text || '',
                    promotions: product.promotions || [],
                    gifts: product.gifts || []
                };
            });

            console.log("📄 formdataapi final:", formdataapi);
            console.log("🛒 productListap final:", productListap);

                // ✅ เรียกส่งข้อมูลเข้า Macfive
                try {
                const macfiveRes = await sendToMacfive(
                    formdataapi,
                    productListap,
                    // promotions,
                    // gifts,
                    deliveryAddress
                );
                console.log("✅ ส่งเข้า Macfive สำเร็จ:", macfiveRes);

                if (macfiveRes.data?.Success) {
                    Swal.fire({
                    title: "ส่งเข้า Macfive สำเร็จ",
                    // text: `เลขที่เอกสาร: ${macfiveRes.VoucherNo || "-"}`,
                    icon: "success",
                    });
                } else {
                    Swal.fire({
                    title: "ไม่สามารถส่งเข้า Macfive ได้",
                    text: macfiveRes.data?.Message || "กรุณาลองใหม่",
                    icon: "error",
                    });
                }
                } catch (err) {
                    console.error("❌ Error ส่ง Macfive:", err);
                    Swal.fire({
                        title: "เกิดข้อผิดพลาด",
                        text: err.message || "ไม่สามารถเชื่อมต่อ Macfive ได้",
                        icon: "error",
                    });
                }
          
          const newDocumentNo = resData.newDocumentNo; // ดึง `documentNo` ใหม่จาก API
          this.formData.documentNo = newDocumentNo; // อัปเดต `documentNo` ใน `formData`

          // อัปเดต URL ไปยัง `saleList` พร้อม `documentNo` ใหม่
          // this.$router.push(`/saleList?documentNo=${newDocumentNo}`);

          // อัปเดต URL ไปยัง `saleList` พร้อม `documentNo` ใหม่ sale-order/:id sale-order/H1-SO25680726-00031
          this.$router.push(`/sale-order/${newDocumentNo}`);

          Swal.fire({ text: resData.message, icon: "success" });
          this.isReadOnly = true; // ปิดการแก้ไขหลังบันทึกสำเร็จ
        } else {
          Swal.fire({ text: resData.message, icon: "error" });
        }


        // if (resData.success) {


        //   const newDocumentNo = resData.newDocumentNo; // ดึง `documentNo` ใหม่จาก API
        //   this.formData.documentNo = newDocumentNo; // อัปเดต `documentNo` ใน `formData`

        //   // อัปเดต URL ไปยัง `saleList` พร้อม `documentNo` ใหม่
        //   // this.$router.push(`/saleList?documentNo=${newDocumentNo}`);

        //   // อัปเดต URL ไปยัง `saleList` พร้อม `documentNo` ใหม่ sale-order/:id sale-order/H1-SO25680726-00031
        //   this.$router.push(`/sale-order/${newDocumentNo}`);

        //   Swal.fire({ text: resData.message, icon: "success" });
        //   this.isReadOnly = true; // ปิดการแก้ไขหลังบันทึกสำเร็จ
        // } else {
        //   Swal.fire({ text: resData.message, icon: "error" });
        // }

        this.isLoading = false;

        // await this.AddressUpdaateData(this.selectedAddress);
      } catch (err) {
        const message = err.response?.data?.message || err.message || "Unknown error";
        Swal.fire({ text: message, icon: "error" });
        this.isLoading = false;
      }
    },



    // ฟังก์ชันเปรียบเทียบข้อมูล
    isDataChanged() {
      const isFormChanged = JSON.stringify(this.formData) !== JSON.stringify(this.originalFormData);
      const isProductChanged =
        JSON.stringify(this.selectedProducts) !== JSON.stringify(this.originalSelectedProducts);
      const isVatChanged = this.isVathidden !== this.originalIsVathidden;
      return isFormChanged || isProductChanged || isVatChanged;
    },



    extractPromotionsAndGifts() {
      const grouped = this.groupByActivityId(this.selectedProducts);
      const allPromotions = [];
      const allGifts = [];

      // วนแต่ละกลุ่มผลลัพธ์
      for (const groupObj of Object.values(grouped)) {
        // ถ้ามีกลุ่มสินค้า
        if (!Array.isArray(groupObj.items) || groupObj.items.length === 0) continue;

        // เอาสินค้าตัวแรกมาเป็นต้นแบบ promotions/gifts
        const firstItem = groupObj.items[0];

        // ถ้ามี promotions เป็น array
        if (Array.isArray(firstItem.promotions)) {
          for (const promo of firstItem.promotions) {
            allPromotions.push({
              title: promo.title,
              ML_Note: promo.ML_Note || '',
              note: promo.note || '',
              pro_activity_id: promo.pro_activity_id || 0,
              activity_id: promo.pro_activity_id || 0,
              pro_sn: promo.pro_sn,
              prosn: promo.prosn,
              pro_goods_id: promo.pro_goods_id || 0,
              pro_goods_num: promo.pro_goods_num || promo.pro_quantity || 0,
              pro_image: promo.pro_image || '',
              pro_sku_price_id: promo.pro_sku_price_id || 0,
              user_id: promo.user_id || 0,
              st: promo.st,
              stock: promo.stock,
            });
          }
        }

        // ถ้ามี gifts เป็น array
        if (Array.isArray(firstItem.gifts)) {
          for (const gift of firstItem.gifts) {
            allGifts.push({
              title: gift.title,
              pro_goods_num: gift.pro_goods_num || gift.pro_quantity || 0,
              pro_image: gift.pro_image || '',
              ML_Note: gift.ML_Note || '',
              note: gift.note || '',
              pro_activity_id: gift.pro_activity_id || 0,
              activity_id: gift.pro_activity_id || 0,
              // pro_goods_sku_text : gift.color || '',
              pro_goods_sku_text: gift.color || gift.pro_goods_sku_text || '',
              pro_sn: gift.pro_sn,
              prosn: gift.prosn,
              pro_goods_id: gift.pro_goods_id || 0,
              pro_sku_price_id: gift.pro_sku_price_id || 0,
              user_id: gift.user_id || 0,
              st: gift.st,
              stock: gift.stock,
            });
          }
        }
      }

      return {
        promotions: allPromotions,
        gifts: allGifts
      };
    },

    handleAddressSelected(data) {
      // async handleAddressSelected(data) {
      console.log("📍 ที่อยู่ที่เลือก:", data);
      const { DC_add1, DC_add2, DC_add3, DC_tel } = data;
      const fullAddress = `${DC_add1}, ${DC_add2}, ${DC_add3}, เบอร์โทร: ${DC_tel}`;
      this.selectedAddress = fullAddress;

      // ✅ เก็บ object เต็ม ๆ
      this.selectedAddress = {
        DC_id: data.DC_id, // สมมติว่า DC_id คือ id ที่อยู่
        DC_add1: data.DC_add1,
        // province_id: this.findProvinceId(data.DC_add3),
        // amphure_id: this.findAmphureId(data.DC_add2),
        // tambon_id: this.findTambonId(data.DC_add2),
        DC_add3: data.DC_add3,
        DC_add2: data.DC_add2,
        DC_tel: data.DC_tel,
        DC_zone: data.DC_zone || "",
      };

      // ✅ แสดงผลใน UI
      this.formData.receiverAddress = fullAddress;
      this.formData.address = fullAddress;
      this.formData.receiverPhone = DC_tel;
      console.log("📍 ที่อยู่ที่เลือก:", this.formData.receiverAddress);
      console.log("📍object ที่อยู่ที่เลือก:", this.selectedAddress);

      // 📌 ใส่ไว้ใน saveDocument()
      // await this.saveDocument(addressData);
    },

    handleAddressSelectedBase(data) {
      // async handleAddressSelected(data) {
      console.log("📍 ที่อยู่ที่เลือก:", data);
      const { DC_add1, DC_tel } = data; //DC_add2, DC_add3,
      const fullAddress = `${DC_add1},  เบอร์โทร: ${DC_tel}`; //${DC_add2}, ${DC_add3},
      this.selectedAddressBase = fullAddress;

      // ✅ เก็บ object เต็ม ๆ
      this.selectedAddressBase = {
        DC_id: data.DC_id, // สมมติว่า DC_id คือ id ที่อยู่
        DC_add1: data.DC_add1,
        // province_id: this.findProvinceId(data.DC_add3),
        // amphure_id: this.findAmphureId(data.DC_add2),
        // tambon_id: this.findTambonId(data.DC_add2),
        DC_add3: data.DC_add3,
        DC_add2: data.DC_add2,
        DC_tel: data.DC_tel,
        DC_zone: data.DC_zone || "",
      };

      // ✅ แสดงผลใน UI
      this.formData.receiverAddress = fullAddress;
      this.formData.address = fullAddress;
      this.formData.receiverPhone = DC_tel;
      console.log("📍 ที่อยู่ที่เลือกเดิม:", this.formData.receiverAddress);
      console.log("📍object ที่อยู่ที่เลือกเดิม:", this.selectedAddressBase);

      // 📌 ใส่ไว้ใน saveDocument()
      // await this.saveDocument(addressData);
    },

    removeProduct(index, activityId) {
      Swal.fire({
        title: "ยืนยันการลบ?",
        text: "คุณต้องการลบสินค้านี้ออกจากรายการใช่หรือไม่?",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "ใช่, ลบเลย!",
        cancelButtonText: "ยกเลิก",
      }).then((result) => {
        if (result.isConfirmed) {
          // 1. ดึงกลุ่ม product ที่ activityId เดียวกัน
          const groupObj = this.groupByActivityId(this.selectedProducts)[activityId];
          const productToRemove = groupObj?.items?.[index];
          // const productToRemove = group[index];

          if (!productToRemove) return;

          const { pro_goods_id, pro_activity_id, pro_sku_price_id, st } = productToRemove;

          // 2. ลบสินค้า, promotion, gift ที่มีค่าตรงกันทั้งหมด
          this.selectedProducts = this.selectedProducts.filter(
            (p) =>
              !(
                p.pro_goods_id == pro_goods_id &&
                p.pro_activity_id == pro_activity_id &&
                p.pro_sku_price_id == pro_sku_price_id &&
                p.st == st
              )
          );

          // p.pro_goods_id === pro_goods_id &&
          //     p.pro_activity_id === pro_activity_id &&
          //     p.pro_sku_price_id === pro_sku_price_id &&
          //     p.st === st

          // 3. อัปเดตข้อมูลของโปรโมชั่นและของแถมใหม่ทันที
          // this.submittedProduct(); // เรียกเพื่อ refresh ของแถม / โปร ทันที
          // 3. อัปเดตข้อมูลของโปรโมชั่นและของแถมใหม่ทันที
          if (this.selectedProducts && this.selectedProducts.length > 0) {
            this.submittedProduct();
          }

          Swal.fire("ลบแล้ว!", "สินค้าถูกลบออกจากรายการ.", "success");
        }
      });
    },

    removeAllProducts() {
      if (this.selectedProducts.length === 0) {
        Swal.fire({
          title: "ไม่มีสินค้า",
          text: "ยังไม่มีสินค้าที่เลือกไว้ในรายการ",
          icon: "info",
        });
        return;
      }

      Swal.fire({
        title: "ยืนยันการลบทั้งหมด?",
        text: "คุณต้องการลบสินค้าที่เลือกทั้งหมดออกจากรายการใช่หรือไม่?",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "ใช่, ลบทั้งหมด!",
        cancelButtonText: "ยกเลิก",
      }).then((result) => {
        if (result.isConfirmed) {
          this.selectedProducts.length = 0; // ล้างอาร์เรย์ทั้งหมด
          Swal.fire("ลบแล้ว!", "สินค้าทั้งหมดถูกลบออกจากรายการ.", "success");
        }
      });
    },

    removeProductById(pro_id, activity_id) {
      // this.selectedProducts = this.selectedProducts.filter(p => p.pro_id !== pro_id);
      this.selectedProducts = this.selectedProducts.filter(
        (p) => !(p.pro_id === pro_id && p.activity_id === activity_id)
      );
    },

    groupByActivityId(products) {
      return products.reduce((acc, item) => {
        // พยายามดึง pro_activity_id และ st จาก promotions
        const promoIdRaw = item.promotions?.[0]?.pro_activity_id ?? null;
        const promoStRaw = item.promotions?.[0]?.st;

        const promoId = Number(promoIdRaw);
        const promoSt = !!promoStRaw; // ✅ แปลงเป็น true/false ไม่ว่ามาจาก 1, 0, true, false

        let key, title;

        if (!isNaN(promoIdRaw)) {
          // ถ้ามี promotion ให้ใช้โปรโมชันนั้นเป็นตัวกำหนดกลุ่ม
          key = `promo-${promoId}-st${Number(promoSt)}`; // ให้ได้ st0 หรือ st1
          title = promoSt
            ? `🔥 โปรโมชั่นรายวัน ${promoId}`
            : `🎯 โปรโมชั่นรายเดือน ${promoId}`;
        } else {
          // ถ้าไม่มี promotion ให้ fallback ไปใช้ข้อมูลจาก item
          const pid = Number(item.pro_activity_id);
          const stRaw = item.st ?? item.process ?? false;
          const st = !!stRaw;

          if (pid === 0 && !st) {
            key = `monthly-st${Number(st)}`;
            title = '🎯 โปรโมชั่นรายเดือน';
          } else if (pid !== 0 && !st) {
            key = `invalid-activity`;
            title = '⚠️ โปรไม่เข้าเงื่อนไข';
          } else {
            key = `promo-${pid}-st${Number(st)}`;
            title = `🔥 โปรโมชั่นรายวัน ${pid}`;
          }
        }

        if (!acc[key]) {
          acc[key] = {
            title,
            items: [],
            promotions: [],
            gifts: []
          };
        }

        acc[key].items.push(item);
        if (item.promotions) acc[key].promotions.push(...item.promotions);
        if (item.gifts) acc[key].gifts.push(...item.gifts);

        return acc;
      }, {});
    },


    // groupByActivityId(products) {
    //   return products.reduce((acc, item) => {
    //     const key = `${item.activity_id || "no-activity"}-st${item.st ?? 0}`;
    //     if (!acc[key]) acc[key] = [];
    //     acc[key].push(item);
    //     return acc;
    //   }, {});
    // },

    totalprice(product) {

      const qty = product.pro_quantity || 0; // ใช้ pro_quantity แทน qty
      const price = product.pro_unit_price || 0;
      const discount = product.discount || 0;
      const totalprice = (qty * price - discount).toFixed(2);
      console.log("Log value:", totalprice);
      return totalprice;
    },

    toggleShowMoreData() {
      this.showMoreData = !this.showMoreData;
      console.log("😵‍💫😵‍💫 showMoreData:", this.showMoreData);
    },

    async updateOrderStatus(documentNo) {
      try {
        const response = await axios.post(
          `${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/document_running/update_status_order.php`,
          {
            documentNo: documentNo,
            status: "ตรวจสอบเรียบร้อย",
          },
          {
            headers: {
              "Content-Type": "application/json",
            },
          }
        );

        if (response.data?.success) {
          console.log("📦 อัปเดตสถานะสำเร็จ:", response.data.message);
        } else {
          console.warn("⚠️ อัปเดตสถานะไม่สำเร็จ:", response.data.message);
        }
      } catch (error) {
        console.error("❌ เกิดข้อผิดพลาดในการอัปเดตสถานะ:", error);
      }
    },

    async getAuthToken() {
      // localStorage.removeItem("token_address");
      const tokenData = JSON.parse(localStorage.getItem("token_address")) || null;

      // console.log("🔑 Check tokenData :", tokenData);

      const oneHour = 60 * 60 * 1000; // 1 ชั่วโมงในหน่วยมิลลิวินาที
      const now = Date.now();

      if (tokenData && tokenData.token && now - tokenData.timestamp < oneHour) {
        // console.log("🔑 ใช้ token เดิม:", tokenData.token);
        return tokenData.token; // ✅ ใช้ token เดิม
      }

      console.log("🔑 Token ไม่พบหรือหมดอายุ กำลังขอใหม่...");

      // 🛎️ แสดง loading เฉพาะตอนขอ token ใหม่
      Swal.fire({
        title: "กำลังดำเนินการ...",
        text: "กำลังเพิ่มข้อมูล (ครั้งแรกจะใช้เวลาสักครู่)",
        allowOutsideClick: false,
        didOpen: () => {
          Swal.showLoading();
        },
      });

      // 🔄 ถ้าไม่มี token หรือหมดอายุ ให้ขอใหม่
      const secretKeyData = qs.stringify({
        secretKey1: import.meta.env.VITE_SECRET_KEY1,
        secretKey2: import.meta.env.VITE_SECRET_KEY2,
      });

      try {
        const authResponse = await axios.post(`${BASE_URL_AUTH}`, secretKeyData, {
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
        });

        const token = authResponse.data.Token;
        if (!token) throw new Error("ไม่สามารถดึง token ได้");

        // 📝 บันทึก token และ timestamp ลง localStorage
        localStorage.setItem(
          "token_address",
          JSON.stringify({
            token,
            timestamp: now,
          })
        );

        Swal.close(); // ✅ ปิด Swal เมื่อเรียบร้อย
        return token;
      } catch (err) {
        Swal.fire({
          icon: "error",
          title: "ขอ Token ไม่สำเร็จ",
          text: "ไม่สามารถขอ token ได้ กรุณาลองใหม่อีกครั้ง",
        });
        console.error("❌ ดึง token ไม่สำเร็จ:", err);
        throw err;
      }
    },

    async saveDocument() {
      try {
        this.isLoading = true;

        console.log("Approve new document");

        try {
          const token = await this.getAuthToken();
          console.log("🔑 token", token);
          console.log("🎁 formData:", this.formData); // ,this.formData

          // 3. 📦 สร้าง payload ข้อมูล Macfive
          const payload = this.buildMacfivePayload();

          console.log("📦 Payload ที่จะส่งไปยัง Macfive:", payload);

          // return

          // 4. 🚀 ส่งไปยัง BASE_URL_MAC_FIVEL
          const macfiveResponse = await axios.post(`${BASE_URL_MAC_FIVEL}`, payload, {
            headers: {
              "Content-Type": "application/x-www-form-urlencoded",
              Authorization: `Bearer ${token}`,
            },
          });

          console.log("✅ Macfive ส่งสำเร็จ", macfiveResponse);

          if (macfiveResponse.data?.Success) {
            this.approvedVoucherNo = macfiveResponse.data?.VoucherNo || "";

            console.log("📦 รายการ DocumentNo :", this.approvedVoucherNo);

            // update สถานะใน Database
            await this.updateOrderStatus(this.approvedVoucherNo);

            Swal.fire({
              title: "อนุมัติรายการสั่งซื้อสำเร็จ",
              text: `อนุมัติเอกสารสำเร็จ: ${this.approvedVoucherNo}`,
              icon: "success",
            })
              .then(() => {
                // ✅ รีเฟรชหน้าเมื่อกด OK
                location.reload();
              });
            // location.reload();

          } else {
            Swal.fire({
              title: "ไม่สามารถอนุมัติรายการสั่งซื้อได้",
              text: "กรุณาลองใหม่อีกครั้ง",
              icon: "error",
            })

            // location.reload();
            const message = err.response?.data?.message || err.message || "เกิดข้อผิดพลาด";
            console.error("เกิดข้อผิดพลาด", message);
          }
        } catch (err) {
          const message = err.response?.data?.message || err.message || "เกิดข้อผิดพลาด";
          Swal.fire("ผิดพลาด", message, "error");
        }

        // Swal.fire({
        //   icon: 'success',
        //   title: 'อนุมัติเอกสารสำเร็จ',
        //   text: 'อนุมัติเอกสารเรียบร้อย',
        // });

        // // ✅ ดำเนินการบันทึกต่อ...
        // console.log("✅ อนุมัติเอกสารเรียบร้อย");

        this.isLoading = false;
      } catch (err) {
        const message = err.response?.data?.message || err.message || "Unknown error";
        Swal.fire({ text: message, icon: "error" });
        console.log("a454545654564 catch");
      }
    },

    buildMacfivePayload() {
      const now = new Date();
      const formatDate = (d) => d.toISOString().slice(0, 10);
      const formatDateTime = (d) => d.toISOString().slice(0, 19).replace("T", " ");

      const docNo = this.formData.documentNo;
      const sale_no = localStorage.getItem("account") || "";
      console.log("Check sale_no: ", sale_no);

      // const countProducts = this.selectedProducts.length;
      // const countGifts = this.formData.gifts.length;
      // const countPromotions = this.formData.promotions.length;

      // const totalItems = countProducts + countGifts + countPromotions;

      // console.log('🧾 จำนวนสินค้าหลัก:', countProducts);
      // console.log('🎁 จำนวนของแถม:', countGifts);
      // console.log('📢 จำนวนโปรโมชัน:', countPromotions);
      // console.log('📦 รวมทั้งหมด (MH_noItems):', totalItems);

      // 🧩 ดึง promotions และ gifts จากสินค้าแต่ละตัว
      const productPromotions = this.selectedProducts.flatMap((item) => item.promotions || []);
      const productGifts = this.selectedProducts.flatMap((item) => item.gifts || []);

      // // 🧮 รวมทั้งหมด
      // const allPromotions = [...(this.formData.promotions || []), ...productPromotions];
      // const allGifts = [...(this.formData.gifts || []), ...productGifts];

      // allPromotions.forEach((promo) => {
      //   if (promo.pro_sn === "P02-ZZ-9999") {
      //     console.warn(`🚫 บล็อกโปรโมชั่น: ${promo.title} (${promo.pro_sn})`);
      //   }
      // });

      // 🧮 รวมทั้งหมด
      let allPromotions = [...(this.formData.promotions || []), ...productPromotions];
      let allGifts = [...(this.formData.gifts || []), ...productGifts];

      // 🎯 กรองข้อมูลซ้ำใน promotions และ gifts
      allPromotions = allPromotions.filter(
        (promo, index, self) =>
          index === self.findIndex((p) => p.pro_sn === promo.pro_sn && p.pro_activity_id === promo.pro_activity_id)
      );

      allGifts = allGifts.filter(
        (gift, index, self) =>
          index === self.findIndex((g) => g.pro_sn === gift.pro_sn && g.pro_activity_id === gift.pro_activity_id)
      );

      allPromotions.forEach((promo) => {
        if (promo.pro_sn === "P02-ZZ-9999") {
          console.warn(`🚫 บล็อกโปรโมชั่น: ${promo.title} (${promo.pro_sn})`);
        }
      });

      // 🎯 กรองโปรโมชันที่ไม่ใช่ P02-ZZ-9999
      const filteredPromotions = allPromotions.filter((promo) => promo.pro_sn !== "P02-ZZ-9999");

      const countProducts = this.selectedProducts.length;
      const countGifts = allGifts.length;
      const countPromotions = filteredPromotions.length;
      // const countPromotions = allPromotions.length;

      const totalItems = countProducts + countGifts + countPromotions;

      const discountMacfive = this.formData.totalDiscount;
      const discT1CF = (discountMacfive * 100) / this.formData.final_total_price;
      const discFT2CC = (this.formData.final_total_price * 7) / 107;
      const discFT2CF = ((discFT2CC * 100) / this.formData.final_total_price).toFixed(5);
      // const discFT2CF = discFT2CC * 100 / this.formData.final_total_price;

      console.log("📦 รวมทั้งหมด (MH_noItems):", totalItems);

      // const payload = {
      return {
        hrows: {
          MH_date: formatDateTime(now),
          MH_type: "PS",
          MH_vnumber: docNo,
          MH_process: 9, // 9 = อนุมัติ
          MH_supcus: this.formData.customerCode,
          MH_noItems: totalItems, //
          // MH_noItems: this.formData.productList.length,
          MH_vatRate: 7,
          MH_vatTotal: parseFloat(this.formData.final_total_price) * 0.07,
          MH_netTotal: parseFloat(this.formData.final_total_price),
          MH_status: 15,
          MH_per: "DP001", //"DP001", // รหัสเซลล์ แก้ๆ
          // MH_per: sale_no, //"DP001", // รหัสเซลล์
          MH_site: this.deliveryAddress?.id || 0, // ที่อยู่จัดส่ง
          // MH_site: 1655, // ที่อยู่จัดส่ง
          MH_deldate: formatDate(now), // วันที่สร้าง
          MH_totalCOG: parseFloat(this.formData.final_total_price), // ยอดรวม
          MH_discT1: discT1CF, //ส่วนลด
          // MH_discT1: 20, //ส่วนลด
          MH_discF1: discountMacfive,
          // MH_discF1: 0,
          MH_discT2: discFT2CF, //
          // MH_discT2: 6.54205, //
          MH_discF2: (parseFloat(this.formData.final_total_price - discountMacfive) * 7) / 107, // round(ส่วนลด * 7 / 107 ,2);
          MH_flow: 0,
          MH_cur: 0,
          MH_Note: `// ${docNo}`,
          MH_cnect: 3,
          MH_cancel: 0,
        },
        erows: {
          ME_date: formatDateTime(now), // วันที่สร้าง
          ME_type: "PS",
          ME_vnumber: docNo,
          ME_supcus: this.formData.customerCode, //เลขที่เอกสาร
          ME_termCX: "7|",
          ME_termPX: "100|",
          ME_termAX: `${parseFloat(this.formData.final_total_price)}|`,
          ME_termDX: `${formatDate(now)}|`, // วันที่สร้าง
          ME_cashRec: 0,
          ME_ccRec: parseFloat(this.formData.final_total_price), // ยอดรวม
        },
        krows: {
          MK_date: formatDateTime(now), //2025\/06\/30 16:13:13
          MK_name: this.formData.fullName, // 1
          // MK_addr: this.formData.address, //ที่อยู่
          MK_addr: 1, //ที่อยู่
          // MK_tel: this.formData.phone // 1
          MK_tel: 1, // 1
        },
        lrows: [
          ...this.selectedProducts.map((item, index) => ({
            ML_date: formatDateTime(now),
            ML_type: "PS",
            ML_vnumber: docNo, //เลขที่เอกสาร
            ML_per: "DP001", //"DP001", // รหัสเซลล์
            ML_supcus: this.formData.customerCode, // รหัสลูกค้า ที่เลือกร้าน
            ML_stk: item.pro_sn || "N/A", //รหัสสินค้า SN
            ML_sto: "MAIN",
            ML_item: index + 1, // อันดับรายการ
            ML_quan: parseFloat(item.pro_quantity), // จำนวนรายการ
            ML_cog: parseFloat(item.pro_total_price || 0), // ราคารวม
            ML_netL: parseFloat(item.pro_total_price || 0), // ราคารวม
            ML_cut: 1,
            ML_unit: "PCS", // || "PCS", //หน่วย
            // ML_unit: item.pro_unit,// || "PCS", //หน่วย
            ML_des: item.pro_erp_title + '' + item.pro_goods_sku_text, // ชื่อสินค้า erp-title
            ML_addcost: 0,
            ML_discL: 0,
            ML_deldate: formatDate(now), // วันที่สร้าง
            ML_uprice: parseFloat(item.pro_unit_price), // ราคารวม
            ML_Note: "item",
            // ML_Note: "item",
          })),

          // 2. 🎁 ของแถม
          ...allGifts.map((gift, index) => ({
            // ...this.formData.gifts.map((gift, index) => ({
            ML_date: formatDateTime(now),
            ML_type: "PS",
            ML_vnumber: docNo,
            ML_per: "DP001", //"DP001",
            ML_supcus: this.formData.customerCode,
            ML_stk: gift.pro_sn || gift.prosn || "N/A",
            ML_sto: "MAIN",
            ML_item: this.selectedProducts.length + index + 1,
            ML_quan: gift.pro_goods_num || 0,
            ML_cog: 0,
            ML_netL: 0,
            ML_cut: 0,
            ML_unit: "PCS", //"PCS",
            // ML_unit: gift.pro_unit, //"PCS",
            ML_des: gift.title + '' + gift.pro_goods_sku_text,
            ML_addcost: 0,
            ML_discL: 0,
            ML_deldate: formatDate(now),
            ML_uprice: 0,
            ML_Note: gift.ML_Note || "gift",
          })),

          // 3. 📢 โปรโมชั่น
          ...filteredPromotions.map((promo, index) => ({
            // ...allPromotions.map((promo, index) => ({
            ML_date: formatDateTime(now),
            ML_type: "PS",
            ML_vnumber: docNo,
            ML_per: "DP001", //"DP001",
            ML_supcus: this.formData.customerCode,
            ML_stk: promo.pro_sn || "N/A",
            ML_sto: "MAIN",
            ML_item: this.selectedProducts.length + this.formData.gifts.length + index + 1,
            ML_quan: promo.pro_goods_num || 0,
            ML_cog: 0,
            ML_netL: 0,
            ML_cut: 0,
            ML_unit: "PCS", //"PCS", promo.pro_unit
            ML_des: promo.title,
            ML_addcost: 0,
            ML_discL: 0,
            ML_deldate: formatDate(now),
            ML_uprice: 0,
            ML_Note: promo.ML_Note || "promotion",
          })),
          // }))
        ],
      };

      console.log("📦 Macfive Payload:\n", JSON.stringify(payload, null, 2));
      return payload;
    },
  },

};
</script>
