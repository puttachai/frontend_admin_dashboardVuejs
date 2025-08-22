    
<?php

namespace app\api\controller;

use app\common\controller\Api;
use think\Cache;
use think\Db;
use WebPConvert\WebPConvert;

/**
 * 手机短信接口
 */
class Openai extends Api
{
    protected $noNeedLogin = '*';
    protected $noNeedRight = '*';
   
   
    public function _initialize()
    {
        parent::_initialize();
       

    }

    
    public function searchByUserFlexible2V2($keywords,$account,$admin,$pageCurrent)
    {
       
        // var_dump('test searchByUserFlexible2V2');die;
        
        // $input = trim(preg_replace('/\s+/', ' ', $keywords));  // ลบช่องว่างเกิ
       
        // // $provinceToken = null;
        // // if (preg_match('/\[.*จ\.\s*([^\]]+)\]/u', $input, $matches)) {
        // //     $provinceToken = trim($matches[1]); // เช่น "สมุทรปราการ"
        // // }
        
        // // ==== แยก saleno ออกจากวงเล็บ ( S97 ) ====
        // $salenoToken = null;
        // if (preg_match('/\(\s*([A-Za-z0-9\-]+)\s*\)/', $input, $m)) {
        //     $salenoToken = $m[1];  // ได้ "S97"
        // }
        
        // // ==== แยกจังหวัดจาก [ จ. ... ] ====
        // // $provinceToken = null;
        // // if (preg_match('/\[.*จ\.\s*([^\]]+)\]/u', $input, $matches)) {
        // //     $provinceToken = trim($matches[1]); // เช่น "อุตรดิตถ์"
        // // }
        
        // $provinceToken = null;

        // if (preg_match('/\[.*จ\.\s*([^\]]+)\]/u', $input, $matches)) {
        //     $provinceToken = trim($matches[1]);
        // } elseif (preg_match('/จ\.\s*([ก-๙]+)/u', $input, $matches)) {
        //     $provinceToken = trim($matches[1]);
        // } elseif (preg_match('/จังหวัด\s*([ก-๙]+)/u', $input, $matches)) {
        //     $provinceToken = trim($matches[1]);
        // } else {
        //     // กรณี user ใส่เฉพาะชื่อจังหวัด
        //     $provinceToken = trim($input);
        // }
        
        // // ==== ลบ saleno และจังหวัดออกไป เหลือ nickname =====
        // $nicknameToken = $input;
        // if ($salenoToken) {
        //     $nicknameToken = preg_replace('/\(\s*'.$salenoToken.'\s*\)/', '', $nicknameToken);
        // }
        // if ($provinceToken) {
        //     $nicknameToken = preg_replace('/\[.*จ\.\s*'.$provinceToken.'\s*\]/u', '', $nicknameToken);
        // }
        // $nicknameToken = trim($nicknameToken);  // เช่น "ร้าน อรไท การค้า"
            
            
        $input = trim(preg_replace('/\s+/', ' ', $keywords));  // ลบช่องว่างเกิน

        // ==== แยก saleno ออกจากวงเล็บ ( S97 ) ====
        // $salenoToken = null;
        // if (preg_match('/\(\s*([A-Za-z0-9\.\-]+)\s*\)/', $input, $m)) {
        //     $salenoToken = $m[1];  // เช่น "S97"
        // }
        
        // ถ้ามีวงเล็บ (S59) ให้ดึงค่าในวงเล็บ
        if (preg_match('/\(\s*([A-Za-z0-9\.\-]+)\s*\)/', $input, $m)) {
            $salenoToken = $m[1];
        } 
        // ถ้าไม่มีวงเล็บ ให้ถือว่า $input เป็น salenoToken เลย
        else {
            $salenoToken = $input;
        }
        // var_dump("salenoToken: " . $salenoToken);die;
      
        
        // ==== แยกจังหวัดจาก [ จ. ... ] หรือรูปแบบอื่น ====
        $provinceToken = null;
        if (preg_match('/\[.*จ\.\s*([^\]]+)\]/u', $input, $matches)) {
            $provinceToken = trim($matches[1]);
        } elseif (preg_match('/จ\.\s*([ก-๙]+)/u', $input, $matches)) {
            $provinceToken = trim($matches[1]);
        } elseif (preg_match('/จังหวัด\s*([ก-๙]+)/u', $input, $matches)) {
            $provinceToken = trim($matches[1]);
        }
        
        // ==== ลบ saleno และจังหวัดออกจาก input เหลือ nickname ====
        $nicknameToken = $input;
        if ($salenoToken) {
            $nicknameToken = preg_replace('/\(\s*'.preg_quote($salenoToken,'/').'\s*\)/', '', $nicknameToken);
        }
        if ($provinceToken) {
            $nicknameToken = preg_replace('/\[.*จ\.\s*'.preg_quote($provinceToken,'/').'\s*\]/u', '', $nicknameToken);
        }
        
        $nicknameToken = trim($nicknameToken); // เช่น "ร้าน อรไท การค้า"
         
        //  $nicknameTokenNoSpace = preg_replace('/\s+/', '', $nicknameToken);
        // // ==== ตรวจสอบว่ามีค่าจริงใน DB หรือไม่ ถ้าไม่ให้เป็น '' ====
        
        // if ($nicknameTokenNoSpace) {
        //     // $exists = Db::name('User')->where('nickname', 'like', "%{$nicknameTokenNoSpace}%")->count();
        //     $exists = Db::name('User') ->whereRaw("REPLACE(nickname, ' ', '') LIKE ?", ["%{$nicknameTokenNoSpace}%"]) ->count();
        //     // if (!$exists) $nicknameTokenNoSpace = '';
            
        //     //  var_dump('adsasdasdas' . $exists);die;
        // }
        // var_dump($exists);die;
        
        $nicknameTokenNoSpace = preg_replace('/\s+/', '', $nicknameToken);
        // var_dump("Token ที่ถูกลบช่องว่างแล้ว: " . $nicknameTokenNoSpace);
        
        if ($nicknameTokenNoSpace) {
            $exists = Db::name('User')
                        ->whereRaw("REPLACE(nickname, ' ', '') LIKE ?", ["%{$nicknameTokenNoSpace}%"])
                        ->count();
        }
        
        // var_dump("จำนวนข้อมูลที่พบ: " . $exists);
        // die;
        
        if ($salenoToken) {
            $exists = Db::name('User')->where('saleno', 'like', "%{$salenoToken}%")->count();
            if (!$exists) $salenoToken = '';
            //   var_dump("salenoToken: " . $salenoToken);
              
        }
        
        // var_dump("salenoToken: " . $salenoToken);
        
        if ($provinceToken) {
            // ตรวจสอบใน address
            $exists = Db::name('User')->where('address', 'like', "%{$provinceToken}%")->count();
            if (!$exists) $provinceToken = '';
        }

        // var_dump($nicknameToken . ' '. $salenoToken);die;

        // ตรวจว่ามีคำพิเศษ $_...$_ หรือไม่
        $hasSpecial = preg_match('/\$_([^\$_]+)_\$/', $input);
        
        // var_dump($hasSpecial);die;
        
        // ถ้ามี $_...$_ → แยก token ทั้งหมด
        if ($hasSpecial) {
            preg_match_all('/\$_([^\$_]+)_\$|[ก-๙]+|[a-zA-Z0-9\-]+/u', $input, $matches);
        
        
        
            $specialTokens = [];
            $normalTokens = [];
            $isCode = [];
        
            foreach ($matches[0] as $i => $token) {
                $token = trim($token);
                if ($token === '') continue;
        
                if (!empty($matches[1][$i])) {
                    $specialTokens[] = $matches[1][$i]; // จาก $_...$_
                } else {
                    $normalTokens[] = $token;
                    if (preg_match('/^[a-zA-Z0-9\-]+$/', $token)) {
                        $isCode[] = $token;
                    }
                }
            }
        } else {
            
            // ถ้าไม่มี $_...$_ → treat ทั้งคำเป็น 1 คำ
            $normalTokens = [$input];
            $specialTokens = [];
            $isCode = preg_match('/^[a-zA-Z0-9\-]+$/', $input) ? [$input] : [];
        }
                
        //var_dump($normalTokens);die;
        //var_dump($normalTokens);die;
        // ========== แยกเงื่อนไขการค้นหา ==========
        if (!empty($isCode)) {
            
            // var_dump('test $isCode');die;
            // ===== ค้นหาแบบรหัสสินค้า/เบอร์ลูกค้า/รหัสลูกค้า =====
            if ($admin == "sale") {
                $goodsQuery = Db::name('User')->where('saleno', $account)
                ->whereNotNull('embedding')
                ->where(function($query) use ($normalTokens, $specialTokens) {
            
                    //กรณีมี $normalTokens → ต้อง match ทั้ง 2 เงื่อนไข
                    
                        
                        ////
                    $query->where(function ($sub) use ($normalTokens, $provinceToken) {
                        if (!empty($normalTokens) || $normalTokens != '') {
                        foreach ($normalTokens as $tk) {
                            $escaped = str_replace(['%','_'], ['\%','\_'], $tk);
                            $sub->whereOr('nickname', 'like', "%{$escaped}%")
                                ->whereOr('mobile', 'like', "%{$escaped}%")
                                ->whereOr('customer_no', 'like', "%{$escaped}%");
                        }
                        }
                        
                        if (!empty($specialTokens) || $specialTokens != '') {
                        //เงื่อนไข saleno = ทุก specialToken (เช่น S54)
                        foreach ($specialTokens as $code) {
                            $query->where('saleno', '=', $code);
                        }
                    }
                    
                    
                    //////
                   
                    // ✅ เพิ่มเงื่อนไขค้นหาจังหวัด
                    if (!empty($provinceToken)) {
                        $escapedProvince = str_replace(['%','_'], ['\%','\_'], $provinceToken);
                        $sub->whereOr('address', 'like', "%{$escapedProvince}%");
                    }
                
                        
                    });
                    
            
                    
                    
                    
                    // $query->where(function ($sub) use ($normalTokens) {
                    //     if (!empty($normalTokens) || $normalTokens != '') {
                    //     foreach ($normalTokens as $tk) {
                    //         $escaped = str_replace(['%','_'], ['\%','\_'], $tk);
                    //         $sub->whereOr('nickname', 'like', "%{$escaped}%")
                    //             ->whereOr('mobile', 'like', "%{$escaped}%")
                    //             ->whereOr('customer_no', 'like', "%{$escaped}%");
                    //     }
                    //     }
                    // });
                    
            
                    // if (!empty($specialTokens) || $specialTokens != '') {
                    //     //เงื่อนไข saleno = ทุก specialToken (เช่น S54)
                    //     foreach ($specialTokens as $code) {
                    //         $query->where('saleno', '=', $code);
                    //     }
                    // }
                });
                    
                   // var_dump('ds,folds');die;
        
                $customer_count = Db::name('User')->where('saleno', $account)
                ->whereNotNull('embedding')
                ->where(function($query) use ($normalTokens, $specialTokens) {
            
                    //กรณีมี $normalTokens → ต้อง match ทั้ง 2 เงื่อนไข
                    
                        
                    $query->where(function ($sub) use ($normalTokens) {
                        if (!empty($normalTokens) || $normalTokens != '') {
                        foreach ($normalTokens as $tk) {
                            $escaped = str_replace(['%','_'], ['\%','\_'], $tk);
                            $sub->whereOr('nickname', 'like', "%{$escaped}%")
                                ->whereOr('mobile', 'like', "%{$escaped}%")
                                ->whereOr('customer_no', 'like', "%{$escaped}%");
                        }
                        }
                    });
                    
            
                    if (!empty($specialTokens) || $specialTokens != '') {
                        //เงื่อนไข saleno = ทุก specialToken (เช่น S54)
                        foreach ($specialTokens as $code) {
                            $query->where('saleno', '=', $code);
                        }
                    }
                })->count();
        
            } else {
                 
                $goodsQuery = Db::name('User')
                ->whereNotNull('embedding')
                ->where(function($query) use ($normalTokens, $specialTokens) {
            
                    //กรณีมี $normalTokens → ต้อง match ทั้ง 2 เงื่อนไข
                    
                        
                    $query->where(function ($sub) use ($normalTokens) {
                        if (!empty($normalTokens) || $normalTokens != '') {
                        foreach ($normalTokens as $tk) {
                            $escaped = str_replace(['%','_'], ['\%','\_'], $tk);
                            $sub->whereOr('nickname', 'like', "%{$escaped}%")
                                ->whereOr('mobile', 'like', "%{$escaped}%")
                                ->whereOr('customer_no', 'like', "%{$escaped}%");
                        }
                        }
                    });
                    
            
                    if (!empty($specialTokens) || $specialTokens != '') {
                        //เงื่อนไข saleno = ทุก specialToken (เช่น S54)
                        foreach ($specialTokens as $code) {
                            $query->where('saleno', '=', $code);
                        }
                    }
                });
                    
               
        
                $customer_count = Db::name('User')
                ->whereNotNull('embedding')
                ->where(function($query) use ($normalTokens, $specialTokens) {
            
                    //กรณีมี $normalTokens → ต้อง match ทั้ง 2 เงื่อนไข
                    
                        
                    $query->where(function ($sub) use ($normalTokens) {
                        if (!empty($normalTokens) || $normalTokens != '') {
                        foreach ($normalTokens as $tk) {
                            $escaped = str_replace(['%','_'], ['\%','\_'], $tk);
                            $sub->whereOr('nickname', 'like', "%{$escaped}%")
                                ->whereOr('mobile', 'like', "%{$escaped}%")
                                ->whereOr('customer_no', 'like', "%{$escaped}%");
                        }
                        }
                    });
                    
            
                    if (!empty($specialTokens) || $specialTokens != '') {
                        //เงื่อนไข saleno = ทุก specialToken (เช่น S54)
                        foreach ($specialTokens as $code) {
                            $query->where('saleno', '=', $code);
                        }
                    }
                })->count();
            }
        } else {
            
             
            
            // var_dump('test Not isCode');die;
            // ===== ค้นหาแบบคำทั่วไป เช่น ชื่อ หรือนามแฝง =====
           
            if ($admin == "sale") {
                
                // var_dump('test Not isCode');die;
                $goodsQuery = Db::name('User')->where('saleno', $account)
                ->whereNotNull('embedding')
                ->where(function($query) use ($normalTokens, $specialTokens, $provinceToken) {
            
                    //กรณีมี $normalTokens → ต้อง match ทั้ง 2 เงื่อนไข
                    
                        
                    $query->where(function ($sub) use ($normalTokens, $provinceToken) {
                        if (!empty($normalTokens) || $normalTokens != '') {
                        foreach ($normalTokens as $tk) {
                            $escaped = str_replace(['%','_'], ['\%','\_'], $tk);
                            $sub->whereOr('nickname', 'like', "%{$escaped}%")
                                ->whereOr('mobile', 'like', "%{$escaped}%")
                                ->whereOr('customer_no', 'like', "%{$escaped}%");
                        }
                        }
                        
                        // ✅ เพิ่มค้นหาจังหวัดจาก address
                        if (!empty($provinceToken)) {
                            $escapedProvince = str_replace(['%','_'], ['\%','\_'], $provinceToken);
                            $sub->whereOr('address', 'like', "%{$escapedProvince}%");
                        }
                    });
                    
            
                    if (!empty($specialTokens) || $specialTokens != '') {
                        //เงื่อนไข saleno = ทุก specialToken (เช่น S54)
                        foreach ($specialTokens as $code) {
                            $query->where('saleno', '=', $code);
                        }
                    }
                });
        
                $customer_count = Db::name('User')->where('saleno', $account)
                ->whereNotNull('embedding')
                ->where(function($query) use ($normalTokens, $specialTokens) {
            
                    //กรณีมี $normalTokens → ต้อง match ทั้ง 2 เงื่อนไข
                    
                        
                    $query->where(function ($sub) use ($normalTokens) {
                        if (!empty($normalTokens) || $normalTokens != '') {
                        foreach ($normalTokens as $tk) {
                            $escaped = str_replace(['%','_'], ['\%','\_'], $tk);
                            $sub->whereOr('nickname', 'like', "%{$escaped}%")
                                ->whereOr('mobile', 'like', "%{$escaped}%")
                                ->whereOr('customer_no', 'like', "%{$escaped}%");
                        }
                        }
                    });
                    
            
                    if (!empty($specialTokens) || $specialTokens != '') {
                        //เงื่อนไข saleno = ทุก specialToken (เช่น S54)
                        foreach ($specialTokens as $code) {
                            $query->where('saleno', '=', $code);
                        }
                    }
                })->count();
                
            } 
            
            else {
                
                // var_dump('test Not isCode');die;
                
                // $goodsQuery = Db::name('User')
                // ->whereNotNull('embedding')
                // // ->where(function($query) use ($normalTokens, $specialTokens, $provinceToken) {
                // ->where(function($query) use ($nicknameToken, $salenoToken, $provinceToken) {
                //     //กรณีมี $normalTokens → ต้อง match ทั้ง 2 เงื่อนไข
                    
                //     if (!empty($nicknameToken)) {
                //         $escaped = str_replace(['%','_'], ['\%','\_'], $nicknameToken);
                //         $query->whereOr('nickname', 'like', "%{$escaped}%");
                        
                //     }
            
                //     if (!empty($salenoToken)) {
                //         // $query->whereOr('saleno', '=', $salenoToken);
                //         $query->whereOr('saleno', 'like', "%{$salenoToken}%");
                        
                //     }
            
                //     // var_dump($provinceToken);die;
                //      if (!empty($provinceToken)) {
                //         // $provinceVariants = ["จ.$provinceToken", $provinceToken, "จังหวัด$provinceToken"];
                        
                //         $provinceVariants = ["จ.$provinceToken", $provinceToken, "จังหวัด$provinceToken", "[จ.$provinceToken]"];
                //         // var_dump($provinceVariants);die;
                //         $query->where(function($q) use ($provinceVariants) {
                //             foreach ($provinceVariants as $prov) {
                //                 $escaped = str_replace(['%','_'], ['\%','\_'], $prov);
                //                 $q->whereOr('address', 'like', "%{$escaped}%");
                //             }
                //         });
                        
                //         //  var_dump($query);die;
                //     }
                    
                // });
                
                // var_dump($salenoToken);die;
                
                $goodsQuery = Db::name('User')
                    ->whereNotNull('embedding')
                    ->where(function($query) use ($nicknameTokenNoSpace, $salenoToken, $provinceToken) {
                        
                        // var_dump($nicknameTokenNoSpace);die;
                        
                        if (!empty($nicknameTokenNoSpace)) {
                            // $escaped = str_replace(['%','_'], ['\%','\_'], $nicknameTokenNoSpace);
                            $query->whereOr('nickname', 'like', "%{$nicknameTokenNoSpace}%");
                        }
                
                        
                        if (!empty($salenoToken)) {
                            $query->whereOr('saleno', '=', $salenoToken);
                        }
                
                        if (!empty($provinceToken)) {
                            $provinceVariants = [
                                "จ.$provinceToken",
                                $provinceToken,
                                "จังหวัด$provinceToken",
                                "[จ.$provinceToken]"
                            ];
                            $query->where(function($q) use ($provinceVariants) {
                                foreach ($provinceVariants as $prov) {
                                    $escaped = str_replace(['%','_'], ['\%','\_'], $prov);
                                    $q->whereOr('address', 'like', "%{$escaped}%");
                                }
                            });
                        }
                    });

                    
                    // var_dump($nicknameToken . ' '. $salenoToken);die;
                    // if (!empty($provinceToken)) {
                    //     $escapedProvince = str_replace(['%','_'], ['\%','\_'], $provinceToken);
                    //     // $query->whereOr('address', 'like', "%{$provinceToken}%");
                    //     $query->whereOr('address', 'like', "%{$escapedProvince}%");
                        
                    // }
                    
                    // if (!empty($provinceToken)) {
                    //     $escapedProvince = str_replace(['%','_'], ['\%','\_'], $provinceToken);
                    //     $query->whereOr('address', 'like', "%{$escapedProvince}%");
                    // } 

                    // if (!empty($provinceToken)) {
                    //     // ตัด "จ." ถ้ามี
                    //     $provinceToken = preg_replace('/^จ\./u', '', $provinceToken);
                    //     $provinceToken = trim($provinceToken);
                    // }
                    // 1. Exact match ก่อน (nickname ตรงกับ keyword ทั้งคำ)
                    // foreach ($normalTokens as $tk) {
                    //     $escaped = str_replace(['%','_'], ['\%','\_'], $tk);
                    //     $query->whereOrRaw("BINARY nickname = ?", [$escaped]); 
                    // }
                    
                    // 2. จากนั้นใช้ like สำหรับ match ที่ "คล้าย"
                    // $query->where(function ($sub) use ($normalTokens, $provinceToken) {
                    //     if (!empty($normalTokens) || $normalTokens != '') {
                    //     foreach ($normalTokens as $tk) {
                    //         $escaped = str_replace(['%','_'], ['\%','\_'], $tk);
                    //         $sub->whereOr('nickname', 'like', "%{$escaped}%")
                    //             ->whereOr('mobile', 'like', "%{$escaped}%")
                    //             ->whereOr('customer_no', 'like', "%{$escaped}%");
                    //     }
                    //     }
                        
                    //      // เพิ่มค้นหาจังหวัดจาก address
                    //     if (!empty($provinceToken)) {
                    //         $escapedProvince = str_replace(['%','_'], ['\%','\_'], $provinceToken);
                    //         $sub->whereOr('address', 'like', "%{$escapedProvince}%");
                    //     }
                        
                    // });
                    
            
                    // // 3. saleno ต้องตรงเป๊ะ
                    // if (!empty($specialTokens) || $specialTokens != '') {
                    //     //เงื่อนไข saleno = ทุก specialToken (เช่น S54)
                    //     foreach ($specialTokens as $code) {
                    //         $query->where('saleno', '=', $code);
                    //     }
                    // }
                // });
                    
                 
                $customer_count = Db::name('User')
                ->whereNotNull('embedding')
                // ->where(function($query) use ($normalTokens, $specialTokens) {
            
                    //กรณีมี $normalTokens → ต้อง match ทั้ง 2 เงื่อนไข
                    
                    // var_dump('Check BINARY nickname');die;
                    
                    // foreach ($normalTokens as $tk) {
                    //     $escaped = str_replace(['%','_'], ['\%','\_'], $tk);
                    //     $query->whereOrRaw("BINARY nickname = ?", [$escaped]); 
                    // }
                    
                     ->where(function($query) use ($nicknameTokenNoSpace, $salenoToken, $provinceToken) {
                    //กรณีมี $normalTokens → ต้อง match ทั้ง 2 เงื่อนไข
                    
                    if (!empty($nicknameToken)) {
                        $escaped = str_replace(['%','_'], ['\%','\_'], $nicknameTokenNoSpace);
                        $query->whereOr('nickname', 'like', "%{$escaped}%");
                    }
            
                    if (!empty($salenoToken)) {
                        $query->whereOr('saleno', '=', $salenoToken);
                    }
            
                    // if (!empty($provinceToken)) {
                    //     $escapedProvince = str_replace(['%','_'], ['\%','\_'], $provinceToken);
                    //     $query->whereOr('address', 'like', "%{$escapedProvince}%");
                    // }
                    
                     if (!empty($provinceToken)) {
                        // $provinceVariants = ["จ.$provinceToken", $provinceToken, "จังหวัด$provinceToken"];
                        
                            $provinceVariants = ["จ.$provinceToken", $provinceToken, "จังหวัด$provinceToken", "[จ.$provinceToken]"];
                            // var_dump($provinceVariants);die;
                            $query->where(function($q) use ($provinceVariants) {
                                foreach ($provinceVariants as $prov) {
                                    $escaped = str_replace(['%','_'], ['\%','\_'], $prov);
                                    $q->whereOr('address', 'like', "%{$escaped}%");
                                }
                            });
                            
                            //  var_dump($query);die;
                        }
                    
                    // var_dump('1424 test $customer_count: ' . '' .$nicknameToken . ' ' . $salenoToken . ' ' . $provinceToken);die;
                        
                    // $query->where(function ($sub) use ($normalTokens) {
                    //     if (!empty($normalTokens) || $normalTokens != '') {
                    //     foreach ($normalTokens as $tk) {
                    //         $escaped = str_replace(['%','_'], ['\%','\_'], $tk);
                    //         $sub->whereOr('nickname', 'like', "%{$escaped}%")
                    //             ->whereOr('mobile', 'like', "%{$escaped}%")
                    //             ->whereOr('customer_no', 'like', "%{$escaped}%");
                    //     }
                    //     }
                    // });
                    
            
                    // if (!empty($specialTokens) || $specialTokens != '') {
                    //     //เงื่อนไข saleno = ทุก specialToken (เช่น S54)
                    //     foreach ($specialTokens as $code) {
                    //         $query->where('saleno', '=', $code);
                    //     }
                    // }
                })->count();
                
                // var_dump('1535 test $customer_count: ' . '' .$nicknameToken . ' ' . $salenoToken . ' ' . $provinceToken);die;
            }
        }
        
        // var_dump('Check pageCurrent = ' . $pageCurrent);
        // echo('Check pageCurrent = ' . $pageCurrent);
        
        
        // ======= ส่วนการประมวลผลผลลัพธ์ =======
        if($customer_count < 15) {
             $pool = $goodsQuery->paginate($customer_count, false, [
                'page'     => $pageCurrent,
                'var_page' => 'pageCurrent',
                'query'    => ['keyword' => $input],
            ]);
            
            // var_dump('Check $input if = ' . $pool);die;
            // print_r($pool->items()); die;
        }else{
            $pool = $goodsQuery->paginate(15, false, [
                'page'     => $pageCurrent,
                'var_page' => 'pageCurrent',
                'query'    => ['keyword' => $input],
            ]);
            // var_dump('Check $goodsQuery else = ' . $pool);die;
            
            // print_r($pool->items()); die;
        }
            
        
        
        
        
        
        if (isset($input) && $input) {
            $targetEmb = $this->getEmbeddingByCurl($input);
        }
        
      
          
        $results = [];
        // foreach ($pool as $item) {
           
        //     $emb = json_decode($item['embedding'], true);
        //     if (!is_array($emb) || empty($emb)) {
        //         continue;
        //     }
        
        //     $titleLower = mb_strtolower($item['nickname'], 'UTF-8');
        //     $matchAll   = true;
        //     $tokensToCheck = !empty($isCode) ? $isCode : $normalTokens;
            
        //     foreach ($tokensToCheck as $tk) {
                
        //         $tkLower = mb_strtolower($tk, 'UTF-8');
                
        //         if ($tkLower === '' || $titleLower === '') {
        //             $matchAll = false;
        //             break;
        //         }
                
        //         if (mb_strpos($titleLower, $tkLower, 0, 'UTF-8') === false) {
        //             $matchAll = false;
        //             break;
        //         }
        //     }
        
        //     if (isset($targetEmb) && $targetEmb) {
        //         $score = $this->cosineSimilarity($targetEmb, $emb);
        //     }
        
        //     $results[] = [
        //         'id'         => $item['id'],
        //         'nickname'   => $item['nickname'],
        //         'user'       => $item,
        //         'score'      => $score ?? 0,
        //         'match_all'  => $matchAll ? 1 : 0,
        //     ];
        // }
        // var_dump('1514 test $nicknameToken: ' . '' .$nicknameToken . ' ' . $salenoToken . ' ' . $provinceToken);die;
        // ร้าน ซี.พี. คอมพิวเตอร์เซอร์วิส (คุณจักรพันธ์ จตุรงคสัมฤทธิ์) ( S97 )  [ จ. พิษณุโลก ] 
        
        // แปลง pool เป็น associative array โดยใช้ nickname เป็น key
        
        
        // ถ้าไม่มีค่า keyword ใด ๆ ให้ return ว่าง ๆ หรือจำนวน 0
        if (empty($nicknameToken) && empty($salenoToken) && empty($provinceToken)) {
            
            //  var_dump('if (empty' . ' => ' . $nicknameToken . ' => ' . $salenoToken . ' => ' . $provinceToken);die;
            
              foreach ($pool as $item) {
                $emb = json_decode($item['embedding'], true);
                if (!is_array($emb) || empty($emb)) {
                    continue;
                }
                
                 // var_dump($item);die;
            
                $titleLower   = mb_strtolower($item['nickname'], 'UTF-8');
                $addressLower = mb_strtolower($item['address'] ?? '', 'UTF-8');
                
                // var_dump('1525 test $addressLower: ' . '' . $addressLower);die;
                $matchAll     = 0;
            
                // ตรวจ nickname
                $nicknameMatch = (!empty($nicknameToken) && mb_strpos($titleLower, mb_strtolower($nicknameToken, 'UTF-8')) !== false);
            
                // ตรวจ saleno
                $salenoMatch = (!empty($salenoToken) && $item['saleno'] === $salenoToken);
            
                // ตรวจจังหวัด
                $provinceMatch = (!empty($provinceToken) && mb_strpos($addressLower, mb_strtolower($provinceToken, 'UTF-8')) !== false);
                
                // var_dump('1535 test all: ' . '' .$nicknameMatch . ' ' . $salenoMatch . ' ' . $provinceMatch);die;
                // var_dump('1535 test $salenoMatch: ' . ' ' . $salenoMatch );die;
                // var_dump('1535 test $provinceMatch: ' . '' . $provinceMatch);die;
            
                if ($nicknameMatch && $salenoMatch && $provinceMatch) {
                    $matchAll = 2; // ตรงทั้งหมด
                    //  var_dump('test ตรงทั้งหมด: ');die;
                } elseif ($nicknameMatch && $salenoMatch) {
                    $matchAll = 1; // ตรงแค่ชื่อ+saleno
                    // var_dump('test ตรงแค่ชื่อ+saleno: ');die;
                    
                }
            
                //  var_dump('test $matchAllno: ' . $matchAll );die;
             
                if (isset($targetEmb) && $targetEmb) {
                    $score = (empty($targetEmb)) ? 0 : $this->cosineSimilarity($targetEmb ?? 0, $emb);
                }
            
                $results[] = [
                    'id'        => $item['id'],
                    'nickname'  => $item['nickname'],
                    'user'      => $item,
                    'score'     => $score ?? 0,
                    'match_all' => $matchAll,
                ];
            }
    
          
            
            
            // เรียงลำดับ
            // usort($results, function ($a, $b) {
            //     if ($b['match_all'] <=> $a['match_all']) {
            //         return $b['match_all'] <=> $a['match_all'];
            //     }
            //     if ($b['score'] < $a['score']) return -1;
            //     if ($b['score'] > $a['score']) return 1;
            //     return 0;
            // });
            
            usort($results, function ($a, $b) {
                // เรียง match_all ก่อน
                if ($a['match_all'] !== $b['match_all']) {
                    return $b['match_all'] <=> $a['match_all'];
                }
                // ถ้า match_all เท่ากัน → เรียงตาม similarity
                return $b['score'] <=> $a['score'];
            });
            
            $top5 = array_slice($results, 0, 5);
            $ids  = array_column($results, 'user');
            
            return [
                'user' => $ids,
                // 'customer_count' => $mappedPoolCount
                'customer_count' => $customer_count
            ];
                
        }else{
        // var_dump('adadsd'); die;
        //   $mappedPool = [];
        //     foreach ($pool as $item) {
        //         $nickname = trim($item['nickname']  = $nicknameToken);
        //         $saleno   = trim($item['saleno']  = $salenoToken);
        //         $province = trim($item['address']  = $provinceToken); // province เก็บใน address
            
        //         // composite key จาก nickname + saleno + province
        //         $key = mb_strtolower($nickname . '|' . $saleno . '|' . $province, 'UTF-8');
            
        //         $mappedPool[$key] = $item;
        //     }
    
        //     // จำนวนทั้งหมดใน mappedPool
        //     $mappedPoolCount = count($mappedPool);
            
            
        // $mappedPool = [];
        //     foreach ($pool as $item) {
        //         $nicknameMatch = trim($item['nickname']) === trim($nicknameToken);
        //         $salenoMatch   = trim($item['saleno']) === trim($salenoToken);
            
        //         // ตรวจสอบว่า provinceToken ปรากฏใน address
        //         $provinceMatch = false;
        //         $address = trim($item['address']);
        //         $province = trim($provinceToken);
            
        //         if (mb_strpos($address, $province) !== false) {
        //             $provinceMatch = true;
        //         }
            
        //         if ($nicknameMatch && $salenoMatch && $provinceMatch) {
        //             $key = mb_strtolower(
        //                 $item['nickname'] . '|' . $item['saleno'] . '|' . $item['address'],
        //                 'UTF-8'
        //             );
        //             $mappedPool[$key] = $item;
        //         }
        //     }
        
        // --- ขั้นแรก: ตรวจสอบตรงกับ database ก่อน ---
        // $exactUser = null;
        // if (!empty($nicknameToken)) {
        //     $exactUser = Db::name('User')
        //         ->whereRaw('LOWER(nickname) = ?', [mb_strtolower($nicknameToken, 'UTF-8')])
        //         ->find();
        // }
        
      
        // --- ขั้นแรก: ตรวจสอบตรงกับ database ก่อน ---
        $exactUsers = [];   // ต้อง init เป็น array ก่อน
        
        if (!empty($nicknameTokenNoSpace)) {
            // ตรวจจาก nickname โดยลบช่องว่างทั้ง input และ database
            $users = Db::name('User')
                ->whereRaw('LOWER(REPLACE(nickname, " ", "")) LIKE ?', ['%' . mb_strtolower($nicknameTokenNoSpace, 'UTF-8') . '%'])
                ->select();
        
            $users = $users ? $users : [];   // กัน null
            $exactUsers = array_merge($exactUsers, $users);
            // var_dump($exactUsers); die;
        }
        
        // if (!empty($nicknameToken)) {
        //     // ตรวจจาก nickname
        //     $users = Db::name('User')
        //         ->whereRaw('LOWER(nickname) LIKE ?', ['%' . mb_strtolower($nicknameToken, 'UTF-8') . '%'])
        //         // ->whereRaw('LOWER(nickname) = ?', [mb_strtolower($nicknameToken, 'UTF-8')])
        //         ->select();
        //     $users = $users ? $users : [];   // กัน null
        //     $exactUsers = array_merge($exactUsers, $users);
        //     // var_dump($exactUsers);die;
        // }
        
        if (!empty($salenoToken)) {
            // ตรวจจาก saleno
            $users = Db::name('User')
                ->where('saleno', trim($salenoToken))
                ->select();
            $users = $users ? $users : [];
            $exactUsers = array_merge($exactUsers, $users);
            // echo('saleno: ');
            // var_dump($exactUsers);die;
        }
        
        if (!empty($provinceToken)) {
            // ตรวจจากจังหวัด (search address)
            $users = Db::name('User')
                ->whereRaw('LOWER(address) LIKE ?', ['%' . mb_strtolower($provinceToken, 'UTF-8') . '%'])
                ->select();
            $users = $users ? $users : [];
            $exactUsers = array_merge($exactUsers, $users);
            // var_dump('$exactUsers');die;
        }

// var_dump($exactUsers);die;
// var_dump($nicknameToken . ' '. $salenoToken);die;
        $mappedPool = [];
        
        // ถ้าเจอ nickname ตรงกันใน database
        if (!empty($exactUsers)) {
        // if ($exactUser) {
            // $mappedPool[] = $exactUser;  // ใช้ข้อมูลนี้เลย
            foreach ($exactUsers as $user) {
                $key = mb_strtolower($user['nickname'] . '|' . $user['saleno'] . '|' . $user['address'], 'UTF-8');
                $mappedPool[$key] = $user;
            }
            // var_dump('sadasdsadasd');die;
        // } else {
                // var_dump($pool);die;
                foreach ($pool as $item) {
                    
                    $nicknameMatch = !empty($nicknameToken) && mb_strpos(mb_strtolower($item['nickname'], 'UTF-8'), mb_strtolower($nicknameToken, 'UTF-8')) !== false;
                    $salenoMatch   = !empty($salenoToken) && trim($item['saleno']) === trim($salenoToken);
                
                    //   var_dump($nicknameMatch);die;
                     
                    $provinceMatch = false;
                    if (!empty($provinceToken)) {
                        $addressLower = mb_strtolower($item['address'] ?? '', 'UTF-8');
                        $provinceMatch = mb_strpos($addressLower, mb_strtolower($provinceToken, 'UTF-8')) !== false;
                    }
                
                    // ถ้า match อย่างน้อย 1 เงื่อนไข ก็เก็บ
                    if ($nicknameMatch || $salenoMatch || $provinceMatch) {
                        $key = mb_strtolower($item['nickname'] . '|' . $item['saleno'] . '|' . $item['address'], 'UTF-8');
                        $mappedPool[$key] = $item;
                    }
                }
            }
            // var_dump($nicknameMatch . ' ' .$salenoMatch . ' ' . $provinceMatch);die;
            // var_dump($mappedPool);die;
            
            $mappedPoolCount = count($mappedPool);

            // $mappedPool = [];
            // foreach ($pool as $item) {
            //     if (trim($item['nickname']) === trim($nicknameToken) &&
            //         trim($item['saleno']) === trim($salenoToken) 
            //         ) {
            //             // trim($item['address']) === trim($provinceToken) // . '|' . $item['address']
            
            //         $key = mb_strtolower(
            //             $item['nickname'] . '|' . $item['saleno'] ,
            //             'UTF-8'
            //         );
            //         $mappedPool[$key] = $item;
            //     }
            // }
            
            // var_dump($mappedPool);die;
            
            // $mappedPoolCount = count($mappedPool);

    
            // $mappedPool = [];
            // foreach ($pool as $item) {
            //     $mappedPool[$item['nickname'] = $nicknameToken] = $item;
            //     // var_dump($mappedPool);die;
                
            // }
    
            // foreach ($pool as $item) {
            //     $emb = json_decode($item['embedding'], true);
            //     if (!is_array($emb) || empty($emb)) {
            //         continue;
            //     }
            // ตรวจสอบ match
            $results = [];
            foreach ($mappedPool as $nickname => $item) {
                $emb = json_decode($item['embedding'], true);
                if (!is_array($emb) || empty($emb)) {
                    continue;
                    
                    
                }
                
                // var_dump($item);die;
            
                // $titleLower   = $nicknameToken;
                $titleLower   = mb_strtolower($item['nickname'], 'UTF-8');
                // $addressLower = $provinceToken;
                $addressLower = mb_strtolower($item['address'] ?? '', 'UTF-8');
                
                
                
                // var_dump('1525 test $addressLower: ' . '' . $addressLower);die;
                $matchAll     = 1;
            
                // echo('test $titleLower:' . ' ' .$titleLower);
                // echo('test $nicknameToken:' . ' ' .$nicknameToken);
                // ตรวจ nickname
                $nicknameMatch = (!empty($nicknameToken) && mb_strpos($titleLower, mb_strtolower($nicknameToken, 'UTF-8')) !== false);
            
            
                // ตรวจ saleno
                $salenoMatch = (!empty($salenoToken) && $item['saleno'] === $salenoToken);
            
                // ตรวจจังหวัด
                $provinceMatch = (!empty($provinceToken) && mb_strpos($addressLower, mb_strtolower($provinceToken, 'UTF-8')) !== false);
                
                // echo 'nicknameMatch: ' . ($nicknameMatch ? 'true' : 'false') . PHP_EOL;
                // echo 'salenoMatch: '   . ($salenoMatch   ? 'true' : 'false') . PHP_EOL;
                // echo 'provinceMatch: ' . ($provinceMatch ? 'true' : 'false') . PHP_EOL;

                // var_dump('test $nicknameMatch: ' . $nicknameMatch );die;
                
                // var_dump('1535 test all: ' . '' .$nicknameMatch . ' ' . $salenoMatch . ' ' . $provinceMatch);die;
                // var_dump('1535 test $salenoMatch: ' . ' ' . $salenoMatch );die;
                // var_dump('1535 test $provinceMatch: ' . '' . $provinceMatch);die;
            
                if ($nicknameMatch && $salenoMatch && $provinceMatch) {
                    $matchAll = 3; // ตรงทั้งหมด
                    //  var_dump('test ตรงทั้งหมด: ');die;
                } elseif ($nicknameMatch && $salenoMatch ) {
                    $matchAll = 2; // ตรงแค่ชื่อ+saleno
                    // var_dump('test ตรงแค่ชื่อ+saleno: ');die;
                    
                }
            
                //  var_dump('test $matchAllno: ' . $matchAll );die;
             
                if (isset($targetEmb) && $targetEmb) {
                    $score = (empty($targetEmb)) ? 0 : $this->cosineSimilarity($targetEmb ?? 0, $emb);
                }
            
                
                // var_dump($nicknameToken);die;
                
                $results[] = [
                    'id'        => $item['id'],
                    'nickname'  => $item['nickname'],
                    // 'nickname'  => $nicknameToken,
                    'user'      => $item,
                    'score'     => $score ?? 0,
                    'match_all' => $matchAll,
                ];
                
                // var_dump($results);die;
            }
    
          
            
            
            // เรียงลำดับ
            // usort($results, function ($a, $b) {
            //     if ($b['match_all'] <=> $a['match_all']) {
            //         return $b['match_all'] <=> $a['match_all'];
            //     }
            //     if ($b['score'] < $a['score']) return -1;
            //     if ($b['score'] > $a['score']) return 1;
            //     return 0;
            // });
            
            // var_dump($results);die;
            
            // usort($results, function ($a, $b) {
            //     // เรียง match_all ก่อน
            //     if ($a['match_all'] !== $b['match_all']) {
            //         return $b['match_all'] <=> $a['match_all'];
            //     }
            //     // ถ้า match_all เท่ากัน → เรียงตาม similarity
            //     return $b['score'] <=> $a['score'];
            // });
            
            // var_dump(array_column($results, 'nickname'));die;

            
            usort($results, function ($a, $b) use ($nicknameToken) {
                // 0. ถ้า nickname ตรง keyword แบบ exact match ให้ดันขึ้นก่อน
               $aName = mb_strtolower($a['nickname'], 'UTF-8');
                $bName = mb_strtolower($b['nickname'], 'UTF-8');
                $token = mb_strtolower($nicknameToken, 'UTF-8');
            
                $exactA = ($aName === $token);
                $exactB = ($bName === $token);
                
                    // var_dump([
                    //     'A' => $a['nickname'],
                    //     'B' => $b['nickname'],
                    //     'token' => $nicknameToken,
                    //     'exactA' => $exactA,
                    //     'exactB' => $exactB,
                    // ]);
                
                    // หยุดแค่รอบแรกให้เห็นก่อน
                    // die;
            
            
                if ($exactA !== $exactB) {
                    return $exactB <=> $exactA;
                }
                // if ($exactA === $exactB) {
                //     return $exactB <=> $exactA; // ใคร exact match ขึ้นก่อน
                // }
            
                // 1. เรียง match_all ก่อน
                if ($a['match_all'] !== $b['match_all']) {
                    return $b['match_all'] <=> $a['match_all'];
                }
            
                // 2. ถ้า match_all เท่ากัน → ใช้ similarity score
                if ($a['score'] !== $b['score']) {
                    return $b['score'] <=> $a['score'];
                }
            
                return 0;
            });

            // usort($results, function ($a, $b) {
            //     // 1. เรียง match_all ก่อน (2 = ตรงทุกอย่าง, 1 = ตรงบางอย่าง, 0 = ไม่ตรง)
            //     if ($a['match_all'] !== $b['match_all']) {
            //         return $b['match_all'] <=> $a['match_all'];
            //     }
            
            //     // 2. ถ้า match_all เท่ากัน → เรียงตาม similarity score
            //     if ($a['score'] !== $b['score']) {
            //         return $b['score'] <=> $a['score'];
            //     }
            
            //     // 3. ถ้า similarity score เท่ากัน → เรียงตาม nickname ตรง keyword แบบ exact match ขึ้นก่อน
            //     $exactA = (mb_strtolower($a['nickname'], 'UTF-8') === mb_strtolower(trim($GLOBALS['nicknameToken']), 'UTF-8'));
            //     $exactB = (mb_strtolower($b['nickname'], 'UTF-8') === mb_strtolower(trim($GLOBALS['nicknameToken']), 'UTF-8'));
                
            //     // var_dump($exactA);die
            //     return $exactB <=> $exactA;
            // });
            
            // var_dump($results);die;
            
            $perPage = 15; // จำนวนต่อหน้า
            $pageCurrent = max(1, (int)($pageCurrent ?? 1)); // ตรวจสอบ pageCurrent
            $mappedPoolCount = count($mappedPool);
            
            // แปลง mappedPool เป็น array ของ user
            $ids = array_column($results, 'user');
            
            // เริ่ม index สำหรับ slice
            $offset = ($pageCurrent - 1) * $perPage;
            $paginatedUsers = array_slice($ids, $offset, $perPage);
            
            return [
                'user' => $paginatedUsers,
                'customer_count' => $mappedPoolCount
            ];
            // $top5 = array_slice($results, 0, 5);
            // $ids  = array_column($results, 'user');
            
            
            // return [
            //     'user' => $ids,
            //     'customer_count' => $mappedPoolCount
            //     // 'customer_count' => $customer_count
            // ];
        
        }

      
    }
}