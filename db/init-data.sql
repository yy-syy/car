-- ========================================
-- fuint-car 系统基础数据初始化脚本
-- 包含：平台、商户、店铺、管理员、角色、菜单、会员等级、商品分类等
-- ========================================

USE `car`;

-- ========================================
-- 1. 平台数据
-- ========================================
INSERT INTO `t_platform` (`owner_id`, `name`, `status`, `description`, `platform_type`) VALUES
(1, '汽车会员系统', 1, '汽车服务会员管理平台', 1);

-- ========================================
-- 2. 商户数据
-- ========================================
INSERT INTO `mt_merchant` (`ID`, `TYPE`, `LOGO`, `NO`, `NAME`, `CONTACT`, `PHONE`, `ADDRESS`, `DESCRIPTION`, `CREATE_TIME`, `UPDATE_TIME`, `STATUS`, `OPERATOR`) VALUES
(1, 'service', '', 'M2024001', '汽车服务商户', '管理员', '13800138000', '北京市朝阳区建国路88号', '汽车会员服务管理商户', NOW(), NOW(), 'A', 'admin');

-- ========================================
-- 3. 店铺数据
-- ========================================
INSERT INTO `mt_store` (`ID`, `MERCHANT_ID`, `NAME`, `LOGO`, `IS_DEFAULT`, `CONTACT`, `PHONE`, `ADDRESS`, `LATITUDE`, `LONGITUDE`, `HOURS`, `DESCRIPTION`, `CREATE_TIME`, `UPDATE_TIME`, `STATUS`, `OPERATOR`) VALUES
(1, 1, '总店', '', 'Y', '张经理', '13800138001', '北京市朝阳区建国路88号', '39.908722', '116.397499', '08:00-22:00', '汽车服务总店', NOW(), NOW(), 'A', 'admin'),
(2, 1, '望京分店', '', 'N', '李经理', '13800138002', '北京市朝阳区望京街道', '40.001811', '116.480488', '08:30-21:30', '汽车服务望京分店', NOW(), NOW(), 'A', 'admin'),
(3, 1, '国贸分店', '', 'N', '王经理', '13800138003', '北京市朝阳区国贸中心', '39.909186', '116.459389', '09:00-21:00', '汽车服务国贸分店', NOW(), NOW(), 'A', 'admin');

-- ========================================
-- 4. 角色数据
-- ========================================
INSERT INTO `t_duty` (`merchant_id`, `duty_id`, `duty_name`, `status`, `description`, `duty_type`) VALUES
(0, 1, '超级管理员', 'A', '拥有所有权限', 'admin'),
(1, 2, '商户管理员', 'A', '管理商户所有功能', 'merchant'),
(1, 3, '店铺管理员', 'A', '管理店铺日常运营', 'store'),
(1, 4, '收银员', 'A', '收银台操作', 'cashier');

-- ========================================
-- 5. 菜单数据
-- ========================================
INSERT INTO `t_source` (`merchant_id`, `source_id`, `source_name`, `source_code`, `path`, `ename`, `new_icon`, `status`, `source_level`, `source_style`, `is_menu`, `description`, `parent_id`, `is_log`, `icon`) VALUES
-- 一级菜单
(1, 1, '系统首页', 'dashboard', '/index', 'dashboard', 'dashboard', 'A', 1, '', 1, '系统首页', 0, 0, 'dashboard'),
(1, 2, '店铺管理', 'store', '/store', 'store', 'store', 'A', 1, '', 1, '店铺管理', 0, 0, 'store'),
(1, 3, '内容管理', 'content', '/content', 'content', 'content', 'A', 1, '', 1, '内容管理', 0, 0, 'content'),
(1, 4, '会员管理', 'member', '/member', 'member', 'user', 'A', 1, '', 1, '会员管理', 0, 0, 'user'),
(1, 5, '汽车服务', 'carService', '/car-service', 'carService', 'car', 'A', 1, '', 1, '汽车服务', 0, 0, 'car'),
(1, 6, '卡券管理', 'coupon', '/coupon', 'coupon', 'coupon', 'A', 1, '', 1, '卡券管理', 0, 0, 'coupon'),
(1, 7, '订单管理', 'order', '/order', 'order', 'shopping', 'A', 1, '', 1, '订单管理', 0, 0, 'shopping'),
(1, 8, '商品管理', 'goods', '/goods', 'goods', 'goods', 'A', 1, '', 1, '商品管理', 0, 0, 'goods'),
(1, 9, '消息管理', 'message', '/message', 'message', 'message', 'A', 1, '', 1, '消息管理', 0, 0, 'message'),
(1, 10, '积分管理', 'point', '/point', 'point', 'edit', 'A', 1, '', 1, '积分管理', 0, 0, 'edit'),
(1, 11, '充值管理', 'recharge', '/recharge', 'recharge', 'money', 'A', 1, '', 1, '充值管理', 0, 0, 'money'),
(1, 12, '分佣提成', 'commission', '/commission', 'commission', 'money', 'A', 1, '', 1, '分佣提成', 0, 0, 'money'),
(1, 13, '系统管理', 'system', '/system', 'system', 'system', 'A', 1, '', 1, '系统管理', 0, 0, 'system'),
-- 二级菜单 - 店铺管理
(1, 21, '店铺列表', 'store:list', '/store/list', 'storeList', 'list', 'A', 2, '', 1, '店铺列表', 2, 0, 'list'),
(1, 22, '员工管理', 'staff:list', '/store/staff', 'storeStaff', 'peoples', 'A', 2, '', 1, '员工管理', 2, 0, 'peoples'),
(1, 23, '预约管理', 'book:list', '/store/booking', 'storeBooking', 'book', 'A', 2, '', 1, '预约管理', 2, 0, 'book'),
(1, 24, '预约记录', 'bookItem:list', '/store/booking-record', 'storeBookingRecord', 'list', 'A', 2, '', 1, '预约记录', 2, 0, 'list'),
(1, 25, '打印设备', 'device:list', '/store/printer', 'storePrinter', 'component', 'A', 2, '', 1, '打印设备', 2, 0, 'component'),
-- 二级菜单 - 内容管理
(1, 31, '轮播管理', 'banner:list', '/content/banner', 'contentBanner', 'component', 'A', 2, '', 1, '轮播管理', 3, 0, 'component'),
(1, 32, '文章管理', 'article:list', '/content/article', 'contentArticle', 'list', 'A', 2, '', 1, '文章管理', 3, 0, 'list'),
(1, 33, '导航管理', 'setting:list', '/content/navigation', 'contentNavigation', 'tree-table', 'A', 2, '', 1, '导航管理', 3, 0, 'tree-table'),
-- 二级菜单 - 会员管理
(1, 41, '会员列表', 'member:list', '/member/list', 'memberList', 'list', 'A', 2, '', 1, '会员列表', 4, 0, 'list'),
(1, 42, '会员分组', 'userGroup:list', '/member/group', 'memberGroup', 'peoples', 'A', 2, '', 1, '会员分组', 4, 0, 'peoples'),
(1, 43, '会员等级', 'userGrade:list', '/member/grade', 'memberGrade', 'component', 'A', 2, '', 1, '会员等级', 4, 0, 'component'),
(1, 44, '开卡赠礼', 'openGift:list', '/member/gift', 'memberGift', 'coupon', 'A', 2, '', 1, '开卡赠礼', 4, 0, 'coupon'),
(1, 45, '会员设置', 'member:setting', '/member/setting', 'memberSetting', 'system', 'A', 2, '', 1, '会员设置', 4, 0, 'system'),
-- 二级菜单 - 汽车服务
(1, 51, '会员车辆', 'vehicle:list', '/car-service/vehicle', 'serviceVehicle', 'car', 'A', 2, '', 1, '会员车辆', 5, 0, 'car'),
(1, 52, '服务订单', 'serviceOrder:list', '/car-service/order', 'serviceOrder', 'list', 'A', 2, '', 1, '服务订单', 5, 0, 'list'),
-- 二级菜单 - 卡券管理
(1, 61, '分组管理', 'couponGroup:list', '/coupon/group', 'couponGroup', 'component', 'A', 2, '', 1, '分组管理', 6, 0, 'component'),
(1, 62, '卡券列表', 'coupon:list', '/coupon/list', 'couponList', 'list', 'A', 2, '', 1, '卡券列表', 6, 0, 'list'),
(1, 63, '卡券核销', 'coupon:verify', '/coupon/verify', 'couponVerify', 'edit', 'A', 2, '', 1, '卡券核销', 6, 0, 'edit'),
(1, 64, '会员卡券', 'userCoupon:list', '/coupon/user', 'couponUser', 'user', 'A', 2, '', 1, '会员卡券', 6, 0, 'user'),
(1, 65, '核销流水', 'confirmLog:list', '/coupon/verify-log', 'couponVerifyLog', 'list', 'A', 2, '', 1, '核销流水', 6, 0, 'list'),
(1, 66, '发券记录', 'sendLog:list', '/coupon/send-log', 'couponSendLog', 'list', 'A', 2, '', 1, '发券记录', 6, 0, 'list'),
(1, 67, '转赠记录', 'give:list', '/coupon/transfer', 'couponTransfer', 'list', 'A', 2, '', 1, '转赠记录', 6, 0, 'list'),
-- 二级菜单 - 订单管理
(1, 71, '订单列表', 'order:list', '/order/list', 'orderList', 'list', 'A', 2, '', 1, '订单列表', 7, 0, 'list'),
(1, 72, '售后订单', 'refund:list', '/order/refund', 'orderRefund', 'edit', 'A', 2, '', 1, '售后订单', 7, 0, 'edit'),
(1, 73, '交易设置', 'order:setting', '/order/setting', 'orderSetting', 'system', 'A', 2, '', 1, '交易设置', 7, 0, 'system'),
(1, 74, '订单结算', 'settlement:list', '/order/settlement', 'orderSettlement', 'money', 'A', 2, '', 1, '订单结算', 7, 0, 'money'),
-- 二级菜单 - 商品管理
(1, 81, '商品分类', 'goods:cate', '/goods/category', 'goodsCategory', 'component', 'A', 2, '', 1, '商品分类', 8, 0, 'component'),
(1, 82, '商品列表', 'goods:list', '/goods/list', 'goodsList', 'list', 'A', 2, '', 1, '商品列表', 8, 0, 'list'),
(1, 83, '库存管理', 'stock:list', '/goods/stock', 'goodsStock', 'shopping', 'A', 2, '', 1, '库存管理', 8, 0, 'shopping'),
-- 二级菜单 - 消息管理
(1, 91, '短信模板', 'smsTemplate:list', '/message/sms-template', 'smsTemplate', 'list', 'A', 2, '', 1, '短信模板', 9, 0, 'list'),
(1, 92, '订阅消息', 'message:subscribe', '/message/subscribe', 'messageSubscribe', 'message', 'A', 2, '', 1, '订阅消息', 9, 0, 'message'),
(1, 93, '已发短信', 'smsLog:list', '/message/sms-log', 'smsLog', 'list', 'A', 2, '', 1, '已发短信', 9, 0, 'list'),
(1, 94, '短信配置', 'sms:setting', '/message/sms-setting', 'smsSetting', 'system', 'A', 2, '', 1, '短信配置', 9, 0, 'system'),
-- 二级菜单 - 积分管理
(1, 101, '积分设置', 'point:setting', '/point/setting', 'pointSetting', 'system', 'A', 2, '', 1, '积分设置', 10, 0, 'system'),
(1, 102, '积分明细', 'point:list', '/point/log', 'pointLog', 'list', 'A', 2, '', 1, '积分明细', 10, 0, 'list'),
-- 二级菜单 - 充值管理
(1, 111, '充值设置', 'balance:setting', '/recharge/setting', 'rechargeSetting', 'system', 'A', 2, '', 1, '充值设置', 11, 0, 'system'),
(1, 112, '余额明细', 'balance:list', '/recharge/balance', 'rechargeBalance', 'money', 'A', 2, '', 1, '余额明细', 11, 0, 'money'),
(1, 113, '会员充值', 'balance:recharge', '/recharge/member', 'rechargeMember', 'user', 'A', 2, '', 1, '会员充值', 11, 0, 'user'),
-- 二级菜单 - 分佣提成
(1, 121, '分佣规则', 'commissionRule:list', '/commission/rule', 'commissionRule', 'system', 'A', 2, '', 1, '分佣规则', 12, 0, 'system'),
(1, 122, '分佣记录', 'commissionLog:list', '/commission/log', 'commissionLog', 'list', 'A', 2, '', 1, '分佣记录', 12, 0, 'list'),
(1, 123, '邀请明细', 'commissionRelation:list', '/commission/invite', 'commissionInvite', 'peoples', 'A', 2, '', 1, '邀请明细', 12, 0, 'peoples'),
(1, 124, '结算记录', 'commissionCash:list', '/commission/settlement', 'commissionSettlement', 'money', 'A', 2, '', 1, '结算记录', 12, 0, 'money'),
-- 二级菜单 - 系统管理
(1, 131, '后台菜单', 'source:list', '/system/menu', 'systemMenu', 'tree-table', 'A', 2, '', 1, '后台菜单', 13, 0, 'tree-table'),
(1, 132, '后台日志', 'actlog:list', '/system/log', 'systemLog', 'list', 'A', 2, '', 1, '后台日志', 13, 0, 'list'),
(1, 133, '后台角色', 'duty:list', '/system/role', 'systemRole', 'component', 'A', 2, '', 1, '后台角色', 13, 0, 'component'),
(1, 134, '后台管理员', 'account:list', '/system/account', 'systemAccount', 'peoples', 'A', 2, '', 1, '后台管理员', 13, 0, 'peoples');

-- ========================================
-- 6. 管理员账户数据（密码为 123456 的 MD5+Salt 加密）
-- ========================================
INSERT INTO `t_account` (`acct_id`, `account_key`, `account_name`, `password`, `account_status`, `is_active`, `create_date`, `modify_date`, `salt`, `role_ids`, `locked`, `owner_id`, `real_name`, `merchant_id`, `store_id`, `staff_id`) VALUES
(1, 'admin', 'admin', '4ce9dcd82a2ed676f0f6e5182d5bbf380a4fbf7e', 1, 1, NOW(), NOW(), 'b130887f80a1a07e', '1', 0, 1, '超级管理员', 0, 0, 0),
(2, 'merchant', 'merchant', '9383fc7f62725d01c950c1304d20cfb9ac9972b2', 1, 1, NOW(), NOW(), 'a20c2c2f9ff27fe2', '2', 0, 1, '商户管理员', 1, 0, 0),
(3, 'store01', 'store01', '17fcd4e10f6b98b447da3eedba75fa8f35f80f7f', 1, 1, NOW(), NOW(), 'ca1a72d8049b2311', '3', 0, 1, '店铺管理员', 1, 1, 0);

-- ========================================
-- 7. 账户角色关联数据
-- ========================================
INSERT INTO `t_account_duty` (`acc_duty_id`, `acct_id`, `duty_id`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);

-- ========================================
-- 8. 角色菜单权限关联数据（超级管理员拥有所有菜单权限）
-- ========================================
INSERT INTO `t_duty_source` (`duty_source_id`, `duty_id`, `source_id`) VALUES
(1, 1, 1), (2, 1, 2), (3, 1, 3), (4, 1, 4), (5, 1, 5), (6, 1, 6), (7, 1, 7), (8, 1, 8), (9, 1, 9), (10, 1, 10),
(11, 1, 11), (12, 1, 12), (13, 1, 13),
(14, 1, 21), (15, 1, 22), (16, 1, 23), (17, 1, 24), (18, 1, 25),
(19, 1, 31), (20, 1, 32), (21, 1, 33),
(22, 1, 41), (23, 1, 42), (24, 1, 43), (25, 1, 44), (26, 1, 45),
(27, 1, 51), (28, 1, 52),
(29, 1, 61), (30, 1, 62), (31, 1, 63), (32, 1, 64), (33, 1, 65), (34, 1, 66), (35, 1, 67),
(36, 1, 71), (37, 1, 72), (38, 1, 73), (39, 1, 74),
(40, 1, 81), (41, 1, 82), (42, 1, 83),
(43, 1, 91), (44, 1, 92), (45, 1, 93), (46, 1, 94),
(47, 1, 101), (48, 1, 102),
(49, 1, 111), (50, 1, 112), (51, 1, 113),
(52, 1, 121), (53, 1, 122), (54, 1, 123), (55, 1, 124),
(56, 1, 131), (57, 1, 132), (58, 1, 133), (59, 1, 134),
-- 商户管理员权限
(60, 2, 1), (61, 2, 2), (62, 2, 3), (63, 2, 4), (64, 2, 5), (65, 2, 6), (66, 2, 7), (67, 2, 8), (68, 2, 9), (69, 2, 10),
(70, 2, 11), (71, 2, 12),
(72, 2, 21), (73, 2, 22), (74, 2, 23), (75, 2, 24), (76, 2, 25),
(77, 2, 31), (78, 2, 32), (79, 2, 33),
(80, 2, 41), (81, 2, 42), (82, 2, 43), (83, 2, 44), (84, 2, 45),
(85, 2, 51), (86, 2, 52),
(87, 2, 61), (88, 2, 62), (89, 2, 63), (90, 2, 64), (91, 2, 65), (92, 2, 66), (93, 2, 67),
(94, 2, 71), (95, 2, 72), (96, 2, 73), (97, 2, 74),
(98, 2, 81), (99, 2, 82), (100, 2, 83),
(101, 2, 91), (102, 2, 92), (103, 2, 93), (104, 2, 94),
(105, 2, 101), (106, 2, 102),
(107, 2, 111), (108, 2, 112), (109, 2, 113),
(110, 2, 121), (111, 2, 122), (112, 2, 123), (113, 2, 124),
-- 店铺管理员权限（部分权限）
(114, 3, 1), (115, 3, 2), (116, 3, 4), (117, 3, 5), (118, 3, 6), (119, 3, 7), (120, 3, 8),
(121, 3, 21), (122, 3, 22), (123, 3, 23), (124, 3, 24),
(125, 3, 41), (126, 3, 42), (127, 3, 43),
(128, 3, 51), (129, 3, 52),
(130, 3, 61), (131, 3, 62), (132, 3, 63), (133, 3, 64),
(134, 3, 71), (135, 3, 72),
(136, 3, 81), (137, 3, 82), (138, 3, 83);

-- ========================================
-- 9. 会员等级数据
-- ========================================
INSERT INTO `mt_user_grade` (`ID`, `MERCHANT_ID`, `GRADE`, `NAME`, `CATCH_CONDITION`, `CATCH_TYPE`, `CATCH_VALUE`, `USER_PRIVILEGE`, `VALID_DAY`, `DISCOUNT`, `SPEED_POINT`, `STATUS`) VALUES
(1, 1, 1, '普通会员', '注册即可获得', 'init', 0.00, '基础会员权益', 0, 10.00, 1.00, 'A'),
(2, 1, 2, '银卡会员', '累积消费满500元', 'amount', 500.00, '享受9.5折优惠，积分1.2倍加速', 365, 9.50, 1.20, 'A'),
(3, 1, 3, '金卡会员', '累积消费满2000元', 'amount', 2000.00, '享受9折优惠，积分1.5倍加速，免费洗车2次/月', 365, 9.00, 1.50, 'A'),
(4, 1, 4, '钻石会员', '累积消费满5000元', 'amount', 5000.00, '享受8.5折优惠，积分2倍加速，免费洗车4次/月，专属顾问', 365, 8.50, 2.00, 'A');

-- ========================================
-- 10. 会员分组数据
-- ========================================
INSERT INTO `mt_user_group` (`ID`, `MERCHANT_ID`, `STORE_ID`, `NAME`, `PARENT_ID`, `DESCRIPTION`, `CREATE_TIME`, `UPDATE_TIME`, `OPERATOR`, `STATUS`) VALUES
(1, 1, 0, '普通客户', 0, '普通到店客户', NOW(), NOW(), 'admin', 'A'),
(2, 1, 0, 'VIP客户', 0, '高频消费客户', NOW(), NOW(), 'admin', 'A'),
(3, 1, 0, '企业客户', 0, '企业车队合作客户', NOW(), NOW(), 'admin', 'A'),
(4, 1, 0, '新客户', 0, '首次到店注册客户', NOW(), NOW(), 'admin', 'A');

-- ========================================
-- 11. 商品分类数据（汽车服务相关）
-- ========================================
INSERT INTO `mt_goods_cate` (`ID`, `MERCHANT_ID`, `STORE_ID`, `NAME`, `LOGO`, `DESCRIPTION`, `CREATE_TIME`, `UPDATE_TIME`, `OPERATOR`, `SORT`, `STATUS`) VALUES
(1, 1, 0, '洗车服务', '', '各类洗车服务项目', NOW(), NOW(), 'admin', 1, 'A'),
(2, 1, 0, '美容养护', '', '汽车美容养护服务', NOW(), NOW(), 'admin', 2, 'A'),
(3, 1, 0, '维修保养', '', '汽车维修保养服务', NOW(), NOW(), 'admin', 3, 'A'),
(4, 1, 0, '轮胎服务', '', '轮胎更换维修服务', NOW(), NOW(), 'admin', 4, 'A'),
(5, 1, 0, '钣金喷漆', '', '车身钣金喷漆修复', NOW(), NOW(), 'admin', 5, 'A'),
(6, 1, 0, '汽车用品', '', '汽车配件及用品销售', NOW(), NOW(), 'admin', 6, 'A'),
(7, 1, 0, '套餐服务', '', '组合套餐服务', NOW(), NOW(), 'admin', 7, 'A');

-- ========================================
-- 12. 商品数据（汽车服务项目）
-- ========================================
INSERT INTO `mt_goods` (`ID`, `TYPE`, `MERCHANT_ID`, `STORE_ID`, `NAME`, `CATE_ID`, `GOODS_NO`, `IS_SINGLE_SPEC`, `PRICE`, `LINE_PRICE`, `STOCK`, `SERVICE_TIME`, `INIT_SALE`, `SALE_POINT`, `SORT`, `DESCRIPTION`, `CREATE_TIME`, `UPDATE_TIME`, `OPERATOR`, `STATUS`) VALUES
(1, 'service', 1, 0, '普通洗车', 1, 'XC001', 'Y', 38.00, 58.00, 999, 30, 128, '快速高效，30分钟完成', 1, '普通洗车服务，包含外观冲洗、泡沫清洁、擦干', NOW(), NOW(), 'admin', 'A'),
(2, 'service', 1, 0, '精致洗车', 1, 'XC002', 'Y', 68.00, 98.00, 999, 60, 86, '内外兼修，深度清洁', 2, '精致洗车服务，包含外观精洗、内饰吸尘、仪表盘清洁、脚垫清洗', NOW(), NOW(), 'admin', 'A'),
(3, 'service', 1, 0, '全车打蜡', 2, 'MR001', 'Y', 198.00, 298.00, 999, 120, 45, '持久亮泽，保护车漆', 3, '全车打蜡服务，使用进口蜡品，持久保护车漆', NOW(), NOW(), 'admin', 'A'),
(4, 'service', 1, 0, '漆面抛光', 2, 'MR002', 'Y', 388.00, 588.00, 999, 180, 32, '恢复光泽，去除划痕', 4, '专业漆面抛光，去除轻微划痕，恢复漆面光泽', NOW(), NOW(), 'admin', 'A'),
(5, 'service', 1, 0, '小保养', 3, 'BY001', 'Y', 299.00, 399.00, 999, 60, 156, '更换机油机滤', 5, '小保养服务，更换机油、机油滤芯，检查基本项目', NOW(), NOW(), 'admin', 'A'),
(6, 'service', 1, 0, '大保养', 3, 'BY002', 'Y', 699.00, 999.00, 999, 120, 78, '全面保养检测', 6, '大保养服务，更换机油、三滤，检查刹车、底盘等全面项目', NOW(), NOW(), 'admin', 'A'),
(7, 'service', 1, 0, '轮胎更换（单条）', 4, 'LT001', 'Y', 150.00, 200.00, 999, 30, 45, '专业安装，含动平衡', 7, '单条轮胎更换服务，含拆装和动平衡（不含轮胎费用）', NOW(), NOW(), 'admin', 'A'),
(8, 'service', 1, 0, '四轮定位', 4, 'LT002', 'Y', 268.00, 368.00, 999, 60, 36, '精准定位，安全行驶', 8, '四轮定位服务，使用专业设备精准调校', NOW(), NOW(), 'admin', 'A'),
(9, 'goods', 1, 0, '行车记录仪', 6, 'YP001', 'Y', 299.00, 499.00, 50, 0, 28, '高清记录，安全行驶', 9, '1080P高清行车记录仪，前后双录，停车监控', NOW(), NOW(), 'admin', 'A'),
(10, 'service', 1, 0, '洗车+打蜡套餐', 7, 'TC001', 'Y', 218.00, 356.00, 999, 150, 62, '超值套餐，一站式服务', 10, '精致洗车+全车打蜡套餐，一次解决清洁养护需求', NOW(), NOW(), 'admin', 'A');

-- ========================================
-- 13. 轮播图数据
-- ========================================
INSERT INTO `mt_banner` (`ID`, `TITLE`, `MERCHANT_ID`, `STORE_ID`, `URL`, `IMAGE`, `DESCRIPTION`, `CREATE_TIME`, `UPDATE_TIME`, `OPERATOR`, `SORT`, `STATUS`) VALUES
(1, '新会员注册有礼', 1, 0, '/pages/register/index', '', '新会员注册即送洗车券', NOW(), NOW(), 'admin', 1, 'A'),
(2, '精致洗车特惠', 1, 0, '/pages/goods/detail?id=2', '', '精致洗车限时特惠68元', NOW(), NOW(), 'admin', 2, 'A'),
(3, '保养套餐优惠', 1, 0, '/pages/goods/detail?id=5', '', '小保养套餐299元起', NOW(), NOW(), 'admin', 3, 'A');

-- ========================================
-- 14. 优惠券组数据
-- ========================================
INSERT INTO `mt_coupon_group` (`ID`, `MERCHANT_ID`, `STORE_ID`, `NAME`, `MONEY`, `NUM`, `TOTAL`, `DESCRIPTION`, `CREATE_TIME`, `UPDATE_TIME`, `OPERATOR`, `STATUS`) VALUES
(1, 1, 0, '新人专享券包', 50.00, 3, 1000, '新注册会员专享优惠券包', NOW(), NOW(), 'admin', 'A'),
(2, 1, 0, '节日活动券包', 100.00, 5, 500, '节日促销活动券包', NOW(), NOW(), 'admin', 'A'),
(3, 1, 0, '会员生日券', 30.00, 1, 2000, '会员生日当月专享券', NOW(), NOW(), 'admin', 'A');

-- ========================================
-- 15. 优惠券数据
-- ========================================
INSERT INTO `mt_coupon` (`ID`, `MERCHANT_ID`, `STORE_ID`, `GROUP_ID`, `TYPE`, `NAME`, `IS_GIVE`, `POINT`, `APPLY_GOODS`, `EXPIRE_TYPE`, `EXPIRE_TIME`, `BEGIN_TIME`, `END_TIME`, `AMOUNT`, `SEND_WAY`, `SEND_NUM`, `TOTAL`, `LIMIT_NUM`, `DESCRIPTION`, `CREATE_TIME`, `UPDATE_TIME`, `OPERATOR`, `STATUS`) VALUES
(1, 1, 0, 1, 'C', '新人洗车券', 0, 0, 'allGoods', 'fix', 30, NULL, NULL, 20.00, 'register', 1, 1000, 1, '新人注册赠送洗车优惠券，满38元可用', NOW(), NOW(), 'admin', 'A'),
(2, 1, 0, 1, 'C', '新人保养券', 0, 0, 'allGoods', 'fix', 60, NULL, NULL, 30.00, 'register', 1, 1000, 1, '新人注册赠送保养优惠券，满299元可用', NOW(), NOW(), 'admin', 'A'),
(3, 1, 0, 2, 'C', '满100减20券', 1, 0, 'allGoods', 'fix', 30, NULL, NULL, 20.00, 'backend', 1, 500, 3, '消费满100元减20元', NOW(), NOW(), 'admin', 'A'),
(4, 1, 0, 2, 'P', '500元储值卡', 0, 0, 'allGoods', 'fix', 365, NULL, NULL, 500.00, 'backend', 1, 200, 1, '500元储值预存卡，充值后可直接消费', NOW(), NOW(), 'admin', 'A'),
(5, 1, 0, 3, 'C', '生日8折券', 0, 0, 'allGoods', 'fix', 30, NULL, NULL, 0.00, 'birthday', 1, 2000, 1, '会员生日当月享8折优惠', NOW(), NOW(), 'admin', 'A'),
(6, 1, 0, 0, 'T', '洗车集次卡（10次）', 0, 0, 'parkGoods', 'fix', 365, NULL, NULL, 380.00, 'backend', 1, 300, 1, '购买10次洗车服务集次卡，单次仅需38元', NOW(), NOW(), 'admin', 'A');

-- ========================================
-- 16. 全局设置数据
-- ========================================
INSERT INTO `mt_setting` (`ID`, `MERCHANT_ID`, `STORE_ID`, `TYPE`, `NAME`, `VALUE`, `DESCRIPTION`, `CREATE_TIME`, `UPDATE_TIME`, `OPERATOR`, `STATUS`) VALUES
(1, 1, 0, 'point', 'pointNeedConsume', '1', '每消费1元获得1积分', NOW(), NOW(), 'admin', 'A'),
(2, 1, 0, 'point', 'canUsedAsMoney', 'true', '积分是否可以当钱使用', NOW(), NOW(), 'admin', 'A'),
(3, 1, 0, 'point', 'exchangeNeedPoint', '100', '多少积分抵扣1元', NOW(), NOW(), 'admin', 'A'),
(4, 1, 0, 'point', 'rechargePointSpeed', '1', '充值积分倍数', NOW(), NOW(), 'admin', 'A'),
(5, 1, 0, 'order', 'deliveryFee', '0', '配送费', NOW(), NOW(), 'admin', 'A'),
(6, 1, 0, 'order', 'deliveryMinAmount', '0', '免配送费门槛', NOW(), NOW(), 'admin', 'A'),
(7, 1, 0, 'order', 'isClose', 'false', '是否关闭交易功能', NOW(), NOW(), 'admin', 'A'),
(8, 1, 0, 'balance', 'rechargePlanList', '[{"planId":1,"planName":"100元","rechargeAmount":100,"giveAmount":10},{"planId":2,"planName":"300元","rechargeAmount":300,"giveAmount":50},{"planId":3,"planName":"500元","rechargeAmount":500,"giveAmount":100},{"planId":4,"planName":"1000元","rechargeAmount":1000,"giveAmount":250}]', '充值方案列表', NOW(), NOW(), 'admin', 'A'),
(9, 1, 0, 'system', 'systemName', '汽车会员管理系统', '系统名称', NOW(), NOW(), 'admin', 'A'),
(10, 1, 0, 'system', 'systemLogo', '', '系统LOGO', NOW(), NOW(), 'admin', 'A'),
(11, 1, 0, 'member', 'openRegister', 'true', '是否开放注册', NOW(), NOW(), 'admin', 'A'),
(12, 1, 0, 'member', 'registerGiftPoint', '100', '注册赠送积分', NOW(), NOW(), 'admin', 'A'),
(13, 1, 0, 'member', 'registerGiftCouponId', '1', '注册赠送优惠券ID', NOW(), NOW(), 'admin', 'A');

-- ========================================
-- 17. 短信模板数据
-- ========================================
INSERT INTO `mt_sms_template` (`ID`, `MERCHANT_ID`, `STORE_ID`, `NAME`, `UNAME`, `CODE`, `CONTENT`, `CREATE_TIME`, `UPDATE_TIME`, `OPERATOR`, `STATUS`) VALUES
(1, 1, 0, '验证码', 'verifyCode', 'verify_code', '您的验证码是${code}，有效期${time}分钟，请勿泄露给他人。', NOW(), NOW(), 'admin', 'A'),
(2, 1, 0, '消费通知', 'consumeNotice', 'consume_notice', '尊敬的${name}，您在${store}消费${amount}元，当前余额${balance}元。', NOW(), NOW(), 'admin', 'A'),
(3, 1, 0, '充值成功', 'rechargeSuccess', 'recharge_success', '尊敬的${name}，您已成功充值${amount}元，当前余额${balance}元。', NOW(), NOW(), 'admin', 'A'),
(4, 1, 0, '预约确认', 'bookConfirm', 'book_confirm', '尊敬的${name}，您已成功预约${service}，时间：${time}，门店：${store}。', NOW(), NOW(), 'admin', 'A'),
(5, 1, 0, '保养提醒', 'maintainRemind', 'maintain_remind', '尊敬的${name}，您的爱车（${carNo}）距上次保养已满${days}天，建议尽快到店保养。', NOW(), NOW(), 'admin', 'A');

-- ========================================
-- 18. 员工数据
-- ========================================
INSERT INTO `mt_staff` (`ID`, `MERCHANT_ID`, `STORE_ID`, `USER_ID`, `CATEGORY`, `MOBILE`, `REAL_NAME`, `CREATE_TIME`, `UPDATE_TIME`, `AUDITED_STATUS`, `DESCRIPTION`) VALUES
(1, 1, 1, 0, 1, '13800138001', '张经理', NOW(), NOW(), 'A', '总店店长'),
(2, 1, 1, 0, 2, '13800138010', '李收银', NOW(), NOW(), 'A', '总店收银员'),
(3, 1, 1, 0, 3, '13800138011', '王师傅', NOW(), NOW(), 'A', '总店洗车技师'),
(4, 1, 1, 0, 3, '13800138012', '赵师傅', NOW(), NOW(), 'A', '总店保养技师'),
(5, 1, 2, 0, 1, '13800138002', '李经理', NOW(), NOW(), 'A', '望京店店长'),
(6, 1, 3, 0, 1, '13800138003', '王经理', NOW(), NOW(), 'A', '国贸店店长');

-- ========================================
-- 19. 文章数据
-- ========================================
INSERT INTO `mt_article` (`ID`, `STORE_ID`, `MERCHANT_ID`, `TITLE`, `BRIEF`, `URL`, `IMAGE`, `DESCRIPTION`, `CLICK`, `CREATE_TIME`, `UPDATE_TIME`, `OPERATOR`, `SORT`, `STATUS`) VALUES
(1, 0, 1, '汽车保养小知识：何时需要更换机油？', '了解机油更换的最佳时机，让爱车始终保持最佳状态', '', '', '<p>机油是发动机的"血液"，定期更换至关重要。一般建议：矿物油每5000公里或半年更换一次；半合成油每7500公里或9个月更换一次；全合成油每10000公里或1年更换一次。</p>', 256, NOW(), NOW(), 'admin', 1, 'A'),
(2, 0, 1, '夏季用车注意事项', '夏天高温天气下的汽车使用与保养建议', '', '', '<p>夏季高温容易造成轮胎爆胎、发动机过热等问题。建议定期检查轮胎气压、冷却液液位，避免长时间暴晒停车。</p>', 189, NOW(), NOW(), 'admin', 2, 'A'),
(3, 0, 1, '会员积分兑换指南', '了解如何使用积分兑换精彩好礼', '', '', '<p>消费1元获得1积分，100积分可抵扣1元消费。积分还可兑换洗车券、保养券等精美礼品。</p>', 345, NOW(), NOW(), 'admin', 3, 'A');

-- ========================================
-- 20. 预约配置数据
-- ========================================
INSERT INTO `mt_book` (`ID`, `MERCHANT_ID`, `STORE_ID`, `GOODS_ID`, `SERVICE_DATES`, `SERVICE_TIMES`, `SERVICE_STAFF_IDS`, `DESCRIPTION`, `CREATE_TIME`, `UPDATE_TIME`, `OPERATOR`, `STATUS`) VALUES
(1, 1, 1, 1, '周一,周二,周三,周四,周五,周六,周日', '08:00-09:00,09:00-10:00,10:00-11:00,11:00-12:00,13:00-14:00,14:00-15:00,15:00-16:00,16:00-17:00,17:00-18:00', '3,4', '洗车服务预约，请提前至少2小时预约', NOW(), NOW(), 'admin', 'A'),
(2, 1, 1, 5, '周一,周二,周三,周四,周五,周六', '08:30-09:30,09:30-10:30,10:30-11:30,13:30-14:30,14:30-15:30,15:30-16:30', '4', '保养服务预约，需提前一天预约', NOW(), NOW(), 'admin', 'A');
