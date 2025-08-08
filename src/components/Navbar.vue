<template>
  <Disclosure as="nav" class="bg-gray-800 fixed top-0 left-0 w-full z-[60]" v-slot="{ open }">
    <div class="mx-auto max-w-7xl px-2 smls:px-6 lg:px-8">
      <div class="relative flex h-16  items-center justify-between">

        <!--  -->

        <!-- Hamburger Button -->
        <button @click="$emit('toggle-sidebar')" class="menu max-[431px]:block hidden smlsls:hidden text-white">
          <span class="material-icons text-3xl">menu</span>
        </button>

        <div class="Logomedia flex items-center relative">
          <router-link to="/dashboard">
            <img class="h-8 w-auto" src="../assets/logo.svg" alt="My Project" />
          </router-link>

          <!-- ข้อความที่ขยับ -->
          <div class="ml-2 overflow-hidden text-white whitespace-nowrap max-w-[280px] hidden md:block message-slide"
            v-show="showSlidingMessage">
            Welcome to D-Power’s Admin Dashboard
          </div>
          <!-- <div class="ml-2 overflow-hidden text-white whitespace-nowrap max-w-[220px] hidden md:block message-slide"
            v-show="showSlidingMessage">
            Welcome to Admin Dashboard!
          </div> -->
        </div>

        <!-- Title (ตรงกลาง) -->
        <div v-if="!contact" class="boxTitel absolute left-1/2 transform -translate-x-1/2">
          <router-link to="/dashboard">
            <h4 class="welcome font-semibold text-xl text-center">Welcome to the D-Power Sales Dashboard</h4>
            <!-- <h4 class="welcome font-semibold text-xl text-center">The Welcome to Admin Dashboard</h4> -->
          </router-link>
        </div>

        <!-- ไอคอนแจ้งเตือนและเมนูผู้ใช้ -->
        <div class="flex items-center space-x-4 relative">

          <!-- Notification Bell -->
          <div class="relative cursor-pointer" @click="toggleDropdown" ref="bellRef" aria-haspopup="true"
            aria-expanded="dropdownOpen">
            <span class="material-icons text-white text-3xl select-none">notifications</span>
            <span v-if="orderStore.pendingCount > 0"
              class="absolute -top-1 -right-1 bg-red-600 text-white text-xs font-bold rounded-full w-5 h-5 flex items-center justify-center animate-pulse shadow-lg">
              {{ orderStore.pendingCount }}
            </span>
            <!-- Dropdown รายการแจ้งเตือน -->
            <transition name="fade" appear>
              <!-- <div v-if="!contact"> -->
                <!--   class="absolute right-0 mt-3 w-[24rem] max-h-[20rem] bg-white rounded-lg shadow-lg ring-1 ring-black ring-opacity-5 z-50 flex flex-col" -->
                <div v-if="dropdownOpen"
                :class="[
                  'absolute right-0 mt-3 w-[24rem] max-h-[20rem] bg-white rounded-lg shadow-lg z-50 flex flex-col',
                  contact ? 'ring-1 ring-black ring-opacity-5 left-1' : 'ring-1',
                    // กำหนด width แบบ responsive
                    'w-full max-w-xs sm:w-96'
                  ]"
                  style="top: 100%;" >
                  <!-- Search -->
                  <div class="p-3 border-b">
                    <div class="flex justify-between items-center mb-1">
                      <h3 class="text-base font-semibold text-gray-900">Notifications</h3>
                      <button @click="markAllRead" class="text-xs text-blue-600 hover:underline focus:outline-none"
                        title="Mark all as read">
                        <!-- ทำเครื่องหมายว่าอ่านแล้ว -->
                      </button>
                    </div>
                    <input @click.stop v-model="searchQuery" type="text" placeholder="ค้นหา Document No หรือ Order ID"
                      class="w-full border rounded-lg px-2 py-1 text-xs focus:outline-none focus:ring focus:border-blue-300" />
                  </div>

                  <!-- List -->
                  <ul class="overflow-y-auto flex-1">
                    <li v-for="(order, index) in paginatedOrders" :key="order.document_no"
                      class="flex items-start gap-2 px-3 py-2 border-b last:border-b-0 hover:bg-gray-50 cursor-pointer">
                      <!-- ไอคอน -->
                      <div class="flex-shrink-0">
                        <div
                          class="w-8 h-8 rounded-full bg-gradient-to-br from-yellow-400 via-yellow-300 to-yellow-500 flex items-center justify-center shadow-md">
                          <span class="material-icons text-white text-lg select-none">notifications_active</span>
                        </div>
                      </div>

                      <!-- เนื้อหา -->
                      <router-link :to="`/sale-order/${order.document_no}`"
                        class="flex-1 text-gray-800 hover:text-blue-600 truncate " title="ดูรายละเอียด">
                        <p class="font-medium text-sm truncate">{{ order.document_no }}</p>
                        <p class="text-xs text-gray-500 truncate">{{ order.status }}</p>
                      </router-link>

                      <!-- เวลา -->
                      <span class="text-[10px] text-gray-400 ml-1 whitespace-nowrap">2 days ago</span>
                    </li>

                    <li v-if="filteredOrders.length === 0" class="text-center py-3 text-gray-400 text-xs">
                      ไม่มีการแจ้งเตือนใหม่
                    </li>
                  </ul>

                  <!-- Pagination -->
                  <div v-if="totalPages > 1" class="flex justify-center items-center gap-2 py-2 border-t">
                    <button @click.stop="prevPage" :disabled="currentPage === 1"
                      class="px-2 py-1 text-xs rounded border hover:bg-gray-100 disabled:opacity-50">
                      ก่อนหน้า
                    </button>
                    <span class="text-xs">หน้า {{ currentPage }} / {{ totalPages }}</span>
                    <button @click.stop="nextPage" :disabled="currentPage === totalPages"
                      class="px-2 py-1 text-xs rounded border hover:bg-gray-100 disabled:opacity-50">
                      ถัดไป
                    </button>
                  </div>
                <!-- </div> -->
              </div>

            </transition>

          </div>

          <!-- User Profile (ตัวอย่างไม่แก้ไข) -->
          <Menu as="div" class="relative ml-3">
            <MenuButton
              class="flex items-center gap-2 rounded-full bg-gray-700 px-3 py-1 text-white hover:bg-gray-600 focus:outline-none focus:ring-2 focus:ring-white">
              <span class="sr-only">Open user menu</span>
              <span class="truncate smls:max-w-[350px] sm:max-w-[230px]">{{ contact }} {{ account }}</span>
              <!-- <span class="truncate max-w-[250px]">{{ contact }} {{ account }}</span> -->
              <template v-if="image_path">
                <img class="w-8 h-8 rounded-full object-cover" :src="image_path" alt="User Avatar" />
              </template>
              <template v-else>
                <span class="material-icons text-white text-3xl">account_circle</span>
              </template>
            </MenuButton>

            <!-- เมนู Dropdown User -->
            <transition enter-active-class="transition ease-out duration-100"
              enter-from-class="transform opacity-0 scale-95" enter-to-class="transform opacity-100 scale-100"
              leave-active-class="transition ease-in duration-75" leave-from-class="transform opacity-100 scale-100"
              leave-to-class="transform opacity-0 scale-95">
              <MenuItems
                class="absolute right-0 mt-2 w-48 origin-top-right rounded-md bg-white py-1 shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none">
                <MenuItem v-slot="{ active }">
                <a href="/about" :class="[
                  active ? 'bg-gray-100' : '',
                  'block px-4 py-2 text-sm text-gray-700 cursor-pointer'
                ]">
                  About
                </a>
                </MenuItem>
                <MenuItem v-slot="{ active }">
                <a href="#" @click="confirmLogoutEmployee" :class="[
                  active ? 'bg-gray-100' : '',
                  'block px-4 py-2 text-sm text-gray-700 cursor-pointer'
                ]">
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
import { ref, onMounted, createApp, onBeforeUnmount, nextTick, watch, computed } from 'vue'
import { useRouter } from 'vue-router'
import { eventBus } from '@/utils/eventBus'
import { useI18n } from 'vue-i18n'
import { useOrderStore } from '@/stores/orderStore'



import {
  Disclosure,
  DisclosureButton,
  DisclosurePanel,
  Menu,
  MenuButton,
  MenuItem,
  MenuItems,
} from '@headlessui/vue'

import { Bars3Icon, XMarkIcon } from '@heroicons/vue/24/outline'

export default {
  emits: ['toggle-sidebar'],
  components: {
    Disclosure,
    DisclosureButton,
    DisclosurePanel,
    Menu,
    MenuButton,
    MenuItem,
    MenuItems,
    Bars3Icon,
    XMarkIcon
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

    const showTranslate = ref(false)

    const showSlidingMessage = ref(true)

    // const orderCount = ref(0)

    const searchQuery = ref('')
    const currentPage = ref(1)
    const itemsPerPage = 6

    // const updateOrderCount = (count) => {
    //   orderCount.value = count
    // }

    function goToOrder(documentNo) {
      router.push(`/sale-order/${documentNo}`)
    }


    // กรองข้อมูลจาก store ตาม searchQuery
    const filteredOrders = computed(() => {
      return orderStore.pendingOrders.filter(order =>
        order.document_no?.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
        order.id?.toString().includes(searchQuery.value) ||
        order.phone?.toString().includes(searchQuery.value) ||
        order.full_name?.toLowerCase().includes(searchQuery.value)
      )
    })

    // slice ตามหน้าปัจจุบัน
    const paginatedOrders = computed(() => {
      const start = (currentPage.value - 1) * itemsPerPage
      return filteredOrders.value.slice(start, start + itemsPerPage)
    })

    // จำนวนหน้าทั้งหมด
    const totalPages = computed(() => Math.ceil(filteredOrders.value.length / itemsPerPage))

    // เปลี่ยนหน้า
    function nextPage() {
      if (currentPage.value < totalPages.value) currentPage.value++
    }
    function prevPage() {
      if (currentPage.value > 1) currentPage.value--
    }

    // reset หน้าเมื่อค้นหา
    watch(searchQuery, () => {
      currentPage.value = 1
    })

    // const goToOrderPage = () => {
    //   // router.push('/sale-orders') // เส้นทางไปยังหน้ารายการคำสั่งซื้อ
    //   if (router.currentRoute.value.path !== '/sale-orders') {
    //     router.push('/sale-orders')
    //   }
    // }

    function toggleDropdown() {
      dropdownOpen.value = !dropdownOpen.value
    }

    // ปิด dropdown หากคลิกนอกกล่อง
    function onClickOutside(event) {
      if (bellRef.value && !bellRef.value.contains(event.target)) {
        dropdownOpen.value = false
      }
    }

    // onMounted(() => {
    //   eventBus.on('updateOrderNotification', updateOrderCount)
    // })

    // onBeforeUnmount(() => {
    //   eventBus.off('updateOrderNotification', updateOrderCount)
    // })


    //โหลดค่าจาก localStorage ตอน component mount
    // onMounted(() => {
    //   loadUserData()

    // })


    // function loadUserData() {
    //   account.value = localStorage.getItem('account') || ''
    //   contact.value = JSON.parse(localStorage.getItem('selectDataCustomer'))?.data2.contact || ''
    //   image_path.value = localStorage.getItem('image_path') || ''
    // }

    // const toggleTranslate = () => {
    //   showTranslate.value = !showTranslate.value

    // }

    const toggleTranslate = async () => {
      showTranslate.value = !showTranslate.value

      if (showTranslate.value) {
        await nextTick()

        // ล้าง widget เดิมก่อน
        const container = document.getElementById('google_translate_element')
        if (container) {
          container.innerHTML = ''
        }

        try {
          await loadGoogleTranslateScript()
          // รอโหลด script เสร็จแล้วค่อย init
          if (typeof window.googleTranslateElementInit === 'function') {
            window.googleTranslateElementInit()
          }
        } catch (error) {
          console.error('❌ Error loading Google Translate script:', error)
        }
      }
    }


    // const toggleTranslate = async () => {
    //   showTranslate.value = !showTranslate.value

    //   if (showTranslate.value) {
    //     await nextTick()
    //     try {
    //       // ล้าง widget เดิมก่อน
    //       const container = document.getElementById('google_translate_element')
    //       if (container) {
    //         container.innerHTML = ''
    //       }
    //       // เรียก function จาก window
    //       if (typeof window.googleTranslateElementInit === 'function') {
    //         window.googleTranslateElementInit()
    //       }
    //     } catch (error) {
    //       console.error('❌ Error initializing Google Translate:', error)
    //     }
    //   }
    // }

    // เพิ่มฟังก์ชันโหลด script แบบ async
    const loadGoogleTranslateScript = () => {
      return new Promise((resolve, reject) => {
        if (window.google && window.google.translate) {
          resolve() // script โหลดแล้ว
        } else {
          const script = document.createElement('script')
          script.src = 'https://translate.google.com/translate_a/element.js?cb=googleTranslateElementInit'
          script.async = true
          script.onload = resolve
          script.onerror = reject
          document.head.appendChild(script)
        }
      })
    }

    // เพิ่มฟังก์ชันบน window ให้สามารถเรียกจาก script ได้
    window.googleTranslateElementInit = function () {
      new window.google.translate.TranslateElement({
        pageLanguage: 'th',
        includedLanguages: 'en,th,zh',
        layout: window.google.translate.TranslateElement.InlineLayout.HORIZONTAL,
        autoDisplay: false
      }, 'google_translate_element')
    }



    // window.googleTranslateElementInit = () => {
    //   new window.google.translate.TranslateElement({
    //     pageLanguage: 'th',
    //     includedLanguages: 'en,th,zh',
    //     // layout: window.google.translate.TranslateElement.InlineLayout.SIMPLE,
    //     // layout: google.translate.TranslateElement.InlineLayout.HORIZONTAL,
    //     layout: window.google?.translate?.TranslateElement?.InlineLayout?.HORIZONTAL || 0,
    //     autoDisplay: false,
    //   }, 'google_translate_element')
    // }

    const loadUserData = () => {
      account.value = localStorage.getItem('account') || ''
      try {
        contact.value = JSON.parse(localStorage.getItem('selectDataCustomer'))?.data2.contact || ''
      } catch {
        contact.value = ''
      }
      image_path.value = localStorage.getItem('image_path') || ''
    }

    // ✅ โหลดครั้งแรก
    onMounted(async () => {

      orderStore.fetchPendingOrders()
      document.addEventListener('click', onClickOutside)

      loadUserData()
      eventBus.on('customerChanged', loadUserData)

      // โหลดจำนวนออเดอร์ค้างทุกครั้งที่หน้าโหลด
      // await orderStore.fetchPendingCount()

      await orderStore.fetchPendingOrders()

    })


    onBeforeUnmount(() => {
      document.removeEventListener('click', onClickOutside)
      eventBus.off('customerChanged', loadUserData)
    })



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
          localStorage.removeItem('token')
          localStorage.removeItem('isAuthenticated')
          // localStorage.removeItem('account')
          localStorage.removeItem('image_path')
          localStorage.removeItem('selectDataCustomer')
          localStorage.removeItem('selectDataCustomerRow')

          // localStorage.removeItem('token_address')
          // localStorage.removeItem('mac5_token')

          localStorage.removeItem('crm_account')
          localStorage.removeItem('fa_account')

          localStorage.removeItem('customer_id')
          localStorage.removeItem('customer_no')

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
      t, // <-- คืนค่ากลับเพื่อใช้ใน template
      locale,
      showTranslate,     // ✅ เพิ่มตรงนี้
      toggleTranslate,   // ✅ และเพิ่มฟังก์ชัน toggle
      showSlidingMessage,
      // orderCount,
      orderStore, // ✅ ใช้ store สำหรับจัดการคำสั่งซื้อ
      // goToOrderPage,
      dropdownOpen,  // <- ต้องคืนค่านี้ด้วย
      bellRef,
      toggleDropdown,

      searchQuery,
      currentPage,
      totalPages,
      filteredOrders,
      paginatedOrders,
      nextPage,
      prevPage,
      goToOrder
      // refreshData,
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