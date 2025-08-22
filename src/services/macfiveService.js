// macfiveService.js
import axios from "axios";
import Swal from "sweetalert2";
import qs from "qs";

const BASE_URL_AUTH = import.meta.env.VITE_API_URL_AUTH;
const BASE_URL_MAC_FIVEL = import.meta.env.VITE_API_URL_MAC_FIVE;

export async function getAuthToken() {
  const tokenData = JSON.parse(localStorage.getItem("token_address")) || null;
  const oneHour = 60 * 60 * 1000;
  const now = Date.now();

  if (tokenData && tokenData.token && now - tokenData.timestamp < oneHour) {
    return tokenData.token;
  }

  Swal.fire({
    title: "กำลังดำเนินการ...",
    text: "กำลังเพิ่มข้อมูล (ครั้งแรกจะใช้เวลาสักครู่)",
    allowOutsideClick: false,
    didOpen: () => Swal.showLoading(),
  });

  const secretKeyData = qs.stringify({
    secretKey1: import.meta.env.VITE_SECRET_KEY1,
    secretKey2: import.meta.env.VITE_SECRET_KEY2,
  });

  try {
    const authResponse = await axios.post(`${BASE_URL_AUTH}`, secretKeyData, {
      headers: { "Content-Type": "application/x-www-form-urlencoded" },
    });

    const token = authResponse.data.Token;
    if (!token) throw new Error("ไม่สามารถดึง token ได้");

    localStorage.setItem(
      "token_address",
      JSON.stringify({ token, timestamp: now })
    );

    Swal.close();
    return token;
  } catch (err) {
    Swal.fire({
      icon: "error",
      title: "ขอ Token ไม่สำเร็จ",
      text: "ไม่สามารถขอ token ได้ กรุณาลองใหม่อีกครั้ง",
    });
    throw err;
  }
}

export async function sendToMacfive(formdataapi, productListap, deliveryAddress) {
// export async function sendToMacfive(formData, selectedProducts, deliveryAddress) {
  const token = await getAuthToken();

  // const now = new Date();
  // const formatDate = (d) => d.toISOString().slice(0, 10);
  // const formatDateTime = (d) => d.toISOString().slice(0, 19).replace("T", " ");

  // สร้าง payload ตาม buildMacfivePayload ของคุณ
  const payload = buildMacfivePayload(formdataapi, productListap, deliveryAddress);
  // const payload = { /* copy payload logic ของคุณมาที่นี่ */ };

  console.log("📦 Payload Macfive:", payload);

  // return 'He he yep';

  try {
    const response = await axios.post(`${BASE_URL_MAC_FIVEL}`, payload, {
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: `Bearer ${token}`,
      },
    });

    console.log('Check response : ', response.data?.Success);

    return response.data;
  } catch (err) {
    console.error("❌ ส่งข้อมูล Macfive ไม่สำเร็จ:", err);
    throw err;
  }
}

export function buildMacfivePayload(formdataapi, productListap, deliveryAddress) {
  const now = new Date();
  const formatDate = (d) => d.toISOString().slice(0, 10);
  const formatDateTime = (d) => d.toISOString().slice(0, 19).replace("T", " ");

  const docNo = formdataapi.documentNo;
  const sale_no = localStorage.getItem("account") || "";

  console.log('🧩 Check productListap: ', productListap);
  console.log('🧩 Check deliveryAddress: ', deliveryAddress);

  // 🧩 รวม promotions และ gifts จาก products
  const productPromotions = productListap.flatMap((item) => item.promotions || []);
  console.log('🧩 Check productPromotions: ', productPromotions);
  const productGifts = productListap.flatMap((item) => item.gifts || []);
  console.log('🧩 Check productGifts: ', productGifts);

  let allPromotions = [...(formdataapi.promotions || []), ...productPromotions];
  let allGifts = [...(formdataapi.gifts || []), ...productGifts]; // , ...(gifts || [])

  // 🎯 filter ของซ้ำ
  allPromotions = allPromotions.filter(
    (promo, index, self) =>
      index === self.findIndex((p) => p.pro_sn === promo.pro_sn && p.pro_activity_id === promo.pro_activity_id)
  );
  allGifts = allGifts.filter(
    (gift, index, self) =>
      index === self.findIndex((g) => g.pro_sn === gift.pro_sn && g.pro_activity_id === gift.pro_activity_id)
  );

  const filteredPromotions = allPromotions.filter((promo) => promo.pro_sn !== "P02-ZZ-9999");

  const countProducts = productListap.length;
  const countGifts = allGifts.length;
  const countPromotions = filteredPromotions.length;
  const totalItems = countProducts + countGifts + countPromotions;

  const discountMacfive = formdataapi.totalDiscount;
  const discT1CF = (discountMacfive * 100) / formdataapi.final_total_price;
  const discFT2CC = (formdataapi.final_total_price * 7) / 107;
  const discFT2CF = ((discFT2CC * 100) / formdataapi.final_total_price).toFixed(5);

  return {
    hrows: {
      MH_date: formatDateTime(now),
      MH_type: "PS",
      MH_vnumber: docNo,
      MH_process: 9,
      MH_supcus: formdataapi.customerCode,
      MH_noItems: totalItems,
      MH_vatRate: 7,
      MH_vatTotal: parseFloat(formdataapi.final_total_price) * 0.07,
      MH_netTotal: parseFloat(formdataapi.final_total_price),
      MH_status: 15,
      MH_per: sale_no || "DP001",
      MH_site: deliveryAddress?.id || 0,
      MH_deldate: formatDate(now),
      MH_totalCOG: parseFloat(formdataapi.final_total_price),
      MH_discT1: discT1CF,
      MH_discF1: discountMacfive,
      MH_discT2: discFT2CF,
      MH_discF2: (parseFloat(formdataapi.final_total_price - discountMacfive) * 7) / 107,
      MH_flow: 0,
      MH_cur: 0,
      MH_Note: `// ${docNo}`,
      MH_cnect: 3,
      MH_cancel: 0,
    },
    erows: {
      ME_date: formatDateTime(now),
      ME_type: "PS",
      ME_vnumber: docNo,
      ME_supcus: formdataapi.customerCode,
      ME_termCX: "7|",
      ME_termPX: "100|",
      ME_termAX: `${parseFloat(formdataapi.final_total_price)}|`,
      ME_termDX: `${formatDate(now)}|`,
      ME_cashRec: 0,
      ME_ccRec: parseFloat(formdataapi.final_total_price),
    },
    krows: {
      MK_date: formatDateTime(now),
      MK_name: formdataapi.fullName,
      MK_addr: formdataapi.address || 1,
      MK_tel: formdataapi.phone || 1,
    },
    lrows: [
      // 🛒 products
      ...productListap.map((item, index) => ({
        ML_date: formatDateTime(now),
        ML_type: "PS",
        ML_vnumber: docNo,
        ML_per: sale_no || "DP001",
        ML_supcus: formdataapi.customerCode,
        ML_stk: item.pro_sn || "N/A",
        ML_sto: "MAIN",
        ML_item: index + 1,
        ML_quan: parseFloat(item.pro_quantity),
        ML_cog: parseFloat(item.pro_total_price || 0),
        ML_netL: parseFloat(item.pro_total_price || 0),
        ML_cut: 1,
        ML_unit: item.pro_unit || "PCS",
        ML_des: item.pro_erp_title + '' + (item.pro_goods_sku_text || ""),
        ML_addcost: 0,
        ML_discL: 0,
        ML_deldate: formatDate(now),
        ML_uprice: parseFloat(item.pro_unit_price),
        ML_Note: "item",
      })),
      // 🎁 gifts
      ...allGifts.map((gift, index) => ({
        ML_date: formatDateTime(now),
        ML_type: "PS",
        ML_vnumber: docNo,
        ML_per: sale_no || "DP001",
        ML_supcus: formdataapi.customerCode,
        ML_stk: gift.pro_sn || gift.prosn || "N/A",
        ML_sto: "MAIN",
        ML_item: productListap.length + index + 1,
        ML_quan: gift.pro_goods_num || 0,
        ML_cog: 0,
        ML_netL: 0,
        ML_cut: 0,
        ML_unit: gift.pro_unit || "PCS",
        ML_des: gift.title + '' + (gift.pro_goods_sku_text || ""),
        ML_addcost: 0,
        ML_discL: 0,
        ML_deldate: formatDate(now),
        ML_uprice: 0,
        ML_Note: gift.ML_Note || "gift",
      })),
      // 📢 promotions
      ...filteredPromotions.map((promo, index) => ({
        ML_date: formatDateTime(now),
        ML_type: "PS",
        ML_vnumber: docNo,
        ML_per: sale_no || "DP001",
        ML_supcus: formdataapi.customerCode,
        ML_stk: promo.pro_sn || "N/A",
        ML_sto: "MAIN",
        ML_item: productListap.length + allGifts.length + index + 1,
        ML_quan: promo.pro_goods_num || 0,
        ML_cog: 0,
        ML_netL: 0,
        ML_cut: 0,
        ML_unit: promo.pro_unit || "PCS",
        ML_des: promo.title,
        ML_addcost: 0,
        ML_discL: 0,
        ML_deldate: formatDate(now),
        ML_uprice: 0,
        ML_Note: promo.ML_Note || "promotion",
      })),
    ],
  };
}
