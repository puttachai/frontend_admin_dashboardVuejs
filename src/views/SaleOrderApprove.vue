<template>
  <div class="p-4 relative">
    <h1 class="text-2xl font-bold mb-4">อนุมัติรายการคำสั่งซื้อ</h1>

    <!-- ด้านบนของตาราง -->
    <div class="mb-4">
      <input v-model="searchQuery" type="text" placeholder="🔍 ค้นหา หมายเลขสั่งซื้อ / รหัสลูกค้า / ชื่อร้าน"
        class="w-full border border-gray-300 rounded-md px-4 py-2 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-500" />
    </div>
    <!-- if (filterStatus.value === "approved") {
    orders = orders.filter(o => normalizeStatus(o.status) === "ตรวจสอบเรียบร้อย".toLowerCase())
  } else if (filterStatus.value === "pending") {
    orders = orders.filter(o => normalizeStatus(o.status) !== "ตรวจสอบเรียบร้อย".toLowerCase())
  } -->
    <div class="flex flex-col sm:flex-row sm:justify-between sm:items-center mb-4 gap-2">
      <div class="mb-4 flex gap-2">
        <select v-model="filterStatus" @change="handleFilterChange" class="border rounded-md px-2 py-1">
          <option value="">-- แสดงทั้งหมด --</option>
          <option value="approved">อนุมัติแล้ว</option>
          <option value="pending">ยังไม่อนุมัติ</option>
        </select>
      </div>
      <div>
        <button @click="approveSelected" :disabled="selectedOrders.length === 0 || isApproving"
          class="px-4 py-2 bg-green-500 text-white rounded hover:bg-green-600 disabled:opacity-50 disabled:cursor-not-allowed">
          อนุมัติเอกสารที่เลือก ({{ selectedOrders.length }})
        </button>
      </div>
    </div>

    <transition name="slide-button">
      <button v-if="showAnimatedButton" @click="scrollToRight"
        class="fixed top-20 right-4 z-50 flex items-center gap-2 px-5 py-3 bg-yellow-400 text-white rounded-lg shadow-lg hover:bg-yellow-700 transition duration-300 ease-in-out max-[480px]:px-1 max-[480px]:py-2 max-[480px]:text-sm max-[480px]:gap-1"
        title="คลิกเพื่อเลื่อนดูข้อมูลเพิ่มเติม">
        <!-- ไอคอนแจ้งเตือน -->
        <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"
          xmlns="http://www.w3.org/2000/svg">
          <path stroke-linecap="round" stroke-linejoin="round"
            d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9" />
        </svg>

        <!-- ข้อความ -->
        <span class="font-medium"> แสดงข้อมูลเพิ่มเติม {{ isScrolledRight ? "◀" : "▶" }} </span>
      </button>
    </transition>

    <div ref="tableWrapper" style="max-width: 100%" class="overflow-auto rounded-lg shadow-md" @scroll="onScroll">
      <table
        class="min-w-[1500px] table-fixed text-sm text-left text-gray-700 divide-x divide-gray-200 border border-gray-300">
        <thead class="bg-gray-100 text-xs uppercase border">
          <tr class="border-r border-gray-300">
            <th class="p-3 border text-center">
              <input type="checkbox" v-model="selectAllApproved" @change="toggleSelectAllApproved" />
            </th>
            <th class="p-3 border">Id</th>
            <th class="p-3 border">หมายเลขสั่งซื้อ</th>
            <th class="p-3 border">รหัสลูกค้า</th>
            <th class="p-3 border">ชื่อร้าน</th>
            <th class="p-3 border">พนง.เร่งรัด</th>
            <th class="p-3 border">เบอร์โทรศัพท์</th>
            <th class="p-3 border">เบอร์โทรศัพท์ พนง.เร่งรัด</th>
            <th class="p-3 border text-right">ยอดคำสั่งซื้อล่าสุด</th>
            <th class="p-3 border text-right">ยอดหนี้คงค้าง</th>
            <th class="p-3 border">เวลาสร้าง</th>
            <th class="p-3 border">ระยะเครดิต (days)</th>
            <th class="p-3 border">วงเงิน (limit)</th>
            <th class="p-3 border">พนักงานขาย (Sales)</th>
            <th class="p-3 border">สถานะประเภทหนี้</th>
            <th class="p-3 border">สถานะตรวจสอบ</th>
            <th class="p-3 border">การทำงาน</th>
            <!-- ถ้าเป็น crm ให้ซ่อนคอลัมน์นี้ -->
            <th v-if="!isCrm" class="p-3 border">ยกเลิกการคำสั่งซื้อ</th>
          </tr>
        </thead>

        <tbody v-if="isLoading">
          <tr>

            <td :colspan="isCrm ? 15 : 16" class="py-10 text-center">
              <!-- <td colspan="11" class="py-10 text-center"> -->
              <svg class="animate-spin h-8 w-8 text-blue-600 mx-auto" xmlns="http://www.w3.org/2000/svg" fill="none"
                viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8H4z"></path>
              </svg>
              <div class="mt-2 text-gray-500">กำลังโหลดข้อมูล...</div>
            </td>
          </tr>
        </tbody>

        <tbody v-if="!isLoading" class="text-xs">
          <template v-for="order in filteredOrders" :key="order.id">
            <!-- divide-x divide-gray-200 -->
            <tr class="border-b hover:bg-gray-50">
              <!-- <tr v-for="order in filteredOrders" :key="order.id" class="border-b hover:bg-gray-50"> -->
              <!-- <tr v-for="order in saleOrders" :key="order.id" class="border-b hover:bg-gray-50"> -->
              <td class="p-3 text-center">
                <input type="checkbox" :value="order.id" v-model="selectedOrders"
                  :disabled="order.status !== 'ยังไม่ได้ตรวจสอบ'" />
              </td>
              <td class="p-3">{{ order.id }}</td>
              <td class="p-3">{{ order.sale_no }}</td>
              <td class="p-3">{{ order.customer_code }}</td>
              <td class="p-3 min-w-[100px]">{{ order.shop_name }}</td>
              <!-- <td class="p-3">{{ order.shop_name }}</td> -->
              <!-- <td class="p-3">{{ order.employee_name ? order.employee_name : "ไม่มีข้อมูล" }}</td> -->

              <td class="px-2 py-1 border whitespace-nowrap relative">
                <div v-if="order.collector_list && order.collector_list.length" class="flex flex-col space-y-1">
                  <div
                    v-for="(c, idx) in order.collector_list.slice(0,2)"
                    :key="idx"
                    class="relative group cursor-pointer"
                  >
                    <span class="hover:text-purple-600">
                      {{ c.full_name && c.full_name.length > 20
                          ? c.full_name.substring(0, 20) + '...'
                          : (c.full_name || 'ไม่มีข้อมูล') }}
                    </span>

                    <!-- tooltip -->
                    <div
                      v-if="c.full_name"
                      class="absolute z-10 hidden group-hover:block bg-gray-800 text-white text-xs rounded px-2 py-1 -top-8 left-0 max-w-xs whitespace-normal"
                    >
                      {{ c.full_name }}
                    </div>
                  </div>
                </div>

                <div v-else>ไม่มีข้อมูล</div>

                <!-- ปุ่มดูทั้งหมด -->
                <button
                  v-if="order.collector_list && order.collector_list.length > 2"
                  @click="openCollectorsModal(order.collector_list)"
                  class="absolute right-1 bottom-1 text-[9px] text-gray-500 hover:text-gray-400 px-1 py-0.5 rounded bg-white shadow-sm"
                >
                  ดูทั้งหมด
                </button>

                <!-- Modal แสดงข้อมูลเต็ม -->
                <div v-if="showCollectorsModal" class="fixed inset-0 bg-opacity-50 flex items-center justify-center z-50">
                  <div class="bg-white rounded-lg shadow-lg w-96 p-4 relative">
                    <h2 class="text-lg font-bold mb-2 ">พนักงานเร่งรัดที่ดูแล</h2>
                    <textarea
                      readonly
                      class="w-full h-40 border rounded p-2 text-sm"
                      :value="modalCollectors.map(c => `📍 ${c.full_name}`).join('\n')"
                    ></textarea>
                    <button
                      @click="showCollectorsModal = false"
                      class="absolute top-2 right-2 text-gray-500 hover:text-black"
                    >
                      ✕
                    </button>
                  </div>
                </div>
              </td>

              <td class="p-3">{{ order.mobile }}</td>
              <!-- <td class="p-3">{{ order.employee_mobile ? order.employee_mobile : "ไม่มีข้อมูล"}}</td> -->
              <!-- <td class="p-3">{{ order.employee_phone ? order.employee_phone : "ไม่มีข้อมูล" }}</td> -->

              <!-- เบอร์โทรศัพท์พนักงานเร่งรัด -->
              <td class="px-2 py-1 border whitespace-nowrap min-w-[120px]">
                <select class="border border-gray-300 rounded px-2 py-1 w-full">
                  <option
                    v-for="(c, idx) in order.collector_list"
                    :key="`tel-${idx}`"
                    :value="c.telephone"
                  >
                    {{ c.telephone || 'ไม่มีข้อมูล' }}
                  </option>
                </select>
              </td>


              <td class="p-3 text-right">{{ formatCurrency(order.total_amount) }}</td>
              <td class="p-3 text-right">{{ formatCurrency(order.total_paid) }}</td>
              <td class="p-3">{{ order.created_at }}</td>

              <td class="p-3">
                {{ order.deBcreditTerm ? order.deBcreditTerm : "ไม่มีข้อมูลกำหนด" }}
              </td>
              <td class="p-3">
                {{
                  !order.deBlimit || isNaN(order.deBlimit)
                    ? "ไม่มีวงเงิน"
                    : formatCurrency(order.deBlimit)
                }}
              </td>
              <td class="p-3">{{ order.deBsalesP ? order.deBsalesP : "ไม่มีข้อมูล" }}</td>
              <!-- <td class="p-3">{{ order.status2 ? order.status2: 'ไม่มีสถานะ' }}</td> -->
              <td :class="[
                'p-3',
                getStatusColor(getHighestStatus(filteredExtraDetails(order))),
                'w-[9rem]', // กำหนดความกว้างเป็น 12rem (48 * 0.25rem)
                'max-w-xs', // กำหนด max-width ถ้าต้องการจำกัด
                'break-words', // ถ้าข้อความยาวให้ตัดขึ้นบรรทัดใหม่
                'border-t-2 border-b-2 border-gray-300', // ใช้เฉพาะขอบบนและขอบล่าง
              ]">
                {{ getDisplayStatus(getHighestStatus(filteredExtraDetails(order))) }}
              </td>

              <td class="p-3">
                <!-- :class="order.status === 'ยังไม่ได้ตรวจสอบ' ? 'bg-gray-500' : 'bg-green-500'" -->
                <span class="flex items-center space-x-1">
                  <span class="w-2 h-2 rounded-full" :class="{
                    'bg-gray-500': order.status === 'ยังไม่ได้ตรวจสอบ',
                    'bg-green-500': order.status === 'ตรวจสอบเรียบร้อย',
                    'bg-red-500': order.status === 'การตรวจสอบล้มเหลว',
                  }"></span>
                  <span class="w-[90px]">{{ order.status }}</span>
                </span>
              </td>

              <!-- ปุ่ม ตรวจสอบ -->
              <td class="p-3">
                <router-link :to="{ name: 'saleorderdetail', params: { id: order.sale_no } }">
                  <button class="w-24 px-4 py-1 bg-blue-500 text-white rounded hover:bg-blue-600 text-sm">
                    ตรวจสอบ
                  </button>
                </router-link>
              </td>

              <!-- ปุ่ม ลบ (แสดงเฉพาะผู้ที่ canApprove เท่านั้น) -->
              <td class="p-3" v-if="canApprove">
                <button @click="confirmDelete(order.id)"
                  class="w-24 px-4 py-1 bg-red-500 text-white rounded hover:bg-red-600 text-sm">
                  ลบ
                </button>
              </td>

            </tr>


            <tr v-if="filteredExtraDetails(order).length > 0"
              class="bg-blue-50 hover:bg-blue-100 transition-colors duration-300">
              <td colspan="18" class="px-6 py-4 border rounded-md">
                <div class="flex items-center space-x-2 text-blue-800 font-medium mb-3">
                  <svg class="w-5 h-5 text-blue-600" fill="none" stroke="currentColor" stroke-width="2"
                    viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round"
                      d="M13 16h-1v-4h-1m2-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                  </svg>
                  <span>ข้อมูลใบแจ้งหนี้ที่เกี่ยวข้อง</span>
                </div>

                <!-- Cards style -->
                <div class="grid grid-cols-2 sm:grid-cols-4 md:grid-cols-5 gap-3 mt-3">
                  <div v-for="(d, i) in filteredExtraDetails(order).slice(0, getVisibleCount(order))" :key="i"
                    class="flex justify-between items-center bg-white shadow-sm rounded-lg p-2 border border-gray-200 transition-transform transform hover:scale-[1.01] hover:shadow-md duration-200 max-w-[280px]">
                    <!-- ข้อมูลฝั่งซ้าย -->
                    <div class="text-xs text-gray-800 space-y-0.5">
                      <div class="text-[11px]">
                        <strong class="text-[11px]">Invoice No.:</strong> {{ d.miHvnos }}
                      </div>
                      <div class="text-[11px]">
                        <strong class="text-[11px]">Due Date:</strong> {{ d.dueDate }}
                      </div>
                      <div class="text-[11px]">
                        <strong class="text-[11px]">Overdue Days:</strong> {{ d.overdueDays }}
                      </div>
                      <div class="text-[11px]">
                        <strong class="text-[11px]">Status:</strong> {{ getDisplayStatus(d.status2) }}
                      </div>
                      <div class="text-[11px]">
                        <strong class="text-[11px]">Status:</strong> {{ d.status2 }}
                      </div>
                      <div class="text-[11px]">
                        <strong class="text-[11px]">Amount Due:</strong> {{ formatCurrency(d.inInvAmount) }}
                      </div>
                    </div>

                    <!-- ไอคอนฝั่งขวา -->
                    <div class="relative group z-50">
                      <div
                        class="w-10 h-10 flex cursor-pointer items-center justify-center rounded-full shadow-inner transition-transform transform group-hover:scale-105"
                        :class="getStatusColor(d.status2)">
                        <component :is="getStatusIcon(d.status2)" class="w-5 h-5" />
                      </div>
                      <div
                        class="absolute -top-2 left-1/2 -translate-x-1/2 -translate-y-full bg-black text-white text-[10px] px-2 py-0.5 rounded-md opacity-0 group-hover:opacity-100 group-hover:-translate-y-[130%] transition-all duration-300 whitespace-nowrap z-60">
                        สถานะ: {{ d.status2 }}
                      </div>
                    </div>
                  </div>
                </div>


                <!-- ปุ่ม Show more / Show less / Show All -->
                <div v-if="filteredExtraDetails(order).length > 3" class="mt-2 flex gap-2">
                  <button v-if="getVisibleCount(order) < filteredExtraDetails(order).length" @click="showMore(order)"
                    class="px-3 py-1 bg-blue-500 text-white rounded hover:bg-blue-600 text-xs">
                    Show more
                  </button>
                  <button v-if="getVisibleCount(order) > 3" @click="showLess(order)"
                    class="px-3 py-1 bg-gray-500 text-white rounded hover:bg-gray-600 text-xs">
                    Show less
                  </button>
                  <button v-if="getVisibleCount(order) < filteredExtraDetails(order).length" @click="showAll(order)"
                    class="px-3 py-1 bg-green-500 text-white rounded hover:bg-green-600 text-xs">
                    Show All
                  </button>
                </div>
              </td>
            </tr>
          </template>

          <!-- ถ้าไม่มีข้อมูล -->
          <tr v-if="!isLoading && filteredOrders.length === 0">
            <td :colspan="isCrm ? 15 : 16" class="text-center py-10 text-gray-500 font-medium">
              ไม่มีข้อมูล
            </td>
          </tr>

        </tbody>
      </table>
    </div>

    <!-- pagination -->
    <!-- pagination -->
    <div class="flex flex-col sm:flex-row sm:justify-between sm:items-center mt-4 gap-2 sm:gap-0 text-sm sm:text-base">
      <!-- จำนวนรายการ -->
      <span class="text-center sm:text-left text-xs">
        Showing {{ filteredOrders.length }} of {{ totalRows }} rows
      </span>

      <!-- ปุ่ม pagination -->
      <div class="flex justify-center sm:justify-end items-center space-x-2">
        <button :disabled="currentPage === 1" @click="goToPage(currentPage - 1)"
          class="px-3 py-1 bg-gray-200 text-ms rounded disabled:opacity-50">
          Prev
        </button>

        <span class="mx-1">หน้า </span>
        <span class="mx-1"> {{ currentPage }} / {{ totalPages }}</span>

        <button :disabled="currentPage === totalPages" @click="goToPage(currentPage + 1)"
          class="px-3 py-1 bg-gray-200 text-ms rounded disabled:opacity-50">
          Next
        </button>
      </div>
    </div>

  </div>

  <div>
        <!-- Loading Overlay -->
        <div v-if="isLoading" class="fixed inset-0 bg-black bg-opacity-40 flex items-center justify-center z-50">
            <div class="text-center">
                <svg class="animate-spin h-10 w-10 text-blue-600 mx-auto" xmlns="http://www.w3.org/2000/svg" fill="none"
                    viewBox="0 0 24 24">
                    <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                    <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8H4z"></path>
                </svg>
                <div class="mt-2 text-white text-lg">กำลังโหลดข้อมูลเพื่ออนุมัติรายการ...</div>
            </div>
        </div>
        <!--  END Loading Overlay -->
    </div>

</template>

<script setup>
import { ref, onMounted, computed, watch, reactive } from "vue";
// , reactive
import axios from "axios";
// import { logActivity } from '@/services/activityLogger.js'
import { sendToMacfive } from "@/services/orderMacficeServiceAll.js";
import Swal from "sweetalert2";
import { toRaw } from 'vue';
import {
  CheckCircleIcon,
  AlertTriangleIcon,
  AlertOctagonIcon,
  XOctagonIcon,
  BanIcon,
  HelpCircleIcon,
} from "lucide-vue-next";

const VITE_API_URL_C_SHARP = import.meta.env.VITE_API_URL_C_SHARP;
const BASE_URL_LOCAL = import.meta.env.VITE_API_URL_LOCAL;

// const BASE_URL = import.meta.env.VITE_API_URL;

const selectedOrders = ref([])   // เก็บ id ที่เลือก
const selectAllApproved = ref(false)  // checkbox all
const approveData = ref([])  //
const filterStatus = ref("")
const isApproving = ref(false)

const tableWrapper = ref(null);
const noticeBox = ref(null);
const showNotice = ref(false);
const isScrolledRight = ref(false); // เก็บสถานะเลื่อนขวาหรือยัง
const showAnimatedButton = ref(false);

const saleOrders = ref([]);

// eslint-disable-next-line no-unused-vars
const approvedVoucherNo = ref(""); // สำหรับเก็บเลขที่เอกสารที่อนุมัติแล้ว

const totalRows = ref(0);
const currentPage = ref(1);
const limit = 10;

const searchQuery = ref(""); // <- ช่องค้นหา
const isLoading = ref(false); // หรือ true ถ้าต้องการให้เริ่มต้นแสดง

const showCollectorsModal = ref(false);
const modalCollectors = ref([]);

const isAdmin = computed(() => localStorage.getItem("role_admin") === "true");
const isFa = computed(() => localStorage.getItem("role_fa") === "true");
const isCrm = computed(() => localStorage.getItem("role_crm") === "true");

const canApprove = computed(() => isFa.value || isAdmin.value);

const statusPriority = {
  เขียว: 1,
  เหลือง: 2,
  ส้ม: 3,
  แดง: 4,
  ดำ: 5,
  ไม่มีสถานะ: 0,
  ยกเลิกคำสั่งซื้อ: 6,
};

const formatCurrency = (value) =>
  Number(value).toLocaleString(undefined, {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
  });


// เมื่อ component โหลดเสร็จ แสดงปุ่มพร้อม animation
onMounted(() => {
  showAnimatedButton.value = true;
  // deBAdminCustomers();

  // ซ่อนปุ่มหลังจาก 10 วินาที
  // setTimeout(() => {
  //   showAnimatedButton.value = false;
  // }, 10000);
});

function scrollToRight() {
  if (!tableWrapper.value) return;

  if (!isScrolledRight.value) {
    // เลื่อนไปขวาสุด
    tableWrapper.value.scrollTo({
      left: tableWrapper.value.scrollWidth,
      behavior: "smooth",
    });
    isScrolledRight.value = true;
  } else {
    // ถ้าเลื่อนขวาแล้ว กดอีกทีเลื่อนกลับซ้ายสุด
    tableWrapper.value.scrollTo({
      left: 0,
      behavior: "smooth",
    });
    isScrolledRight.value = false;
  }

  // แสดงแจ้งเตือน (optional)
  showNotice.value = true;
  setTimeout(() => {
    showNotice.value = false;
  }, 3000);
}

function onScroll() {
  if (!tableWrapper.value || !noticeBox.value) return;

  const scrollLeft = tableWrapper.value.scrollLeft;
  // เลื่อนกล่องแจ้งเตือนไปขวาตาม scrollLeft แต่ไม่เกิน container width - notice width
  const maxTranslateX = tableWrapper.value.clientWidth - noticeBox.value.offsetWidth;

  // -scrollLeft เพราะกล่องอยู่ติดซ้าย แต่ scroll คือเลื่อนไปขวา => กล่องต้องเลื่อนกลับไปทางซ้าย
  let translateX = -scrollLeft;

  if (translateX < -maxTranslateX) translateX = -maxTranslateX;
  if (translateX > 0) translateX = 0;
}

const getDisplayStatus = (status) => {
  switch (status) {
    case "เขียว":
      return "เกินกำหนดชำระไม่เกิน 30 วัน";
    case "เหลือง":
      return "เกินกำหนดชำระเกิน 30 วัน";
    case "ส้ม":
      return "เกินกำหนดชำระเกิน 30 วัน";
    case "แดง":
      return "เกินกำหนดชำระ 120 วัน";
    case "ดำ":
      return "เกินกำหนดชำระ 180 วัน";
    case "ไม่มีสถานะ":
      return "ไม่มีสถานะ";
    case "ยกเลิกคำสั่งซื้อ":
      return "ถูกยกเลิก";
    default:
      return status || "ไม่มีสถานะ";
  }
};

const getStatusColor = (status) => {
  switch (status) {
    case "เขียว":
      return "bg-green-100 text-green-800";
    case "เหลือง":
      return "bg-yellow-100 text-yellow-800";
    case "ส้ม":
      return "bg-orange-100 text-orange-800";
    case "แดง":
      return "bg-red-100 text-red-800";
    case "ดำ":
      return "bg-gray-800 text-white";
    case "ไม่มีสถานะ":
      return "bg-gray-200 text-gray-600";
    case "ยกเลิกคำสั่งซื้อ":
      return "bg-gray-300 text-gray-700 italic";
    default:
      return "bg-gray-100 text-gray-500";
  }
};

// ✅ เพิ่ม icon ตามสถานะ
const getStatusIcon = (status) => {
  switch (status) {
    case "เขียว":
      return CheckCircleIcon;
    case "เหลือง":
      return AlertTriangleIcon;
    case "ส้ม":
      return AlertTriangleIcon;
    case "แดง":
      return AlertOctagonIcon;
    case "ดำ":
      return XOctagonIcon;
    case "ยกเลิกคำสั่งซื้อ":
      return BanIcon;
    default:
      return HelpCircleIcon;
  }
};


const getHighestStatus = (details) => {
  if (!details || details.length === 0) return "ไม่มีสถานะ";

  return details.reduce((highest, current) => {
    const currentPriority = statusPriority[current.status2] ?? 0;
    const highestPriority = statusPriority[highest] ?? 0;
    return currentPriority > highestPriority ? current.status2 : highest;
  }, "ไม่มีสถานะ");
};


// const filteredOrders = computed(() => {
//   const raw = searchQuery.value.trim();
//   if (!raw) return saleOrders.value;

//   const keyword = raw.toLowerCase();
//   const parts = keyword.split(/\s+/); // แยกด้วยช่องว่าง

//   return saleOrders.value.filter((order) => {
//     const saleNo = order.sale_no?.toLowerCase().trim() || "";
//     const customerCode = order.customer_code?.toLowerCase().trim() || "";
//     const shopName = order.shop_name?.toLowerCase().trim() || "";
//     const employeeName = order.employee_name?.toLowerCase().trim() || "";
//     const mobile = order.mobile?.toLowerCase().trim() || "";
//     const employeeMobile = order.employee_mobile?.toLowerCase().trim() || "";
//     const createdAt = order.created_at?.toLowerCase().trim() || "";

//     // เงื่อนไข: ตรวจทีละ keyword
//     return parts.every((part) => {
//       const isoDate = convertThaiDateToISO(part);
//       return (
//         saleNo.includes(part) ||
//         customerCode.includes(part) ||
//         shopName.includes(part) ||
//         employeeMobile.includes(part) ||
//         mobile.includes(part) ||
//         employeeName.includes(part) ||
//         (isoDate && createdAt.includes(isoDate)) ||
//         createdAt.includes(part) // เผื่อ user พิมพ์ yyyy-mm-dd โดยตรง
//       );
//     });
//   });
// });

// ===== Filter ตามสถานะ =====
// แปลงสถานะให้ตรงก่อน filter
// const normalizeStatus = (s) => (s || "").trim().toLowerCase()

// if (filterStatus.value === "approved") {
//   orders = orders.filter(o => normalizeStatus(o.status) === "ตรวจสอบเรียบร้อย".toLowerCase())
// } else if (filterStatus.value === "pending") {
//   orders = orders.filter(o => normalizeStatus(o.status) !== "ตรวจสอบเรียบร้อย".toLowerCase())
// }

// if (filterStatus.value === "approved") {
//   orders = orders.filter(o => o.status === "ตรวจสอบเรียบร้อย");
//   console.log("Filtered approved orders:", orders);
// } else if (filterStatus.value === "pending") {
//   orders = orders.filter(o => o.status !== "ตรวจสอบเรียบร้อย");
//   console.log("Filtered pending orders:", orders);
// }


const filteredOrders = computed(() => {
  let orders = saleOrders.value;


  // ===== Filter ตามคำค้นหา =====
  if (searchQuery.value.trim()) {
    const parts = searchQuery.value
      .toLowerCase()
      .split(" ")
      .map(p => p.trim())
      .filter(p => p);

    orders = orders.filter(order => {
      const saleNo = order.sale_no?.toLowerCase() || "";
      const customerCode = order.customer_code?.toLowerCase() || "";
      const shopName = order.shop_name?.toLowerCase() || "";
      const employeeMobile = order.employee_mobile?.toLowerCase() || "";
      const mobile = order.mobile?.toLowerCase() || "";
      const employeeName = order.employee_name?.toLowerCase() || "";
      const createdAt = order.created_at || "";

      return parts.every((part) => {
        const isoDate = convertThaiDateToISO(part);
        return (
          saleNo.includes(part) ||
          customerCode.includes(part) ||
          shopName.includes(part) ||
          employeeMobile.includes(part) ||
          mobile.includes(part) ||
          employeeName.includes(part) ||
          (isoDate && createdAt.includes(isoDate)) ||
          createdAt.includes(part)
        );
      });
    });
  }

  return orders;
});

// กดเลือก/ยกเลิกทั้งหมด แต่เลือกเฉพาะ order ที่ยังไม่อนุมัติแล้ว
// function toggleSelectAllApproved() {
//   if (selectAllApproved.value) {
//     selectedOrders.value = filteredOrders.value
//       .filter(o => o.status === "ยังไม่ได้ตรวจสอบ") // เฉพาะที่ยังไม่อนุมัติ
//       .map(o => o.id)
//   } else {
//     selectedOrders.value = []
//   }
// }

// กดเลือก/ยกเลิกทั้งหมด เฉพาะ order ที่ยังไม่อนุมัติในหน้านี้
function toggleSelectAllApproved() {
  const pageIds = filteredOrders.value
    .filter(o => o.status === "ยังไม่ได้ตรวจสอบ")
    .map(o => o.id);

  if (selectAllApproved.value) {
    // เพิ่ม id ที่ยังไม่มีใน selectedOrders
    selectedOrders.value = Array.from(new Set([...selectedOrders.value, ...pageIds]));
  } else {
    // ลบ id เฉพาะที่อยู่ในหน้านี้ออกจาก selectedOrders
    selectedOrders.value = selectedOrders.value.filter(id => !pageIds.includes(id));
  }
}

// sync สถานะ checkbox all
// watch([selectedOrders, filteredOrders], () => {
//   const approvedIds = filteredOrders.value
//     .filter(o => o.status === "ยังไม่ได้ตรวจสอบ")
//     .map(o => o.id)

//   selectAllApproved.value =
//     approvedIds.length > 0 && approvedIds.every(id => selectedOrders.value.includes(id))
// })

// sync สถานะ checkbox all เฉพาะหน้า
watch([selectedOrders, filteredOrders], () => {
  const pageIds = filteredOrders.value
    .filter(o => o.status === "ยังไม่ได้ตรวจสอบ")
    .map(o => o.id);

  selectAllApproved.value =
    pageIds.length > 0 && pageIds.every(id => selectedOrders.value.includes(id));
});

// // Watcher: sync state ระหว่าง checkbox all กับ selectedOrders
// watch(selectedOrders, (newVal) => {
//   const approvedIds = filteredOrders.value
//     .filter(o => o.status === "ตรวจสอบเรียบร้อย")
//     .map(o => o.id)

//   selectAllApproved.value =
//     approvedIds.length > 0 && approvedIds.every(id => newVal.includes(id))
// })


// async function approveSelected() {
//   if (!selectedOrders.value.length) {
//     alert("กรุณาเลือก order อย่างน้อย 1 รายการ");
//     return;
//   }

//   const ordersToSend = selectedOrders.value
//     .map(orderId => {
//       const order = saleOrders.value.find(o => o.id === orderId);
//       if (!order) return null;

//       return {
//         formdataapi: {
//           ...order.order,
//           promotions: order.promotions || [],
//           gifts: order.gifts || [],
//         },
//         productListap: order.productList || [],
//         servicesPull: order.services || [],
//         deliveryAddress: order.deliveryAddress || null,
//       };
//     })
//     .filter(Boolean);

//   try {
//     const result = await sendToMacfive(ordersToSend);
//     console.log("✅ ผลลัพธ์การส่ง Macfive:", result);

//     Swal.fire({
//       icon: "success",
//       title: "ส่งเข้า Macfive เสร็จสิ้น",
//       text: `จำนวน ${ordersToSend.length} รายการ`,
//     });
//   } catch (err) {
//     console.error(err);
//     Swal.fire({
//       icon: "error",
//       title: "เกิดข้อผิดพลาด",
//       text: "ไม่สามารถส่งข้อมูล Macfive ได้",
//     });
//   }
// }




// function approveSelected() {
//   if (selectedOrders.value.length === 0) return;

//   Swal.fire({
//     title: 'ยืนยันการอนุมัติ',
//     text: `ต้องการอนุมัติเอกสารที่เลือก ${selectedOrders.value.length} รายการ ใช่หรือไม่?`,
//     icon: 'question',
//     showCancelButton: true,
//     confirmButtonText: 'ใช่, อนุมัติเลย',
//     cancelButtonText: 'ยกเลิก',
//   }).then(async (result) => {
//     if (result.isConfirmed) {
//       console.log("Selected Order IDs to approve:", selectedOrders.value);

//       // ดึงรายละเอียดของ order ที่เลือก
//       const ordersToApprove = selectedOrders.value
//         .map(orderId => saleOrders.value.find(o => o.id === orderId))
//         .filter(Boolean); // ลบ undefined ถ้าไม่เจอ

//       console.log("Orders with details to approve:", ordersToApprove);

//       // 🌟 loop ผ่าน ordersToApprove และส่งแต่ละ order ไป Macfive
//       for (const orderObj of ordersToApprove) {
//         // เอา Proxy ออกให้หมด
//         const formdataapi = JSON.parse(JSON.stringify(orderObj.order));
//         const productListap = JSON.parse(JSON.stringify(orderObj.productList));
//         const servicesPull = JSON.parse(JSON.stringify(orderObj.services));
//         const deliveryAddress = JSON.parse(JSON.stringify(orderObj.deliveryAddress));

//         console.log("Sending to Macfive:", { formdataapi, productListap, servicesPull, deliveryAddress });

//         try {
//           const res = await sendToMacfive(formdataapi, productListap, servicesPull, deliveryAddress);
//           console.log('ส่งไป Macfive สำเร็จ:', res);
//         } catch (err) {
//           console.error('ส่งไป Macfive ไม่สำเร็จ:', err);
//         }
//       }
//     }
//   });
// }


// import { toRaw } from "vue";

async function updateOrderStatus(documentNo) {
      try {
        const response = await axios.post(
          `${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/document_running/update_status_order.php`,
          {
            documentNo: documentNo,
            status: "ตรวจสอบเรียบร้อย",
          },
          {
            headers: {
              "Content-Type": "application/json",
            },
          }
        );

        if (response.data?.success) {
          console.log("📦 อัปเดตสถานะสำเร็จ:", response.data.message);
        } else {
          console.warn("⚠️ อัปเดตสถานะไม่สำเร็จ:", response.data.message);
        }
      } catch (error) {
        console.error("❌ เกิดข้อผิดพลาดในการอัปเดตสถานะ:", error);
      }
    }

// async function approveSelected() {
//   if (selectedOrders.value.length === 0) return;

//    // Log ข้อมูลที่เลือกไว้ทั้งหมด
//   console.log("🟢 selectedOrders (IDs):", JSON.stringify(selectedOrders.value));
//   console.log("🟢 approveData (all loaded orders):", JSON.stringify(approveData.value.map(o => o.id)));


//   const resultConfirm = await Swal.fire({
//     title: 'ยืนยันการอนุมัติ',
//     text: `ต้องการอนุมัติเอกสารที่เลือก ${selectedOrders.value.length} รายการ ใช่หรือไม่?`,
//     icon: 'question',
//     showCancelButton: true,
//     confirmButtonText: 'ใช่, อนุมัติเลย',
//     cancelButtonText: 'ยกเลิก',
//   });

//   if (!resultConfirm.isConfirmed) return;

//   // ✅ เปิด Loading
//   isLoading.value = true;

// // Log ก่อนหา order
//   console.log("🟢 หา ordersToApprove จาก approveData");

//   const ordersToApprove = selectedOrders.value
//     .map(id => approveData.value.find(o => o.id === id))
//     // .map(id => saleOrders.value.find(o => o.id === id))
//     .filter(o => o && o.order);

//      // Log ordersToApprove ที่จะส่งไป
//   console.log("🟢 ordersToApprove (objects):", JSON.stringify(ordersToApprove.map(o => o.id)));


//   const successList = [];
//   const failList = [];

//   for (const orderObj of ordersToApprove) {
//     const formdataapi = structuredClone(toRaw(orderObj.order));
//     const productListap = structuredClone(toRaw(orderObj.productList || []));
//     const servicesPull = structuredClone(toRaw(orderObj.services || []));
//     const deliveryAddress = structuredClone(toRaw(orderObj.deliveryAddress || false));

//     try {
//       const res = await sendToMacfive(formdataapi, productListap, servicesPull, deliveryAddress);

//       if (res?.Success) {
//         successList.push(formdataapi.document_no || formdataapi.documentNo || "N/A");

//       } else {
//         Swal.fire({
//           title: "ไม่สามารถอนุมัติรายการสั่งซื้อได้",
//           text: "กรุณาลองใหม่อีกครั้ง",
//           icon: "error",
//         })

//         // location.reload();
//         // eslint-disable-next-line no-undef
//         const message = err.response?.data?.message || err.message || "เกิดข้อผิดพลาด";
//         console.error("เกิดข้อผิดพลาด", message);
//       }

//     } catch (err) {
//       failList.push({
//         doc: formdataapi.document_no || formdataapi.documentNo || "N/A",
//         msg: err.message || "เกิดข้อผิดพลาด"
//       });
//     }
//   }

//   // ✅ ปิด Loading
//   isLoading.value = false;


// let hasSuccess = successList.length > 0;
// let hasFail = failList.length > 0;

// // สร้างข้อความสรุปสั้น ๆ
// let summaryMessage = '';
// if (hasSuccess) summaryMessage += `✅ สำเร็จ: ${successList.length} รายการ<br>`;
// if (hasFail) summaryMessage += `❌ ไม่สำเร็จ: ${failList.length} รายการ`;

// // เพิ่มปุ่มสำหรับดูรายละเอียด
// Swal.fire({
//   title: 'ผลการอนุมัติรายการ',
//   html: summaryMessage,
//   icon: hasFail ? 'warning' : 'success',
//   showCancelButton: hasSuccess || hasFail,
//   confirmButtonText: 'ดูรายละเอียด',
//   cancelButtonText: 'ปิด',
//   width: '400px', // ลดความกว้างของกล่อง
//   customClass: {
//     popup: 'p-3 text-sm',
//     title: 'swal-title-small'    // กำหนด class ให้ title
//   } // ลด padding และตัวอักษรเล็กลง
// }).then((result) => {
//   if (result.isConfirmed) {
//     let leftColumn = hasSuccess
//       ? `<p>✅ สำเร็จ:</p><ul>${successList.map(v => `<li><a href="/sale-order/${v}" target="_blank">${v}</a></li>`).join('')}</ul>`
//       : '';
//     let rightColumn = hasFail
//       ? `<p>❌ ไม่สำเร็จ:</p><ul>${failList.map(v => `<li><a href="/sale-order/${v.doc}" target="_blank">${v.doc}</a></li>`).join('')}</ul>`
//       : '';

//     let detailHtml = '';
//     if (hasSuccess && hasFail) {
//       detailHtml = `
//         <div style="display:flex; gap:15px; max-height:250px; overflow:auto; font-size:0.95rem;">
//           <div style="flex:1; border-right:1px solid #ccc; padding-right:8px;">${leftColumn}</div>
//           <div style="flex:1; padding-left:8px;">${rightColumn}</div>
//         </div>
//       `;
//     } else if (hasSuccess) {
//       detailHtml = `<div style="max-height:250px; overflow:auto; font-size:0.95rem;">${leftColumn}</div>`;
//     } else if (hasFail) {
//       detailHtml = `<div style="max-height:250px; overflow:auto; font-size:0.95rem;">${rightColumn}</div>`;
//     }

//     Swal.fire({
//       title: 'รายละเอียดผลการอนุมัติ',
//       html: detailHtml,
//       width: '500px', // ลดความกว้างของกล่องรายละเอียด
//       confirmButtonText: 'ปิด',
//       customClass: {
//         popup: 'p-3 text-sm',
//         title: 'swal-title-small'    // กำหนด class ให้ title
//       } // ลด padding และตัวอักษรเล็กลง
//     }).then(() => {
//       location.reload();
//     });
//   } else {
//     // กดปิด
//     location.reload();
//   }
// });
// }

async function approveSelected() {
  if (selectedOrders.value.length === 0) return;

  const resultConfirm = await Swal.fire({
    title: 'ยืนยันการอนุมัติ',
    text: `ต้องการอนุมัติเอกสารที่เลือก ${selectedOrders.value.length} รายการ ใช่หรือไม่?`,
    icon: 'question',
    showCancelButton: true,
    confirmButtonText: 'ใช่, อนุมัติเลย',
    cancelButtonText: 'ยกเลิก',
  });

  if (!resultConfirm.isConfirmed) return;

  isLoading.value = true;

  const ordersToApprove = selectedOrders.value
    .map(id => approveData.value.find(o => o.id === id))
    .filter(o => o && o.order);

  const successList = [];
  const failList = [];
  const approvedVoucherList = []; // ✅ เก็บ VoucherNo สำหรับอัปเดตหลังสุด

  for (const orderObj of ordersToApprove) {
    const formdataapi = structuredClone(toRaw(orderObj.order));
    const productListap = structuredClone(toRaw(orderObj.productList || []));
    const servicesPull = structuredClone(toRaw(orderObj.services || []));
    const deliveryAddress = structuredClone(toRaw(orderObj.deliveryAddress || false));

    try {
      const res = await sendToMacfive(formdataapi, productListap, servicesPull, deliveryAddress);

      if (res?.Success) {
        const voucherNo = res?.VoucherNo || "";
        console.log('Check voucherNo : ',voucherNo);

        successList.push(formdataapi.document_no || formdataapi.documentNo || "N/A");
        approvedVoucherList.push(voucherNo); // ✅ เก็บไว้ใช้อัปเดตทีเดียว

        console.log('Check approvedVoucherList : ',approvedVoucherList);

      } else {
        failList.push({
          doc: formdataapi.document_no || formdataapi.documentNo || "N/A",
          msg: res?.message || "เกิดข้อผิดพลาด",
        });
      }
    } catch (err) {
      failList.push({
        doc: formdataapi.document_no || formdataapi.documentNo || "N/A",
        msg: err.message || "เกิดข้อผิดพลาด",
      });
    }
  }

  // อัปเดตสถานะทั้งหมดทีเดียวหลังอนุมัติสำเร็จ
  if (approvedVoucherList.length > 0) {
    for (const voucher of approvedVoucherList) {
      await updateOrderStatus(voucher);
    }
  }

  isLoading.value = false;

  const hasSuccess = successList.length > 0;
  const hasFail = failList.length > 0;

  let summaryMessage = '';
  if (hasSuccess) summaryMessage += `✅ สำเร็จ: ${successList.length} รายการ<br>`;
  if (hasFail) summaryMessage += `❌ ไม่สำเร็จ: ${failList.length} รายการ`;

  Swal.fire({
    title: 'ผลการอนุมัติรายการ',
    html: summaryMessage,
    icon: hasFail ? 'warning' : 'success',
    showCancelButton: hasSuccess || hasFail,
    confirmButtonText: 'ดูรายละเอียด',
    cancelButtonText: 'ปิด',
    width: '400px',
    customClass: {
      popup: 'p-3 text-sm',
      title: 'swal-title-small'
    }
  }).then((result) => {
    if (result.isConfirmed) {
      const leftColumn = hasSuccess
        ? `<p>✅ สำเร็จ:</p><ul>${successList.map(v => `<li><a href="/sale-order/${v}" target="_blank">${v}</a></li>`).join('')}</ul>`
        : '';
      const rightColumn = hasFail
        ? `<p>❌ ไม่สำเร็จ:</p><ul>${failList.map(v => `<li>${v.doc} - ${v.msg}</li>`).join('')}</ul>`
        : '';

      const detailHtml =
        hasSuccess && hasFail
          ? `<div style="display:flex; gap:15px; max-height:250px; overflow:auto; font-size:0.95rem;">
               <div style="flex:1; border-right:1px solid #ccc; padding-right:8px;">${leftColumn}</div>
               <div style="flex:1; padding-left:8px;">${rightColumn}</div>
             </div>`
          : hasSuccess
          ? `<div style="max-height:250px; overflow:auto; font-size:0.95rem;">${leftColumn}</div>`
          : `<div style="max-height:250px; overflow:auto; font-size:0.95rem;">${rightColumn}</div>`;

      Swal.fire({
        title: 'รายละเอียดผลการอนุมัติ',
        html: detailHtml,
        width: '500px',
        confirmButtonText: 'ปิด',
        customClass: {
          popup: 'p-3 text-sm',
          title: 'swal-title-small'
        }
      }).then(() => {
        location.reload();
      });
    } else {
      location.reload();
    }
  });
}


// function approveSelected() {
//   if (selectedOrders.value.length === 0) return;

//   Swal.fire({
//     title: 'ยืนยันการอนุมัติ',
//     text: `ต้องการอนุมัติเอกสารที่เลือก ${selectedOrders.value.length} รายการ ใช่หรือไม่?`,
//     icon: 'question',
//     showCancelButton: true,
//     confirmButtonText: 'ใช่, อนุมัติเลย',
//     cancelButtonText: 'ยกเลิก',
//   }).then(async (result) => {
//     if (!result.isConfirmed) return;

//     console.log("Selected Order IDs to approve:", selectedOrders.value);

//     // ดึงรายละเอียด Orders ทั้งหมดที่เลือก
//     const ordersToApprove = selectedOrders.value
//       .map(id => saleOrders.value.find(o => o.id === id) )
//       .filter(o => o && o.order); // กัน undefined และ order ที่ไม่มีข้อมูล

//     console.log("Orders with details to approve:", ordersToApprove);

//     for (const orderObj of ordersToApprove) {
//       // ใช้ structuredClone หรือ toRaw เพื่อลอก Proxy ออก
//       const formdataapi = structuredClone(toRaw(orderObj.order));
//       const productListap = structuredClone(toRaw(orderObj.productList || []));
//       const servicesPull = structuredClone(toRaw(orderObj.services || []));
//       const deliveryAddress = structuredClone(toRaw(orderObj.deliveryAddress || false));

//       console.log("Sending to Macfive:", { formdataapi, productListap, servicesPull, deliveryAddress });

//       try {
//         const res = await sendToMacfive(formdataapi, productListap, servicesPull, deliveryAddress);

//         const macfiveResponse = res; // สมมติ res คือ response จาก Macfive

//         console.log("Response from Macfive VoucherNo:", macfiveResponse.VoucherNo);

//         if (macfiveResponse?.Success) {
//         // if (macfiveResponse.data?.Success) {

//           console.log('ส่งไป Macfive สำเร็จ:', macfiveResponse);

//             approvedVoucherNo.value = macfiveResponse?.VoucherNo || "";

//             console.log("📦 รายการ DocumentNo :", approvedVoucherNo.value);

//             // update สถานะใน Database ปิดไว้ก่อน
//             // await this.updateOrderStatus(approvedVoucherNo.value);

//             Swal.fire({
//               title: "อนุมัติรายการสั่งซื้อสำเร็จ",
//               text: `อนุมัติเอกสารสำเร็จ: ${approvedVoucherNo.value}`,
//               icon: "success",
//             })
//               .then(() => {
//                 // ✅ รีเฟรชหน้าเมื่อกด OK
//                 location.reload();
//               });
//             // location.reload();

//           } else {
//             // Swal.fire({
//             //   title: "ไม่สามารถอนุมัติรายการสั่งซื้อได้",
//             //   text: "กรุณาลองใหม่อีกครั้ง",
//             //   icon: "error",
//             // })

//             const message = macfiveResponse?.Message || "กรุณาลองใหม่อีกครั้ง";
//             Swal.fire({
//               title: "ไม่สามารถอนุมัติรายการสั่งซื้อได้",
//               text: message,
//               icon: "error",
//             });
//             console.error("เกิดข้อผิดพลาด:", message);

//             // location.reload();

//             // const message = err.response?.data?.message || err.message || "เกิดข้อผิดพลาด";
//             //  throw new Error(macfiveResponse?.data?.Message || "กรุณาลองใหม่อีกครั้ง");
//             // console.error("เกิดข้อผิดพลาด", message);
//           }


//       } catch (err) {
//         console.error(`❌ ส่ง Order ${orderObj.id} ไม่สำเร็จ:`, err);
//       }
//     }
//   });
// }


// function approveSelected() {
//   if (selectedOrders.value.length === 0) return;

//   Swal.fire({
//     title: 'ยืนยันการอนุมัติ',
//     text: `ต้องการอนุมัติเอกสารที่เลือก ${selectedOrders.value.length} รายการ ใช่หรือไม่?`,
//     icon: 'question',
//     showCancelButton: true,
//     confirmButtonText: 'ใช่, อนุมัติเลย',
//     cancelButtonText: 'ยกเลิก',
//   }).then(async (result) => {
//     if (result.isConfirmed) {
//       console.log("Selected Order IDs to approve:", selectedOrders.value);

//       // ดึงรายละเอียดของ order ที่เลือก
//       const ordersToApprove = selectedOrders.value
//         .map(orderId => saleOrders.value.find(o => o.id === orderId))
//         .filter(Boolean); // ลบ undefined ถ้าไม่เจอ

//       console.log("Orders with details to approve:", ordersToApprove);

//       // 🌟 loop ผ่าน ordersToApprove และส่งแต่ละ order ไป Macfive
//       for (const orderObj of ordersToApprove) {
//         const formdataapi = orderObj.order;             // ดึง order object
//         const productListap = orderObj.productList;     // ดึง products
//         const servicesPull = orderObj.services;         // ดึง services
//         const deliveryAddress = orderObj.deliveryAddress; // ดึง address

//         try {
//           const res = await sendToMacfive(formdataapi, productListap, servicesPull, deliveryAddress);
//           console.log('ส่งไป Macfive สำเร็จ:', res);
//         } catch (err) {
//           console.error('ส่งไป Macfive ไม่สำเร็จ:', err);
//         }
//       }
//     }
//   });
// }


// function approveSelected() {
//   if (selectedOrders.value.length === 0) return;

//   Swal.fire({
//     title: 'ยืนยันการอนุมัติ',
//     text: `ต้องการอนุมัติเอกสารที่เลือก ${selectedOrders.value.length} รายการ ใช่หรือไม่?`,
//     icon: 'question',
//     showCancelButton: true,
//     confirmButtonText: 'ใช่, อนุมัติเลย',
//     cancelButtonText: 'ยกเลิก',
//   }).then(async (result) => {
//     if (result.isConfirmed) {

//       console.log("Selected Order IDs to approve:", selectedOrders.value);

//       // ดึงรายละเอียดของ order ที่เลือก
//       // const ordersToApprove = approveData.value.map(orderId => {
//       //   // หา order object จาก list_order ของหน้าปัจจุบัน
//       //   return approveData.value.find(o => o.order.id === orderId.id);
//       //   // return listOrders.value.find(o => o.order.id === orderId);
//       // }).filter(Boolean); // ลบ undefined ถ้าไม่เจอ

//       // ดึงรายละเอียด order ที่เลือกเฉพาะ
//       const ordersToApprove = selectedOrders.value
//         .map(orderId => saleOrders.value.find(o => o.id === orderId))
//         .filter(Boolean); // ลบ undefined ถ้าไม่เจอ

//       console.log("Orders with details to approve:", ordersToApprove);

//       // console.log("Approving orders: ", approveData.value);

//       return; // testing


//       // try {
//       //   isApproving.value = true;

//       //   const res = await axios.post(
//       //     `${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/list_sale_orders/approve_orders.php`,
//       //     { orders: ordersToApprove  },
//       //     // { orderIds: selectedOrders.value,
//       //     {
//       //       headers: {
//       //         'Content-Type': 'application/json',
//       //       },
//       //     }
//       //   );

//       //   if (res.data.success) {
//       //     Swal.fire('อนุมัติสำเร็จ', res.data.message, 'success');
//       //     selectedOrders.value = [];
//       //     selectAllApproved.value = false;
//       //     await fetchPage(currentPage.value);
//       //   } else {
//       //     Swal.fire('ผิดพลาด', res.data.message || 'อนุมัติไม่สำเร็จ', 'error');
//       //   }
//       // } catch (error) {
//       //   Swal.fire('ผิดพลาด', error.message || 'เกิดข้อผิดพลาด', 'error');
//       // } finally {
//       //   isApproving.value = false;
//       // }
//     }
//   });
// }


// function approveSelected() {
//   if (selectedOrders.value.length === 0) return;

//   Swal.fire({
//     title: 'ยืนยันการอนุมัติ',
//     text: `ต้องการอนุมัติเอกสารที่เลือก ${selectedOrders.value.length} รายการ ใช่หรือไม่?`,
//     icon: 'question',
//     showCancelButton: true,
//     confirmButtonText: 'ใช่, อนุมัติเลย',
//     cancelButtonText: 'ยกเลิก',
//   }).then(async (result) => {
//     if (result.isConfirmed) {

//       console.log("Selected Order IDs to approve:", selectedOrders.value);

//       // ดึงรายละเอียดของ order ที่เลือก
//       // const ordersToApprove = approveData.value.map(orderId => {
//       //   // หา order object จาก list_order ของหน้าปัจจุบัน
//       //   return approveData.value.find(o => o.order.id === orderId.id);
//       //   // return listOrders.value.find(o => o.order.id === orderId);
//       // }).filter(Boolean); // ลบ undefined ถ้าไม่เจอ

//       // ดึงรายละเอียด order ที่เลือกเฉพาะ
//       const ordersToApprove = selectedOrders.value
//         .map(orderId => saleOrders.value.find(o => o.id === orderId))
//         .filter(Boolean); // ลบ undefined ถ้าไม่เจอ

//       console.log("Orders with details to approve:", ordersToApprove);

//       // console.log("Approving orders: ", approveData.value);

//       // return; // testing


//       try {
//         isApproving.value = true;

//         const res = await axios.post(
//           `${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/list_sale_orders/approve_orders.php`,
//           { orders: ordersToApprove  },
//           // { orderIds: selectedOrders.value,
//           {
//             headers: {
//               'Content-Type': 'application/json',
//             },
//           }
//         );

//         if (res.data.success) {
//           Swal.fire('อนุมัติสำเร็จ', res.data.message, 'success');
//           selectedOrders.value = [];
//           selectAllApproved.value = false;
//           await fetchPage(currentPage.value);
//         } else {
//           Swal.fire('ผิดพลาด', res.data.message || 'อนุมัติไม่สำเร็จ', 'error');
//         }
//       } catch (error) {
//         Swal.fire('ผิดพลาด', error.message || 'เกิดข้อผิดพลาด', 'error');
//       } finally {
//         isApproving.value = false;
//       }
//     }
//   });
// }


function convertThaiDateToISO(dateStr) {
  const parts = dateStr.trim().split(/[-/]/);
  if (parts.length !== 3) return null;

  let [day, month, year] = parts.map((p) => parseInt(p, 10));

  // ตรวจสอบว่าเป็นตัวเลขทั้งหมด
  if (isNaN(day) || isNaN(month) || isNaN(year)) return null;

  if (year > 2400) year -= 543;

  const dateObj = new Date(year, month - 1, day);

  // ตรวจสอบว่าเป็น valid date
  if (isNaN(dateObj.getTime())) return null;

  return dateObj.toISOString().split("T")[0]; // yyyy-mm-dd
}

async function confirmDelete(orderId) {
  console.log("Check orderId: ", orderId);

  const result = await Swal.fire({
    title: "ยืนยันการลบ",
    text: "ต้องการลบรายการนี้ใช่หรือไม่? ข้อมูลที่เกี่ยวข้องจะถูกลบทั้งหมด",
    icon: "warning",
    showCancelButton: true,
    confirmButtonText: "ใช่, ลบเลย",
    cancelButtonText: "ยกเลิก",
  });

  // return;

  if (result.isConfirmed) {
    try {
      const res = await axios.post(
        `${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/list_sale_orders/delete_order.php`,
        { orderId },
        {
          headers: {
            "Content-Type": "application/json",
          },
        }
      );

      if (res.data.success) {
        Swal.fire("ลบสำเร็จ", res.data.message, "success");
        // โหลดข้อมูลใหม่
        await fetchPage(currentPage.value);
      } else {
        Swal.fire("ผิดพลาด", res.data.message || "ลบไม่สำเร็จ", "error");
      }
    } catch (error) {
      Swal.fire("ผิดพลาด", error.message || "เกิดข้อผิดพลาด", "error");
    }
  }
}

const visibleCounts = reactive({}); // key = order.sale_no, value = number of items shown

function getVisibleCount(order) {
  return visibleCounts[order.sale_no] ?? 5; // เริ่มต้น 3 รายการ
}

function showMore(order) {
  const extraLength = filteredExtraDetails(order).length;
  const current = getVisibleCount(order);
  visibleCounts[order.sale_no] = Math.min(current + 5, extraLength);
}

function showLess(order) {
  visibleCounts[order.sale_no] = Math.max(getVisibleCount(order) - 5, 5);
}

function showAll(order) {
  visibleCounts[order.sale_no] = filteredExtraDetails(order).length;
}



// ฟังก์ชันเมื่อเลือกตัวกรอง
async function handleFilterChange() {
  let orderstatus = filterStatus.value;
  // let orderstatus = saleOrders.value;
  console.log('Filter changed to:', filterStatus.value)
  console.log('Filtered Orders:', orderstatus)

  currentPage.value = 1; // เริ่มหน้าแรก

  await fetchPage(currentPage.value, orderstatus) // โหลดหน้าแรกใหม่ทุกครั้งที่เปลี่ยนตัวกรอง

}


function openCollectorsModal(list) {
  modalCollectors.value = list;
  console.log('check Function openCollectorsModal :');
  console.log('check modalCollectors.value :',modalCollectors.value);
  showCollectorsModal.value = true;
}


async function fetchPage(page = 1, orderstatus) {

  console.log(" status filter:", orderstatus);

  isLoading.value = true;
  try {
    const res = await axios.get(
      `${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/list_sale_orders/get_list_sale_order_Approve.php?v=${Date.now()}`,
      {
        params: {
          page,
          limit,
          search: searchQuery.value.trim(),
          status: orderstatus, // ส่งสถานะไป backend
        },
      }
    );

    console.log("Check Log res :", res);

    // if (res.data.success) {

    //   console.log("test if res.data.data :");

    //   if (Array.isArray(res.data.data)) {
    //     // รวม list_order จากทุก block เข้าด้วยกัน
    //     const mergedOrders = res.data.data.list_order.flatMap(block => block.list_order);

    if (res.data.success) {

      // const listOrder = res.data.data.list_order || [];

       if (res.data.success) {
          const listOrder = res.data.data.list_order || [];
          if (Array.isArray(listOrder)) {
            const mergedOrders = listOrder.map((item) => ({
              ...item,
              id: item.order.id,
              sale_no: item.order.document_no,
              customer_code: item.order.customer_code,
              shop_name: item.order.full_name,
              mobile: item.order.phone,
              total_amount: item.order.final_total_price,
              total_paid: item.order.final_total_price,
              status: item.order.status,
              created_at: item.order.created_at,
              employee_name: item.order.employee_name || "",
              employee_phone: item.order.employee_phone || "",
              collector_list: item.collector_list || [], // เก็บ collector ทั้งหมด
              extra_details: item.order.extra_list || [],
              productList: item.productList || [],
              services: item.services || [],
            }));

            saleOrders.value = mergedOrders;

            // Merge order ใหม่เข้า approveData (ไม่ซ้ำ id)
            const approveMap = new Map(approveData.value.map(o => [o.id, o]));
            mergedOrders.forEach(o => {
              if (!approveMap.has(o.id)) {
                approveMap.set(o.id, o);
              }
            });
            approveData.value = Array.from(approveMap.values());

            console.log('check approveData: ',approveData.value);

            totalRows.value = res.data.data.total;
            currentPage.value = page;

            await TypeCustomers();
            isLoading.value = false;
          }
        }

      // if (Array.isArray(listOrder)) {
      //   // list_order เป็น array อยู่แล้ว
      //   const mergedOrders = listOrder;

      //   saleOrders.value = mergedOrders.map((item) => ({
      //     ...item,
      //     id: item.order.id,
      //     sale_no: item.order.document_no,
      //     customer_code: item.order.customer_code,
      //     shop_name: item.order.full_name,
      //     mobile: item.order.phone,
      //     total_amount: item.order.final_total_price,
      //     total_paid: item.order.final_total_price,
      //     status: item.order.status,
      //     created_at: item.order.created_at,
      //     employee_name: item.order.employee_name || "",
      //     employee_phone: item.order.employee_phone || "",
      //     extra_details: item.order.extra_list || [],
      //     productList: item.productList || [],
      //     // promotions: item.promotions || [],
      //     // gifts: item.gifts || [],
      //     services: item.services || [],
      //   }));

      //   approveData.value =  saleOrders.value;

      //   // totalRows.value = saleOrders.value.length;
      //   totalRows.value = res.data.data.total; // จำนวนทั้งหมดจริงจาก database
      //   // saleOrders.value = res.data.data.list_order;
      //   currentPage.value = page;

      //   console.log("Merged Orders 781: ", saleOrders.value);

      //   await TypeCustomers();

      //   isLoading.value = false;
      // }

      console.log("Merged Orders 788: ", saleOrders.value);
      console.log("test else res.data.data :");

    }
  } catch (e) {
    console.error(e);
  } finally {
    isLoading.value = false;
  }
}




//
async function getTokenDebtStatusType() {
  isLoading.value = true;

  try {
    const loginData = {
      username: "DPower1",
      password: "1234",
    };

    const res = await axios.post(
      `${VITE_API_URL_C_SHARP}/api/Users/Login?v=${Date.now()}`,
      loginData,
      {
        headers: {
          "Content-Type": "application/json",
        },
      }
    );

    const data = res.data;

    console.log("Check Log data :", data);
    console.log("Check Log data.token :", data.token);

    const tokenDebtStatusType = data.token;
    console.log("Check Log res.tokenDebtStatusType :", tokenDebtStatusType);

    if (tokenDebtStatusType) {
      localStorage.setItem("tokenDebtStatusType", tokenDebtStatusType);
      isLoading.value = false;
      return tokenDebtStatusType;
    } else {
      console.warn("⚠️ Token not found in response.");
      return null;
    }
  } catch (e) {
    console.error(e);
  } finally {
    isLoading.value = false;
  }
}

async function TypeCustomers() {
  isLoading.value = true;

  // 🔁 สร้าง payload จาก saleOrders
  const payload = saleOrders.value.map((item) => ({
    CustomerDocument: item.sale_no,
    CustomerCode: item.customer_code,
  }));

  console.log(" payload: ", payload);

  const tokendebtStatusType = await getTokenDebtStatusType();

  // const tokendebtStatusType = await getTokenDebtStatusType();
  console.log("🔑 tokendebtStatusType: ", tokendebtStatusType);

  if (!tokendebtStatusType) {
    console.error("❌ No token available. Cannot call TypeCustomers API.");
    isLoading.value = false;
    return;
  }

  try {
    // VITE_API_URL_C_SHARP
    const res = await axios.post(
      `${VITE_API_URL_C_SHARP}/api/TypeCustomers?v=${Date.now()}`,
      payload,
      {
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${tokendebtStatusType}`,
        },
      }
    );

    const data = res.data;

    console.log("✅ Response from TypeCustomers:", data);

    if (data && Array.isArray(data)) {
      // 1) group by sale_no/customerDocument
      const grouped = {};
      data.forEach((item) => {
        const key = item.customerDocument;
        if (!grouped[key]) {
          grouped[key] = {
            deBcreditTerm: item.deBcreditTerm,
            deBlimit: item.deBlimit,
            deBsalesP: item.deBsalesP,
            status2: item.status2,
            total_paid: 0,
            extra_details: [],
          };
        }
        grouped[key].total_paid += item.inInvAmount ?? 0;
        grouped[key].extra_details.push({
          dueDate: item.dueDate || [],
          overdueDays: item.overdueDays || [],
          status2: item.status2 || [],
          inInvAmount: item.inInvAmount || [],
          miHvnos: item.miHvnos || [],
        });
      });

      // 2) merge back into saleOrders.value

      saleOrders.value = saleOrders.value.map((order) => {
        // หาว่าใน data มี deBcode ที่ตรงกับ customer_code ไหม
        const matched = data.find((item) => item.deBcode === order.customer_code);

        const hasMatch = !!matched;
        const deBcode = matched?.deBcode;
        const saleNo = order.sale_no;
        const updates = grouped[saleNo];

        console.log(`🔍 ตรวจสอบ: ${order.customer_code} -> deBcode: ${deBcode} | พบ: ${hasMatch}`);

        if (!hasMatch) {
          console.log(`❌ ไม่พบ deBcode ที่ตรงกับ order.customer_code = ${order.customer_code}`);
        }

        if (updates) {
          // เก็บ deBlimit ไว้ใน localStorage โดยใช้ customer_code เป็น key
          try {
            localStorage.setItem(
              `deBlimit_${order.customer_code}`,
              JSON.stringify(updates.deBlimit)
            );
          } catch (e) {
            console.warn("❗ เก็บ localStorage ไม่ได้:", e);
          }

          return {
            ...order,
            deBcreditTerm: updates.deBcreditTerm,
            deBlimit: updates.deBlimit,
            deBsalesP: updates.deBsalesP,
            status2: updates.status2,
            total_paid: updates.total_paid,
            extra_details:
              hasMatch && Array.isArray(updates.extra_details)
                ? updates.extra_details.filter((d) => typeof d === "object" && d !== null)
                : [],
            // extra_details: hasMatch ? updates.extra_details : []
          };
        }

        return order;
      });

      console.table(
        data.map((item) => ({
          deBcode: item.deBcode,
          customerDocument: item.customerDocument,
          inInvAmount: item.inInvAmount,
        }))
      );

      console.table(
        saleOrders.value.map((order) => ({
          sale_no: order.sale_no,
          customer_code: order.customer_code,
          extra_details: order.extra_details,
        }))
      );

      console.log("🎉 Grouped saleOrders:", saleOrders.value);
    } else {
      Swal.fire({
        title: "Not Data TypeCustomers",
        text: "Response from TypeCustomers is undefined",
        icon: "error",
      });
      console.error("❌ No valid data from API");
    }

    isLoading.value = false;
  } catch (e) {
    console.error(e);
  } finally {
    isLoading.value = false;
  }
}

function filteredExtraDetails(order) {
  if (!order.extra_details || !Array.isArray(order.extra_details)) return [];
  return order.extra_details.filter(
    (e) =>
      typeof e === "object" &&
      e !== null &&
      Object.values(e).some((v) => v !== "" && v !== undefined && !Number.isNaN(v))
  );
}

saleOrders.value.forEach((o) => {
  if (Array.isArray(o.extra_details)) {
    console.log(
      o.sale_no,
      o.extra_details.map((e) => typeof e)
    );
  }
});

watch(searchQuery, () => {
  // newVal
  currentPage.value = 1;
  // fetchPage(1);
  fetchPage(1, filterStatus.value);

});

onMounted(() => fetchPage(1));

const totalPages = computed(() => Math.ceil(totalRows.value / limit));

function goToPage(page) {
  if (page < 1 || page > totalPages.value) return;
  // fetchPage(page);
  fetchPage(page, filterStatus.value); // ส่งตัวกรองไปด้วย
}
</script>


<style scoped>
.slide-button-enter-active {
  transition: transform 0.5s ease, opacity 0.5s ease;
}

.slide-button-leave-active {
  transition: transform 0.5s ease, opacity 0.5s ease;
}

.slide-button-enter-from {
  transform: translateX(200%);
  opacity: 0;
}

.slide-button-enter-to {
  transform: translateX(0%);
  opacity: 1;
}

.slide-button-leave-from {
  transform: translateX(0%);
  opacity: 1;
}

.slide-button-leave-to {
  transform: translateX(200%);
  opacity: 0;
}
</style>


<!--


  // saleOrders.value = res.data.data.list_order.order.map((item) => ({
      //   id: item.id,
      //   sale_no: item.document_no,
      //   customer_code: item.customer_code,
      //   shop_name: item.full_name,
      //   mobile: item.phone,
      //   total_amount: item.final_total_price,
      //   total_paid: item.final_total_price,
      //   status: item.status,
      //   created_at: item.created_at,
      //   employee_name: item.employee_name, //
      //   employee_phone: item.employee_phone, // ถ้าจะใช้
      //   extra_details: item.extra_list || [],
      // }));

      // totalRows.value = res.data.data.total;
      // currentPage.value = page;

      // // คำนวณจำนวน Order ที่ยังไม่อนุมัติ
      // const pendingCount = saleOrders.value.filter(o => o.status !== 'ตรวจสอบเรียบร้อย').length;

      // // ส่งไปให้ Navbar ผ่าน eventBus
      // eventBus.emit('updateOrderNotification', pendingCount);

      // เรียกใช้ TypeCustomers หลังโหลดรายการเสร็จ
      // await TypeCustomers();
      // เรียก API deBAdminCustomers สำหรับแต่ละ order

      // const customerCodes = saleOrders.value.map(o => o.customer_code);
      // await deBAdminCustomersBatch(customerCodes);

      // isLoading.value = false;


-->
