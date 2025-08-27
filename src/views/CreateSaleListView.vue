<!-- eslint-disable vue/no-deprecated-v-on-native-modifier -->
<template>

    <div
        class="mainbox flex flex-col in-h-screen items-center gap-4 justify-center bg-gray-100 py-8 px-4 sm:px-6 lg:px-8">

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
                            <router-link to="/createsalelist" @click.native="reloadPage"
                                class="text-purple-600 font-medium hover:text-purple-800 transition">
                                Create Sale List
                            </router-link>
                        </li>
                    </ul>
                </nav>

                <!-- Action Bar -->
                <div class="flex flex-wrap justify-end gap-3 responsive-action-buttons md:gap-4 md:flex-nowrap">

                    <!-- ปุ่ม แก้ไข -->
                    <button v-if="isReadOnly" @click="enableEditMode"
                        class="bg-yellow-500 text-white py-2 px-4 md:px-6 text-sm md:text-base rounded-md hover:bg-yellow-600">
                        แก้ไข
                    </button>

                    <!-- ปุ่ม บันทึก -->
                    <button v-if="!isReadOnly && isCreatePage" @click="saveDocument"
                        class="flex items-center gap-2 bg-purple-700 text-white py-2 px-4 md:px-6 text-sm md:text-base rounded-md hover:bg-purple-800 transition duration-300 shadow hover:shadow-lg">
                        <span class="material-icons">save</span>
                        <span>บันทึก</span>
                    </button>

                    <!-- ปุ่ม บันทึกการแก้ไข -->
                    <button v-if="!isReadOnly && formData.documentNo && !isCreatePage" @click="updateDocument"
                        class="bg-green-600 text-white py-2 px-4 md:px-6 text-sm md:text-base rounded-md hover:bg-green-700">
                        บันทึกการแก้ไข
                    </button>

                    <!-- ปุ่มยืนยันการบันทึก -->
                    <!-- <button v-if="!isReadOnly && formData.documentNo && !isConfirmed && !isCreatePage"
                        @click="confirmFinalSave"
                        class="bg-red-600 text-white py-2 px-4 md:px-6 text-sm md:text-base rounded-md hover:bg-red-700">
                        ยืนยันการบันทึก (ไม่สามารถแก้ไขได้อีก)
                    </button> -->

                </div>
            </div>
        </div>

        <!-- form รายการเอกสาร -->
        <div class="boxback w-full mt-20 gap-4 bg-white p-8 rounded-lg shadow-lg">

            <div>
                <!-- Logo and Title -->
                <div class="text-center mb-4 ">
                    <img src="../assets/logo.svg" alt="Logo" class="mx-auto h-16">
                    <p class="mt-1 text-xl text-gray-700">สร้างรายการขาย</p>
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


                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">วันที่</label>
                        <div class="relative">
                            <!-- Flatpickr Input -->
                            <flat-pickr v-model="formData.sellDate" :config="dateConfig" disabled
                                placeholder="เลือกวันที่"
                                class="pl-4 pr-10 py-2 mt-1 w-full rounded-md border border-gray-300 text-gray-700 placeholder-gray-400 shadow-sm focus:ring-purple-500 focus:border-purple-500"></flat-pickr>

                            <!-- Calendar Icon -->
                            <span class="absolute inset-y-0 right-3 flex items-center pointer-events-none">
                                <span class="material-icons text-gray-400 text-base">calendar_today</span>
                            </span>
                        </div>
                    </div>


                    <!-- เงื่อนไขแสดงเพิ่มเติม -->
                    <div v-if="showMoreData" :key="showMoreData"
                        class="md:col-span-2 grid grid-cols-1 md:grid-cols-2 gap-4">

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

                        <!-- <div class="md:col-span-2">
                            <label class="block text-sm font-medium text-gray-700">ประเภทภาษี</label>
                            <input type="text" v-model="formData.taxType" :readonly="isReadOnly"
                                class="border text-gray-700 mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                        </div> -->

                    </div>

                </form>
                <!-- ปุ่ม Show More / Show Less , <button @click="showMoreData = !showMoreData" type="button" -->
                <button @click="toggleShowMoreData" type="button"
                    class="mt-4 text-purple-600 hover:underline focus:outline-none ">
                    {{ showMoreData ? 'แสดงน้อยลง ▲' : 'แสดงเพิ่มเติม ▼' }}
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
                            <p v-if="formTouched && errors.fullName" class="text-red-500 text-sm mt-1">{{
                                errors.fullName }}</p>
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700">รหัสลูกค้า</label>
                            <input type="text" v-model="formData.customerCode" disabled
                                class="mt-1 block w-full text-gray-700 rounded-md border border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                            <p v-if="formTouched && errors.customerCode" class="text-red-500 text-sm mt-1">{{
                                errors.customerCode }}
                            </p>
                        </div>

                        <div class="">
                            <label class="block text-sm font-medium text-gray-700">เบอร์โทรศัพท์ลูกค้า</label>
                            <input type="text" v-model="formData.phone" :readonly="isReadOnly"
                                class="mt-1 block w-full text-gray-700 rounded-md border border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                        </div>

                        <!-- เงื่อนไขแสดงเพิ่มเติม -->
                        <div v-if="showMore">

                            <div class="mt-4">
                                <label class="block text-sm font-medium text-gray-700">อีเมลลูกค้า</label>
                                <input type="text" v-model="formData.email" :readonly="isReadOnly"
                                    class="mt-1 block w-full text-gray-700 rounded-md border border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                            </div>

                            <div class="mt-4">
                                <label class="block text-sm font-medium text-gray-700">ที่อยู่ลูกค้า
                                    <span class="text-red-500 text-xs">*</span>
                                    <span class="text-red-500 text-xs">กรุณากรอกข้อมูลนี้ที่แบบฟอร์มที่ 3
                                        ข้อมูลที่อยู่ผู้รับ</span>
                                </label>
                                <input type="text" v-model="formData.address" disabled :readonly="isReadOnly"
                                    class="mt-1 block w-full text-gray-700 rounded-md border border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                                <!-- <p v-if="formTouched && errors.address" class="text-red-500 text-sm mt-1">{{
                                    errors.address }}</p> -->
                            </div>
                        </div>
                    </form>

                    <!-- ปุ่ม Show More / Show Less -->
                    <button @click="showMore = !showMore" type="button"
                        class="mt-4 text-purple-600 hover:underline focus:outline-none">
                        {{ showMore ? 'แสดงน้อยลง ▲' : 'แสดงเพิ่มเติม ▼' }}
                    </button>
                    <p v-if="formTouched && errors.address" class="text-red-500 text-sm mt-1">{{
                        errors.address }}</p>
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
                <div class="mdl:hidden relative">
                    <button @click="toggleDropdown"
                        class="relative bg-gradient-to-r from-purple-100 to-purple-200 text-purple-800 font-medium px-4 py-2 rounded-lg shadow-sm hover:from-purple-200 hover:to-purple-300 transition duration-300 ease-in-out flex items-center gap-2">
                        <span class="material-icons transform transition-transform duration-300"
                            :class="{ 'rotate-180': isDropdownOpen }">
                            expand_more
                        </span>
                        <span>ตัวเลือกสินค้า</span>
                    </button>
                    <div v-show="isDropdownOpen" class="absolute right-0 mt-2 bg-white border rounded shadow-lg w-48">
                        <!-- <button @click="addProductRow" :disabled="isReadOnly"
                            class="block w-full text-left px-4 py-2 text-sm text-green-600 hover:bg-green-100">
                            + เพิ่มแถวสินค้า
                        </button> -->
                        <button @click="showProductSelector = true" :disabled="isReadOnly"
                            class="block w-full text-left px-4 py-2 text-sm text-blue-600 hover:bg-blue-100">
                            เลือกสินค้า
                        </button>
                        <button @click="showPromotionSelector = true" :disabled="isReadOnly"
                            class="block w-full text-left px-4 py-2 text-sm text-yellow-600 hover:bg-yellow-100">
                            เลือกโปรโมชั่น
                        </button>
                        <button @click="removeAllProducts" :disabled="isReadOnly"
                            class="block w-full text-left px-4 py-2 text-sm text-red-600 hover:bg-red-100">
                            ลบสินค้าที่เลือกทั้งหมด
                        </button>
                    </div>
                </div>
            </div>

            <!-- Popup Component -->
            <ProductSelector v-if="showProductSelector" :productList="Apiproducts" @close="showProductSelector = false"
                :selectProducts_old_month="selectedProducts" @selectProductsWithMonth="addSelectedProductsWithmonth" />
            <!-- <ProductSelector v-if="showProductSelector" :productList="Apiproducts" @close="showProductSelector = false"
                @select-products="addSelectedProducts" /> -->

            <!--  ไม่ได้ใช้ สำรองไว้ตอนแก้ไขสินค้า  -->
            <ProductSelector v-if="showProductSelectoronly" :productList="Apiproducts"
                @close="showProductSelectoronly = false" @select-products="replaceProductInRow" />

            <!-- :productList="Apipromotion" -->
            <PromotionSelector v-if="showPromotionSelector" @close="showPromotionSelector = false"
                @select-promotion="SelectedPromotion" />


            <!-- Popup ตัวที่สอง -->
            <Promotion_ProductSelector v-if="showPromotionProductSelector" :selectedPromotion="selectedPromotion"
                :selectProducts_old="selectedProducts" @close="showPromotionProductSelector = false"
                @selectPromotionProducts="handleSelectedPromotionProducts" @go-back="handleBackToPromotion" />

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
                                <svg class="animate-spin h-8 w-8 text-blue-600 mx-auto"
                                    xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                                    <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor"
                                        stroke-width="4"></circle>
                                    <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8H4z"></path>
                                </svg>
                                <div class="mt-2 text-gray-500">กำลังโหลดข้อมูล...</div>
                            </td>
                        </tr>
                    </tbody>

                    <tbody v-if="!isLoading">
                        <!-- แสดงรายการสินค้า -->
                        <!-- 👉 Group by pro_activity_id -->


                        <template v-for="(groupObj, activityKey) in groupByActivityId(selectedProducts)"
                            :key="activityKey">
                            <!-- 🧩 แสดงชื่อหัวแต่ละกลุ่มโปรโมชัน -->
                            <tr>
                                <td colspan="9"
                                    class="px-6 py-3 bg-gray-100 font-semibold text-left text-lg text-gray-800 border">
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
                                            <img :src="product.pro_images.startsWith('http') ? product.pro_images : BASE_URL_IMAGE + product.pro_images"
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
                                        <input type="number" :min="1" :max="product.pro_stock" step="1"
                                            @blur="onQuantityBlur(product)" v-model="product.pro_quantity"
                                            @input="onQuantityChange($event, product)"
                                            @keypress="onlyNumberInput($event)" :disabled="isReadOnly"
                                            class="w-full px-2 py-1 border rounded" />
                                    </td>
                                    <td class="px-4 py-2 border">{{ product.pro_goods_price || product.pro_unit_price ?
                                       Number(product.pro_goods_price || product.pro_unit_price).toLocaleString(undefined, {
                                            minimumFractionDigits: 2,
                                            maximumFractionDigits: 2
                                        }) : '0.00' }}
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
                                    <td colspan="9"
                                        class="px-6 py-3 bg-red-50 text-red-700 text-sm border-l-4 border-red-400">
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
                                        <svg class="w-5 h-5 text-blue-600" fill="none" stroke="currentColor"
                                            stroke-width="2" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                d="M13 16h-1v-4h-1m2-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                                        </svg>
                                        <span>โปรโมชั่น</span>
                                    </div>
                                    <ul class="list-disc list-inside ml-6 mt-2 text-sm text-gray-700">
                                        <li v-for="(promotion, promoIndex) in groupObj.items[0].promotions"
                                            :key="promoIndex">
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
                                        <svg class="w-5 h-5 text-yellow-600" fill="none" stroke="currentColor"
                                            stroke-width="2" viewBox="0 0 24 24">
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
                                                <div class="font-semibold">{{ gift.color || gift.pro_goods_sku_text }}
                                                </div>
                                                <div class="text-gray-500">จำนวน: {{ gift.pro_goods_num }}</div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </template>


                        <!-- <template v-for="(group, activityId) in groupByActivityIdmonth(selectedProducts)"
                            :key="activityId"> -->

                        <!-- fsfs  -->

                        <!-- 🟦 โปรโมชั่น (มินิมอล + ลูกเล่นไอคอน) -->
                        <!-- <tr v-if="group[0].promotionsmonth && group[0].promotionsmonth.length > 0"
                                class="bg-blue-50 hover:bg-blue-100 transition-colors duration-300">
                                <td colspan="9" class="px-6 py-4 border rounded-md">
                                    <div class="flex items-center space-x-2 text-blue-800 font-medium">
                                        <svg class="w-5 h-5 text-blue-600" fill="none" stroke="currentColor"
                                            stroke-width="2" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                d="M13 16h-1v-4h-1m2-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                                        </svg>
                                        <span>โปรโมชั่น</span>
                                    </div>
                                    <ul class="list-disc list-inside ml-6 mt-2 text-sm text-gray-700">
                                        <li v-for="(promotion, promoIndex) in group[0].promotionsmonth"
                                            :key="promoIndex">
                                            {{ promotion.title }}
                                        </li>
                                    </ul>
                                </td>
                            </tr> -->


                        <!-- 🟨 ของแถม (มินิมอล + รูปภาพ + ฟีล modern card) -->
                        <!--<tr v-if="group[0].giftsmonth && group[0].giftsmonth.length > 0"
                                class="bg-yellow-50 hover:bg-yellow-100 transition-colors duration-300">
                                <td colspan="9" class="px-6 py-4 border rounded-md">
                                    <div class="flex items-center space-x-2 text-yellow-800 font-medium">
                                        <svg class="w-5 h-5 text-yellow-600" fill="none" stroke="currentColor"
                                            stroke-width="2" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                d="M12 8c-1.1 0-2 .9-2 2m4 0a2 2 0 00-2-2m0 4a2 2 0 002-2m-4 0a2 2 0 012-2m0 4a2 2 0 01-2-2m8-6H4a2 2 0 00-2 2v12a2 2 0 002 2h16a2 2 0 002-2V8l-6-6z" />
                                        </svg>
                                        <span>ของแถม</span>
                                    </div>
                                    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4 mt-4">
                                        <div v-for="(gift, giftIndex) in group[0].giftsmonth" :key="giftIndex"
                                            class="flex items-center bg-white shadow-sm rounded-lg p-2 border border-gray-200">
                                            <img v-if="gift.pro_image"
                                                :src="gift.pro_image.startsWith('http') ? gift.pro_image : BASE_URL_IMAGE + gift.pro_image"
                                                class="w-12 h-12 object-cover rounded mr-4" alt="gift image" />
                                            <div class="text-sm text-gray-800">
                                                <div class="font-semibold">{{ gift.title }}</div>
                                                <div class="text-gray-500">จำนวน: {{ gift.pro_goods_num }}</div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>

                        </template> -->

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
                        style="margin: 0.4rem;" class="w-full border px-3 py-2 rounded text-gray-700">

                        <option value="">เลือกช่องทางจัดส่ง</option>
                        <option>ไปรษณีย์ไทย</option>
                        <option>Flash Express</option>
                        <!-- <option>ไปรษณีย์</option> -->
                        <!-- <option>แมสเซนเจอร์</option>
                        <option>ขนส่งเอกชน</option> -->
                    </select>
                    <p v-if="this.formTouched && errors.deliveryType" class="text-red-500 text-sm mt-1">{{
                        errors.deliveryType
                        }}</p>
                </div>
                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label class="block font-medium mb-1 text-gray-700">ส่วนลด</label>
                        <input type="text" v-model="formData.totalDiscount" :readonly="isReadOnly"
                            class="w-full text-gray-700 border px-3 py-2 rounded text-gray-700"
                            placeholder="จำนวนเงิน หรือ %" />
                    </div>
                    <div>
                        <label class="block font-medium mb-1 text-gray-700">ค่าจัดส่ง</label>
                        <input type="number" :min="0" v-model="formData.deliveryFee" :readonly="isReadOnly"
                            class="w-full text-gray-700 border px-3 py-2 rounded text-gray-700"
                            placeholder="ค่าจัดส่ง" />

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

            <!-- รวม -->

            <div class="mt-6 text-right space-y-1">
                <!-- ซ่อนมูลค่ารวมก่อนภาษี เมื่อ isVatIncluded === true -->
                <div v-if="isVathidden" class="text-gray-700">
                    มูลค่ารวมก่อนภาษี:
                    <span class="ml-2 text-gray-700">
                        {{ netAmountBeforeVat.toLocaleString(undefined, {
                            minimumFractionDigits: 2,
                            maximumFractionDigits: 2
                        }) }}
                    </span>
                    <!-- <span class="ml-2 text-gray-700">{{ Number(totalAmountBeforeDiscount).toLocaleString(undefined, {
                        minimumFractionDigits: 2, maximumFractionDigits: 2
                    }) }}</span> -->
                </div>

                <div class="text-gray-700 flex items-center justify-end">
                    <input type="checkbox" v-model="isVathidden" id="vatCheckbox" @change="handleVatToggle"
                        :disabled="isReadOnly" class="mr-2" />
                    <label for="vatCheckbox">แสดงภาษีมูลค่าเพิ่ม (7%) และมูลค่าก่อนภาษี</label>
                    <!-- แสดงภาษีเมื่อ isVatIncluded === true -->
                    <span v-if="isVathidden" class="ml-2 text-gray-700">
                        {{ vatAmount.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })
                        }} บาท
                    </span>
                    <!-- <span v-if="!isVathidden" class="ml-2 text-gray-700">
                        {{ Number(totalAmountBeforeDiscount * 0.07).toLocaleString(undefined, {
                            minimumFractionDigits:
                                2,
                            maximumFractionDigits: 2
                        }) }}
                    </span> -->
                </div>

                <div v-if="!formData.deliveryFee == 0" class="text-gray-700">
                    ค่าจัดส่ง:
                    <span class="ml-2 text-gray-700">
                        {{ formData.deliveryFee ? formData.deliveryFee.toLocaleString(undefined, {
                            minimumFractionDigits: 2,
                            maximumFractionDigits: 2
                        }) : '0.00' }}
                    </span>
                </div>
                <div v-if="!formData.totalDiscount == 0" class="text-gray-700">
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
                        {{ grandTotal.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })
                        }}
                    </span>
                    <!-- <span class="ml-2 text-blue-600">{{ grandTotal.toLocaleString(undefined, {
                        minimumFractionDigits: 2,
                        maximumFractionDigits: 2
                    }) }}</span> -->
                </div>
            </div>

        </div>


        <!-- -ข้อมูลที่อยู่ผู้รับ  -->
        <div class="w-full mx-auto p-6 bg-white rounded-lg shadow-md space-y-8">
            <!-- กล่องหลัก แบ่งเป็น 2 ฝั่ง -->
            <div class="  gap-8">
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
                            <p v-if="formTouched && errors.receiverPhone" class="text-red-500 text-sm mt-1">{{
                                errors.receiverPhone }}
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
                            <textarea rows="4" v-model="formData.receiverAddress" disabled :readonly="isReadOnly"
                                class="w-full text-gray-700 border rounded px-3 py-2 resize-none">
                    </textarea>
                        </div>

                        <div class="flex justify-end gap-4 mt-4">
                            <!-- ปุ่ม popup ด้านล่างขวา -->
                          <div class="bottom-6 right-6 z-50 justify-self-end">
                              <button
                                  @click="showAddressPopupBase = true"
                                  :disabled="isReadOnly"
                                  class="bg-green-600 text-white rounded-md shadow hover:bg-green-700 transition
                                        px-2 py-1 text-xs sm:px-3 sm:py-1 sm:text-sm sml:px-3 sml:py-2 sml:text-sml md:px-4 md:py-2 md:text-base">
                                  + เลือกที่อยู่ / จัดส่ง เดิมที่มีอยู่
                              </button>
                          </div>

                          <!-- ปุ่ม popup ด้านล่างขวา -->
                          <div class="bottom-6 right-6 z-50 justify-self-end">
                              <button
                                  @click="showAddressPopup = true"
                                  :disabled="isReadOnly"
                                  class="bg-purple-600 text-white rounded-md shadow hover:bg-purple-700 transition
                                        px-2 py-1 text-xs sm:px-3 sm:py-1 sm:text-sm sml:px-3 sml:py-2 sml:text-sml md:px-4 md:py-2 md:text-base">
                                  + เพิ่มที่อยู่ / จัดส่ง ใหม่
                              </button>
                          </div>

                            <!-- ✅ แสดง Popup -->
                            <DeliveryAddressPopup v-if="showAddressPopup" :existingAddress="selectedAddress"
                                @close="showAddressPopup = false" @submitted="handleAddressSelected" />

                            <DeliveryAddressPopupBase v-if="showAddressPopupBase"
                                :existingAddressBase="selectedAddressBase" @close="showAddressPopupBase = false"
                                :customerNo="customerData.customer_no" @submitted="handleAddressSelectedBase" />

                            <p v-if="formTouched && errors.receiverAddress" class="text-red-500 text-sm mt-1">{{
                                errors.receiverAddress }} </p>
                        </div>

                        <!-- <button class="mt-2 px-4 py-2 bg-indigo-600 text-white text-sm rounded hover:bg-indigo-700">
                                ตรวจสอบที่อยู่
                            </button> -->
                        <!-- </div> -->
                    </div>
                </div>

                <!-- ปุ่ม Show More / Show Less -->
                <!-- ไม่ได้ใช้งาน -->
                <!-- <button @click="showMoreAdress = !showMoreAdress" type="button"
                    class="mt-4 text-purple-600 hover:underline focus:outline-none">
                    {{ showMoreAdress ? 'แสดงน้อยลง ▲' : 'แสดงเพิ่มเติม ▼ ' }}
                </button> -->

                <!-- ใช้งานได้ -->
                <!-- <div class="mt-4 flex items-center space-x-2">
                    <button @click="showMoreAdress = !showMoreAdress" type="button"
                        class="text-purple-600 hover:underline focus:outline-none">
                        {{ showMoreAdress ? 'แสดงน้อยลง ▲' : 'แสดงเพิ่มเติม ▼ ' }}
                    </button>
                    <span class="text-red-500 text-xs">*</span>
                    <span class="text-red-500 text-xs">จำเป็นต้องกรอกข้อมูลนี้</span>
                </div> -->

            </div>

            <!-- ขวา: ข้อมูลการจัดส่งสินค้า -->
            <div>
                <div class="flex items-center gap-2 mb-4">
                    <span class="material-icons text-purple-600">local_shipping</span>
                    <h2 class="text-lg font-semibold text-gray-800">ข้อมูลการจัดส่งสินค้า</h2>
                </div>

                <div class="space-y-4">
                    <!-- <div>
                        <label class="text-sm text-gray-700 block mb-1">วันส่งสินค้า</label>
                        <div class="flex">
                            <input type="date" v-model="formData.deliveryDate" :readonly="isReadOnly"
                                class="flex-grow border rounded-l px-3 py-2 bg-gray-50 text-gray-700" />
                            <p v-if="formTouched && errors.deliveryDate" class="text-red-500 text-sm mt-1">{{
                                errors.deliveryDate }}
                            </p>

                            <button class="bg-gray-200 px-3 rounded-r hover:bg-gray-300">
                                <span class="material-icons text-sm">calendar_today</span>
                            </button>
                        </div>
                    </div> -->
                    <div>
                        <label class="block text-sm font-medium text-gray-700">วันที่จัดส่ง</label>

                        <div class="relative">
                            <!-- Flatpickr Input -->
                            <flat-pickr v-model="formData.deliveryDate" :config="dateConfig" :disabled="isReadOnly"
                                class="cursor-pointer w-full text-gray-700 border rounded px-3 py-2"></flat-pickr>
                            <!-- class="cursor-not-allowed pr-10 mt-1 pl-4 py-2 w-full border border-gray-300 rounded-lg shadow-sm focus:border-purple-500 focus:ring-purple-500 text-gray-700 placeholder-gray-400 bg-gray-100" /> -->

                            <!-- Calendar Icon on the right -->
                            <span class="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none"
                                style="padding-top: 0.2rem;">
                                <span class="material-icons text-gray-400 text-base">calendar_today</span>
                            </span>

                        </div>

                    </div>
                    <p v-if="formTouched && errors.deliveryDate" class="text-red-500 text-sm mt-1">{{
                        errors.deliveryDate }} </p>

                    <div>
                        <label class="text-sm text-gray-700 block mb-1">Tracking No.
                            <!-- <span class="text-red-500 text-xs ml-1">*</span> -->
                            <!-- <span class="text-red-500 text-xs ml-1">จำเป็นต้องกรอกข้อมูลนี้</span> -->
                        </label>
                        <input type="text" v-model="formData.trackingNo" :readonly="isReadOnly"
                            class="w-full text-gray-700 border rounded px-3 py-2" />
                        <p v-if="formTouched && errors.trackingNo" class="text-red-500 text-sm mt-1">{{
                            errors.trackingNo }} </p>
                    </div>
                </div>
            </div>


        </div>

        <div class="w-full mx-auto p-6 rounded-lg bg-white shadow-md space-y-8">

            <div :class="[
                'gap-4 grid',
                visibleButtons.length === 1 ? 'grid-cols-1 place-items-center' : 'grid-cols-1 md:grid-cols-2'
            ]">
                <!-- ปุ่ม แก้ไข -->
                <!-- <button v-if="isReadOnly" @click="enableEditMode"
                    class="bg-yellow-500 w-full text-white py-2 px-6 rounded-md hover:bg-yellow-600">
                    แก้ไข
                </button> -->

                <!-- ปุ่ม แก้ไข -->
                <button v-if="isReadOnly && !isConfirmed && !lockedDocumentNos.includes(formData.documentNo)"
                    @click="enableEditMode"
                    class="bg-yellow-500 w-full text-white py-2 px-6 rounded-md hover:bg-yellow-600">
                    แก้ไข
                </button>

                <!-- ปุ่ม บันทึก (เฉพาะเมื่อ path คือ /createsalelist) -->
                <button v-if="!isReadOnly && isCreatePage" @click="saveDocument"
                    class="bg-purple-700 w-full text-white py-2 px-6 rounded-md hover:bg-purple-800">
                    บันทึก
                </button>

                <!-- ปุ่ม บันทึกการแก้ไข (เฉพาะเมื่อมี documentNo และไม่ใช่หน้า create) -->
                <button v-if="!isReadOnly && formData.documentNo && !isCreatePage" @click="updateDocument"
                    class="bg-green-600 w-full text-white py-2 px-6 rounded-md hover:bg-green-700">
                    บันทึกการแก้ไข
                </button>

                <!-- ✅ ปุ่มยืนยันบันทึก ปรากฏเฉพาะกรณีแก้ไข -->
                <button v-if="!isReadOnly && formData.documentNo && !isConfirmed && !isCreatePage"
                    @click="confirmFinalSave"
                    class="bg-red-600 w-full text-white py-2 px-6 rounded-md hover:bg-red-700">
                    ยืนยันการบันทึก (ไม่สามารถแก้ไขได้อีก)
                </button>
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
// eslint-disable-next-line no-unused-vars
import { ref, onMounted, watch } from 'vue';
import axios from 'axios';
import Swal from 'sweetalert2';
import ProductSelector from '../components/ProductSelector.vue';
import PromotionSelector from '../components/PromotionSelector.vue';
import Promotion_ProductSelector from '../components/Promotion_ProductSelector.vue';
import DeliveryAddressPopup from '@/components/DeliveryAddressPopup.vue'
import DeliveryAddressPopupBase from '@/components/DeliveryAddressPopupBase.vue'

import { sendToMacfive } from "@/services/macfiveService.js";

// import { logActivity } from '@/services/activityLogger.js'

// eslint-disable-next-line no-unused-vars
import { useRoute } from 'vue-router'
// import ConfirmEditPopup from '@/components/saleOrder/ConfirmEditPopup.vue'
import qs from 'qs';
import Flatpickr from 'vue-flatpickr-component'
import 'flatpickr/dist/flatpickr.css'

// import Thai locale
import { Thai } from 'flatpickr/dist/l10n/th.js'
import flatpickr from 'flatpickr'
// import { it } from 'vitest';


// ตั้งค่าภาษาไทยให้กับ flatpickr
flatpickr.localize(Thai)

const BASE_URL = import.meta.env.VITE_API_URL;
const BASE_URL_LOCAL = import.meta.env.VITE_API_URL_LOCAL;
const BASE_URL_C_SHARP = import.meta.env.VITE_API_URL_C_SHARP;

console.log('adadasdsadadasdadasdadasdasda', BASE_URL_LOCAL);


const BASE_URL_AUTH = import.meta.env.VITE_API_URL_AUTH;

// const secretKey1 = import.meta.env.VITE_SECRET_KEY1;
// const secretKey2 = import.meta.env.VITE_SECRET_KEY2;

// eslint-disable-next-line no-unused-vars
const BASE_URL_IMAGE = import.meta.env.VITE_API_URL_IMAGE;

// const getDataCustomer = JSON.parse(localStorage.getItem('selectDataCustomer') || 'null');

// console.log("BASE_URL_IMAGE:", BASE_URL_IMAGE);

export default {
    name: 'SignupForm',
    components: {
        ProductSelector,
        PromotionSelector,
        Promotion_ProductSelector,
        DeliveryAddressPopup,
        DeliveryAddressPopupBase,
        'flat-pickr': Flatpickr,
        // ConfirmEditPopup
    },
    data() {
        return {

            hasLoadedAll: false, // ✅ ป้องกันการ reload ซ้ำ

            isLoading: false, // สำหรับ loading spinner

            isVatIncluded: true, //  เริ่มต้นให้คิดภาษี
            isVathidden: false, //  เริ่มต้นให้คิดภาษี
            originalIsVathidden: false,

            // ตัวแปรควบคุม popup
            showAddressPopup: false, // ควบคุมการแสดง popup ที่อยู่
            showAddressPopupBase: false, // ควบคุมการแสดง popup ที่อยู่

            //  เก็บข้อมูลที่อยู่ที่เลือกจาก popup
            selectedAddress: [],
            selectedAddressBase: [],

            isConfirmed: false, // สำหรับควบคุมปุ่ม "ยืนยันการบันทึก"
            lockedDocumentNos: [], // เอกสารที่ถูกล็อก (เก็บใน LocalStorage หรือดึงจาก backend)

            errors: {}, // เก็บข้อผิดพลาดของฟอร์ม
            formTouched: false, // ค่าเริ่มต้น

            customerData: JSON.parse(localStorage.getItem('selectDataCustomer') || 'null'),

            BASE_URL_IMAGE: import.meta.env.VITE_API_URL_IMAGE,

            isReadOnly: false, // ใช้ควบคุมสถานะ readonly

            selectedDate: '',
            // ✅ ตั้งค่ารูปแบบวันและปฏิทิน
            dateConfig: {
                dateFormat: 'd/m/Y', // เช่น 01/07/2568
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

            formData: {

                account: '',
                nickname_admin: '',
                sale_no: '',

                vatVisible: false, // ตัวนี้ไว้เก็บสถานะว่าติ๊กไว้หรือไม่

                listCode: '',
                // oxlint-disable-next-line no-dupe-keys
                sellDate: '',
                // sellDate: new Date().toISOString().split('T')[0], // ตั้งค่าเริ่มต้นเป็นวันที่ปัจจุบัน (YYYY-MM-DD)
                // sellDate: new Date().toLocaleDateString('th-TH', {
                //     day: '2-digit',
                //     month: '2-digit',
                //     year: 'numeric',
                // }), // ตั้งค่าเริ่มต้นเป็นวันที่ปัจจุบันในรูปแบบ วัน/เดือน/ปี
                sellDate: new Date(),        // ✅ ใช้ Date object ตรง ๆ
                deliveryDate: new Date(),    // ✅ ใช้ Date object ตรง ๆ
                // expireDate: '',
                // oxlint-disable-next-line no-constant-binary-expression
                reference: '' || '-',
                // oxlint-disable-next-line no-constant-binary-expression
                channel: '' || '-',
                // oxlint-disable-next-line no-constant-binary-expression
                taxType: '' || '-',

                fullName: '',
                customerCode: '',
                phone: '',
                // oxlint-disable-next-line no-constant-binary-expression
                email: '' || '-',
                address: '',
                receiverName: '',
                // oxlint-disable-next-line no-constant-binary-expression
                receiverPhone: '' || '-',
                // oxlint-disable-next-line no-constant-binary-expression
                receiverEmail: '' || '-',
                receiverAddress: '',
                // oxlint-disable-next-line no-constant-binary-expression
                note: '' || '-',
                // oxlint-disable-next-line no-constant-binary-expression
                workDetail: '' || '-',

                promotions: [], // เก็บรายการสินค้าที่เลือก
                gifts: [], // เก็บรายการของแถม

                // ใช้
                // deliveryDate: '',

                // oxlint-disable-next-line no-constant-binary-expression
                trackingNo: '' || '-',
                deliveryType: '',

                // oxlint-disable-next-line no-constant-binary-expression
                totalDiscount: '' || 0,
                // oxlint-disable-next-line no-constant-binary-expression
                sumProMonth: '' || 0, // เพิ่มเพื่อเก็บ sum_pro_month

                // oxlint-disable-next-line no-constant-binary-expression
                deliveryFee: '' || 0,

                documentNo: '',

                // prosn:'',

                // oxlint-disable-next-line no-constant-binary-expression
                pro_quantity: '' || 0,

                // oxlint-disable-next-line no-constant-binary-expression
                discount: '' || 0,

                // ... ของเดิมทั้งหมด
                price_before_tax: 0,
                tax_value: 0,
                price_with_tax: 0,
                // ... ต่อไป

                final_total_price: 0,

                // total_price: '' || 0,

                // product_name : product.pro_name,
                // qty: '',
                pro_erp_title: '',
                // pro_name: '',

                productList: [],

                warehouseCode: 'H1',
                docType: 'SO',
            },

            //form ที่โหลดมาตั้งต้นเพื่อเปรียบเทียบค่าว่ามีการเปลี่ยนแปลงก่อนอัปเดทไหม
            originalFormData: {},
            originalSelectedProducts: [],

            selectedProducts: [], // ค่าเริ่มต้นเป็น array ว่าง

            allSelectedPromotionProducts: [], // 🔁 รวมสินค้าที่เคยเลือกทั้งหมด
        };
    },

// oxlint-disable-next-line no-dupe-keys
    async mounted() {
        // await logActivity('user ได้เข้าหน้า CreateSaleListView', 'CreateSaleListView.vue');

        const locked = JSON.parse(localStorage.getItem('lockedDocumentNos') || '[]');
        this.lockedDocumentNos = locked;

        if (this.formData.documentNo && locked.includes(this.formData.documentNo)) {
            this.isReadOnly = true;
            this.isConfirmed = true;
        }
    },

    watch: {
        isVatIncluded(newVal) {
            this.formData.taxType = newVal ? 'รวมภาษี' : 'ไม่รวมภาษี'
        },

        // ✅ watch ทุก field ที่ต้องการทีละตัว
        'formData.deliveryDate'(newVal) {
            console.log("deliveryDate เปลี่ยนเป็น:", newVal);
        },
        'formData.fullName'(newVal) {
            console.log("fullName เปลี่ยนเป็น:", newVal);
        },
        'formData.email'(newVal) {
            console.log("email เปลี่ยนเป็น:", newVal);
        },

        // ✅ หรือ watch ทั้ง formData
        formData: {
            handler(newVal) {
                console.log("formData เปลี่ยนแปลง:", JSON.parse(JSON.stringify(newVal)));
            },
            deep: true // จำเป็นต้องใส่ถ้า watch object
        }
    },

    computed: {

        totalAmountBeforeDiscount() {
            const subtotal = this.selectedProducts.reduce((sum, product) => {
                const qty = product.pro_quantity || 0;
                const price = product.pro_unit_price || 0;
                const discount = product.discount || 0;
                return sum + (qty * price - discount);
            }, 0);
            const deliveryFee = parseFloat(this.formData.deliveryFee || 0) || 0;
            // const totalDiscount = parseFloat(this.formData.totalDiscount || 0) || 0;
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
                return grossAmount - (grossAmount / 1.07);
            } else {
                return this.totalAmountBeforeDiscount * 0.07;
            }
        },


        //พอใช้ได้ปรับ .
        // totalAmountBeforeDiscount() {
        //     const subtotal = this.selectedProducts.reduce((sum, product) => {
        //         const qty = product.pro_quantity || 0;
        //         const price = product.pro_unit_price || 0;
        //         const discount = product.discount || 0;
        //         return sum + (qty * price - discount);
        //     }, 0);

        //     const deliveryFee = parseFloat(this.formData.deliveryFee) || 0;
        //     const totalDiscount = parseFloat(this.formData.totalDiscount) || 0;

        //     // ✅ ราคาสุทธิรวม VAT
        //     const totalWithVat = subtotal + deliveryFee - totalDiscount;

        //     if (this.isVatIncluded) {
        //         // ✅ ราคาก่อน VAT
        //         const netBeforeVat = totalWithVat / 1.07;
        //         return netBeforeVat < 0 ? 0 : netBeforeVat;
        //     } else {
        //         return totalWithVat < 0 ? 0 : totalWithVat;
        //     }
        // },

        // vatAmount() {
        //     // VAT = grandTotal - totalAmountBeforeDiscount
        //     const vat = this.grandTotal - this.totalAmountBeforeDiscount;
        //     return vat < 0 ? 0 : vat;
        // },

        // grandTotal() {
        //     // ✅ ราคาสุทธิรวม VAT อยู่แล้ว
        //     const subtotal = this.selectedProducts.reduce((sum, product) => {
        //         const qty = product.pro_quantity || 0;
        //         const price = product.pro_unit_price || 0;
        //         const discount = product.discount || 0;
        //         return sum + (qty * price - discount);
        //     }, 0);

        //     const deliveryFee = parseFloat(this.formData.deliveryFee) || 0;
        //     const totalDiscount = parseFloat(this.formData.totalDiscount) || 0;
        //     const total = subtotal + deliveryFee - totalDiscount;
        //     return total < 0 ? 0 : total;
        // },


        // ตรวจสอบว่าเป็นหน้าแก้ไขหรือสร้างใหม่
        isCreatePage() {
            return this.$route.path === '/createsalelist'
        },

        visibleButtons() {
            const buttons = []
            if (this.isReadOnly) buttons.push('edit')
            if (!this.isReadOnly && this.isCreatePage) buttons.push('save')
            if (!this.isReadOnly && this.formData.documentNo && !this.isCreatePage) buttons.push('update')
            return buttons

        },

    },

    methods: {


        async submittedProduct() {

            try {
                const token = localStorage.getItem('token');

                console.log('Check: this.selectedProducts', this.selectedProducts);

                // ⚠️ กรองก่อนว่า ต้องไม่เป็น '' หรือ null หรือ undefined
                // const validProducts = this.selectedProducts.filter(product => {
                //     return product.pro_goods_num !== '' && product.pro_goods_num !== null && product.pro_goods_num !== undefined;
                // });

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
                //     products: validProducts.map(product => ({
                //     // products: this.selectedProducts.map(product => ({
                //         pro_activity_id: product.pro_activity_id || 0,
                //         pro_goods_id: product.pro_goods_id,
                //         pro_goods_price: parseFloat(product.pro_unit_price) || 0,
                //         pro_sku_price_id: product.pro_sku_price_id || product.pro_id || 0,
                //         pro_erp_title: product.pro_erp_title || '',
                //         pro_goods_num: product.pro_quantity, // ส่งจำนวนล่าสุด
                //         pro_image: product.pro_images,
                //         pro_sn: product.pro_sn,
                //         pro_title: product.pro_title,
                //         pro_units: product.pro_units
                //     }))
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

                    // ✅ ตรวจสอบว่ามีข้อมูลใน datasumdiscount และนำมาใช้
                    // if (datasumdiscount.discount_day !== undefined) {
                    //     // this.formData.totalDiscount = datasumdiscount.discount_day;
                    //     this.formData.totalDiscount = Math.abs(Number(datasumdiscount.discount_day));
                    //     console.log("🎯 Updated totalDiscount:", this.formData.totalDiscount);
                    // } else {
                    //     console.warn("⚠️ ไม่พบ discount_day ใน datasumdiscount:", datasumdiscount);
                    // }

                    // // ✅ ถ้าคุณต้องการเก็บค่ารวมรายเดือนไว้ใช้ต่อ
                    // if (datasumdiscount.sum_pro_month !== undefined) {
                    //     this.formData.sumProMonth = datasumdiscount.sum_pro_month;
                    //     console.log("🧾 sum_pro_month:", this.formData.sumProMonth);
                    // }


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
                            pro_goods_id: matchedItem.pro_goods_id,
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

        // Optional: mock API call
        saveVatVisibilityToServer(documentNo, isVisible) {
            // call API here
            console.log(`📡 ส่งข้อมูลว่าเอกสาร ${documentNo} แสดงภาษี: ${isVisible}`);
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
            if (product.pro_quantity === '' || product.pro_quantity === null || product.pro_quantity === 0) {
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
                }, 500); // รอ 200ms
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
            // if (product.pro_quantity === '' || product.pro_quantity === null) {
            //     product.pro_quantity = 1;
            //     product.pro_goods_num = 1;

            //     try {
            //         console.log('Check product.pro_quantity: ', product.pro_quantity);
            //         console.log('Check product.pro_goods_num: ', product.pro_goods_num);
            //         await this.submittedProduct();
            //     } catch (error) {
            //         console.error('Error submitting product on blur:', error);
            //     }
            // }
        },

        async onQuantityChange(event, product) {
            let value = event.target.value;

            // อนุญาตให้ว่างได้ระหว่างพิมพ์
            if (value === '') {
                product.pro_quantity = '';
                product.pro_goods_num = '';
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
                console.log('Check pro_stock: ',product.pro_stock);//
                product.pro_quantity =  product.pro_stock; //product.pro_quantity ||
                console.log('Check pro_quantity: ',product.pro_quantity);//
                product.pro_goods_num = product.pro_quantity;
                console.log('Check pro_goods_num: ',product.pro_goods_num);//
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
                            pro_goods_num: product.pro_goods_num || product.pro_quantity || 0,
                            pro_quantity: product.pro_quantity || product.pro_goods_num || 0,
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
                }, 100); // รอ 200ms

                // await this.submittedProduct();
            } catch (error) {
                console.error('Error submitting product:', error);
            }
        },


        // async onQuantityChange(product) {
        //     if (product.pro_quantity < 1) product.pro_quantity = 1;
        //     if (product.pro_quantity > product.pro_stock) product.pro_quantity = product.pro_stock;

        //     console.log('Check product.pro_quantity: ',product.pro_quantity);

        //     product.pro_goods_num = product.pro_quantity;

        //     // ✅ รอให้ submittedProduct ทำงานเสร็จ
        //     if (this.selectedProducts && this.selectedProducts.length > 0) {
        //         await this.submittedProduct();
        //     }
        // },

        // ใช้ได้ดีเลย
        // onQuantityChange(product) {
        //     if (product.pro_quantity < 1) product.pro_quantity = 1;
        //     if (product.pro_quantity > product.pro_stock) product.pro_quantity = product.pro_stock;

        //     product.pro_goods_num = product.pro_quantity;

        //     this.submittedProduct(); // แทนการส่งแค่ product เดียว
        // },

        // groupByActivityId(products) {
        //     return products.reduce((acc, item) => {
        //         const key = item.promotions?.[0]?.pro_activity_id || item.pro_activity_id || 'no-activity';
        //         if (!acc[key]) acc[key] = [];
        //         acc[key].push(item);
        //         return acc;
        //     }, {});
        // },


        // // // ใช้ได้ 1000% ใช้อยู๋
        // groupByActivityId(products) {
        //     return products.reduce((acc, item) => {
        //         //1515/stfalse
        //         const isMonthly = item.pro_activity_id === 0;
        //         const key = `${item.activity_id || 'no-activity'}-st${item.st ?? false}`;
        //         // if (!acc[key]) acc[key] = [];
        //          if (!acc[key]) acc[key] = {
        //             title: isMonthly
        //                 ? '🎯 โปรโมชั่นรายเดือน'
        //                 : `🔥 โปรโมชั่นรายวัน ${item.pro_activity_id}`,
        //             items: []
        //         };
        //         // acc[key].push(item);
        //         acc[key].items.push(item);
        //         return acc;
        //     }, {});
        // },


        //         groupByActivityId(products) {
        //     return products.reduce((acc, item) => {
        //         const isMonthly = item.pro_activity_id === 0;
        //         const isActive = item.st === true;

        //         const key = isMonthly
        //             ? `monthly-st${isActive ? 'true' : 'false'}`
        //             : `promo-${item.pro_activity_id}-st${isActive ? 'true' : 'false'}`;

        //         // สร้างชื่อกลุ่มที่อ่านง่าย
        //         const title = isMonthly
        //             ? `🎯 โปรโมชั่นรายเดือน (${isActive ? 'ใช้งานอยู่' : 'ยังไม่เปิดใช้งาน'})`
        //             : `🔥 โปรโมชั่นรายวัน #${item.pro_activity_id} (${isActive ? 'ใช้งานอยู่' : 'ยังไม่เปิดใช้งาน'})`;

        //         if (!acc[key]) {
        //             acc[key] = {
        //                 title,
        //                 items: []
        //             };
        //         }

        //         acc[key].items.push(item);
        //         return acc;
        //     }, {});
        // },



        // groupByActivityId(products) {
        //     return products.reduce((acc, item) => {
        //         // เงื่อนไขพิเศษ: pro_activity_id !== 0 และ st === false
        //         if (item.pro_activity_id != 0 && item.st == false) {
        //             const key = 'invalid-activity';
        //             if (!acc[key]) {
        //                 acc[key] = {
        //                     title: '🎯โปรโมชันรายเดือน',
        //                     items: []
        //                 };
        //             }
        //             acc[key].items.push(item);
        //             return acc;
        //         }

        //         // เงื่อนไขปกติ
        //         const isMonthly = item.pro_activity_id == 0;
        //         const key = isMonthly
        //             ? `monthly-st${item.st ?? 0}`
        //             : `promo-${item.pro_activity_id}-st${item.st ?? 0}`;

        //         if (!acc[key]) {
        //             acc[key] = {
        //                 title: isMonthly
        //                     ? '🎯 โปรโมชั่นรายเดือน'
        //                     : `🔥 โปรโมชั่นรายวัน ${item.pro_activity_id}`,
        //                 items: []
        //             };
        //         }

        //         acc[key].items.push(item);
        //         return acc;
        //     }, {});
        // },

        groupByActivityId(products) {
            return products.reduce((acc, item) => {
                // พยายามดึง pro_activity_id จาก promotions ก่อน
                const promoId = item.promotions?.[0]?.pro_activity_id ?? null;
                const promoSt = item.promotions?.[0]?.st ?? null;

                let key, title;
                if (promoId !== null) {
                    // ถ้ามี promotion ให้ใช้โปรโมชันนั้นเป็นตัวกำหนดกลุ่ม
                    key = `promo-${promoId}-st${promoSt}`;
                    title = promoSt
                        ? `🔥 โปรโมชั่นรายวัน ${promoId}`
                        : `🎯 โปรโมชั่นรายเดือน ${promoId}`;
                } else {
                    // ถ้าไม่มี promotion ก็ fallback ไปที่เดิม
                    const pid = Number(item.pro_activity_id);
                    const st = item.st ? 1 : 0;
                    key = pid === 0
                        ? `monthly-st${st}`
                        : `invalid-activity`;
                    title = pid === 0
                        ? '🎯 โปรโมชั่นรายเดือน'
                        : '⚠️ โปรไม่เข้าเงื่อนไข';
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


        //โอเคเลย
        // groupByActivityId(products) {
        //     return products.reduce((acc, item) => {
        //         const isMonthly = item.pro_activity_id === 0;
        //         const isFalse = item.st === false;

        //         let key;
        //         if (isFalse) {
        //             key = 'st-false-group';
        //         } else {
        //             key = isMonthly
        //                 ? `monthly-st-true`
        //                 : `promo-${item.pro_activity_id}-st-true`;
        //         }

        //         if (!acc[key]) {
        //             acc[key] = {
        //                 title: isFalse
        //                     ? '⚠️ กลุ่มที่ไม่ได้ระบุสถานะ (st = false)'
        //                     : isMonthly
        //                         ? '🎯 โปรโมชั่นรายเดือน (st = true)'
        //                         : `🔥 โปรโมชั่นรายวัน ${item.pro_activity_id} (st = true)`,
        //                 items: []
        //             };
        //         }

        //         acc[key].items.push(item);
        //         return acc;
        //     }, {});
        // },


        // groupByActivityId(products) {
        //     return products.reduce((acc, item) => {
        //         const isMonthly = item.pro_activity_id === 0;
        //         const key = isMonthly
        //             ? `monthly-st${item.st ?? 0}`
        //             : `promo-${item.pro_activity_id}-st${item.st ?? 0}`;

        //         if (!acc[key]) acc[key] = {
        //             title: isMonthly
        //                 ? '🎯 โปรโมชั่นรายเดือน'
        //                 : `🔥 โปรโมชั่นรายวัน ${item.pro_activity_id}`,
        //             items: []
        //         };

        //         acc[key].items.push(item);
        //         return acc;
        //     }, {});
        // },




        // แยกกลุ่ม promotions
        // groupByActivityId(products) {
        //     return products.reduce((acc, item) => {
        //         const key = `${item.activity_id || 'no-activity'}-st${item.st ?? 0}`;

        //         item.pro_quantity = item.pro_goods_num;

        //         const filteredItem = {
        //             ...item, // ใช้ item ที่มีข้อมูลทั้งหมดก่อน แล้วลดทอนภายหลัง
        //             activity_id: item.activity_id,
        //             pro_activity_id: item.pro_activity_id,
        //             promotions: item.promotions,

        //             gifts: item.gifts
        //         };

        //         // แปลง st เป็น Boolean

        //         console.log("📦 filteredItem:", filteredItem);

        //         // หากคุณต้องการเอาเฉพาะบาง field จริง ๆ:
        //         // const filteredItem = {
        //         //   ...getCleanProduct(item),
        //         //   ...getCleanMatchedItem(item),
        //         //   activity_id: item.activity_id,
        //         //   pro_activity_id: item.pro_activity_id,
        //         //   promotions: item.promotions,
        //         //   gifts: item.gifts
        //         // };

        //         if (!acc[key]) acc[key] = [];
        //         acc[key].push(filteredItem);
        //         return acc;
        //     }, {});
        // },

        // groupByActivityIdmonth(products) {
        //     return products.reduce((acc, item) => {
        //         const key = `${item.activity_id || 'no-activity'}-st${item.st ?? 0}`;

        //         const filteredItem = {
        //             promotionsmonth: item.promotionsmonth,
        //             giftsmonth: item.giftsmonth,
        //         };

        //         // หากคุณต้องการเอาเฉพาะบาง field จริง ๆ:
        //         // const filteredItem = {
        //         //   ...getCleanProduct(item),
        //         //   ...getCleanMatchedItem(item),
        //         //   activity_id: item.activity_id,
        //         //   pro_activity_id: item.pro_activity_id,
        //         //   promotions: item.promotions,
        //         //   gifts: item.gifts
        //         // };

        //         if (!acc[key]) acc[key] = [];
        //         acc[key].push(filteredItem);
        //         return acc;
        //     }, {});
        // },.




        reloadPage(event) {
            event.preventDefault(); // ป้องกัน router-link ทำงานเอง
            this.$router.go();      // รีโหลดหน้าเดิม
        },

        // groupByActivityId(products) {
        //     return products.reduce((acc, item) => {
        //         const key = item.pro_activity_id || 'no-activity'; // ✅ ใช้ pro_activity_id โดยตรง
        //         if (!acc[key]) acc[key] = [];
        //         acc[key].push(item);
        //         return acc;
        //     }, {});
        // },


        // groupByActivityId(products) {
        //     return products.reduce((acc, item) => {
        //         const key = item.activity_id || 'no-activity';
        //         if (!acc[key]) acc[key] = [];
        //         acc[key].push(item);
        //         return acc;
        //     }, {});
        // },


        validateQuantity(product) {
            if (product.pro_quantity > product.pro_stock) {
                product.pro_quantity = product.pro_stock;
            } else if (product.pro_quantity < 1) {
                product.pro_quantity = 1;
            }
        },


        // ปุ่ม dropdown สำหรับมือถือ
        toggleDropdown() {
            this.isDropdownOpen = !this.isDropdownOpen;
        },

        toggleShowMoreData() {
            this.showMoreData = !this.showMoreData;
            console.log("😵‍💫😵‍💫 showMoreData:", this.showMoreData);
        },


        updateCustomerData() {

            if (this.customerData?.data2) {
                this.formData.fullName = this.customerData.data2.nickname || this.customerData.data2.contact || '';
                this.formData.receiverName = this.customerData.data2.nickname | this.customerData.data2.contact || '';
                this.formData.customerCode = this.customerData.data2.customer_no || '';
                this.formData.phone = this.customerData.data2.mobile || '';
            } else {
                console.warn("😡 customerData หรือ data2 ไม่มีค่า:", this.customerData);
            }
            // this.formData.email = this.customerData.data.data2.email || '';
            // this.formData.address = this.customerData.data.data2.address || '';

        },

        updateDeliveryDate(newDate) {
            this.formData.deliveryDate = newDate;
            this.formData.sellDate = newDate; // ❌ อัปเดต sellDate ด้วย
        },

        // ใช้ได้แต่โหลดช้า
        async getProduct(page = 1) {

            // const getDataCustomer = JSON.parse(localStorage.getItem('selectDataCustomer') || 'null');

            // ใช้ 0 แทนถ้า level เป็น null หรือ undefined
            const level = this.customerData?.data.data2?.level ?? 0;
            // const level = getDataCustomer?.data2?.level ?? 0;

            console.log("log Create LeVel 643: ", level);

            try {
                // กำหนด pageSize ตามที่ user ต้องการ หรือเก็บไว้ใน data() แล้วส่งไป
                const raw = {
                    pageCurrent: page,
                    keywords: '',
                    level: level,
                    pageSize: this.pageSize // this.pageSize เช่น 30, 50 หรือ item_count
                };

                console.log("raw:", raw);
                //`${BASE_URL}/Goods2/product`
                const response = await axios.post(`${BASE_URL}/Goods2/product`, raw, {
                // const response = await axios.post(`${BASE_URL}/Goods2/product2f`, raw, {
                    headers: {
                        'Content-Type': 'application/json'
                    }
                });

                const data = response.data.data;

                console.log('📦 Loaded products:', data);

                // ❌ อย่าเพิ่งอัปเดต totalItems ถ้า status = false หรือไม่มีข้อมูล
                if (response.data.status === false || !data || !Array.isArray(data.data2)) {
                    console.warn('❌ Invalid data received from API:', data);
                    return; // 🛑 หยุดทำงานต่อ ไม่ต้องโหลดซ้ำ
                }

                // ✅ ค่อยอัปเดตเมื่อมั่นใจว่าข้อมูลมาถูกต้อง
                this.totalItems = data.item_count || 0;

                // เก็บจำนวนสินค้าทั้งหมดจาก API
                // this.totalItems = data.item_count || 0;

                // ถ้าคุณอยากโหลดสินค้าทั้งหมดในรอบเดียว ให้ตั้ง pageSize = totalItems แล้วโหลดใหม่
                // ตัวอย่าง: โหลดทั้งหมดในครั้งแรก
                if (page === 1 && this.pageSize !== this.totalItems) {
                    this.pageSize = this.totalItems;
                    // เรียกโหลดใหม่อีกครั้ง
                    return this.getProduct(1);
                }


                // เอาข้อมูลสินค้าที่ได้มาเก็บในตัวแปร
                this.Apiproducts = data.data2 || [];
                this.pageCurrent = page;

                console.log('📦 Loaded products:', this.Apiproducts);
                console.log('Total items:', this.totalItems);

            } catch (err) {
                const message = err.response?.data?.message || err.message || 'Unknown error';
                Swal.fire({ text: message, icon: 'error' });
            }
        },

        // ตัวอย่างการเรียกใช้ข้อมูลในฟังก์ชัน
        // async getProducts(page = 1) {
        //     const level = customerData.value?.data2?.level ?? 0;
        //     console.log("log Create LeVel 643: ", level);

        //     try {
        //         const res = await axios.get(`${BASE_URL}/your-endpoint?page=${page}&level=${level}`);
        //         console.log('📦 Product Data:', res.data);
        //     } catch (err) {
        //         console.error('❌ Error loading product:', err);
        //     }
        // },

        async validateForm() {
            this.formTouched = true; // ✅ เมื่อผู้ใช้กด "บันทึก" แล้วถือว่า touched
            this.errors = {}; // ล้างข้อผิดพลาดก่อนตรวจสอบใหม่
            let isValid = true;


            const requiredFields = {
                sellDate: 'วันที่ขาย',
                fullName: 'ชื่อลูกค้า',
                customerCode: 'รหัสลูกค้า',
                phone: 'เบอร์โทร',
                // address: 'ที่อยู่',
                receiverName: 'ชื่อผู้รับ',
                receiverPhone: 'เบอร์ผู้รับ',
                // receiverEmail: 'อีเมลผู้รับ',
                receiverAddress: 'ที่อยู่ผู้รับ',
                // deliveryType: 'ประเภทการจัดส่ง',
                deliveryDate: 'วันที่จัดส่ง',
                // trackingNo: 'เลขติดตาม',
                deliveryType: 'ประเภทการจัดส่ง'
            };


            console.log("Log Value requiredFields: ", requiredFields);

            // for (const field of requiredFields) {
            //     if (!this.formData[field]) {
            //         this.errors[field] = 'กรุณากรอกข้อมูลให้ครบถ้วน';
            //         isValid = false;
            //     }
            // }


            for (const [field, label] of Object.entries(requiredFields)) {
                const value = this.formData[field];
                // if (!value || (typeof value === 'string' && value.trim() === '')) {
                //     this.errors[field] = `กรุณากรอก${label}`;
                //     isValid = false;
                // }
                if (!value || value === '-' || (typeof value === 'string' && value.trim() === '')) {
                    this.errors[field] = `กรุณากรอก${label}`;
                    isValid = false;
                }
                this.isLoading = false;
            }

            // ตรวจสอบรายการสินค้า
            if (this.selectedProducts.length === 0) {
                Swal.fire({
                    text: 'กรุณาเพิ่มสินค้าอย่างน้อย 1 รายการ',
                    icon: 'warning'
                });
                isValid = false;
            } else {
                for (const product of this.selectedProducts) {
                    if (!product.pro_erp_title || !product.pro_quantity || product.pro_quantity <= 0 || !product.pro_unit_price || product.pro_unit_price <= 0) {
                        Swal.fire({
                            text: 'กรุณากรอกชื่อสินค้า, จำนวน, และมูลค่าต่อหน่วยให้ครบถ้วนและถูกต้องสำหรับทุกรายการสินค้า',
                            icon: 'warning'
                        });
                        isValid = false;
                        break;
                    }
                }
            }

            return isValid;
        },

        async saveDocument() {
            this.isLoading = true;

            console.log('Save new document')

            // console.log(ข้อมูลทั้งหมดใน formData:", this.formData);
            console.log("ข้อมูลทั้งหมดใน formData:", JSON.parse(JSON.stringify(this.formData)));

            const isValid = await this.validateForm();
            if (!isValid) {
                console.warn("❌ ข้อมูลไม่ครบ", this.errors);
                Swal.fire({
                    icon: 'error',
                    title: 'ไม่สามารถบันทึกได้',
                    text: 'กรุณากรอกข้อมูลให้ครบถ้วน',
                });
                this.isLoading = false;
                return;
            }

            // ดำเนินการบันทึกต่อ...
            console.log("กำลังบันทึกข้อมูล", this.formData);



            // เรียก API เพื่อสร้าง Document Running // เพิ่มข้อมูล DocumentRunning
            // let documentRunning = null;
            try {
                 this.isLoading = true;

                const docRunningPayload = {
                    warehouse_code: this.formData.warehouseCode || "H1",
                    doc_type: this.formData.docType || "SO"
                    // warehouse_code: "H1",      // สมมุติใช้คลัง H1
                    // doc_type: "SO"             // เอกสารขาย: Sale Order
                };

                const docResponse = await axios.post(
                    `${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/document_running/post_documentrunning.php`,
                    // `${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/post_documentrunning.php`,
                    docRunningPayload,
                    {
                        // headers: { 'Content-Type': 'application/json' }
                    }
                );

                this.documentRunning = docResponse.data; // ค่าที่จะเอามาใช้ prefix =>H1-SO25680625 prefix+RunNumber H1-SO25680625-00001

                // console.log("Log Value documentRunning: ", this.documentRunning);
                console.log("📄 ได้เลขเอกสาร:", this.documentRunning);

                if (!this.documentRunning.success) {
                    Swal.fire({ text: this.documentRunning.message, icon: 'error' });
                    return;
                }

                 this.isLoading = false;

            } catch (err) {
                const message = err.response?.data?.message || err.message || 'เกิดข้อผิดพลาดในการสร้างเลขเอกสาร';
                Swal.fire({ text: message, icon: 'error' });
                this.isLoading = false;
                return;
            }

            // ===> ใส่เลขเอกสารลงใน formData เช่น
            const list_code = this.documentRunning?.list_code; // H1-SO25680619
            this.formData.listCode = list_code; // เช่น H1-SO25680619
            console.log("Log Value listCodeData: ", list_code);

            const documentNo = this.documentRunning?.doc_number;// H1-SO25680619-0003 , run_number_formatteddaj get_products = localStorage.getItem('');
            this.formData.documentNo = documentNo;
            console.log("Log Value DocumentNo: ", documentNo);


            if (this.selectedProducts.length === 0) {
                Swal.fire({
                    text: 'กรุณาเพิ่มสินค้าอย่างน้อย 1 รายการ',
                    icon: 'warning'
                });
                return;
            }

            console.log("🔍 Selected Products: ", this.selectedProducts);

            for (const product of this.selectedProducts) {
                if (product.pro_erp_title) {
                    this.pro_erp_title = product.pro_erp_title;
                    this.formData.pro_erp_title = this.pro_erp_title;
                }
            }

            console.log("log value this.pro_erp_title:", this.pro_erp_title);

            //pro_name
            for (const product of this.selectedProducts) {
                if (!product.pro_erp_title || !product.pro_quantity || product.pro_quantity < 0 || !product.pro_unit_price || product.pro_unit_price < 0) {
                    Swal.fire({
                        text: 'กรุณากรอกชื่อสินค้า, จำนวน, และมูลค่าต่อหน่วยให้ครบถ้วนและถูกต้องสำหรับทุกรายการสินค้า',
                        icon: 'warning'
                    });
                    return; // หยุดการทำงานหากมีสินค้าที่ไม่สมบูรณ์
                }
            }


            this.formData.productList = this.selectedProducts.map(product => {

                const total = this.totalprice(product);

                return {
                    pro_sku_price_id: product.pro_id, //46764
                    // pro_id: product.pro_id,
                    pro_erp_title: product.pro_erp_title, //
                    pro_title: product.pro_title, //
                    pro_quantity: product.pro_quantity, //3
                    pro_goods_num: product.pro_quantity, // 3
                    pro_goods_id: product.pro_goods_id, // 3
                    pro_unit_price: product.pro_unit_price, // "315.00"
                    // pro_discount: this.formData.discount === 0 ? 0 : this.formData.discount,
                    pro_total_price: total, // รวมราคาต่อสินค้า
                    totalDiscount: this.formData.totalDiscount || 0, // รวมราคาต่อสินค้า
                    pro_discount: this.formData.discount || 0, // รวมราคาต่อสินค้า
                    pro_image: product.pro_images, //
                    pro_goods_sku_text: product.pro_goods_sku_text, //
                    pro_sn: product.pro_sn,//
                    prosn: product.prosn,//
                    st: product.st,
                    stock: product.stock,
                    pro_units: product.pro_units,//
                    activity_id: product.activity_id || 0, // เพิ่ม activity_id 0 ถ้าไม่มี
                    pro_activity_id: product.pro_activity_id || 0, // เพิ่ม pro_activity_id ถ้ามี
                    promotions: product.promotions || [],   // <= เพิ่มตรงนี้
                    // gifts: product.gifts || [], // <= เพิ่มตรงนี้
                    gifts: product.gifts.map(g => ({
                        ...g,
                        pro_goods_sku_text: g.color || g.pro_goods_sku_text || ''
                    }))
                };
            });


            console.log("🔍 log value this.productList:", this.formData.productList);

            this.formData.final_total_price = this.grandTotal;
            this.formData.vatVisible = this.isVathidden ? 1 : 0;

            const { promotions, gifts } = this.extractPromotionsAndGifts();
            this.formData.promotions = promotions;
            this.formData.gifts = gifts;

            // await this.AddressInsertData(this.selectedAddress);
            // this.formData.price_before_tax = parseFloat(this.totalAmountBeforeDiscount.toFixed(2));
            this.formData.price_before_tax = parseFloat(this.netAmountBeforeVat.toFixed(2));
            this.formData.tax_value = this.isVatIncluded ? parseFloat(this.vatAmount.toFixed(2)) : 0;
            // this.formData.tax_value = this.isVatIncluded ? parseFloat((this.totalAmountBeforeDiscount * 0.07).toFixed(2)) : 0;
            this.formData.price_with_tax = parseFloat(this.grandTotal.toFixed(2));
            // this.formData.price_with_tax = parseFloat(this.grandTotal);

            this.formData.final_total_price = parseFloat(this.grandTotal.toFixed(2));
            // this.formData.final_total_price = parseFloat(this.grandTotal);

             // ดึงค่าจาก localStorage
            const account = localStorage.getItem("account") || "";
            const nicknameAdmin = localStorage.getItem("nickname_admin") || "";
            const saleNo = localStorage.getItem("sale_no") || "";

            // เพิ่มเข้า formData
            this.formData.account = account;
            this.formData.nickname_admin = nicknameAdmin;
            this.formData.sale_no = saleNo;

            console.log("📝 Save with account/nickname/sale:", {
                account,
                nicknameAdmin,
                saleNo
            });

            const payload = new FormData();


            // for (const key in this.formData) {
            //     if (key === 'productList') {
            //         // แปลง array เป็น JSON string แล้วแนบ
            //         payload.append('productList', JSON.stringify(this.formData.productList));
            //     } else {
            //         payload.append(key, this.formData[key]);
            //     }
            // }

            for (const key in this.formData) {
                if (key === 'productList' || key === 'promotions' || key === 'gifts') { //|| key === 'receiverAddress'
                    payload.append(key, JSON.stringify(this.formData[key]));
                } else {
                    payload.append(key, this.formData[key]);
                }
            }

           if (
                (
                    (!this.selectedAddress || Object.keys(this.selectedAddress).length === 0) &&
                    (!this.selectedAddressBase || Object.keys(this.selectedAddressBase).length === 0)
                ) &&
                (!this.formData.receiverAddress || this.formData.receiverAddress.trim() === '')
            ) {
                Swal.fire({
                    icon: 'warning',
                    title: 'กรุณาเลือกที่อยู่จัดส่ง',
                });
                this.isLoading = false;
                return;
            }

            // ✅ เพิ่ม selectedAddress เข้าไป
            payload.append('deliveryAddress', JSON.stringify(this.selectedAddress || this.selectedAddressBase));

            // เพื่อมข้อมูล FormData
            try {
                this.isLoading = true;

                const response = await axios.post(`${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/sale_order/post_sale_order.php`, payload, {
                    // const response = await axios.post(`${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/post_sale_order.php`, payload, {
                    // headers: { 'Content-Type': 'application/json' },
                });

                console.log(" Log Value Data: ", response.data);

                const resData = typeof response.data === 'string' ? JSON.parse(response.data) : response.data;

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


                            // เก็บ deep copy
                            this.originalFormData = JSON.parse(JSON.stringify(this.formData));
                            this.originalSelectedProducts = JSON.parse(JSON.stringify(this.selectedProducts));

                            // เก็บ documentNo และ order_id ลง localStorage
                            localStorage.setItem('order_id', resData.order_id);
                            localStorage.setItem('newDocumentNo', resData.newDocumentNo);
                            localStorage.setItem('documentNo', this.formData.documentNo);

                            Swal.fire({ text: resData.message, icon: 'success' });
                            this.$router.push(`/saleList?documentNo=${this.formData.documentNo}`);
                            this.isReadOnly = true;
                            this.isLoading = false;
                } else {
                    Swal.fire({ text: 'asdadas', icon: 'error' });
                    console.log('resData', resData);
                    this.isLoading = false;
                }
                // if (resData.success) {
                //     // เก็บ documentNo ลง localStorage

                //     ///////////////////////////////////////////
                //     const order_ids = resData.order_id;
                //     console.log('✅ order_ids ✅: ', order_ids);
                //     const newDocumentNo = resData.newDocumentNo;
                //     console.log('newDocumentNo', newDocumentNo);

                //     localStorage.setItem('order_id', order_ids);
                //     localStorage.setItem('newDocumentNo', newDocumentNo);
                //     /////////////////////////////////////////////////////////

                //     const documentNo = this.formData.documentNo;
                //     localStorage.setItem('documentNo', documentNo);

                //     // เปลี่ยน URL ไปยัง saleList?documentNo=<documentNo>
                //     this.$router.push(`/saleList?documentNo=${documentNo}`);

                //     // ตั้งค่าให้ฟอร์มเป็น readonly
                //     this.isReadOnly = true;

                //     Swal.fire({ text: resData.message, icon: 'success' });

                //     this.isLoading = false;
                // } else {
                //     Swal.fire({ text: 'asdadas', icon: 'error' });
                //     console.log('resData', resData);
                //     this.isLoading = false;
                // }

                // this.selectedAddress = {
                //     id: data.DC_id,
                //     detail: data.DC_add1,
                //     province_id: this.findProvinceId(data.DC_add3),
                //     amphure_id: this.findAmphureId(data.DC_add2),
                //     tambon_id: this.findTambonId(data.DC_add2),
                //     phone: data.DC_tel,
                // };

                // await this.AddressInsertData(this.selectedAddress);

                // Swal.fire({ text: resData.message, icon: 'success' });
                this.isLoading = false;
            } catch (err) {
                const message = err.response?.data?.message || err.message || 'Unknown error';
                Swal.fire({ text: message, icon: 'error' });
                console.log('a454545654564 catch');
                this.isLoading = false;
            }

        },

        async getAuthToken() {
            // localStorage.removeItem("mac5_token");
            const tokenData = JSON.parse(localStorage.getItem("mac5_token")) || null;

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
                title: 'กำลังดำเนินการ...',
                text: 'กำลังเพิ่มข้อมูล (ครั้งแรกจะใช้เวลาสักครู่)',
                allowOutsideClick: false,
                didOpen: () => {
                    Swal.showLoading();
                }
            });

            // 🔄 ถ้าไม่มี token หรือหมดอายุ ให้ขอใหม่
            const secretKeyData = qs.stringify({
                secretKey1: import.meta.env.VITE_SECRET_KEY1,
                secretKey2: import.meta.env.VITE_SECRET_KEY2
            });

            try {
                const authResponse = await axios.post(`${BASE_URL_AUTH}`, secretKeyData, {
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    }
                });

                const token = authResponse.data.Token;
                if (!token) throw new Error("ไม่สามารถดึง token ได้");

                // 📝 บันทึก token และ timestamp ลง localStorage
                localStorage.setItem("mac5_token", JSON.stringify({
                    token,
                    timestamp: now
                }));

                Swal.close(); // ✅ ปิด Swal เมื่อเรียบร้อย
                return token;
            } catch (err) {
                Swal.fire({
                    icon: 'error',
                    title: 'ขอ Token ไม่สำเร็จ',
                    text: 'ไม่สามารถขอ token ได้ กรุณาลองใหม่อีกครั้ง',
                });
                this.isLoading = false;
                console.error("❌ ดึง token ไม่สำเร็จ:", err);
                throw err;
            }
        },

        async confirmFinalSave() {
            const result = await Swal.fire({
                title: 'คุณแน่ใจหรือไม่?',
                text: "หลังจากยืนยัน จะไม่สามารถแก้ไขข้อมูลนี้ได้อีก",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'ยืนยัน',
                cancelButtonText: 'ยกเลิก'
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
                    Swal.fire('ผิดพลาด', lockResponse.data.message, 'error');
                    return;
                }

                if (resData.success) {
                    this.isReadOnly = true;
                    this.isConfirmed = true;

                    // กันย้อนแก้ในเครื่องนี้ (optional)
                    const locked = JSON.parse(localStorage.getItem('lockedDocumentNos') || '[]');
                    if (!locked.includes(docNo)) {
                        locked.push(docNo);
                        localStorage.setItem('lockedDocumentNos', JSON.stringify(locked));
                    }

                    Swal.fire('สำเร็จ!', 'รายการถูกล็อกแล้ว', 'success');
                } else {
                    Swal.fire('ผิดพลาด', resData.message, 'error');
                }

            } catch (err) {
                const message = err.response?.data?.message || err.message || 'เกิดข้อผิดพลาด';
                Swal.fire('ผิดพลาด', message, 'error');
                this.isLoading = false;
            }

        },

        enableEditMode() {
            this.isReadOnly = false; // เปิดให้แก้ไขฟอร์ม
        },


        async updateDocument() {

            console.log('Update existing document')

            const isValid = await this.validateForm();
            if (!isValid) {
                Swal.fire({
                    icon: 'error',
                    title: 'ไม่สามารถบันทึกได้',
                    text: 'กรุณากรอกข้อมูลให้ครบถ้วน',
                });
                return;
            }

            // 🔍 ตรวจสอบว่ามีการเปลี่ยนแปลงหรือไม่
            if (!this.isDataChanged()) {
                Swal.fire({
                    icon: 'info',
                    title: 'ไม่มีข้อมูลเปลี่ยนแปลง',
                    text: 'คุณยังไม่ได้แก้ไขข้อมูลใด ๆ',
                });
                return;
            }

            try {

                this.isLoading = true;

                this.formData.productList = this.selectedProducts.map(product => {

                    const total = this.totalprice(product);

                    console.log('✅ check: product', product);

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
                        pro_goods_sku_text: product.pro_goods_sku_text, //
                        pro_sn: product.pro_sn,//
                        prosn: product.prosn,//
                        st: product.st,
                        stock: product.pro_stock || product.stock,
                        pro_units: product.pro_units,//
                        activity_id: product.activity_id || 0, // เพิ่ม activity_id 0 ถ้าไม่มี
                        pro_activity_id: product.pro_activity_id || 0, // เพิ่ม pro_activity_id ถ้ามี

                    };
                });


                console.log("🔍sadsadsa log value this.productList:", this.formData.productList)

                this.formData.final_total_price = this.grandTotal;
                this.formData.vatVisible = this.isVathidden ? 1 : 0;

                const { promotions, gifts } = this.extractPromotionsAndGifts();
                this.formData.promotions = promotions;
                this.formData.gifts = gifts;

                // **เพิ่มคำนวณภาษีและราคาก่อนส่ง
                this.formData.price_before_tax = parseFloat(this.netAmountBeforeVat.toFixed(2));
                // this.formData.price_before_tax = parseFloat(this.totalAmountBeforeDiscount.toFixed(2));
                this.formData.tax_value = this.isVatIncluded ? parseFloat(this.vatAmount.toFixed(2)) : 0;
                // this.formData.tax_value = this.isVatIncluded ? parseFloat((this.totalAmountBeforeDiscount * 0.07).toFixed(2)) : 0;
                this.formData.price_with_tax = parseFloat(this.grandTotal.toFixed(2));
                // this.formData.price_with_tax = parseFloat(this.grandTotal);

                this.formData.final_total_price = parseFloat(this.grandTotal.toFixed(2));
                // this.formData.final_total_price = parseFloat(this.grandTotal);

                const payload = new FormData();

                for (const key in this.formData) {
                    if (key === 'productList' || key === 'promotions' || key === 'gifts') {
                        payload.append(key, JSON.stringify([...this.formData[key]]));
                    } else {
                        payload.append(key, this.formData[key]);
                    }
                }

                if (!this.formData.receiverName) {
                    Swal.fire({
                        icon: 'warning',
                        title: 'กรุณาเลือกที่อยู่จัดส่ง',
                    });
                    return;
                }

                // ✅ เพิ่ม selectedAddress เข้าไป
                payload.append('deliveryAddress', JSON.stringify(this.selectedAddress || this.selectedAddressBase));

                console.log("🛒 productList:", this.formData.productList);
                console.log(JSON.stringify(payload))

                // return;

                const response = await axios.post(
                    `${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/sale_order/update_sale_order.php`,
                    // `${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/update_sale_order.php`,
                    payload
                );

                console.log("🔍 Response API :", response);

                const resData = typeof response.data === 'string' ? JSON.parse(response.data) : response.data;

                console.log("🔍 Response จาก API:", resData);

                if (resData.success) {

                    const order = resData.data.order;
                            const productList = resData.data.productList;
                            // const promotions = resData.data.promotions;
                            // const gifts = resData.data.gifts;
                            const deliveryAddress = resData.data.deliveryAddress;

                            console.log("📄 order data:", order);
                            console.log("🛒 productList:", productList);
                            // console.log("🎁 promotions:", promotions);
                            // console.log("🎁 gifts:", gifts);
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
                                // promotions: promotions || [],
                                // gifts: gifts || []
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

                    console.log("🔍 Response API newDocumentNo :", newDocumentNo);

                    this.formData.documentNo = newDocumentNo; // อัปเดต `documentNo` ใน `formData`

                    // อัปเดต URL ไปยัง `saleList` พร้อม `documentNo` ใหม่ sale-order/H1-SO25680726-00031
                    // this.$router.push(`/sale-order/${newDocumentNo}`);

                    this.$router.push(`/saleList?documentNo=${newDocumentNo}`);

                    Swal.fire({ text: resData.message, icon: 'success' });
                    this.isReadOnly = true; // ปิดการแก้ไขหลังบันทึกสำเร็จ
                } else {
                    Swal.fire({ text: resData.message, icon: 'error' });
                }
                // if (resData.success) {
                //     const newDocumentNo = resData.newDocumentNo; // ดึง `documentNo` ใหม่จาก API

                //     console.log("🔍 Response API newDocumentNo :", newDocumentNo);

                //     this.formData.documentNo = newDocumentNo; // อัปเดต `documentNo` ใน `formData`

                //     // อัปเดต URL ไปยัง `saleList` พร้อม `documentNo` ใหม่ sale-order/H1-SO25680726-00031
                //     // this.$router.push(`/sale-order/${newDocumentNo}`);

                //     this.$router.push(`/saleList?documentNo=${newDocumentNo}`);

                //     Swal.fire({ text: resData.message, icon: 'success' });
                //     this.isReadOnly = true; // ปิดการแก้ไขหลังบันทึกสำเร็จ
                // } else {
                //     Swal.fire({ text: resData.message, icon: 'error' });
                // }

                this.isLoading = false;

                // await this.AddressUpdaateData(this.selectedAddress);
            } catch (err) {
                const message = err.response?.data?.message || err.message || 'Unknown error';
                Swal.fire({ text: message, icon: 'error' });
                this.isLoading = false;
            }
        },

        // ฟังก์ชันเปรียบเทียบข้อมูล
        isDataChanged() {
            const isFormChanged = JSON.stringify(this.formData) !== JSON.stringify(this.originalFormData);
            const isProductChanged = JSON.stringify(this.selectedProducts) !== JSON.stringify(this.originalSelectedProducts);
            const isVatChanged = this.isVathidden !== this.originalIsVathidden;
            return isFormChanged || isProductChanged || isVatChanged;
        },


        async loadDocumentData(documentNo) {
            try {
                this.isLoading = true;

                const response = await axios.get(`${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/sale_order/get_sale_order.php?documentNo=${documentNo}`);

                console.log("😂 Log Value response: ", response);

                const resData = response.data;

                console.log("😂 Log Value resData: ", resData.data);

                if (resData.success) {
                    // เติมข้อมูลลงใน formData โดยรักษาฟิลด์ที่ไม่ได้อยู่ใน API
                    this.formData = {
                        ...this.formData, // เก็บค่าฟิลด์เดิมที่ไม่ได้อยู่ใน API
                        listCode: resData.data.order.list_code || '',
                        sellDate: resData.data.order.sell_date || '',
                        reference: resData.data.order.reference || '',
                        channel: resData.data.order.channel || '',
                        taxType: resData.data.order.tax_type || '',
                        fullName: resData.data.order.full_name || '',
                        customerCode: resData.data.order.customer_code || '',
                        phone: resData.data.order.phone || '',
                        email: resData.data.order.email || '',
                        address: resData.data.order.address || '',
                        receiverName: resData.data.order.receiver_name || '',
                        receiverPhone: resData.data.order.receiver_phone || '',
                        receiverEmail: resData.data.order.receiver_email || '',
                        receiverAddress: resData.data.order.receiver_address || '',
                        note: resData.data.order.note || '',
                        workDetail: resData.data.order.work_detail || '',
                        deliveryDate: resData.data.order.delivery_date || '',
                        trackingNo: resData.data.order.tracking_no || '',
                        deliveryType: resData.data.order.delivery_type || '',
                        totalDiscount: resData.data.order.total_discount || 0,
                        deliveryFee: resData.data.order.delivery_fee || 0,
                        final_total_price: resData.data.order.final_total_price || 0,
                        documentNo: resData.data.order.document_no || '',
                        vatVisible: resData.data.order.vat_visible || 'ไม่มีค่าDCM',

                        //
                        promotions: resData.data.promotions || [],
                        gifts: resData.data.gifts || []
                        // this.formData.promotions = resData.data.promotions || [],
                        // this.formData.gifts = resData.data.gifts || []
                    };

                    this.isVathidden = !!Number(resData.data.order.vat_visible);
                    this.originalIsVathidden = this.isVathidden; // เก็บค่าเดิมไว้เปรียบเทียบ
                    // เติมข้อมูลสินค้า
                    // this.selectedProducts = resData.data.productList || [];

                    console.log("📄 ข้อมูลเอกสารที่โหลด:", resData.data.productList);

                    // const getSite_id = resData.data.data.deliveryAddress;
                    // console.log("📄 ข้อมูล Docmentที่โหลด:", getSite_id);

                    console.log("🔍 ก่อน map this.selectedProducts:", this.selectedProducts);

                    this.selectedProducts = resData.data.productList.map(product => {

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
                            pro_images: product.pro_image,
                            prosn: product.sn,
                            pro_sn: product.pro_sn,
                            st: product.st,
                            pro_stock: product.stock || 0,
                            pro_unit: product.pro_units || '',
                            // pro_unit: product.unit || '',
                            activity_id: product.activity_id || 0,
                            pro_activity_id: product.pro_activity_id || 0, // ✅ ใช้ชื่อนี้ให้ตรง backend
                            pro_goods_sku_text: product.pro_goods_sku_text || '',
                            // pro_sku_pricr_id: product.pro_sku_pricr_id || '',
                            // promotions: matchedPromotions,
                            // gifts: matchedGifts
                            // ✅ ดึงจาก product โดยตรง
                            promotions: product.promotions || [],
                            gifts: product.gifts || []
                            // gifts: product.gifts.map(g => ({
                            //     ...g,
                            //     pro_goods_sku_text: g.pro_goods_sku_text || g.color || ''
                            // }))
                        };

                        console.log("🎁 productObj:", productObj); // <--- สำคัญ
                        return productObj;

                    });

                    console.log("📄 ข้อมูลเอกสารที่โหลด:", this.formData);
                    console.log("🛒 รายการสินค้า:", this.selectedProducts)

                    this.originalFormData = JSON.parse(JSON.stringify(this.formData)); // deep copy
                    this.originalSelectedProducts = JSON.parse(JSON.stringify(this.selectedProducts));


                    this.isLoading = false;

                } else {
                    Swal.fire({ text: resData.message, icon: 'error' });
                    this.isLoading = false;
                }
            } catch (err) {
                const message = err.response?.data?.message || err.message || 'เกิดข้อผิดพลาดในการโหลดข้อมูลเอกสาร';
                Swal.fire({ text: message, icon: 'error' });
                this.isLoading = false;
            }
        },

        async getAuthTokenAddress() {
            // localStorage.removeItem("mac5_token");
            const tokenData = JSON.parse(localStorage.getItem("token_userlogin")) || null;

            console.log('Check tokenData :', tokenData);

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

            try {
                const authResponse = await axios.post(
                    `${BASE_URL_C_SHARP}/api/Users/Login`, //https://backend2.d-power.online:58915
                    {
                        username: "DPower1", // ใส่จริงตรงนี้
                        password: "1234", // หรือใช้จาก .env ก็ได้
                    },
                    {
                        headers: {
                            "Content-Type": "application/json",
                        },
                    }
                );

                console.log("authResponse 🔑 Token :", authResponse);

                const token = authResponse.data.token;
                if (!token) throw new Error("ไม่สามารถดึง token ได้");

                // 📝 บันทึก token และ timestamp ลง localStorage
                localStorage.setItem(
                    "token_userlogin",
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



        async loadCustomerAddresses() {
            try {
                const token = await this.getAuthTokenAddress(); // ดึง token

                console.log("Check this.customerData:", this.customerData);
                // console.log('Check this.customerDataRow:',this.customerDataRow);

                const customerNo = this.customerData?.data2.customer_no || ""; // ดึงจาก localStorage หรือ prop
                console.log("Check customerNo: ", customerNo);

                const response = await axios.post(
                    `${BASE_URL_C_SHARP}/api/AddressCustomers`, // `${BASE_URL_C_SHARP}/api/Users/Login`, //https://backend2.d-power.online:58915
                    qs.stringify({ CustomerCode: customerNo }),
                    {
                        headers: {
                            Authorization: `Bearer ${token}`,
                            "Content-Type": "application/x-www-form-urlencoded",
                        },
                    }
                );

                console.log("Check response.data: ", response.data);

                const addressList = response.data || [];

                // ✅ ถ้ามี defaultAddress == 1 ให้เลือกอัตโนมัติ
                const defaultAddr = addressList.find(addr => addr.defaultAddress === 1);
                if (defaultAddr) {
                    // this.selectedAddressId = defaultAddr.id;
                    this.formData.receiverAddress = defaultAddr.address;
                    this.formData.address = defaultAddr.address;
                    this.formData.receiverPhone = this.customerData?.data2.mobile || '-';
                }

            } catch (err) {
                console.error("❌ โหลดข้อมูลที่อยู่ล้มเหลว:", err);
                Swal.fire({
                    icon: "error",
                    title: "โหลดที่อยู่ไม่สำเร็จ",
                    text: "ไม่สามารถโหลดข้อมูลที่อยู่ของลูกค้าได้",
                });
            }
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


        // ใช้งานได้ดีเลย
        // new function and old function
        // extractPromotionsAndGifts() {
        //     const grouped = this.groupByActivityId(this.selectedProducts);
        //     const allPromotions = [];
        //     const allGifts = [];

        //     for (const group of Object.values(grouped)) {
        //         if (group[0].promotions && Array.isArray(group[0].promotions)) {

        //             for (const promo of group[0].promotions) {

        //                 allPromotions.push({

        //                     title: promo.title,
        //                     ML_Note: promo.ML_Note || '',
        //                     note: promo.note || '',
        //                     pro_activity_id: promo.pro_activity_id || 0,
        //                     activity_id: promo.pro_activity_id || 0,
        //                     pro_sn: promo.pro_sn,
        //                     prosn: promo.prosn,
        //                     pro_goods_id: promo.pro_goods_id || 0,
        //                     pro_goods_num: promo.pro_goods_num || promo.pro_quantity || 0,
        //                     pro_image: promo.pro_image || '',
        //                     pro_sku_price_id: promo.pro_sku_price_id || 0,
        //                     user_id: promo.user_id || 0,
        //                     st: promo.st,
        //                     stock: promo.stock,

        //                 });
        //             }
        //         }

        //         if (group[0].gifts && Array.isArray(group[0].gifts)) {
        //             for (const gift of group[0].gifts) {

        //                 console.log("🎁 gift:", gift); // <--- log gift object
        //                 console.log("🎁 gift.pro_goods_num:", gift.pro_goods_num); // <--- log gift object
        //                 console.log("🎁 gift.pro_quantity:", gift.pro_quantity); // <--- log gift object

        //                 allGifts.push({
        //                     title: gift.title,
        //                     // pro_goods_num: gift.pro_goods_num || 0,
        //                     pro_goods_num: gift.pro_goods_num || gift.pro_quantity || 0,
        //                     pro_image: gift.pro_image || '',
        //                     ML_Note: gift.ML_Note || '',
        //                     note: gift.note || '',
        //                     pro_activity_id: gift.pro_activity_id || 0,
        //                     activity_id: gift.pro_activity_id || 0,
        //                     pro_sn: gift.pro_sn,
        //                     prosn: gift.prosn,
        //                     pro_goods_id: gift.pro_goods_id || 0,
        //                     pro_sku_price_id: gift.pro_sku_price_id || 0,
        //                     user_id: gift.user_id || 0,
        //                     st: gift.st,
        //                     stock: gift.stock,
        //                 });
        //             }
        //         }
        //     }

        //     return {
        //         promotions: allPromotions,
        //         gifts: allGifts
        //     };
        // },

        //
        // addSelectedProducts(products) {
        //     products.forEach(p => {
        //         const alreadyExists = this.selectedProducts.some(sp => sp.pro_id === p.pro_id);
        //         if (!alreadyExists) {
        //             // this.selectedProducts.push(p);
        //             this.selectedProducts.push({
        //                 pro_id: p.pro_id,
        //                 pro_erp_title: p.pro_erp_title,
        //                 pro_sn: p.pro_sn,
        //                 pro_images: p.pro_images,
        //                 pro_quantity: p.pro_quantity || 1,
        //                 pro_unit_price: p.pro_unit_price,
        //                 pro_unit: p.pro_unit,
        //                 pro_stock: p.pro_stock,
        //                 pro_goods_sku_text: p.pro_goods_sku_text,
        //                 promotions: p.promotions || [],
        //                 gifts: p.gifts || [],
        //                 activity_id: p.activity_id ?? 0,
        //                 st: p.st ?? 0
        //             });
        //         }
        //     });
        // },


        SelectedPromotion(promotionData) {
            console.log('รับโปรโมชั่นจาก child:', promotionData)

            this.selectedPromotion = promotionData
            this.showPromotionSelector = false
            console.log('ปิด popup 1')

            setTimeout(() => {
                this.showPromotionProductSelector = true
                console.log('เปิด popup 2')
            }, 100)
        },

        handleAddressSelected(data) {
            // async handleAddressSelected(data) {
            console.log('📍 ที่อยู่ที่เลือก:', data);
            const { DC_add1, DC_add2, DC_add3, DC_tel } = data
            const fullAddress = `${DC_add1}, ${DC_add2}, ${DC_add3}, เบอร์โทร: ${DC_tel}`
            this.selectedAddress = fullAddress

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
                DC_zone: data.DC_zone || '',
            };

            // ✅ แสดงผลใน UI
            this.formData.receiverAddress = fullAddress;
            this.formData.address = fullAddress;
            this.formData.receiverPhone = DC_tel;
            console.log('📍 ที่อยู่ที่เลือกใหม่:', this.formData.receiverAddress);
            console.log('📍object ที่อยู่ที่เลือกใหม่:', this.selectedAddress);

            // 📌 ใส่ไว้ใน saveDocument()
            // await this.saveDocument(addressData);
        },

        handleAddressSelectedBase(data) {
            // async handleAddressSelected(data) {
            console.log('📍 ที่อยู่ที่เลือก:', data);
            const { DC_add1, DC_tel } = data  //DC_add2, DC_add3,
            const fullAddress = `${DC_add1},  เบอร์โทร: ${DC_tel}` //${DC_add2}, ${DC_add3},
            this.selectedAddressBase = fullAddress

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
                DC_zone: data.DC_zone || '',
            };

            // ✅ แสดงผลใน UI
            this.formData.receiverAddress = fullAddress;
            this.formData.address = fullAddress;
            this.formData.receiverPhone = DC_tel;
            console.log('📍 ที่อยู่ที่เลือกเดิม:', this.formData.receiverAddress);
            console.log('📍object ที่อยู่ที่เลือกเดิม:', this.selectedAddressBase);

            // 📌 ใส่ไว้ใน saveDocument()
            // await this.saveDocument(addressData);
        },

        handleBackToPromotion() {
            this.showPromotionProductSelector = false

            // 🔁 ใช้ delay เล็กน้อยเพื่อให้ UI สลับได้ลื่นขึ้น
            setTimeout(() => {
                this.showPromotionSelector = true
            }, 100)
        },

        // //handleSelectedProducts
        async addSelectedProductsWithmonth(payload) {
            console.log('📦 payload ที่ได้รับ ที่ได้รับจาก Promotion_ProductSelector:', payload);

            // this.selectedProducts = [];

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

            //  ถ้าต้องการเก็บค่ารวมรายเดือนไว้ใช้ต่อ
            if (datasumdiscount.sum_pro_month !== undefined) {
                this.formData.sumProMonth = datasumdiscount.sum_pro_month;
                console.log("🧾 sum_pro_month:", this.formData.sumProMonth);
            }

            console.log("✅ payload:", payload);

            console.log("✅ Items:", items);
            console.log("✅ Gifts:", giftsDay);
            console.log("✅ Promotions:", promotions);
            console.log("✅ EmitTitles:", emitTitles);


            for (const item of items) {

                const activityId = item.st === false ? false : item.pro_activity_id;
                const matchedTitle = emitTitles.find(emit => emit.pro_goods_id == item.pro_goods_id && emit.pro_sku_price_id == item.pro_sku_price_id) || {};
                const matchedTitle_erp_title_zero = emitTitles.find(emit => emit.pro_goods_id == item.pro_goods_id && emit.pro_sn == item.prosn) || {};


                // eslint-disable-next-line no-unused-vars
                const fullActivityGifts = giftsDay.filter(gift => gift.pro_activity_id === item.pro_activity_id && gift.st === item.st);
                // eslint-disable-next-line no-unused-vars
                const fullActivityPromotions = promotions.filter(promo => promo.pro_activity_id === item.pro_activity_id && promo.st === item.st)


                const FinalPromotions = promotions.filter(promo => {
                    const stMatch = promo.st === item.st;

                    if (item.st === true) {
                        return stMatch && promo.pro_activity_id === item.pro_activity_id;
                    } else {
                        return stMatch;
                    }
                });

                const FinalGifts = giftsDay.filter(gift => {
                    const stMatch = gift.st === item.st;

                    if (item.st === true) {
                        return stMatch && gift.pro_activity_id === item.pro_activity_id;
                    } else {
                        return stMatch;
                    }
                });





                // ✅ แปลงให้เรียบร้อยก่อน
                item.pro_id = parseInt(item.pro_id) || 0;
                item.pro_sku_price_id = parseInt(item.pro_sku_price_id) || 0;
                item.st = Boolean(item.st);

                console.log("sss Chack item.st: ", item.st);


                // หา item ที่ pro_sn เดียวกันแต่ activity ต่างกัน
                const similarItem = this.selectedProducts.find(sp =>
                    sp.pro_sn == (matchedTitle.pro_sn || item.pro_sn) &&
                    sp.activity_id != activityId &&
                    sp.st != item.st
                );

                const activity_id_ItemIsok = this.selectedProducts.find(sp =>
                    sp.pro_sn == (matchedTitle.pro_sn || item.pro_sn) &&
                    sp.activity_id != activityId &&
                    sp.st == item.st
                );

                const activity_id_ItemIs_Not_ok = this.selectedProducts.find(sp =>
                    sp.pro_id == item.pro_sku_price_id &&
                    sp.activity_id == activityId &&
                    // sp.st !== item.st
                    Boolean(sp.st) != Boolean(item.st)// different st
                );

                //หา item ที่ activity_id เดียวกันและ st เหมือนกัน
                const alreadyExists = this.selectedProducts.find(sp =>
                    sp.pro_id == item.pro_sku_price_id &&
                    sp.activity_id == activityId &&
                    sp.st == item.st
                );


                console.log("✅ this.selectedProducts:", this.selectedProducts);
                console.log("✅ this.selectedProducts.length === 0:", this.selectedProducts.length === 0);

                const caseType = (() => {

                    if (this.selectedProducts.length === 0) return 'EMPTY';
                    if (activity_id_ItemIs_Not_ok) return 'ACTIVITY_ID_ITEM_IS_Not_OK';
                    if (activity_id_ItemIsok) return 'ACTIVITY_ID_ITEM_ISOK';
                    if (similarItem) return 'SIMILAR_SN_DIFFERENT_ACTIVITY';
                    if (alreadyExists) return 'EXISTS';
                    return 'NEW';
                    // New
                    // if (normalEntry && promoEntry) return 'MERGE_NORMAL_PROMO';
                    // New
                    // if (normalEntry && !item.st) return 'EXISTS_NORMAL';
                    // if (promoEntry && item.st) return 'EXISTS_PROMO';
                    // if (this.selectedProducts.length === 0) return 'EMPTY';
                    // if (alreadyExists) return 'EXISTS';
                    // // if (alreadyExists2) return 'EXISTS2';
                    // if (activity_id_ItemIs_Not_ok) return 'ACTIVITY_ID_ITEM_IS_Not_OK';
                    // if (activity_id_ItemIsok) return 'ACTIVITY_ID_ITEM_ISOK';
                    // // if (similarItem || alreadyExists) return 'ACTIVITY_NOT_LOOP';
                    // if (similarItem) return 'SIMILAR_SN_DIFFERENT_ACTIVITY';


                    // return 'NEW';
                })();

                switch (caseType) {

                    case 'EMPTY':
                    case 'NEW':
                        this.selectedProducts.push({
                            item_id: 0,
                            pro_id: item.pro_sku_price_id,
                            activity_id: activityId,
                            pro_activity_id: item.pro_activity_id,
                            pro_goods_id: item.pro_goods_id,
                            // i:1,
                            // pro_activity_id: item.pro_activity_id,
                            st: item.st,
                            pro_erp_title: matchedTitle.pro_erp_title === 0 ? matchedTitle.pro_title : matchedTitle.pro_erp_title || item.pro_erp_title || matchedTitle_erp_title_zero.pro_erp_title,
                            pro_title: matchedTitle.pro_title || matchedTitle_erp_title_zero.pro_erp_title,
                            // pro_erp_title: matchedTitle.pro_erp_title && matchedTitle.pro_erp_title === 0 || item.pro_erp_title || '',
                            pro_unit_price: item.pro_goods_price || '',
                            // pro_goods_sku_text: item.pro_goods_sku_text || '',
                            pro_goods_sku_text: item.color || item.pro_goods_sku_text || '',
                            pro_sn: matchedTitle.pro_sn || item.pro_sn || item.prosn,
                            prosn: item.prosn || '',
                            pro_images: item.pro_image || '',
                            pro_goods_price: item.pro_goods_price || '',
                            pro_image: item.pro_image || '',
                            pro_quantity: item.pro_goods_num || 0,
                            pro_goods_num: item.pro_goods_num || 0,
                            pro_units: matchedTitle.pro_units || item.pro_units || '',
                            pro_stock: matchedTitle.stock || item.stock || 0,
                            pro_sku_price_id: item.pro_sku_price_id,
                            // กรองเฉพาะของที่ activity_id ตรงกัน
                            gifts: FinalGifts,
                            promotions: FinalPromotions,

                        });
                        console.log('NEW || EMPTY');
                        break;

                    case 'SIMILAR_SN_DIFFERENT_ACTIVITY':
                        // 1) เปลี่ยน activity_id ของรายการเดิมให้ตรงกับตัวใหม่
                        Object.assign(similarItem, {
                            activity_id: activityId,
                            st: item.st,
                            pro_goods_num: item.pro_goods_num,
                            pro_quantity: item.pro_goods_num,
                            // 2) อัปเดต promotions/gifts
                            promotions: FinalPromotions,
                            gifts: FinalGifts,
                            // … field อื่นๆ ตามที่ต้องการ
                        });
                        console.log('SIMILAR_SN_DIFFERENT_ACTIVITY: ย้ายไป activity ใหม่ พร้อมโหลด promotions');
                        Swal.fire({
                            icon: 'info',
                            title: 'อัปเดตโปรโมชั่นสำเร็จ',
                            text: `ปรับข้อมูล ${matchedTitle.pro_erp_title || item.pro_title} เป็น st=${item.st}`,
                            showConfirmButton: false,
                            timer: 1500
                        });
                        break;


                    case 'EXISTS':
                        Object.assign(alreadyExists, {
                            ...item,
                            pro_id: item.pro_sku_price_id,
                            activity_id: activityId,
                            pro_quantity: item.pro_goods_num,
                            pro_goods_num: item.pro_goods_num,
                            pro_goods_sku_text: item.color || item.pro_goods_sku_text || '',
                            pro_goods_price: item.pro_goods_price || '',
                            pro_image: item.pro_image || '',
                            gifts: FinalGifts,
                            promotions: FinalPromotions

                            // เพิ่มค่าอื่น ๆ ที่จำเป็น
                        });

                        console.log('EXISTS');

                        Swal.fire({
                            icon: 'info',
                            title: 'เพิ่มจำนวนข้อมูลสินค้าสำเร็จ',
                            text: `เพิ่มข้อมูลสินค้าเรียบร้อย ${matchedTitle.pro_erp_title || item.pro_title || ''}`,
                            showConfirmButton: false,
                            timer: 2000, // ปิดอัตโนมัติใน 2 วินาที (2000 มิลลิวินาที)
                            timerProgressBar: true
                        });
                        break;
                    case 'EXISTS2':
                        // eslint-disable-next-line no-undef
                        Object.assign(alreadyExists2, {
                            ...item,
                            pro_id: item.pro_sku_price_id,
                            activity_id: activityId,
                            pro_quantity: item.pro_goods_num,
                            pro_goods_num: item.pro_goods_num,
                            pro_goods_sku_text: item.color || item.pro_goods_sku_text || '',
                            gifts: FinalGifts,
                            promotions: FinalPromotions

                            // เพิ่มค่าอื่น ๆ ที่จำเป็น
                        });

                        console.log('alreadyExists2');

                        Swal.fire({
                            icon: 'info',
                            title: 'เพิ่มจำนวนข้อมูลสินค้าสำเร็จ',
                            text: `เพิ่มข้อมูลสินค้าเรียบร้อย ${matchedTitle.pro_erp_title || item.pro_title || ''}`,
                            showConfirmButton: false,
                            timer: 2000, // ปิดอัตโนมัติใน 2 วินาที (2000 มิลลิวินาที)
                            timerProgressBar: true
                        });
                        break;
                    case 'ACTIVITY_ID_ITEM_ISOK':
                        Object.assign(activity_id_ItemIsok, {
                            ...item,
                            pro_id: item.pro_sku_price_id,
                            activity_id: activityId,
                            pro_quantity: item.pro_goods_num,
                            pro_goods_num: item.pro_goods_num,
                            pro_goods_sku_text: item.color || item.pro_goods_sku_text || '',
                            pro_goods_price: item.pro_goods_price || '',
                            pro_image: item.pro_image || '',
                            gifts: FinalGifts, //fullActivityGifts ||
                            promotions: FinalPromotions, //
                            // เพิ่มค่าอื่น ๆ ที่จำเป็น
                        });

                        console.log('ACTIVITY_ID_ITEM_ISOK');

                        Swal.fire({
                            icon: 'info',
                            title: 'เพิ่มจำนวนข้อมูลสินค้าสำเร็จ',
                            text: `เพิ่มข้อมูลสินค้าเรียบร้อย ${matchedTitle.pro_title || item.pro_erp_title || ''}`,
                            showConfirmButton: false,
                            timer: 2000, // ปิดอัตโนมัติใน 2 วินาที (2000 มิลลิวินาที)
                            timerProgressBar: true
                        });
                        break;

                    case 'ACTIVITY_ID_ITEM_IS_Not_OK':
                        Object.assign(activity_id_ItemIs_Not_ok, {
                            ...item,
                            pro_id: item.pro_sku_price_id,
                            activity_id: activityId,
                            pro_quantity: item.pro_goods_num,
                            pro_goods_num: item.pro_goods_num,
                            pro_goods_sku_text: item.color || item.pro_goods_sku_text || '',
                            pro_goods_price: item.pro_goods_price || '',
                            pro_image: item.pro_image || '',
                            gifts: FinalGifts, //fullActivityGifts ||
                            promotions: FinalPromotions, //
                            // เพิ่มค่าอื่น ๆ ที่จำเป็น
                        });

                        console.log('ACTIVITY_ID_ITEM_IS_Not_OK');

                        Swal.fire({
                            icon: 'info',
                            title: 'เพิ่มข้อมูลสินค้าสำเร็จ',
                            text: `เพิ่มสินค้าเรียบร้อย ${matchedTitle.pro_title || item.pro_erp_title || ''}`,
                            showConfirmButton: false,
                            timer: 2000, // ปิดอัตโนมัติใน 2 วินาที (2000 มิลลิวินาที)
                            timerProgressBar: true
                        });

                        console.log('เพิ่มข้อมูลสินค้า ต่าง st สำเร็จ');
                        break;

                }
            }

            console.log("📋 รายการสินค้าในตาราง:", this.selectedProducts);

        },

        async handleSelectedPromotionProducts(payload) {
            console.log('📦 payload ที่ได้รับ ที่ได้รับจาก Promotion_ProductSelector:', payload);

              // 🔴 วิธีแก้ไข: เคลียร์ Array เก่าออกก่อนเสมอ
            this.selectedProducts = [];
            // หรือใช้ this.selectedProducts.length = 0; ก็ได้

            const items = payload.items || [];
            // const gifts = payload.gifts || [];
            const giftsDay = payload.gifts || [];
            const promotions = payload.promotions || [];
            // const promotionsmonth = payload.promotionsmonth || [];
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


            // ✅ ถ้าคุณต้องการเก็บค่ารวมรายเดือนไว้ใช้ต่อ
            if (datasumdiscount.sum_pro_month !== undefined) {
                this.formData.sumProMonth = datasumdiscount.sum_pro_month;
                console.log("🧾 sum_pro_month:", this.formData.sumProMonth);
            }

            console.log("✅ payload:", payload);
            console.log("✅ Items:", items);
            console.log("✅ Gifts:", giftsDay);
            console.log("✅ Promotions:", promotions);
            console.log("✅ EmitTitles:", emitTitles);

            for (const item of items) {
                //
                const activityId = item.pro_activity_id;
                // const activityId = item.st === false ? false : item.pro_activity_id;
                const matchedTitle = emitTitles.find(emit => emit.pro_goods_id == item.pro_goods_id && emit.pro_sku_price_id == item.pro_sku_price_id) || {};


                // eslint-disable-next-line no-unused-vars
                const fullActivityGifts = giftsDay.filter(gift => gift.pro_activity_id === item.pro_activity_id && gift.st === item.st);
                // eslint-disable-next-line no-unused-vars
                const fullActivityPromotions = promotions.filter(promo => promo.pro_activity_id === item.pro_activity_id && promo.st === item.st)

                const FinalPromotions = promotions.filter(promo => {
                    const stMatch = promo.st === item.st;

                    if (item.st === true) {
                        return stMatch && promo.pro_activity_id === item.pro_activity_id;
                    } else {
                        return stMatch;
                    }
                });

                const FinalGifts = giftsDay.filter(gift => {
                    const stMatch = gift.st === item.st;

                    if (item.st === true) {
                        return stMatch && gift.pro_activity_id === item.pro_activity_id;
                    } else {
                        return stMatch;
                    }
                });




                // ✅ แปลงให้เรียบร้อยก่อน
                item.pro_id = parseInt(item.pro_id) || 0;
                item.pro_sku_price_id = parseInt(item.pro_sku_price_id) || 0;
                item.st = Boolean(item.st);

                console.log("sss Chack item.st: ", item.st);

                const hasSimilarItemButDifferentActivityAndSt = this.selectedProducts.find(sp =>
                    sp.pro_sn === item.pro_sn &&
                    sp.pro_sku_price_id === item.pro_sku_price_id &&
                    sp.pro_activity_id !== item.pro_activity_id &&
                    Boolean(sp.st) !== Boolean(item.st)
                );


                // หา item ที่ pro_sn เดียวกันแต่ activity ต่างกัน
                const similarItem = this.selectedProducts.find(sp =>
                    sp.pro_sn === (matchedTitle.pro_sn || item.pro_sn) &&
                    sp.activity_id !== activityId &&
                    // sp.st !== item.st
                    Boolean(sp.st) !== Boolean(item.st)
                );

                const activity_id_ItemIsok = this.selectedProducts.find(sp =>
                    sp.pro_sn === (matchedTitle.pro_sn || item.pro_sn) &&
                    sp.activity_id !== activityId &&
                    sp.st === item.st
                );

                const activity_id_ItemIs_Not_ok = this.selectedProducts.find(sp =>
                    sp.pro_id === item.pro_sku_price_id &&
                    sp.activity_id === activityId &&
                    // sp.st !== item.st
                    Boolean(sp.st) !== Boolean(item.st)// different st
                );

                //หา item ที่ activity_id เดียวกันและ st เหมือนกัน
                const alreadyExists = this.selectedProducts.find(sp =>
                    sp.pro_id === item.pro_sku_price_id &&
                    sp.activity_id === activityId &&
                    Boolean(sp.st) === Boolean(item.st)
                );


                console.log("✅ this.selectedProducts:", this.selectedProducts);
                console.log("✅ this.selectedProducts.length === 0:", this.selectedProducts.length === 0);

                const caseType = (() => {

                    if (this.selectedProducts.length === 0) return 'EMPTY';
                    if (hasSimilarItemButDifferentActivityAndSt) return 'DIFFERENT_ACTIVITY_AND_ST';

                    if (activity_id_ItemIs_Not_ok) return 'ACTIVITY_ID_ITEM_IS_Not_OK';
                    if (activity_id_ItemIsok) return 'ACTIVITY_ID_ITEM_ISOK';

                    if (alreadyExists) return 'EXISTS';
                    return 'NEW';

                    // New
                    // if (normalEntry && promoEntry) return 'MERGE_NORMAL_PROMO';
                    // New
                    // if (normalEntry && !item.st) return 'EXISTS_NORMAL';
                    // if (promoEntry && item.st) return 'EXISTS_PROMO';
                    // if (similarItem) return 'SIMILAR_SN_DIFFERENT_ACTIVITY';
                    // if (this.selectedProducts.length === 0) return 'EMPTY';
                    // if (alreadyExists) return 'EXISTS';
                    // // if (alreadyExists2) return 'EXISTS2';
                    // if (activity_id_ItemIs_Not_ok) return 'ACTIVITY_ID_ITEM_IS_Not_OK';
                    // if (activity_id_ItemIsok) return 'ACTIVITY_ID_ITEM_ISOK';
                    // // if (similarItem || alreadyExists) return 'ACTIVITY_NOT_LOOP';
                    // if (similarItem) return 'SIMILAR_SN_DIFFERENT_ACTIVITY';
                    // return 'NEW';
                })();

                switch (caseType) {
                    // New
                    // case 'MERGE_NORMAL_PROMO':
                    //     // combine quantities from normal + promo, keep promo metadata
                    //     const totalQty = normalEntry.pro_goods_num + promoEntry.pro_goods_num;
                    //     Object.assign(promoEntry, {
                    //         pro_goods_num: totalQty,
                    //         pro_quantity: totalQty,
                    //         // mark as promo
                    //         st: true,
                    //         activity_id: promoEntry.activity_id,
                    //         pro_activity_id: promoEntry.pro_activity_id
                    //     });
                    //     // remove the normal entry
                    //     this.selectedProducts = this.selectedProducts.filter(sp => sp !== normalEntry);
                    //     break;
                    case 'EMPTY':
                    case 'NEW':
                        this.selectedProducts.push({
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
                            pro_goods_price: item.pro_goods_price || '',
                            pro_goods_sku_text: item.color || item.pro_goods_sku_text || '',
                            // pro_goods_sku_text: item.pro_goods_sku_text || '',
                            pro_sn: matchedTitle.pro_sn || item.pro_sn || '',
                            prosn: item.prosn || '',
                            pro_images: item.pro_image || '',
                            pro_image: item.pro_image || '',
                            pro_quantity: item.pro_goods_num || 0,
                            pro_goods_num: item.pro_goods_num || 0,
                            pro_units: matchedTitle.pro_units || item.pro_units || '',
                            pro_stock: matchedTitle.stock || item.stock,
                            // pro_stock: item.stock || 0,

                            pro_sku_price_id: item.pro_sku_price_id,

                            // กรองเฉพาะของที่ activity_id ตรงกัน
                            gifts: FinalGifts,
                            promotions: FinalPromotions,
                        });
                        console.log('NEW || EMPTY');
                        break;

                    case 'DIFFERENT_ACTIVITY_AND_ST':
                        this.selectedProducts.push({
                            item_id: 0,
                            pro_id: item.pro_sku_price_id,
                            activity_id: activityId,
                            pro_activity_id: item.pro_activity_id,
                            pro_goods_id: item.pro_goods_id,
                            st: item.st,
                            pro_erp_title: matchedTitle.pro_erp_title || item.pro_erp_title || '',
                            pro_title: matchedTitle.pro_title || item.pro_title || '',
                            pro_unit_price: item.pro_goods_price || '',
                            pro_goods_price: item.pro_goods_price || '',
                            // pro_goods_sku_text: item.pro_goods_sku_text || '',
                            pro_goods_sku_text: item.color || item.pro_goods_sku_text || '',
                            pro_sn: matchedTitle.pro_sn || item.pro_sn || '',
                            prosn: item.prosn || '',
                            pro_images: item.pro_image || '',
                            pro_image: item.pro_image || '',
                            pro_quantity: item.pro_goods_num || 0,
                            pro_goods_num: item.pro_goods_num || 0,
                            pro_units: matchedTitle.pro_units || item.pro_units || '',
                            pro_stock: matchedTitle.stock || item.stock,
                            pro_sku_price_id: item.pro_sku_price_id,
                            gifts: FinalGifts,
                            promotions: FinalPromotions,
                        });

                        console.log('✅ DIFFERENT_ACTIVITY_AND_ST: แยกก้อนใหม่เพราะต่าง activity_id และ st');
                        Swal.fire({
                            icon: 'success',
                            title: 'เพิ่มสินค้ารายการใหม่',
                            text: `เพิ่มก้อนใหม่สำหรับ ${matchedTitle.pro_erp_title || item.pro_title}`,
                            timer: 1500,
                            showConfirmButton: false
                        });
                        break;

                    // case 'EXISTS_NORMAL':
                    //     // update only normal
                    //     Object.assign(normalEntry, { pro_goods_num: normalEntry.pro_goods_num + item.pro_goods_num });
                    //     break;

                    // case 'EXISTS_PROMO':
                    //     // update only promo
                    //     Object.assign(promoEntry, { pro_goods_num: promoEntry.pro_goods_num + item.pro_goods_num });
                    //     break;

                    case 'SIMILAR_SN_DIFFERENT_ACTIVITY':
                        // 1) เปลี่ยน activity_id ของรายการเดิมให้ตรงกับตัวใหม่
                        Object.assign(similarItem, {
                            activity_id: activityId,
                            st: item.st,
                            pro_goods_num: item.pro_goods_num,
                            pro_quantity: item.pro_goods_num,
                            pro_unit_price: item.pro_goods_price || 0,
                            pro_goods_sku_text: item.color || item.pro_goods_sku_text || '',
                            pro_goods_price: item.pro_goods_price || '',
                            pro_image: item.pro_image || '',
                            // 2) อัปเดต promotions/gifts
                            promotions: FinalPromotions,
                            gifts: FinalGifts,
                            // … field อื่นๆ ตามที่ต้องการ
                        });
                        console.log('SIMILAR_SN_DIFFERENT_ACTIVITY: ย้ายไป activity ใหม่ พร้อมโหลด promotions');
                        Swal.fire({
                            icon: 'info',
                            title: 'อัปเดตโปรโมชั่นสำเร็จ',
                            text: `ปรับข้อมูล ${matchedTitle.pro_erp_title || item.pro_title} เป็น st=${item.st}`,
                            showConfirmButton: false,
                            timer: 1500
                        });
                        break;

                    case 'EXISTS':
                        Object.assign(alreadyExists, {
                            ...item,
                            pro_id: item.pro_sku_price_id,
                            // pro_activity_id: item.pro_activity_id,
                            activity_id: activityId,
                            pro_quantity: item.pro_goods_num,
                            pro_goods_num: item.pro_goods_num,
                            pro_goods_sku_text: item.color || item.pro_goods_sku_text || '',
                            pro_goods_price: item.pro_goods_price || '',
                            pro_image: item.pro_image || '',
                            gifts: FinalGifts,
                            promotions: FinalPromotions

                            // เพิ่มค่าอื่น ๆ ที่จำเป็น
                        });

                        console.log('EXISTS');

                        Swal.fire({
                            icon: 'info',
                            title: 'เพิ่มจำนวนข้อมูลสินค้าสำเร็จ',
                            text: `เพิ่มข้อมูลสินค้าเรียบร้อย ${matchedTitle.pro_erp_title || item.pro_title || ''}`,
                            showConfirmButton: false,
                            timer: 2000, // ปิดอัตโนมัติใน 2 วินาที (2000 มิลลิวินาที)
                            timerProgressBar: true
                        });
                        break;
                    case 'EXISTS2':
                        // eslint-disable-next-line no-undef
                        Object.assign(alreadyExists2, {
                            ...item,
                            pro_id: item.pro_sku_price_id,
                            activity_id: activityId,
                            pro_quantity: item.pro_goods_num,
                            pro_goods_sku_text: item.color || item.pro_goods_sku_text || '',
                            pro_goods_num: item.pro_goods_num,
                            gifts: FinalGifts,
                            promotions: FinalPromotions

                            // เพิ่มค่าอื่น ๆ ที่จำเป็น
                        });

                        console.log('alreadyExists2');

                        Swal.fire({
                            icon: 'info',
                            title: 'เพิ่มจำนวนข้อมูลสินค้าสำเร็จ',
                            text: `เพิ่มข้อมูลสินค้าเรียบร้อย ${matchedTitle.pro_erp_title || item.pro_title || ''}`,
                            showConfirmButton: false,
                            timer: 2000, // ปิดอัตโนมัติใน 2 วินาที (2000 มิลลิวินาที)
                            timerProgressBar: true
                        });
                        break;
                    case 'ACTIVITY_ID_ITEM_ISOK':
                        Object.assign(activity_id_ItemIsok, {
                            ...item,
                            pro_id: item.pro_sku_price_id,
                            activity_id: activityId,
                            pro_quantity: item.pro_goods_num,
                            pro_goods_num: item.pro_goods_num,
                            pro_goods_sku_text: item.color || item.pro_goods_sku_text || '',
                            pro_goods_price: item.pro_goods_price || '',
                            pro_image: item.pro_image || '',
                            gifts: FinalGifts, //fullActivityGifts ||
                            promotions: FinalPromotions, //
                            // เพิ่มค่าอื่น ๆ ที่จำเป็น
                        });

                        console.log('ACTIVITY_ID_ITEM_ISOK');

                        Swal.fire({
                            icon: 'info',
                            title: 'เพิ่มจำนวนข้อมูลสินค้าสำเร็จ',
                            text: `เพิ่มข้อมูลสินค้าเรียบร้อย ${matchedTitle.pro_title || item.pro_erp_title || ''}`,
                            showConfirmButton: false,
                            timer: 2000, // ปิดอัตโนมัติใน 2 วินาที (2000 มิลลิวินาที)
                            timerProgressBar: true
                        });
                        break;

                    case 'ACTIVITY_ID_ITEM_IS_Not_OK':
                        Object.assign(activity_id_ItemIs_Not_ok, {
                            ...item,
                            pro_id: item.pro_sku_price_id,
                            activity_id: activityId,
                            pro_quantity: item.pro_goods_num,
                            pro_goods_num: item.pro_goods_num,
                            pro_goods_sku_text: item.color || item.pro_goods_sku_text || '',
                            pro_goods_price: item.pro_goods_price || '',
                            pro_image: item.pro_image || '',
                            gifts: FinalGifts, //fullActivityGifts ||
                            promotions: FinalPromotions, //
                            // เพิ่มค่าอื่น ๆ ที่จำเป็น
                        });

                        console.log('ACTIVITY_ID_ITEM_IS_Not_OK');

                        Swal.fire({
                            icon: 'info',
                            title: 'เพิ่มข้อมูลสินค้าสำเร็จ',
                            text: `เพิ่มสินค้าเรียบร้อย ${matchedTitle.pro_title || item.pro_erp_title || ''}`,
                            showConfirmButton: false,
                            timer: 2000, // ปิดอัตโนมัติใน 2 วินาที (2000 มิลลิวินาที)
                            timerProgressBar: true
                        });

                        console.log('เพิ่มข้อมูลสินค้า ต่าง st สำเร็จ');
                        break;

                }

            }

            console.log("📋 รายการสินค้าในตาราง:", this.selectedProducts);

        },

        removeProductById(pro_id, activity_id) {
            // this.selectedProducts = this.selectedProducts.filter(p => p.pro_id !== pro_id);
            this.selectedProducts = this.selectedProducts.filter(
                p => !(p.pro_id === pro_id && p.activity_id === activity_id)
            );
        },

        removeProduct(index, activityId) {
            Swal.fire({
                title: 'ยืนยันการลบ?',
                text: 'คุณต้องการลบสินค้านี้ออกจากรายการใช่หรือไม่?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'ใช่, ลบเลย!',
                cancelButtonText: 'ยกเลิก'
            }).then((result) => {
                if (result.isConfirmed) {
                    // 1. ดึงกลุ่ม product ที่ activityId เดียวกัน
                    const groupObj = this.groupByActivityId(this.selectedProducts)[activityId];
                    // const productToRemove = group[index];

                    const productToRemove = groupObj?.items?.[index];

                    if (!productToRemove) return;

                    const {
                        pro_goods_id,
                        pro_activity_id,
                        pro_sku_price_id,
                        st
                    } = productToRemove;

                    // 2. ลบสินค้า, promotion, gift ที่มีค่าตรงกันทั้งหมด
                    this.selectedProducts = this.selectedProducts.filter(p =>
                        !(
                            p.pro_goods_id == pro_goods_id &&
                            p.pro_activity_id == pro_activity_id &&
                            p.pro_sku_price_id == pro_sku_price_id &&
                            p.st == st
                        )
                    );

                    // 3. รีเซ็ตส่วนลดให้เป็น 0
                     this.formData.totalDiscount = 0;

                    // 4. อัปเดตข้อมูลของโปรโมชั่นและของแถมใหม่ทันที
                    // this.submittedProduct(); // เรียกเพื่อ refresh ของแถม / โปร ทันที
                    if (this.selectedProducts && this.selectedProducts.length > 0) {
                        this.submittedProduct();
                    }

                    Swal.fire('ลบแล้ว!', 'สินค้าถูกลบออกจากรายการ.', 'success');
                }
            });
        },


        removeAllProducts() {
            if (this.selectedProducts.length === 0) {
                Swal.fire({
                    title: 'ไม่มีสินค้า',
                    text: 'ยังไม่มีสินค้าที่เลือกไว้ในรายการ',
                    icon: 'info'
                });
                return;
            }

            Swal.fire({
                title: 'ยืนยันการลบทั้งหมด?',
                text: 'คุณต้องการลบสินค้าที่เลือกทั้งหมดออกจากรายการใช่หรือไม่?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'ใช่, ลบทั้งหมด!',
                cancelButtonText: 'ยกเลิก'

            }).then((result) => {
                if (result.isConfirmed) {
                    this.selectedProducts.length = 0; // ล้างอาร์เรย์ทั้งหมด
                    this.formData.totalDiscount = 0; // ล้างอาร์เรย์ทั้งหมด
                    Swal.fire('ลบแล้ว!', 'สินค้าทั้งหมดถูกลบออกจากรายการ.', 'success');
                }
            });
        },

        addProductRow() { //
            console.log('เพิ่มแถวสินค้าใหม่');
            this.selectedProducts.push({
                id: Date.now(),
                pro_id: '',
                pro_erp_title: '',
                pro_quantity: 0,
                pro_unit_price: 0,
                discount: 0,
                pro_images: '',
                pro_goods_sku_text: '',
            });
        },
        openSelectorForRow(index) {
            this.editIndex = index;
            this.showProductSelectoronly = true;
        },

        replaceProductInRow(products) {
            if (!products || products.length === 0) {
                Swal.fire('กรุณาเลือกสินค้า 1 รายการ', '', 'warning')
                return;
            }

            if (products.length > 1) {
                Swal.fire('กรุณาเลือกสินค้าแค่ 1 รายการ', '', 'info')
                return;
            }

            const selected = products[0];
            if (this.editIndex !== null && selected) {
                this.selectedProducts[this.editIndex] = {
                    pro_id: selected.pro_id,
                    pro_erp_title: selected.pro_erp_title,
                    pro_sku: selected.pro_sku,
                    pro_quantity: selected.pro_quantity,
                    pro_unit: selected.pro_unit,
                    pro_unit_price: selected.pro_unit_price,
                    pro_images: selected.pro_images,
                    qty: 1,
                    discount: 0
                };
            }

            this.showProductSelectoronly = false;
            this.editIndex = null;
        },

        totalprice(product) {
            // const qty = product.qty || 0;
            // const price = product.pro_unit_price || 0;
            // const discount = product.discount || 0;
            // const totalprice = (qty * price - discount).toFixed(2);
            // console.log('Log value:', totalprice);
            // return totalprice;
            const qty = product.pro_quantity || 0; // ใช้ pro_quantity แทน qty
            const price = product.pro_unit_price || 0;
            const discount = product.discount || 0;
            const totalprice = (qty * price - discount).toFixed(2);
            console.log('Log value:', totalprice);
            return totalprice;
        },

    },

    created() {
        this.getProduct();
        // accountLoginSubmit();
    },

    mounted() {
        this.loadCustomerAddresses();

        const urlParams = new URLSearchParams(window.location.search);
        const documentNo = urlParams.get('documentNo');

        if (documentNo) {
            this.isReadOnly = true; // ถ้ามี documentNo ให้ตั้งค่า readonly
            // this.loadOrderData();
            this.loadDocumentData(documentNo); // โหลดข้อมูลเอกสาร
        }

        this.getProduct(1);


        const today = new Date();
        const year = today.getFullYear(); // ปีคริสต์ศักราช
        const month = String(today.getMonth() + 1).padStart(2, '0'); // เดือน (01-12)
        const day = String(today.getDate()).padStart(2, '0'); // วัน (01-31)

        this.formData.sellDate = `${day}/${month}/${year}`; // ตั้งค่าเป็น วัน/เดือน/ปี
        this.formData.deliveryDate = `${day}/${month}/${year}`; // ตั้งค่าเป็น วัน/เดือน/ปี

        // อัปเดตอัตโนมัติเมื่อ localStorage ถูกเปลี่ยนจากแท็บอื่น
        window.addEventListener('storage', (event) => {
            if (event.key === 'selectDataCustomer') {
                this.customerData = JSON.parse(event.newValue || 'null');
                console.log('🔄 customerData updated via storage event:', this.customerData);
                this.getProduct(); // เรียกใหม่เมื่อข้อมูลลูกค้าเปลี่ยน
            }
        });

        // โหลดข้อมูลลูกค้าจาก localStorage ครั้งแรก
        if (this.customerData && this.customerData.data2) {
            this.updateCustomerData();
        } else {
            console.warn("customerData ไม่มีค่าใน localStorage:", this.customerData);
        }

    },


}

</script>

<style>
input {

    padding: 0.5rem;
    margin-top: 0.4rem;

}

@media (max-width: 431px) {
    .responsive-action-bar {
        left: 0;
    }

}

@media (max-width: 667px) {
    .responsive-action-buttons button {
        font-size: 0.75rem;
        /* ลดขนาดตัวอักษร */
        padding: 0.5rem 0.75rem;
        /* ลดขนาดปุ่ม */
    }

    .responsive-action-buttons {
        justify-content: center;
    }
}

/* @media (max-width: 500px) {
    .md\\:hidden {
        display: block;
    }

    .md\\:flex {
        display: none;
    }
} */
</style>
