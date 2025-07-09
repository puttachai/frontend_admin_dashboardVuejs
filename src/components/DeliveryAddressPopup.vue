<template>
    <div class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black bg-opacity-50">
        <div class="w-full max-w-md bg-white rounded-lg p-6 shadow-xl">
            <h2 class="text-lg font-semibold mb-4">กรอกข้อมูลที่อยู่/จัดส่ง</h2>
            <form @submit.prevent="submitAddress">
                <div class="space-y-4">
                    <!-- จังหวัด -->
                    <div>
                        <label class="text-sm">จังหวัด</label>
                        <select v-model="form.province_id" @change="onProvinceChange"
                            class="w-full border rounded px-3 py-2">
                            <option value="">-- กรุณาเลือกจังหวัด --</option>
                            <option v-for="p in provinces" :key="p.id" :value="p.id">{{ p.name_th }}</option>
                        </select>
                    </div>

                    <!-- เขต/อำเภอ -->
                    <div>
                        <label class="text-sm">เขต/อำเภอ</label>
                        <select v-model="form.amphure_id" @change="onAmphureChange"
                            class="w-full border rounded px-3 py-2">
                            <option value="">-- กรุณาเลือกอำเภอ --</option>
                            <option v-for="a in amphures" :key="a.id" :value="a.id">{{ a.name_th }}</option>
                        </select>
                    </div>

                    <!-- ตำบล/แขวง -->
                    <div>
                        <label class="text-sm">แขวง/ตำบล</label>
                        <select v-model="form.tambon_id" class="w-full border rounded px-3 py-2">
                            <option value="">-- กรุณาเลือกตำบล --</option>
                            <option v-for="t in tambons" :key="t.id" :value="t.id">{{ t.name_th }}</option>
                        </select>
                    </div>

                    <!-- ที่อยู่เพิ่มเติม -->
                    <div>
                        <label class="text-sm">ที่อยู่เพิ่มเติม</label>
                        <textarea v-model="form.detail" rows="3" class="w-full border rounded px-3 py-2"
                            required></textarea>
                    </div>

                    <!-- ปุ่ม -->
                    <div class="flex justify-end space-x-2">
                        <button type="button" @click="$emit('close')"
                            class="px-4 py-2 border rounded text-gray-600 hover:bg-gray-100">ยกเลิก</button>
                        <button type="submit"
                            class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">ตกลง</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</template>


<script>
import axios from 'axios';
import Swal from 'sweetalert2';
import qs from 'qs'; // อย่าลืม import
// import.meta.env.VITE_DELIVERY_ADDRESS

const BASE_URL_DELIVERY_ADDRESS = import.meta.env.VITE_DELIVERY_ADDRESS;
const BASE_URL_LOCAL = import.meta.env.VITE_API_URL_LOCAL;

const BASE_URL_AUTH = import.meta.env.VITE_API_URL_AUTH;

export default {
    name: 'DeliveryAddressPopup',
    data() {
        //   return {
        //     form: {
        //       province: '',
        //       district: '',
        //       subDistrict: '',
        //       detail: '',
        //     },
        //     provinces: [
        //       'กรุงเทพมหานคร', 'เชียงใหม่', 'ชลบุรี', 'ภูเก็ต', 'ขอนแก่น',
        //       'นครราชสีมา', 'สงขลา', 'สุราษฎร์ธานี', 'เชียงราย', 'พิษณุโลก'
        //       // เพิ่มจังหวัดอื่นได้อีกตามต้องการ
        //     ]
        //   };
        return {
            form: {
                province_id: '',
                amphure_id: '',
                tambon_id: '',
                detail: ''
            },
            provinces: [],
            amphures: [],
            tambons: [],
            rawData: []
        };
    },
    mounted() {
        this.fetchLocationData();
    },

    methods: {
        async fetchLocationData() {
            try {
                const res = await axios.get('https://raw.githubusercontent.com/kongvut/thai-province-data/master/api_province_with_amphure_tambon.json');
                this.rawData = res.data;
                this.provinces = this.rawData.map(p => ({ id: p.id, name_th: p.name_th, amphure: p.amphure }));
            } catch (err) {
                console.error('❌ โหลดข้อมูลจังหวัดไม่สำเร็จ', err);
            }
        },
        onProvinceChange() {
            const selectedProvince = this.rawData.find(p => p.id === this.form.province_id);
            this.amphures = selectedProvince?.amphure || [];
            this.form.amphure_id = '';
            this.form.tambon_id = '';
            this.tambons = [];
        },
        onAmphureChange() {
            const selectedProvince = this.rawData.find(p => p.id === this.form.province_id);
            const selectedAmphure = selectedProvince?.amphure.find(a => a.id === this.form.amphure_id);
            this.tambons = selectedAmphure?.tambon || [];
            this.form.tambon_id = '';
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
                title: 'กำลังดำเนินการ...',
                text: 'กำลังเพิ่มข้อมูล (ครั้งแรกจะใช้เวลาสักครู่)',
                allowOutsideClick: false,
                didOpen: () => {
                    Swal.showLoading();
                }
            });

            // 🔄 ถ้าไม่มี token หรือหมดอายุ ให้ขอใหม่
            const secretKeyData = qs.stringify({
                secretKey1: import.meta.env.VITE_SECRET_KEY1,
                secretKey2: import.meta.env.VITE_SECRET_KEY2
            });

            try {
                const authResponse = await axios.post(`${BASE_URL_AUTH}`, secretKeyData, {
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    }
                });

                const token = authResponse.data.Token;
                if (!token) throw new Error("ไม่สามารถดึง token ได้");

                // 📝 บันทึก token และ timestamp ลง localStorage
                localStorage.setItem("mac5_token", JSON.stringify({
                    token,
                    timestamp: now
                }));

                Swal.close(); // ✅ ปิด Swal เมื่อเรียบร้อย
                return token;
            } catch (err) {
                Swal.fire({
                    icon: 'error',
                    title: 'ขอ Token ไม่สำเร็จ',
                    text: 'ไม่สามารถขอ token ได้ กรุณาลองใหม่อีกครั้ง',
                });
                console.error("❌ ดึง token ไม่สำเร็จ:", err);
                throw err;
            }
        },


        async submitAddress() {
            const province = this.provinces.find(p => p.id === this.form.province_id)?.name_th || '';
            const district = this.amphures.find(a => a.id === this.form.amphure_id)?.name_th || '';
            const subDistrict = this.tambons.find(t => t.id === this.form.tambon_id)?.name_th || '';

            const getselectDataCustomerRow = JSON.parse(localStorage.getItem('selectDataCustomerRow') || '{}');

            const getCustomer_id = getselectDataCustomerRow?.customer_id ?? 0;;
            const getCustomer_no = getselectDataCustomerRow?.customer_no ?? 0;;
            const getMobile = getselectDataCustomerRow?.mobile ?? 0;;

            console.log('log getCustomer_id: ', getCustomer_id);

            // return; // สำหรับทดสอบไม่ให้ส่งข้อมูลจริง

            const addressData = {
                DC_code: getCustomer_no, //'DEL-REST-01', // AP 
                DC_id: getCustomer_id, //'0001', // ID ของที่อยู่ ใน table delivery_address
                DC_add1: this.form.detail,
                DC_add2: `แขวง ${subDistrict} ${district}`, //เขต
                DC_add3: `${province}`, //10500, // รหัสไปรษณีย์
                DC_tel: getMobile, //'029797000',
                DC_zone: '', //'ZON-TEST-01'
            };

            console.log('📦 ข้อมูลที่อยู่:', addressData)

            // return; // สำหรับทดสอบไม่ให้ส่งข้อมูลจริง

            //Api Database Local
            try {
                const res = await axios.post(`${BASE_URL_LOCAL}/api_admin_dashboard/backend/api/post_delivery_address.php`, addressData,
                    {
                        headers: {
                            'Content-Type': 'application/json',
                        }
                    }
                );
                console.log('📦 ส่งสำเร็จ:', res.data);

                if (res.data.success === true) {
                    Swal.fire({
                        icon: 'success',
                        title: 'ส่งข้อมูลสำเร็จ',
                        text: 'ข้อมูลที่อยู่ถูกบันทึกเรียบร้อยแล้ว',
                    });

                    localStorage.setItem('address_id', res.data.id)
                    const address_id = res.data.id;
                    // const addressData = JSON.parse(localStorage.getItem('address_id') || 'null');
                    // const address_id = addressData?.data.id || null;
                    console.log('📦 address_id:', address_id);

                    const getaddress_id = JSON.parse(localStorage.getItem('address_id')) || null;
                    console.log('📦 getaddress_id:', getaddress_id);

                    // // 1. 🔑 ดึง token จาก BASE_URL_AUTH
                    // const secretKeyData = qs.stringify({
                    //     secretKey1: import.meta.env.VITE_SECRET_KEY1,
                    //     secretKey2: import.meta.env.VITE_SECRET_KEY2
                    // });

                    // // 2. 🧪 ดึง token จาก BASE_URL_AUTH
                    // const authResponse = await axios.post(`${BASE_URL_AUTH}`, secretKeyData, {
                    //     // Secretkey1: "your_secret_1", // 👉 เปลี่ยนเป็นค่าแท้จริง
                    //     // Secretkey2: "your_secret_2"
                    //     headers: {
                    //         'Content-Type': 'application/x-www-form-urlencoded'
                    //     }
                    // });

                    // const token = authResponse.data.Token;
                    // console.log("🔑 Token ที่ได้จาก BASE_URL_AUTH:", token);
                    // if (!token) throw new Error("ไม่สามารถดึง token ได้");

                    // ก้อนข้อมูลที่อยู่สำหรับส่งไปยัง Mac 5
                    const addressBulidMacFive = {
                        DC_code: getCustomer_no, //'DEL-REST-01', // AP 
                        DC_id: getaddress_id, //'0001', // ID ของที่อยู่ ใน table delivery_address
                        DC_add1: this.form.detail,
                        DC_add2: `แขวง ${subDistrict} ${district}`, //เขต
                        DC_add3: `${province}`, //10500, // รหัสไปรษณีย์
                        DC_tel: getMobile, //'029797000',
                        DC_zone: '', //'ZON-TEST-01'
                    };

                    console.log('📦 addressBulidMacFive:', addressBulidMacFive);

                    // const formEncodedData = qs.stringify(addressBulidMacFive);

                    // 1. ✅ เรียกใช้ token ก่อนยิง API ไป Mac Five
                    const token = await this.getAuthToken();

                    // 2. 🔃 สร้าง addressBulidMacFive → qs.stringify แล้วยิงไป Mac Five
                    const formEncodedData = qs.stringify(addressBulidMacFive);

                    // return; // สำหรับทดสอบไม่ให้ส่งข้อมูลจริง

                    //Api Mac 5 
                    try {
                        const response = await axios.post(`${BASE_URL_DELIVERY_ADDRESS}`, formEncodedData, {
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded',
                                'Authorization': `Bearer ${token}` // ถ้าต้องการใช้ token ใน header
                            }
                        });
                        console.log('📦 ส่งสำเร็จ:', response.data);

                        // return; // สำหรับทดสอบไม่ให้ส่งข้อมูลจริง

                        // localStorage.setItem('deliveryAddress', response.data);
                        this.$emit('submitted', addressBulidMacFive);
                        this.$emit('close');
                    } catch (err) {
                        console.error('❌ ส่งไม่สำเร็จ:', err);
                        alert('เกิดข้อผิดพลาดในการส่งข้อมูล');
                    }


                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'เกิดข้อผิดพลาด',
                        text: 'ไม่สามารถบันทึกข้อมูลที่อยู่ได้',
                    });
                }

                return; // สำหรับทดสอบไม่ให้ส่งข้อมูลจริง

                localStorage.setItem('deliveryAddress', JSON.stringify(addressData));
                this.$emit('submitted', addressData);
                this.$emit('close');
            } catch (err) {
                console.error('❌ ส่งไม่สำเร็จ:', err);
                alert('เกิดข้อผิดพลาดในการส่งข้อมูล');
            }

            // return; // สำหรับทดสอบไม่ให้ส่งข้อมูลจริง

            // const getaddress_id = JSON.parse(localStorage.getItem('address_id')) || null;
            // console.log('📦 getaddress_id:', getaddress_id);

            // const addressBulidMacFive = {
            //     DC_code: getCustomer_no, //'DEL-REST-01', // AP 
            //     DC_id: getCustomer_id, //'0001', // ID ของที่อยู่ ใน table delivery_address
            //     DC_add1: this.form.detail,
            //     DC_add2: `แขวง ${subDistrict} เขต ${district}`,
            //     DC_add3: `${province}`, //10500, // รหัสไปรษณีย์
            //     DC_tel: getMobile, //'029797000',
            //     DC_zone: '', //'ZON-TEST-01'
            // };

            // console.log('📦 addressBulidMacFive:', addressBulidMacFive);

            // return; // สำหรับทดสอบไม่ให้ส่งข้อมูลจริง

            // //Api Mac 5 
            // try {
            //     const response = await axios.post(`${BASE_URL_DELIVERY_ADDRESS}`, addressBulidMacFive);
            //     console.log('📦 ส่งสำเร็จ:', response.data);

            //     // return; // สำหรับทดสอบไม่ให้ส่งข้อมูลจริง

            //     localStorage.setItem('deliveryAddress', JSON.stringify(addressData));
            //     this.$emit('submitted', addressData);
            //     this.$emit('close');
            // } catch (err) {
            //     console.error('❌ ส่งไม่สำเร็จ:', err);
            //     alert('เกิดข้อผิดพลาดในการส่งข้อมูล');
            // }
        }
    }
};
//     async submitAddress() {
//         const addressData = {
//             DC_code: 'DEL-REST-01',
//             DC_id: '0001',
//             DC_add1: this.form.detail,
//             DC_add2: `ถนน ${this.form.subDistrict} แขวง ${this.form.subDistrict} เขต ${this.form.district}`,
//             DC_add3: `${this.form.province} 10500`,
//             DC_tel: '029797000',
//             DC_zone: 'ZON-TEST-01'
//         };

//         try {
//             const res = await axios.post(import.meta.env.VITE_DELIVERY_ADDRESS, addressData);
//             console.log('📦 ส่งสำเร็จ:', res.data);

//             localStorage.setItem('deliveryAddress', JSON.stringify(addressData));
//             this.$emit('submitted', addressData);
//             this.$emit('close');
//         } catch (err) {
//             console.error('❌ ส่งไม่สำเร็จ:', err);
//             alert('เกิดข้อผิดพลาดในการส่งข้อมูล');
//         }
//     }
// }
</script>

<style scoped></style>

<!-- 
  import provinces from '@/assets/thailand/api_province.json'
import amphures from '@/assets/thailand/api_amphure.json'
import tambons from '@/assets/thailand/api_tambon.json'

const selectedProvince = ref('')
const filteredAmphurs = computed(() =>
  amphures.filter(a => a.province_code === selectedProvince.value)
)

const selectedAmphur = ref('')
const filteredTambons = computed(() =>
  tambons.filter(t => t.amphure_code === selectedAmphur.value)
) -->