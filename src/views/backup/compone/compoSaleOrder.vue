<template>
    <div
        class="mainbox flex flex-col in-h-screen items-center gap-4 justify-center bg-gray-100 py-12 px-4 sm:px-6 lg:px-8">

        <!-- ฟอร์มรายการเอกสาร -->
        <SaleOrderForm :formData="formData" />

        <!-- ฟอร์มรายการสินค้า -->
        <ProductForm :formData="formData" :Apiproducts="Apiproducts" :selectedProducts="selectedProducts"
            :BASE_URL_IMAGE="BASE_URL_IMAGE" :addSelectedProducts="addSelectedProducts"
            :replaceProductInRow="replaceProductInRow" :removeAllProducts="removeAllProducts"
            :removeProduct="removeProduct" :openSelectorForRow="openSelectorForRow" :addProductRow="addProductRow"
            :totalprice="totalprice" />

        <!-- ฟอร์มข้อมูลที่อยู่ผู้รับ -->
        <ReceiverInfoForm :formData="formData" />

        <!-- ปุ่มบันทึก -->
        <div class="w-full mx-auto p-6 rounded-lg bg-white shadow-md space-y-8">
            <div class="md:col-span-2 mt-4">
                <button type="button" @click="saveDocument"
                    class="w-full bg-purple-700 text-white py-2 px-4 rounded-md hover:bg-purple-800 transition">
                    บันทึก
                </button>
            </div>
        </div>
    </div>
</template>

<script>
import { ref, reactive, onMounted, watch } from 'vue';
import Swal from 'sweetalert2';
import axios from 'axios';

import SaleOrderForm from '@/components/ComSaleOrder/SaleOrderForm.vue';
import ProductForm from '@/components/ComSaleOrder/ProductForm.vue';
import ReceiverInfoForm from '@/components/ComSaleOrder/ReceiverInfoForm.vue';

const BASE_URL = import.meta.env.VITE_API_URL;
const BASE_URL_IMAGE = import.meta.env.VITE_API_URL_IMAGE;

export default {
    name: 'CreateSaleOrderPage',
    components: {
        SaleOrderForm,
        ProductForm,
        ReceiverInfoForm,
    },
    setup() {
        const formData = reactive({
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
            deliveryFee: '',
            productList: [],
            warehouseCode: 'H1',
            docType: 'SO',
        });

        const selectedProducts = ref([]);
        const Apiproducts = ref([]);

        const getProduct = async () => {
            try {
                const raw = {
                    pageCurrent: 1,
                    keywords: '',
                    level: 0,
                    pageSize: 1000,
                };
                const response = await axios.post(`${BASE_URL}/Goods2/product`, raw);
                Apiproducts.value = response.data.data?.data2 || [];
            } catch (err) {
                Swal.fire({ text: err.message, icon: 'error' });
            }
        };

        const handleProductUpdate = (products) => {
            selectedProducts.value = products;
        };

        const saveDocument = async () => {
            if (selectedProducts.value.length === 0) {
                Swal.fire({ text: 'กรุณาเพิ่มสินค้าอย่างน้อย 1 รายการ', icon: 'warning' });
                return;
            }

            const requiredFields = [
                'listCode', 'sellDate', 'expireDate', 'reference', 'channel', 'taxType',
                'fullName', 'customerCode', 'phone', 'email', 'address',
                'receiverName', 'receiverPhone', 'receiverEmail', 'receiverAddress',
                'deliveryDate', 'trackingNo', 'deliveryType'
            ];

            for (const field of requiredFields) {
                if (!formData[field]) {
                    Swal.fire({
                        text: 'กรุณากรอกข้อมูลที่จำเป็นให้ครบถ้วน',
                        icon: 'warning'
                    });
                    return;
                }
            }

            try {
                const docRunningPayload = {
                    warehouse_code: formData.warehouseCode,
                    doc_type: formData.docType
                };
                const docRes = await axios.post(
                    'http://localhost/api_admin_dashboard/backend/api/post_documentrunning.php',
                    docRunningPayload
                );
                const docData = docRes.data;
                if (!docData.success) throw new Error(docData.message);
                formData.documentNo = docData.document_number;
            } catch (err) {
                Swal.fire({ text: err.message || 'เกิดข้อผิดพลาดในการสร้างเลขเอกสาร', icon: 'error' });
                return;
            }

            formData.productList = selectedProducts.value.map(p => ({ pro_name: p.pro_name, qty: p.qty }));
            formData.product_name = selectedProducts.value.map(p => p.pro_name).join(', ');
            formData.product_qty = selectedProducts.value.reduce((sum, p) => sum + (p.qty || 0), 0);

            const payload = new FormData();
            for (const key in formData) {
                if (key === 'productList') {
                    payload.append('productList', JSON.stringify(formData[key]));
                } else {
                    payload.append(key, formData[key]);
                }
            }
            payload.append('products', JSON.stringify(selectedProducts.value));

            try {
                const response = await axios.post(
                    'http://localhost/api_admin_dashboard/backend/api/post_sale_order.php',
                    payload
                );
                const resData = typeof response.data === 'string' ? JSON.parse(response.data) : response.data;
                Swal.fire({ text: resData.message, icon: 'success' });
            } catch (err) {
                Swal.fire({ text: err.message || 'Unknown error', icon: 'error' });
            }
        };

        onMounted(getProduct);

        return {
            formData,
            selectedProducts,
            Apiproducts,
            BASE_URL_IMAGE,
            saveDocument,
            handleProductUpdate
        };
    }
};
</script>
<!-- 
<style scoped>
.mainbox {
  justify-items: center;
}
</style>

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
</style> -->

<style scoped>
.mainbox {
    justify-items: center;
}

input {
    padding: 4px;
    width: 100%;
    height: 40px;
}

.p p {
    padding: 7px;
    width: 100%;
    height: 40px;
    justify-items: center;
}
</style>
