<template>
  <div class="p-6 bg-gray-100 min-h-screen">
    <!-- Top Cards -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">

      <!-- Employee Stats -->

        <!-- <div class="bg-orange-400 text-white rounded-xl shadow p-4 mb-4">
          <p class="text-lg font-bold">Employees Stats</p>
          <p class="text-sm">New employees on 15th September, 2016</p>
        </div> -->

        <!-- Employee Table (ล่าสุด 5 คน) -->
        <div class="bg-white rounded-xl shadow p-4 ">
          <h2 class="text-lg font-bold text-gray-700 mb-2">Latest 5 Employees</h2>
          <div class="overflow-x-auto overflow-y-auto">
            <table class="min-w-full text-sm text-left text-gray-700">
              <thead class="text-xs uppercase bg-gray-100">
                <tr>
                  <th class="px-4 py-2">ชื่อพนักงาน</th>
                  <th class="px-4 py-2">เบอร์โทร</th>
                  <th class="px-4 py-2">ตำแหน่ง</th>
                  <th class="px-4 py-2">วันที่เริ่มงาน</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="(emp, index) in latestEmployees" :key="index" class="border-b">
                  <td class="px-4 py-2">{{ emp.full_name }}</td>
                  <td class="px-4 py-2">{{ emp.telephone }}</td>
                  <td class="px-4 py-2">{{ emp.department }}</td>
                  <td class="px-4 py-2">{{ emp.start_work }}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>


      <!-- Daily Sales -->
        <div class="bg-white rounded-xl shadow p-4">
          <p class="font-semibold text-gray-600 mb-1">เงินเดือนพนักงาน</p>
          <p class="text-sm text-green-500 mb-3">จัดเรียงจากมากไปน้อย</p>
          <div class="h-64">
            <canvas id="salaryChart"></canvas> <!-- 👈 แสดง Chart -->
          </div>
          <p class="text-xs text-gray-400 mt-2">อัปเดตล่าสุด</p>
        </div>

      <!-- Completed Tasks -->
      <!-- แสดง Chart -->
        <div class="bg-white rounded-xl shadow p-4">
          <p class="font-semibold text-gray-600 mb-1">จำนวนพนักงานแต่ละแผนก</p>
          <p class="text-sm text-blue-500 mb-3">เรียงจากมากไปน้อย</p>
          <div class="h-64">
            <canvas id="departmentChart"></canvas>
          </div>
          <p class="text-xs text-gray-400 mt-2">อัปเดตล่าสุด</p>
        </div>

    </div>

    <!-- Middle Stats -->
    <div class="grid grid-cols-2 md:grid-cols-6 gap-4 mb-6">
      <div class="bg-white rounded-xl shadow p-4 flex items-center gap-4 overflow-hidden">
        <div class="bg-sky-500 p-2 rounded text-white flex-shrink-0">
          <i class="fab fa-vuejs"></i>
        </div>
        <div class="flex-1">
          <p class="text-lg font-semibold truncate">+245</p>
          <p class="text-sm text-gray-400 truncate">Followers</p>
        </div>
      </div>

      <div class="bg-white rounded-xl shadow p-4">
        <p class="text-lg font-semibold">75.521</p>
        <p class="text-sm text-gray-400">Website Visits</p>
        <p class="text-xs text-gray-400 mt-1">Tracked from Google Analytics</p>
      </div>

      <div class="bg-white rounded-xl shadow p-4">
        <p class="text-lg font-semibold">$ 34,245</p>
        <p class="text-sm text-gray-400">Revenue</p>
        <p class="text-xs text-gray-400 mt-1">Last 24 Hours</p>
      </div>

      <div class="bg-white rounded-xl shadow p-4">
        <p class="text-lg font-semibold">184</p>
        <p class="text-sm text-gray-400">Bookings</p>
        <p class="text-xs text-red-400 mt-1">▲ Get More Space...</p>
      </div>
    </div>

    <!-- Employee Stats -->
    <div class="bg-orange-400 text-white rounded-xl shadow p-4 mb-4">
      <p class="text-lg font-bold">Employees Stats</p>
      <p class="text-sm">New employees on 15th September, 2016</p>
    </div>

    <!-- Task Tabs -->
    <div class="bg-green-500 text-white rounded-xl shadow p-4">
      <div class="flex gap-4 mb-2">
        <span class="underline font-semibold">Bugs</span>
        <span>Website</span>
        <span>Server</span>
      </div>
      <div class="bg-white rounded p-2 text-black text-sm">
        <p>✔️ Sign contract for "What are conference organizers afraid of?"</p>
      </div>
    </div>
  </div>
</template>

<script>

import { Chart, registerables } from 'chart.js';
import ChartDataLabels from 'chartjs-plugin-datalabels';

Chart.register(...registerables);
Chart.register(ChartDataLabels);

const BASE_URL = import.meta.env.VITE_API_URL;

  export default {
    name: 'Dashboard',
    data() {
    return {
      latestEmployees: [],
      salaryChart: null,
      // departments: [],
      chartData: {
          labels: [],
          datasets: [{
            label: 'จำนวนพนักงาน',
            data: [],
            backgroundColor: ['#4ade80', '#60a5fa', '#f472b6']
          }]
      }
    };
  },
  mounted() {
    this.fetchLatestEmployees();
    this.fetchSalaryData(); // 👈 เรียกข้อมูลเงินเดือน
    this.fetchdepartments(); // ดึงข้อมูลของแผนก
  },
  methods: {
    fetchLatestEmployees() {
      fetch(`${BASE_URL}/api_admin_dashboard/backend/api/get-latest-employees.php`)
        .then(res => res.json())
        .then(data => {
          this.latestEmployees = data;
        })
        .catch(err => {
          console.error('Error fetching employee data:', err);
        });
    },
    fetchdepartments(){
      fetch(`${BASE_URL}/api_admin_dashboard/backend/api/api_department_count.php`)
      .then(res => res.json())
  .then(result => {
    if(result.success) {
      const data = result.departments;  // <-- ใช้ departments จาก response

      const ctx = document.getElementById("departmentChart").getContext("2d");

      if (this.departmentChart) {
        this.departmentChart.destroy(); // เคลียร์ chart เก่าก่อนถ้ามี
      }

      this.departmentChart = new Chart(ctx, {
        type: "pie",
        data: {
          labels: data.map(item => item.department),
          datasets: [{
            label: "จำนวนพนักงาน",
            data: data.map(item => item.total),
            backgroundColor: [
              "#60a5fa", "#34d399", "#fbbf24", "#f87171", "#a78bfa", "#fb7185"
            ],
            borderRadius: 1,
          }]
        },
        options: {
          responsive: true,
          plugins: {
            legend: {
              position: 'right',  // แสดง legend ข้าง ๆ chart
            },
            tooltip: {
              enabled: true,
              callbacks: {
                label: function(context) {
                  const label = context.label || '';
                  const value = context.parsed || 0;
                  return `${label}: ${value} คน`;
                }
              }
            },
            datalabels: {   // plugin สำหรับแสดงตัวเลขบนแต่ละชิ้นส่วนของ Pie chart
              color: '#000',
              formatter: (value, ctx) => {
                return value; // แสดงตัวเลขจำนวนคนบน chart
              },
              font: {
                weight: 'bold',
                size: 14
              }
            }
          }
        },
        plugins: [ChartDataLabels],  // ต้องเพิ่ม plugin นี้เข้าไปด้วย
      });
    } else {
      console.error('Failed to fetch departments:', result.message);
    }
  })
  .catch(err => {
    console.error('Error fetching departments:', err);
  });
    },
    
    fetchSalaryData() {
      fetch(`${BASE_URL}/api_admin_dashboard/backend/api/get_top_salary.php`)
        .then(res => res.json())
        .then(result => {
          if (result.success) {
            const labels = result.data.map(e => e.full_name);
            const data = result.data.map(e => e.salary);
            console.log('Department data:', data);  // เช็คข้อมูล

            const ctx = document.getElementById('salaryChart');

            if (this.salaryChart) {
              this.salaryChart.destroy(); // เคลียร์ chart เก่า
            }

            this.salaryChart = new Chart(ctx, {
              type: 'bar',
              data: {
                labels,
                datasets: [{
                  label: 'เงินเดือน (บาท)',
                  data,
                  backgroundColor: '#34d399' // Tailwind green-400
                }]
              },
              options: {
                responsive: true,
                plugins: {
                  legend: {
                    display: false
                  },
                  title: {
                    display: true,
                    text: 'เงินเดือนพนักงานสูงสุด'
                  }
                },
                scales: {
                  y: {
                    beginAtZero: true,
                    ticks: {
                      callback: function(value) {
                        return new Intl.NumberFormat().format(value) + ' ฿';
                      }
                    }
                  }
                }
              }
            });
          }
        })
        .catch(err => {
          console.error('Error fetching salary chart data:', err);
        });
    },

  }
  };

</script>



<style scoped>
/* Optional custom styles */
</style>
