เปลี่ยน นำตัวของ ช่อง search นั้นไปแทนที่ตัวของ th   <th class="px-4 py-2 text-left text-sm font-medium text-gray-600">รหัส Sale</th>  ของ รหัส Sale 

<template> 
    <div class="max-w-4xl mx-auto p-6 mt-4 mb-4 space-y-6 bg-white rounded-lg shadow-md" @contextmenu.prevent>
        <!-- Search Section -->
        <div class="flex items-center space-x-4">
            <!-- Search Icon -->
            <span class="material-icons text-gray-600" style="font-size: 28px;">search</span>
            <!-- Search Input -->
            <input
                class="w-full p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                v-model="keyword" placeholder="ค้นหา..." @input="onInput" confirm-type="search" />
        </div>

        <div class="text-sm text-gray-500 mt-2">
            * สามารถ ค้นหาได้ เบอร์มือถือ, ชื่อร้านค้า, รหัสร้านค้า
        </div>

        <!-- Data Table -->
        <div class="overflow-x-auto ">
            <table class="min-w-full table-auto border-collapse bg-gray-50 border border-gray-200">
                <thead>
                    <tr class="bg-gray-200">
                        <th class="px-4 py-2 text-left text-sm font-medium text-gray-600">รหัส</th>
                        <th class="px-4 py-2 text-left text-sm font-medium text-gray-600">ร้านค้า</th>
                        <th class="px-4 py-2 text-left text-sm font-medium text-gray-600">รหัส Sale</th>
                        <th class="px-4 py-2 text-center text-sm font-medium text-gray-600">เลือก</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(item, index) in tableData" :key="index" class="hover:bg-gray-100 cursor-pointer">
                        <td class="px-4 py-2 text-sm text-gray-700">{{ item.customer_no }}</td>
                        <td class="px-4 py-2 text-sm text-gray-700">{{ item.nickname }}</td>
                        <!-- รหัส Sale -->
                        <td class="px-4 py-2 text-sm text-gray-700">
                            <div class="relative">
                                <input type="text" v-model="keyword_sale_no" placeholder="ค้นหา Sale"
                                    @input="searchSaleId"
                                    class="w-full px-2 py-1 border border-gray-300 rounded-md focus:outline-none"
                                    @focus="dropdownOpenIndex = index" />

                                <div v-show="dropdownOpenIndex === index"
                                    class="absolute z-[100] w-full mt-1 bg-white border border-gray-300 rounded-md shadow-lg max-h-40 overflow-y-auto">
                                    <div v-for="(item, idx) in dataselectSale_no" :key="idx"
                                        class="px-3 py-1 hover:bg-blue-100 flex items-center space-x-2 cursor-pointer">
                                        <input type="checkbox" :value="item.sale_no" v-model="selectedSales"
                                            @change="onSaleSelected(index)" />
                                        <label>{{ item.sale_no }}</label>
                                    </div>
                                </div>
                            </div>
                        </td>


                        <!-- <td class="px-4 py-2 text-sm text-gray-700">{{ item.sale_no }}</td> -->
                        <td @click="rowClick(item, index)" class="px-4 py-2 text-sm text-center text-blue-500">เลือก
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- :page-size-options="[5, 10, 15, 20]" show-jumper -->
        <ConfigProvider :globalConfig="localeConfig">
            <div class="overflow-auto">
                <pagination v-model="pageCurrent" :pageSize.sync="pageSize" :total="total" show-page-size
                    :prev-button-props="{ content: '⏪' }" :next-button-props="{ content: '⏩' }"
                    @change="onPageSizeChange" class="mt-4" />
            </div>
        </ConfigProvider>

    </div>
</template>


<script>
//  import '@/shopro/store/modules/shopro.js';

import axios from 'axios'
import { ref } from 'vue'
import { useRouter } from 'vue-router';
// import { Pagination } from 'tdesign-vue-next';
import { Pagination, ConfigProvider } from 'tdesign-vue-next'
import enConfig from 'tdesign-vue-next/es/locale/en_US'

const BASE_URL = import.meta.env.VITE_API_URL;
console.log("Show BASE_URL: ", BASE_URL);

const error = ref('');
let timer = null;
let arr = [];

const account = localStorage.getItem('account')
const password = localStorage.getItem('password')
console.log("Log Value: ", account);
console.log("Log Value: ", password);

const router = useRouter()
//  import {
//   mapMutations,
//   mapActions,
//   mapState,
//   mapGetters
//  } from "vuex";
export default {
    components: {
        Pagination,
        ConfigProvider,
    },

    data() {
        return {
            dropdownOpenIndex: null,
            searchText: [],
            selectedSale: [],
            selectedSales:[],
            saleList: ['Uppercase', 'Lowercase', 'Camel Case', 'Kebab Case'], // << แทนด้วยข้อมูลจาก API ได้
            // skeletonLoadingTime: true,
            // fadeOutTime: "1.0",
            // setfadeOutTime: "1000",
            // animateTime: "1.0",
            // startFadeOut: true,
            // HomeHeadLoading: true,
            // wgtInfoversion: "",
            versionLatest: "",
            dataselect: [],
            dataselectSale_no: [],
            filteredData: [],   // ข้อมูลหลังกรอง
            searchVal: '',
            tableData: [],
            // 每页数据量
            pageSize: 10,
            pageNext: 15,
            // 当前页
            pageCurrent: 1,
            limit: 5, // หรือจำนวนที่คุณต้องการแสดงปุ่ม page
            disabled: false,
            // 数据总量
            total: 0,
            loading: false,
            keyword: '',
            keyword_sale_no: '',
        };
    },
    // computed: {
    //     paginatedData() {
    //         const start = (this.pageCurrent - 1) * 10;
    //         const end = start + 10;
    //         return this.tableData.slice(start, end);
    //     }
    // },

    computed: {
        localeConfig() {
            return enConfig;
        }
    },

    mounted() {
        window.addEventListener('wheel', () => { }, { passive: true });
    },
    created() {

        this.accountLoginSubmit();
        this.searchSaleId();
        // accountLoginSubmit();
    },
    onShow() {

    },
    onLoad() {

    },
    //   computed: {

    //    ...mapGetters(["userInfo","initShop", "homeTemplate", "hasTemplate", "isLogin",'cartList', 'checkCart']),


    //   },


    methods: {

        toggleDropdown(index) {
            if (this.dropdownOpenIndex === index) {
                this.dropdownOpenIndex = null;
            } else {
                this.dropdownOpenIndex = index;
            }

            if (!this.searchText[index]) {
                // this.$set(this.searchText, index, '');
                this.searchText[index] = '';
            }
        },
        filteredSales(index) {
            const text = this.searchText[index] || '';
            return this.saleList.filter((sale) =>
                sale.toLowerCase().includes(text.toLowerCase())
            );
        },
        selectSale(index, sale) {
            // this.$set(this.selectedSale, index, sale);
            // this.searchText[index] = '';
            this.selectedSale[index] = sale;
            this.dropdownOpenIndex = null;
        },

        onPageSizeChange(newSize) {
            this.pageSize = newSize.pageSize;
            this.pageCurrent = newSize.current; // รีเซ็ตกลับหน้าที่ 1 
            console.log("start newSize: ", newSize);
            this.accountLoginSubmit();
        },

        rowClick(row, idx) {
            console.log(row.mobile)

            this.accountLoginCustomerSubmit(row);
            //uni.showToast({ title: `คุณคลิกที่แถวที่ ${idx + 1}: ${row.mobile}`, icon: 'none' });
            // หรือจะ navigate ไปหน้าอื่น เช่น:
            // uni.navigateTo({ url: /pages/detail/detail?id=${row.id} });
        },

        onSaleSelected(index) {
            // กรอง dataselect ให้เหลือเฉพาะ Sale ที่ถูกเลือกไว้ใน selectedSales
            this.tableData = this.dataselect.filter((item) =>
                this.selectedSales.includes(item.sale_no)
            );
        },


        onInput() {
            // ยกเลิก timeout เก่าถ้ามี
            clearTimeout(this.searchTimer)
            // ตั้ง timeout ใหม่ รอ 500ms ถ้าไม่มีการพิมพ์เพิ่มถึงค่อยเรียก
            this.accountLoginSubmit()
            this.searchSaleId()
            // this.searchTimer = setTimeout(() => {
            //     this.accountLoginSubmit()
            // }, 1000)
        },
        async accountLoginSubmit() {

            const response = await axios.post(`${BASE_URL}/user/accountLogin4`, {
                account: account,
                // account: that.$Route.query.account,
                password: password,
                customer: '',
                version: '2.0.2',
                pageCurrent: this.pageCurrent,
                keyword: this.keyword,
                // mobile: mobile.value,
                // password: password.value
            }, {
                // withCredentials: true,
                headers: {
                    'Content-Type': 'application/json'
                }
            });

            console.log(response.data.data.data.data2);

            if (response.data.code == 1) {

                this.total = response.data.data.data.customer_count;
                this.dataselect = response.data.data.data.data2;
                this.tableData = response.data.data.data.data2;

                console.log("Log total: ", this.total);

            } else {
                error.value = response.data.message || 'failed'
                // Swal.fire({
                //     title: 'ล็อกอินไม่สำเร็จ',
                //     text: error.value || 'โปรดลองใหม่ภายหลัง',
                //     icon: 'error',
                // });
            }

        },
        async searchSaleId() {

            const response = await axios.post(`${BASE_URL}/user/accountLogin4`, {
                account: account,
                // account: that.$Route.query.account,
                password: password,
                customer: '',
                version: '2.0.2',
                pageCurrent: this.pageCurrent,
                keyword: this.keyword_sale_no,
                // mobile: mobile.value,
                // password: password.value
            }, {
                // withCredentials: true,
                headers: {
                    'Content-Type': 'application/json'
                }
            });

            console.log(response.data.data.data.data2);

            if (response.data.code == 1) {

                this.total = response.data.data.data.customer_count;
                this.dataselectSale_no = response.data.data.data.data2;
                this.tableData = response.data.data.data.data2;

                console.log("Log total: ", this.total);

            } else {
                error.value = response.data.message || 'failed'
                // Swal.fire({
                //     title: 'ล็อกอินไม่สำเร็จ',
                //     text: error.value || 'โปรดลองใหม่ภายหลัง',
                //     icon: 'error',
                // });
            }

        },
        async accountLoginCustomerSubmit(row) {

            const response = await axios.post(`${BASE_URL}/user/accountLogin4`, {
                account: row.mobile,
                password: row.mobile,
                customer: row.customer_no,
                version: '2.0.2',
                pageCurrent: this.pageCurrent,
                keyword: this.keyword,
                // mobile: mobile.value,
                // password: password.value
            }, {
                // withCredentials: true,
                headers: {
                    'Content-Type': 'application/json'
                }
            });

            console.log("log response 274: ", response);
            console.log(row);
            console.log(response.data);


            if (response.data.code === 1) {

                // console.log('log :',response.data.data.token);

                localStorage.setItem('token', response.data.data.token);

                // เก็บข้อมูลลง localStorage แบบ string
                localStorage.setItem('selectDataCustomer', JSON.stringify(response.data.data));

                const selectDataCustomer = JSON.parse(localStorage.getItem('selectDataCustomer'));

                console.log('log selectDataCustomer: ', selectDataCustomer);


                // window.location.reload();

                this.$router.push('/dashboard');

            } else {
                error.value = response.data.message || 'failed'
                // Swal.fire({
                //     title: 'ล็อกอินไม่สำเร็จ',
                //     text: error.value || 'โปรดลองใหม่ภายหลัง',
                //     icon: 'error',
                // });
            }

            // return {
            //     accountLoginCustomerSubmit
            // }

        },

    }
};
</script>
