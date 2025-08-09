import { defineStore } from "pinia";
import axios from "axios";

export const useOrderStore = defineStore("order", {
  state: () => ({
    pendingCount: 0,
    pendingOrders: [], // <-- เพิ่มตรงนี้
    // unreadOrders: [],   // เก็บเฉพาะยังไม่อ่าน (is_read = 0)
    pendingCountMessage: 0,
    pendingOrdersMessage: [], // เก็บเฉพาะยังไม่อ่าน (is_read = 0)
  }),
  actions: {
    async fetchPendingOrders() {
      try {
        const BASE_URL_LOCAL = import.meta.env.VITE_API_URL_LOCAL;
        console.log("BASE_URL_LOCAL : ", BASE_URL_LOCAL);

        const res = await axios.get(
          `${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/list_sale_orders/get_list_sale_order.php?v=${Date.now()}`,
          {
            params: { page: 1, limit: 1000, search: "" },
          }
        );

        if (res.data.success) {
          const orders = res.data.data.list_order;
          
          this.pendingOrders = orders.filter((o) => o.status !== "ตรวจสอบเรียบร้อย");

          // ดึงข้อมูลแจ้งเตือนทั้งหมด ไม่กรอง is_read
          this.pendingOrdersMessage = orders;

          // pendingCountMessage = จำนวนที่ยังไม่อ่าน is_read === 0
          this.pendingCountMessage = orders.filter((o) => o.is_read === 0).length;

          // pendingCount = จำนวนที่ยังไม่ตรวจสอบ (ตามเดิม)
          this.pendingCount = this.pendingOrders.length;

          console.log("pendingCount", this.pendingCount);
          console.log("pendingCountMessage (ยังไม่อ่าน)", this.pendingCountMessage);
          console.log("pendingOrdersMessage (ทั้งหมด)", this.pendingOrdersMessage.length);
        }

        // if (res.data.success) {
        //   const orders = res.data.data.list_order
        //   console.log('Fetched pending orders:', orders)
        //   this.pendingCount = orders.filter(o => o.status !== 'ตรวจสอบเรียบร้อย').length

        //     // กรองเอาเฉพาะสถานะที่ไม่ใช่ "ตรวจสอบเรียบร้อย"
        //   this.pendingOrders = orders.filter(o => o.status !== 'ตรวจสอบเรียบร้อย')

        //   this.pendingCountMessage = orders.filter(o => o.is_read).length
        //   this.pendingOrdersMessage = orders.filter(o => o.is_read )
        //   // this.pendingOrders = orders  // <-- กำหนดค่าตรงนี้ด้วย
        //   console.log('Pending orders count', this.pendingCount)
        //   console.log('Pending orders pendingCountMessage', this.pendingCountMessage)
        //   console.log('Pending orders pendingOrdersMessage', this.pendingOrdersMessage)
        //   console.log('Fetched pending orders:', this.pendingOrders)

        // }
      } catch (err) {
        console.error("Error fetching pending orders:", err);
      }
    },

    async markAsRead(document_no) {
      try {
        const BASE_URL_LOCAL = import.meta.env.VITE_API_URL_LOCAL;
        // เรียก API อัพเดตสถานะอ่านใน DB
        await axios.post(
          `${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/list_sale_orders/mark_as_read.php`,
          { document_no }
        );

        // อัปเดตสถานะใน pendingOrdersMessage ตัวที่ตรงกัน ให้ is_read = 1 เพื่อให้ count ลดลงทันทีไม่ต้องรอ fetch ใหม่
        const idx = this.pendingOrdersMessage.findIndex((o) => o.document_no === document_no);
        if (idx !== -1) {
          this.pendingOrdersMessage[idx].is_read = 1;
        }

        // อัปเดต count pendingCountMessage ใหม่ (นับที่ is_read === 0)
        this.pendingCountMessage = this.pendingOrdersMessage.filter((o) => o.is_read === 0).length;

        // รีเฟรชข้อมูลหลังจาก update
        // ถ้าต้องการ รีเฟรชข้อมูลทั้งหมดก็เรียก fetch ใหม่ แต่ถ้าช้า ใช้วิธีนี้ดีกว่า
        // await this.fetchPendingOrders();

      } catch (err) {
        console.error("Error marking order as read:", err);
      }
    },
  },
});
