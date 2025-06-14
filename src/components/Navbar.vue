<template>
  <Disclosure as="nav" class="bg-gray-800" v-slot="{ open }">
    <div class="mx-auto max-w-7xl px-2 sm:px-6 lg:px-8">
      <div class="relative flex h-16 items-center justify-between">

        <!-- Mobile Menu Button (ซ้ายสุด) -->
        <!-- <div class="absolute inset-y-0 left-0 flex items-center sm:hidden">
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
        <div class="Logomedia flex items-center">
          <router-link to="/dashboard">
            <img class="h-8 w-auto" src="../assets/logo.svg" alt="My Project" />
          </router-link>
        </div>

        <!-- Title (ตรงกลาง) -->
        <div class="boxTitel absolute left-1/2 transform -translate-x-1/2">
          <router-link to="/dashboard">
            <h4 class="font-semibold text-xl text-center">The Welcome to Admin Dashboard</h4>
          </router-link>
        </div>

        <!-- User Menu (ด้านขวา) -->
        <div class="absolute inset-y-0 right-0 flex items-center pr-2 sm:static sm:inset-auto sm:ml-6 sm:pr-0">
          <Menu as="div" class="relative ml-3">
            <!-- <div>
                <MenuButton
                  class="relative flex rounded-full bg-gray-800 text-sm focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-gray-800 focus:outline-hidden"
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
            <div>
              <MenuButton
                class="relative flex rounded-full bg-gray-800 text-sm focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-gray-800 focus:outline-hidden">
                <span class="absolute -inset-1.5" />
                <span class="sr-only">Open user menu</span>

                <template v-if="image_path">
                  <img class="size-8 rounded-full" :src="image_path" alt="User Avatar" />
                </template>
                <template v-else>
                  <span class="material-icons text-white text-[32px]">account_circle</span>
                </template>
              </MenuButton>
            </div>
            <transition enter-active-class="transition ease-out duration-100"
              enter-from-class="transform opacity-0 scale-95" enter-to-class="transform opacity-100 scale-100"
              leave-active-class="transition ease-in duration-75" leave-from-class="transform opacity-100 scale-100"
              leave-to-class="transform opacity-0 scale-95">
              <MenuItems
                class="absolute right-0 z-10 mt-2 w-48 origin-top-right rounded-md bg-white py-1 shadow-lg ring-1 ring-black/5 focus:outline-hidden">
                <MenuItem v-slot="{ active }">
                <a href="/about" :class="[
                  active ? 'bg-gray-100 outline-hidden' : '',
                  'block px-4 py-2 text-sm text-gray-700'
                ]">
                  About
                </a>
                </MenuItem>
                <!-- <MenuItem v-slot="{ active }">
                    <a
                      href="#"
                      :class="[
                        active ? 'bg-gray-100 outline-hidden' : '',
                        'block px-4 py-2 text-sm text-gray-700'
                      ]"
                    >
                      Settings
                    </a>
                  </MenuItem> -->
                <MenuItem v-slot="{ active }">
                <a href="#" @click="confirmLogoutEmployee" :class="[
                  active ? 'bg-gray-100 outline-hidden' : '',
                  'block px-4 py-2 text-sm text-gray-700'
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
    <DisclosurePanel class="sm:hidden">
      <div class="space-y-1 px-2 pt-2 pb-3">
        <!-- Add navigation items here if needed -->
      </div>
    </DisclosurePanel>
  </Disclosure>
</template>

<script setup>
import Swal from 'sweetalert2'

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
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()

// const logout = () => {
//     // ลบข้อมูล token และข้อมูลอื่น ๆ ที่เก็บไว้ใน localStorage
//     localStorage.removeItem('token')
//     localStorage.removeItem('isAuthenticated')
//     localStorage.removeItem('image_path')

//     // ไปหน้า signin
//     router.push('/')
// }

const confirmLogoutEmployee = async () => {
  const result = await Swal.fire({
    title: 'ยืนยันการออกจากระบบ',
    text: 'คุณต้องการออกจากระบบจริงหรือไม่?',
    icon: 'question',
    showCancelButton: true,
    confirmButtonText: 'ใช่, ออกเลย',
    cancelButtonText: 'ยกเลิก',
  });

  if (result.isConfirmed) {

    try {

      // ลบข้อมูล token และข้อมูลอื่น ๆ ที่เก็บไว้ใน localStorage
      localStorage.removeItem('token')
      localStorage.removeItem('isAuthenticated')
      localStorage.removeItem('image_path')

      // ไปหน้า signin
      router.push('/')

    } catch (error) {
      console.error('Error Delete employees:', error);
      Swal.fire('เกิดข้อผิดพลาด', 'ไม่สามารถออกจากระบบได้', 'error');
    }

  } else {
    // กดยกเลิก ไม่ทำอะไร
    console.log('ยกเลิกการออกจากระบบ');
  }
}

const image_path = ref('')
// โหลดรูปจาก localStorage
onMounted(() => {
  image_path.value = localStorage.getItem('image_path'); //|| 'https://via.placeholder.com/150'
})

</script>


<style scoped>
.boxTitel {

  h4 {
    font-size: 1.5rem;

    @media (max-width:768px) {

      font-size: 1rem;

    }

  }
}

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
} */
</style>