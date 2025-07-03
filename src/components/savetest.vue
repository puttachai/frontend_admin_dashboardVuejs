<template>

    <div
        class="mainbox flex flex-col in-h-screen items-center gap-4 justify-center bg-gray-100 py-8 px-4 sm:px-6 lg:px-8">
        <!-- <div class="min-h-screen flex items-center gap-2 justify-center bg-gray-100 py-12 px-4 sm:px-6 lg:px-8"> -->
        <div class="flex self-end">
            <button type="button" @click="saveDocument"
                class="w-full bg-purple-700 text-white py-2 px-6 rounded-md hover:bg-purple-800 transition">บันทึก
            </button>
        </div>
        <!-- form รายการเอกสาร -->
        <div class="boxback w-full gap-4 bg-white p-8 rounded-lg shadow-lg">

            <div>
                <!-- Logo and Title -->
                <div class="text-center mb-4 ">
                    <img src="../assets/logo.svg" alt="Logo" class="mx-auto h-16">
                    <p class="mt-1 text-xl text-gray-700">สร้างรายการขาย</p>
                </div>

                <div class="flex items-center gap-2 mb-4">
                    <span class="material-icons text-purple-600">content_paste</span>
                    <h1 class="text-xl">ข้อมูล</h1>
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
                        <label class="block text-sm font-medium text-gray-700">รายการ *</label>
                        <input type="text" placeholder="รหัสรายการ" disabled v-model="formData.documentNo"
                            class="border mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                    </div>

                    <!-- <div>
                        <label class="block text-sm font-medium text-gray-700">วันที่</label>
                        <input type="date" v-model="formData.sellDate" disabled
                            class="border mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                    </div> -->

                    <div>
                        <label class="text-sm text-gray-700 block mb-1">วันที่</label>
                        <div class="relative">

                            <!-- Flatpickr Input -->
                            <flat-pickr v-model="formData.sellDate" :config="dateConfig" :readonly="isReadOnly"
                                placeholder="เลือกวันที่"
                                class="cursor-pointer pr-10 mt-1 pl-4 py-2 w-full border border-gray-300 rounded-lg shadow-sm focus:border-purple-500 focus:ring-purple-500 text-gray-700 placeholder-gray-400" />

                            <!-- Calendar Icon on the right -->
                            <span class="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none"
                                style="padding-top: 0.2rem;">
                                <span class="material-icons text-gray-400 text-base">calendar_today</span>
                            </span>
                        </div>
                    </div>



                    <!-- เงื่อนไขแสดงเพิ่มเติม -->
                    <template v-if="showMoreData">

                        <div>
                            <label class="block text-sm font-medium text-gray-700">อ้างอิง</label>
                            <input type="text" v-model="formData.reference" :readonly="isReadOnly"
                                class="border  mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700">ช่องทางการขาย</label>
                            <input type="text" v-model="formData.channel" :readonly="isReadOnly"
                                class="border  mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                        </div>

                        <div class="md:col-span-2">
                            <label class="block text-sm font-medium text-gray-700">ประเภทภาษี</label>
                            <input type="text" v-model="formData.taxType" :readonly="isReadOnly"
                                class="border  mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                        </div>

                    </template>

                </form>
                <!-- ปุ่ม Show More / Show Less -->
                <button @click="showMoreData = !showMoreData" type="button"
                    class="mt-4 text-purple-600 hover:underline focus:outline-none">
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
                        <h1 class="text-xl">แบบฟอร์มลูกค้า</h1>
                    </div>

                    <!-- แบบฟอร์ม -->
                    <form class="grid grid-cols-1 gap-4">
                        <!-- แสดงเสมอ -->
                        <div>
                            <label class="block text-sm font-medium text-gray-700">ชื่อลูกค้า</label>
                            <input type="text" placeholder="ชื่อ, รหัส" disabled v-model="formData.fullName"
                                class="mt-1 block w-full rounded-md border border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                            <p v-if="formTouched && errors.fullName" class="text-red-500 text-sm mt-1">{{
                                errors.fullName }}</p>
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700">รหัสลูกค้า</label>
                            <input type="text" v-model="formData.customerCode" disabled
                                class="mt-1 block w-full rounded-md border border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                            <p v-if="formTouched && errors.customerCode" class="text-red-500 text-sm mt-1">{{
                                errors.customerCode }}
                            </p>
                        </div>

                        <!-- เงื่อนไขแสดงเพิ่มเติม -->
                        <div v-if="showMore">
                            <div>
                                <label class="block text-sm font-medium text-gray-700">เบอร์โทรศัพท์ลูกค้า</label>
                                <input type="text" v-model="formData.phone" :readonly="isReadOnly"
                                    class="mt-1 block w-full rounded-md border border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-gray-700">อีเมลลูกค้า</label>
                                <input type="text" v-model="formData.email" :readonly="isReadOnly"
                                    class="mt-1 block w-full rounded-md border border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-gray-700">ที่อยู่ลูกค้า</label>
                                <input type="text" v-model="formData.address" :readonly="isReadOnly"
                                    class="mt-1 block w-full rounded-md border border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                            </div>
                        </div>
                    </form>

                    <!-- ปุ่ม Show More / Show Less -->
                    <button @click="showMore = !showMore" type="button"
                        class="mt-4 text-purple-600 hover:underline focus:outline-none">
                        {{ showMore ? 'แสดงน้อยลง ▲' : 'แสดงเพิ่มเติม ▼' }}
                    </button>
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
                    <h2 class="text-xl font-semibold">สินค้า</h2>
                </div>

                <!-- ส่วนขวา: ปุ่มต่าง ๆ -->
                <div class="flex gap-2">
                    <button @click="addProductRow" class="bg-green-600 text-white px-4 py-2 rounded">
                        + เพิ่มแถวสินค้า
                    </button>
                    <button @click="showProductSelector = true"
                        class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">
                        เลือกสินค้า
                    </button>
                    <button @click="showPromotionSelector = true"
                        class="bg-yellow-500 text-white px-4 py-2 rounded hover:bg-blue-700">
                        เลือกโปรโมชั่น
                    </button>
                    <button @click="removeAllProducts" class="bg-red-600 text-white px-4 py-2 rounded hover:bg-red-700">
                        ลบสินค้าที่เลือกทั้งหมด
                    </button>
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
                @close="showPromotionProductSelector = false" @select-promotion_products="handleSelectedProducts" />

            <!-- แสดงข้อมูลสินค้าที่เลือก -->
            <div class="overflow-x-auto">
                <table class="min-w-full border text-sm">
                    <thead class="bg-gray-100 text-gray-700">
                        <tr class="text-center">
                            <th class="px-4 py-2 border">รหัส</th>
                            <th class="px-4 py-2 border">รูปภาพ</th>
                            <th class="px-4 py-2 border">ชื่อสินค้า *</th>
                            <th class="px-4 py-2 border">สี</th>
                            <!-- <th class="px-4 py-2 border">จากโปรโมชั่น</th> -->
                            <th class="px-4 py-2 border">จำนวน *</th>
                            <th class="px-4 py-2 border">มูลค่าต่อหน่วย *</th>
                            <th class="px-4 py-2 border">ส่วนลดต่อหน่วย</th>
                            <th class="px-4 py-2 border ">รวม</th>
                            <th class="px-4 py-2 border text-center">ลบ</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- ถ้า selectedProducts มีสินค้า -->
                        <tr v-for="(product, index) in selectedProducts" :key="product.id">
                            <!-- รหัส <button @click="showProductSelector = true"-->
                            <td class="px-4 py-2 border">

                                <button @click="openSelectorForRow(index)" class="bg-gray-200 px-3 py-1 rounded">{{
                                    product.pro_id }} เลือก
                                </button>

                            </td>

                            <!-- <img :src="BASE_URL_IMAGE + product.pro_images" alt="products"
                                        class="w-10 h-10 rounded-full mx-auto"> -->

                            <td class="px-4 py-4 border text-center">
                                <template v-if="product.pro_images">
                                    {{ console.log("Check Value url and image: ", BASE_URL_IMAGE + product.pro_images)
                                    }}
                                    <img :src="product.pro_images.startsWith('http') ? product.pro_images : BASE_URL_IMAGE + product.pro_images"
                                        class="w-10 h-10 rounded-full mx-auto">
                                </template>
                                <template v-else>
                                    <span class="material-icons text-gray-400 text-4xl">broken_image</span>
                                    <!-- image Defult -->
                                </template>
                            </td>

                            <!-- ชื่อสินค้า -->
                            <td class="px-4 py-2 border">
                                <input type="text" v-model="product.pro_erp_title" disabled
                                    class="w-full border rounded px-2 py-1" placeholder="ชื่อสินค้า" />
                            </td>

                            <td class="px-4 py-2 border">
                                <input type="text" v-model="product.pro_goods_sku_text"
                                    class="w-full border rounded px-2 py-1" placeholder="สี" disabled />
                                <!-- {{ ?? '-' }} -->
                            </td>

                            <!-- <td class="px-4 py-2 border text-center">
                                {{ console.log(' : ', ) }}
                                <span v-if="ifs">
                                    {{  }}
                                </span>
                                <span v-else class="text-gray-400 italic">
                                    -
                                </span>
                            </td> -->

                            <!-- จำนวน -->
                            <td class="px-4 py-2 border">
                                <input type="number" min="0" v-model.number="product.pro_quantity"
                                    class="w-full border rounded px-2 py-1 text-right" disabled placeholder="จำนวน" />
                            </td>

                            <!-- ราคาต่อหน่วย -->
                            <td class="px-4 py-2 border">
                                <input type="number" v-model.number="product.pro_unit_price"
                                    class="w-full border rounded px-2 py-1 text-right" disabled
                                    placeholder="ราคาต่อหน่วย" />
                            </td>

                            <!-- ส่วนลด -->
                            <td class="px-4 py-2 border">

                                <input type="number" v-model.number="product.discount"
                                    class="w-full border rounded px-2 py-1 text-right" disabled placeholder="ส่วนลด" />
                            </td>

                            <!-- รวม -->
                            <td class="px-4 py-2 border text-right">
                                {{ totalprice(product) }}
                                <!-- {{ product.pro_total_price }} -->
                            </td>
                            <!-- <td class="px-4 py-2 border text-right">
                                    {{ ((product.qty || 0) * (product.pro_unit_price || 0) - (product.discount ||
                                        0)).toFixed(2) }}
                                </td> -->

                            <!-- ปุ่มลบ -->
                            <td class="px-4 py-2 border text-center text-red-500 cursor-pointer hover:text-red-700"
                                @click="removeProduct(index)">
                                ลบ
                            </td>
                        </tr>



                    </tbody>

                </table>
            </div>

            <!-- ช่องทางจัดส่ง -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mt-6">
                <div>
                    <label class="block font-medium mb-1">ช่องทางจัดส่ง</label>
                    <select v-model="formData.deliveryType" placeholder="ช่องทางจัดส่ง"
                        class="w-full border px-3 py-2 rounded">

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
                        <label class="block font-medium mb-1">ส่วนลด</label>
                        <input type="text" v-model="formData.totalDiscount" :readonly="isReadOnly"
                            class="w-full border px-3 py-2 rounded" placeholder="จำนวนเงิน หรือ %" />
                    </div>
                    <div>
                        <label class="block font-medium mb-1">ค่าจัดส่ง</label>
                        <input type="number" v-model="formData.deliveryFee" :readonly="isReadOnly"
                            class="w-full border px-3 py-2 rounded" />
                    </div>
                </div>
            </div>

            <!-- หมายเหตุ -->
            <div class="mt-4">
                <label class="block font-medium mb-1">หมายเหตุ</label>
                <textarea rows="3" v-model="formData.note" class="w-full border px-3 py-2 rounded"></textarea>
            </div>

            <!-- รวม -->
            <div class="mt-6 text-right space-y-1">
                <div>มูลค่ารวมก่อนภาษี: <span class="ml-2">{{ totalAmountBeforeDiscount.toFixed(2) }}</span></div>
                <div>ภาษีมูลค่าเพิ่ม (7%): <span class="ml-2">{{ (totalAmountBeforeDiscount * 0.07).toFixed(2) }}</span>
                </div>
                <div class="text-xl font-bold text-purple-700 mt-2">
                    มูลค่ารวมสุทธิ: <span class="ml-2 text-blue-600">{{ grandTotal }}</span>
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
                            <label class="text-sm text-gray-700 block mb-1">ชื่อผู้รับ</label>
                            <input type="text" v-model="formData.receiverName" :readonly="isReadOnly"
                                class="w-full border rounded px-3 py-2" />
                            <p v-if="formTouched && errors.receiverName" class="text-red-500 text-sm mt-1">{{
                                errors.receiverName }}
                            </p>
                        </div>

                        <!-- <div class="flex items-center gap-2 text-sm text-blue-600 cursor-pointer">
                            <span class="material-icons text-base">content_copy</span>
                            <span>คัดลอกจากข้อมูลลูกค้า</span>
                        </div> -->

                        <div>
                            <label class="text-sm text-gray-700 block mb-1">เบอร์โทรศัพท์ผู้รับ</label>
                            <input type="tel" v-model="formData.receiverPhone" :readonly="isReadOnly"
                                class="w-full border rounded px-3 py-2" />
                            <p v-if="formTouched && errors.receiverPhone" class="text-red-500 text-sm mt-1">{{
                                errors.receiverPhone }}
                            </p>
                        </div>

                        <div v-if="showMoreAdress">

                            <div>
                                <label class="text-sm text-gray-700 block mb-1">อีเมลผู้รับ</label>
                                <input type="email" v-model="formData.receiverEmail" :readonly="isReadOnly"
                                    class="w-full border rounded px-3 py-2" />
                            </div>

                            <div>
                                <label class="text-sm text-gray-700 block mb-1">ที่อยู่/จัดส่ง</label>

                                <textarea rows="4" v-model="formData.receiverAddress" :readonly="isReadOnly"
                                    class="w-full border rounded px-3 py-2 resize-none">

                        </textarea>
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
                <button @click="showMoreAdress = !showMoreAdress" type="button"
                    class="mt-4 text-purple-600 hover:underline focus:outline-none">
                    {{ showMoreAdress ? 'แสดงน้อยลง ▲' : 'แสดงเพิ่มเติม ▼' }}
                </button>

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
                            <flat-pickr v-model="formData.deliveryDate" :config="dateConfig" disabled
                                class="cursor-not-allowed pr-10 mt-1 pl-4 py-2 w-full border border-gray-300 rounded-lg shadow-sm focus:border-purple-500 focus:ring-purple-500 text-gray-700 placeholder-gray-400 bg-gray-100" />

                            <!-- Calendar Icon on the right -->
                            <span class="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none"
                                style="padding-top: 0.2rem;">
                                <span class="material-icons text-gray-400 text-base">calendar_today</span>
                            </span>
                        </div>
                    </div>

                    <div>
                        <label class="text-sm text-gray-700 block mb-1">Tracking No.</label>
                        <input type="text" v-model="formData.trackingNo" :readonly="isReadOnly"
                            class="w-full border rounded px-3 py-2" />
                    </div>
                </div>
            </div>


        </div>

        <div class=" w-full mx-auto p-6 rounded-lg bg-white shadow-md space-y-8">
            <div>
                <button v-if="isReadOnly" @click="enableEditMode"
                    class="bg-yellow-500 text-white py-2 px-4 rounded-md hover:bg-yellow-600">
                    แก้ไข
                </button>
                <button v-if="!isReadOnly" @click="saveDocument"
                    class="bg-purple-700 text-white py-2 px-4 rounded-md hover:bg-purple-800">
                    บันทึก
                </button>
                <button v-if="!isReadOnly && formData.documentNo" @click="updateDocument"
                    class="bg-green-600 text-white py-2 px-4 rounded-md hover:bg-green-700">
                    บันทึกการแก้ไข
                </button>

                <form>
                    <input type="text" v-model="formData.reference" :readonly="isReadOnly"
                        class="border mt-1 block w-full rounded-md" />
                    <!-- เพิ่ม readonly ให้ input อื่น ๆ -->
                </form>
            </div>
            <!-- <div class="md:col-span-2 mt-4">
                <button type="button" @click="saveDocument"
                    class="w-full bg-purple-700 text-white py-2 px-4 rounded-md hover:bg-purple-800 transition">บันทึก
                </button>
            </div> -->
        </div>

    </div>

</template>
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


<script>

import { ref, onMounted, watch } from 'vue';
import axios from 'axios';
import Swal from 'sweetalert2';
import ProductSelector from '../components/ProductSelector.vue';
import PromotionSelector from '../components/PromotionSelector.vue';
import Promotion_ProductSelector from '../components/Promotion_ProductSelector.vue';

// import ConfirmEditPopup from '@/components/saleOrder/ConfirmEditPopup.vue'

import Flatpickr from 'vue-flatpickr-component'
import 'flatpickr/dist/flatpickr.css'

// ✅ import Thai locale
import { Thai } from 'flatpickr/dist/l10n/th.js'
import flatpickr from 'flatpickr'

// ✅ ตั้งค่าภาษาไทยให้กับ flatpickr
flatpickr.localize(Thai)

const BASE_URL = import.meta.env.VITE_API_URL;
const BASE_URL_IMAGE = import.meta.env.VITE_API_URL_IMAGE;

// const getDataCustomer = JSON.parse(localStorage.getItem('selectDataCustomer') || 'null');

console.log("BASE_URL_IMAGE:", BASE_URL_IMAGE);

export default {
    name: 'SignupForm',
    components: {
        ProductSelector,
        PromotionSelector,
        Promotion_ProductSelector,
        'flat-pickr': Flatpickr,
        // ConfirmEditPopup
    },
    data() {
        return {

            customerData: JSON.parse(localStorage.getItem('selectDataCustomer') || 'null'),

            BASE_URL_IMAGE: import.meta.env.VITE_API_URL_IMAGE,

            isReadOnly: false, // ใช้ควบคุมสถานะ readonly

            selectedDate: '',
            // ✅ ตั้งค่ารูปแบบวันและปฏิทิน
            dateConfig: {
                dateFormat: 'd/m/Y', // เช่น 01/07/2568
                locale: Thai, // ใช้ภาษาไทย
            },

            showProductSelector: false,
            showPromotionSelector: false,
            showProductSelectoronly: false,

            showPromotionProductSelector: false,
            selectedPromotion: [],

            showConfirmEditPopup: false,
            popupFormData: [],

            formData: {
                listCode: '',
                sellDate: '',

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
                deliveryDate: '',
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
        };
    },


    methods: {

        // async openConfirmPopup() {
        //     this.popupFormData = { ...formData }; // clone เพื่อส่งไป popup
        //     this.showConfirmEditPopup = true;
        // },

        // async handlePopupConfirm(updatedData) {
        //     formData = { ...updatedData }; // แทนที่ค่าในฟอร์มหลักด้วยค่าที่แก้ไขจาก popup
        //     this.showConfirmEditPopup = false;

        //     // ดำเนินการ save จริง
        //     saveDocument();
        // },

        updateDeliveryDate(newDate) {
            this.formData.deliveryDate = newDate;
            this.formData.sellDate = newDate; // ❌ อัปเดต sellDate ด้วย
        },

        async saveDocument() {

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
            const requiredFields = [
                'sellDate', 'reference', 'channel', 'taxType',
                'fullName', 'customerCode', 'phone', 'address',
                'receiverName', 'receiverPhone', 'receiverEmail', 'receiverAddress',
                'deliveryDate', 'trackingNo', 'deliveryType'
            ];

            console.log("Log Value requiredFields: ", requiredFields);

            for (const field of requiredFields) {
                if (!this.formData[field]) {
                    Swal.fire({
                        text: 'กรุณากรอกข้อมูลที่จำเป็นให้ครบถ้วนในส่วน "ข้อมูลรายการ" "แบบฟอร์มลูกค้า" "รายการสินค้า" "ข้อมูลที่อยู่ผู้รับ" และ "ข้อมูลการจัดส่งสินค้า"',
                        icon: 'warning'
                    });
                    return; // หยุดการทำงานหากมีฟิลด์ที่ว่าง
                }
            }


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
                    'http://localhost/api_admin_dashboard/backend/api/post_documentrunning.php',
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
                    unit: product.pro_unit
                };
            });


            console.log("🔍 log value this.productList:", this.formData.productList)

            this.formData.final_total_price = this.grandTotal;

            const payload = new FormData();

            for (const key in this.formData) {
                if (key === 'productList') {
                    // แปลง array เป็น JSON string แล้วแนบ
                    payload.append('productList', JSON.stringify(this.formData.productList));
                } else {
                    payload.append(key, this.formData[key]);
                }
            }

            // เพื่อมข้อมูล FormData
            try {
                const response = await axios.post('http://localhost/api_admin_dashboard/backend/api/post_sale_order.php', payload, {
                    // headers: { 'Content-Type': 'application/json' },
                });

                console.log("Log Value Data: ", response.data);

                const resData = typeof response.data === 'string' ? JSON.parse(response.data) : response.data;
                if (resData.success) {
                    // เก็บ documentNo ลง localStorage
                    const documentNo = this.formData.documentNo;
                    localStorage.setItem('documentNo', documentNo);

                    // เปลี่ยน URL ไปยัง saleList?documentNo=<documentNo>
                    this.$router.push(`/saleList?documentNo=${documentNo}`);

                    // ตั้งค่าให้ฟอร์มเป็น readonly
                    this.isReadOnly = true;

                    Swal.fire({ text: resData.message, icon: 'success' });
                } else {
                    Swal.fire({ text: resData.message, icon: 'error' });
                }
                // Swal.fire({ text: resData.message, icon: 'success' });
            } catch (err) {
                const message = err.response?.data?.message || err.message || 'Unknown error';
                Swal.fire({ text: message, icon: 'error' });
            }



        },
        enableEditMode() {
            this.isReadOnly = false; // เปิดให้แก้ไขฟอร์ม
        },
        async updateDocument() {
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
                const payload = new FormData();
                for (const key in this.formData) {
                    if (key === 'productList') {
                        payload.append('productList', JSON.stringify(this.formData.productList));
                    } else {
                        payload.append(key, this.formData[key]);
                    }
                }

                const response = await axios.post(
                    'http://localhost/api_admin_dashboard/backend/api/update_sale_order.php',
                    payload
                );

                const resData = typeof response.data === 'string' ? JSON.parse(response.data) : response.data;

                if (resData.success) {
                    Swal.fire({ text: resData.message, icon: 'success' });
                    this.isReadOnly = true; // ปิดการแก้ไขหลังบันทึกสำเร็จ
                } else {
                    Swal.fire({ text: resData.message, icon: 'error' });
                }
            } catch (err) {
                const message = err.response?.data?.message || err.message || 'Unknown error';
                Swal.fire({ text: message, icon: 'error' });
            }
        },
        async loadDocumentData(documentNo) {
            try {
                const response = await axios.get(`http://localhost/api_admin_dashboard/backend/api/get_sale_order.php?documentNo=${documentNo}`);
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
                        documentNo: resData.data.order.document_no || ''
                    };

                    // เติมข้อมูลสินค้า
                    // this.selectedProducts = resData.data.productList || [];

                    // เติมข้อมูลสินค้า โดยแมปให้ตรงกับโครงสร้างที่ใช้ใน Vue
                    this.selectedProducts = resData.data.productList.map(product => ({
                        pro_id: product.pro_id,
                        pro_erp_title: product.pro_name,
                        pro_quantity: product.qty,
                        pro_unit_price: parseFloat(product.unit_price),
                        pro_discount: parseFloat(product.discount),
                        pro_total_price: parseFloat(product.total_price),
                        pro_images: product.pro_images,
                        pro_sn: product.sn,
                        unit: product.unit || ''
                    }));

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

        handleSelectedProducts(products) {
            console.log('✅ สินค้าที่เลือก:', products)
            this.showPromotionProductSelector = false

            products.forEach(p => {
                const alreadyExists = this.selectedProducts.some(sp => sp.pro_id === p.pro_id);
                if (!alreadyExists) {
                    this.selectedProducts.push({
                        ...p,
                        pro_quantity: 0, // ให้ผู้ใช้ใส่จำนวนภายหลัง

                        pro_unit_price: p.pro_unit_price || 0,
                        discount: p.discount || 0,
                        pro_unit_price: p.pro_unit_price || 0,
                        pro_images: p.pro_images || '',
                        pro_erp_title: p.pro_erp_title || '',
                    });
                }
            });
        },

        handleSelectedProducts(payload) {
            console.log('📦 payload ที่ได้รับ:', payload);

            const products = payload?.products ?? [];
            const promotions = payload?.promotions ?? [];

            const getProduct = products.map(p => ({
                pro_id: p.pro_id,
                pro_title: p.pro_title,
                pro_code: p.pro_code,
                pro_images: p.pro_images,
            }));

            const getPromotion = promotions.map(p => ({
                pro_m_id: p.pro_m_id,
                pro_m_title: p.pro_m_title,
                pro_m_code: p.pro_m_code,
                pro_m_images: p.pro_m_images,
            }));

            console.log('🛒 ได้สินค้า:', getProduct);
            console.log('🎯 โปรโมชั่นที่เลือก:', getPromotion);
        },

        removeAllProducts() {
            this.selectedProducts = []; // ล้าง array ของสินค้า
        },

        addProductRow() {
            this.selectedProducts.push({
                id: Date.now(),
            });
        },
        openSelectorForRow(index) {
            this.editIndex = index;
            this.showProductSelectoronly = true;
        },
    },
    mounted() {
        const urlParams = new URLSearchParams(window.location.search);
        const documentNo = urlParams.get('documentNo');

        if (documentNo) {
            this.isReadOnly = true; // ถ้ามี documentNo ให้ตั้งค่า readonly
            this.loadDocumentData(documentNo); // โหลดข้อมูลเอกสาร
        }

        this.getProduct(1);
        const today = new Date().toISOString().split('T')[0]; // YYYY-MM-DD
        if (!this.formData.sellDate) {
            this.formData.sellDate = today;
        }

    },
    computed: {
        totalAmountBeforeDiscount() {
            const subtotal = this.selectedProducts.reduce((sum, product) => {
                const qty = product.pro_quantity || 0;
                const price = product.pro_unit_price || 0;
                const discount = product.pro_discount || 0;
                return sum + (qty * price - discount);
            }, 0);
            const deliveryFee = parseFloat(this.formData.deliveryFee) || 0;
            const totalDiscount = parseFloat(this.formData.totalDiscount) || 0;
            return subtotal + deliveryFee - totalDiscount;
        },
        grandTotal() {
            const netBeforeVat = this.totalAmountBeforeDiscount;
            const vat = netBeforeVat * 0.07;
            return (netBeforeVat + vat).toFixed(2);
        }
    }
}

</script>