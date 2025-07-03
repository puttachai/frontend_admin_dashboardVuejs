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
                            <input type="text" v-model="product.pro_erp_title" class="w-full border rounded px-2 py-1"
                                placeholder="ชื่อสินค้า" />
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
    </div>

</template>

<!-- <script>
import ProductSelector from '../ProductSelector.vue';

export default {
    name: 'ProductForm',
    components: { ProductSelector },
    props: [
        'formData',
        'Apiproducts',
        'selectedProducts',
        'BASE_URL_IMAGE',
        'addSelectedProducts',
        'replaceProductInRow',
        'removeAllProducts',
        'removeProduct',
        'openSelectorForRow',
        'addProductRow',
        'totalprice'
    ]
};
</script> -->

<script>

import ProductSelector from '../ProductSelector.vue';

export default {
  props: {
    formData: Object,
    selectedProducts: Array,
    Apiproducts: Array,
    showProductSelector: Boolean,
    showProductSelectoronly: Boolean,
  },
  emits: [
    'addSelectedProducts',
    'replaceProductInRow',
    'removeAllProducts',
    'removeProduct',
    'openSelectorForRow',
    'addProductRow',
    'totalprice'
  ],
  methods: {
    handleAddRow() {
      this.$emit('addProductRow');
    },
    // เช่นเวลาเรียก:
    handleRemove(index) {
      this.$emit('removeProduct', index);
    }
  }
};
</script>


<style scoped>
.data {
  text-align: center;
  justify-items: center;
}

input {
  padding: 4px;
  width: 100%;
  height: 40px;
}
</style>
