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
                :selectProducts_old_month="selectedProducts" @selectProductsWithMonth="addSelectedProductsWithmonth" />
            <!-- <ProductSelector v-if="showProductSelector" :productList="Apiproducts" @close="showProductSelector = false"
                @select-products="addSelectedProducts" /> -->

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
                                    <td class="px-4 py-2 border">{{ product.pro_erp_title == 0 ? product.pro_title :
                                        product.pro_erp_title }}</td>
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

            <!-- รวม -->
            <!-- รวม -->
            <div class="mt-6 text-right space-y-1">
                <div class="text-gray-700">มูลค่ารวมก่อนภาษี:
                    <span class="ml-2 text-gray-700">{{ totalAmountBeforeDiscount.toFixed(2) }}</span>
                </div>

                <div class="text-gray-700 flex items-center justify-end">
                    <input type="checkbox" v-model="isVatIncluded" id="vatCheckbox" :disabled="isReadOnly" class="mr-2" />
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

import { useRoute } from 'vue-router'

const route = useRoute()

// const documentNo = route.params.id

// const getDataCustomer = JSON.parse(localStorage.getItem('selectDataCustomer') || 'null');

// console.log("BASE_URL_IMAGE:", BASE_URL_IMAGE);

export default {
    name: 'SignupForm',
    // components: {
    //     ProductSelector,
    //     PromotionSelector,
    //     Promotion_ProductSelector,
    //     DeliveryAddressPopup,
    //     'flat-pickr': Flatpickr,
    //     // ConfirmEditPopup
    // },
    data() {
        return {

            documentNo_route_params: route.params.id,

            isLoading: false, // สำหรับ loading spinner

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
                reference: '' || '-',
                channel: '' || '-',
                taxType: '' || '-',

                fullName: '',
                customerCode: '',
                phone: '',
                email: '' || '-',
                address: '',
                receiverName: '',
                receiverPhone: '' || '-',
                receiverEmail: '' || '-',
                receiverAddress: '',
                note: '' || '-',

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

    mounted() {
        
    },

    watch: {

        isVatIncluded(newVal) {
            this.formData.taxType = newVal ? 'รวมภาษี' : 'ไม่รวมภาษี'
        },

    },

    computed: {
             

    },

    methods: {

        async loadDocumentData(documentNo_route_params) {
            try {
                this.isLoading = true;

                const response = await axios.get(`${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/sale_order/get_sale_order.php?documentNo=${documentNo_route_params}`);

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
                      
                    };

                    console.log("📄 ข้อมูลเอกสารที่โหลด:", resData.data.productList);
                    console.log("🔍 ก่อน map this.selectedProducts:", this.selectedProducts);


                    this.selectedProducts = resData.data.productList.map(product => {

                        console.log("🛠️ กำลัง map product:", product); // 👈 log ตรงนี้เช็กแต่ละตัว
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

                    });

                    console.log("📄 ข้อมูลเอกสารที่โหลด:", this.formData);
                    console.log("🛒 รายการสินค้า:", this.selectedProducts)

                    this.originalFormData = JSON.parse(JSON.stringify(this.formData)); // deep copy
                    this.originalSelectedProducts = JSON.parse(JSON.stringify(this.selectedProducts));


                    this.isLoading = false;
                    ;
                } else {
                    Swal.fire({ text: resData.message, icon: 'error' });
                }
            } catch (err) {
                const message = err.response?.data?.message || err.message || 'เกิดข้อผิดพลาดในการโหลดข้อมูลเอกสาร';
                Swal.fire({ text: message, icon: 'error' });
            }
        },
    },

}


</script>