-- fuint-car 数据初始化脚本
-- 生成时间: 2026-05-08 14:56:15
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ------- mt_merchant -------
INSERT INTO `mt_merchant` (`id`, `name`, `no`, `logo`, `contact`, `phone`, `address`, `description`, `status`, `create_time`, `update_time`) VALUES
(1, '小隅安商行', 'M0001', '', '张元', '17400004125', '海口市', '汽车会员管理系统', 'A', '2022-01-01 00:00:00', '2026-05-06 00:00:00');

-- ------- mt_store -------
TRUNCATE TABLE `mt_store`;
INSERT INTO `mt_store` (`id`, `merchant_id`, `name`, `is_default`, `contact`, `phone`, `address`, `hours`, `latitude`, `longitude`, `description`, `status`, `create_time`, `update_time`) VALUES (3, 1, '海口永万路店', 'Y', '张元', '174****4125  ', '1路7号2楼01室                                                                                           ', '￥%……&', '10.004229', '110.273855', '海口分店', 'A', '2022-01-07 16:57:42', '2026-05-06 15:43:39');
INSERT INTO `mt_store` (`id`, `merchant_id`, `name`, `is_default`, `contact`, `phone`, `address`, `hours`, `latitude`, `longitude`, `description`, `status`, `create_time`, `update_time`) VALUES (2, 1, '海口科技路店', 'N', '张小斐', '123****89011', '上海市九新公路818号天宇歆翱创意园C栋C11-C13号', '9:00-20：00', '', '', '上海松江分店', 'A', '2020-04-26 09:27:22', '2026-05-06 10:35:29');
INSERT INTO `mt_store` (`id`, `merchant_id`, `name`, `is_default`, `contact`, `phone`, `address`, `hours`, `latitude`, `longitude`, `description`, `status`, `create_time`, `update_time`) VALUES (4, 1, '海口长彤路店', 'N', '王辉', '189****7743', '海口市西海岸长彤路220号', '9:00-22:00', '20.01874', '110.34967', '长彤路店', 'A', '2022-01-14 11:22:03', '2026-04-04 12:45:43');
INSERT INTO `mt_store` (`id`, `merchant_id`, `name`, `is_default`, `contact`, `phone`, `address`, `hours`, `latitude`, `longitude`, `description`, `status`, `create_time`, `update_time`) VALUES (5, 1, '海口国兴路店', 'N', '张易', '138****8001', '海口市白石桥', '9:00-22:00', '110.293768', '19.99326', '海口分店', 'A', '2022-02-11 13:40:35', '2026-04-04 12:45:34');

-- ------- mt_staff -------
TRUNCATE TABLE `mt_staff`;
INSERT INTO `mt_staff` (`id`, `merchant_id`, `store_id`, `user_id`, `category`, `mobile`, `real_name`, `audit_status`, `status`, `create_time`, `update_time`) VALUES (117, 1, 3, 7967, 1, '138****4441', '20260422', 'A', 'A', '2026-04-22 15:56:59', '2026-05-03 21:40:43');
INSERT INTO `mt_staff` (`id`, `merchant_id`, `store_id`, `user_id`, `category`, `mobile`, `real_name`, `audit_status`, `status`, `create_time`, `update_time`) VALUES (115, 1, 89, 7938, 1, '159****2745', 'msk', 'A', 'A', '2026-04-07 16:10:19', '2026-04-07 16:10:19');
INSERT INTO `mt_staff` (`id`, `merchant_id`, `store_id`, `user_id`, `category`, `mobile`, `real_name`, `audit_status`, `status`, `create_time`, `update_time`) VALUES (114, 1, 0, 7918, 1, '187****2595', '18799152595', 'A', 'A', '2026-03-17 23:23:27', '2026-03-17 23:23:27');
INSERT INTO `mt_staff` (`id`, `merchant_id`, `store_id`, `user_id`, `category`, `mobile`, `real_name`, `audit_status`, `status`, `create_time`, `update_time`) VALUES (112, 1, 2, 7896, 0, '155****6556', 'ces', 'A', 'A', '2026-02-25 21:50:36', '2026-02-25 21:50:36');
INSERT INTO `mt_staff` (`id`, `merchant_id`, `store_id`, `user_id`, `category`, `mobile`, `real_name`, `audit_status`, `status`, `create_time`, `update_time`) VALUES (111, 1, 2, 7878, 1, '131****1111', 'xl888888', 'N', 'A', '2026-01-21 14:57:44', '2026-02-02 16:16:20');
INSERT INTO `mt_staff` (`id`, `merchant_id`, `store_id`, `user_id`, `category`, `mobile`, `real_name`, `audit_status`, `status`, `create_time`, `update_time`) VALUES (110, 1, 73, 7837, 1, '188****8888', '18888888888', 'A', 'A', '2025-12-29 11:20:26', '2025-12-29 11:20:26');
INSERT INTO `mt_staff` (`id`, `merchant_id`, `store_id`, `user_id`, `category`, `mobile`, `real_name`, `audit_status`, `status`, `create_time`, `update_time`) VALUES (109, 1, 2, 7835, 4, '155****5555', '测试888', 'A', 'A', '2025-11-02 12:48:27', '2025-12-25 20:49:24');
INSERT INTO `mt_staff` (`id`, `merchant_id`, `store_id`, `user_id`, `category`, `mobile`, `real_name`, `audit_status`, `status`, `create_time`, `update_time`) VALUES (108, 1, 2, 7834, 1, '138****7233', '测试店长', 'A', 'A', '2025-11-02 12:43:36', '2025-12-04 22:04:43');
INSERT INTO `mt_staff` (`id`, `merchant_id`, `store_id`, `user_id`, `category`, `mobile`, `real_name`, `audit_status`, `status`, `create_time`, `update_time`) VALUES (105, 1, 0, 7793, 1, '138****0000', 'test05', 'N', 'A', '2025-08-10 15:55:10', '2025-10-10 15:05:36');
INSERT INTO `mt_staff` (`id`, `merchant_id`, `store_id`, `user_id`, `category`, `mobile`, `real_name`, `audit_status`, `status`, `create_time`, `update_time`) VALUES (104, 1, 0, 7791, 0, '185****1100', '1264565', 'A', 'A', '2025-08-08 22:58:37', '2025-10-14 14:38:52');
INSERT INTO `mt_staff` (`id`, `merchant_id`, `store_id`, `user_id`, `category`, `mobile`, `real_name`, `audit_status`, `status`, `create_time`, `update_time`) VALUES (100, 1, 2, 7668, 3, '177****0111', '老王', 'A', 'A', '2025-04-10 01:18:32', '2025-06-19 02:27:42');
INSERT INTO `mt_staff` (`id`, `merchant_id`, `store_id`, `user_id`, `category`, `mobile`, `real_name`, `audit_status`, `status`, `create_time`, `update_time`) VALUES (95, 1, 2, 7596, 2, '155****2312', 'www888', 'A', 'A', '2025-03-04 15:48:43', '2025-04-21 18:40:35');
INSERT INTO `mt_staff` (`id`, `merchant_id`, `store_id`, `user_id`, `category`, `mobile`, `real_name`, `audit_status`, `status`, `create_time`, `update_time`) VALUES (82, 1, 3, 7551, 4, '134****7428', '手上上', 'A', 'A', '2025-02-05 20:28:35', '2025-03-19 21:00:01');
INSERT INTO `mt_staff` (`id`, `merchant_id`, `store_id`, `user_id`, `category`, `mobile`, `real_name`, `audit_status`, `status`, `create_time`, `update_time`) VALUES (81, 1, 4, 7548, 2, '135****6781', '', 'A', 'A', '2025-01-20 17:20:50', '2025-01-20 17:20:50');
INSERT INTO `mt_staff` (`id`, `merchant_id`, `store_id`, `user_id`, `category`, `mobile`, `real_name`, `audit_status`, `status`, `create_time`, `update_time`) VALUES (55, 1, 0, 7486, 1, '177****2980', '小禾', 'A', 'A', '2024-12-13 14:40:03', '2026-01-08 16:15:18');
INSERT INTO `mt_staff` (`id`, `merchant_id`, `store_id`, `user_id`, `category`, `mobile`, `real_name`, `audit_status`, `status`, `create_time`, `update_time`) VALUES (2, 1, 3, 7397, 1, '166****0701', '章里雯', 'A', 'A', '2023-07-24 20:12:31', '2025-07-18 09:35:33');
INSERT INTO `mt_staff` (`id`, `merchant_id`, `store_id`, `user_id`, `category`, `mobile`, `real_name`, `audit_status`, `status`, `create_time`, `update_time`) VALUES (1, 1, 2, 7398, 1, '189****9980', '符小安', 'A', 'A', '2023-07-24 18:57:49', '2026-01-06 14:06:05');

-- ------- mt_user_group -------
TRUNCATE TABLE `mt_user_group`;
INSERT INTO `mt_user_group` (`id`, `merchant_id`, `name`, `parent_id`, `status`, `description`, `create_time`, `update_time`, `operator`) VALUES (41, 1, '小阳4', 0, 'N', '测试', '2026-04-16 20:13:12', '2026-05-06 09:03:38', 'fuint');
INSERT INTO `mt_user_group` (`id`, `merchant_id`, `name`, `parent_id`, `status`, `description`, `create_time`, `update_time`, `operator`) VALUES (40, 1, '小阳3', 0, 'A', '', '2026-03-27 20:38:37', '2026-04-10 13:53:47', 'fuint');
INSERT INTO `mt_user_group` (`id`, `merchant_id`, `name`, `parent_id`, `status`, `description`, `create_time`, `update_time`, `operator`) VALUES (37, 1, '售后部', 0, 'A', '', '2025-09-18 09:59:49', '2025-09-18 09:59:49', 'fuint');
INSERT INTO `mt_user_group` (`id`, `merchant_id`, `name`, `parent_id`, `status`, `description`, `create_time`, `update_time`, `operator`) VALUES (35, 1, '01', 0, 'A', '', '2025-05-27 09:38:27', '2025-05-27 09:38:27', 'fuint');
INSERT INTO `mt_user_group` (`id`, `merchant_id`, `name`, `parent_id`, `status`, `description`, `create_time`, `update_time`, `operator`) VALUES (33, 1, '的', 0, 'A', '', '2025-05-21 09:18:54', '2025-05-21 09:18:54', 'fuint');
INSERT INTO `mt_user_group` (`id`, `merchant_id`, `name`, `parent_id`, `status`, `description`, `create_time`, `update_time`, `operator`) VALUES (30, 1, '23554', 0, 'A', '', '2025-03-05 12:33:05', '2025-03-09 12:37:06', 'fuint');
INSERT INTO `mt_user_group` (`id`, `merchant_id`, `name`, `parent_id`, `status`, `description`, `create_time`, `update_time`, `operator`) VALUES (26, 1, '33dfdf', 0, 'N', '', '2025-03-05 11:05:55', '2025-05-08 15:18:08', 'fuint');
INSERT INTO `mt_user_group` (`id`, `merchant_id`, `name`, `parent_id`, `status`, `description`, `create_time`, `update_time`, `operator`) VALUES (15, 1, 'vvip3', 0, 'A', '', '2025-02-15 07:44:31', '2025-03-05 12:44:53', 'fuint');
INSERT INTO `mt_user_group` (`id`, `merchant_id`, `name`, `parent_id`, `status`, `description`, `create_time`, `update_time`, `operator`) VALUES (13, 1, '店铺管理员-会员分组', 0, 'A', '', '2024-09-05 15:16:25', '2025-03-01 00:07:09', 'fuint');
INSERT INTO `mt_user_group` (`id`, `merchant_id`, `name`, `parent_id`, `status`, `description`, `create_time`, `update_time`, `operator`) VALUES (12, 1, 'V01', 0, 'A', 'V01', '2023-11-20 17:40:10', '2024-10-18 11:45:05', 'fuint');
INSERT INTO `mt_user_group` (`id`, `merchant_id`, `name`, `parent_id`, `status`, `description`, `create_time`, `update_time`, `operator`) VALUES (11, 1, '小时卡', 0, 'A', '按小时计费', '2023-11-06 20:08:14', '2025-03-01 02:16:11', 'fuint');
INSERT INTO `mt_user_group` (`id`, `merchant_id`, `name`, `parent_id`, `status`, `description`, `create_time`, `update_time`, `operator`) VALUES (10, 1, '长期客户', 0, 'A', '', '2023-11-04 12:05:02', '2023-11-06 19:22:20', 'admin');

-- ------- mt_user_grade -------
TRUNCATE TABLE `mt_user_grade`;
INSERT INTO `mt_user_grade` (`id`, `merchant_id`, `grade`, `name`, `catch_type`, `catch_value`, `valid_day`, `discount`, `speed_point`, `status`) VALUES (94, 1, 5, '测试会员', '累积消费金额升级', 6000.0, 30, 8.0, 4.0, 'A');
INSERT INTO `mt_user_grade` (`id`, `merchant_id`, `grade`, `name`, `catch_type`, `catch_value`, `valid_day`, `discount`, `speed_point`, `status`) VALUES (5, 1, 4, '金牌会员', '付费升级', 5000.0, 0, 8.8, 3.0, 'A');
INSERT INTO `mt_user_grade` (`id`, `merchant_id`, `grade`, `name`, `catch_type`, `catch_value`, `valid_day`, `discount`, `speed_point`, `status`) VALUES (4, 1, 3, '银牌会员', '付费升级', 1000.0, 0, 9.0, 2.0, 'A');
INSERT INTO `mt_user_grade` (`id`, `merchant_id`, `grade`, `name`, `catch_type`, `catch_value`, `valid_day`, `discount`, `speed_point`, `status`) VALUES (2, 1, 2, '铜牌会员', '付费升级', 600.0, 100, 9.0, 2.0, 'A');
INSERT INTO `mt_user_grade` (`id`, `merchant_id`, `grade`, `name`, `catch_type`, `catch_value`, `valid_day`, `discount`, `speed_point`, `status`) VALUES (1, 1, 1, '普通会员', '默认获取', 0.0, 0, 0.0, 0.0, 'A');

-- ------- mt_goods_cate -------
TRUNCATE TABLE `mt_goods_cate`;
INSERT INTO `mt_goods_cate` (`id`, `merchant_id`, `store_id`, `name`, `logo`, `description`, `sort`, `status`, `create_time`, `update_time`, `operator`) VALUES (1, 1, 0, '洗车美容', '/static/defaultImage/xi.png', '1234', 0, 'A', NULL, NULL, 'fuint');
INSERT INTO `mt_goods_cate` (`id`, `merchant_id`, `store_id`, `name`, `logo`, `description`, `sort`, `status`, `create_time`, `update_time`, `operator`) VALUES (2, 1, 0, '贴膜服务', '/static/defaultImage/mo.png', '', 1, 'A', NULL, NULL, 'fuint');
INSERT INTO `mt_goods_cate` (`id`, `merchant_id`, `store_id`, `name`, `logo`, `description`, `sort`, `status`, `create_time`, `update_time`, `operator`) VALUES (3, 1, 0, '机修服务', '/static/defaultImage/repair.png', '好物推荐', 2, 'A', NULL, NULL, 'fuint');
INSERT INTO `mt_goods_cate` (`id`, `merchant_id`, `store_id`, `name`, `logo`, `description`, `sort`, `status`, `create_time`, `update_time`, `operator`) VALUES (193, 1, 0, '检车服务', '/uploads/20250910/b3f87d5f423e4083bc589fd70893e99b.png', '', 3, 'A', NULL, NULL, 'fuint');
INSERT INTO `mt_goods_cate` (`id`, `merchant_id`, `store_id`, `name`, `logo`, `description`, `sort`, `status`, `create_time`, `update_time`, `operator`) VALUES (4, 1, 0, '其他服务', '/static/defaultImage/other.png', '低价甩卖', 4, 'A', NULL, NULL, 'fuint');

-- ------- mt_coupon_group -------
TRUNCATE TABLE `mt_coupon_group`;
INSERT INTO `mt_coupon_group` (`id`, `merchant_id`, `store_id`, `name`, `total`, `description`, `status`, `create_time`, `update_time`, `operator`) VALUES (13, 1, 0, '月末福利卡券', 0, '', 'A', '2026-03-31 16:06:29', '2026-03-31 16:06:29', 'fuint');
INSERT INTO `mt_coupon_group` (`id`, `merchant_id`, `store_id`, `name`, `total`, `description`, `status`, `create_time`, `update_time`, `operator`) VALUES (12, 1, 0, '五一活动', 0, '', 'A', '2026-03-24 13:30:12', '2026-03-24 13:30:12', 'fuint');
INSERT INTO `mt_coupon_group` (`id`, `merchant_id`, `store_id`, `name`, `total`, `description`, `status`, `create_time`, `update_time`, `operator`) VALUES (10, 1, 2, '计次卡', 0, '', 'A', '2025-11-11 14:03:03', '2025-11-11 14:03:03', 'fuint');
INSERT INTO `mt_coupon_group` (`id`, `merchant_id`, `store_id`, `name`, `total`, `description`, `status`, `create_time`, `update_time`, `operator`) VALUES (9, 1, 0, '售后部', 0, '', 'A', '2025-09-17 12:10:04', '2025-09-17 12:10:04', 'fuint');
INSERT INTO `mt_coupon_group` (`id`, `merchant_id`, `store_id`, `name`, `total`, `description`, `status`, `create_time`, `update_time`, `operator`) VALUES (8, 1, 0, '销售部', 0, '', 'A', '2025-09-17 12:09:52', '2025-09-17 12:09:52', 'fuint');
INSERT INTO `mt_coupon_group` (`id`, `merchant_id`, `store_id`, `name`, `total`, `description`, `status`, `create_time`, `update_time`, `operator`) VALUES (6, 1, 5, '111', 0, '', 'A', '2025-06-03 09:49:34', '2025-06-03 09:49:34', 'fuint');
INSERT INTO `mt_coupon_group` (`id`, `merchant_id`, `store_id`, `name`, `total`, `description`, `status`, `create_time`, `update_time`, `operator`) VALUES (5, 1, 0, '你说我组不组', 0, '', 'A', '2025-03-09 18:44:37', '2025-03-09 18:44:37', 'fuint');
INSERT INTO `mt_coupon_group` (`id`, `merchant_id`, `store_id`, `name`, `total`, `description`, `status`, `create_time`, `update_time`, `operator`) VALUES (4, 1, 0, '**********', 0, '', 'A', '2025-03-09 13:46:52', '2025-03-09 13:46:52', 'fuint');
INSERT INTO `mt_coupon_group` (`id`, `merchant_id`, `store_id`, `name`, `total`, `description`, `status`, `create_time`, `update_time`, `operator`) VALUES (3, 1, 0, '日常营销', 0, '', 'N', '2024-12-02 10:51:52', '2025-03-09 08:27:12', 'fuint');
INSERT INTO `mt_coupon_group` (`id`, `merchant_id`, `store_id`, `name`, `total`, `description`, `status`, `create_time`, `update_time`, `operator`) VALUES (2, 1, 0, '新手用户', 0, '1111', 'A', '2024-08-26 16:40:56', '2024-12-02 10:51:41', 'fuint');

-- ------- t_account (后台管理账号) -------
TRUNCATE TABLE `t_account`;
INSERT INTO `t_account` (`acct_id`, `account_key`, `account_name`, `password`, `account_status`, `is_active`, `create_date`, `modify_date`, `salt`, `real_name`, `store_id`, `merchant_id`, `staff_id`) VALUES (1, 'fuint', 'fuint', 'e10adc3949ba59abbe56e057f20f883e', 1, 1, '2022-01-01 00:00:00', '2026-05-07 00:00:00', '', '管理员', 0, 1, 0);

-- ------- t_duty (系统角色) -------
TRUNCATE TABLE `t_duty`;
INSERT INTO `t_duty` (`duty_id`, `duty_name`, `merchant_id`, `store_id`, `status`, `description`) VALUES (1, '商户管理员', 1, 0, 'A', '商户管理员拥有所有权限');

-- ------- t_account_duty -------
TRUNCATE TABLE `t_account_duty`;
INSERT INTO `t_account_duty` (`acc_duty_id`, `acct_id`, `duty_id`) VALUES (1, 1, 1);

-- ------- mt_setting (系统设置) -------
TRUNCATE TABLE `mt_setting`;
INSERT INTO `mt_setting` (`id`, `merchant_id`, `store_id`, `type`, `name`, `value`, `description`, `create_time`, `update_time`, `operator`, `status`) VALUES
(1, 1, 0, 'point', 'pointNeedConsume', '1', '消费1元获得积分', '2022-01-01 00:00:00', '2026-01-01 00:00:00', 'fuint', 'A'),
(2, 1, 0, 'point', 'rechargePointSpeed', '100', '多少积分抵扣1元', '2022-01-01 00:00:00', '2026-01-01 00:00:00', 'fuint', 'A');

SET FOREIGN_KEY_CHECKS = 1;