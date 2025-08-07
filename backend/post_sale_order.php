<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: POST");

// require_once('conndb.php');
require_once(__DIR__ . '/../db/conndb.php');

$response = [];

function convertDateToMySQLFormat($date)
{
    if (!$date) return null;
    $parts = explode('/', $date);
    if (count($parts) === 3) {
        return "{$parts[2]}-{$parts[1]}-{$parts[0]}";
    }
    return null;
}

try {
    $documentNo = $_POST['documentNo'] ?? '';
    if (empty($documentNo)) throw new Exception("ไม่พบ documentNo");

    $sellDate = convertDateToMySQLFormat($_POST['sellDate'] ?? '');
    $deliveryDate = convertDateToMySQLFormat($_POST['deliveryDate'] ?? '');

    // ดึง order_id
    $stmtOrder = $pdo->prepare("SELECT id FROM sale_order WHERE document_no = ?");
    $stmtOrder->execute([$documentNo]);
    $order = $stmtOrder->fetch(PDO::FETCH_ASSOC);

    if (!$order) {
        // ✅ ถ้ายังไม่มี order นี้ ให้สร้างใหม่
        $stmtInsertOrder = $pdo->prepare("INSERT INTO sale_order (
            document_no, list_code, sell_date, reference, channel, tax_type, 
            full_name, customer_code, phone, email, address, 
            receiver_name, receiver_phone, receiver_email, receiver_address, note, 
            delivery_date, tracking_no, delivery_type, total_discount, delivery_fee, 
            discount_qty, final_total_price, 
            price_before_tax, tax_value, price_with_tax
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

        $stmtInsertOrder->execute([
            $documentNo,
            $_POST['listCode'] ?? '',
            $sellDate,
            $_POST['reference'] ?? '',
            $_POST['channel'] ?? '',
            $_POST['taxType'] ?? '',
            $_POST['fullName'] ?? '',
            $_POST['customerCode'] ?? '',
            $_POST['phone'] ?? '',
            $_POST['email'] ?? '',
            $_POST['address'] ?? '',
            $_POST['receiverName'] ?? '',
            $_POST['receiverPhone'] ?? '',
            $_POST['receiverEmail'] ?? '',
            $_POST['receiverAddress'] ?? '',
            $_POST['note'] ?? '',
            $deliveryDate,
            $_POST['trackingNo'] ?? '',
            $_POST['deliveryType'] ?? '',

            $_POST['totalDiscount'] ?? 0,
            $_POST['deliveryFee'] ?? 0,
            $_POST['pro_discount'] ?? 0,
            $_POST['final_total_price'] ?? 0,
            //
            $_POST['price_before_tax'] ?? 0,  // เพิ่มนี้
            $_POST['tax_value'] ?? 0,         // เพิ่มนี้
            $_POST['price_with_tax'] ?? 0     // เพิ่มนี้
        ]);

        $order_id = $pdo->lastInsertId(); // เก็บ order_id ที่สร้างใหม่ไว้ใช้ต่อ

        $delivery_address = json_decode($_POST['deliveryAddress'] ?? '[]', true);

        if ($delivery_address) {
            $stmtInsertAddress = $pdo->prepare("INSERT INTO so_delivery_address (
        customer_code, customer_id, address_line1, address_line2, address_line3, phone, zone_code, order_id
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");

            $stmtInsertAddress->execute([
                $_POST['customerCode'] ?? '',
                $delivery_address['DC_id'] ?? '',
                $delivery_address['DC_add1'] ?? '',
                $delivery_address['DC_add2'] ?? '',
                $delivery_address['DC_add3'] ?? '',
                $delivery_address['DC_tel'] ?? '',
                $delivery_address['DC_zone'] ?? 'ไม่มีข้อมูล', // zone_code ยังไม่มีส่งมาก็ใส่ค่า default ไปก่อน
                $order_id
            ]);
        } else {
            $response['warning'] = 'ไม่มีข้อมูลที่อยู่สำหรับจัดส่ง';
        }
    } else {
        $order_id = $order['id'];

        // ✅ ทำการอัปเดตคำสั่งขายเดิม
        $stmt = $pdo->prepare("UPDATE sale_order SET 
            list_code = ?, sell_date = ?, reference = ?, channel = ?, tax_type = ?, 
            full_name = ?, customer_code = ?, phone = ?, email = ?, address = ?, 
            receiver_name = ?, receiver_phone = ?, receiver_email = ?, receiver_address = ?, note = ?, 
            delivery_date = ?, tracking_no = ?, delivery_type = ?, total_discount = ?, delivery_fee = ?, 
            discount_qty = ?,final_total_price = ?,
            price_before_tax = ?, tax_value = ?, price_with_tax = ? 
            WHERE id = ?");
        $stmt->execute([
            $_POST['listCode'] ?? '',
            $sellDate,
            $_POST['reference'] ?? '',
            $_POST['channel'] ?? '',
            $_POST['taxType'] ?? '',
            $_POST['fullName'] ?? '',
            $_POST['customerCode'] ?? '',
            $_POST['phone'] ?? '',
            $_POST['email'] ?? '',
            $_POST['address'] ?? '',
            $_POST['receiverName'] ?? '',
            $_POST['receiverPhone'] ?? '',
            $_POST['receiverEmail'] ?? '',
            $_POST['receiverAddress'] ?? '',
            $_POST['note'] ?? '',
            $deliveryDate,
            $_POST['trackingNo'] ?? '',
            $_POST['deliveryType'] ?? '',
            $_POST['totalDiscount'] ?? 0,
            $_POST['deliveryFee'] ?? 0,
            $_POST['pro_discount'] ?? 0,
            $_POST['final_total_price'] ?? 0,
            //
            $_POST['price_before_tax'] ?? 0,  // เพิ่มนี้
            $_POST['tax_value'] ?? 0,         // เพิ่มนี้
            $_POST['price_with_tax'] ?? 0,    // เพิ่มนี้
            $order_id
        ]);
    }

    // อัปเดตหรือเพิ่มสินค้า
    $products = json_decode($_POST['productList'] ?? '[]', true);
    foreach ($products as $product) {

        $stmtCheck = $pdo->prepare("SELECT id FROM sale_order_items 
    WHERE order_id = ? AND pro_id = ? AND pro_activity_id = ? AND unit_price = ? AND total_price = ?");
        $stmtCheck->execute([
            $order_id,
            $product['pro_sku_price_id'],
            $product['pro_activity_id'] ?? null,
            $product['pro_unit_price'] ?? '',
            // $product['pro_sn'] ?? '',
            $product['pro_total_price'] ?? 0
        ]);

        $existing = $stmtCheck->fetch(PDO::FETCH_ASSOC);

        if ($existing) {
            $stmtUpdate = $pdo->prepare("UPDATE sale_order_items SET 
                pro_id = ?, pro_name = ?, pro_title = ?, pro_goods_sku_text = ?, qty = ?, stock = ?, unit_price = ?, discount = ?, 
                total_price = ?, pro_images = ?, unit = ?, st = ?, pro_activity_id = ? , activity_id = ?, st = ?, pro_goods_id = ?
                WHERE id = ?");
            $stmtUpdate->execute([
                $product['pro_sku_price_id'] ?? 0,
                $product['pro_erp_title'] ?? '',
                $product['pro_title'] ?? '',
                $gift['pro_goods_sku_text'] ?? '',
                $product['pro_goods_num'],
                $product['stock'] ?? 0,
                // $product['pro_quantity'] ?? 0,
                $product['pro_unit_price'] ?? 0,
                $product['pro_discount'] ?? 0,
                $product['pro_total_price'] ?? 0,
                $product['pro_image'] ?? '',
                $product['pro_units'] ?? '',
                $product['pro_sn'] ?? '',
                $product['st'] ?? 0,
                $product['pro_activity_id'] ?? 0,
                $product['activity_id'] ?? 0,
                $product['pro_goods_id'] ?? 0,
                $existing['id']


            ]);

            // --- 2) Promotions ที่อยู่ในตัวสินค้า ---
            if (!empty($product['promotions'])) {
                foreach ($product['promotions'] as $promo) {
                    // ตรวจสอบก่อนว่ามีอยู่แล้วหรือยัง (เช็คด้วย order_id + pro_activity_id + prosn)
                    $stmt = $pdo->prepare("
                SELECT id FROM sale_order_promotions
                 WHERE order_id = ? 
                   AND pro_activity_id = ? 
                   AND pro_sku_price_id = ?
            ");
                    $stmt->execute([
                        $order_id,
                        $promo['pro_activity_id'] ?? null,
                        $promo['pro_sku_price_id'] ?? null
                    ]);
                    if ($stmt->fetch()) {
                        // UPDATE ถ้ามี
                        $upd = $pdo->prepare("
                    UPDATE sale_order_promotions SET
                      title = ?, ML_Note = ?, note = ?, st = ?, activity_id = ?, 
                      pro_goods_id = ?, pro_goods_num = ?, stock = ?, pro_image = ?, user_id = ?
                    WHERE id = ?
                ");
                        $upd->execute([
                            $promo['title'],
                            $promo['ML_Note'],
                            $promo['note'],
                            $promo['st'] ? 1 : 0,
                            $promo['activity_id'] ?? 0,
                            $promo['pro_goods_id'],
                            $promo['pro_goods_num'],
                            $promo['stock'],
                            $promo['pro_image'],
                            $promo['user_id'],
                            // id ที่เช็คเจอ
                            $stmt->fetchColumn()
                        ]);
                    } else {
                        // INSERT ถ้ายังไม่มี sale_order_item_id
                        $ins = $pdo->prepare("
                    INSERT INTO sale_order_promotions (
                        order_id, pro_sn,
                        pro_activity_id, pro_sku_price_id,
                        title, ML_Note, note, st, activity_id,
                        pro_goods_id, pro_goods_num, stock, pro_image, user_id
                    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                ");
                // , ?
                        $ins->execute([
                            $order_id,
                            // $item_id,
                            $promo['prosn'] ?? $promo['pro_sn'],
                            $promo['pro_activity_id'] ?? null,
                            $promo['pro_sku_price_id'] ?? null,
                            $promo['title'],
                            $promo['ML_Note'],
                            $promo['note'],
                            $promo['st'] ? 1 : 0,
                            $promo['activity_id'] ?? 0,
                            $promo['pro_goods_id'],
                            $promo['pro_goods_num'],
                            $promo['stock'],
                            $promo['pro_image'],
                            $promo['user_id'],
                        ]);
                    }
                }
            }

            // --- 3) Gifts ที่อยู่ในตัวสินค้า ---
            if (!empty($product['gifts'])) {
                foreach ($product['gifts'] as $gift) {
                    $stmt = $pdo->prepare("
                SELECT id FROM sale_order_gifts
                 WHERE order_id = ?
                   AND pro_activity_id = ?
                   AND pro_sku_price_id = ?
            ");
                    $stmt->execute([
                        $order_id,
                        $gift['pro_activity_id'] ?? null,
                        $gift['pro_sku_price_id'] ?? null
                    ]);
                    if ($stmt->fetch()) {
                        // UPDATE
                        $upd = $pdo->prepare("
                    UPDATE sale_order_gifts SET
                      title = ?, ML_Note = ?, pro_goods_sku_text = ?, note = ?, st = ?, activity_id = ?,
                      pro_goods_id = ?, pro_goods_num = ?, stock = ?, pro_image = ?, user_id = ?
                    WHERE id = ?
                ");
                        $upd->execute([
                            $gift['title'],
                            $gift['ML_Note'],
                            $gift['pro_goods_sku_text'] ?? '',
                            $gift['note'],
                            $gift['st'] ? 1 : 0,
                            $gift['activity_id'] ?? 0,
                            $gift['pro_goods_id'],
                            $gift['pro_goods_num'],
                            $gift['stock'],
                            $gift['pro_image'],
                            $gift['user_id'],
                            $stmt->fetchColumn()
                        ]);
                    } else {
                        // INSERT sale_order_item_id
                        $ins = $pdo->prepare("
                    INSERT INTO sale_order_gifts (
                        order_id, pro_sn, pro_goods_sku_text ,
                        pro_activity_id, pro_sku_price_id,
                        title, ML_Note, note, st, activity_id,
                        pro_goods_id, pro_goods_num, stock, pro_image, user_id
                    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                ");
                // , ?
                        $ins->execute([
                            $order_id,
                            // $item_id,
                            // $gift['prosn'],
                            $gift['prosn'] ?? $gift['pro_sn'],
                            $gift['pro_goods_sku_text'] ?? '',
                            $gift['pro_activity_id'] ?? null,
                            $gift['pro_sku_price_id'] ?? null,
                            $gift['title'],
                            $gift['ML_Note'],
                            $gift['note'],
                            $gift['st'] ? 1 : 0,
                            $gift['activity_id'] ?? 0,
                            $gift['pro_goods_id'],
                            $gift['pro_goods_num'],
                            $gift['stock'],
                            $gift['pro_image'],
                            $gift['user_id'],
                        ]);
                    }
                }
            }
        } else {
            $stmtInsert = $pdo->prepare("INSERT INTO sale_order_items (
    order_id, pro_id, pro_name, pro_title, pro_goods_sku_text, sn, qty, stock, unit_price, discount, total_price, pro_images, unit, st, pro_activity_id, activity_id, pro_goods_id
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

            $stmtInsert->execute([
                $order_id,
                $product['pro_sku_price_id'] ?? 0,
                $product['pro_erp_title'] ?? '',
                $product['pro_title'] ?? '',
                $product['pro_goods_sku_text'] ?? '',
                
                $product['pro_sn'] ?? '',
                $product['pro_goods_num'],
                $product['stock'] ?? 0,
                // $product['pro_quantity'] ?? 0,
                $product['pro_unit_price'] ?? 0,
                $product['pro_discount'] ?? 0,
                $product['pro_total_price'] ?? 0,
                $product['pro_image'] ?? '',
                $product['pro_units'] ?? '',
                $product['st'] ?? 0,
                $product['pro_activity_id'] ?? 0,
                $product['activity_id'] ?? 0,
                $product['pro_goods_id'] ?? 0,
            ]);

            $stmtInsert2 = [];

            $stmtInsert2 = [
                $order_id,
                $product['pro_id'] ?? 0,
                $product['pro_erp_title'] ?? '',
                $product['pro_sn'] ?? '',
                $product['pro_quantity'] ?? 0,
                $product['pro_unit_price'] ?? 0,
                $product['pro_discount'] ?? 0,
                $product['pro_total_price'] ?? 0,
                $product['pro_images'] ?? '',
                $product['pro_units'] ?? '',
                $product['st'] ?? 0,
                $product['stock'] ?? 0,
                $product['pro_activity_id'] ?? null
            ];

            // --- 2) Promotions ที่อยู่ในตัวสินค้า ---
            if (!empty($product['promotions'])) {
                foreach ($product['promotions'] as $promo) {
                    // ตรวจสอบก่อนว่ามีอยู่แล้วหรือยัง (เช็คด้วย order_id + pro_activity_id + prosn)
                    $stmt = $pdo->prepare("
                SELECT id FROM sale_order_promotions
                 WHERE order_id = ? 
                   AND pro_activity_id = ? 
                   AND pro_sku_price_id = ?
            ");
                    $stmt->execute([
                        $order_id,
                        $promo['pro_activity_id'] ?? null,
                        $promo['pro_sku_price_id'] ?? null
                    ]);
                    if ($stmt->fetch()) {
                        // UPDATE ถ้ามี
                        $upd = $pdo->prepare("
                    UPDATE sale_order_promotions SET
                      title = ?, ML_Note = ?, note = ?, st = ?, activity_id = ?, 
                      pro_goods_id = ?, pro_goods_num = ?, stock = ?, pro_image = ?, user_id = ?
                    WHERE id = ?
                ");
                        $upd->execute([
                            $promo['title'],
                            $promo['ML_Note'],
                            $promo['note'],
                            $promo['st'] ? 1 : 0,
                            $promo['activity_id'] ?? 0,
                            $promo['pro_goods_id'],
                            $promo['pro_goods_num'],
                            $promo['stock'],
                            $promo['pro_image'],
                            $promo['user_id'],
                            // id ที่เช็คเจอ
                            $stmt->fetchColumn()
                        ]);
                    } else {
                        // INSERT ถ้ายังไม่มี
                        $ins = $pdo->prepare("
                    INSERT INTO sale_order_promotions (
                        order_id, pro_sn,
                        pro_activity_id, pro_sku_price_id,
                        title, ML_Note, note, st, activity_id,
                        pro_goods_id, pro_goods_num, stock, pro_image, user_id
                    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                ");
                //, ?
                        $ins->execute([
                            $order_id,
                            // $item_id,
                            $promo['prosn'] ??  $promo['pro_sn'],
                            // $promo['prosn'],
                            $promo['pro_activity_id'] ?? null,
                            $promo['pro_sku_price_id'] ?? null,
                            $promo['title'],
                            $promo['ML_Note'],
                            $promo['note'],
                            $promo['st'] ? 1 : 0,
                            $promo['activity_id'] ?? 0,
                            $promo['pro_goods_id'],
                            $promo['pro_goods_num'],
                            $promo['stock'],
                            $promo['pro_image'],
                            $promo['user_id'],
                        ]);
                    }
                }
            }

            // --- 3) Gifts ที่อยู่ในตัวสินค้า ---
            if (!empty($product['gifts'])) {
                foreach ($product['gifts'] as $gift) {
                    $stmt = $pdo->prepare("
                SELECT id FROM sale_order_gifts
                 WHERE order_id = ?
                   AND pro_activity_id = ?
                   AND pro_sku_price_id = ?
            ");
                    $stmt->execute([
                        $order_id,
                        $gift['pro_activity_id'] ?? null,
                        $gift['pro_sku_price_id'] ?? null
                    ]);
                    if ($stmt->fetch()) {
                        // UPDATE
                        $upd = $pdo->prepare("
                    UPDATE sale_order_gifts SET
                      title = ?, ML_Note = ?, pro_goods_sku_text = ?, note = ?, st = ?, activity_id = ?,
                      pro_goods_id = ?, pro_goods_num = ?, stock = ?, pro_image = ?, user_id = ?
                    WHERE id = ?
                ");
                        $upd->execute([
                            $gift['title'],
                            $gift['ML_Note'],
                            $gift['pro_goods_sku_text'] ?? '',
                            $gift['note'],
                            $gift['st'] ? 1 : 0,
                            $gift['activity_id'] ?? 0,
                            $gift['pro_goods_id'],
                            $gift['pro_goods_num'],
                            $gift['stock'],
                            $gift['pro_image'],
                            $gift['user_id'],
                            $stmt->fetchColumn()
                        ]);
                    } else {
                        // INSERT sale_order_item_id
                        $ins = $pdo->prepare("
                    INSERT INTO sale_order_gifts (
                        order_id, pro_sn, pro_goods_sku_text ,
                        pro_activity_id, pro_sku_price_id,
                        title, ML_Note, note, st, activity_id,
                        pro_goods_id, pro_goods_num, stock, pro_image, user_id
                    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                ");
                // , ?
                        $ins->execute([
                            $order_id,
                            // $item_id,
                            $gift['prosn'] ?? $gift['pro_sn'],
                            $gift['pro_goods_sku_text'] ?? '',
                            // $gift['prosn'],
                            $gift['pro_activity_id'] ?? null,
                            $gift['pro_sku_price_id'] ?? null,
                            $gift['title'],
                            $gift['ML_Note'],
                            $gift['note'],
                            $gift['st'] ? 1 : 0,
                            $gift['activity_id'] ?? 0,
                            $gift['pro_goods_id'],
                            $gift['pro_goods_num'],
                            $gift['stock'],
                            $gift['pro_image'],
                            $gift['user_id'],
                        ]);
                    }
                }
            }
        }
    }

    // // แก้ loop promotions เป็นแบบนี้
    // $promotions = json_decode($_POST['promotions'] ?? '[]', true);
    // foreach ($promotions as $promo) {
    //     // เช็คด้วย order_id + pro_activity_id (หรือ pro_sn ก็ได้)
    //     $stmtCheckPromo = $pdo->prepare("
    //     SELECT id 
    //     FROM sale_order_promotions 
    //     WHERE order_id = ? 
    //       AND pro_activity_id = ? 
    //       AND pro_sn = ?
    // ");
    //     $stmtCheckPromo->execute([
    //         $order_id,
    //         $promo['pro_activity_id'] ?? null,
    //         $promo['prosn'] ?? null
    //     ]);
    //     $existingPromo = $stmtCheckPromo->fetch(PDO::FETCH_ASSOC);

    //     if (!$existingPromo) {
    //         $stmtInsertPromo = $pdo->prepare("
    //         INSERT INTO sale_order_promotions (
    //             order_id, title, ML_Note, note, st, pro_activity_id, activity_id, pro_sn, 
    //             pro_goods_id, pro_goods_num, stock, pro_image, pro_sku_price_id, user_id
    //         ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    //     ");
    //         $stmtInsertPromo->execute([
    //             $order_id,
    //             $promo['title'] ?? '',
    //             $promo['ML_Note'] ?? '',
    //             $promo['note'] ?? '',
    //             $promo['st'] ?? 0,
    //             $promo['pro_activity_id'] ?? null,
    //             $promo['activity_id'] ?? 0,
    //             $promo['prosn'] ?? null,
    //             $promo['pro_goods_id'] ?? null,
    //             $promo['pro_goods_num'],
    //             $promo['stock'] ?? 0,
    //             $promo['pro_image'] ?? null,
    //             $promo['pro_sku_price_id'] ?? null,
    //             $promo['user_id'] ?? null,
    //         ]);
    //     }
    // }


    // // อัปเดต gifts
    // $gifts = json_decode($_POST['gifts'] ?? '[]', true);
    // foreach ($gifts as $gift) {
    //     $stmtCheckGift = $pdo->prepare("SELECT id FROM sale_order_gifts WHERE order_id = ? AND title = ?");
    //     $stmtCheckGift->execute([$order_id, $gift['title']]);
    //     $existingGift = $stmtCheckGift->fetch(PDO::FETCH_ASSOC);

    //     if (!$existingGift) {
    //         $stmtInsertGift = $pdo->prepare("INSERT INTO sale_order_gifts (
    //             order_id, pro_sn, title, pro_goods_num, stock, pro_image,
    //             ML_Note, note, st, pro_activity_id, activity_id, pro_goods_id, pro_sku_price_id, user_id
    //         ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
    //         $stmtInsertGift->execute([
    //             $order_id,
    //             $gift['prosn'],
    //             $gift['title'],
    //             $gift['pro_goods_num'] ?? 0,
    //             $gift['stock'] ?? 0,
    //             $gift['pro_image'] ?? '',
    //             $gift['ML_Note'] ?? '',
    //             $gift['note'] ?? '',
    //             $gift['st'] ?? 0,
    //             $gift['pro_activity_id'] ?? null,
    //             $gift['activity_id'] ?? 0,
    //             $gift['pro_goods_id'] ?? null,
    //             $gift['pro_sku_price_id'] ?? null,
    //             $gift['user_id'] ?? null,
    //         ]);
    //     }
    // }

    $response['success'] = true;
    $response['message'] = "อัปเดตรายการเรียบร้อยแล้ว";
    $response['newDocumentNo'] = $documentNo;
    $response['stmtInsert2'] = $stmtInsert2;
    $response['order_id'] = $order_id;
} catch (Exception $e) {
    $response['success'] = false;
    $response['message'] = "เกิดข้อผิดพลาด: " . $e->getMessage();
}

echo json_encode($response);
