<template>

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

</template>

<script>
export default {
  name: 'SaleOrderForm',
  props: ['formData']
};
</script>