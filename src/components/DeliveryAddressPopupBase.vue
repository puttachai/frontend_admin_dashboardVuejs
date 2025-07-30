<template>
  <div class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black bg-opacity-50">
    <div class="w-full max-w-md bg-white rounded-lg p-6 shadow-xl">
      <h2 class="text-lg text-gray-600 font-semibold mb-4">กรอกข้อมูลที่อยู่/จัดส่ง</h2>
      <form @submit.prevent="submitAddress">
        <div class="space-y-4">
          <!-- จังหวัด -->
          <div>
            <label class="text-sm text-gray-600">จังหวัด</label>
            <select
              v-model="form.province_id"
              @change="onProvinceChange"
              class="w-full text-gray-600 border rounded px-3 py-2"
            >
              <option value="">-- กรุณาเลือกจังหวัด --</option>
              <option v-for="p in provinces" :key="p.id" :value="p.id">{{ p.name_th }}</option>
            </select>
          </div>

          <!-- เขต/อำเภอ -->
          <div>
            <label class="text-sm text-gray-600">เขต/อำเภอ</label>
            <select
              v-model="form.amphure_id"
              @change="onAmphureChange"
              class="w-full text-gray-600 border rounded px-3 py-2"
            >
              <option value="">-- กรุณาเลือกอำเภอ --</option>
              <option v-for="a in amphures" :key="a.id" :value="a.id">{{ a.name_th }}</option>
            </select>
          </div>

          <!-- ตำบล/แขวง -->
          <div>
            <label class="text-sm text-gray-600">แขวง/ตำบล</label>
            <select v-model="form.tambon_id" class="w-full text-gray-600 border rounded px-3 py-2">
              <option value="">-- กรุณาเลือกตำบล --</option>
              <option v-for="t in tambons" :key="t.id" :value="t.id">{{ t.name_th }}</option>
            </select>
          </div>

          <!-- ที่อยู่เพิ่มเติม -->
          <div>
            <label class="text-sm text-gray-600">ที่อยู่เพิ่มเติม</label>
            <textarea
              v-model="form.detail"
              rows="3"
              class="w-full text-gray-600 border rounded px-3 py-2"
              required
            ></textarea>
          </div>

          <!-- ปุ่ม -->
          <div class="flex justify-end space-x-2">
            <button
              type="button"
              @click="$emit('close')"
              class="px-4 py-2 border rounded text-gray-600 hover:bg-gray-100"
            >
              ยกเลิก
            </button>
            <button
              type="submit"
              class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700"
            >
              ตกลง
            </button>
          </div>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import Swal from "sweetalert2";
import qs from "qs"; // อย่าลืม import
// import.meta.env.VITE_DELIVERY_ADDRESS

const BASE_URL_DELIVERY_ADDRESS = import.meta.env.VITE_DELIVERY_ADDRESS;
const BASE_URL_LOCAL = import.meta.env.VITE_API_URL_LOCAL;

const BASE_URL_AUTH = import.meta.env.VITE_API_URL_AUTH;
// showAddressPopupBase
export default {
  //   name: "DeliveryAddressPopup",
  name: "DeliveryAddressPopupBase",
  data() {
    return {

      customerData: JSON.parse(localStorage.getItem('selectDataCustomer') || 'null'),

      form: {
        province_id: "",
        amphure_id: "",
        tambon_id: "",
        detail: "",
      },
      provinces: [],
      amphures: [],
      tambons: [],
      rawData: [],
    };
  },

  //   props: {
  //     existingAddressBase: {
  //       type: Object,
  //       default: () => ({}),
  //     },
  //   },

  props: {
    existingAddressBase: {
      type: Object,
      default: () => ({}),
    },
    // customerNo: {
    //   type: [String, Number],
    //   required: true,
    // },
  },

  mounted() {
    // this.fetchLocationData();
    this.fetchLocationData().then(() => {
      this.prefillAddressForm();
    });
  },

  methods: {
    
    prefillAddressForm() {
      if (this.existingAddressBase && Object.keys(this.existingAddressBase).length) {
        const { province_id, amphure_id, tambon_id, detail } = this.existingAddressBase;

        this.form.province_id = province_id;
        this.form.amphure_id = amphure_id;
        this.form.tambon_id = tambon_id;
        this.form.detail = detail;

        this.onProvinceChange();
        setTimeout(() => {
          this.onAmphureChange();
        }, 0);
      }
    },

    async fetchLocationData() {
      try {
        const res = await axios.get(
          "https://raw.githubusercontent.com/kongvut/thai-province-data/master/api_province_with_amphure_tambon.json"
        );
        this.rawData = res.data;
        this.provinces = this.rawData.map((p) => ({
          id: p.id,
          name_th: p.name_th,
          amphure: p.amphure,
        }));
      } catch (err) {
        console.error("❌ โหลดข้อมูลจังหวัดไม่สำเร็จ", err);
      }
    },

    onProvinceChange() {
      const selectedProvince = this.rawData.find((p) => p.id === this.form.province_id);
      this.amphures = selectedProvince?.amphure || [];
      this.form.amphure_id = "";
      this.form.tambon_id = "";
      this.tambons = [];
    },
    onAmphureChange() {
      const selectedProvince = this.rawData.find((p) => p.id === this.form.province_id);
      const selectedAmphure = selectedProvince?.amphure.find((a) => a.id === this.form.amphure_id);
      this.tambons = selectedAmphure?.tambon || [];
      this.form.tambon_id = "";
    },

    async getAuthToken() {
      // localStorage.removeItem("mac5_token");
      const tokenData = JSON.parse(localStorage.getItem("mac5_token")) || null;

      // console.log("🔑 Check tokenData :", tokenData);

      const oneHour = 60 * 60 * 1000; // 1 ชั่วโมงในหน่วยมิลลิวินาที
      const now = Date.now();

      if (tokenData && tokenData.token && now - tokenData.timestamp < oneHour) {
        // console.log("🔑 ใช้ token เดิม:", tokenData.token);
        return tokenData.token; // ✅ ใช้ token เดิม
      }

      console.log("🔑 Token ไม่พบหรือหมดอายุ กำลังขอใหม่...");

      // 🛎️ แสดง loading เฉพาะตอนขอ token ใหม่
      Swal.fire({
        title: "กำลังดำเนินการ...",
        text: "กำลังเพิ่มข้อมูล (ครั้งแรกจะใช้เวลาสักครู่)",
        allowOutsideClick: false,
        didOpen: () => {
          Swal.showLoading();
        },
      });

      // 🔄 ถ้าไม่มี token หรือหมดอายุ ให้ขอใหม่
      const secretKeyData = qs.stringify({
        secretKey1: import.meta.env.VITE_SECRET_KEY1,
        secretKey2: import.meta.env.VITE_SECRET_KEY2,
      });

      try {
        const authResponse = await axios.post(`${BASE_URL_AUTH}`, secretKeyData, {
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
        });

        const token = authResponse.data.Token;
        if (!token) throw new Error("ไม่สามารถดึง token ได้");

        // 📝 บันทึก token และ timestamp ลง localStorage
        localStorage.setItem(
          "mac5_token",
          JSON.stringify({
            token,
            timestamp: now,
          })
        );

        Swal.close(); // ✅ ปิด Swal เมื่อเรียบร้อย
        return token;
      } catch (err) {
        Swal.fire({
          icon: "error",
          title: "ขอ Token ไม่สำเร็จ",
          text: "ไม่สามารถขอ token ได้ กรุณาลองใหม่อีกครั้ง",
        });
        console.error("❌ ดึง token ไม่สำเร็จ:", err);
        throw err;
      }
    },

    async submitAddress() {
      // const account_id = localStorage.getItem('account');
      // console.log('📌📌 log address_ids: ', account_id);
      const existingAddressId = this.existingAddress?.id; // || account_id
      // const addressId = this.existingAddress?.id || localStorage.getItem('address_id');
      const isManualInput = this.form.detail && !existingAddressId;

      const province = this.provinces.find((p) => p.id === this.form.province_id)?.name_th || "";
      const district = this.amphures.find((a) => a.id === this.form.amphure_id)?.name_th || "";
      const subDistrict = this.tambons.find((t) => t.id === this.form.tambon_id)?.name_th || "";

      const getselectDataCustomerRow = JSON.parse(
        localStorage.getItem("selectDataCustomerRow") || "{}"
      );

      const getCustomer_id = getselectDataCustomerRow?.customer_id ?? 0;
      const getCustomer_no = getselectDataCustomerRow?.customer_no ?? 0;
      const getMobile = getselectDataCustomerRow?.mobile ?? 0;

      console.log("log getCustomer_id: ", getCustomer_id);
      console.log("log getselectDataCustomerRow: ", getselectDataCustomerRow);

      // 📌 กำหนด addressId จาก existingAddress หรือ localStorage
      const addressId = existingAddressId || null;

      if (addressId) {
        // UPDATE ที่อยู่เดิม
        const updatePayload = {
          id: addressId,
          DC_code: getCustomer_no,
          DC_id: getCustomer_id,
          DC_add1: this.form.detail,
          DC_add2: `แขวง ${subDistrict} ${district}`,
          DC_add3: province,
          DC_tel: getMobile,
          DC_zone: "",
        };

        try {
          try {
            // localStorage.setItem('deliveryAddress', response.data);
            this.$emit("submitted", updatePayload);
            this.$emit("close");
          } catch (err) {
            console.error("❌ ส่งไม่สำเร็จ:", err);
            alert("เกิดข้อผิดพลาดในการส่งข้อมูล");
          }
          // }
        } catch (error) {
          console.error("❌ ส่งไม่สำเร็จ:", err);
          alert("เกิดข้อผิดพลาดในการส่งข้อมูล");
        }
      } else {
        // INSERT ใหม่
        const addressData = {
          DC_code: getCustomer_no, //'DEL-REST-01', // AP
          DC_id: getCustomer_id, //'0001', // ID ของที่อยู่ ใน table delivery_address
          DC_add1: this.form.detail,
          DC_add2: `แขวง ${subDistrict} ${district}`, //เขต
          DC_add3: `${province}`, //10500, // รหัสไปรษณีย์
          DC_tel: getMobile, //'029797000',
          DC_zone: "", //'ZON-TEST-01'
        };

        console.log("📦 ข้อมูลที่อยู่:", addressData);

        try {
          this.$emit("submitted", addressData);
          // this.$emit('submitted', formJsonData);
          this.$emit("close");

          return; // สำหรับทดสอบไม่ให้ส่งข้อมูลจริง

          localStorage.setItem("deliveryAddress", JSON.stringify(addressData));
          this.$emit("submitted", addressData);
          this.$emit("close");
        } catch (err) {
          console.error("❌ ส่งไม่สำเร็จ:", err);
          alert("เกิดข้อผิดพลาดในการส่งข้อมูล");
        }
      }
    },
  },
};
</script>

<style scoped></style>
