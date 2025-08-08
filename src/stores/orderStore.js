import { defineStore } from 'pinia'
import axios from 'axios'

export const useOrderStore = defineStore('order', {
  state: () => ({
    pendingCount: 0,
    pendingOrders: [],  // <-- เพิ่มตรงนี้
  }),
  actions: {
    async fetchPendingOrders() {
      try {

        const BASE_URL_LOCAL = import.meta.env.VITE_API_URL_LOCAL
        console.log('BASE_URL_LOCAL : ', BASE_URL_LOCAL);

        const res = await axios.get(`${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/list_sale_orders/get_list_sale_order.php?v=${Date.now()}`, {
          params: { page: 1, limit: 1000, search: '' }
        })
        if (res.data.success) {
          const orders = res.data.data.list_order
          console.log('Fetched pending orders:', orders)
          this.pendingCount = orders.filter(o => o.status !== 'ตรวจสอบเรียบร้อย').length
          
          this.pendingOrders = orders  // <-- กำหนดค่าตรงนี้ด้วย
          console.log('Pending orders count', this.pendingCount)
          console.log('Fetched pending orders:', this.pendingOrders)

        }
      } catch (err) {
        console.error('Error fetching pending orders:', err)
      }
    }
  }
})
