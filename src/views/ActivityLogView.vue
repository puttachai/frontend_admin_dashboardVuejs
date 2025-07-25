<!-- <template>
  <div class="p-6">
    <h2 class="text-xl font-bold mb-4">กิจกรรมของผู้ใช้</h2>
    <table class="w-full border border-gray-300 text-sm">
      <thead class="bg-gray-100">
        <tr>
          <th class="border p-2">เวลา</th>
          <th class="border p-2">บัญชีผู้ใช้</th>
          <th class="border p-2">IP</th>
          <th class="border p-2">กิจกรรม</th>
          <th class="border p-2">หน้า</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="log in activityLogs" :key="log.id">
          <td class="border p-2">{{ log.timestamp }}</td>
          <td class="border p-2">{{ log.account }}</td>
          <td class="border p-2">{{ log.ip_address }}</td>
          <td class="border p-2">{{ log.activity }}</td>
          <td class="border p-2">{{ log.page }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'

const activityLogs = ref([])
const BASE_URL = import.meta.env.VITE_API_URL_LOCAL;

onMounted(async () => {
  try {
    const res = await axios.get(`${BASE_URL}/api_admin_dashboard/backend/api/log/all.php`);
     console.log('res : ',res);
    activityLogs.value = res.data.logs;
    console.log('activityLogs : ',activityLogs);
  } catch (err) {
    console.error('❌ โหลด log ไม่สำเร็จ:', err);
  }
});
</script> -->
