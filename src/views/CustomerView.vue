<template>
  <!-- กล่องรวม breadcrumb + action bar -->
  <div class="fixed top-16 left-16 right-0 bg-white rounded-lg p-4 shadow-lg z-50 responsive-action-bar">

    <!-- Breadcrumb + ActionBar inline -->
    <div class="flex flex-wrap md:flex-nowrap justify-between  items-center gap-4">

      <!-- Breadcrumb -->
      <nav class="text-sm text-gray-600">
        <ul class="flex items-center space-x-1">
          <li>
            <span class="mx-1 text-gray-400">›</span>
            <router-link to="/createsalelist" class="text-purple-600 hover:text-purple-700 transition">Create Sale Order</router-link>
            <!-- <span class="mx-1 text-gray-400">›</span> -->
          </li>


        </ul>
      </nav>

    </div>
  </div>

  <div
    class="max-w-5xl mx-auto my-10 mt-20 p-8 bg-white shadow-2xl rounded-3xl space-y-8 border border-gray-100"
    @contextmenu.prevent
  >
    <!-- 🔍 Search -->
    <div
      class="flex items-center gap-3 border border-gray-300 bg-white px-4 py-3 rounded-xl shadow-sm"
    >
      <span class="material-icons text-gray-500 text-xl">search</span>
      <input
        v-model="keyword"
        type="text"
        placeholder="ค้นหาด้วยเบอร์, ชื่อร้านค้า หรือรหัสร้านค้า..."
        class="w-full text-sm bg-transparent outline-none placeholder-gray-400 mt-0"
        @input="onInput"
        confirm-type="search"
      />
    </div>
    <p class="text-xs text-gray-400 italic -mt-4">
      * สามารถ ค้นหาได้ เบอร์มือถือ, ชื่อร้านค้า, รหัสร้านค้า
    </p>

    <!-- 🧾 Data Table -->
    <div class="overflow-x-auto border border-gray-200 rounded-xl shadow-inner bg-white/90">
      <table class="w-full min-w-[650px] text-sm text-gray-700">

        <thead class="bg-gradient-to-r from-indigo-50 to-purple-50 text-gray-600 text-center">
          <tr>
            <th class="px-5 py-3 font-semibold">รหัส</th>
            <th class="px-5 py-3 font-semibold">ร้านค้า</th>
            <th class="px-5 py-3 font-semibold">
              <div class="flex justify-center items-center gap-1">
                <span class="material-icons text-sm text-gray-500">badge</span>
                SaleId
              </div>
            </th>
            <th class="px-5 py-3 font-semibold">
              <div class="flex flex-row sm:flex-row items-center justify-center gap-2">
                <input
                  type="text"
                  v-model="keyword_sale_no"
                  placeholder="ค้นหา Sale"
                  @focus="dropdownOpenIndex = 'header'"
                  class="w-[200px] py-1.5 border border-gray-300 rounded-md shadow-sm text-sm placeholder-gray-400 focus:ring-2 focus:ring-indigo-300 focus:outline-none"
                  style="margin-top: 0 !important"
                />
                <button
                  @click="searchSaleId(pageCurrent, pageSize)"
                  class="search flex items-center gap-1 px-3 py-1.5 bg-indigo-600 text-white text-sm rounded-md hover:bg-indigo-700 transition"
                >
                  <span class="material-icons text-sm">search</span>
                  ค้นหา
                </button>
              </div>
            </th>
            <th class="px-5 py-3 font-semibold">
              <span class="material-icons text-sm text-gray-500">touch_app</span>
            </th>
          </tr>
        </thead>

        <!-- Mobile -->
        <tbody v-if="!isLoading" class="lg:hidden">
            <tr
              v-for="(item, index) in tableData"
              :key="index"
              class="hover:bg-indigo-50 cursor-pointer transition duration-150"
              @click="handleRowClick(item, index)"
            >
              <td class="px-5 py-3">{{ item.customer_no }}</td>
              <td class="px-5 py-3">{{ item.nickname }}</td>
              <td class="px-5 py-3">{{ item.sale_no }}</td>
              <td class="px-5 py-3 text-gray-400 italic">–</td>
              <td class="px-5 py-3 text-center">
                <button
                  @click.stop="rowClick(item, index)"
                  class="text-indigo-600 hover:underline font-medium"
                >
                  เลือก
                </button>
              </td>
            </tr>
            <tr v-if="!tableData.length" class="lg:hidden">
              <td colspan="5" class="py-10">
                <div class="flex justify-center items-center">
                  <span class="text-gray-400 italic text-center">ไม่พบข้อมูล</span>
                </div>
              </td>
            </tr>

          </tbody>

        <tbody v-if="isLoading">
          <tr>
            <td colspan="10" class="py-10 text-center">
              <svg
                class="animate-spin h-8 w-8 text-blue-600 mx-auto"
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
              >
                <circle
                  class="opacity-25"
                  cx="12"
                  cy="12"
                  r="10"
                  stroke="currentColor"
                  stroke-width="4"
                ></circle>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8H4z"></path>
              </svg>
              <div class="mt-2 text-gray-500">กำลังโหลดข้อมูล...</div>
            </td>
          </tr>
        </tbody>

        <!-- web -->
        <tbody v-if="!isLoading" class="hidden lg:table-row-group">
          <tr
            v-for="(item, index) in tableData"
            :key="index"
            class="hover:bg-indigo-50 cursor-pointer transition duration-150"
          >
            <td class="px-5 py-3">{{ item.customer_no }}</td>
            <td class="px-5 py-3">{{ item.nickname }}</td>
            <!-- <td class="px-5 py-3">{{  formatContactNickname(item) }}</td> -->
            <td class="px-5 py-3">{{ item.sale_no }}</td>
            <td class="px-5 py-3 text-gray-400 italic">–</td>
            <td class="px-5 py-3 text-center">
              <button
                @click="rowClick(item, index)"
                class="text-indigo-600 hover:underline font-medium"
              >
                เลือก
              </button>
            </td>
          </tr>
          <tr v-if="!tableData.length" class="hidden lg:table-row">
            <td colspan="5" class="text-center text-gray-400 py-6 italic">ไม่พบข้อมูล</td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- 🔢 Pagination ,:pageSize.sync="pageSize" , @change="onPageSizeChange" -->
    <!-- <ConfigProvider :globalConfig="localeConfig">
      <div class="overflow-auto">
        <pagination
          v-model="pageCurrent"
          v-model:pageSize="pageSize"
          :total="total"
          :pageSizeOptions="[5,10,15]"
          show-page-size
          :prev-button-props="{ content: '⏪' }"
          :next-button-props="{ content: '⏩' }"
          @change="handlePaginationChange"
          class="mt-4"
        />
      </div>
    </ConfigProvider> ,,,,,-->
   <ConfigProvider :globalConfig="localeConfig">
  <div class="w-full overflow-x-auto mt-4">
    <div class="inline-block min-w-full">
      <pagination
        v-model="pageCurrent"
        v-model:pageSize="pageSize"
        :total="total"
        :pageSizeOptions="[5,10,15]"
        show-page-size
        :prev-button-props="{ content: '⏪' }"
        :next-button-props="{ content: '⏩' }"
        :show-less-items="false"
        :show-quick-jumper="true"
        @change="handlePaginationChange"
        class="pagination-responsive inline-flex items-center gap-1 whitespace-nowrap"
      />
    </div>
  </div>
</ConfigProvider>
    <!-- <ConfigProvider :globalConfig="localeConfig">
        <div class="w-full overflow-x-auto flex justify-center mt-4">
          <pagination
            v-model="pageCurrent"
            v-model:pageSize="pageSize"
            :total="total"
            :pageSizeOptions="[5,10,15]"
            show-page-size
            :prev-button-props="{ content: '⏪' }"
            :next-button-props="{ content: '⏩' }"
            :show-less-items="false"
            :show-quick-jumper="true"
            @change="handlePaginationChange"
            class="pagination-responsive flex flex-wrap justify-center items-center gap-1"
          />
        </div>
      </ConfigProvider> -->

  </div>
</template>

<!-- <div class="text-sm text-gray-500 mt-2">
    * สามารถ ค้นหาได้ เบอร์มือถือ, ชื่อร้านค้า, รหัสร้านค้า
</div> -->
<script>
//  import '@/shopro/store/modules/shopro.js';

import axios from "axios";
import { ref } from "vue";
import { useRouter } from "vue-router";
// import { Pagination } from 'tdesign-vue-next';
import { Pagination, ConfigProvider } from "tdesign-vue-next";
import enConfig from "tdesign-vue-next/es/locale/en_US";
import { eventBus } from "@/utils/eventBus";
import Swal from 'sweetalert2';
// import { logActivity } from '@/services/activityLogger.js'

const BASE_URL = import.meta.env.VITE_API_URL;
console.log("Show BASE_URL: ", BASE_URL);

// eslint-disable-next-line no-unused-vars
const error = ref("");
// let timer = null;
// let arr = [];

// const account = localStorage.getItem('account')
// const password = localStorage.getItem('password')
// console.log("Log Value: ", account);
// console.log("Log Value: ", password);

// eslint-disable-next-line no-unused-vars
const router = useRouter();
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
      account: localStorage.getItem("account") || "",
      password: localStorage.getItem("password") || "",
      dropdownOpenIndex: null,
      searchText: [],
      selectedSale: [],
      selectedSales: [],
      saleList: ["Uppercase", "Lowercase", "Camel Case", "Kebab Case"], // << แทนด้วยข้อมูลจาก API ได้
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
      filteredData: [], // ข้อมูลหลังกรอง
      searchVal: "",
      tableData: [],
      // 每页数据量
      defaultPageSize: 15, // << เพิ่มไว้เก็บค่า default
      pageSize: 15,
      pageNext: 15,
      // 当前页
      pageCurrent: 1,
      limit: 5, // หรือจำนวนที่คุณต้องการแสดงปุ่ม page
      disabled: false,
      // 数据总量
      total: 0,
      loading: false,
      keyword: "",
      keyword_sale_no: "",
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
    },
  },

  async mounted() {
    // await logActivity('user ได้เข้าหน้า CustomerView', 'CustomerView.vue');
    window.addEventListener("wheel", () => {}, { passive: true });
  },
  created() {
    // this.accountLoginSubmit();
    // this.searchSaleId();
    // accountLoginSubmit();
    const account = localStorage.getItem("account");
    const password = localStorage.getItem("password");

    if (account && password) {
      this.accountLoginSubmit();
    } else {
      console.warn("⛔ ไม่พบ account/password ใน localStorage");
      this.isLoading = false;
    }
  },
  // watch() {

  //     this.accountLoginSubmit();

  // },
  watch: {
    keyword() {
      // newVal
      this.accountLoginSubmit();
    },
  },

  onShow() {},
  onLoad() {},
  //   computed: {

  //    ...mapGetters(["userInfo","initShop", "homeTemplate", "hasTemplate", "isLogin",'cartList', 'checkCart']),

  //   },

  methods: {

     handleRowClick(item, index) {
    // ตรวจสอบว่าขนาดจอเล็กกว่า lg (960px)
        if (window.innerWidth < 960) {
          this.rowClick(item, index);
        }
        // ถ้า >= lg จะไม่ทำอะไร กดได้แค่ปุ่ม "เลือก"
      },


    // formatContactNickname(item) {
    //   if (!item?.contact) return item?.nickname || '';
    //   if (!item?.nickname) return item?.contact || '';

    //   // แปลงเป็น lower case เพื่อตรวจซ้ำแบบไม่สนตัวพิมพ์เล็ก/ใหญ่
    //   const contactLower = item.contact.toLowerCase();
    //   const nicknameLower = item.nickname.toLowerCase();

    //   // ถ้า nickname มีคำเดียวกับ contact → แสดง nickname อย่างเดียว
    //   if (nicknameLower.includes(contactLower)) {
    //     return item.nickname;
    //   }

    //   // ถ้าไม่ซ้ำ → เอามาบวกกัน
    //   return `${item.contact} ${item.nickname}`;
    // },

    toggleDropdown(index) {
      if (this.dropdownOpenIndex === index) {
        this.dropdownOpenIndex = null;
      } else {
        this.dropdownOpenIndex = index;
      }

      if (!this.searchText[index]) {
        // this.$set(this.searchText, index, '');
        this.searchText[index] = "";
      }
    },
    filteredSales(index) {
      const text = this.searchText[index] || "";
      return this.saleList.filter((sale) => sale.toLowerCase().includes(text.toLowerCase()));
    },
    selectSale(index, sale) {
      // this.$set(this.selectedSale, index, sale);
      // this.searchText[index] = '';
      this.selectedSale[index] = sale;
      this.dropdownOpenIndex = null;
    },

    // onPageSizeChange(newSize) {
    //   this.pageSize = newSize.pageSize;
    //   this.pageCurrent = newSize.current; // รีเซ็ตกลับหน้าที่ 1
    //   console.log("start newSize: ", newSize);
    //   this.accountLoginSubmit();
    // },

    handlePaginationChange(info) {
      // กันไม่ให้ pageSize กลายเป็น object
      if (typeof info === 'object') {
        if (info.pageSize && typeof info.pageSize === 'number') {
          this.pageSize = info.pageSize;
        }
        if (info.current && typeof info.current === 'number') {
          this.pageCurrent = info.current;
        }
      } else {
        // fallback กันไว้
        this.pageSize = Number(info) || this.defaultPageSize;
      }

      // โหลดข้อมูลใหม่
      if (this.keyword_sale_no.trim() !== "") {
        this.searchSaleId(this.pageCurrent, this.pageSize);
      } else {
        this.accountLoginSubmit(this.pageCurrent, this.pageSize);
      }
    },


      onPageSizeChange(newSize) {
        // เวลาเปลี่ยน pageSize ให้ update ค่า default ด้วย
        this.defaultPageSize = newSize;
        this.pageSize = newSize;
        this.pageCurrent = 1;
        console.log("Pagination changed:", this.pageCurrent, this.pageSize);
        // this.accountLoginSubmit();
        if (this.keyword_sale_no.trim() !== "") {
          this.searchSaleId(this.pageCurrent, this.pageSize);
        } else {
          this.accountLoginSubmit(this.pageCurrent, this.pageSize);
        }

      },

    // onPageSizeChange(paginationInfo) {
    //   // paginationInfo = { current: <เลขหน้า>, pageSize: <จำนวนแถว> }
    //   this.pageCurrent = paginationInfo.current;
    //   this.pageSize = paginationInfo.pageSize;

    //   console.log("Pagination changed:", this.pageCurrent, this.pageSize);

    //   if (this.keyword_sale_no.trim() !== "") {
    //     this.searchSaleId(this.pageCurrent, this.pageSize);
    //   } else {
    //     this.accountLoginSubmit(this.pageCurrent, this.pageSize);
    //   }
    // },

    // พอได้
    // onPageSizeChange(newSize) {
    //   this.pageSize = newSize.pageSize;
    //   this.pageCurrent = newSize.current;
    //   console.log("start newSize: ", newSize);

    //   if (this.keyword_sale_no.trim() !== "") {
    //     // กรณีค้นหา sale_no ให้ใช้ searchSaleId พร้อมส่ง pageCurrent ใหม่
    //     this.searchSaleId(this.pageCurrent, this.pageSize);
    //   } else {
    //     // กรณีค้นหาธรรมดา
    //     this.accountLoginSubmit(this.pageCurrent, this.pageSize);
    //   }
    // },

    rowClick(row, index) {
      // idx
      console.log(row.mobile);

      console.log("เลือก:", row, index);

      this.accountLoginCustomerSubmit(row);
      //uni.showToast({ title: `คุณคลิกที่แถวที่ ${idx + 1}: ${row.mobile}`, icon: 'none' });
      // หรือจะ navigate ไปหน้าอื่น เช่น:
      // uni.navigateTo({ url: /pages/detail/detail?id=${row.id} });
    },

    onSaleSelected() {
      // index
      // กรอง dataselect ให้เหลือเฉพาะ Sale ที่ถูกเลือกไว้ใน selectedSales
      this.tableData = this.dataselect.filter((item) => this.selectedSales.includes(item.sale_no));
    },

    onInput() {
      // ยกเลิก timeout เก่าถ้ามี
      clearTimeout(this.searchTimer);
      // ตั้ง timeout ใหม่ รอ 500ms ถ้าไม่มีการพิมพ์เพิ่มถึงค่อยเรียก
      this.pageCurrent = 1; // Reset = 1 สำคัญมาก
      this.accountLoginSubmit();
      // this.searchSaleId()
      // this.searchTimer = setTimeout(() => {
      //     this.accountLoginSubmit()
      // }, 1000)
    },
   async accountLoginSubmit() {
    // page = 1, size = 15
    this.isLoading = true;

    try {
      const response = await axios.post(
        `${BASE_URL}/user/accountLogin4V2`,
        // `${BASE_URL}/user/accountLogin4`,
        {
          account: this.account,
          password: this.password,
          customer: "",
          version: "2.0.2",
          pageCurrent: this.pageCurrent,
          // pageCurrent: page,
          keyword: this.keyword,
          // pageSize: size,
          pageSize: this.pageSize,
        },
        {
          headers: {
            "Content-Type": "application/json",
          },
        }
      );

      if (response.data.code == 1) {
        this.total = response.data.data.data.customer_count;
        this.tableData = response.data.data.data.data2;
        // ✅ อย่าใช้ this.total หรือ 0 มา overwrite pageSize

        if (this.total === 0) {
          // ✅ Reset pageSize ถ้าไม่เจอข้อมูล
            this.pageSize = this.defaultPageSize; // reset กลับ default
          // this.pageSize = this.defaultPageSize;
        }

        console.log('this.pageSize: ',this.pageSize);

        // if (this.total < this.pageSize) {
        //   this.pageSize = this.total; // กรณีรายการน้อยกว่าที่เลือกต่อหน้า
        // }

        // this.pageSize = this.total < this.pageSize ? this.total : this.pageSize;
        // this.pageSize = this.total;
        // this.pageSize = this.total < size ? this.total : size;

        console.log("this.total",this.total)
        console.log("this.tableData",this.tableData)
        console.log("this.pageSize",this.pageSize)

      } else {
          console.warn("❌ ไม่สามารถโหลดข้อมูลได้", response.data.message);
          this.total = 0;
          this.tableData = [];
          this.pageSize = this.defaultPageSize; // ✅ Reset กลับ
      }
    } catch (error) {
      console.error("❌ accountLoginSubmit error:", error);
    } finally {
      this.isLoading = false;
    }
  },

async searchSaleId() {
  // page = 1, size = 15
  this.isLoading = true;

  try {
    const keywordSale = this.keyword_sale_no.trim();



    let postData = {
      account: this.account,
      password: this.password,
      customer: "",
      version: "2.0.2",
      // pageCurrent: page,
      // pageSize: size,
      pageCurrent: this.pageCurrent,
      pageSize: this.pageSize,
      keyword: this.keyword,
    };

    if (keywordSale !== "") {
      postData.keyword =  keywordSale ;
      // postData.keyword = this.keyword + "$_" + keywordSale + "_$";
    }

    const response = await axios.post(`${BASE_URL}/user/accountLogin4V2`, postData, {
    // const response = await axios.post(`${BASE_URL}/user/accountLogin4`, postData, {
      headers: {
        "Content-Type": "application/json",
      },
    });

    if (response.data.code === 1) {
      // this.pageCurrent = 1; // Reset กลับหน้า 1
      this.total = response.data.data.data.customer_count;
      this.dataselectSale_no = response.data.data.data.data2 ; // ตรวจสอบ path ให้ถูกต้อง || response.data.data.data2
      this.tableData = [...this.dataselectSale_no];

      if (this.total === 0) {
          this.pageSize = this.defaultPageSize; // reset กลับ default
          // this.pageSize = this.defaultPageSize; // ✅ Reset ถ้าไม่เจอ
      }

      console.log('this.pageSize: ',this.pageSize);

      // if (this.total < this.pageSize) {
      //   this.pageSize = this.total;
      // }

      // this.pageSize = this.total < this.pageSize ? this.total : this.pageSize;
      // this.pageSize = this.total;
      // this.pageSize = this.total < size ? this.total : size;
    } else {
      console.warn("ไม่พบข้อมูล", response.data.message);
      // this.dataselectSale_no = [];
      // this.tableData = [];
      // this.total = 0;
      this.tableData = [];
      this.total = 0;
      this.pageSize = this.defaultPageSize; // ✅ Reset กลับ
    }
  } catch (err) {
    console.error("searchSaleId Error:", err);
  } finally {
    this.isLoading = false;
  }
},

    async accountLoginCustomerSubmit(row) {
      const response = await axios.post(
        `${BASE_URL}/user/accountLogin4V2`,
        // `${BASE_URL}/user/accountLogin4`,
        {
          account: row.mobile,
          password: row.mobile,
          customer: row.customer_no || "",
          version: "2.0.2",
          pageCurrent: this.pageCurrent,
          keyword: this.keyword,
          // mobile: mobile.value,
          // password: password.value
        },
        {
          // withCredentials: true,
          headers: {
            "Content-Type": "application/json",
          },
        }
      );

      console.log("log response 458: ", response);
      console.log("log row: ", row);
      console.log("response.data: ", response.data);

      if (response.data.code === 1) {
        // console.log('log :',response.data.data.token);

        localStorage.setItem("token", response.data.data.token);

        const gettoken = localStorage.getItem("token");

        // เก็บข้อมูลลง localStorage แบบ string
        localStorage.setItem("selectDataCustomer", JSON.stringify(response.data.data));
        localStorage.setItem("selectDataCustomerRow", JSON.stringify(row));

        const selectDataCustomer = JSON.parse(localStorage.getItem("selectDataCustomer"));
        const selectDataCustomerRow = JSON.parse(localStorage.getItem("selectDataCustomerRow"));

        console.log("log selectDataCustomer: ", selectDataCustomer);
        console.log("log selectDataCustomerRow: ", selectDataCustomerRow);
        console.log("log gettoken: ", gettoken);

        // แจ้งให้ Navbar โหลดใหม่
        eventBus.emit("customerChanged");

        this.$router.push("/createsalelist");
        // this.$router.push("/dashboard");
      } else {
         // Login ไม่สำเร็จ → แจ้งเตือนเฉพาะ
      const customerNo = row.customer_no || "-L"; // ถ้าไม่มี customer_no ใช้ -L
      const message = `รายการที่เลือกนั้น ไม่ได้ใช้งาน โดย รหัส ${customerNo}`;

      // ถ้าใช้ SweetAlert2
      Swal.fire({
        title: "ไม่สามารถใช้งานได้",
        text: message,
        icon: "error",
      });

      // หรือถ้าไม่ใช้ Swal → ใช้ alert
      // alert(message);
        // error.value = response.data.message || "failed";
        // Swal.fire({
        //     title: 'ล็อกอินไม่สำเร็จ',
        //     text: error.value || 'โปรดลองใหม่ภายหลัง',
        //     icon: 'error',
        // });
      }

    },
  },
};

</script>
<style scoped>

.pagination-responsive {
  font-size: 14px; /* desktop */
}

.pagination-responsive >>> .rc-pagination-item,
.pagination-responsive >>> .rc-pagination-prev,
.pagination-responsive >>> .rc-pagination-next {
  min-width: 36px;
  height: 36px;
  line-height: 36px;
  padding: 0 8px;
  border-radius: 8px;
  border: 1px solid #e5e7eb;
  text-align: center;
  transition: all 0.2s;
}

.pagination-responsive >>> .rc-pagination-item-active {
  background-color: #6366f1;
  color: white;
  border-color: #6366f1;
}

.pagination-responsive >>> .rc-pagination-item:hover,
.pagination-responsive >>> .rc-pagination-prev:hover,
.pagination-responsive >>> .rc-pagination-next:hover {
  background-color: #eef2ff;
  border-color: #c7d2fe;
}

/* Responsive mobile */
@media (max-width: 500px) {
  .pagination-responsive {
    font-size: 12px;
  }

  .pagination-responsive >>> .rc-pagination-item,
  .pagination-responsive >>> .rc-pagination-prev,
  .pagination-responsive >>> .rc-pagination-next {
    min-width: 28px;
    height: 28px;
    line-height: 28px;
    padding: 0 4px;
  }

    table {
    font-size: 12px;
    /* ลดขนาดตัวอักษร */
  }

  /* input[type="text"] {
        width: 100% !important;
    } */

  thead .flex-col {
    flex-direction: column;
  }

  button {
    width: 100%;
    justify-content: center;
  }

  table input,
  table button {
    font-size: 12px;
    padding: 4px 6px;
    /* ลด padding */
  }

  table th,
  table td {
    padding: 6px !important;
    /* ลด padding ใน cell */
  }

  .w-36 {
    width: 100% !important;
    /* ให้ input search ขยายเต็มความกว้าง */
  }

  .text-sm {
    font-size: 12px !important;
  }

  .text-base {
    font-size: 14px !important;
  }

  .material-icons {
    font-size: 16px !important;
  }

  th,
  td {
    text-align: center;
  }

  .material-icons {
    font-size: 16px !important;
  }

}
</style>

<<<<<<< Updated upstream


=======
>>>>>>> Stashed changes
<!--
@media (max-width: 500px) {
    table {
      font-size: 12px; /* ลดขนาดตัวอักษร */
    }

    table input,
    table button {
      font-size: 12px;
      padding: 4px 6px; /* ลด padding */
    }

    table th,
    table td {
      padding: 6px !important; /* ลด padding ใน cell */
    }

    .overflow-x-auto {
      font-size: 12px;
      overflow-x: auto; /* อนุญาตให้เลื่อนในแนวนอน */
    }

    .w-36 {
      width: 100% !important; /* ให้ input search ขยายเต็มความกว้าง */
    }

    .text-sm {
      font-size: 12px !important;
    }

    .text-base {
      font-size: 14px !important;
    }

    .material-icons {
      font-size: 16px !important;
    }

    /* บังคับตารางให้ไม่เกินกล่อง */
    table {
      width: 100%;
      table-layout: fixed;
      word-break: break-word;
    } -->
<!--

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
} -->
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
