<template>
  <div class="p-4 relative">
    <h1 class="text-2xl font-bold mb-4">รายการคำสั่งซื้อ</h1>

    <!-- ด้านบนของตาราง -->
    <div class="mb-4">
      <input
        v-model="searchQuery"
        type="text"
        placeholder="🔍 ค้นหา หมายเลขสั่งซื้อ / รหัสลูกค้า / ชื่อร้าน"
        class="w-full border border-gray-300 rounded-md px-4 py-2 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-500"
      />
    </div>

    <!-- ปุ่มแจ้งเตือน-->
    <!-- <transition name="slide-button">
      <button
        v-if="showAnimatedButton"
        @click="scrollToRight"
        class="fixed top-20 right-4 z-50 px-4 py-2 bg-blue-600 text-white rounded shadow-lg hover:bg-blue-700 transition"
        title="คลิกเพื่อเลื่อนดูข้อมูลเพิ่มเติม"
      >
        แสดงข้อมูลเพิ่มเติม {{ isScrolledRight ? "◀" : "▶" }}
      </button>
    </transition> -->

    <transition name="slide-button">
      <button
        v-if="showAnimatedButton"
        @click="scrollToRight"
        class="fixed top-20 right-4 z-50 flex items-center gap-2 px-5 py-3 bg-yellow-400 text-white rounded-lg shadow-lg hover:bg-yellow-700 transition duration-300 ease-in-out max-[480px]:px-1 max-[480px]:py-2 max-[480px]:text-sm max-[480px]:gap-1"
        title="คลิกเพื่อเลื่อนดูข้อมูลเพิ่มเติม"
      >
        <!-- ไอคอนแจ้งเตือน -->
        <svg
          class="w-5 h-5 text-white"
          fill="none"
          stroke="currentColor"
          stroke-width="2"
          viewBox="0 0 24 24"
          xmlns="http://www.w3.org/2000/svg"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"
          />
        </svg>

        <!-- ข้อความ -->
        <span class="font-medium"> แสดงข้อมูลเพิ่มเติม {{ isScrolledRight ? "◀" : "▶" }} </span>
      </button>
    </transition>

    <!-- <table class="min-w-full || [1500px] text-sm text-left text-gray-700 divide-x divide-gray-200"> -->
    <div
      ref="tableWrapper"
      style="max-width: 100%"
      class="overflow-auto rounded-lg shadow-md"
      @scroll="onScroll"
    >
      <table
        class="min-w-[1500px] table-fixed text-sm text-left text-gray-700 divide-x divide-gray-200 border border-gray-300"
      >
        <thead class="bg-gray-100 text-xs uppercase border">
          <tr class="border-r border-gray-300">
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
            <!-- เพิ่ม -->
            <th class="p-3 border">วงเงิน (limit)</th>
            <!-- เพิ่ม -->
            <th class="p-3 border">พนักงานขาย (Sales)</th>
            <!-- เพิ่ม -->
            <th class="p-3 border">สถานะประเภทหนี้</th>
            <th class="p-3 border">สถานะตรวจสอบ</th>
            <th class="p-3 border">การทำงาน</th>
            <!-- <th class="p-3 border">ยกเลิกการคำสั่งซื้อ</th> -->

            <!-- ถ้าเป็น crm ให้ซ่อนคอลัมน์นี้ -->
            <th v-if="!isCrm" class="p-3 border">ยกเลิกการคำสั่งซื้อ</th>
          </tr>
        </thead>

        <tbody v-if="isLoading">
          <tr>

            <td :colspan="isCrm ? 15 : 16" class="py-10 text-center">
            <!-- <td colspan="11" class="py-10 text-center"> -->
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

        <tbody v-if="!isLoading" class="text-xs">
          <template v-for="order in filteredOrders" :key="order.id">
            <!-- divide-x divide-gray-200 -->
            <tr class="border-b hover:bg-gray-50">
              <!-- <tr v-for="order in filteredOrders" :key="order.id" class="border-b hover:bg-gray-50"> -->
              <!-- <tr v-for="order in saleOrders" :key="order.id" class="border-b hover:bg-gray-50"> -->
              <td class="p-3">{{ order.id }}</td>
              <td class="p-3">{{ order.sale_no }}</td>
              <td class="p-3">{{ order.customer_code }}</td>
              <td class="p-3">{{ order.shop_name }}</td>
              <!-- <td class="p-3">{{ order.shop_name }}</td> -->
              <td class="p-3">{{ order.employee_name ? order.employee_name : "ไม่มีข้อมูล" }}</td>
              <td class="p-3">{{ order.mobile }}</td>
              <!-- <td class="p-3">{{ order.employee_mobile ? order.employee_mobile : "ไม่มีข้อมูล"}}</td> -->
              <td class="p-3">{{ order.employee_phone ? order.employee_phone : "ไม่มีข้อมูล"}}</td>
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
              <td
                :class="[
                  'p-3',
                  getStatusColor(getHighestStatus(filteredExtraDetails(order))),
                  'w-[9rem]', // กำหนดความกว้างเป็น 12rem (48 * 0.25rem)
                  'max-w-xs', // กำหนด max-width ถ้าต้องการจำกัด
                  'break-words', // ถ้าข้อความยาวให้ตัดขึ้นบรรทัดใหม่
                  'border-t-2 border-b-2 border-gray-300', // ใช้เฉพาะขอบบนและขอบล่าง
                ]"
              >
                {{ getDisplayStatus(getHighestStatus(filteredExtraDetails(order))) }}
              </td>

              <td class="p-3">
                <!-- :class="order.status === 'ยังไม่ได้ตรวจสอบ' ? 'bg-gray-500' : 'bg-green-500'" -->
                <span class="flex items-center space-x-1">
                  <span
                    class="w-2 h-2 rounded-full"
                    :class="{
                      'bg-gray-500': order.status === 'ยังไม่ได้ตรวจสอบ',
                      'bg-green-500': order.status === 'ตรวจสอบเรียบร้อย',
                      'bg-red-500': order.status === 'การตรวจสอบล้มเหลว',
                    }"
                  ></span>
                  <span class="w-[90px]">{{ order.status }}</span>
                </span>
              </td>

              <!-- ปุ่ม ตรวจสอบ -->
              <td class="p-3">
                <router-link :to="{ name: 'saleorderdetail', params: { id: order.sale_no } }">
                  <button
                    class="w-24 px-4 py-1 bg-blue-500 text-white rounded hover:bg-blue-600 text-sm"
                  >
                    ตรวจสอบ
                  </button>
                </router-link>
              </td>

              <!-- ปุ่ม ลบ (แสดงเฉพาะผู้ที่ canApprove เท่านั้น) -->
              <td class="p-3" v-if="canApprove">
                <button
                  @click="confirmDelete(order.id)"
                  class="w-24 px-4 py-1 bg-red-500 text-white rounded hover:bg-red-600 text-sm"
                >
                  ลบ
                </button>
              </td>

              <!-- ปุ่ม แก้ไข (แสดงเฉพาะผู้ที่ canEdit เท่านั้น) -->
              <!-- <td class="p-3" v-if="canEdit">
                <button
                  @click="enableEditMode(order.id)"
                  class="w-24 px-4 py-1 bg-yellow-500 text-white rounded hover:bg-yellow-600 text-sm"
                >
                  แก้ไข
                </button>
              </td> -->
            </tr>

            <!-- ✅ แถวรายละเอียดเพิ่มเติม (ถ้ามีข้อมูลพ่วง) -->
            <!-- <tr v-if="order.extra_details" class="bg-blue-50"> -->
            <!-- <td colspan="11" class="p-4 text-sm text-gray-700 border"> -->
            <!-- คุณสามารถปรับให้แสดงเป็นตาราง หรือข้อความ หรือ card ได้ -->
            <!-- <div>
                  <strong>ข้อมูลเพิ่มเติม:</strong>
                  <ul class="list-disc ml-6 mt-2">
                    <li v-for="(item, index) in order.extra_details" :key="index">{{ item }}</li>
                  </ul>
                </div>
              </td>
            </tr> -->
            <!-- แถวรายละเอียดเพิ่มเติม -->
            <!-- <tr v-if="order.extra_details.length" class="bg-blue-50"> -->

            <tr
              v-if="filteredExtraDetails(order).length > 0"
              class="bg-blue-50 hover:bg-blue-100 transition-colors duration-300"
            >
              <td colspan="16" class="px-6 py-4 border rounded-md">
                <div class="flex items-center space-x-2 text-blue-800 font-medium mb-3">
                  <svg
                    class="w-5 h-5 text-blue-600"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2"
                    viewBox="0 0 24 24"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      d="M13 16h-1v-4h-1m2-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
                    />
                  </svg>
                  <span>ข้อมูลใบแจ้งหนี้ที่เกี่ยวข้อง</span>
                </div>

                <!-- Cards style -->
                <div class="grid grid-cols-2 sm:grid-cols-4 md:grid-cols-5 gap-3 mt-3">
                  <div
                    v-for="(d, i) in filteredExtraDetails(order).slice(0, getVisibleCount(order))"
                    :key="i"
                    class="flex justify-between items-center bg-white shadow-sm rounded-lg p-2 border border-gray-200 transition-transform transform hover:scale-[1.01] hover:shadow-md duration-200 max-w-[280px]"
                  >
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
                        :class="getStatusColor(d.status2)"
                      >
                        <component :is="getStatusIcon(d.status2)" class="w-5 h-5" />
                      </div>
                      <div
                        class="absolute -top-2 left-1/2 -translate-x-1/2 -translate-y-full bg-black text-white text-[10px] px-2 py-0.5 rounded-md opacity-0 group-hover:opacity-100 group-hover:-translate-y-[130%] transition-all duration-300 whitespace-nowrap z-60"
                      >
                        สถานะ: {{ d.status2 }}
                      </div>
                    </div>
                  </div>
                </div>


                <!-- ปุ่ม Show more / Show less / Show All -->
                <div v-if="filteredExtraDetails(order).length > 3" class="mt-2 flex gap-2">
                  <button
                    v-if="getVisibleCount(order) < filteredExtraDetails(order).length"
                    @click="showMore(order)"
                    class="px-3 py-1 bg-blue-500 text-white rounded hover:bg-blue-600 text-xs"
                  >
                    Show more
                  </button>
                  <button
                    v-if="getVisibleCount(order) > 3"
                    @click="showLess(order)"
                    class="px-3 py-1 bg-gray-500 text-white rounded hover:bg-gray-600 text-xs"
                  >
                    Show less
                  </button>
                  <button
                    v-if="getVisibleCount(order) < filteredExtraDetails(order).length"
                    @click="showAll(order)"
                    class="px-3 py-1 bg-green-500 text-white rounded hover:bg-green-600 text-xs"
                  >
                    Show All
                  </button>
                </div>
              </td>
            </tr>
          </template>

            <!-- ถ้าไม่มีข้อมูล -->
            <tr v-if="!isLoading && filteredOrders.length === 0">
              <td
                :colspan="isCrm ? 15 : 16"
                class="text-center py-10 text-gray-500 font-medium"
              >
                ไม่มีข้อมูล
              </td>
            </tr>

        </tbody>
      </table>
    </div>

    <!-- pagination -->
    <!-- pagination -->
    <div
      class="flex flex-col sm:flex-row sm:justify-between sm:items-center mt-4 gap-2 sm:gap-0 text-sm sm:text-base"
    >
      <!-- จำนวนรายการ -->
      <span class="text-center sm:text-left text-xs">
        Showing {{ filteredOrders.length }} of {{ totalRows }} rows
      </span>

      <!-- ปุ่ม pagination -->
      <div class="flex justify-center sm:justify-end items-center space-x-2">
        <button
          :disabled="currentPage === 1"
          @click="goToPage(currentPage - 1)"
          class="px-3 py-1 bg-gray-200 text-ms rounded disabled:opacity-50"
        >
          Prev
        </button>

        <span class="mx-1">หน้า </span>
        <span class="mx-1"> {{ currentPage }} / {{ totalPages }}</span>

        <button
          :disabled="currentPage === totalPages"
          @click="goToPage(currentPage + 1)"
          class="px-3 py-1 bg-gray-200 text-ms rounded disabled:opacity-50"
        >
          Next
        </button>
      </div>
    </div>

    <!-- pagination -->
    <!-- <div class="flex justify-between items-center mt-4"> -->
    <!-- <span>Showing {{ saleOrders.length }} of {{ totalRows }} rows</span> -->
    <!-- <span>Showing {{ filteredOrders.length }} of {{ totalRows }} rows</span> -->
    <!-- Pagination UI -->
    <!-- คุณสามารถเพิ่ม Tailwind pagination component ที่นี่ -->
    <!-- </div> -->
  </div>
</template>

<script setup>
import { ref, onMounted, computed, watch, reactive } from "vue";
// , reactive
import axios from "axios";
// import { logActivity } from '@/services/activityLogger.js'
import Swal from "sweetalert2";
import {
  CheckCircleIcon,
  AlertTriangleIcon,
  AlertOctagonIcon,
  XOctagonIcon,
  BanIcon,
  HelpCircleIcon,
} from "lucide-vue-next";

// import { eventBus } from '@/utils/eventBus'

// import { Message } from 'tdesign-vue-next'

// const BASE_URL_LOCAL = import.meta.env.VITE_API_URL_LOCAL;

// const BASE_URL = import.meta.env.VITE_API_URL
const VITE_API_URL_C_SHARP = import.meta.env.VITE_API_URL_C_SHARP;
const BASE_URL_LOCAL = import.meta.env.VITE_API_URL_LOCAL;
const BASE_URL = import.meta.env.VITE_API_URL;

const tableWrapper = ref(null);
const noticeBox = ref(null);
const showNotice = ref(false);
const isScrolledRight = ref(false); // เก็บสถานะเลื่อนขวาหรือยัง
const showAnimatedButton = ref(false);

const saleOrders = ref([]);

const totalRows = ref(0);
const currentPage = ref(1);
const limit = 10;

const searchQuery = ref(""); // <- ช่องค้นหา
const isLoading = ref(false); // หรือ true ถ้าต้องการให้เริ่มต้นแสดง

const isAdmin = computed(() => localStorage.getItem("role_admin") === "true");
const isFa = computed(() => localStorage.getItem("role_fa") === "true");
const isCrm = computed(() => localStorage.getItem("role_crm") === "true");

const canApprove = computed(() => isFa.value || isAdmin.value);
// const canEdit = computed(() => isCrm.value || isAdmin.value);

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

// const getDisplayStatus = (status) => {
//   switch (status) {
//     case 'ตรวจสอบเรียบร้อย': return 'เกินกำหนดชำระไม่เกิน 30 วัน'; // เขียว
//     case 'รอตรวจสอบ': return 'เกินกำหนดชำระกิน 30 วัน'; // เหลือง
//     case 'การตรวจสอบล้มเหลว': return 'เกินกำหนดชำระ 120 วัน'; // แดง
//     case 'ยังไม่ได้ตรวจสอบ': return 'เกินกำหนดชำระ 180 วัน'; // ดำ
//     case 'ยกเลิกคำสั่งซื้อ': return 'ถูกยกเลิก';
//     default: return status;
//   }
// }

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

const filteredOrders = computed(() => {
  const raw = searchQuery.value.trim();
  if (!raw) return saleOrders.value;

  const keyword = raw.toLowerCase();
  const parts = keyword.split(/\s+/); // แยกด้วยช่องว่าง

  return saleOrders.value.filter((order) => {
    const saleNo = order.sale_no?.toLowerCase().trim() || "";
    const customerCode = order.customer_code?.toLowerCase().trim() || "";
    const shopName = order.shop_name?.toLowerCase().trim() || "";
    const employeeName = order.employee_name?.toLowerCase().trim() || "";
    const mobile = order.mobile?.toLowerCase().trim() || "";
    const employeeMobile = order.employee_mobile?.toLowerCase().trim() || "";
    const createdAt = order.created_at?.toLowerCase().trim() || "";

    // เงื่อนไข: ตรวจทีละ keyword
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
        createdAt.includes(part) // เผื่อ user พิมพ์ yyyy-mm-dd โดยตรง
      );
    });
  });
});

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

// ดึงข้อมูลหน้าปัจจุบัน
// async function fetchPage(page = 1) {
//   isLoading.value = true;
//   try {
//     // ${BASE_URL}
//     const res = await axios.get(
//       `${BASE_URL}/api_admin_dashboard/backend/api/list_sale_orders/get_list_sale_order.php?v=${Date.now()}`,
//       { params: { page, limit } }
//     );

//     console.log("Check Log res :", res);

//     if (res.data.success) {
//       // console.log('Check Log res.data :',res.data);
//       saleOrders.value = res.data.data.list_order.map((item) => ({
//         id: item.id,
//         sale_no: item.document_no,
//         customer_code: item.customer_code,
//         shop_name: item.full_name,
//         mobile: item.phone,
//         total_amount: item.final_total_price,
//         total_paid: item.final_total_price,
//         status: item.status,
//         created_at: item.created_at,
//         // ตัวอย่าง mock data
//         extra_details: item.extra_list || [
//           `รหัสสินค้า: ${item.id}-A`,
//           `ยอดคงเหลือ: ${item.final_total_price}`,
//           `หมายเหตุ: ${item.status}`,
//           // `หมายเหตุ: ตรวจสอบแล้ว`
//         ],
//       }));

//       console.log("Check Log saleOrders.value :", saleOrders.value);

//       totalRows.value = res.data.data.total;
//       currentPage.value = page;

//       // await logActivity(' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue');
//       // ✅ เรียกใช้ TypeCustomers หลังโหลดรายการเสร็จ
//       await TypeCustomers();
//     }
//   } catch (e) {
//     console.error(e);
//   } finally {
//     isLoading.value = false;
//   }
// }

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


async function fetchPage(page = 1) {
  isLoading.value = true;
  try {
    const res = await axios.get(
      `${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/list_sale_orders/get_list_sale_order.php?v=${Date.now()}`,
      {
        params: {
          page,
          limit,
          search: searchQuery.value.trim(),
        },
      }
    );

    console.log("Check Log res :", res);

    if (res.data.success) {
      saleOrders.value = res.data.data.list_order.map((item) => ({
        id: item.id,
        sale_no: item.document_no,
        customer_code: item.customer_code,
        shop_name: item.full_name,
        mobile: item.phone,
        total_amount: item.final_total_price,
        total_paid: item.final_total_price,
        status: item.status,
        created_at: item.created_at,
        employee_name: item.employee_name, //
        employee_phone: item.employee_phone, // ถ้าจะใช้
        extra_details: item.extra_list || [],
      }));

      totalRows.value = res.data.data.total;
      currentPage.value = page;

      // // คำนวณจำนวน Order ที่ยังไม่อนุมัติ
      // const pendingCount = saleOrders.value.filter(o => o.status !== 'ตรวจสอบเรียบร้อย').length;

      // // ส่งไปให้ Navbar ผ่าน eventBus
      // eventBus.emit('updateOrderNotification', pendingCount);

      // เรียกใช้ TypeCustomers หลังโหลดรายการเสร็จ
      await TypeCustomers();
       // เรียก API deBAdminCustomers สำหรับแต่ละ order

      // const customerCodes = saleOrders.value.map(o => o.customer_code);
      // await deBAdminCustomersBatch(customerCodes);

      isLoading.value = false;

    }
  } catch (e) {
    console.error(e);
  } finally {
    isLoading.value = false;
  }
}


// eslint-disable-next-line no-unused-vars
async function deBAdminCustomersBatch(customerCodes) {
  if (!customerCodes || customerCodes.length === 0) return;

  isLoading.value = true;

  try {
    const res = await axios.post(
      `${BASE_URL}/user/deBAdminCustomersBatch?v=${Date.now()}`,
      { customerCodes },
      { headers: { "Content-Type": "application/json" } }
    );

    if (res.data.success) {
      const admins = res.data.data2;

      // map ข้อมูลกลับไปยัง saleOrders
      admins.forEach((item) => {
        const order = saleOrders.value.find((o) => o.customer_code === item.customer_code);
        if (order) {
          order.employee_name = item.contact_person;
          order.employee_mobile = item.admin_mobile;
          // order.employee_name = item.nickname;
          // order.employee_mobile = item.mobile;
        }
      });

      console.log("Batch deBAdminCustomers:", admins);
    }
  } catch (e) {
    console.error(e);
  } finally {
    isLoading.value = false;
  }
}


// async function deBAdminCustomers(customer_code) {
//   isLoading.value = true;

//   // const customer_code = customer_code.value;

//   console.log("Check Log customer_code :", customer_code);

//   try {
//     const res = await axios.post(
//       `${BASE_URL}/user/deBAdminCustomers?v=${Date.now()}`,
//       {

//         customerCode: customer_code,

//       },
//       {
//         headers: {
//           "Content-Type": "application/json",
//         },
//       }
//       // {
//       //   params: {
//       //     // page,
//       //     customerCode: customer_code.value,
//       //   },
//       // }
//     );

//     console.log("Check Log deBAdminCustomer :", res);

//     if (res.data.success) {
//       const deBAdminCustomer = res.data.data2.map((item) => ({
//         // id: item.id,
//         employee_name: item.nickname,
//         mobile: item.mobile,
//         customer_code: item.customer_code

//       }));

//       deBAdminCustomer.map((item) => {
//         // หา order ที่ตรงกับ customer_code
//         const order = saleOrders.value.find((o) => o.customer_code === item.customer_code);
//         if (order) {
//           order.employee_name = item.employee_name;
//           order.employee_mobile = item.mobile;
//         }
//       });

//       console.log("Check Log deBAdminCustomer :", deBAdminCustomer);

//       // totalRows.value = res.data.data2.total;

//     }
//   } catch (e) {
//     console.error(e);
//   } finally {
//     isLoading.value = false;
//   }
// }

//
async function getTokenDebtStatusType() {
  isLoading.value = true;

  // const payload = {
  //   username: "DPower1",
  //   password: "1234"
  // }

  // console.log('Log payload: ', payload);

  try {
    const loginData = {
      username: "DPower1",
      password: "1234",
    };

    //fetch ใช้ await res.json() ในการรอค่าก่อนถ้าไม่ทำจะได้ Promise
    // const res = await fetch('https://203.154.60.148:58915/api/Users/Login', {
    //   method: 'POST',
    //   headers: {
    //     'Content-Type': 'application/json'
    //   },
    //   body: JSON.stringify(loginData),
    //   mode: 'cors'
    // });

    // const data = await res.json();.

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

      // บันทึกเข้า localStorage
      // localStorage.setItem("deBlimit_all", JSON.stringify(allLimits));

      // const storedLimits = JSON.parse(localStorage.getItem("deBlimit_all") || "[]");
      // console.log("💾 deBlimit ที่บันทึกไว้:", storedLimits);

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
  fetchPage(1);

});

onMounted(() => fetchPage(1));

const totalPages = computed(() => Math.ceil(totalRows.value / limit));

function goToPage(page) {
  if (page < 1 || page > totalPages.value) return;
  fetchPage(page);
}
</script>

<!-- <style>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.5s;
}
.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style> -->

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

<!-- <div v-for="(d, i) in filteredExtraDetails(order)" :key="i"
    class="flex flex-col bg-white shadow-sm rounded-lg p-4 border border-gray-200">

    <div class="text-sm text-gray-800">
      <div class="text-[13px]"><strong class="text-[13px]">Invoice No.:</strong> {{ d.miHvnos }}</div>
      <div class="text-[13px]"><strong class="text-[13px]">Due Date:</strong> {{ d.dueDate }}</div>
      <div class="text-[13px]"><strong class="text-[13px]">Overdue Days:</strong> {{ d.overdueDays }}
      </div>
      <div class="text-[13px]"><strong class="text-[13px]">Status:</strong> {{ d.status2 }}</div>
      <div class="text-[13px]"><strong class="text-[13px]">Amount Due:</strong> {{
        formatCurrency(d.inInvAmount) }}</div>
    </div>

  </div> -->

<!-- // saleOrders.value = saleOrders.value.map(order => {
      //   const deBcode = data.find(item => item.deBcode === order.customer_code)?.deBcode;
      //   console.log('Log Value deBcode:', deBcode, 'for order.CustomerCode:', order.CustomerCode);

      //   if (deBcode) {
      //     console.log(`พบ deBcode: ${deBcode} ตรงกับ CustomerCode: ${order.customer_code}`);
      //   } else {
      //     console.log(`ไม่พบ deBcode ตรงกับ CustomerCode: ${order.customer_code}`);
      //   }
      //   // จากนั้นทำงานตามปกติ
      //   const updates = grouped[order.sale_no];
      //   if (updates) {

      //     // ถ้า deBcode ตรงกับ customer_code ให้แสดง extra_details ปกติ
      //     // ถ้าไม่ตรง ให้ซ่อน (ตั้งเป็น array ว่าง)
      //     // const extraDetailsToShow = deBcode ? updates.extra_details : [];
      //     const extraDetailsToShow = deBcode === order.customer_code ? updates.extra_details : [];


      //     return {
      //       ...order,
      //       deBcreditTerm: updates.deBcreditTerm,
      //       deBlimit: updates.deBlimit,
      //       deBsalesP: updates.deBsalesP,
      //       status2: updates.status2,
      //       total_paid: updates.total_paid,
      //       extra_details: extraDetailsToShow  // ถ้าเจอ deBcode ให้ซ่อน extra_details
      //       // extra_details: deBcode ? updates.extra_details : []  // ถ้าเจอ deBcode ให้ซ่อน extra_details
      //       // extra_details: order.customer_code  === deBcode ? [] : updates.extra_details
      //     };
      //   }
      //   return order;

      // }) -->

<!--
 // const res = await axios.post(
    //   `${VITE_API_URL_C_SHARP}/api/TypeCustomers`, payload, {
    //   headers: {
    //     // 'Content-Type': 'application/x-www-form-urlencoded',
    //     'Content-Type': 'application/json', // ควรใช้ JSON ถ้า backend รองรับ
    //     'Authorization': `Bearer ${tokendebtStatusType}`
    //   }
    // });

    // const res = await fetch('https://203.154.60.148:58915/api/TypeCustomers', {
    //   method: 'POST',
    //   headers: {
    //     'Content-Type': 'application/json',
    //     'Authorization': `Bearer ${tokendebtStatusType}`
    //   },
    //   body: JSON.stringify(payload),
    //   mode: 'cors'
    // });

    // const data = await res.json();
    // console.log('✅ Response from TypeCustomers:', data);
 -->

<!-- // ถ้ามี response รูปแบบเฉพาะ เช่น success = true
    // if (data) {

    //   console.log("🎉 API success:", res.data);

    //   // return;
    //   saleOrders.value = res.data.map(item => ({

    //     // Header
    //     sale_no: item.customerDocument, //customerDocument
    //     customer_code: item.deBcode, // C04366
    //     shop_name: item.deBcontactT, // "คุณนรินทร์ โชยชัยสุนทร"
    //     deBcreditTerm: item.deBcreditTerm, // เครดิตจำนวนวันลูกค้า
    //     deBlimit: item.deBlimit, //วงเกินต้องไม่เกินที่กำหนด
    //     deBsalesP: item.deBsalesP // เพิ่มอีก colum รหัส sale
    //     total_paid: item.final_total_price,
    //     status: item.status2, // สถานะการตรวจสอบ
    //     created_at: item.created_at,
    //     // total_amount: item.final_total_price,

    //     // Detail
    //     extra_details: res.data.map(item => ({
    //       dueDate: item.dueDate, // กำหนดชำระ
    //       overdueDays: item.overdueDays,  //จำนวนวันที่ค้าง
    //       status2: item.status2, // สถานะลูกหนี้
    //       inInvAmount: item.inInvAmount, //ค้างชำระที่ยังไม่จ่าย
    //     }))

    //   })) -->

<!--
// filter ตามคำค้นหา
// const filteredOrders = computed(() => {
//   if (!searchQuery.value.trim()) return saleOrders.value

//   const keyword = searchQuery.value.toLowerCase()
//   return saleOrders.value.filter(order =>
//     order.sale_no?.toLowerCase().includes(keyword) ||
//     order.customer_code?.toLowerCase().includes(keyword) ||
//     order.shop_name?.toLowerCase().includes(keyword) ||
//     order.mobile?.toLowerCase().includes(keyword)
//   )
// }) -->

<!-- // const filteredOrders = computed(() => {
//   if (!searchQuery.value.trim()) return saleOrders.value
//   const kw = searchQuery.value.toLowerCase()
//   return saleOrders.value.filter(o =>
//     [o.sale_no, o.customer_code, o.shop_name, o.mobile, o.created_at]
//       .some(str => str.toLowerCase().includes(kw))
//   )
// }) -->

<!--
// onMounted(async () => {
//   try {

//     isLoading.value = true;

//     const response = await axios.get(`${BASE_URL}/api_admin_dashboard/backend/api/list_sale_orders/get_list_sale_order.php`)
//     console.log('Check log responseData:', response.data.data.list_order);

//     saleOrders.value = (response.data.data.list_order || []).map(item => ({
//       id: item.id,
//       sale_no: item.document_no,
//       customer_code: item.customer_code,
//       shop_name: item.full_name,
//       mobile: item.phone,
//       total_amount: item.final_total_price,
//       total_paid: item.final_total_price,
//       status: item.status,
//       created_at: item.created_at
//     }));

//     // saleOrders.value = response.data.data.list_order || []
//     totalRows.value = response.data.total || response.data.data.list_order.length

//     isLoading.value = false;
//   } catch (error) {
//     console.error('❌ Failed to load sale orders:', error)
//   }
// }); -->
