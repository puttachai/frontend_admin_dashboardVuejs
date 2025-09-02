import axios from 'axios';
const BASE_URL = import.meta.env.VITE_API_URL;

export const submitProducts = async (selectedProducts, token) => {
    const productsForApi = selectedProducts.map(product => ({
        pro_activity_id: product.pro_activity_id || 0,
        pro_goods_id: product.pro_goods_id,
        pro_goods_price: parseFloat(product.pro_unit_price) || 0,
        pro_sku_price_id: product.pro_sku_price_id || product.pro_id || 0,
        pro_erp_title: product.pro_erp_title || '',
        pro_goods_num: Number(product.pro_goods_num || 1),
        pro_image: product.pro_images,
        pro_sn: product.pro_sn,
        pro_title: product.pro_title,
        pro_units: product.pro_units
    })).filter(p => p.pro_goods_num > 0);

    if (!productsForApi.length) return null;

    const response = await axios.post(
        `${BASE_URL}/cart_out/index`,
        { products: productsForApi },
        { headers: { token, 'Content-Type': 'application/json' } }
    );

    return response.data;
};
