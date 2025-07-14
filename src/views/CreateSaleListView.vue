<template>

    <div
        class="mainbox flex flex-col in-h-screen items-center gap-4 justify-center bg-gray-100 py-8 px-4 sm:px-6 lg:px-8">
        <!-- <div class="min-h-screen flex items-center gap-2 justify-center bg-gray-100 py-12 px-4 sm:px-6 lg:px-8"> -->
        <!-- <div class="flex self-end">
             self-end 
            <router-link class="button" to="/createsalelist">
                <span class="material-icons">shopping_bag</span>
                <span class="text">Create Sale Order</span>
            </router-link>
            <button type="button" @click="saveDocument"
                class="w-full bg-purple-700 text-white py-2 px-6 rounded-md hover:bg-purple-800 transition">บันทึก
            </button>
        </div> -->
        <!-- กล่องรวม breadcrumb + action bar -->
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
                    <button v-if="!isReadOnly && formData.documentNo && !isConfirmed && !isCreatePage"
                        @click="confirmFinalSave"
                        class="bg-red-600 text-white py-2 px-4 md:px-6 text-sm md:text-base rounded-md hover:bg-red-700">
                        ยืนยันการบันทึก (ไม่สามารถแก้ไขได้อีก)
                    </button>

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

                    <!-- <div>
                        <label class="block text-sm font-medium text-gray-700">วันที่</label>
                        <input type="date" v-model="formData.sellDate" disabled
                            class="border mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                    </div> -->

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

                        <div class="md:col-span-2">
                            <label class="block text-sm font-medium text-gray-700">ประเภทภาษี</label>
                            <input type="text" v-model="formData.taxType" :readonly="isReadOnly"
                                class="border text-gray-700 mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                        </div>

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

                        <!-- เงื่อนไขแสดงเพิ่มเติม -->
                        <div v-if="showMore">
                            <div class="">
                                <label class="block text-sm font-medium text-gray-700">เบอร์โทรศัพท์ลูกค้า</label>
                                <input type="text" v-model="formData.phone" :readonly="isReadOnly"
                                    class="mt-1 block w-full text-gray-700 rounded-md border border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                            </div>

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
                        <button @click="addProductRow" :disabled="isReadOnly"
                            class="block w-full text-left px-4 py-2 text-sm text-green-600 hover:bg-green-100">
                            + เพิ่มแถวสินค้า
                        </button>
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
                @select-products="addSelectedProducts" />

            <ProductSelector v-if="showProductSelectoronly" :productList="Apiproducts"
                @close="showProductSelectoronly = false" @select-products="replaceProductInRow" />

            <!-- :productList="Apipromotion" -->
            <PromotionSelector v-if="showPromotionSelector" @close="showPromotionSelector = false"
                @select-promotion="SelectedPromotion" />

            <!-- Popup ตัวที่สอง -->
            <Promotion_ProductSelector v-if="showPromotionProductSelector" :selectedPromotion="selectedPromotion"
                @close="showPromotionProductSelector = false" @selectPromotionProducts="handleSelectedPromotionProducts"
                @go-back="handleBackToPromotion" />

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

                    <tbody>
                        <!-- แสดงรายการสินค้า -->
                        <!-- 👉 Group by pro_activity_id -->
                        <template v-for="(group, activityId) in groupByActivityId(selectedProducts)" :key="activityId">
                            <!-- 🔁 Loop สินค้าในกลุ่มนั้น -->
                            <template v-for="(product, index) in group" :key="product.pro_id">
                                <!-- 🔳 สินค้า -->
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
                                    <td class="px-4 py-2 border">{{ product.pro_erp_title }}</td>
                                    <td class="px-4 py-2 border">{{ product.pro_goods_sku_text || '-' }}</td>
                                    <!-- <td class="px-4 py-2 border">{{ product.pro_quantity }}</td> -->
                                    <!-- <td class="px-4 text-gray-700 py-2 border">
                                        <input type="number" v-model.pro_quantity="product.pro_quantity" min="1" placeholder="จำนวน"
                                            class="w-full px-2 py-1 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-purple-500" />
                                    </td> -->
                                    <!-- <td class="px-4 py-2 border">
                                        <input type="number" :min="0" :max="product.pro_stock" step="1"
                                            v-model.number="product.pro_quantity" @input="validateQuantity(product)"
                                            class="w-full px-2 py-1 border rounded" />
                                    </td> -->
                                    <td class="px-4 py-2 border">{{ product.pro_quantity }}</td>
                                    <!-- <td class="px-4 py-2 border">{{ product.pro_stock }}</td> -->
                                    <td class="px-4 py-2 border">{{ product.pro_unit_price }}</td>
                                    <td class="px-4 py-2 border">{{ product.discount || 0 }}</td>
                                    <td class="px-4 py-2 border">{{ totalprice(product) }}</td>
                                    <!-- <td class="px-4 py-2 border text-red-500 cursor-pointer hover:text-red-700"
                                        :disabled="isReadOnly"
                                        @click="removeProduct(index, activityId)">
                                        ลบ
                                    </td> -->
                                    <td class="px-4 py-2 border" :class="{
                                        'text-red-500 cursor-pointer hover:text-red-700': !isReadOnly,
                                        'text-gray-400 cursor-not-allowed': isReadOnly
                                    }" @click="!isReadOnly && removeProduct(index, activityId)">
                                        ลบ
                                    </td>
                                </tr>
                            </template>

                            <!-- 🟦 โปรโมชั่น (มินิมอล + ลูกเล่นไอคอน) -->
                            <tr v-if="group[0].promotions && group[0].promotions.length > 0"
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
                                        <li v-for="(promotion, promoIndex) in group[0].promotions" :key="promoIndex">
                                            {{ promotion.title }}
                                        </li>
                                    </ul>
                                </td>
                            </tr>


                            <!-- 🟨 ของแถม (มินิมอล + รูปภาพ + ฟีล modern card) -->
                            <tr v-if="group[0].gifts && group[0].gifts.length > 0"
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
                                        <div v-for="(gift, giftIndex) in group[0].gifts" :key="giftIndex"
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
                        style="margin: 0.4rem;" class="w-full border px-3 py-2 rounded text-gray-700">

                        <option value="">เลือกช่องทางจัดส่ง</option>
                        <option>ไปรษณีย์</option>
                        <!-- <option>ไปรษณีย์</option> -->
                        <option>แมสเซนเจอร์</option>
                        <option>ขนส่งเอกชน</option>
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
                        <input type="number" v-model="formData.deliveryFee" :readonly="isReadOnly"
                            class="w-full text-gray-700 border px-3 py-2 rounded text-gray-700" />
                    </div>
                </div>
            </div>

            <!-- หมายเหตุ -->
            <div class="mt-4">
                <label class="block font-medium mb-1 text-gray-700">หมายเหตุ</label>
                <textarea rows="3" v-model="formData.note" :readonly="isReadOnly"
                    class="w-full border px-3 py-2 rounded text-gray-700"></textarea>
            </div>

            <!-- รวม -->
            <!-- รวม -->
            <div class="mt-6 text-right space-y-1">
                <div class="text-gray-700">มูลค่ารวมก่อนภาษี:
                    <span class="ml-2 text-gray-700">{{ totalAmountBeforeDiscount.toFixed(2) }}</span>
                </div>

                <div class="text-gray-700 flex items-center justify-end">
                    <input type="checkbox" v-model="isVatIncluded" id="vatCheckbox" class="mr-2" />
                    <label for="vatCheckbox">ภาษีมูลค่าเพิ่ม (7%)</label>
                    <span class="ml-2 text-gray-700">
                        {{ isVatIncluded ? (totalAmountBeforeDiscount * 0.07).toFixed(2) : '0.00' }}
                    </span>
                </div>

                <div class="text-xl font-bold text-purple-700 mt-2">
                    มูลค่ารวมสุทธิ:
                    <span class="ml-2 text-blue-600">{{ grandTotal }}</span>
                </div>
            </div>

            <!-- <div class="mt-6 text-right space-y-1">
                <div class="text-gray-700">มูลค่ารวมก่อนภาษี: <span class="ml-2 text-gray-700">{{
                    totalAmountBeforeDiscount.toFixed(2) }}</span></div>
                <div class="text-gray-700">ภาษีมูลค่าเพิ่ม (7%): <span class="ml-2 text-gray-700">{{
                    (totalAmountBeforeDiscount
                        * 0.07).toFixed(2) }}</span>
                </div>
                <div class="text-xl font-bold text-purple-700 mt-2">
                    มูลค่ารวมสุทธิ: <span class="ml-2 text-blue-600">{{ grandTotal }}</span>
                </div>
            </div> -->
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

                        <div v-if="showMoreAdress">

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
                            <div>

                                <!-- ✅ ปุ่ม popup ด้านล่างขวา -->
                                <div class="bottom-6 right-6 z-50 justify-self-end">
                                    <button @click="showAddressPopup = true" :disabled="isReadOnly"
                                        class="bg-purple-600 text-white item-end px-6 py-3 rounded-lg shadow-lg hover:bg-purple-700 transition">
                                        + เลือกที่อยู่ / จัดส่ง
                                    </button>
                                </div>

                                <!-- ✅ แสดง Popup -->
                                <DeliveryAddressPopup v-if="showAddressPopup" :existingAddress="selectedAddress"
                                    @close="showAddressPopup = false" @submitted="handleAddressSelected" />
                                <!-- โครตเจ๋ง -->
                                <!-- <div class="fixed bottom-6 right-6 z-50">
                                    <button @click="showAddressPopup = true"
                                        class="bg-purple-600 text-white px-6 py-3 rounded-lg shadow-lg hover:bg-purple-700 transition">
                                        + เลือกที่อยู่ / จัดส่ง
                                    </button>
                                </div> -->

                                <p v-if="formTouched && errors.receiverAddress" class="text-red-500 text-sm mt-1">{{
                                    errors.receiverAddress }} </p>
                            </div>

                            <!-- <button class="mt-2 px-4 py-2 bg-indigo-600 text-white text-sm rounded hover:bg-indigo-700">
                                ตรวจสอบที่อยู่
                            </button> -->
                        </div>
                    </div>
                </div>

                <!-- ปุ่ม Show More / Show Less -->
                <!-- <button @click="showMoreAdress = !showMoreAdress" type="button"
                    class="mt-4 text-purple-600 hover:underline focus:outline-none">
                    {{ showMoreAdress ? 'แสดงน้อยลง ▲' : 'แสดงเพิ่มเติม ▼ ' }}
                </button> -->
                <div class="mt-4 flex items-center space-x-2">
                    <button @click="showMoreAdress = !showMoreAdress" type="button"
                        class="text-purple-600 hover:underline focus:outline-none">
                        {{ showMoreAdress ? 'แสดงน้อยลง ▲' : 'แสดงเพิ่มเติม ▼ ' }}
                    </button>

                    <!-- ✅ เพิ่มข้อความแจ้งเตือนด้านข้างปุ่ม -->
                    <span class="text-red-500 text-xs">*</span>
                    <span class="text-red-500 text-xs">จำเป็นต้องกรอกข้อมูลนี้</span>
                </div>

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
                            <span class="text-red-500 text-xs ml-1">*</span>
                            <span class="text-red-500 text-xs ml-1">จำเป็นต้องกรอกข้อมูลนี้</span>
                        </label>
                        <input type="text" v-model="formData.trackingNo" :readonly="isReadOnly"
                            class="w-full text-gray-700 border rounded px-3 py-2" />
                        <p v-if="formTouched && errors.trackingNo" class="text-red-500 text-sm mt-1">{{
                            errors.trackingNo }} </p>
                    </div>
                </div>
            </div>


        </div>

        <!-- <div class=" w-full mx-auto p-6 rounded-lg bg-white shadow-md space-y-8">
            <div class="gap-4 grid grid-cols-1 md:grid-cols-2">
                <button v-if="isReadOnly" @click="enableEditMode"
                    class="bg-yellow-500 text-white py-2 px-4 rounded-md hover:bg-yellow-600">
                    แก้ไข
                </button>
                <button v-if="!isReadOnly" @click="saveDocument"
                    class="bg-purple-700 w-full text-white py-2 px-4 rounded-md hover:bg-purple-800">
                    บันทึก
                </button>
                <button v-if="!isReadOnly && formData.documentNo" @click="updateDocument"
                    class="bg-green-600 w-full text-white py-2 px-4 rounded-md hover:bg-green-700">
                    บันทึกการแก้ไข
                </button>

            </div>
        </div> -->
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

</template>

<script>
import { ref, onMounted, watch } from 'vue';
import axios from 'axios';
import Swal from 'sweetalert2';
import ProductSelector from '../components/ProductSelector.vue';
import PromotionSelector from '../components/PromotionSelector.vue';
import Promotion_ProductSelector from '../components/Promotion_ProductSelector.vue';
import DeliveryAddressPopup from '@/components/DeliveryAddressPopup.vue'
import { useRoute } from 'vue-router'
// import ConfirmEditPopup from '@/components/saleOrder/ConfirmEditPopup.vue'
import qs from 'qs';
import Flatpickr from 'vue-flatpickr-component'
import 'flatpickr/dist/flatpickr.css'

// ✅ import Thai locale
import { Thai } from 'flatpickr/dist/l10n/th.js'
import flatpickr from 'flatpickr'


// ✅ ตั้งค่าภาษาไทยให้กับ flatpickr
flatpickr.localize(Thai)

const BASE_URL = import.meta.env.VITE_API_URL;
const BASE_URL_LOCAL = import.meta.env.VITE_API_URL_LOCAL;

console.log('adadasdsadadasdadasdadasdasda', BASE_URL_LOCAL);

const BASE_URL_MAC_FIVEL = import.meta.env.VITE_API_URL_MAC_FIVELE;
const BASE_URL_AUTH = import.meta.env.VITE_API_URL_AUTH;

// const secretKey1 = import.meta.env.VITE_SECRET_KEY1;
// const secretKey2 = import.meta.env.VITE_SECRET_KEY2;

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
        'flat-pickr': Flatpickr,
        // ConfirmEditPopup
    },
    data() {
        return {

            isVatIncluded: true, //  เริ่มต้นให้คิดภาษี

            // ตัวแปรควบคุม popup
            showAddressPopup: false, // ควบคุมการแสดง popup ที่อยู่]

            //  เก็บข้อมูลที่อยู่ที่เลือกจาก popup
            selectedAddress: [],

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
                listCode: '',
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
                reference: '',
                channel: '',
                taxType: '',

                fullName: '',
                customerCode: '',
                phone: '',
                email: '',
                address: '',
                receiverName: '',
                receiverPhone: '',
                receiverEmail: '',
                receiverAddress: '',
                note: '',

                promotions: [], // เก็บรายการสินค้าที่เลือก
                gifts: [], // เก็บรายการของแถม

                // ใช้
                // deliveryDate: '',

                trackingNo: '',
                deliveryType: '',
                totalDiscount: '',

                totalDiscount: '',
                deliveryFee: '',

                documentNo: '',

                pro_quantity: '' || 0,

                discount: '' || 0,
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

            selectedProducts: [], // ค่าเริ่มต้นเป็น array ว่าง

            allSelectedPromotionProducts: [], // 🔁 รวมสินค้าที่เคยเลือกทั้งหมด
        };
    },

    mounted() {
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
        // totalAmountBeforeDiscount() {
        //     const subtotal = this.selectedProducts.reduce((sum, product) => {
        //         const qty = product.pro_quantity || 0;
        //         // const qty = product.qty || 0;
        //         const price = product.pro_unit_price || 0;
        //         const discount = product.discount || 0;
        //         return sum + (qty * price - discount);
        //     }, 0);
        //     const deliveryFee = parseFloat(this.formData.deliveryFee) || 0;
        //     const totalDiscount = parseFloat(this.formData.totalDiscount) || 0;
        //     const total = subtotal + deliveryFee - totalDiscount;
        //     return total < 0 ? 0 : total;
        // },
        // grandTotal() {
        //     const netBeforeVat = this.totalAmountBeforeDiscount;
        //     const vat = netBeforeVat * 0.07;
        //     return (netBeforeVat + vat).toFixed(2);
        // },

        totalAmountBeforeDiscount() {
            const subtotal = this.selectedProducts.reduce((sum, product) => {
                const qty = product.pro_quantity || 0;
                const price = product.pro_unit_price || 0;
                const discount = product.discount || 0;
                return sum + (qty * price - discount);
            }, 0);
            const deliveryFee = parseFloat(this.formData.deliveryFee) || 0;
            const totalDiscount = parseFloat(this.formData.totalDiscount) || 0;
            const total = subtotal + deliveryFee - totalDiscount;
            return total < 0 ? 0 : total;
        },
        grandTotal() {
            const netBeforeVat = this.totalAmountBeforeDiscount;
            const vat = this.isVatIncluded ? netBeforeVat * 0.07 : 0;
            return (netBeforeVat + vat).toFixed(2);
        },
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



        // groupByActivityId(products) {
        //     return products.reduce((acc, item) => {
        //         const key = item.promotions?.[0]?.pro_activity_id || item.pro_activity_id || 'no-activity';
        //         if (!acc[key]) acc[key] = [];
        //         acc[key].push(item);
        //         return acc;
        //     }, {});
        // },

        groupByActivityId(products) {
            return products.reduce((acc, item) => {
                const key = `${item.activity_id || 'no-activity'}-st${item.st ?? 0}`;
                if (!acc[key]) acc[key] = [];
                acc[key].push(item);
                return acc;
            }, {});
        },

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
                this.formData.fullName = this.customerData.data2.contact || '';
                this.formData.receiverName = this.customerData.data2.contact || '';
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
                    headers: {
                        'Content-Type': 'application/json'
                    }
                });

                const data = response.data.data;

                console.log('📦 Loaded products:', data);

                // เก็บจำนวนสินค้าทั้งหมดจาก API
                this.totalItems = data.item_count || 0;

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

            // ตรวจสอบฟิลด์ที่จำเป็น 'reference', 'channel', 'taxType',
            // const requiredFields = [
            //     'sellDate', 'fullName', 'customerCode', 'phone', 'address',
            //     'receiverName', 'receiverPhone', 'receiverEmail', 'receiverAddress',
            //     'deliveryDate', 'trackingNo', 'deliveryType'
            // ];
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
                deliveryDate: 'วันที่จัดส่ง',
                trackingNo: 'เลขติดตาม',
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
                if (!value || (typeof value === 'string' && value.trim() === '')) {
                    this.errors[field] = `กรุณากรอก${label}`;
                    isValid = false;
                }
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
                return;
            }

            // ✅ ดำเนินการบันทึกต่อ...
            console.log("✅ กำลังบันทึกข้อมูล", this.formData);

            // 'listCode' ,'expireDate', 'email',
            // const requiredFields = [
            //     'sellDate', 'reference', 'channel', 'taxType',
            //     'fullName', 'customerCode', 'phone', 'address',
            //     'receiverName', 'receiverPhone', 'receiverEmail', 'receiverAddress',
            //     'deliveryDate', 'trackingNo', 'deliveryType'
            // ];

            // console.log("Log Value requiredFields: ", requiredFields);

            // for (const field of requiredFields) {
            //     if (!this.formData[field]) {
            //         Swal.fire({
            //             text: 'กรุณากรอกข้อมูลที่จำเป็นให้ครบถ้วนในส่วน "ข้อมูลรายการ" "แบบฟอร์มลูกค้า" "รายการสินค้า" "ข้อมูลที่อยู่ผู้รับ" และ "ข้อมูลการจัดส่งสินค้า"',
            //             icon: 'warning'
            //         });
            //         return; // หยุดการทำงานหากมีฟิลด์ที่ว่าง
            //     }
            // }


            // เรียก API เพื่อสร้าง Document Running // เพิ่มข้อมูล DocumentRunning
            // let documentRunning = null;
            try {
                const docRunningPayload = {
                    warehouse_code: this.formData.warehouseCode || "H1",
                    doc_type: this.formData.docType || "SO"
                    // warehouse_code: "H1",      // สมมุติใช้คลัง H1
                    // doc_type: "SO"             // เอกสารขาย: Sale Order
                };

                const docResponse = await axios.post(
                    `${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/post_documentrunning.php`,
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

            } catch (err) {
                const message = err.response?.data?.message || err.message || 'เกิดข้อผิดพลาดในการสร้างเลขเอกสาร';
                Swal.fire({ text: message, icon: 'error' });
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
                    pro_id: product.pro_id,
                    pro_erp_title: product.pro_erp_title,
                    pro_quantity: product.pro_quantity,
                    pro_unit_price: product.pro_unit_price,
                    pro_discount: this.formData.discount,
                    pro_total_price: total, // รวมราคาต่อสินค้า
                    pro_images: product.pro_images,
                    pro_sn: product.pro_sn,
                    pro_units: product.pro_units,
                    pro_activity_id: product.activity_id || 0, // เพิ่ม activity_id ถ้ามี
                };
            });


            console.log("🔍 log value this.productList:", this.formData.productList)

            this.formData.final_total_price = this.grandTotal;

            const { promotions, gifts } = this.extractPromotionsAndGifts();
            this.formData.promotions = promotions;
            this.formData.gifts = gifts;

            // await this.AddressInsertData(this.selectedAddress);

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

            if (!this.selectedAddress || Object.keys(this.selectedAddress).length === 0) {
                Swal.fire({
                    icon: 'warning',
                    title: 'กรุณาเลือกที่อยู่จัดส่ง',
                });
                return;
            }

            // ✅ เพิ่ม selectedAddress เข้าไป
            payload.append('deliveryAddress', JSON.stringify(this.selectedAddress));
            // console.log('asdasdasdads',payload);
            // for (let pair of payload.entries()) {
            //     console.log("🤯 payload asdasdasfadfafas", pair[0] + ': ' + pair[1]);
            // }

            // console.log("🤯 Log Value this.promotions: ", this.promotions);
            // console.log("🤯 Log Value this.gifts: ", this.gifts);

            // payload.append('promotions', JSON.stringify(this.promotions));
            // payload.append('gifts', JSON.stringify(this.gifts));



            // เพื่อมข้อมูล FormData
            try {
                console.log('adadasdsadadasdadasdadasdasda', BASE_URL_LOCAL);
                const response = await axios.post(`${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/post_sale_order.php`, payload, {
                    // headers: { 'Content-Type': 'application/json' },
                });

                console.log(" Log Value Data: ", response.data);

                const resData = typeof response.data === 'string' ? JSON.parse(response.data) : response.data;
                if (resData.success) {
                    // เก็บ documentNo ลง localStorage

                    ///////////////////////////////////////////
                    const order_ids = resData.order_id;
                    console.log('order_ids', order_ids);
                    const newDocumentNo = resData.newDocumentNo;
                    console.log('newDocumentNo', newDocumentNo);

                    localStorage.setItem('order_id', order_ids);
                    localStorage.setItem('newDocumentNo', newDocumentNo);
                    /////////////////////////////////////////////////////////

                    const documentNo = this.formData.documentNo;
                    localStorage.setItem('documentNo', documentNo);

                    // เปลี่ยน URL ไปยัง saleList?documentNo=<documentNo>
                    this.$router.push(`/saleList?documentNo=${documentNo}`);

                    // ตั้งค่าให้ฟอร์มเป็น readonly
                    this.isReadOnly = true;

                    Swal.fire({ text: resData.message, icon: 'success' });
                } else {
                    Swal.fire({ text: 'asdadas', icon: 'error' });
                    console.log('resData', resData);
                }

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
            } catch (err) {
                const message = err.response?.data?.message || err.message || 'Unknown error';
                Swal.fire({ text: message, icon: 'error' });
                console.log('a454545654564 catch');
            }

        },

        // async AddressInsertData(data) {
        //     // เซ็ตข้อมูล selectedAddress จากข้อมูลที่เลือก
        //     this.selectedAddress = {
        //         id: data.DC_id,
        //         detail: data.DC_add1,
        //         province_id: this.findProvinceId(data.DC_add3),
        //         amphure_id: this.findAmphureId(data.DC_add2),
        //         tambon_id: this.findTambonId(data.DC_add2),
        //         phone: data.DC_tel,
        //     };

        //     const addressData = this.selectedAddress;

        //     console.log('📦 ข้อมูลที่อยู่:', addressData);

        //     // ดึงข้อมูลลูกค้า
        //     const getselectDataCustomerRow = JSON.parse(localStorage.getItem('selectDataCustomerRow') || '{}');
        //     const getCustomer_no = getselectDataCustomerRow?.customer_no ?? 'UNKNOWN';
        //     const getCustomer_id = getselectDataCustomerRow?.customer_id ?? 0;
        //     const getMobile = getselectDataCustomerRow?.mobile ?? '';

        //     // ดึงชื่อจังหวัด/อำเภอ/ตำบลจาก id
        //     const province = this.provinces.find(p => p.id === addressData.province_id)?.name_th || '';
        //     const district = this.amphures.find(a => a.id === addressData.amphure_id)?.name_th || '';
        //     const subDistrict = this.tambons.find(t => t.id === addressData.tambon_id)?.name_th || '';

        //     // 👉 ยิง API เพื่อ Insert ข้อมูลที่อยู่ลงใน Database
        //     try {
        //         const res = await axios.post(`${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/post_delivery_address.php`, addressData, {
        //             headers: {
        //                 'Content-Type': 'application/json',
        //             }
        //         });

        //         console.log('📦 ส่งสำเร็จ:', res.data);

        //         if (res.data.success === true) {
        //             Swal.fire({
        //                 icon: 'success',
        //                 title: 'ส่งข้อมูลสำเร็จ',
        //                 text: 'ข้อมูลที่อยู่ถูกบันทึกเรียบร้อยแล้ว',
        //             });

        //             const address_id = res.data.id;
        //             localStorage.setItem('address_id', address_id);

        //             // ✅ ก้อนข้อมูลสำหรับ Mac Five (ใช้ addressData และข้อมูลจาก selectedAddress)
        //             const addressBulidMacFive = {
        //                 DC_code: getCustomer_no,
        //                 DC_id: address_id,
        //                 DC_add1: addressData.detail,
        //                 DC_add2: `แขวง ${subDistrict} ${district}`,
        //                 DC_add3: province,
        //                 DC_tel: addressData.phone || getMobile,
        //                 DC_zone: '', // เพิ่ม zone หากมีข้อมูล
        //             };

        //             console.log('📦 addressBulidMacFive:', addressBulidMacFive);

        //             const token = await this.getAuthToken();
        //             const formEncodedData = qs.stringify(addressBulidMacFive);

        //             try {
        //                 const response = await axios.post(`${BASE_URL_DELIVERY_ADDRESS}`, formEncodedData, {
        //                     headers: {
        //                         'Content-Type': 'application/x-www-form-urlencoded',
        //                         'Authorization': `Bearer ${token}`
        //                     }
        //                 });

        //                 console.log('📦 ส่งข้อมูลไป Mac Five สำเร็จ:', response.data);

        //                 this.$emit('submitted', addressBulidMacFive);
        //                 this.$emit('close');
        //             } catch (err) {
        //                 console.error('❌ ส่งไป Mac Five ไม่สำเร็จ:', err);
        //                 alert('เกิดข้อผิดพลาดในการส่งข้อมูลไปยัง Mac Five');
        //             }

        //         } else {
        //             Swal.fire({
        //                 icon: 'error',
        //                 title: 'เกิดข้อผิดพลาด',
        //                 text: 'ไม่สามารถบันทึกข้อมูลที่อยู่ได้',
        //             });
        //         }

        //     } catch (err) {
        //         console.error('❌ ส่งไม่สำเร็จ:', err);
        //         alert('เกิดข้อผิดพลาดในการส่งข้อมูล');
        //     }
        // },

        // async AddressUpdaateData(data) {
        //     // เซ็ตข้อมูล selectedAddress จากข้อมูลที่เลือก
        //     this.selectedAddress = {
        //         id: data.DC_id,
        //         detail: data.DC_add1,
        //         province_id: this.findProvinceId(data.DC_add3),
        //         amphure_id: this.findAmphureId(data.DC_add2),
        //         tambon_id: this.findTambonId(data.DC_add2),
        //         phone: data.DC_tel,
        //     };

        //     const addressData = this.selectedAddress;

        //     console.log('📦 ข้อมูลที่อยู่:', addressData);

        //     // ดึงข้อมูลลูกค้า
        //     const getselectDataCustomerRow = JSON.parse(localStorage.getItem('selectDataCustomerRow') || '{}');
        //     const getCustomer_no = getselectDataCustomerRow?.customer_no ?? 'UNKNOWN';
        //     const getCustomer_id = getselectDataCustomerRow?.customer_id ?? 0;
        //     const getMobile = getselectDataCustomerRow?.mobile ?? '';

        //     // ดึงชื่อจังหวัด/อำเภอ/ตำบลจาก id
        //     const province = this.provinces.find(p => p.id === addressData.province_id)?.name_th || '';
        //     const district = this.amphures.find(a => a.id === addressData.amphure_id)?.name_th || '';
        //     const subDistrict = this.tambons.find(t => t.id === addressData.tambon_id)?.name_th || '';

        //     // 👉 ยิง API เพื่อ Insert ข้อมูลที่อยู่ลงใน Database
        //     try {
        //         const res = await axios.post(`${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/post_delivery_address.php`, addressData, {
        //             headers: {
        //                 'Content-Type': 'application/json',
        //             }
        //         });

        //         console.log('📦 ส่งสำเร็จ:', res.data);

        //         return;

        //         if (res.data.success === true) {
        //             Swal.fire({
        //                 icon: 'success',
        //                 title: 'ส่งข้อมูลสำเร็จ',
        //                 text: 'ข้อมูลที่อยู่ถูกบันทึกเรียบร้อยแล้ว',
        //             });

        //             const address_id = res.data.id;
        //             localStorage.setItem('address_id', address_id);

        //             // ✅ ก้อนข้อมูลสำหรับ Mac Five (ใช้ addressData และข้อมูลจาก selectedAddress)
        //             const addressBulidMacFive = {
        //                 DC_code: getCustomer_no,
        //                 DC_id: address_id,
        //                 DC_add1: addressData.detail,
        //                 DC_add2: `แขวง ${subDistrict} ${district}`,
        //                 DC_add3: province,
        //                 DC_tel: addressData.phone || getMobile,
        //                 DC_zone: '', // เพิ่ม zone หากมีข้อมูล
        //             };

        //             console.log('📦 addressBulidMacFive:', addressBulidMacFive);

        //             const token = await this.getAuthToken();
        //             const formEncodedData = qs.stringify(addressBulidMacFive);

        //             try {
        //                 const response = await axios.post(`${BASE_URL_DELIVERY_ADDRESS}`, formEncodedData, {
        //                     headers: {
        //                         'Content-Type': 'application/x-www-form-urlencoded',
        //                         'Authorization': `Bearer ${token}`
        //                     }
        //                 });

        //                 console.log('📦 ส่งข้อมูลไป Mac Five สำเร็จ:', response.data);

        //                 this.$emit('submitted', addressBulidMacFive);
        //                 this.$emit('close');
        //             } catch (err) {
        //                 console.error('❌ ส่งไป Mac Five ไม่สำเร็จ:', err);
        //                 alert('เกิดข้อผิดพลาดในการส่งข้อมูลไปยัง Mac Five');
        //             }


        //         } else {
        //             Swal.fire({
        //                 icon: 'error',
        //                 title: 'เกิดข้อผิดพลาด',
        //                 text: 'ไม่สามารถบันทึกข้อมูลที่อยู่ได้',
        //             });
        //         }

        //         // UPDATE ที่อยู่เดิม
        //         // const updatePayload = {
        //         //     id: addressId,
        //         //     DC_code: getCustomer_no,
        //         //     DC_id: getCustomer_id,
        //         //     DC_add1: this.form.detail,
        //         //     DC_add2: `แขวง ${subDistrict} ${district}`,
        //         //     DC_add3: province,
        //         //     DC_tel: getMobile,
        //         //     DC_zone: '',
        //         // };
        //         this.selectedAddress = {
        //             id: data.DC_id,
        //             detail: data.DC_add1,
        //             province_id: this.findProvinceId(data.DC_add3),
        //             amphure_id: this.findAmphureId(data.DC_add2),
        //             tambon_id: this.findTambonId(data.DC_add2),
        //             phone: data.DC_tel,
        //         };

        //         const updatePayload = this.selectedAddress;

        //         console.log('📦 ข้อมูลที่อยู่:', updatePayload);

        //         try {

        //             const res = await axios.post(`${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/update_delivery_address.php`, updatePayload);

        //             console.log('📦 update สำเร็จ:', res.data);

        //             console.log('✅ res.data.success =', res.data.success);
        //             console.log('✅ typeof res.data.success =', typeof res.data.success);


        //             if (res.data.success) {
        //                 // Swal.fire({ icon: 'success', text: 'อัปเดตข้อมูลที่อยู่เรียบร้อยแล้ว' });
        //                 Swal.fire({
        //                     icon: 'success',
        //                     title: 'อัปเดทข้อมูลสำเร็จ',
        //                     text: 'อัปเดทข้อมูล ที่อยู่ ถูกบันทึกเรียบร้อยแล้ว',
        //                 });

        //                 // ✅ ดึงข้อมูลล่าสุดที่ถูกอัปเดตจาก backend
        //                 const updatedData = res.data;
        //                 console.log('📦 ข้อมูลที่อัปเดตล่าสุด:', res.data);
        //                 console.log('📦 ข้อมูลที่อัปเดตล่าสุด:', updatedData);

        //                 // return;

        //                 localStorage.setItem('address_id', res.data.id)

        //                 // ✅ ก้อนข้อมูลที่อยู่สำหรับ Mac Five
        //                 const addressBulidMacFive = {
        //                     DC_code: res.data.data.customer_code, //'DEL-REST-01', // AP 
        //                     DC_id: res.data.data.id,  //'0001', // ID ของที่อยู่ ใน table delivery_address
        //                     DC_add1: res.data.data.address_line1,
        //                     DC_add2: res.data.data.address_line2, //เขต
        //                     DC_add3: res.data.data.address_line3, //10500, // รหัสไปรษณีย์
        //                     DC_tel: res.data.data.phone, //'029797000',
        //                     DC_zone: res.data.data.zone_code || '', //'ZON-TEST-01'
        //                 };

        //                 console.log('📦 addressBulidMacFive:', addressBulidMacFive);

        //                 // return;

        //                 const formJsonData = addressBulidMacFive;

        //                 // return;

        //                 // 1. 🔃 สร้าง addressBulidMacFive → qs.stringify แล้วยิงไป Mac Five
        //                 const formEncodedData = qs.stringify(addressBulidMacFive);

        //                 // 2. ✅ เรียกใช้ token ก่อนยิง API ไป Mac Five
        //                 const token = await this.getAuthToken();
        //                 // return; // สำหรับทดสอบไม่ให้ส่งข้อมูลจริง

        //                 //Api Mac 5 
        //                 try {
        //                     const response = await axios.post(`${BASE_URL_DELIVERY_ADDRESS}`, formEncodedData, {
        //                         headers: {
        //                             'Content-Type': 'application/x-www-form-urlencoded',
        //                             'Authorization': `Bearer ${token}` // ถ้าต้องการใช้ token ใน header
        //                         }
        //                     });
        //                     console.log('📦 ส่งสำเร็จ:', response.data);

        //                     // return; // สำหรับทดสอบไม่ให้ส่งข้อมูลจริง

        //                     // localStorage.setItem('deliveryAddress', response.data);
        //                     this.$emit('submitted', formJsonData);
        //                     this.$emit('close');
        //                 } catch (err) {
        //                     console.error('❌ ส่งไม่สำเร็จ:', err);
        //                     alert('เกิดข้อผิดพลาดในการส่งข้อมูล');
        //                 }
        //             }
        //         } catch (error) {
        //             console.error('❌ ส่งไม่สำเร็จ:', err);
        //             alert('เกิดข้อผิดพลาดในการส่งข้อมูล');
        //         }

        //     } catch (err) {
        //         console.error('❌ ส่งไม่สำเร็จ:', err);
        //         alert('เกิดข้อผิดพลาดในการส่งข้อมูล');
        //     }
        // },



        ////////////////////////////////////////////////////////
        // async confirmFinalSave() {
        //     const result = await Swal.fire({
        //         title: 'คุณแน่ใจหรือไม่?',
        //         text: "หลังจากยืนยัน จะไม่สามารถแก้ไขข้อมูลนี้ได้อีก",
        //         icon: 'warning',
        //         showCancelButton: true,
        //         confirmButtonText: 'ยืนยัน',
        //         cancelButtonText: 'ยกเลิก'
        //     });

        //     if (result.isConfirmed) {
        //         // 🔒 แกล้งทำเหมือนว่ามี API บันทึกสถานะ lock (คุณสามารถต่อ API จริงได้)
        //         const docNo = this.formData.documentNo;
        //         this.isReadOnly = true;
        //         this.isConfirmed = true;

        //         // เก็บไว้ใน localStorage เพื่อกัน user กลับมาแก้ใหม่
        //         const locked = JSON.parse(localStorage.getItem('lockedDocumentNos') || '[]');
        //         if (!locked.includes(docNo)) {
        //             locked.push(docNo);
        //             localStorage.setItem('lockedDocumentNos', JSON.stringify(locked));
        //         }

        //         Swal.fire('สำเร็จ!', 'รายการถูกล็อกแล้ว', 'success');
        //     }
        // },

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
                    `${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/lock_document.php`,
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

                const token = await this.getAuthToken();
                console.log("🔑 token", token);

                console.log("🧪 Selected Products:", this.selectedProducts.length);
                console.log("🎁 Gifts:", this.formData.gifts?.length); // ,this.formData.gifts
                console.log("📢 Promotions:", this.formData.promotions?.length); //, this.formData.promotions
                console.log("🧪 Address:", this.selectedAddress); //, this.formData.selectedAddress
                console.log("🧪 Address:", this.selectedAddress?.length); //, this.formData.selectedAddress


                // 3. 📦 สร้าง payload ข้อมูล Macfive
                const payload = this.buildMacfivePayload();

                console.log("📦 Payload ที่จะส่งไปยัง Macfive:", payload);

                return

                // 4. 🚀 ส่งไปยัง BASE_URL_MAC_FIVEL
                const macfiveResponse = await axios.post(`${BASE_URL_MAC_FIVEL}`, payload, {
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                        'Authorization': `Bearer ${token}`
                    }
                });

                console.log("✅ Macfive ส่งสำเร็จ", macfiveResponse.data);

            } catch (err) {
                const message = err.response?.data?.message || err.message || 'เกิดข้อผิดพลาด';
                Swal.fire('ผิดพลาด', message, 'error');
            }

        },
        // },

        buildMacfivePayload() {
            const now = new Date();
            const formatDate = (d) => d.toISOString().slice(0, 10);
            const formatDateTime = (d) => d.toISOString().slice(0, 19).replace("T", " ");

            const docNo = this.formData.documentNo;
            const sale_no = localStorage.getItem('account') || ''
            console.log('Check sale_no: ', sale_no);

            return {
                hrows: {
                    MH_date: formatDateTime(now),
                    MH_type: "PS",
                    MH_vnumber: docNo,
                    MH_process: 5,
                    MH_supcus: this.formData.customerCode,
                    MH_noItems: 5,
                    // MH_noItems: this.formData.productList.length,
                    MH_vatRate: 7,
                    MH_vatTotal: parseFloat(this.formData.final_total_price) * 0.07,
                    MH_netTotal: parseFloat(this.formData.final_total_price),
                    MH_status: 15,
                    MH_per: sale_no, //"DP001", // รหัสเซลล์
                    MH_site: 1655, // ที่อยู่จัดส่ง
                    MH_deldate: formatDate(now), // วันที่สร้าง
                    MH_totalCOG: parseFloat(this.formData.final_total_price),  // ยอดรวม
                    MH_discT1: 0,
                    MH_discF1: 0,
                    MH_discT2: 6.54205,
                    MH_discF2: parseFloat(this.formData.final_total_price) * 0.07,
                    MH_flow: 0,
                    MH_cur: 0,
                    MH_Note: `// ${docNo}`,
                    MH_cnect: 3,
                    MH_cancel: 0
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
                    ME_ccRec: parseFloat(this.formData.final_total_price) // ยอดรวม
                },
                krows: {
                    MK_date: formatDateTime(now), //2025\/06\/30 16:13:13
                    MK_name: this.formData.fullName, // 1
                    // MK_addr: this.formData.address, //ที่อยู่
                    MK_addr: 1, //ที่อยู่
                    // MK_tel: this.formData.phone // 1
                    MK_tel: 1 // 1
                },
                lrows: [
                    ...this.selectedProducts.map((item, index) => ({
                        ML_date: formatDateTime(now),
                        ML_type: "PS",
                        ML_vnumber: docNo, //เลขที่เอกสาร
                        ML_per: sale_no,//"DP001", // รหัสเซลล์
                        ML_supcus: this.formData.customerCode, // รหัสลูกค้า ที่เลือกร้าน
                        ML_stk: item.pro_sn || "N/A", //รหัสสินค้า SN
                        ML_sto: "MAIN",
                        ML_item: index + 1, // อันดับรายการ
                        ML_quan: parseFloat(item.pro_quantity), // จำนวนรายการ
                        ML_cog: parseFloat(item.pro_total_price || 0), // ราคารวม
                        ML_netL: parseFloat(item.pro_total_price || 0), // ราคารวม
                        ML_cut: 1,
                        ML_unit: item.pro_unit,// || "PCS", //หน่วย
                        ML_des: item.pro_erp_title, // ชื่อสินค้า erp-title
                        ML_addcost: 0,
                        ML_discL: 0,
                        ML_deldate: formatDate(now), // วันที่สร้าง
                        ML_uprice: parseFloat(item.pro_unit_price), // ราคารวม
                        ML_Note: "item",

                    })),

                    // 2. 🎁 ของแถม
                    ...this.formData.gifts.map((gift, index) => ({
                        ML_date: formatDateTime(now),
                        ML_type: "PS",
                        ML_vnumber: docNo,
                        ML_per: sale_no, //"DP001",
                        ML_supcus: this.formData.customerCode,
                        ML_stk: gift.pro_sn || "N/A",
                        ML_sto: "MAIN",
                        ML_item: this.selectedProducts.length + index + 1,
                        ML_quan: parseFloat(gift.pro_goods_num),
                        ML_cog: 0,
                        ML_netL: 0,
                        ML_cut: 0,
                        ML_unit: gift.pro_unit, //"PCS",
                        ML_des: gift.title,
                        ML_addcost: 0,
                        ML_discL: 0,
                        ML_deldate: formatDate(now),
                        ML_uprice: 0,
                        ML_Note: gift.ML_Note || "gift"
                    })),

                    // 3. 📢 โปรโมชั่น
                    ...this.formData.promotions.map((promo, index) => ({
                        ML_date: formatDateTime(now),
                        ML_type: "PS",
                        ML_vnumber: docNo,
                        ML_per: sale_no, //"DP001",
                        ML_supcus: this.formData.customerCode,
                        ML_stk: promo.pro_sn || "N/A",
                        ML_sto: "MAIN",
                        ML_item: this.selectedProducts.length + this.formData.gifts.length + index + 1,
                        ML_quan: parseFloat(promo.pro_goods_num),
                        ML_cog: 0,
                        ML_netL: 0,
                        ML_cut: 0,
                        ML_unit: promo.pro_unit, //"PCS",
                        ML_des: promo.title,
                        ML_addcost: 0,
                        ML_discL: 0,
                        ML_deldate: formatDate(now),
                        ML_uprice: 0,
                        ML_Note: promo.ML_Note || "promotion"

                    }))
                    // }))
                ]
            };

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

            try {

                this.formData.productList = this.selectedProducts.map(product => {

                    const total = this.totalprice(product);

                    console.log('✅ check: product', product);

                    return {
                        item_id: product.item_id ?? 0, // ✅ ใส่ id เดิมถ้ามี
                        pro_id: product.pro_id,
                        pro_erp_title: product.pro_erp_title,
                        pro_name: product.pro_erp_title,
                        pro_quantity: product.pro_quantity,
                        pro_unit_price: product.pro_unit_price,
                        pro_discount: this.formData.discount,
                        pro_total_price: total, // รวมราคาต่อสินค้า
                        pro_images: product.pro_images,
                        pro_sn: product.pro_sn,
                        pro_units: product.pro_units,
                        pro_activity_id: product.pro_activity_id || 0 // ✅ เพิ่มบรรทัดนี้!
                    };
                });


                console.log("🔍sadsadsa log value this.productList:", this.formData.productList)

                this.formData.final_total_price = this.grandTotal;

                const { promotions, gifts } = this.extractPromotionsAndGifts();
                this.formData.promotions = promotions;
                this.formData.gifts = gifts;

                const payload = new FormData();
                // for (const key in this.formData) {
                //     if (key === 'productList') {
                //         // payload.append('productList', JSON.stringify(this.formData.productList));
                //         // ✅ แปลง proxy เป็น array ปกติก่อน stringify
                //         payload.append('productList', JSON.stringify([...this.formData.productList]));
                //     } else {
                //         payload.append(key, this.formData[key]);
                //     }
                // }
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
                } else if (!this.selectedAddress || Object.keys(this.selectedAddress).length === 0) {
                    Swal.fire({
                        icon: 'warning',
                        title: 'กรุณาเลือกที่อยู่จัดส่ง',
                    });
                }

                // ✅ เพิ่ม selectedAddress เข้าไป
                payload.append('deliveryAddress', JSON.stringify(this.selectedAddress));

                // console.log("🤯 Log Value payload: ", payload);

                // ✅ log payload ทั้งหมดแบบอ่านได้
                // console.log("📦🤯 Log payload entries:");
                // for (const [key, value] of payload.entries()) {
                //     console.log(`${key}:`, value);
                // }

                console.log("🛒 productList:", this.formData.productList);
                console.log(JSON.stringify(payload))

                const response = await axios.post(
                    `${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/update_sale_order.php`,
                    payload
                );

                const resData = typeof response.data === 'string' ? JSON.parse(response.data) : response.data;

                console.log("🔍 Response จาก API:", resData);

                if (resData.success) {
                    const newDocumentNo = resData.newDocumentNo; // ดึง `documentNo` ใหม่จาก API
                    this.formData.documentNo = newDocumentNo; // อัปเดต `documentNo` ใน `formData`

                    // อัปเดต URL ไปยัง `saleList` พร้อม `documentNo` ใหม่
                    this.$router.push(`/saleList?documentNo=${newDocumentNo}`);

                    Swal.fire({ text: resData.message, icon: 'success' });
                    this.isReadOnly = true; // ปิดการแก้ไขหลังบันทึกสำเร็จ
                } else {
                    Swal.fire({ text: resData.message, icon: 'error' });
                }

                // await this.AddressUpdaateData(this.selectedAddress);
            } catch (err) {
                const message = err.response?.data?.message || err.message || 'Unknown error';
                Swal.fire({ text: message, icon: 'error' });
            }
        },

        async loadDocumentData(documentNo) {
            try {

                const response = await axios.get(`${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/get_sale_order.php?documentNo=${documentNo}`);

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
                        deliveryDate: resData.data.order.delivery_date || '',
                        trackingNo: resData.data.order.tracking_no || '',
                        deliveryType: resData.data.order.delivery_type || '',
                        totalDiscount: resData.data.order.total_discount || 0,
                        deliveryFee: resData.data.order.delivery_fee || 0,
                        final_total_price: resData.data.order.final_total_price || 0,
                        documentNo: resData.data.order.document_no || '',

                        //
                        promotions: resData.data.promotions || [],
                        gifts: resData.data.gifts || []
                        // this.formData.promotions = resData.data.promotions || [],
                        // this.formData.gifts = resData.data.gifts || []
                    };

                    // เติมข้อมูลสินค้า
                    // this.selectedProducts = resData.data.productList || [];

                    // เติมข้อมูลสินค้า โดยแมปให้ตรงกับโครงสร้างที่ใช้ใน Vue
                    // this.selectedProducts = resData.data.productList.map(product => ({
                    //     pro_id: product.pro_id,
                    //     pro_erp_title: product.pro_name,
                    //     pro_quantity: product.qty,
                    //     pro_unit_price: parseFloat(product.unit_price),
                    //     pro_discount: parseFloat(product.discount),
                    //     pro_total_price: parseFloat(product.total_price),
                    //     pro_images: product.pro_images,
                    //     pro_sn: product.sn,
                    //     unit: product.unit || ''
                    // }));

                    console.log("📄 ข้อมูลเอกสารที่โหลด:", resData.data.productList);

                    // const getSite_id = resData.data.data.deliveryAddress;
                    // console.log("📄 ข้อมูล Docmentที่โหลด:", getSite_id);

                    console.log("🔍 ก่อน map this.selectedProducts:", this.selectedProducts);


                    this.selectedProducts = resData.data.productList.map(product => {

                        console.log("🛠️ กำลัง map product:", product); // 👈 log ตรงนี้เช็กแต่ละตัว
                        // const matchedPromotions = (resData.data.promotions || []).filter(p => p.pro_activity_id === product.pro_activity_id);
                        // const matchedPromotions = (resData.data.promotions || []).filter(p => {
                        //     console.log("🔍 เช็ก promo.pro_activity_id =", p.pro_activity_id, "vs product =", product.pro_activity_id);
                        //     return p.pro_activity_id === product.pro_activity_id;
                        // });

                        // const matchedGifts = (resData.data.gifts || []).filter(g => g.pro_activity_id === product.pro_activity_id);

                        // console.log("🔍 เช็ก matchedGifts =", matchedGifts);
                        // console.log("🔍 เช็ก matchedPromotions =", matchedPromotions);

                        const productObj = {
                            item_id: product.id,
                            pro_id: product.pro_id,
                            pro_erp_title: product.pro_name,
                            pro_quantity: product.qty,
                            pro_unit_price: parseFloat(product.unit_price),
                            pro_discount: parseFloat(product.discount),
                            pro_total_price: parseFloat(product.total_price),
                            pro_images: product.pro_images,
                            pro_sn: product.sn,
                            pro_unit: product.unit || '',
                            activity_id: product.pro_activity_id || null,
                            pro_activity_id: product.pro_activity_id || 0, // ✅ ใช้ชื่อนี้ให้ตรง backend
                            pro_goods_sku_text: product.pro_goods_sku_text || '',
                            // promotions: matchedPromotions,
                            // gifts: matchedGifts
                            // ✅ ดึงจาก product โดยตรง
                            promotions: product.promotions || [],
                            gifts: product.gifts || []
                        };

                        console.log("🎁 productObj:", productObj); // <--- สำคัญ
                        return productObj;



                        // return {
                        //     pro_id: product.pro_id,
                        //     pro_erp_title: product.pro_name,
                        //     pro_quantity: product.qty,
                        //     pro_unit_price: parseFloat(product.unit_price),
                        //     pro_discount: parseFloat(product.discount),
                        //     pro_total_price: parseFloat(product.total_price),
                        //     pro_images: product.pro_images,
                        //     pro_sn: product.sn,
                        //     unit: product.unit || '',
                        //     activity_id: product.pro_activity_id || null,
                        //     pro_activity_id: product.pro_activity_id || null, // ✅ ใช้ชื่อนี้ให้ตรง backend
                        //     pro_goods_sku_text: product.pro_goods_sku_text || '',
                        //     promotions: matchedPromotions,
                        //     gifts: matchedGifts
                        // };
                    });

                    // ใส่ promotions และ gifts ลงในแต่ละกลุ่ม (ถ้าใช้ groupByActivityId)
                    // const grouped = this.groupByActivityId(this.selectedProducts);
                    // for (const activityId in grouped) {
                    //     if (grouped[activityId]?.length) {
                    //         grouped[activityId][0].promotions = resData.data.promotions || [];
                    //         grouped[activityId][0].gifts = resData.data.gifts || [];
                    //     }
                    // }

                    // console.log("📦 ข้อมูลสินค้า:", grouped);

                    // console.log("🧾 this.formData.productList (ส่งเข้า backend):", this.formData.productList);

                    // 👉 เติมข้อมูล promotions และ gifts ให้กับสินค้า index 0 เท่านั้น (ต่อกลุ่ม)
                    // if (this.selectedProducts.length > 0) {
                    //     this.selectedProducts[0].promotions = this.formData.promotions;
                    //     this.selectedProducts[0].gifts = this.formData.gifts;
                    // }

                    console.log("📄 ข้อมูลเอกสารที่โหลด:", this.formData);
                    console.log("🛒 รายการสินค้า:", this.selectedProducts);
                } else {
                    Swal.fire({ text: resData.message, icon: 'error' });
                }
            } catch (err) {
                const message = err.response?.data?.message || err.message || 'เกิดข้อผิดพลาดในการโหลดข้อมูลเอกสาร';
                Swal.fire({ text: message, icon: 'error' });
            }
        },

        // new function 
        extractPromotionsAndGifts() {
            const grouped = this.groupByActivityId(this.selectedProducts);
            const allPromotions = [];
            const allGifts = [];

            for (const group of Object.values(grouped)) {
                if (group[0].promotions && Array.isArray(group[0].promotions)) {
                    for (const promo of group[0].promotions) {
                        allPromotions.push({

                            title: promo.title,
                            ML_Note: promo.ML_Note || '',
                            note: promo.note || '',
                            pro_activity_id: promo.pro_activity_id || null,
                            pro_goods_id: promo.pro_goods_id || 0,
                            pro_goods_num: promo.pro_goods_num || 0,
                            pro_image: promo.pro_image || '',
                            pro_sku_price_id: promo.pro_sku_price_id || null,
                            user_id: promo.user_id || null,

                        });
                    }
                }

                if (group[0].gifts && Array.isArray(group[0].gifts)) {
                    for (const gift of group[0].gifts) {
                        allGifts.push({
                            title: gift.title,
                            pro_goods_num: gift.pro_goods_num || 0,
                            pro_image: gift.pro_image || '',
                            ML_Note: gift.ML_Note || '',
                            note: gift.note || '',
                            pro_activity_id: gift.pro_activity_id || null,
                            pro_goods_id: gift.pro_goods_id || 0,
                            pro_sku_price_id: gift.pro_sku_price_id || null,
                            user_id: gift.user_id || null,
                        });
                    }
                }
            }

            return {
                promotions: allPromotions,
                gifts: allGifts
            };
        },



        addSelectedProducts(products) {
            products.forEach(p => {
                const alreadyExists = this.selectedProducts.some(sp => sp.pro_id === p.pro_id);
                if (!alreadyExists) {
                    this.selectedProducts.push(p);
                }
            });
        },

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

        // findProvinceId(name) {
        //     const match = this.$refs.addressPopup?.rawData?.find(p => p.name_th === name);
        //     return match?.id || '';
        // },
        // findAmphureId(name) {
        //     const allAmphures = this.$refs.addressPopup?.rawData?.flatMap(p => p.amphure);
        //     const match = allAmphures?.find(a => name.includes(a.name_th));
        //     return match?.id || '';
        // },
        // findTambonId(name) {
        //     const allTambons = this.$refs.addressPopup?.rawData?.flatMap(p => p.amphure.flatMap(a => a.tambon));
        //     const match = allTambons?.find(t => name.includes(t.name_th));
        //     return match?.id || '';
        // },

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
            console.log('📍 ที่อยู่ที่เลือก:', this.formData.receiverAddress);
            console.log('📍object ที่อยู่ที่เลือก:', this.selectedAddress);

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
        async handleSelectedPromotionProducts(payload) {
            console.log('📦 payload ที่ได้รับ ที่ได้รับจาก Promotion_ProductSelector:', payload);

            const items = payload.items || [];
            // const gifts = payload.gifts || [];
            const giftsDay = payload.gifts || [];
            const promotions = payload.promotions || [];
            const emitTitles = payload.emitTitles || [];

            // const items = payload.items || [];
            // const itemsMonth = payload.itemsMonth || [];
            // const giftsDay = payload.giftsDay || [];
            // // const gifts = payload.gifts || [];
            // const giftsMonth = payload.giftsMonth || [];
            // const promotions = payload.promotions || [];
            // const promotionsMonth = payload.promotionsMonth || [];
            // const emitTitles = payload.emitTitles || [];


            // const {
            //     items,
            //     itemsMonth,
            //     giftsDay,
            //     giftsMonth,
            //     promotionsDay,
            //     promotionsMonth,
            //     emitTitles
            // } = payload;


            console.log("✅ payload:", payload);

            console.log("✅ Items:", items);
            console.log("✅ Gifts:", giftsDay);
            console.log("✅ Promotions:", promotions);
            console.log("✅ EmitTitles:", emitTitles);

            // items.forEach(item => {
            //     // const alreadyExists = this.selectedProducts.some(sp => sp.pro_id === item.pro_sku_price_id);

            //     // หา emit title ที่ตรงกับสินค้า
            //     const matchedTitle = emitTitles.find(emit => emit.pro_goods_id == item.pro_goods_id) || {};

            //     // 👇 ตรวจซ้ำโดยใช้ sku_id + activity_id
            //     // const alreadyExists = this.selectedProducts.find(sp =>

            //     //     sp.pro_id === item.pro_sku_price_id && sp.activity_id === item.pro_activity_id 
            //     // );
            //     const activityId = item.st === false ? 0 : item.pro_activity_id;

            //     console.log('item.pro_activity_id', item.pro_activity_id);
            //     console.log('activityId', activityId);


            //     const alreadyExists = this.selectedProducts.find(sp =>
            //         sp.pro_id === item.pro_sku_price_id &&
            //         sp.activity_id === activityId &&
            //         sp.st === item.st // ✅ ตรวจ st ด้วย
            //     );
            //     console.log("🧮 Chack selectedProducts: ", this.selectedProducts);
            //     console.log("🧮 Chack pro_sku_price_id: ", item.pro_sku_price_id);

            //     console.log("🧮 Chack pro_activity_id: ", item.pro_activity_id);
            //     console.log("🧮 Chack alreadyExists: ", alreadyExists);
            //     console.log("sss Chack item.st: ", item.st);
            //     // const alreadyExists = this.selectedProducts.some(sp =>
            //     //     sp.pro_id === item.pro_sku_price_id && sp.activity_id === item.pro_activity_id
            //     // );

            //     // if (!alreadyExists) {
            //     if (alreadyExists) {
            //         // 🔁 ถ้ามีอยู่แล้ว → บวกจำนวนเพิ่ม
            //         alreadyExists.pro_quantity = parseInt(alreadyExists.pro_quantity) + parseInt(item.pro_goods_num || 0);
            //         console.log("🧮 เดิม:", alreadyExists.pro_quantity, "เพิ่ม:", item.pro_goods_num);
            //         Swal.fire({
            //             icon: 'info',
            //             title: 'เพิ่มจำนวนสินค้าอยู่ในรายการแล้ว',
            //             text: `เพิ่มจำนวนสินค้า ${matchedTitle.pro_erp_title || item.pro_erp_title || ''} เป็น ${alreadyExists.pro_quantity} ชิ้น`,
            //         });
            //         // this.selectedProducts.push({ 
            //         //     pro_quantity: item.pro_quantity += item.pro_goods_num || 0,
            //         // });

            //     } else {

            //         this.selectedProducts.push({
            //             item_id: 0, // 📌 ใช้ 0 ชั่วคราว กรณียังไม่ไม่ได้เพิ่มตัวของสินค้าลง Database 
            //             pro_id: item.pro_sku_price_id,
            //             activity_id: (item.st === false || item.st === 'false' || item.st == null) ? 0 : item.pro_activity_id, //activityId ,
            //             // activity_id: item.st == false?0 : activityId, //activityId ,
            //             pro_activity_id: (item.st === false || item.st === 'false' || item.st == null) ? 0 : item.pro_activity_id,
            //             // pro_activity_id: activityId,
            //             st: item.st, // ✅ เก็บค่า st ไว้ด้วย
            //             pro_erp_title: matchedTitle.pro_erp_title || item.pro_erp_title || '',
            //             pro_unit_price: item.pro_goods_price || item.pro_goods_price || '',
            //             pro_goods_sku_text: item.pro_goods_sku_text || '',
            //             pro_sn: matchedTitle.pro_sn || item.pro_sn || '',
            //             pro_images: item.pro_image || '',
            //             pro_quantity: item.pro_goods_num || 0,
            //             pro_units: matchedTitle.pro_units || item.pro_units || '',
            //             pro_stock: matchedTitle.stock || 0,
            //             gifts: giftsDay,
            //             // gifts: gifts.filter(gift => gift.pro_activity_id == item.pro_activity_id),
            //             promotions: promotions,
            //             // promotions: promotions.filter(promo => promo.pro_activity_id == item.pro_activity_id),
            //             // promotions: promotions.filter(promo => promo.pro_activity_id == item.pro_activity_id),
            //         });


            //     }

            // });

            // console.log('📡 ส่ง selectedProductsToResend ไปยัง API:', this.selectedProducts);
            // await this.submittedProduct(this.selectedProducts);

            for (const item of items) {
                const activityId = item.st === false ? 0 : item.pro_activity_id;
                const matchedTitle = emitTitles.find(emit => emit.pro_goods_id == item.pro_goods_id) || {};

                // หา item ที่ pro_sn เดียวกันแต่ activity ต่างกัน
                const similarItem = this.selectedProducts.find(sp =>
                    sp.pro_sn === (matchedTitle.pro_sn || item.pro_sn) &&
                    sp.activity_id !== activityId
                );

                const alreadyExists = this.selectedProducts.find(sp =>
                    sp.pro_id === item.pro_sku_price_id &&
                    sp.activity_id === activityId &&
                    sp.st === item.st
                );

                const caseType = (() => {
                    if (this.selectedProducts.length === 0) return 'EMPTY';
                    if (alreadyExists) return 'EXISTS';
                    if (similarItem) return 'SIMILAR_SN_DIFFERENT_ACTIVITY';
                    return 'NEW';
                })();

                switch (caseType) {
                    case 'EMPTY':
                    case 'NEW':
                        this.selectedProducts.push({
                            item_id: 0,
                            pro_id: item.pro_sku_price_id,
                            activity_id: activityId,
                            pro_activity_id: item.pro_activity_id,
                            st: item.st,
                            pro_erp_title: matchedTitle.pro_erp_title || item.pro_erp_title || '',
                            pro_unit_price: item.pro_goods_price || '',
                            pro_goods_sku_text: item.pro_goods_sku_text || '',
                            pro_sn: matchedTitle.pro_sn || item.pro_sn || '',
                            pro_images: item.pro_image || '',
                            pro_quantity: item.pro_goods_num || 0,
                            pro_units: matchedTitle.pro_units || item.pro_units || '',
                            pro_stock: matchedTitle.stock || 0,
                            gifts: giftsDay,
                            promotions: promotions
                        });
                        break;

                    case 'EXISTS':
                        alreadyExists.pro_quantity = parseInt(alreadyExists.pro_quantity) + parseInt(item.pro_goods_num || 0);
                        Swal.fire({
                            icon: 'info',
                            title: 'เพิ่มจำนวนสินค้าอยู่ในรายการแล้ว',
                            text: `เพิ่มจำนวนสินค้า ${matchedTitle.pro_erp_title || item.pro_erp_title || ''} เป็น ${alreadyExists.pro_quantity} ชิ้น`,
                        });
                        break;

                    case 'SIMILAR_SN_DIFFERENT_ACTIVITY':
                        const selectedProductsToResend = [
                            JSON.parse(JSON.stringify(similarItem)),
                            {
                                item_id: 0,
                                pro_id: item.pro_sku_price_id,
                                activity_id: activityId,
                                pro_activity_id: item.pro_activity_id,
                                st: item.st,
                                pro_erp_title: matchedTitle.pro_erp_title || item.pro_erp_title || '',
                                pro_unit_price: item.pro_goods_price || '',
                                pro_goods_sku_text: item.pro_goods_sku_text || '',
                                pro_sn: matchedTitle.pro_sn || item.pro_sn || '',
                                pro_images: item.pro_image || '',
                                pro_quantity: item.pro_goods_num || 0,
                                pro_units: matchedTitle.pro_units || item.pro_units || '',
                                pro_stock: matchedTitle.stock || 0,
                                gifts: giftsDay,
                                promotions: promotions
                            }
                        ];

                        console.log('🚨 พบสินค้า pro_sn เดียวกัน แต่ activity_id ต่างกัน');
                        console.log('📦 เก่า:', similarItem);
                        console.log('📦 ใหม่:', item);
                        console.log('📡 ส่ง selectedProductsToResend ไปยัง API:', selectedProductsToResend);

                        await this.submittedProduct(selectedProductsToResend);
                        return;
                    // const selectedProductsToResend = [];

                    // if (similarItem) {
                    //     selectedProductsToResend.push(similarItem);
                    // }

                    // selectedProductsToResend.push({
                    //     item_id: 0,
                    //     pro_id: item.pro_sku_price_id,
                    //     activity_id: activityId,
                    //     pro_activity_id: item.pro_activity_id,
                    //     st: item.st,
                    //     pro_erp_title: matchedTitle.pro_erp_title || item.pro_erp_title || '',
                    //     pro_unit_price: item.pro_goods_price || '',
                    //     pro_goods_sku_text: item.pro_goods_sku_text || '',
                    //     pro_sn: matchedTitle.pro_sn || item.pro_sn || '',
                    //     pro_images: item.pro_image || '',
                    //     pro_quantity: item.pro_goods_num || 0,
                    //     pro_units: matchedTitle.pro_units || item.pro_units || '',
                    //     pro_stock: matchedTitle.stock || 0,
                    //     gifts: giftsDay,
                    //     promotions: promotions
                    // });

                    // console.log('🚨 พบสินค้า pro_sn เดียวกัน แต่ activity_id ต่างกัน');
                    // console.log('📦 เก่า:', similarItem);
                    // console.log('📦 ใหม่:', item);
                    // console.log('📡 ส่ง selectedProductsToResend ไปยัง API:', selectedProductsToResend);

                    // await this.submittedProduct(selectedProductsToResend);
                    // return; // ✅ หยุด loop และออกจากฟังก์ชัน
                }
            }


            // items.forEach(item => {
            //     const activityId = item.st === false ? 0 : item.pro_activity_id;
            //     const matchedTitle = emitTitles.find(emit => emit.pro_goods_id == item.pro_goods_id) || {};

            //     // หา item ที่ pro_sn เดียวกัน
            //     const similarItem = this.selectedProducts.find(sp =>
            //         sp.pro_sn === (matchedTitle.pro_sn || item.pro_sn) &&
            //         sp.activity_id !== activityId
            //     );

            //     const alreadyExists = this.selectedProducts.find(sp =>
            //         sp.pro_id === item.pro_sku_price_id &&
            //         sp.activity_id === activityId &&
            //         sp.st === item.st
            //     );

            //     const caseType = (() => {
            //         if (this.selectedProducts.length === 0) return 'EMPTY';
            //         if (alreadyExists) return 'EXISTS';
            //         if (similarItem) return 'SIMILAR_SN_DIFFERENT_ACTIVITY';
            //         return 'NEW';
            //     })();

            //     switch (caseType) {
            //         case 'EMPTY':
            //         case 'NEW':
            //             this.selectedProducts.push({
            //                 item_id: 0,
            //                 pro_id: item.pro_sku_price_id,
            //                 activity_id: activityId,
            //                 pro_activity_id: item.pro_activity_id,
            //                 st: item.st,
            //                 pro_erp_title: matchedTitle.pro_erp_title || item.pro_erp_title || '',
            //                 pro_unit_price: item.pro_goods_price || '',
            //                 pro_goods_sku_text: item.pro_goods_sku_text || '',
            //                 pro_sn: matchedTitle.pro_sn || item.pro_sn || '',
            //                 pro_images: item.pro_image || '',
            //                 pro_quantity: item.pro_goods_num || 0,
            //                 pro_units: matchedTitle.pro_units || item.pro_units || '',
            //                 pro_stock: matchedTitle.stock || 0,
            //                 gifts: giftsDay,
            //                 promotions: promotions
            //             });
            //             break;

            //         case 'EXISTS':
            //             alreadyExists.pro_quantity = parseInt(alreadyExists.pro_quantity) + parseInt(item.pro_goods_num || 0);
            //             Swal.fire({
            //                 icon: 'info',
            //                 title: 'เพิ่มจำนวนสินค้าอยู่ในรายการแล้ว',
            //                 text: `เพิ่มจำนวนสินค้า ${matchedTitle.pro_erp_title || item.pro_erp_title || ''} เป็น ${alreadyExists.pro_quantity} ชิ้น`,
            //             });
            //             break;

            //         case 'SIMILAR_SN_DIFFERENT_ACTIVITY':
            //             const selectedProductsToResend = [];

            //             if (similarItem) {
            //                 selectedProductsToResend.push(similarItem);
            //             }

            //             selectedProductsToResend.push({
            //                 item_id: 0,
            //                 pro_id: item.pro_sku_price_id,
            //                 activity_id: activityId,
            //                 pro_activity_id: item.pro_activity_id,
            //                 st: item.st,
            //                 pro_erp_title: matchedTitle.pro_erp_title || item.pro_erp_title || '',
            //                 pro_unit_price: item.pro_goods_price || '',
            //                 pro_goods_sku_text: item.pro_goods_sku_text || '',
            //                 pro_sn: matchedTitle.pro_sn || item.pro_sn || '',
            //                 pro_images: item.pro_image || '',
            //                 pro_quantity: item.pro_goods_num || 0,
            //                 pro_units: matchedTitle.pro_units || item.pro_units || '',
            //                 pro_stock: matchedTitle.stock || 0,
            //                 gifts: giftsDay,
            //                 promotions: promotions
            //             });

            //             console.log('🚨 พบสินค้า pro_sn เดียวกัน แต่ activity_id ต่างกัน');
            //             console.log('📦 เก่า:', similarItem);
            //             console.log('📦 ใหม่:', item);
            //             console.log('📡 ส่ง selectedProductsToResend ไปยัง API:', selectedProductsToResend);

            //             await this.submittedProduct(selectedProductsToResend);
            //             return; // ✅ หยุด loop ทันที
            //     }
            // });



            // return; // ✅ หยุดการเพิ่มใหม่ เพราะรอข้อมูลจาก API

            // items.forEach(async item => {
            //     const matchedTitle = emitTitles.find(emit => emit.pro_goods_id == item.pro_goods_id) || {};
            //     const activityId = item.st === false ? 0 : item.pro_activity_id;

            //     console.log('this.selectedProducts:', this.selectedProducts);

            //     // 🔍 ตรวจว่ามีสินค้า pro_sn เดียวกัน + pro_activity_id เดียวกัน แต่ activity_id ไม่เหมือน
            //     const similarItem = this.selectedProducts.find(sp =>
            //         sp.pro_sn === item.pro_sn && //
            //         sp.pro_activity_id === item.pro_activity_id &&
            //         sp.activity_id !== activityId && // 🔁 ต่างกันตรงนี้
            //         sp.st !== item.st

            //     );
            //     // const similarItem = this.selectedProducts.find(sp =>
            //     //     sp.pro_sn === items.pro_sn && sp.activity_id == items.activity_id
            //     // );


            //     if (!similarItem) {
            //         // console.log('🧠 พบสินค้าเดิมใน selectedProducts');
            //         // console.log('📦 existing.pro_id:', similarItem.pro_id);
            //         // console.log('📦 existing.activity_id:', similarItem.activity_id);
            //         // console.log('📦 existing.st:', similarItem.st);
            //         // console.log('📦 existing.pro_quantity (ก่อนรวม):', similarItem.pro_quantity);
            //         // console.log('📦 item.pro_goods_num (ที่จะเพิ่ม):', item.pro_goods_num);
            //         // console.log('📦 ผลรวม (ถ้ารวม):', parseInt(existing.pro_quantity) + parseInt(item.pro_goods_num || 0));
            //     } else {
            //         console.log('🆕 ไม่พบสินค้าเดิม pro_id:', item.pro_sku_price_id, 'activity_id:', activityId, 'st:', item.st);
            //     }

            //     if (!similarItem) {

            //         console.log('🚨 พบสินค้า pro_sn เดียวกัน แต่ activity_id ต่างกัน');
            //         console.log('📦 เก่า:', this.selectedProducts);
            //         // console.log('📦 เก่า:', similarItem);
            //         console.log('📦 ใหม่:', item);

            //         this.selectedProducts.map(item => ({
            //             // {
            //             item_id: 0,
            //             pro_id: item.pro_sku_price_id,
            //             activity_id: activityId,
            //             pro_activity_id: item.pro_activity_id,
            //             st: item.st,
            //             pro_erp_title: matchedTitle.pro_erp_title || item.pro_erp_title || '',
            //             pro_unit_price: item.pro_goods_price || '',
            //             pro_goods_sku_text: item.pro_goods_sku_text || '',
            //             pro_sn: matchedTitle.pro_sn || item.pro_sn || '',
            //             pro_images: item.pro_image || '',
            //             pro_quantity: item.pro_goods_num || 0,
            //             pro_units: matchedTitle.pro_units || item.pro_units || '',
            //             pro_stock: matchedTitle.stock || 0,
            //             gifts: giftsDay,
            //             promotions: promotions
            //         }));
            //         // ];

            //         console.log('📡 ส่ง selectedProductsToResend ไปยัง API:', this.selectedProducts);
            //         await this.submittedProduct(this.selectedProducts);
            //         return; // ✅ หยุดการเพิ่มใหม่ เพราะรอข้อมูลจาก API
            //     }

            //     // ตรวจของเดิมแบบปกติ
            //     const alreadyExists = this.selectedProducts.find(sp =>
            //         sp.pro_id === item.pro_sku_price_id &&
            //         sp.activity_id === activityId &&
            //         sp.st === item.st
            //     );

            //     if (alreadyExists) {
            //         alreadyExists.pro_quantity = parseInt(alreadyExists.pro_quantity) + parseInt(item.pro_goods_num || 0);
            //         Swal.fire({
            //             icon: 'info',
            //             title: 'เพิ่มจำนวนสินค้าอยู่ในรายการแล้ว',
            //             text: `เพิ่มจำนวนสินค้า ${matchedTitle.pro_erp_title || item.pro_erp_title || ''} เป็น ${alreadyExists.pro_quantity} ชิ้น`,
            //         });
            //     } else {
            //         this.selectedProducts.push({
            //             item_id: 0,
            //             pro_id: item.pro_sku_price_id,
            //             activity_id: activityId,
            //             pro_activity_id: item.pro_activity_id,
            //             st: item.st,
            //             pro_erp_title: matchedTitle.pro_erp_title || item.pro_erp_title || '',
            //             pro_unit_price: item.pro_goods_price || '',
            //             pro_goods_sku_text: item.pro_goods_sku_text || '',
            //             pro_sn: matchedTitle.pro_sn || item.pro_sn || '',
            //             pro_images: item.pro_image || '',
            //             pro_quantity: item.pro_goods_num || 0,
            //             pro_units: matchedTitle.pro_units || item.pro_units || '',
            //             pro_stock: matchedTitle.stock || 0,
            //             gifts: giftsDay,
            //             promotions: promotions
            //         });
            //     }
            // });


            console.log("📋 รายการสินค้าในตาราง:", this.selectedProducts);

        },


        async submittedProduct(selectedProducts) {
            const gettoken = localStorage.getItem('token');

            console.log('Check selectedProducts : ', selectedProducts)

            const mappedProducts = (selectedProducts || [])
                .filter(p => p && typeof p === 'object')
                .map(p => ({
                    pro_activity_id: p.activity_id || 0,
                    pro_code: p.pro_code || '',
                    pro_erp_title: p.pro_erp_title || '',
                    pro_goods_id: p.pro_goods_id || 0,
                    pro_goods_num: p.pro_quantity || p.pro_goods_num || 0,
                    pro_goods_price: p.pro_unit_price || p.pro_goods_price || '0',
                    pro_image: p.pro_images || p.pro_image || '',
                    pro_m_code: p.pro_m_code || '',
                    pro_sku_price_id: p.pro_id || p.pro_sku_price_id || 0,
                    pro_sn: p.pro_sn || '',
                    pro_title: p.pro_title || p.pro_erp_title || '',
                    pro_units: p.pro_units || '',
                    stock: p.pro_stock || p.stock || 0
                }));



            try {
                const response = await axios.post(
                    `${BASE_URL}/cart_out/index`,
                    {
                        products: mappedProducts,
                    },
                    {
                        headers: {
                            'Content-Type': 'application/json',
                            'token': gettoken
                        }
                    }
                );

                console.log("✅ Response from API:", response);

                if (response.data.code === 1) {
                    Swal.fire({
                        title: 'ส่งข้อมูลสำเร็จ',
                        text: 'ข้อมูลถูกส่งไปยัง API แล้ว',
                        icon: 'success'
                    });

                    const data = response.data.data.products || [];

                    const items = data.filter(item => item.pro_goods_id !== 0 && (item.ML_Note === 'item' || item.ML_Note === 'itemmonth'));
                    const gifts = data.filter(item => item.pro_goods_id !== 0 && (item.ML_Note === 'zengsopng_day' || item.ML_Note === 'zengsopng_month'));
                    const promotions = data.filter(item => item.pro_activity_id !== 0 && (item.ML_Note === 'promotion_day' || item.ML_Note === 'promotion_month'));

                    console.log('items', items);
                    console.log('gifts', gifts);
                    console.log('promotions', promotions);

                    return;

                    const emitTitles = selectedProducts.map(p => ({
                        pro_goods_id: p.pro_goods_id || 0,
                        pro_activity_id: p.pro_activity_id || 0,
                        pro_erp_title: p.pro_title || p.pro_erp_title || '(ไม่มีชื่อ)',
                        pro_goods_price: p.pro_goods_price || 0,
                        pro_sn: p.pro_sn || '',
                        pro_units: p.pro_units || '',
                        amount: p.pro_goods_num || 0,
                        stock: p.stock || 0,
                    }));

                    this.handleSelectedPromotionProductsFinal({ items, gifts, promotions, emitTitles }); // หรืออัปเดตตารางตรง ๆ ตามที่คุณต้องการ

                    Swal.fire({
                        title: 'ส่งข้อมูลสำเร็จ',
                        text: 'ข้อมูลถูกส่งไปยัง API แล้ว',
                        icon: 'success'
                    });
                } else {
                    Swal.fire({
                        title: 'ผิดพลาด',
                        text: response.data.message || 'เกิดข้อผิดพลาด',
                        icon: 'error'
                    });
                }

            } catch (err) {
                Swal.fire({
                    title: 'เชื่อมต่อ API ไม่ได้',
                    text: err.message || 'กรุณาลองใหม่ภายหลัง',
                    icon: 'error'
                });
            }
        },



        removeProductById(pro_id, activity_id) {
            // this.selectedProducts = this.selectedProducts.filter(p => p.pro_id !== pro_id);
            this.selectedProducts = this.selectedProducts.filter(
                p => !(p.pro_id === pro_id && p.activity_id === activity_id)
            );
        },

        removeProduct(index, activityId) {
            // this.selectedProducts.splice(index, 1);
            Swal.fire({
                title: 'ยืนยันการลบ?',
                text: 'คุณต้องการลบสินค้านี้ออกจากรายการใช่หรือไม่?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'ใช่, ลบเลย!',
                cancelButtonText: 'ยกเลิก'
            }).then((result) => {
                // if (result.isConfirmed) {
                //     this.selectedProducts.splice(index, 1);
                //     Swal.fire('ลบแล้ว!', 'สินค้าถูกลบออกจากรายการ.', 'success');
                // }
                if (result.isConfirmed) {
                    // หา index ที่แท้จริงจาก group
                    const group = this.groupByActivityId(this.selectedProducts)[activityId];
                    const productToRemove = group[index];

                    // ค้นหา index ใน selectedProducts
                    const realIndex = this.selectedProducts.findIndex(p =>
                        p.pro_id === productToRemove.pro_id &&
                        p.pro_activity_id === productToRemove.pro_activity_id
                    );

                    if (realIndex !== -1) {
                        this.selectedProducts.splice(realIndex, 1);
                        Swal.fire('ลบแล้ว!', 'สินค้าถูกลบออกจากรายการ.', 'success');
                    }
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
        const urlParams = new URLSearchParams(window.location.search);
        const documentNo = urlParams.get('documentNo');

        if (documentNo) {
            this.isReadOnly = true; // ถ้ามี documentNo ให้ตั้งค่า readonly
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
    /* font-size: 0.875rem; /* ขนาดตัวอักษร 14px */
    /* line-height: 1.25rem; ความสูงบรรทัด 20px */
    /* padding-top: 0.5rem;
    padding-bottom: 0.5rem; */

    padding: 0.5rem;
    margin-top: 0.4rem;

}

@media (max-width: 431px) {
    .responsive-action-bar {
        left: 0;
    }

    /* .show-more-content {
        display: block; /* แสดงข้อมูลเพิ่มเติม 
    } */

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






<!-- // async validateForm() {
    //     this.errors = {}; // reset error ก่อน

    //     const requiredFields = [
    //         { key: 'reference', label: 'กรุณากรอกข้อมูลอ้างอิง' },
    //         { key: 'channel', label: 'กรุณาระบุช่องทางการขาย' },
    //         { key: 'taxType', label: 'กรุณาระบุประเภทภาษี' },
    //         { key: 'fullName', label: 'กรุณาระบุชื่อลูกค้า' },
    //         { key: 'customerCode', label: 'กรุณาระบุรหัสลูกค้า' },
    //         { key: 'phone', label: 'กรุณาระบุเบอร์โทรลูกค้า' },
    //         { key: 'address', label: 'กรุณาระบุที่อยู่ลูกค้า' },
    //         { key: 'receiverName', label: 'กรุณาระบุชื่อผู้รับ' },
    //         { key: 'receiverPhone', label: 'กรุณาระบุเบอร์โทรผู้รับ' },
    //         { key: 'receiverEmail', label: 'กรุณาระบุอีเมลผู้รับ' },
    //         { key: 'receiverAddress', label: 'กรุณาระบุที่อยู่ผู้รับ' },
    //         { key: 'deliveryDate', label: 'กรุณาระบุวันส่งสินค้า' },
    //         { key: 'trackingNo', label: 'กรุณาระบุ Tracking No.' },
    //         { key: 'deliveryType', label: 'กรุณาเลือกช่องทางการจัดส่ง' }
    //     ];

    //     requiredFields.forEach(field => {
    //         const value = this.formData[field.key];
    //         if (!value || value.toString().trim() === '') {
    //             this.errors[field.key] = field.label;
    //         }
    //     });

    //     // ตรวจสอบรายการสินค้า
    //     if (this.formData.productList.length === 0) {
    //         this.errors.productList = 'กรุณาเพิ่มรายการสินค้าอย่างน้อย 1 รายการ';
    //     } else {
    //         this.formData.productList.forEach((product, index) => {
    //             if (!product.pro_erp_title) {
    //                 this.errors[`productList.${index}.pro_erp_title`] = 'กรุณาระบุชื่อสินค้า';
    //             }
    //             if (!product.pro_quantity || product.pro_quantity <= 0) {
    //                 this.errors[`productList.${index}.pro_quantity`] = 'กรุณาระบุจำนวน';
    //             }
    //         });
    //     }

    //     return Object.keys(this.errors).length === 0;
    // }, -->


<!-- //         handleSelectedPromotionProducts(groupedData) {
    //   console.log('📦 groupedData ที่ได้รับ:', groupedData);

    //   Object.keys(groupedData).forEach(activityId => {
    //     const group = groupedData[activityId];
    //     const items = group.items || [];
    //     const gifts = group.gifts || [];
    //     const promotions = group.promotions || [];
    //     const emitTitles = group.emitTitles || [];

    //     console.log(`📋 Group ${activityId} — Items:`, items);
    //     console.log(`🎁 Group ${activityId} — Gifts:`, gifts);
    //     console.log(`🔥 Group ${activityId} — Promotions:`, promotions);
    //     console.log(`🏷️ Group ${activityId} — EmitTitles:`, emitTitles);

    //     items.forEach(item => {
    //       const alreadyExists = this.selectedProducts.some(sp => sp.pro_id === item.pro_sku_price_id);
    //       if (!alreadyExists) {
    //         const matchedTitle = emitTitles.find(emit => emit.pro_goods_id == item.pro_goods_id) || {};

    //         this.selectedProducts.push({
    //           pro_id: item.pro_sku_price_id,
    //           pro_erp_title: matchedTitle.pro_erp_title || item.pro_erp_title || '',
    //           pro_unit_price: matchedTitle.pro_goods_price || item.pro_goods_price || '',
    //           pro_goods_sku_text: item.pro_goods_sku_text || '',
    //           pro_sn: matchedTitle.pro_sn || item.pro_sn || '',
    //           pro_images: item.pro_image || '',
    //           pro_quantity: item.pro_goods_num || 0,
    //           pro_units: matchedTitle.pro_units || item.pro_units || '',
    //           gifts: gifts.filter(gift => gift.pro_activity_id == item.pro_activity_id),
    //           promotions: promotions.filter(promo => promo.pro_activity_id == item.pro_activity_id),
    //         });
    //       }
    //     });
    //   });

    //   console.log("🧾 รวมสินค้าทั้งหมดใน selectedProducts:", this.selectedProducts);
    // }, -->

<!-- ใช้ได้ครั้งที่ 2 ล่าสุด -->
<!-- 🟦 โปรโมชั่น (แสดงแค่ 1 ครั้งในแต่ละกลุ่ม) -->
<!-- <tr v-if="group[0].promotions && group[0].promotions.length > 0"
                                class="text-center bg-blue-50">
                                <td colspan="9" class="px-4 py-2 border text-left">
                                    <strong>โปรโมชั่น:</strong>
                                    <ul>
                                        <li v-for="(promotion, promoIndex) in group[0].promotions" :key="promoIndex">
                                            {{ promotion.title }}
                                        </li>
                                    </ul>
                                </td>
                            </tr> -->

<!-- ใช้ได้ครั้งที่ 1 -->
<!-- 🟨 ของแถม (แสดงแค่ 1 ครั้งในแต่ละกลุ่ม) -->
<!-- <tr v-if="group[0].gifts && group[0].gifts.length > 0" class="text-center bg-yellow-50">
                                <td colspan="9" class="px-4 py-2 border text-left">
                                    <strong>ของแถม:</strong>
                                    <ul>
                                        <li v-for="(gift, giftIndex) in group[0].gifts" :key="giftIndex">
                                            {{ gift.title }} (จำนวน: {{ gift.pro_goods_num }})
                                        </li>
                                    </ul>
                                </td>
                            </tr> -->

<!-- ใช้ได้ครั้งที่ 2 ล่าสุด -->
<!-- 🟨 ของแถม (แสดงแค่ 1 ครั้งในแต่ละกลุ่ม) -->
<!-- <tr v-if="group[0].gifts && group[0].gifts.length > 0" class="text-center bg-yellow-50">
                                <td colspan="9" class="px-4 py-2 border text-left">
                                    <strong>ของแถม:</strong>
                                    <ul class="space-y-2 mt-2">
                                        <li v-for="(gift, giftIndex) in group[0].gifts" :key="giftIndex"
                                            class="flex items-center space-x-4">
                                            < ✅ รูปภาพของแถม >
                                            <img v-if="gift.pro_image"
                                                :src="gift.pro_image.startsWith('http') ? gift.pro_image : BASE_URL_IMAGE + gift.pro_image"
                                                class="w-10 h-10 object-cover rounded" alt="gift pro_image" />
                                            <span>
                                                {{ gift.title }} (จำนวน: {{ gift.pro_goods_num }})
                                            </span>
                                        </li>
                                    </ul>
                                </td>
                            </tr> -->

<!-- แสดงข้อมูลสินค้าที่เลือก -->
<!-- <div class="overflow-x-auto">
    <table class="min-w-full border text-sm">
        <thead class="bg-gray-100 text-gray-700">
            <tr class="text-center">
                <th class="px-4 py-2 border">รหัส</th>
                <th class="px-4 py-2 border">รูปภาพ</th>
                <th class="px-4 py-2 border">ชื่อสินค้า *</th>
                <th class="px-4 py-2 border">สี</th>
                <!-- <th class="px-4 py-2 border">จากโปรโมชั่น</th> 
                <th class="px-4 py-2 border">จำนวน *</th>
                <th class="px-4 py-2 border">มูลค่าต่อหน่วย *</th>
                <th class="px-4 py-2 border">ส่วนลดต่อหน่วย</th>
                <th class="px-4 py-2 border ">รวม</th>
                <th class="px-4 py-2 border text-center">ลบ</th>
            </tr>
        </thead>
        <tbody>
            <!-- ถ้า selectedProducts มีสินค้า 
            <tr v-for="(product, index) in selectedProducts" :key="product.id">
                <!-- รหัส <button @click="showProductSelector = true"
                <td class="px-4 py-2 border">

                    <button @click="openSelectorForRow(index)" :disabled="isReadOnly"
                        class="bg-gray-200 px-3 py-1 text-gray-700 rounded">{{
                            product.pro_id }} แก้ไขสินค้า
                    </button>

                </td>

                <!-- <img :src="BASE_URL_IMAGE + product.pro_images" alt="products"
                            class="w-10 h-10 rounded-full mx-auto"> 

                <td class="px-4 py-4 border text-center">
                    <template v-if="product.pro_images">
                        {{ console.log("Check Value url and image: ", BASE_URL_IMAGE + product.pro_images)
                        }}
                        <img :src="product.pro_images.startsWith('http') ? product.pro_images : BASE_URL_IMAGE + product.pro_images"
                            class="w-10 h-10 rounded-full mx-auto">
                    </template>
                    <template v-else>
                        <span class="material-icons text-gray-400 text-4xl">broken_image</span>
                        <!-- image Defult 
                    </template>
                </td>

                <!-- ชื่อสินค้า 
                <td class="px-4 py-2 border">
                    <input type="text" v-model="product.pro_erp_title" disabled
                        class="w-[250px] border text-gray-700 rounded px-2 py-1" placeholder="ชื่อสินค้า" />
                </td>

                <td class="px-4 py-2 border">
                    <input type="text" v-model="product.pro_goods_sku_text"
                        class="w-full border text-gray-700 rounded px-2 py-1" placeholder="สี" disabled />
                     {{ ?? '-' }} 
                </td>

                <!-- <td class="px-4 py-2 border text-center">
                    {{ console.log(' : ', ) }}
                    <span v-if="ifs">
                        {{  }}
                    </span>
                    <span v-else class="text-gray-400 italic">
                        -
                    </span>
                </td> -

                <!-- จำนวน 
                <td class="px-4 py-2 border">
                    <input type="number" min="0" v-model.number="product.pro_quantity"
                        class="w-[70px] border text-gray-700 rounded px-2 py-1 text-right" disabled
                        placeholder="จำนวน" />
                </td>

                <!-- ราคาต่อหน่วย 
                <td class="px-4 py-2 border">
                    <input type="number" v-model.number="product.pro_unit_price"
                        class="w-[100px] border text-gray-700 rounded px-2 py-1 text-right" disabled
                        placeholder="ราคาต่อหน่วย" />
                </td>

                <!-- ส่วนลด 
                <td class="px-4 py-2 border">

                    <input type="number" v-model.number="product.discount"
                        class="w-[70px] border text-gray-700 rounded px-2 py-1 text-right" disabled
                        placeholder="ส่วนลด" />
                </td>

                <!-- รวม 
                <td class="px-4 py-2 text-gray-700 border text-right">
                    {{ totalprice(product) }}
                    <!-- {{ product.pro_total_price }} 
                </td>
                <!-- <td class="px-4 py-2 border text-right">
                        {{ ((product.qty || 0) * (product.pro_unit_price || 0) - (product.discount ||
                            0)).toFixed(2) }}
                    </td> 

                <!-- ปุ่มลบ 
                <td class="px-4 py-2 text-gray-700 border text-center text-red-500 cursor-pointer hover:text-red-700"
                    :disabled="isReadOnly" @click="removeProduct(index)">
                    ลบ
                </td>
            </tr>



        </tbody>

    </table>
</div> -->

<!-- handleSelectedPromotionProducts(payload) {
    console.log('📦 payload ที่ได้รับ ที่ได้รับจาก Promotion_ProductSelector:', payload);

    const products = payload?.products ?? [];
    const promotions = payload?.promotions ?? [];

    const getProduct = products.map(p => ({
        // pro_id: p.pro_id, // 50983
        // pro_title: p.pro_title, // "ชุดอะแดปเตอร์เซ็ต AG-201 (20W)"
        // pro_code: p.pro_code, //"P02-ZZ-9999"
        // pro_images: p.pro_images, //image url
        pro_id: p.pro_id,//
        pro_erp_title: p.pro_title,//
        pro_goods_price: p.pro_goods_price,//
        pro_goods_sku_text: p.pro_goods_sku_text,//
        pro_sn: p.pro_sn,//
        pro_images: p.pro_images,//
        pro_quantity: p.pro_quantity,//
        pro_units: p.pro_units,//
        pro_m_code: p.pro_m_code//
    }));

    const getPromotion = promotions.map(p => ({
        pro_m_id: p.pro_m_id,
        pro_m_title: p.pro_m_title,
        pro_m_code: p.pro_m_code,
        pro_m_images: p.pro_m_images,

    }));

    console.log('🛒 ได้สินค้า:', getProduct);
    console.log('🎯 โปรโมชั่นที่เลือก:', getPromotion);

    // เพิ่มสินค้าใหม่ลงใน selectedProducts
    getProduct.forEach(product => {
        const alreadyExists = this.selectedProducts.some(sp => sp.pro_id === product.pro_id);
        if (!alreadyExists) {
            // this.selectedProducts.push(product);
            this.selectedProducts.push({
                pro_id: product.pro_id,//
                pro_erp_title: product.pro_erp_title,//
                pro_unit_price: product.pro_goods_price,//
                pro_goods_sku_text: product.pro_goods_sku_text,//
                // pro_sn: product.pro_sn,//
                pro_images: product.pro_images,//
                pro_quantity: product.pro_quantity,//
                pro_units: product.pro_units,//
                // pro_m_code: product.pro_m_code//
            });
        }
    });

    console.log('📋 รายการสินค้าในตาราง:', this.selectedProducts);

}, -->

<!-- 

// setup() {
    //             const customerData = ref(JSON.parse(localStorage.getItem('selectDataCustomer') || 'null'));

    //             // อัปเดตอัตโนมัติเมื่อ localStorage ถูกเปลี่ยนจากแท็บอื่น
    //             window.addEventListener('storage', (event) => {
    //             if (event.key === 'selectDataCustomer') {
    //                 customerData.value = JSON.parse(event.newValue || 'null');
    //                 console.log('🔄 customerData updated via storage event:', customerData.value);
    //                 getProduct(); // เรียกใหม่เมื่อข้อมูลลูกค้าเปลี่ยน
    //             }
    //         });

     -->

<!--  ใช้ได้ backenup เอาไว้ -->

<!-- Header -->
<!-- <div class="flex justify-between items-center mb-4">
    <!-- ส่วนซ้าย ไอคอนและสินค้า -->
<!-- <div class="flex items-center gap-2">
        <span class="material-icons text-purple-600">assignment_add</span>
        <h2 class="text-xl font-semibold text-gray-700">สินค้า</h2>
    </div> -->



<!-- ปุ่มใช้ได้  -->

<!-- <form>
                    <input type="text" v-model="formData.reference" :readonly="isReadOnly"
                        class="border mt-1 block w-full rounded-md" /> 
                <!-- เพิ่ม readonly ให้ input อื่น ๆ 
                <!-- </form> 
            </div>
            <div class="md:col-span-2 mt-4">
                <button type="button" @click="saveDocument"
                    class="w-full bg-purple-700 text-white py-2 px-4 rounded-md hover:bg-purple-800 transition">บันทึก
                </button>
            </div> -->

<!-- ส่วนขวา: ปุ่มต่าง ๆ
    <div class="flex gap-2">
        <button @click="addProductRow" :disabled="isReadOnly"
            class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700">
            + เพิ่มแถวสินค้า
        </button>
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
</div> -->


<!-- <div class="flex justify-between items-center w-full">
    
    <router-link class="button " to="/createsalelist">
        <div class="flex items-center gap-2 text-purple-600 hover:text-purple-800">
            <span class="material-icons">shopping_bag</span>
            <span class="text">Create Sale Order</span>
        </div>
    </router-link>

 
    <button type="button" @click="saveDocument"
        class="bg-purple-700 text-white py-2 px-6 rounded-md hover:bg-purple-800 transition">
        บันทึก
    </button>
</div> -->


<!-- 
// async saveDocument() {

    //     // console.log(ข้อมูลทั้งหมดใน formData:", this.formData);
    //     console.log("ข้อมูลทั้งหมดใน formData:", JSON.parse(JSON.stringify(this.formData)));

    //     const requiredFields = [
    //         'listCode', 'sellDate', 'expireDate', 'reference', 'channel', 'taxType',
    //         'fullName', 'customerCode', 'phone', 'email', 'address',
    //         'receiverName', 'receiverPhone', 'receiverEmail', 'receiverAddress',
    //         'deliveryDate', 'trackingNo', 'deliveryType'
    //     ];

    //     for (const field of requiredFields) {
    //         if (!this.formData[field]) {
    //             Swal.fire({
    //                 text: 'กรุณากรอกข้อมูลที่จำเป็นให้ครบถ้วนในส่วน "ข้อมูลรายการ" "แบบฟอร์มลูกค้า" "รายการสินค้า" "ข้อมูลที่อยู่ผู้รับ" และ "ข้อมูลการจัดส่งสินค้า"',
    //                 icon: 'warning'
    //             });
    //             return; // หยุดการทำงานหากมีฟิลด์ที่ว่าง
    //         }
    //     }


    //     // เรียก API เพื่อสร้าง Document Running // เพิ่มข้อมูล DocumentRunning
    //     let documentRunning = null;
    //     try {
    //         const docRunningPayload = {
    //             warehouse_code: this.formData.warehouseCode || "H1",
    //             doc_type: this.formData.docType || "SO"
    //             // warehouse_code: "H1",      // สมมุติใช้คลัง H1
    //             // doc_type: "SO"             // เอกสารขาย: Sale Order
    //         };

    //         const docResponse = await axios.post(
    //             'http://localhost/api_admin_dashboard/backend/api/post_documentrunning.php',
    //             docRunningPayload,
    //             {
    //                 // headers: { 'Content-Type': 'application/json' }
    //             }
    //         );

    //         documentRunning = docResponse.data;

    //         console.log("Log Value documentRunning: ", documentRunning);

    //         if (!documentRunning.success) {
    //             Swal.fire({ text: documentRunning.message, icon: 'error' });
    //             return;
    //         }

    //         console.log("📄 ได้เลขเอกสาร:", documentRunning);

    //     } catch (err) {
    //         const message = err.response?.data?.message || err.message || 'เกิดข้อผิดพลาดในการสร้างเลขเอกสาร';
    //         Swal.fire({ text: message, icon: 'error' });
    //         return;
    //     }

    //     // ===> ใส่เลขเอกสารลงใน formData เช่น
    //     this.formData.documentNo = documentRunning.document_number; // เช่น H1-SO25680619-0003


    //     if (this.selectedProducts.length === 0) {
    //         Swal.fire({
    //             text: 'กรุณาเพิ่มสินค้าอย่างน้อย 1 รายการ',
    //             icon: 'warning'
    //         });
    //         return;
    //     }

    //     for (const product of this.selectedProducts) {
    //         if (!product.pro_name || !product.qty || product.qty <= 0 || !product.pro_unit_price || product.pro_unit_price <= 0) {
    //             Swal.fire({
    //                 text: 'กรุณากรอกชื่อสินค้า, จำนวน, และมูลค่าต่อหน่วยให้ครบถ้วนและถูกต้องสำหรับทุกรายการสินค้า',
    //                 icon: 'warning'
    //             });
    //             return; // หยุดการทำงานหากมีสินค้าที่ไม่สมบูรณ์
    //         }
    //     }


    //     // เตรียมข้อมูลสินค้า
    //     this.formData.productList = this.selectedProducts.map(product => ({
    //         pro_name: product.pro_name,
    //         qty: product.qty
    //     }));

    //     // 👇 ดึงชื่อสินค้าแบบรวมเป็น string เช่น: "MacBook 13, MacBook 15"
    //     this.formData.product_name = this.selectedProducts.map(p => p.pro_name).join(', ');

    //     // 👇 รวมจำนวนสินค้าทั้งหมด เช่น: 4 + 2 = 6
    //     this.formData.product_qty = this.selectedProducts.reduce((sum, p) => sum + (p.qty || 0), 0);

    //     // สร้าง payload
    //     const payload = new FormData();
    //     for (const key in this.formData) {
    //         payload.append(key, this.formData[key]);
    //         //แก้ที่นี้
    //         if (key === 'productList') {
    //             // productList ต้องแปลงเป็น string ก่อนแนบ
    //             payload.append('productList', JSON.stringify(this.formData[key]));
    //         }
    //     }

    //     // payload.append('status', this.formData.status || 'Active');

    //     // ✅ ส่ง selectedProducts เป็น JSON string
    //     payload.append('products', JSON.stringify(this.selectedProducts));

    //     // เพื่อมข้อมูล FormData
    //     try {
    //         const response = await axios.post('http://localhost/api_admin_dashboard/backend/api/post_sale_order.php', payload, {
    //             // headers: { 'Content-Type': 'application/json' },
    //         });

    //         console.log("Log Value Data: ", response.data);

    //         const resData = typeof response.data === 'string' ? JSON.parse(response.data) : response.data;
    //         Swal.fire({ text: resData.message, icon: 'success' });
    //     } catch (err) {
    //         const message = err.response?.data?.message || err.message || 'Unknown error';
    //         Swal.fire({ text: message, icon: 'error' });
    //     }



    // }, -->




<!-- // mounted() {
    //     this.getProduct(1);
    // },



    // computed: {
    //     totalAmountBeforeDiscount() {
    //         const subtotal = this.selectedProducts.reduce((sum, product) => {
    //             const qty = product.pro_quantity || 0;
    //             const price = product.pro_unit_price || 0;
    //             const discount = product.pro_discount || 0;
    //             return sum + (qty * price - discount);
    //         }, 0);
    //         const deliveryFee = parseFloat(this.formData.deliveryFee) || 0;
    //         const totalDiscount = parseFloat(this.formData.totalDiscount) || 0;
    //         return subtotal + deliveryFee - totalDiscount;
    //     },
    //     grandTotal() {
    //         const netBeforeVat = this.totalAmountBeforeDiscount;
    //         const vat = netBeforeVat * 0.07;
    //         return (netBeforeVat + vat).toFixed(2);
    //     }
    // } -->


<!-- 
    
    // addSelectedProducts(products) {
        //         products.forEach(p => {
        //             const alreadyExists = this.selectedProducts.some(sp => sp.pro_id === p.pro_id);
        //             if (!alreadyExists) {
        //                 this.selectedProducts.push(p);
        //             }
        //         });
        //     },
    
        // openSelectorForRow(index) {
        //     this.editIndex = index;
        //     this.showProductSelectoronly = true;
        // }, -->

<!-- // removeAllProducts() {
            //     this.selectedProducts = []; // ล้าง array ของสินค้า
            // }, -->


<!-- // handleSelectedProducts(products) {
        //     console.log('✅ สินค้าที่เลือก:', products)
        //     this.showPromotionProductSelector = false

        //     products.forEach(p => {
        //         const alreadyExists = this.selectedProducts.some(sp => sp.pro_id === p.pro_id);
        //         if (!alreadyExists) {
        //             this.selectedProducts.push({
        //                 ...p,
        //                 pro_quantity: 0, // ให้ผู้ใช้ใส่จำนวนภายหลัง

        //                 pro_unit_price: p.pro_unit_price || 0,
        //                 discount: p.discount || 0,
        //                 pro_unit_price: p.pro_unit_price || 0,
        //                 pro_images: p.pro_images || '',
        //                 pro_erp_title: p.pro_erp_title || '',
        //             });
        //         }
        //     });
        // }, -->



<!-- // async getProduct(page = 1) {
        //     try {
        //         const response = await axios.get(`http://localhost/api_admin_dashboard/backend/api/get_products.php?page=${page}`);
        //         const resData = response.data;

        //         if (resData.success) {
        //             console.log("📦 สินค้าที่โหลด:", resData.data);
        //             this.Apiproducts = resData.data; // สมมติว่าคุณมีตัวแปร Apiproducts ใน data
        //         } else {
        //             Swal.fire({ text: resData.message, icon: 'error' });
        //         }
        //     } catch (err) {
        //         const message = err.response?.data?.message || err.message || 'เกิดข้อผิดพลาดในการโหลดสินค้า';
        //         Swal.fire({ text: message, icon: 'error' });
        //     }
        // },

        // async getProductss() {
        //     try {
        //         const raw = {
        //             pageCurrent: 1,
        //             keywords: '',
        //             level: 0,
        //             pageSize: 1000,
        //         };
        //         const response = await axios.post(`${BASE_URL}/Goods2/product`, raw);
        //         Apiproducts.value = response.data.data?.data2 || [];
        //     } catch (err) {
        //         Swal.fire({ text: err.message, icon: 'error' });
        //     }
        // }, -->


<!-- // async openConfirmPopup() {
            //     this.popupFormData = { ...formData }; // clone เพื่อส่งไป popup
            //     this.showConfirmEditPopup = true;
            // },
    
            // async handlePopupConfirm(updatedData) {
            //     formData = { ...updatedData }; // แทนที่ค่าในฟอร์มหลักด้วยค่าที่แก้ไขจาก popup
            //     this.showConfirmEditPopup = false;
    
            //     // ดำเนินการ save จริง
            //     saveDocument();
            // }, -->



<!-- 
<template>
    <div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
      <div class="bg-white p-6 rounded-lg shadow-md w-full max-w-md">
        <h2 class="text-lg font-semibold text-gray-800 mb-4">ยืนยันการบันทึกรายการขาย</h2>
        <p class="text-gray-600 mb-6">คุณต้องการบันทึกรายการนี้ลงในระบบใช่หรือไม่?</p>
        <div class="flex justify-end space-x-4">
          <button @click="$emit('cancel')" class="px-4 py-2 bg-gray-300 text-gray-800 rounded hover:bg-gray-400">
            ยกเลิก
          </button>
          <button @click="$emit('confirm')" class="px-4 py-2 bg-purple-600 text-white rounded hover:bg-purple-700">
            ยืนยัน
          </button>
        </div>
      </div>
    </div>
  </template> -->
<!-- 
import ConfirmSavePopup from '@/components/saleOrder/popup/ConfirmSavePopup.vue'

import { ref } from 'vue'

const showConfirmPopup = ref(false)
 -->