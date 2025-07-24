// services/activityLogger.js
import axios from "axios";
// import Swal from "sweetalert2";
const BASE_URL = import.meta.env.VITE_API_URL_LOCAL;

export const logActivity = async (activity, pageName) => {
  try {
    const account = localStorage.getItem("account");
    const ip = await axios.get("https://api.ipify.org?format=json");

    const response = await axios.post(
      `${BASE_URL}/api_admin_dashboard/backend/api/log/activity.php`,
      {
        account,
        ip: ip.data.ip,
        activity,
        page: pageName,
        timestamp: new Date().toISOString(),
      },
      {
        headers: {
          "Content-Type": "application/json",
        },
      }
    );

    console.log("Check response.data:", response.data);

    // if (response.data?.success) {
    //   Swal.fire({
    //     title: "เพิ่มข้อมูลสำเร็จ",
    //     text: "เพิ่มข้อมูล logActivity สำเร็จ",
    //     icon: "success",
    //   });
    //   console.log("response.data.message: ", response.data.message);
    // } else {
    //   Swal.fire({
    //     title: "เพิ่มข้อมูลไม่สำเร็จ",
    //     text: "เพิ่มข้อมูล logActivity ไม่สำเร็จ",
    //     icon: "error",
    //   });
    //   console.error("response.data.message: ", response.data.message);
    // }
  } catch (err) {
    console.error("❌ Logging activity failed:", err);
  }
};
