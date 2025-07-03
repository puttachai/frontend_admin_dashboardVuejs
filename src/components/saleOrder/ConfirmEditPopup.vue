<template>
    <div
        class="fixed inset-0 bg-gradient-to-br via-purple-800 to-purple-700 bg-opacity-80 flex items-center justify-center z-50 overflow-y-auto p-4">
        <!-- <div class="bg-white rounded-xl shadow-2xl w-full max-w-7xl max-h-[90vh] overflow-y-auto p-8 space-y-8"
            role="dialog" aria-modal="true" aria-labelledby="modal-title"> -->
        <div class="bg-white rounded-xl shadow-2xl w-full max-w-7xl max-h-[90vh] overflow-y-auto">
            <!-- banner -->
            <div class="flex h-[70px] justify-between">

                <div class="px-6 border-b border-purple-200 flex justify-between items-center">
                    <h4 id="modal-title" class="text-xl font-extrabold text-purple-600  tracking-wide">
                        ยืนยันและแก้ไขข้อมูลก่อนบันทึก
                    </h4>
                    <!-- <button @click="$emit('cancel')" class="mb-6 border px-4 py-2 rounded-xl text text-red-500"
                        type="button">
                        X
                    </button> -->
                    <!-- <button @click="$emit('cancel')">
                        <span class="material-icons text-red-500 hover:text-gray-700">
                            close
                        </span>
                    </button> -->
                </div>

                <div class="content-center">
                    <button @click="$emit('cancel')">
                        <span class="material-icons text-red-500 hover:text-gray-700 item-center pr-1">
                            close
                        </span>
                    </button>
                </div>

            </div>


            <div class="p-6 space-y-8">
                <!-- Section Template -->
                <section class="space-y-4">
                    <h3 class="text-xl font-semibold text-purple-900 border-b border-purple-200 pb-2">
                        ข้อมูลทั่วไป
                    </h3>
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                        <div>
                            <label class="block mb-1 text-sm font-medium text-gray-700">อ้างอิง</label>
                            <input v-model="editData.reference" type="text"
                                class="w-full rounded-xl border border-purple-300 px-4 py-2 text-gray-800 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-400 focus:border-transparent transition"
                                placeholder="กรอกอ้างอิง" />
                        </div>
                        <div>
                            <label class="block mb-1 text-sm font-medium text-gray-700">ช่องทาง</label>
                            <input v-model="editData.channel" type="text"
                                class="w-full rounded-xl border border-purple-300 px-4 py-2 text-gray-800 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-400 focus:border-transparent transition"
                                placeholder="กรอกช่องทาง" />
                        </div>
                        <div>
                            <label class="block mb-1 text-sm font-medium text-gray-700">ประเภทภาษี</label>
                            <input v-model="editData.taxType" type="text"
                                class="w-full rounded-xl border border-purple-300 px-4 py-2 text-gray-800 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-400 focus:border-transparent transition"
                                placeholder="กรอกประเภทภาษี" />
                        </div>
                    </div>
                </section>

                <section class="space-y-4">
                    <h3 class="text-xl font-semibold text-purple-900 border-b border-purple-200 pb-2">
                        ข้อมูลลูกค้า
                    </h3>
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                        <div>
                            <label class="block mb-1 text-sm font-medium text-gray-700">เบอร์โทร</label>
                            <input v-model="editData.phone" type="tel"
                                class="w-full rounded-xl border border-purple-300 px-4 py-2 text-gray-800 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-400 focus:border-transparent transition"
                                placeholder="กรอกเบอร์โทร" />
                        </div>
                        <div>
                            <label class="block mb-1 text-sm font-medium text-gray-700">อีเมล</label>
                            <input v-model="editData.email" type="email"
                                class="w-full rounded-xl border border-purple-300 px-4 py-2 text-gray-800 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-400 focus:border-transparent transition"
                                placeholder="กรอกอีเมล" />
                        </div>
                        <div>
                            <label class="block mb-1 text-sm font-medium text-gray-700">ที่อยู่</label>
                            <textarea v-model="editData.address" rows="3"
                                class="w-full rounded-xl border border-purple-300 px-4 py-2 text-gray-800 shadow-sm resize-none focus:outline-none focus:ring-2 focus:ring-purple-400 focus:border-transparent transition"
                                placeholder="กรอกที่อยู่"></textarea>
                        </div>
                    </div>
                </section>

                <!--  -->
                <!-- สินค้า -->
                <section>
                    <div class="flex items-center gap-2 mb-4 text-purple-700 font-semibold text-2xl">
                        <span class="material-icons">assignment_add</span>
                        <span>สินค้า</span>
                    </div>

                    <div
                        class="overflow-x-auto max-h-[30rem] overflow-y-auto border border-purple-300 rounded-xl shadow-inner">
                        <table class="min-w-full text-left text-gray-800">
                            <thead class="bg-purple-100 sticky top-0 z-10">
                                <tr class="text-center text-purple-900 font-semibold select-none">
                                    <th class="p-3 border border-purple-300">รหัส</th>
                                    <th class="p-3 border border-purple-300">รูปภาพ</th>
                                    <th class="p-3 border border-purple-300">ชื่อสินค้า *</th>
                                    <th class="p-3 border border-purple-300">สี</th>
                                    <th class="p-3 border border-purple-300">จำนวน *</th>
                                    <th class="p-3 border border-purple-300">มูลค่าต่อหน่วย *</th>
                                    <th class="p-3 border border-purple-300">ส่วนลดต่อหน่วย</th>
                                    <th class="p-3 border border-purple-300">รวม</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(product, index) in editData.products" :key="product.pro_id"
                                    class="odd:bg-white even:bg-purple-50">
                                    <td class="p-3 border border-purple-300 text-center font-mono">
                                        {{ product.pro_id }}
                                    </td>
                                    <td class="p-3 border border-purple-300 text-center">
                                        <img v-if="product.pro_images" :src="product.pro_images.startsWith('http')
                                            ? product.pro_images
                                            : BASE_URL_IMAGE + product.pro_images
                                            " alt="product image"
                                            class="inline-block w-12 h-12 rounded-lg object-cover" />
                                        <span v-else class="material-icons text-gray-300 text-5xl"
                                            aria-label="ไม่มีรูปภาพ">broken_image</span>
                                    </td>
                                    <td class="p-3 border border-purple-300">
                                        <input type="text" v-model="product.pro_erp_title"
                                            class="w-full rounded-lg border border-purple-300 px-2 py-1 focus:outline-none focus:ring-1 focus:ring-purple-400 transition"
                                            placeholder="ชื่อสินค้า" />
                                    </td>
                                    <td class="p-3 border border-purple-300 text-center">
                                        <input type="text" v-model="product.pro_goods_sku_text"
                                            class="w-full rounded-lg border border-purple-300 px-2 py-1 bg-gray-100 text-center cursor-not-allowed"
                                            placeholder="สี" disabled />
                                    </td>
                                    <td class="p-3 border border-purple-300 text-center">
                                        <input type="number" min="0" v-model.number="product.pro_quantity"
                                            class="w-full rounded-lg border border-purple-300 px-2 py-1 text-right bg-gray-100 cursor-not-allowed"
                                            placeholder="จำนวน" disabled />
                                    </td>
                                    <td class="p-3 border border-purple-300 text-center">
                                        <input type="number" v-model.number="product.pro_unit_price"
                                            class="w-full rounded-lg border border-purple-300 px-2 py-1 text-right bg-gray-100 cursor-not-allowed"
                                            placeholder="ราคาต่อหน่วย" disabled />
                                    </td>
                                    <td class="p-3 border border-purple-300 text-center">
                                        <input type="number" v-model.number="product.discount"
                                            class="w-full rounded-lg border border-purple-300 px-2 py-1 text-right bg-gray-100 cursor-not-allowed"
                                            placeholder="ส่วนลด" disabled />
                                    </td>
                                    <td class="p-3 border border-purple-300 text-right font-semibold">
                                        {{ totalprice(product) }}
                                    </td>
                                </tr>
                                <tr v-if="!editData.products || editData.products.length === 0">
                                    <td colspan="8"
                                        class="p-4 border border-purple-300 text-center text-gray-400 italic">
                                        ไม่มีสินค้าในรายการ
                                    </td>
                                </tr>
                            </tbody>
                        </table>

                    </div>
                    <!-- รวม -->
                    <div class="mt-6 text-right space-y-1">
                        <div>มูลค่ารวมก่อนภาษี: <span class="ml-2">{{ totalAmountBeforeDiscount.toFixed(2) }}</span>
                        </div>
                        <div>ภาษีมูลค่าเพิ่ม (7%): <span class="ml-2">{{ (totalAmountBeforeDiscount * 0.07).toFixed(2)
                        }}</span>
                        </div>
                        <div class="text-xl font-bold text-purple-700 mt-2">
                            มูลค่ารวมสุทธิ: <span class="ml-2 text-blue-600">{{ grandTotal }}</span>
                        </div>
                    </div>
                </section>


                <section class="space-y-4">
                    <h3 class="text-xl font-semibold text-purple-900 border-b border-purple-200 pb-2">
                        ข้อมูลที่อยู่ผู้รับ
                    </h3>
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                        <div>
                            <label class="block mb-1 text-sm font-medium text-gray-700">ชื่อผู้รับ</label>
                            <input v-model="editData.receiverName" type="text"
                                class="w-full rounded-xl border border-purple-300 px-4 py-2 text-gray-800 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-400 focus:border-transparent transition"
                                placeholder="กรอกชื่อผู้รับ" />
                        </div>
                        <div>
                            <label class="block mb-1 text-sm font-medium text-gray-700">เบอร์โทรผู้รับ</label>
                            <input v-model="editData.receiverPhone" type="tel"
                                class="w-full rounded-xl border border-purple-300 px-4 py-2 text-gray-800 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-400 focus:border-transparent transition"
                                placeholder="กรอกเบอร์โทรผู้รับ" />
                        </div>
                        <div>
                            <label class="block mb-1 text-sm font-medium text-gray-700">ที่อยู่ผู้รับ</label>
                            <textarea v-model="editData.receiverAddress" rows="3"
                                class="w-full rounded-xl border border-purple-300 px-4 py-2 text-gray-800 shadow-sm resize-none focus:outline-none focus:ring-2 focus:ring-purple-400 focus:border-transparent transition"
                                placeholder="กรอกที่อยู่ผู้รับ"></textarea>
                        </div>
                    </div>
                </section>

                <section class="space-y-4">
                    <h3 class="text-xl font-semibold text-purple-900 border-b border-purple-200 pb-2">
                        ข้อมูลการจัดส่ง
                    </h3>
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                        <div>
                            <label class="block mb-1 text-sm font-medium text-gray-700">วันจัดส่ง</label>
                            <input type="date" v-model="editData.deliveryDate"
                                class="w-full rounded-xl border border-purple-300 px-4 py-2 text-gray-800 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-400 focus:border-transparent transition" />
                        </div>
                        <div>
                            <label class="block mb-1 text-sm font-medium text-gray-700">Tracking No.</label>
                            <input v-model="editData.trackingNo" type="text"
                                class="w-full rounded-xl border border-purple-300 px-4 py-2 text-gray-800 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-400 focus:border-transparent transition"
                                placeholder="กรอก Tracking No." />
                        </div>
                        <div></div>
                    </div>
                </section>

                <section class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <label class="block mb-1 text-sm font-medium text-gray-700">ส่วนลด</label>
                        <input v-model="editData.totalDiscount" type="text"
                            class="w-full rounded-xl border border-purple-300 px-4 py-2 text-gray-800 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-400 focus:border-transparent transition"
                            placeholder="กรอกส่วนลดรวม" />
                    </div>
                    <div>
                        <label class="block mb-1 text-sm font-medium text-gray-700">ค่าจัดส่ง</label>
                        <input type="number" v-model.number="editData.deliveryFee"
                            class="w-full rounded-xl border border-purple-300 px-4 py-2 text-gray-800 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-400 focus:border-transparent transition"
                            placeholder="กรอกค่าจัดส่ง" min="0" />
                    </div>
                </section>

                <section>
                    <label class="block mb-1 text-sm font-medium text-gray-700">หมายเหตุ</label>
                    <textarea v-model="editData.note" rows="3"
                        class="w-full rounded-xl border border-purple-300 px-4 py-2 text-gray-800 shadow-sm resize-none focus:outline-none focus:ring-2 focus:ring-purple-400 focus:border-transparent transition"
                        placeholder="กรอกหมายเหตุเพิ่มเติม"></textarea>
                </section>


                <!-- Action Buttons -->
                <div class="flex justify-end gap-5 mt-6">
                    <button @click="$emit('cancel')"
                        class="px-6 py-3 rounded-full bg-gray-300 hover:bg-gray-400 font-semibold transition"
                        type="button">
                        ยกเลิก
                    </button>
                    <button @click="confirmSave"
                        class="px-6 py-3 rounded-full bg-purple-700 hover:bg-purple-800 text-white font-semibold transition"
                        type="button">
                        ยืนยันและบันทึก
                    </button>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { reactive, computed } from "vue";

const props = defineProps({
    data: Object,
});

const emit = defineEmits(["confirm", "cancel"]);

const BASE_URL = import.meta.env.VITE_API_URL;
const BASE_URL_IMAGE = import.meta.env.VITE_API_URL_IMAGE;

// Clone data เพื่อแก้ไข local
const editData = reactive({
    ...props.data,
    products: props.data.products ? JSON.parse(JSON.stringify(props.data.products)) : [],
});

function confirmSave() {
    emit("confirm", { ...editData });
}

function totalprice(product) {
    const qty = product.pro_quantity || 0;
    const price = product.pro_unit_price || 0;
    const discount = product.discount || 0;
    return (qty * price - discount).toFixed(2);
}

// ✅ Computed รวมราคาก่อนภาษี
const totalAmountBeforeDiscount = computed(() => {
    const subtotal = editData.products.reduce((sum, product) => {
        const qty = product.pro_quantity || 0;
        const price = product.pro_unit_price || 0;
        const discount = product.discount || 0;
        return sum + (qty * price - discount);
    }, 0);

    const deliveryFee = parseFloat(editData.deliveryFee) || 0;
    const totalDiscount = parseFloat(editData.totalDiscount) || 0;
    const total = subtotal + deliveryFee - totalDiscount;

    return total < 0 ? 0 : total;
});

// ✅ Computed รวมราคาหลังบวกภาษี
const grandTotal = computed(() => {
    const vat = totalAmountBeforeDiscount.value * 0.07;
    return (totalAmountBeforeDiscount.value + vat).toFixed(2);
});

// const totalAmountBeforeDiscount = computed(() =>
//   props.products.reduce((sum, item) => {
//     const qty = Number(item.pro_quantity) || 0
//     const price = Number(item.pro_goods_price) || 0
//     const discount = product.discount || 0;
//     return sum + (qty * price - discount)
//   }, 0)
// )

// const grandTotal = computed(() =>
//   (totalAmountBeforeDiscount.value * 1.07).toFixed(2)
// )


</script>

<style scoped>
/* scrollbar style */
::-webkit-scrollbar {
    width: 8px;
    height: 8px;
}

::-webkit-scrollbar-thumb {
    background-color: rgba(124, 58, 237, 0.4);
    border-radius: 8px;
}

::-webkit-scrollbar-track {
    background: transparent;
}
</style>