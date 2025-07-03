<template>

<div
        class="mainbox flex flex-col in-h-screen items-center gap-4 justify-center bg-gray-100 py-12 px-4 sm:px-6 lg:px-8">
        <!-- <div class="min-h-screen flex items-center gap-2 justify-center bg-gray-100 py-12 px-4 sm:px-6 lg:px-8"> -->

        <!-- form รายการเอกสาร -->
        <div class="boxback w-full gap-4 bg-white p-8 rounded-lg shadow-lg">

            <!-- Logo and Title -->
            <div class="text-center mb-4 ">
                <img src="../assets/logo.svg" alt="Logo" class="mx-auto h-16">
                <!-- <h2 class="text-3xl font-extrabold text-gray-900">GEKKO</h2>
                <p class="text-blue-500 text-sm tracking-wide uppercase">Shop</p> -->
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
                <div class="p">
                    <label class="block text-sm font-medium text-gray-700">ประเภท:</label>
                    <!-- <input type="text" readonly v-model="formData.emp_ids"
                        class="mt-1 block w-full rounded-md border-gray-300 bg-gray-50 shadow-sm focus:border-purple-500 focus:ring-purple-500" /> -->
                    <p
                        class="border border mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500">
                        ขายสินค้าออก</p>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700">รายการ *</label>
                    <input type="text" placeholder="รหัสรายการ" v-model="formData.listCode"
                        class="border mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700">วันที่</label>
                    <input type="date" v-model="formData.sellDate"
                        class="border  mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700">วันหมดอายุ</label>
                    <input type="date" v-model="formData.expireDate"
                        class="border  mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700">อ้างอิง</label>
                    <input type="email" v-model="formData.reference"
                        class="border  mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700">ช่องทางการขาย</label>
                    <input type="email" v-model="formData.channel"
                        class="border  mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                </div>

                <div class="md:col-span-2">
                    <label class="block text-sm font-medium text-gray-700">ประเภทภาษี</label>
                    <input type="email" v-model="formData.taxType"
                        class="border  mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                </div>

            </form>


            <!-- หัวข้อ "แบบฟอร์มลูกค้า" ด้านซ้าย และ "แบบฟอร์มสินค้า" ด้านขวา -->
            <div class="gap-6 items-start mt-4">
                <!-- แบบฟอร์มลูกค้า: อยู่ฝั่งซ้าย -->
                <div>
                    <div class="flex items-center gap-2 mb-4">
                        <span class="material-icons text-blue-600">account_circle</span>

                        <h1 class="text-xl">แบบฟอร์มลูกค้า</h1>
                    </div>

                    <form class="grid grid-cols-1 gap-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-700">ชื่อลูกค้า</label>
                            <input type="text" placeholder="ชื่อ, รหัส" v-model="formData.fullName"
                                class="mt-1 block w-full rounded-md border border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700">รหัสลูกค้า</label>
                            <input type="text" v-model="formData.customerCode"
                                class="mt-1 block w-full rounded-md border border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700">เบอร์โทรศัพท์ลูกค้า</label>
                            <input type="text" v-model="formData.phone"
                                class="mt-1 block w-full rounded-md border border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700">อีเมลลูกค้า</label>
                            <input type="text" v-model="formData.email"
                                class="mt-1 block w-full rounded-md border border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700">ที่อยู่ลูกค้า</label>
                            <input type="text" v-model="formData.address"
                                class="mt-1 block w-full rounded-md border border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500" />
                        </div>
                    </form>
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
                                <input type="number" v-model.number="product.qty"
                                    class="w-full border rounded px-2 py-1 text-right" placeholder="จำนวน" />
                            </td>

                            <!-- ราคาต่อหน่วย -->
                            <td class="px-4 py-2 border">
                                <input type="number" v-model.number="product.pro_unit_price"
                                    class="w-full border rounded px-2 py-1 text-right" readonly
                                    placeholder="ราคาต่อหน่วย" />
                            </td>

                            <!-- ส่วนลด -->
                            <td class="px-4 py-2 border">
                                <input type="number" v-model.number="product.discount"
                                    class="w-full border rounded px-2 py-1 text-right" readonly placeholder="ส่วนลด" />
                            </td>

                            <!-- รวม -->
                            <td class="px-4 py-2 border text-right">
                                {{ totalprice(product) }}
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
                            <input type="text" v-model="formData.receiverName"
                                class="w-full border rounded px-3 py-2" />
                        </div>

                        <div class="flex items-center gap-2 text-sm text-blue-600 cursor-pointer">
                            <span class="material-icons text-base">content_copy</span>
                            <span>คัดลอกจากข้อมูลลูกค้า</span>
                        </div>

                        <div>
                            <label class="text-sm text-gray-700 block mb-1">เบอร์โทรศัพท์ผู้รับ</label>
                            <input type="tel" v-model="formData.receiverPhone"
                                class="w-full border rounded px-3 py-2" />
                        </div>

                        <div>
                            <label class="text-sm text-gray-700 block mb-1">อีเมลผู้รับ</label>
                            <input type="email" v-model="formData.receiverEmail"
                                class="w-full border rounded px-3 py-2" />
                        </div>

                        <div>
                            <label class="text-sm text-gray-700 block mb-1">ที่อยู่/จัดส่ง</label>
                            <textarea rows="4" v-model="formData.receiverAddress"
                                class="w-full border rounded px-3 py-2 resize-none"></textarea>
                        </div>

                        <button class="mt-2 px-4 py-2 bg-indigo-600 text-white text-sm rounded hover:bg-indigo-700">
                            ตรวจสอบที่อยู่
                        </button>
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
                        <label class="text-sm text-gray-700 block mb-1">วันส่งสินค้า</label>
                        <div class="flex">
                            <input type="date" v-model="formData.deliveryDate"
                                class="flex-grow border rounded-l px-3 py-2 bg-gray-50 text-gray-700" />
                            <button class="bg-gray-200 px-3 rounded-r hover:bg-gray-300">
                                <span class="material-icons text-sm">calendar_today</span>
                            </button>
                        </div>
                    </div>

                    <div>
                        <label class="text-sm text-gray-700 block mb-1">Tracking No.</label>
                        <input type="text" v-model="formData.trackingNo" class="w-full border rounded px-3 py-2" />
                    </div>
                </div>
            </div>


        </div>
        
        <div class=" w-full mx-auto p-6 rounded-lg bg-white shadow-md space-y-8">
            <div class="md:col-span-2 mt-4">
                <button type="button" @click="saveDocument"
                    class="w-full bg-purple-700 text-white py-2 px-4 rounded-md hover:bg-purple-800 transition">บันทึก
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

const BASE_URL = import.meta.env.VITE_API_URL;
const BASE_URL_IMAGE = import.meta.env.VITE_API_URL_IMAGE;


console.log("BASE_URL_IMAGE:", BASE_URL_IMAGE);

export default {
    name: 'SignupForm',
    components: {
        ProductSelector,
    },
    data() {
        return {
            BASE_URL_IMAGE: import.meta.env.VITE_API_URL_IMAGE,
            showProductSelector: false,
            showProductSelectoronly: false,
            selectedProducts: [],
            editIndex: null,
            products: [],

            Apiproducts: [],

            // pageCurrent: 1,
            // pageSize: 30,
            // totalItems: 0,

            // fix โหลดเร็ว
            // pageCurrent: 1,
            // pageSize: 30,
            // totalItems: 0,
            // Apiproducts: [],
            // loading: false,
            // cacheProducts: {}, // เก็บ cache ตาม page

            formData: {
                listCode: '',
                sellDate: '',

                expireDate: '',
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

                // product_name : product.pro_name,
                // qty: '',
                // pro_name: '',

                productList: [],

                warehouseCode: 'H1',
                docType: 'SO',
            },
        };
    },

    watch: {
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
                const qty = product.qty || 0;
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
            const vat = netBeforeVat * 0.07;
            return (netBeforeVat + vat).toFixed(2);
        },


    },

    methods: {
        async saveDocument() {

            // console.log(ข้อมูลทั้งหมดใน formData:", this.formData);
            console.log("ข้อมูลทั้งหมดใน formData:", JSON.parse(JSON.stringify(this.formData)));

            const requiredFields = [
                'listCode', 'sellDate', 'expireDate', 'reference', 'channel', 'taxType',
                'fullName', 'customerCode', 'phone', 'email', 'address',
                'receiverName', 'receiverPhone', 'receiverEmail', 'receiverAddress',
                'deliveryDate', 'trackingNo', 'deliveryType'
            ];

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
            let documentRunning = null;
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

                documentRunning = docResponse.data;

                console.log("Log Value documentRunning: ", documentRunning);

                if (!documentRunning.success) {
                    Swal.fire({ text: documentRunning.message, icon: 'error' });
                    return;
                }

                console.log("📄 ได้เลขเอกสาร:", documentRunning);

            } catch (err) {
                const message = err.response?.data?.message || err.message || 'เกิดข้อผิดพลาดในการสร้างเลขเอกสาร';
                Swal.fire({ text: message, icon: 'error' });
                return;
            }

            // ===> ใส่เลขเอกสารลงใน formData เช่น
            this.formData.documentNo = documentRunning.document_number; // เช่น H1-SO25680619-0003


            if (this.selectedProducts.length === 0) {
                Swal.fire({
                    text: 'กรุณาเพิ่มสินค้าอย่างน้อย 1 รายการ',
                    icon: 'warning'
                });
                return;
            }

            for (const product of this.selectedProducts) {
                if (!product.pro_name || !product.qty || product.qty <= 0 || !product.pro_unit_price || product.pro_unit_price <= 0) {
                    Swal.fire({
                        text: 'กรุณากรอกชื่อสินค้า, จำนวน, และมูลค่าต่อหน่วยให้ครบถ้วนและถูกต้องสำหรับทุกรายการสินค้า',
                        icon: 'warning'
                    });
                    return; // หยุดการทำงานหากมีสินค้าที่ไม่สมบูรณ์
                }
            }


            // เตรียมข้อมูลสินค้า
            this.formData.productList = this.selectedProducts.map(product => ({
                pro_name: product.pro_name,
                qty: product.qty
            }));

            // 👇 ดึงชื่อสินค้าแบบรวมเป็น string เช่น: "MacBook 13, MacBook 15"
            this.formData.product_name = this.selectedProducts.map(p => p.pro_name).join(', ');

            // 👇 รวมจำนวนสินค้าทั้งหมด เช่น: 4 + 2 = 6
            this.formData.product_qty = this.selectedProducts.reduce((sum, p) => sum + (p.qty || 0), 0);

            // สร้าง payload
            const payload = new FormData();
            for (const key in this.formData) {
                payload.append(key, this.formData[key]);
                //แก้ที่นี้
                if (key === 'productList') {
                    // productList ต้องแปลงเป็น string ก่อนแนบ
                    payload.append('productList', JSON.stringify(this.formData[key]));
                }
            }

            // payload.append('status', this.formData.status || 'Active');

            // ✅ ส่ง selectedProducts เป็น JSON string
            payload.append('products', JSON.stringify(this.selectedProducts));

            // เพื่อมข้อมูล FormData
            try {
                const response = await axios.post('http://localhost/api_admin_dashboard/backend/api/post_sale_order.php', payload, {
                    // headers: { 'Content-Type': 'application/json' },
                });

                console.log("Log Value Data: ", response.data);

                const resData = typeof response.data === 'string' ? JSON.parse(response.data) : response.data;
                Swal.fire({ text: resData.message, icon: 'success' });
            } catch (err) {
                const message = err.response?.data?.message || err.message || 'Unknown error';
                Swal.fire({ text: message, icon: 'error' });
            }



        },


        // ใช้ได้แต่โหลดช้า
        async getProduct(page = 1) {

            const getLevelSS = JSON.parse(localStorage.getItem('selectDataCustomer') || 'null');

            // ใช้ 0 แทนถ้า level เป็น null หรือ undefined
            const level = getLevelSS?.data2?.level ?? 0;


            try {
                // กำหนด pageSize ตามที่ user ต้องการ หรือเก็บไว้ใน data() แล้วส่งไป
                const raw = {
                    pageCurrent: page,
                    keywords: '',
                    level: level,
                    pageSize: this.pageSize // this.pageSize เช่น 30, 50 หรือ item_count
                };

                console.log("raw:", raw);

                const response = await axios.post(`${BASE_URL}/Goods2/product`, raw, {
                    headers: {
                        'Content-Type': 'application/json'
                    }
                });

                const data = response.data.data;

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

                console.log('Loaded products:', this.Apiproducts);
                console.log('Total items:', this.totalItems);

            } catch (err) {
                const message = err.response?.data?.message || err.message || 'Unknown error';
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

        addProductRow() {
            this.selectedProducts.push({
                id: Date.now(),
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
            const qty = product.qty || 0;
            const price = product.pro_unit_price || 0;
            const discount = product.discount || 0;
            const totalprice = (qty * price - discount).toFixed(2);
            console.log('Log value:', totalprice);
            return totalprice;
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


        removeProduct(index) {
            // this.selectedProducts.splice(index, 1);
            Swal.fire({
                title: 'ยืนยันการลบ?',
                text: 'คุณต้องการลบสินค้านี้ออกจากรายการใช่หรือไม่?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'ใช่, ลบเลย!',
                cancelButtonText: 'ยกเลิก'
            }).then((result) => {
                if (result.isConfirmed) {
                    this.selectedProducts.splice(index, 1);
                    Swal.fire('ลบแล้ว!', 'สินค้าถูกลบออกจากรายการ.', 'success');
                }
            });
        },

    },
    mounted() {
        this.getProduct(1);
    },
    created() {

        this.getProduct();
        // accountLoginSubmit();
    },


};

</script>

<style scoped>
/* Optional custom styles */
.box {

    margin: 30px;
    background-color: none;

}

.mainbox {

    justify-items: center;

}

input {
    padding: 4px;
    width: 100%;
    height: 40px;
}

.data {
    text-align: center;
    justify-items: center;
}

.p {

    p {
        padding: 7px;
        width: 100%;
        height: 40px;
        justify-items: center;

    }
}
</style>
