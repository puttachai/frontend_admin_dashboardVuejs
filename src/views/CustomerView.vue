<template>
    <div class="max-w-5xl mx-auto my-10 p-8 bg-white shadow-2xl rounded-3xl space-y-8 border border-gray-100"
        @contextmenu.prevent>
        <!-- 🔍 Search -->
        <div class="flex items-center gap-3 border border-gray-300 bg-white px-4 py-3 rounded-xl shadow-sm">
            <span class="material-icons text-gray-500 text-xl">search</span>
            <input v-model="keyword" type="text" placeholder="ค้นหาด้วยเบอร์, ชื่อร้านค้า หรือรหัสร้านค้า..."
                class="w-full text-sm bg-transparent ๅ outline-none placeholder-gray-400" @input="onInput"
                confirm-type="search" />
        </div>
        <p class="text-xs text-gray-400 italic -mt-4"> * สามารถ ค้นหาได้ เบอร์มือถือ, ชื่อร้านค้า, รหัสร้านค้า</p>

        <!-- 🧾 Data Table -->
        <div class="overflow-x-auto border border-gray-200 rounded-xl shadow-inner bg-white/90">
            <table class="min-w-full text-sm text-gray-700">
                <thead class="bg-gradient-to-r from-indigo-50 to-purple-50 text-gray-600">
                    <tr>
                        <th class="text-left px-5 py-3 font-semibold">รหัส</th>
                        <th class="text-left px-5 py-3 font-semibold">ร้านค้า</th>
                        <th class="text-left px-5 py-3 font-semibold">
                            <div class="flex items-center gap-2">
                                <span class="material-icons text-sm text-gray-500">badge</span>
                                SaleId
                            </div>
                        </th>
                        <th class="px-5 py-3 text-center font-semibold">
                            <div class="flex items-center justify-center gap-2">
                                <input type="text" v-model="keyword_sale_no" placeholder="ค้นหา Sale"
                                    @focus="dropdownOpenIndex = 'header'"
                                    class="w-36 px-3 py-1.5 border border-gray-300 rounded-lg shadow-sm text-sm placeholder-gray-400 focus:ring-2 focus:ring-indigo-300 focus:outline-none" />
                                <button @click="searchSaleId"
                                    class="flex items-center gap-1 px-4 py-1.5 text-sm bg-indigo-600 text-white rounded-full hover:bg-indigo-700 transition">
                                    <span class="material-icons text-base">search</span> ค้นหา
                                </button>
                            </div>
                        </th>
                        <th class="text-center px-5 py-3 font-semibold">
                            <span class="material-icons text-sm text-gray-500">touch_app</span>
                        </th>
                    </tr>
                </thead>

                <tbody v-if="isLoading">
                    <tr>
                        <td colspan="10" class="py-10 text-center">
                            <svg class="animate-spin h-8 w-8 text-blue-600 mx-auto" xmlns="http://www.w3.org/2000/svg"
                                fill="none" viewBox="0 0 24 24">
                                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor"
                                    stroke-width="4"></circle>
                                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8H4z"></path>
                            </svg>
                            <div class="mt-2 text-gray-500">กำลังโหลดข้อมูล...</div>
                        </td>
                    </tr>
                </tbody>

                <tbody v-if="!isLoading">
                    <tr v-for="(item, index) in tableData" :key="index"
                        class="hover:bg-indigo-50 cursor-pointer transition duration-150">
                        <td class="px-5 py-3">{{ item.customer_no }}</td>
                        <td class="px-5 py-3">{{ item.nickname }}</td>
                        <td class="px-5 py-3">{{ item.sale_no }}</td>
                        <td class="px-5 py-3 text-gray-400 italic">–</td>
                        <td class="px-5 py-3 text-center">
                            <button @click="rowClick(item, index)" class="text-indigo-600 hover:underline font-medium">
                                เลือก
                            </button>
                        </td>
                    </tr>
                    <tr v-if="!tableData.length">
                        <td colspan="5" class="text-center text-gray-400 py-6 italic">ไม่พบข้อมูล</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- 🔢 Pagination -->
        <ConfigProvider :globalConfig="localeConfig">
            <div class="overflow-auto">
                <pagination v-model="pageCurrent" :pageSize.sync="pageSize" :total="total" show-page-size
                    :prev-button-props="{ content: '⏪' }" :next-button-props="{ content: '⏩' }"
                    @change="onPageSizeChange" class="mt-4" />
            </div>
        </ConfigProvider>
    </div>
</template>




<!-- <div class="text-sm text-gray-500 mt-2">
    * สามารถ ค้นหาได้ เบอร์มือถือ, ชื่อร้านค้า, รหัสร้านค้า
</div> -->
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
            selectedSales: [],
            saleList: ['Uppercase', 'Lowercase', 'Camel Case', 'Kebab Case'], // << แทนด้วยข้อมูลจาก API ได้
            isLoading: false,
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
            pageSize: 15,
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
        // this.searchSaleId();
        // accountLoginSubmit();
    },
    watch() {

        this.accountLoginSubmit();

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
            this.pageCurrent = 1; // Reset = 1 สำคัญมาก
            this.accountLoginSubmit()
            // this.searchSaleId()
            // this.searchTimer = setTimeout(() => {
            //     this.accountLoginSubmit()
            // }, 1000)
        },
        async accountLoginSubmit() {

            this.isLoading = true;

            const response = await axios.post(`${BASE_URL}/user/accountLogin4`, {
                account: account,
                // account: that.$Route.query.account,
                password: password,
                customer: '',
                version: '2.0.2',
                pageCurrent: this.pageCurrent,
                keyword: this.keyword,
                pageSize: 15
                // mobile: mobile.value,
                // password: password.value
            }, {
                // withCredentials: true,
                headers: {
                    'Content-Type': 'application/json'
                }
            });

            console.log("🔁 pageCurrent ส่งไป:", this.pageCurrent);
            console.log("📦 response data___:", response.data.data.data.data2);
            console.log("📦 response data:", response.data);


            // console.log(response.data.data.data.data2);
            const saleNos = response.data.data.data.data2.map(item => item.sale_no);
            console.log("🧾 รายการ sale_no ทั้งหมด:", saleNos);

            if (response.data.code == 1) {

                this.total = response.data.data.data.customer_count;
                // this.dataselect = response.data.data.data.data2;
                this.tableData = response.data.data.data.data2;
                console.log("🧾 รายการ this.tableData ทั้งหมด:", this.tableData);

                // this.pageSize = (this.total<this.pageSize) ?this.total:this.pageSize;
                this.pageSize = (this.total < this.pageSize) ? this.total : parseInt(this.pageSize);

                console.log((this.total + ' ' + parseInt(this.pageSize)));

                console.log("Log total: ", this.total);
                console.log("Log this.tableData: ", this.tableData);

                this.isLoading = false;

                // return;

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

            clearTimeout(this.searchTimer)

            console.log("adasddad: ");

            if (!this.keyword_sale_no.trim()) {

                try {
                    const response = await axios.post(`${BASE_URL}/user/accountLogin4`, {
                        account: account,
                        password: password,
                        customer: '',
                        version: '2.0.2',
                        pageCurrent: this.pageCurrent,
                        keyword: this.keyword,
                    }, {
                        headers: {
                            'Content-Type': 'application/json',
                        },
                    });

                    console.log("Log response.data.data: ", response.data.data);

                    if (response.data.code === 1) {
                        this.total = response.data.data.data.customer_count;
                        this.dataselectSale_no = response.data.data.data2;
                        this.tableData = [...this.dataselectSale_no]; // เพื่อแสดงผลลัพธ์
                        console.log("Log searchSaleId total: ", this.total);
                        console.log("Log searchSaleId dataselectSale_no: ", this.dataselectSale_no);

                        // this.pageSize = (this.total<this.pageSize) ?this.total:this.pageSize;
                        this.pageSize = (this.total < this.pageSize) ? this.total : parseInt(this.pageSize);


                    } else {
                        console.warn('ไม่พบข้อมูล', response.data.message);
                        this.dataselectSale_no = [];
                        this.tableData = [];
                    }
                } catch (err) {
                    console.error("searchSaleId Error:", err);
                }

            } else {

                try {
                    const response = await axios.post(`${BASE_URL}/user/accountLogin4`, {
                        account: account,
                        password: password,
                        customer: '',
                        version: '2.0.2',
                        pageCurrent: this.pageCurrent,
                        keyword: this.keyword + '$_' + this.keyword_sale_no + '_$',
                    }, {
                        headers: {
                            'Content-Type': 'application/json',
                        },
                    });

                    console.log("Log response.data.data: ", response.data.data);

                    if (response.data.code === 1) {
                        this.total = response.data.data.data.customer_count;
                        this.dataselectSale_no = response.data.data.data2;
                        this.tableData = [...this.dataselectSale_no]; // เพื่อแสดงผลลัพธ์
                        console.log("Log searchSaleId total: ", this.total);
                        console.log("Log searchSaleId dataselectSale_no: ", this.dataselectSale_no);
                    } else {
                        console.warn('ไม่พบข้อมูล', response.data.message);
                        this.dataselectSale_no = [];
                        this.tableData = [];
                    }
                } catch (err) {
                    console.error("searchSaleId Error:", err);
                }
            }


        },


        async accountLoginCustomerSubmit(row) {

            const response = await axios.post(`${BASE_URL}/user/accountLogin4`, {
                account: row.mobile,
                password: row.mobile,
                customer: row.customer_no || '',
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

                const gettoken = localStorage.getItem('token');

                // เก็บข้อมูลลง localStorage แบบ string
                localStorage.setItem('selectDataCustomer', JSON.stringify(response.data.data));

                const selectDataCustomer = JSON.parse(localStorage.getItem('selectDataCustomer'));

                console.log('log selectDataCustomer: ', selectDataCustomer);
                console.log('log gettoken: ', gettoken);


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

<style scoped>
/* บังคับให้ตารางเลื่อนแนวนอน */
.overflow-x-auto {
    overflow-x: auto; /* อนุญาตให้เลื่อนในแนวนอน */
    width: 100%; /* ขนาดเต็ม */
}

/* กำหนดขนาดขั้นต่ำของตาราง */
table {
    min-width: 800px; /* ขนาดขั้นต่ำของตาราง */
    border-collapse: collapse; /* ลดช่องว่างระหว่างเซลล์ */
}

/* ปรับขนาดฟอนต์และระยะห่างเมื่อหน้าจอเล็ก */
@media (max-width: 768px) {
    th, td {
        padding: 0.5rem; /* ลดระยะห่าง */
        font-size: 0.875rem; /* ลดขนาดฟอนต์ */
    }
}
</style>


<!-- // async searchSaleId() {
    //     this.loading = true;
    //     const allSales = await this.fetchAllSales(this.keyword_sale_no);
    //     this.dataselectSale_no = allSales;
    //     this.tableData = allSales;
    //     this.total = allSales.length;
    //     this.loading = false;

    //     console.log("ดึงข้อมูลทั้งหมดจาก keyword_sale_no แล้ว:", allSales);
    // },

    // async searchSaleId() {

    //     const response = await axios.post(`${BASE_URL}/user/accountLogin4`, {
    //         account: account,
    //         // account: that.$Route.query.account,
    //         password: password,
    //         customer: '',
    //         version: '2.0.2',
    //         // pageCurrent: 1, // 
    //         // pageSize: 99999, //
    //         pageCurrent: this.pageCurrent,
    //         keyword: this.keyword_sale_no,
    //         // mobile: mobile.value,
    //         // password: password.value
    //     }, {
    //         // withCredentials: true,
    //         headers: {
    //             'Content-Type': 'application/json'
    //         }
    //     });

    //     console.log(response.data.data.data.data2);

    //     if (response.data.code == 1) {

    //         this.total = response.data.data.data.customer_count;
    //         this.dataselectSale_no = response.data.data.data.data2;
    //         // this.dataselectSale_no = response.data.data.data.data2;
    //         // this.tableData = response.data.data.data.data2;

    //         console.log("Log total: ", this.total);
    //         console.log("Log this.dataselectSale_no: ", this.dataselectSale_no);

    //     } else {
    //         error.value = response.data.message || 'failed'
    //         // Swal.fire({
    //         //     title: 'ล็อกอินไม่สำเร็จ',
    //         //     text: error.value || 'โปรดลองใหม่ภายหลัง',
    //         //     icon: 'error',
    //         // });
    //     }

    // }, -->

<!-- 
// async fetchAllSales(keyword) {
    //     const allData = [];
    //     let currentPage = 1;
    //     let hasMore = true;

    //     while (hasMore) {
    //         const response = await axios.post(`${BASE_URL}/user/accountLogin4`, {
    //             account: account,
    //             password: password,
    //             customer: '',
    //             version: '2.0.2',
    //             pageCurrent: currentPage,
    //             keywords: keyword
    //         }, {
    //             headers: {
    //                 'Content-Type': 'application/json'
    //             }
    //         });

    //         if (response.data.code === 1) {
    //             const data = response.data.data.data.data2;
    //             const total = response.data.data.data.customer_count;
    //             allData.push(...data);

    //             if (allData.length >= total || data.length === 0) {
    //                 hasMore = false;
    //             } else {
    //                 currentPage++;
    //             }
    //         } else {
    //             hasMore = false;
    //             console.error("โหลดข้อมูลล้มเหลว: ", response.data.message);
    //         }
    //     }

    //     return allData;
    // },

 -->

<!-- // เปลี่ยนหน้า pagination
// changePage(page) {

//     this.pageCurrent = page.current;

//     this.pageNext = this.pageCurrent * this.pageSize;

//     //console.log(this.pageNext)

//     // ถ้าต้องการ scroll ขึ้นบน
//     //uni.pageScrollTo({ scrollTop: 0, duration: 200 });
//     this.accountLoginSubmit();
// }, -->