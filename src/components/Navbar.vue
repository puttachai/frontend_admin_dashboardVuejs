<template>
  <Disclosure as="nav" class="bg-gray-800 fixed top-0 left-0 w-full z-[60]" v-slot="{ open }">
    <div class="mx-auto max-w-7xl px-2 smls:px-6 lg:px-8">
      <div class="relative flex h-16 items-center justify-between">

        <!-- Hamburger Button -->
        <button @click="$emit('toggle-sidebar')" class="menu max-[431px]:block hidden smlsls:hidden text-white">
          <span class="material-icons text-3xl">menu</span>
        </button>

        <div class="Logomedia flex items-center relative">
          <router-link to="/createsalelist">
            <img class="h-8 w-auto" src="../assets/logo.svg" alt="My Project" />
          </router-link>

          <!-- ข้อความที่ขยับ -->
          <div class="ml-2 overflow-hidden text-white whitespace-nowrap max-w-[280px] hidden md:block message-slide"
            v-show="showSlidingMessage">
            Welcome to D-Power’s Admin Dashboard
          </div>
        </div>

        <!-- Title (ตรงกลาง) -->
        <div v-if="!contact" class="boxTitel absolute left-1/2 transform -translate-x-1/2">
          <router-link to="/createsalelist">
          <!-- <router-link to="/dashboard"> -->
            <h4 class="welcome font-semibold text-xl text-center">Welcome to the D-Power Sales Dashboard</h4>
          </router-link>
        </div>

        <!-- ไอคอนแจ้งเตือนและเมนูผู้ใช้ -->
        <div class="flex items-center space-x-4 relative">

          <!-- Notification Bell -->
          <div class="relative cursor-pointer" ref="bellRef" aria-haspopup="true"
            :aria-expanded="dropdownOpen.toString()">
            <!-- <span class="material-icons text-white text-3xl select-none" @click="toggleDropdown">notifications</span>
            <span v-if="orderStore.pendingCount > 0 || orderStore.pendingCountMessage > 0"
              class="absolute -top-1 -right-1 bg-red-600 text-white text-[8px] font-bold rounded-full w-5 h-5 flex items-center justify-center animate-pulse shadow-lg">
              New
            </span> -->
             <span class="material-icons text-white text-3xl select-none" @click="toggleDropdown">notifications</span>
            <!-- กรณีมีทั้งสองค่ามากกว่า 0 -->
              <template v-if="orderStore.pendingCount > 0 && orderStore.pendingCountMessage > 0">
                <span
                  v-show="showRed"
                  class="absolute -top-1 -right-1 bg-red-600 text-white text-[8px] font-bold rounded-full w-5 h-5 flex items-center justify-center animate-pulse shadow-lg">
                  {{ orderStore.pendingCount }}
                </span>
                <span
                  v-show="!showRed"
                  class="absolute -top-1 -right-1 bg-green-600 text-white text-[8px] font-bold rounded-full w-5 h-5 flex items-center justify-center animate-pulse shadow-lg">
                  {{ orderStore.pendingCountMessage }}
                </span>
              </template>

              <!-- กรณีมีแค่ pendingCount -->
              <span
                v-else-if="orderStore.pendingCount > 0"
                class="absolute -top-1 -right-1 bg-red-600 text-white text-[8px] font-bold rounded-full w-5 h-5 flex items-center justify-center animate-pulse shadow-lg">
                {{ orderStore.pendingCount }}
              </span>

              <!-- กรณีมีแค่ pendingCountMessage -->
              <span
                v-else-if="orderStore.pendingCountMessage > 0"
                class="absolute -top-1 -right-1 bg-green-600 text-white text-[8px] font-bold rounded-full w-5 h-5 flex items-center justify-center animate-pulse shadow-lg">
                {{ orderStore.pendingCountMessage }}
              </span>
            <!-- {{ orderStore.pendingCount }} -->


            <!-- :class="[
                  'absolute right-0 mt-3 w-[18rem] max-h-[20rem] bg-white rounded-lg shadow-lg z-50 flex flex-col',
                  contact ? 'ring-1 ring-black ring-opacity-5 left-1' : 'ring-1',
                    // กำหนด width แบบ responsive
                    'w-full max-w-xs sm:w-96'
                  ]" -->
            <!-- :class="[
                  'absolute right-0 mt-3 w-[24rem] max-h-[20rem] bg-white rounded-lg shadow-lg z-50 flex flex-col',
                  contact ? 'ring-1 ring-black ring-opacity-5 left-1' : 'ring-1',
                    // กำหนด width แบบ responsive
                    'w-full max-w-xs sm:w-96'
                  ]" > -->
            <!-- Dropdown Menu -->
            <!--  class="absolute right-0 mt-3 w-80 max-h-[24rem] bg-white rounded-lg shadow-lg ring-1 ring-black ring-opacity-5 z-50 flex flex-col"> -->
            <transition name="fade" appear>
              
              <div v-if="dropdownOpen" :class="[ //sm:w-96
                'absolute right-0 mt-3 w-[18rem] max-h-[20rem] bg-white rounded-lg max-w-xs md:w-96 mdl:w-96 lg:w-96 xs:left-[-2rem] sm:left-[-2rem] smls:left-[-2rem] sml:left-[-2rem] md:left-[-2rem] mdl:left-[-2rem] lg:left-[-2rem] lgl:left-[-2rem] xl:left-[-2rem] shadow-lg z-50 flex flex-col',
                contact ? 'ring-1 ring-black ring-opacity-5  ' : 'ring-1',
                // กำหนด width แบบ responsive
                'md:w-96 mdl:w-96 '
                // 'md:w-full'
              ]">

                <!-- Tabs -->
                <div class="flex border-b border-gray-200">
                  <!-- <button
                    :class="['flex-1 py-2 text-center font-medium text-sm', activeTab === 'status' ? 'border-b-2 border-blue-600 text-blue-600' : 'text-gray-600 hover:text-blue-600']"
                    @click="activeTab = 'status'">
                    ตรวจสอบสถานะอนุมัติ
                  </button>
                  <button
                    :class="['flex-1 py-2 text-center font-medium text-sm', activeTab === 'new' ? 'border-b-2 border-blue-600 text-blue-600' : 'text-gray-600 hover:text-blue-600']"
                    @click="activeTab = 'new'">
                    แจ้งเตือนรายการใหม่
                  </button> -->
                  <button
                    :class="['flex-1 py-2 text-center font-medium text-sm', activeTab === 'status' ? 'border-b-2 border-blue-600 text-blue-600' : 'text-gray-600 hover:text-blue-600']"
                    @click="activeTab = 'status'">
                    ตรวจสอบสถานะอนุมัติ
                    <span v-if="orderStore.pendingCount > 0"
                      class="ml-1 inline-block bg-red-600 text-white text-xs font-semibold rounded-full px-2 py-0.5 align-middle">
                      {{ orderStore.pendingCount }}
                    </span>
                  </button>
                  <button
                    :class="['flex-1 py-2 text-center font-medium text-sm pl-2', activeTab === 'new' ? 'border-b-2 border-blue-600 text-blue-600' : 'text-gray-600 hover:text-blue-600']"
                    @click="activeTab = 'new'">
                    แจ้งเตือนรายการใหม่
                    <span v-if="orderStore.pendingCountMessage > 0"
                      class="ml-1 inline-block bg-green-600 text-white text-xs font-semibold rounded-full px-2 py-0.5 align-middle">
                      {{ orderStore.pendingCountMessage }}
                    </span>
                  </button>
                </div>

                <!-- Tab Contents -->
                <div class="flex-1 overflow-y-auto p-3">
                  <!-- Tab 1: ตรวจสอบสถานะอนุมัติ -->
                  <div v-if="activeTab === 'status'">

                    <input v-model="searchQuery" type="text" placeholder="ค้นหาสถานะอนุมัติ"
                      class="w-full mb-2 px-3 py-2 border rounded focus:outline-none focus:ring focus:ring-blue-300" />
                    
                    <ul>
                      <li v-for="order in paginatedOrders" :key="order.document_no"
                          class="flex flex-col gap-1 px-2 py-2 border-b last:border-b-0 cursor-pointer hover:bg-gray-50"
                          @click="handleOrderClick(order.document_no)">
                          
                          <div class="flex items-center gap-2">
                            <span class="material-icons text-yellow-500 select-none" title="แจ้งเตือนรายการ">notifications_active</span>
                            <div class="flex-1 max-w-full">
                              <!-- แสดง document_no -->
                              <p class="font-medium text-sm break-all">{{ order.document_no }}</p>
                              <!-- <p class="font-medium text-sm truncate">{{ order.document_no }}</p> -->
                              <!-- แสดง account, saleNo, nicknameAdmin -->
                              <p class="text-xs text-gray-500 break-words">
                              <!-- <p class="text-xs text-gray-500 truncate"> -->
                                Account: {{ order.account_user }} | Sale No: {{ order.sale_no }} | Admin: {{ order.nickname_admin }}
                              </p>
                              <span class="text-xs text-gray-400 whitespace-nowrap">{{ formatDate(order.created_at) }}</span>
                            </div>
                            
                          </div>
                          
                          <!-- สถานะ order -->
                          <p class="text-xs text-gray-500 mt-1">{{ order.status }}</p>
                      </li>
                    </ul>

                      <!-- <ul>
                      <li v-for="order in paginatedOrders" :key="order.document_no"
                        class="flex items-center gap-2 px-2 py-2 border-b last:border-b-0 cursor-pointer hover:bg-gray-50"
                        @click="handleOrderClick(order.document_no)">
                        <span class="material-icons text-yellow-500 select-none"
                          title="แจ้งเตือนรายการสถานะที่ยังไม่อนุมัติใหม่">notifications_active</span>
                        <div class="flex-1 ">
                          <p class="font-medium text-sm truncate">{{ order.document_no }}</p>
                          <p class="text-xs text-gray-500 truncate">{{ order.status }}</p>
                        </div>
                        <span class="text-xs text-gray-400 whitespace-nowrap">{{ formatDate(order.created_at) }}</span>
                      </li>
                    </ul> -->
                    <div v-if="paginatedOrders.length === 0" class="text-center text-gray-400 mt-4">
                      ไม่มีรายการแจ้งเตือนสถานะยังไม่อนุมัติใหม่
                    </div>

                    <!-- Pagination -->
                    <div v-if="totalPages > 1" class="flex justify-center items-center gap-2 py-2 border-t mt-2">
                      <button @click="prevPage" :disabled="currentPage === 1"
                        class="px-2 py-1 text-xs rounded border hover:bg-gray-100 disabled:opacity-50">ก่อนหน้า</button>
                      <span class="text-xs">หน้า {{ currentPage }} / {{ totalPages }}</span>
                      <button @click="nextPage" :disabled="currentPage === totalPages"
                        class="px-2 py-1 text-xs rounded border hover:bg-gray-100 disabled:opacity-50">ถัดไป</button>
                    </div>

                    <!-- <input
                      v-model="searchQuery"
                      @keyup.enter="searchDocument"
                      type="text"
                      placeholder="กรอก Document No เพื่อเช็คสถานะ"
                      class="w-full mb-3 px-3 py-2 border rounded focus:outline-none focus:ring focus:ring-blue-300"
                    />
                    <button
                      @click="searchDocument"
                      class="w-full bg-blue-600 text-white py-2 rounded hover:bg-blue-700 transition">
                      ค้นหา
                    </button>

                    <div v-if="loadingStatus" class="mt-3 text-center text-gray-500">กำลังค้นหา...</div>

                    <div v-if="statusResult" class="mt-3">
                      <p><strong>Document No:</strong> {{ statusResult.document_no }}</p>
                      <p><strong>สถานะ:</strong> {{ statusResult.status }}</p>
                      <p><strong>อนุมัติแล้ว:</strong> {{ statusResult.is_approved ? 'ใช่' : 'ยังไม่อนุมัติ' }}</p>
                    </div>

                    <div v-if="errorStatus" class="mt-3 text-red-600">{{ errorStatus }}</div> -->
                  </div>

                  <!-- Tab 2: แจ้งเตือนรายการใหม่ -->
                  <div v-if="activeTab === 'new'">
                    <input v-model="searchQuery" type="text" placeholder="ค้นหาแจ้งเตือน"
                      class="w-full mb-2 px-3 py-2 border rounded focus:outline-none focus:ring focus:ring-blue-300" />
                    <!-- <ul>
                      <li v-for="order in paginatedOrdersMessage" :key="order.document_no"
                        @click="handleOrderClick(order.document_no)" :class="[
                          'flex items-center gap-2 px-2 py-2 border-b last:border-b-0 cursor-pointer hover:bg-gray-50',
                          order.is_read === 1 ? 'opacity-50 cursor-default' : 'opacity-100'
                        ]">
                        <span class="material-icons text-yellow-500 select-none" title="แจ้งเตือนรายการใหม่">
                          notifications_active
                        </span>
                        <div class="flex-1">
                          <p class="font-medium text-sm truncate">{{ order.document_no }}</p>
                          <p class="text-xs truncate text-gray-500">
                            {{ order.is_read === 1 ? 'อ่านแล้ว' : 'ยังไม่อ่าน' }}
                          </p>
                        </div>
                        <span class="text-xs text-gray-400 whitespace-nowrap">
                          {{ formatDate(order.created_at) }}
                        </span>
                      </li>
                    </ul> -->

                    <ul>
                      <li v-for="order in paginatedOrdersMessage" :key="order.document_no"
                        @click="handleOrderClick(order.document_no)" :class="[
                          'flex items-center gap-2 px-2 py-2 border-b last:border-b-0 cursor-pointer hover:bg-gray-50',
                          order.is_read === 1 ? 'opacity-50 cursor-default' : 'opacity-100'
                        ]">
                          
                          <div class="flex items-center gap-2">
                            <span class="material-icons text-yellow-500 select-none" title="แจ้งเตือนรายการใหม่">notifications_active</span>
                            <div class="flex-1 max-w-full">
                              <!-- แสดง document_no -->
                               <p class="font-medium text-sm truncate">{{ order.document_no }}</p>
                               <p class="text-xs truncate text-gray-500">
                                {{ order.is_read === 1 ? 'อ่านแล้ว' : 'ยังไม่อ่าน' }}
                              </p>
                              <!-- แสดง account, saleNo, nicknameAdmin -->
                              <p class="text-xs text-gray-500 break-words">
                              <!-- <p class="text-xs text-gray-500 truncate"> -->
                                Account: {{ order.account_user }} | Sale No: {{ order.sale_no }} | Admin: {{ order.nickname_admin }}
                              </p>
                              <span class="text-xs text-gray-400 whitespace-nowrap">{{ formatDate(order.created_at) }}</span>
                              <!-- สถานะ order -->
                              <p class="text-xs text-gray-500 mt-1">{{ order.status }}</p>
                            </div>
                            
                          </div>
                          
                          <!-- สถานะ order -->
                          <!-- <p class="text-xs text-gray-500 mt-1">{{ order.status }}</p> -->
                      </li>
                    </ul>

                    <div v-if="paginatedOrdersMessage.length === 0" class="text-center text-gray-400 mt-4">
                      ไม่มีรายการแจ้งเตือนใหม่
                    </div>

                    <!-- Pagination -->
                    <div v-if="totalPagesMessage > 1" class="flex justify-center items-center gap-2 py-2 border-t mt-2">
                      <button @click="prevPage" :disabled="currentPage === 1"
                        class="px-2 py-1 text-xs rounded border hover:bg-gray-100 disabled:opacity-50">ก่อนหน้า</button>
                      <span class="text-xs">หน้า {{ currentPage }} / {{ totalPagesMessage }}</span>
                      <button @click="nextPage" :disabled="currentPage === totalPagesMessage"
                        class="px-2 py-1 text-xs rounded border hover:bg-gray-100 disabled:opacity-50">ถัดไป</button>
                    </div>
                  </div>
                </div>

              </div>
            </transition>
          </div>

          <!-- User Profile -->
          <Menu as="div" class="relative ml-3">
            <MenuButton
              class="flex items-center gap-2 rounded-full bg-gray-700 px-3 py-1 text-white hover:bg-gray-600 focus:outline-none focus:ring-2 focus:ring-white">
              <span class="sr-only">Open user menu</span>
              <span class="truncate xs:text-xs sm:text-smls md:text-[14px] smls:max-w-[350px] sm:max-w-[230px]">{{
                contact }} {{ account }}</span>
              <template v-if="image_path">
                <img class="w-8 h-8 rounded-full object-cover" :src="image_path" alt="User Avatar" />
              </template>
              <template v-else>
                <span class="material-icons text-white text-3xl">account_circle</span>
              </template>
            </MenuButton>

            <!-- User Dropdown Menu -->
            <transition enter-active-class="transition ease-out duration-100"
              enter-from-class="transform opacity-0 scale-95" enter-to-class="transform opacity-100 scale-100"
              leave-active-class="transition ease-in duration-75" leave-from-class="transform opacity-100 scale-100"
              leave-to-class="transform opacity-0 scale-95">
              <MenuItems
                class="absolute right-0 mt-2 w-48 origin-top-right rounded-md bg-white py-1 shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none">
                <MenuItem v-slot="{ active }">
                <a href="/about"
                  :class="[active ? 'bg-gray-100' : '', 'block px-4 py-2 text-sm text-gray-700 cursor-pointer']">
                  About
                </a>
                </MenuItem>
                <MenuItem v-slot="{ active }">
                <a href="#" @click="confirmLogoutEmployee"
                  :class="[active ? 'bg-gray-100' : '', 'block px-4 py-2 text-sm text-gray-700 cursor-pointer']">
                  Sign out
                </a>
                </MenuItem>
              </MenuItems>
            </transition>
          </Menu>
        </div>
      </div>
    </div>

    <!-- Mobile Menu Items -->
    <DisclosurePanel class="smlsls:hidden">
      <div class="space-y-1 px-2 pt-2 pb-3">
        <!-- Add navigation items here if needed -->
      </div>
    </DisclosurePanel>
  </Disclosure>
</template>

<script>
import Swal from 'sweetalert2'
import { ref, onMounted, onBeforeUnmount, nextTick, watch, computed } from 'vue'
import { useRouter } from 'vue-router'
import { eventBus } from '@/utils/eventBus'
import { useI18n } from 'vue-i18n'
import { useOrderStore } from '@/stores/orderStore'

import {
  Disclosure,
  DisclosurePanel,
  Menu,
  MenuButton,
  MenuItem,
  MenuItems,
} from '@headlessui/vue'

export default {
  emits: ['toggle-sidebar'],
  components: {
    Disclosure,
    DisclosurePanel,
    Menu,
    MenuButton,
    MenuItem,
    MenuItems,
  },
  setup() {
    const orderStore = useOrderStore()
    const dropdownOpen = ref(false)
    const bellRef = ref(null)
    const router = useRouter()
    const account = ref('')
    const contact = ref('')

    const image_path = ref('')
    const { t, locale } = useI18n()

    const showSlidingMessage = ref(true)
    const searchQuery = ref('')
    const currentPage = ref(1)
    const itemsPerPage = 6
    const activeTab = ref('status')

    const loadingStatus = ref(false)
    const statusResult = ref(null)
    const errorStatus = ref(null)

    const showRed = ref(true)
    let intervalId = null


    // ฟังก์ชันค้นหา Document status (ตัวอย่างสมมติ)
    async function searchDocument() {
      if (!searchQuery.value.trim()) return
      loadingStatus.value = true
      errorStatus.value = null
      statusResult.value = null
      try {
        // ตัวอย่างเรียก API, ให้แก้ URL ตามจริง
        const BASE_URL_LOCAL = import.meta.env.VITE_API_URL_LOCAL
        const res = await fetch(`${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/get_list_sale_order.php?document_no=${encodeURIComponent(searchQuery.value.trim())}`)
        const data = await res.json()
        if (data.success) {
          statusResult.value = data.result
        } else {
          errorStatus.value = data.message || 'ไม่พบข้อมูลสถานะ'
        }
      } catch (e) {
        errorStatus.value = 'เกิดข้อผิดพลาดในการค้นหา'
      } finally {
        loadingStatus.value = false
      }
    }

    // กรองข้อมูลจาก store ตาม searchQuery
    const filteredOrders = computed(() => {
      if (!searchQuery.value) return orderStore.pendingOrders
      return orderStore.pendingOrders.filter(order =>
        (order.document_no || '').toLowerCase().includes(searchQuery.value.toLowerCase()) ||
        (order.id ? order.id.toString() : '').includes(searchQuery.value) ||
        (order.phone ? order.phone.toString() : '').includes(searchQuery.value) ||
        (order.full_name || '').toLowerCase().includes(searchQuery.value.toLowerCase())
      )
    })

    // filteredOrdersMessage สำหรับ Tab แจ้งเตือนรายการใหม่
    const filteredOrdersMessage = computed(() => {
      if (!searchQuery.value) return orderStore.pendingOrdersMessage
      return orderStore.pendingOrdersMessage.filter(order =>
        (order.document_no || '').toLowerCase().includes(searchQuery.value.toLowerCase()) ||
        (order.id ? order.id.toString() : '').includes(searchQuery.value) ||
        (order.phone ? order.phone.toString() : '').includes(searchQuery.value) ||
        (order.full_name || '').toLowerCase().includes(searchQuery.value.toLowerCase())
      )
    })

    // slice ตามหน้าปัจจุบัน
    const paginatedOrders = computed(() => {
      const start = (currentPage.value - 1) * itemsPerPage
      return filteredOrders.value.slice(start, start + itemsPerPage)
    })

    // paginatedOrdersMessage สำหรับ Tab แจ้งเตือนรายการใหม่
    const paginatedOrdersMessage = computed(() => {
      const start = (currentPage.value - 1) * itemsPerPage
      return filteredOrdersMessage.value.slice(start, start + itemsPerPage)
    })

    // จำนวนหน้าทั้งหมด
    const totalPages = computed(() => Math.ceil(filteredOrders.value.length / itemsPerPage))

    // totalPagesMessage สำหรับ Tab แจ้งเตือนรายการใหม่
    const totalPagesMessage = computed(() => Math.ceil(filteredOrdersMessage.value.length / itemsPerPage))

    // เปลี่ยนหน้า
    // function nextPage() {
    //   if (currentPage.value < totalPages.value) currentPage.value++
    // }
    // function prevPage() {
    //   if (currentPage.value > 1) currentPage.value--
    // }

    // ปรับฟังก์ชันเปลี่ยนหน้าให้รองรับทั้ง 2 Tab
    function nextPage() {
      if (activeTab.value === 'status') {
        if (currentPage.value < totalPages.value) currentPage.value++
      } else {
        if (currentPage.value < totalPagesMessage.value) currentPage.value++
      }
    }
    function prevPage() {
      if (activeTab.value === 'status') {
        if (currentPage.value > 1) currentPage.value--
      } else {
        if (currentPage.value > 1) currentPage.value--
      }
    }

    // reset หน้าเมื่อค้นหา
    watch(searchQuery, () => {
      currentPage.value = 1
    })

    function toggleDropdown() {
      dropdownOpen.value = !dropdownOpen.value
    }

    // ปิด dropdown หากคลิกนอกกล่อง
    function onClickOutside(event) {
      if (bellRef.value && !bellRef.value.contains(event.target)) {
        dropdownOpen.value = false
      }
    }

    function formatDate(dateStr) {
      if (!dateStr) return ''
      const d = new Date(dateStr)
      return d.toLocaleDateString('th-TH', { year: 'numeric', month: 'short', day: 'numeric', hour: '2-digit', minute: '2-digit' })
    }

    // ไปหน้ารายละเอียดคำสั่งซื้อและทำเครื่องหมายว่าอ่านแล้ว
    async function handleOrderClick(document_no) {
      console.log('check document_no :', document_no);
      await orderStore.markAsRead(document_no)
      dropdownOpen.value = false
      router.push(`/sale-order/${document_no}`)
    }

    const loadUserData = () => {
      account.value = localStorage.getItem('account') || ''
      try {
        contact.value = JSON.parse(localStorage.getItem('selectDataCustomer'))?.data2.contact || ''
      } catch {
        contact.value = ''
      }
      image_path.value = localStorage.getItem('image_path') || ''
    }

      // watch เฝ้าดู pendingCount และ pendingCountMessage
  watch(
    () => [orderStore.pendingCount, orderStore.pendingCountMessage],
    ([pendingCount, pendingCountMessage]) => {
      if (intervalId) {
        clearInterval(intervalId)
        intervalId = null
      }

      if (pendingCount > 0 && pendingCountMessage > 0) {
        // ถ้ามีค่าทั้งคู่ สลับ showRed ทุก 800ms
        intervalId = setInterval(() => {
          showRed.value = !showRed.value
        }, 2000)
      } else {
        // ถ้าไม่มีทั้งคู่ หรือมีแค่ค่าเดียว แสดง badge สีแดง (showRed = true)
        showRed.value = true
      }
    },
    { immediate: true }  // ให้ run ตอนเริ่มต้นด้วย
  )

  onBeforeUnmount(() => {
    if (intervalId) clearInterval(intervalId)
  })


    onMounted(async () => {
      orderStore.fetchPendingOrders()
      document.addEventListener('click', onClickOutside)
      loadUserData()
      eventBus.on('customerChanged', loadUserData)

      const interval = setInterval(() => {
        orderStore.fetchPendingOrders()
      }, 5000)

          // ถ้ามีทั้งสองค่า ให้สลับทุก 800ms
        // if (orderStore.pendingCount > 0 && orderStore.pendingCountMessage > 0) {
        //   intervalId = setInterval(() => {
        //     showRed.value = !showRed.value
        //   }, 800)
        // } else {
        //   showRed.value = true
        // }

      onBeforeUnmount(() => {
        // clearInterval(intervalId)
        clearInterval(interval)
        document.removeEventListener('click', onClickOutside)
        eventBus.off('customerChanged', loadUserData)
      })
    })

    // onMounted(() => {
    //     // ถ้ามีทั้งสองค่า ให้สลับทุก 800ms
    //     if (orderStore.pendingCount > 0 && orderStore.pendingCountMessage > 0) {
    //       intervalId = setInterval(() => {
    //         showRed.value = !showRed.value
    //       }, 800)
    //     } else {
    //       showRed.value = true
    //     }
    //   })

    //   onBeforeUnmount(() => {
    //     clearInterval(intervalId)
    //   })


    // ฟังก์ชัน logout
    const confirmLogoutEmployee = async () => {
      const result = await Swal.fire({
        title: 'ยืนยันการออกจากระบบ',
        text: 'คุณต้องการออกจากระบบจริงหรือไม่?',
        icon: 'question',
        showCancelButton: true,
        confirmButtonText: 'ใช่, ออกเลย',
        cancelButtonText: 'ยกเลิก',
      })

      if (result.isConfirmed) {
        try {
          localStorage.clear() //เครียร์ storage ทั้งหมด
          router.push('/')
        } catch (error) {
          console.error('Error Delete employees:', error)
          Swal.fire('เกิดข้อผิดพลาด', 'ไม่สามารถออกจากระบบได้', 'error')
        }
      } else {
        console.log('ยกเลิกการออกจากระบบ')
      }
    }

    return {
      account,
      contact,
      image_path,
      confirmLogoutEmployee,
      t,
      locale,
      showSlidingMessage,
      orderStore,
      dropdownOpen,
      bellRef,
      toggleDropdown,
      searchQuery,
      currentPage,
      totalPages,
      totalPagesMessage,
      filteredOrders,
      paginatedOrders,
      nextPage,
      prevPage,
      goToOrder: handleOrderClick,
      activeTab,
      loadingStatus,
      statusResult,
      errorStatus,
      searchDocument,
      formatDate,
      handleOrderClick,
      paginatedOrdersMessage,
      showRed
    }
  }
}
</script>



<style scoped>
ul::-webkit-scrollbar {
  width: 6px;
}

ul::-webkit-scrollbar-thumb {
  background-color: rgba(0, 0, 0, 0.2);
  border-radius: 3px;
}

.boxTitel {

  h4 {
    font-size: 1.5rem;

    @media (max-width:768px) {

      font-size: 1rem;

    }

  }
}

/* ยกเลิก scoped ถ้า style ไม่ถูก injected ให้ใช้ global */
#google_translate_element {
  position: absolute;
  top: 100%;
  right: 0;
  background-color: white;
  border-radius: 8px;
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
  min-width: 180px;
  z-index: 9999;
  padding: 10px;
  font-family: 'Segoe UI', sans-serif;
}

/* ปรับขนาด dropdown ให้ดูสวย */
.goog-te-combo {
  width: 100%;
  padding: 6px 10px;
  font-size: 14px;
  border-radius: 6px;
  border: 1px solid #ccc;
  cursor: pointer;
  outline: none;
  appearance: none;
  background-color: #f9f9f9;
}

/* ซ่อนโลโก้ Google และ branding ด้านล่าง */
.goog-logo-link,
.goog-te-banner-frame.skiptranslate {
  display: none !important;
}

/* ซ่อนข้อความ “Powered by” */
.goog-te-gadget span,
.goog-te-gadget-simple span {
  display: none;
}

/* ปิดพื้นหลัง iframe ที่อาจล้น */
body>.skiptranslate {
  display: none !important;
}


@media (max-width: 431px) {
  .boxTitel {
    display: none;
  }

  .Logomedia {
    flex: 1;
    justify-content: center;
    display: none;
    /* ✅ ซ่อนโลโก้เมื่อหน้าจอเล็ก */
  }


}

@media (max-width: 820px) {
  /* @media (max-width: 680px) { */

  .welcome,
  .boxTitel {
    display: none;
  }
}


/*  */
@keyframes slideInOut {
  0% {
    transform: translateX(-10%);
    opacity: 0;
  }

  33.33% {
    transform: translateX(-10%);
    opacity: 0;
  }

  40% {
    transform: translateX(0);
    opacity: 1;
  }

  90% {
    transform: translateX(0);
    opacity: 1;
  }

  100% {
    transform: translateX(-10%);
    opacity: 0;
  }
}

.message-slide {
  animation: slideInOut 15s ease-in-out infinite;
}

/* ใช้ได้ */
/* @keyframes slideInOut {
  0% {
    transform: translateX(-10%);
    opacity: 0;
  }
  10% {
    transform: translateX(0);
    opacity: 1;
  }
  90% {
    transform: translateX(0);
    opacity: 1;
  }
  100% {
    transform: translateX(-10%);
    opacity: 0;
  }
}

.message-slide {
  animation: slideInOut 10s ease-in-out infinite;
} */

/* ซ่อนข้อความถ้าหน้าจอ <= 480px */
@media (max-width: 480px) {
  .message-slide {
    display: none !important;
  }
}
</style>

<!-- 
/* .Logomedia {
  position: relative;
}

.Logomedia img {
  position: relative;
  z-index: 1;
}

@media (max-width: 639px) {
  .Logomedia img {
    position: absolute;
    top: 0;
    left: 0;
    opacity: 0.7; 
    transform: scale(0.9);
    z-index: 2;
  }
} */ -->


<!-- Mobile Menu Button (ซ้ายสุด) -->
<!-- <div class="absolute inset-y-0 left-0 flex items-center smls:hidden">
            <DisclosureButton
              class="relative inline-flex items-center justify-center rounded-md p-2 text-gray-400 hover:bg-gray-700 hover:text-white focus:ring-2 focus:ring-white focus:outline-hidden focus:ring-inset"
            >
              <span class="absolute -inset-0.5" />
              <span class="sr-only">Open main menu</span>
              <Bars3Icon v-if="!open" class="block size-6" aria-hidden="true" />
              <XMarkIcon v-else class="block size-6" aria-hidden="true" />
            </DisclosureButton>
          </div> -->


<!-- Logo (ด้านซ้าย) src="https://tailwindcss.com/plus-assets/img/logos/mark.svg?color=indigo&shade=500" file:///D:/Users/first/Downloads/White and Black Minimal Bold Real Estate Brand Logo (2).png -->
<!-- <div class="Logomedia flex items-center">
          <router-link to="/dashboard">
            <img class="h-8 w-auto" src="../assets/logo.svg" alt="My Project" />
          </router-link>
        </div>
         -->

<!-- <div id="google_translate_element"></div> -->

<!-- ยังไม่ใช้ -->
<!-- ปุ่มไอคอน Google Translate -->
<!-- <button @click="toggleTranslate" class="text-white ml-4 hover:text-yellow-300" title="Translate">
                  <span class="material-icons text-[28px]">translate</span>
                </button> -->

<!-- กล่องแสดง Google Translate (แสดง/ซ่อน) -->
<!-- <div id="google_translate_element" v-show="showTranslate"
                  class="absolute top-12  z-[9999] bg-white p-2 rounded shadow"></div>
              </div> -->


<!-- <div>
                <MenuButton
                  class="relative flex rounded-full bg-gray-800 text-smls focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-gray-800 focus:outline-hidden"
                >
                  <span class="absolute -inset-1.5" />
                  <span class="sr-only">Open user menu</span>
                  <img
                    class="size-8 rounded-full"
                    :src="image_path"
                    alt="User Avatar"
                  />
                </MenuButton>
              </div> -->