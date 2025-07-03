<!-- 
<script>

import { ref, onMounted, watch } from 'vue';
import axios from 'axios';
import Swal from 'sweetalert2';
import ProductSelector from '../components/ProductSelector.vue';
import PromotionSelector from '../components/PromotionSelector.vue';
import Promotion_ProductSelector from '../components/Promotion_ProductSelector.vue';

const BASE_URL = import.meta.env.VITE_API_URL;
const BASE_URL_IMAGE = import.meta.env.VITE_API_URL_IMAGE;

// const getDataCustomer = JSON.parse(localStorage.getItem('selectDataCustomer') || 'null');

console.log("BASE_URL_IMAGE:", BASE_URL_IMAGE);

export default {
    name: 'SignupForm',
    components: {
        ProductSelector,
        PromotionSelector,
        Promotion_ProductSelector
    },
    data() {
        return {

            customerData: JSON.parse(localStorage.getItem('selectDataCustomer') || 'null'),

            BASE_URL_IMAGE: import.meta.env.VITE_API_URL_IMAGE,

            showProductSelector: false,
            showPromotionSelector: false,
            showProductSelectoronly: false,

            selectedProducts: [],
            selectedPromotion: [],

            showPromotionProductSelector: false,

            editIndex: null,
            products: [], 


   SelectedPromotion(promotionData) {
            selectedPromotion.value = promotionData
            showPromotionSelector.value = true

            // เปิด popup ที่สองในรอบถัดไป (เพื่อให้ Vue unmount ก่อน)
            setTimeout(() => {
                showPromotionSelector.value = true
            }, 50)
        },

        handleSelectedProducts(products) {
        console.log('✅ สินค้าที่เลือก:', products)
        showPromotionProductSelector.value = false
        }, 

    }}}
        </script> -->


<template>
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

                    <td class="px-4 py-4 border text-center">
                        <template v-if="product.pro_images">
                            {{ console.log("Check Value url and image: ", BASE_URL_IMAGE + product.pro_images)
                            }}
                            <img :src="BASE_URL_IMAGE + product.pro_images" alt="products"
                                class="w-10 h-10 rounded-full mx-auto">
                        </template>
                        <template v-else>
                            <span class="material-icons text-gray-400 text-4xl">broken_image</span>
                            <!-- image Defult -->
                        </template>
                    </td>

                    <!-- ชื่อสินค้า -->
                    <td class="px-4 py-2 border">
                        <input type="text" v-model="product.pro_erp_title"
                            class="w-full border rounded px-2 py-1" placeholder="ชื่อสินค้า" />
                    </td>

                    <!-- จำนวน -->
                    <td class="px-4 py-2 border">
                        <input type="number" min="0" v-model.number="product.pro_quantity"
                            class="w-full border rounded px-2 py-1 text-right" placeholder="จำนวน" />
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
                <input type="text" v-model="formData.totalDiscount" class="w-full border px-3 py-2 rounded"
                    placeholder="จำนวนเงิน หรือ %" />
            </div>
            <div>
                <label class="block font-medium mb-1">ค่าจัดส่ง</label>
                <input type="number" v-model="formData.deliveryFee" class="w-full border px-3 py-2 rounded" />
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

<!-- script (โดยย่อไปก่อน)  -->

</template>

<script>

import { ref, onMounted, watch } from 'vue';
import axios from 'axios';
import Swal from 'sweetalert2';
import ProductSelector from '../components/ProductSelector.vue';
import PromotionSelector from '../components/PromotionSelector.vue';
import Promotion_ProductSelector from '../components/Promotion_ProductSelector.vue';

const BASE_URL = import.meta.env.VITE_API_URL;
const BASE_URL_IMAGE = import.meta.env.VITE_API_URL_IMAGE;

// const getDataCustomer = JSON.parse(localStorage.getItem('selectDataCustomer') || 'null');

console.log("BASE_URL_IMAGE:", BASE_URL_IMAGE);

export default {
name: 'SignupForm',
components: {
ProductSelector,
PromotionSelector,
Promotion_ProductSelector
},
data() {
return {

    customerData: JSON.parse(localStorage.getItem('selectDataCustomer') || 'null'),

    BASE_URL_IMAGE: import.meta.env.VITE_API_URL_IMAGE,

    showProductSelector: false,
    showPromotionSelector: false,
    showProductSelectoronly: false,

    selectedProducts: [],
    selectedPromotion: [],

    showPromotionProductSelector: false,

    editIndex: null,
    products: [],

    formTouched: false,
    errors: {},

    documentRunning: [],

    Apiproducts: [],

    showMore: false,
    showMoreData: false,
    showMoreAdress: false, 

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
}}}

</script>