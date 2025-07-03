<template>

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

</template>

<script>
export default {
  name: 'ReceiverInfoForm',
  props: ['formData']
};
</script>

<style scoped>
input {
  padding: 4px;
  width: 100%;
  height: 40px;
}
</style>
