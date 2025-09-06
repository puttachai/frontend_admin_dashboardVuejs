
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

export async function sendToMacfive(formdataapi, productListap, servicesPull, deliveryAddress) {
// export async function sendToMacfive(formData, selectedProducts, deliveryAddress) {
  const token = await getAuthToken();

  // const now = new Date();
  // const formatDate = (d) => d.toISOString().slice(0, 10);
  // const formatDateTime = (d) => d.toISOString().slice(0, 19).replace("T", " ");

  // สร้าง payload ตาม buildMacfivePayload ของคุณ
  const payload = buildMacfivePayload(formdataapi, productListap, servicesPull, deliveryAddress);
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


// // helper functions
// function round(value, decimals = 2) {
//   return Number(Math.round(value + "e" + decimals) + "e-" + decimals);
// }

// function number_format(number, decimals = 2, dec_point = ".", thousands_sep = ",") {
//   const n = !isFinite(+number) ? 0 : +number;
//   const prec = !isFinite(+decimals) ? 0 : Math.abs(decimals);
//   const sep = thousands_sep;
//   const dec = dec_point;

//   let s = n.toFixed(prec).split(".");
//   if (s[0].length > 3) {
//     s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
//   }
//   if ((s[1] || "").length < prec) {
//     s[1] = s[1] || "";
//     s[1] += new Array(prec - s[1].length + 1).join("0");
//   }
//   return s.join(dec);
// }


export function buildMacfivePayload(formdataapi, productListap, servicesPull, deliveryAddress) {
  const now = new Date();
  const formatDate = (d) => d.toISOString().slice(0, 10);
  const formatDateTime = (d) => d.toISOString().slice(0, 19).replace("T", " ");

  const docNo = formdataapi.documentNo;
  const sale_no = localStorage.getItem("account") || "";

  console.log('🧩 Check productListap: ', productListap);
  console.log('🧩 Check servicesPull: ', servicesPull);
  console.log('🧩 Check deliveryAddress: ', deliveryAddress);

  // 🧩 รวม promotions และ gifts จาก products
  const productPromotions = productListap.flatMap((item) => item.promotions || []);
  console.log('🧩 Check productPromotions: ', productPromotions);

  const productGifts = productListap.flatMap((item) => item.gifts || []);
  console.log('🧩 Check productGifts: ', productGifts);



    formdataapi.promotions = formdataapi.promotions.map(promo => {

      return {
          ...promo,
          pro_sn: promo.pro_sn || promo.prosn || 'noting',
      };

    });

    console.log('🧩 Check formdataapi.promotions: ', formdataapi.promotions);

    formdataapi.gifts = formdataapi.gifts.map(gift => {

      return {
          ...gift,
          pro_sn: gift.pro_sn || gift.prosn || 'noting',
      };

    });

    console.log('🧩 Check formdataapi.gifts: ', formdataapi.gifts);

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

   console.log('🧩 Check allPromotions: ', allPromotions);
   console.log('🧩 Check productGifts: ', allGifts);

  const filteredPromotions = allPromotions.filter((promo) => promo.pro_sn !== "P02-ZZ-9999");

  const countProducts = productListap.length;
  const countGifts = allGifts.length;
  const countPromotions = filteredPromotions.length;
  const countservices = servicesPull.length;
  const totalItems = countProducts + countGifts + countPromotions + countservices;

  // ใช้ได้

  // //
  // const discountMacfive = formdataapi.totalDiscount;
  // const discT1CF = (discountMacfive * 100) / formdataapi.final_total_price;

  // const discFT2CC = (formdataapi.final_total_price * 7) / 107;
  // const discFT2CF = ((discFT2CC * 100) / formdataapi.final_total_price).toFixed(5);
  // //

  //  Last version

  // มีอยู่แล้ว
const afterDiscount1 = parseFloat(formdataapi.final_total_price); // 1540
const discount1 = parseFloat(formdataapi.totalDiscount); // 30

// ย้อนกลับหา subtotal ก่อนลด
const subtotal = afterDiscount1 + discount1; // 1540 + 30 = 1570

// % ส่วนลด 1
const discT1CF = (discount1 * 100) / subtotal; // 1.91082803

// ส่วนลด 2 (VAT backout)
const discount2 = (afterDiscount1 * 7) / 107; // 100.75

// % ส่วนลด 2
const discT2CF = (discount2 * 100) / afterDiscount1; // 6.54220

// VAT = discount2
const vat = discount2; // 100.75

// Net total
const netTotal = afterDiscount1 - discount2 + vat; // 1540

  // New old
  // const discount_sum = formdataapi.final_total_price - discountMacfive; // 9570
  // const discFT       = round(discount_sum, 2);    // 9570.00

  // // ปัด 7/107 เป็น 5 ตำแหน่งก่อน แล้วคูณ 100
  // const vatRatio5   = round(7 / 107, 5);                           // 0.06542
  // const MH_discT2   = number_format(vatRatio5 * 100, 5, '.', ''); // 6.54200


  // const MH_discF2   = number_format(discFT * vatRatio5, 2, '.', ''); // 626.07

  // const discT1CFTTT = discountMacfive * 100 / formdataapi.final_total_price;

  return {
    hrows: {
      MH_date: formatDateTime(now),
      MH_type: "PS",
      MH_vnumber: docNo,
      MH_process: 9,
      MH_supcus: formdataapi.customerCode,
      MH_noItems: totalItems,
      MH_vatRate: 7,
      // MH_vatTotal: parseFloat(formdataapi.final_total_price) * 0.07,
      // MH_netTotal: parseFloat(formdataapi.final_total_price),
      MH_status: 15,
      MH_per: sale_no || "DP001",
      MH_site: deliveryAddress?.id || 0,
      MH_deldate: formatDate(now),

      // MH_vatTotal: parseFloat(formdataapi.final_total_price) * 0.07,
      // MH_netTotal: parseFloat(formdataapi.final_total_price),
      // MH_totalCOG: parseFloat(formdataapi.final_total_price),
      MH_vatTotal: vat,             // 100.75
      MH_netTotal: netTotal,        // 1540.00
      MH_totalCOG: afterDiscount1,  // 1540

      // New
      // MH_discT1: discT1CFTTT, // <-- แปลงเป็น int
      // MH_discF1:  Math.round(discountMacfive),
      // MH_discT2: round(MH_discT2,5),
      // MH_discF2: round(MH_discF2,5),

      // new old
      // MH_discT1: discT1CF,
      // MH_discF1: discountMacfive,
      // MH_discT2: discFT2CF,
      // MH_discF2: (parseFloat(formdataapi.final_total_price - discountMacfive) * 7) / 107,

      MH_discF1: discount1,         // 30
      MH_discT1: discT1CF,          // 1.91082803
      MH_discF2: discount2,         // 100.75
      MH_discT2: discT2CF,          // 6.54220

      // old
      // MH_discT1: discountMacfive,
      // MH_discT1: discT1CF,
      // MH_discF1: discountMacfive,
      // MH_discT2: discFT2CF,
      // MH_discF2: (parseFloat(formdataapi.final_total_price - discountMacfive) * 7) / 107,

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
        ML_cog: parseFloat(item.pro_total_price || 0).toFixed(2),
        ML_netL: parseFloat(item.pro_total_price || 0).toFixed(2),
        ML_cut: 1,
        ML_unit: item.pro_unit || "PCS",
        ML_des: item.pro_erp_title + '' + (item.pro_goods_sku_text || ""),
        ML_addcost: 0,
        ML_discL: 0,
        ML_deldate: formatDate(now),
        ML_uprice: parseFloat(item.pro_unit_price).toFixed(2),
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

      // 🛠️ services
      ...servicesPull.map((service, index) => ({
        ML_date: formatDateTime(now),
        ML_type: "PS", // STKpsi
        ML_vnumber: docNo,
        ML_per: sale_no || "DP001",
        ML_supcus: formdataapi.customerCode,
        ML_stk: service.service_code || "N/A", // STKcode || STKcode2 // service_code
        ML_sto: "MAIN",
        ML_item: productListap.length + allGifts.length + filteredPromotions.length + index + 1,
        ML_quan: service.qty || 0, // qty
        ML_cog: parseFloat(service.price).toFixed(2),
        ML_netL: parseFloat(service.price).toFixed(2),
        ML_cut: 0,
        ML_unit: service.service_unit || "PCS", // STKuname1
        ML_des: service.service_name, // STKdescT1
        ML_addcost: 0,
        ML_discL: 0,
        ML_deldate: formatDate(now),
        ML_uprice: parseFloat(service.price).toFixed(2),
        ML_Note:"Services", // service.ML_Note ||
      })),
    ],
  };
}
