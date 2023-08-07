/*
MySQL Database Backup Tools
Server:127.0.0.1:3306
Database:node_cloud
Data:2023-08-03 11:58:34
*/
SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for is_account
-- ----------------------------
DROP TABLE IF EXISTS `is_account`;
CREATE TABLE `is_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL COMMENT '账户名称',
  `py` varchar(32) DEFAULT '' COMMENT '首拼信息',
  `number` varchar(32) NOT NULL COMMENT '账户编号',
  `initial` decimal(10,2) DEFAULT '0.00' COMMENT '期初余额',
  `balance` decimal(10,2) DEFAULT '0.00' COMMENT '资金余额',
  `createtime` int(11) NOT NULL COMMENT '开账时间',
  `data` varchar(128) DEFAULT '' COMMENT '备注信息',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `number` (`number`),
  KEY `name_py` (`name`,`py`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资金账户';
-- ----------------------------
-- Records of is_account
-- ----------------------------

-- ----------------------------
-- Table structure for is_accountinfo
-- ----------------------------
DROP TABLE IF EXISTS `is_accountinfo`;
CREATE TABLE `is_accountinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '所属ID',
  `set` tinyint(1) NOT NULL COMMENT '行为状态[0:资金减少|1:资金增加]',
  `money` decimal(10,2) DEFAULT '0.00' COMMENT '操作金额',
  `type` int(11) NOT NULL COMMENT '单据类型[1:购货核销单|2:销货核销单|3:购货退货核销单|4:销货退货核销单|5:收款单|6:付款单|7:其他收入单|8:其他支出单|9:零售单收款|10:零售退货单|11:采购入库核销单|12:服务核销单|13:资金调拨单-出|14:资金调拨单-入]',
  `time` int(11) NOT NULL COMMENT '操作时间',
  `user` int(11) NOT NULL COMMENT '制单人',
  `class` int(11) NOT NULL COMMENT '类ID',
  `bill` int(11) DEFAULT NULL COMMENT '账单ID',
  `data` varchar(128) DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`id`),
  KEY `pid_type_user_class` (`pid`,`type`,`user`,`class`),
  KEY `pid_type_user` (`pid`,`type`,`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资金详情表';
-- ----------------------------
-- Records of is_accountinfo
-- ----------------------------

-- ----------------------------
-- Table structure for is_action
-- ----------------------------
DROP TABLE IF EXISTS `is_action`;
CREATE TABLE `is_action` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '所属行为',
  `name` varchar(36) NOT NULL COMMENT '行为名称',
  `value` varchar(36) NOT NULL COMMENT '行为内容',
  `state` tinyint(1) DEFAULT '1' COMMENT '行为状态[0:禁用|1:正常]',
  `sort` int(11) NOT NULL COMMENT '行为排序',
  `data` varchar(256) DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`id`),
  KEY `pid_name_value_state` (`pid`,`name`,`value`,`state`),
  KEY `name_value_state` (`name`,`value`,`state`),
  KEY `state` (`state`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='行为信息';
-- ----------------------------
-- Records of is_action
-- ----------------------------
INSERT INTO `is_action` (`id`,`pid`,`name`,`value`,`state`,`sort`,`data`) VALUES ('1','0','静态文件扩展','pagemore','1','0','传入：[\"配置类型\",\"配置标识|为空自动判断\"]');
INSERT INTO `is_action` (`id`,`pid`,`name`,`value`,`state`,`sort`,`data`) VALUES ('2','1','静态文件扩展','addons\\pagemore\\controller\\main','1','0','静态文件扩展-创建插件[pagemore]');

-- ----------------------------
-- Table structure for is_allocationclass
-- ----------------------------
DROP TABLE IF EXISTS `is_allocationclass`;
CREATE TABLE `is_allocationclass` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `merchant` int(11) NOT NULL COMMENT '所属商户',
  `time` int(11) NOT NULL COMMENT '单据时间',
  `number` varchar(32) NOT NULL COMMENT '单据编号',
  `user` int(11) NOT NULL COMMENT '制单人',
  `file` varchar(128) DEFAULT '' COMMENT '单据附件',
  `data` varchar(128) DEFAULT '' COMMENT '备注信息',
  `type` tinyint(1) NOT NULL COMMENT '审核状态[0:未审核|1:已审核]',
  `auditinguser` int(11) NOT NULL COMMENT '审核人',
  `auditingtime` int(11) NOT NULL COMMENT '审核时间',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `merchant_user_type` (`merchant`,`user`,`type`),
  KEY `time_number` (`time`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='调拨单';
-- ----------------------------
-- Records of is_allocationclass
-- ----------------------------

-- ----------------------------
-- Table structure for is_allocationinfo
-- ----------------------------
DROP TABLE IF EXISTS `is_allocationinfo`;
CREATE TABLE `is_allocationinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '所属ID',
  `room` int(11) NOT NULL COMMENT '仓储ID',
  `goods` int(11) NOT NULL COMMENT '商品ID(搜索用)',
  `warehouse` int(11) NOT NULL COMMENT '仓库ID(搜索用)',
  `serial` text COMMENT '串号',
  `nums` decimal(10,2) NOT NULL COMMENT '数量',
  `towarehouse` int(11) NOT NULL COMMENT '调拨仓库',
  `toroom` int(11) NOT NULL COMMENT '调拨仓储ID',
  `data` varchar(128) DEFAULT '' COMMENT '备注',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `pid_warehouse_towarehouse` (`pid`,`warehouse`,`towarehouse`),
  KEY `goods_room_toroom` (`goods`,`room`,`toroom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='调拨详情表';
-- ----------------------------
-- Records of is_allocationinfo
-- ----------------------------

-- ----------------------------
-- Table structure for is_attr
-- ----------------------------
DROP TABLE IF EXISTS `is_attr`;
CREATE TABLE `is_attr` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '所属商品',
  `nod` varchar(32) NOT NULL COMMENT '属性组合',
  `name` varchar(64) NOT NULL COMMENT '属性名称',
  `buy` decimal(10,2) NOT NULL COMMENT '购货价格',
  `sell` decimal(10,2) NOT NULL COMMENT '销货价格',
  `retail` decimal(10,2) NOT NULL COMMENT '零售价格',
  `code` varchar(32) DEFAULT '' COMMENT '条形码',
  `enable` tinyint(1) NOT NULL COMMENT '是否启用[0:否|1:是]',
  PRIMARY KEY (`id`),
  KEY `pid_ape_enable` (`pid`,`nod`,`enable`) USING BTREE,
  KEY `nod_enable` (`nod`,`enable`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品辅助属性表';
-- ----------------------------
-- Records of is_attr
-- ----------------------------

-- ----------------------------
-- Table structure for is_attribute
-- ----------------------------
DROP TABLE IF EXISTS `is_attribute`;
CREATE TABLE `is_attribute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '属性类型[0:主属性|1:扩展属性]',
  `name` varchar(32) NOT NULL COMMENT '属性名称',
  `data` varchar(128) DEFAULT '' COMMENT '属性备注',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `pid_name` (`pid`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='辅助属性';
-- ----------------------------
-- Records of is_attribute
-- ----------------------------

-- ----------------------------
-- Table structure for is_auth
-- ----------------------------
DROP TABLE IF EXISTS `is_auth`;
CREATE TABLE `is_auth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '所属用户',
  `name` varchar(32) NOT NULL COMMENT '设置名称',
  `info` text NOT NULL COMMENT '设置内容',
  PRIMARY KEY (`id`),
  KEY `pid_name` (`pid`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据授权';
-- ----------------------------
-- Records of is_auth
-- ----------------------------

-- ----------------------------
-- Table structure for is_brand
-- ----------------------------
DROP TABLE IF EXISTS `is_brand`;
CREATE TABLE `is_brand` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL COMMENT '品牌名称',
  `py` varchar(32) DEFAULT '' COMMENT '拼音信息',
  `number` varchar(32) DEFAULT '' COMMENT '品牌编号',
  `data` varchar(128) DEFAULT '' COMMENT '备注信息',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `name_py_number` (`name`,`py`,`number`),
  KEY `number` (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='品牌信息表';
-- ----------------------------
-- Records of is_brand
-- ----------------------------

-- ----------------------------
-- Table structure for is_cashierclass
-- ----------------------------
DROP TABLE IF EXISTS `is_cashierclass`;
CREATE TABLE `is_cashierclass` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `merchant` int(11) NOT NULL COMMENT '所属商户',
  `customer` int(11) NOT NULL COMMENT '客户ID',
  `time` int(11) NOT NULL COMMENT '单据时间',
  `number` varchar(32) NOT NULL COMMENT '单据编号',
  `total` decimal(10,2) NOT NULL COMMENT '单据金额',
  `actual` decimal(10,2) NOT NULL COMMENT '实际金额',
  `money` decimal(10,2) NOT NULL COMMENT '实收金额',
  `integral` decimal(10,2) NOT NULL COMMENT '赠送积分',
  `user` int(11) NOT NULL COMMENT '制单人',
  `account` int(11) NOT NULL COMMENT '结算账户',
  `paytype` tinyint(1) NOT NULL COMMENT '付款方式[0:单独付款|1:组合付款]',
  `payinfo` text NOT NULL COMMENT '组合支付',
  `data` varchar(128) DEFAULT '' COMMENT '备注信息',
  `type` tinyint(1) NOT NULL COMMENT '审核状态[0:未审核|1:已审核]',
  `auditinguser` int(11) NOT NULL COMMENT '审核人',
  `auditingtime` int(11) NOT NULL COMMENT '审核时间',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `merchant_customer_user_type` (`merchant`,`customer`,`user`,`type`),
  KEY `time_number` (`time`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='零售单';
-- ----------------------------
-- Records of is_cashierclass
-- ----------------------------

-- ----------------------------
-- Table structure for is_cashierinfo
-- ----------------------------
DROP TABLE IF EXISTS `is_cashierinfo`;
CREATE TABLE `is_cashierinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '所属ID',
  `room` int(11) NOT NULL COMMENT '仓储ID',
  `goods` int(11) NOT NULL COMMENT '商品ID(搜索用)',
  `warehouse` int(11) NOT NULL COMMENT '仓库ID(搜索用)',
  `serial` text COMMENT '串号',
  `nums` decimal(10,2) NOT NULL COMMENT '数量',
  `price` decimal(10,2) NOT NULL COMMENT '单价',
  `discount` decimal(10,2) NOT NULL COMMENT '折扣',
  `total` decimal(10,2) NOT NULL COMMENT '总价',
  `data` varchar(128) DEFAULT '' COMMENT '备注',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `warehouse` (`warehouse`) USING BTREE,
  KEY `pid_goods_warehouse_room` (`pid`,`goods`,`warehouse`,`room`) USING BTREE,
  KEY `goods` (`goods`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='零售详情表';
-- ----------------------------
-- Records of is_cashierinfo
-- ----------------------------

-- ----------------------------
-- Table structure for is_code
-- ----------------------------
DROP TABLE IF EXISTS `is_code`;
CREATE TABLE `is_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL COMMENT '条码名称',
  `py` varchar(32) NOT NULL COMMENT '拼音信息',
  `code` varchar(128) NOT NULL COMMENT '条码内容',
  `type` tinyint(1) NOT NULL COMMENT '条码类型0:条形码 | 1:二维码',
  `data` varchar(128) DEFAULT '' COMMENT '备注信息',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `name_py_code_type` (`name`,`py`,`code`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='条码表';
-- ----------------------------
-- Records of is_code
-- ----------------------------

-- ----------------------------
-- Table structure for is_customer
-- ----------------------------
DROP TABLE IF EXISTS `is_customer`;
CREATE TABLE `is_customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL COMMENT '客户名称',
  `py` varchar(32) DEFAULT '' COMMENT '首拼信息',
  `number` varchar(32) DEFAULT '' COMMENT '客户编号',
  `contacts` varchar(32) DEFAULT '' COMMENT '联系人员',
  `tel` varchar(32) DEFAULT '' COMMENT '联系电话',
  `add` varchar(64) DEFAULT '' COMMENT '客户地址',
  `birthday` int(11) DEFAULT NULL COMMENT '客户生日',
  `integral` decimal(10,2) DEFAULT '0.00' COMMENT '客户积分',
  `bank` varchar(64) DEFAULT '' COMMENT '开户银行',
  `account` varchar(64) DEFAULT '' COMMENT '银行账号',
  `tax` varchar(64) DEFAULT '' COMMENT '客户税号',
  `other` varchar(64) DEFAULT '' COMMENT '社交账号',
  `email` varchar(64) DEFAULT '' COMMENT '邮箱地址',
  `data` varchar(128) DEFAULT '' COMMENT '备注信息',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `name_py_number` (`name`,`py`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户表';
-- ----------------------------
-- Records of is_customer
-- ----------------------------

-- ----------------------------
-- Table structure for is_eftclass
-- ----------------------------
DROP TABLE IF EXISTS `is_eftclass`;
CREATE TABLE `is_eftclass` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `merchant` int(11) NOT NULL COMMENT '所属商户',
  `time` int(11) NOT NULL COMMENT '单据时间',
  `number` varchar(32) NOT NULL COMMENT '单据编号',
  `user` int(11) NOT NULL COMMENT '制单人',
  `file` varchar(128) DEFAULT '' COMMENT '单据附件',
  `data` varchar(128) DEFAULT '' COMMENT '备注信息',
  `type` tinyint(1) NOT NULL COMMENT '审核状态[0:未审核|1:已审核]',
  `auditinguser` int(11) NOT NULL COMMENT '审核人',
  `auditingtime` int(11) NOT NULL COMMENT '审核时间',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `merchant_user_type` (`merchant`,`user`,`type`),
  KEY `time_number` (`time`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资金调拨单';
-- ----------------------------
-- Records of is_eftclass
-- ----------------------------

-- ----------------------------
-- Table structure for is_eftinfo
-- ----------------------------
DROP TABLE IF EXISTS `is_eftinfo`;
CREATE TABLE `is_eftinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '所属ID',
  `account` int(11) NOT NULL COMMENT '调出账户ID',
  `toaccount` int(11) NOT NULL COMMENT '调入账户ID',
  `total` decimal(10,2) NOT NULL COMMENT '金额',
  `data` varchar(128) DEFAULT '' COMMENT '备注',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `pid_account_id_toaccount_id` (`pid`,`account`,`toaccount`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资金调拨详情表';
-- ----------------------------
-- Records of is_eftinfo
-- ----------------------------

-- ----------------------------
-- Table structure for is_exchangeclass
-- ----------------------------
DROP TABLE IF EXISTS `is_exchangeclass`;
CREATE TABLE `is_exchangeclass` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `merchant` int(11) NOT NULL COMMENT '所属商户',
  `customer` int(11) NOT NULL COMMENT '客户ID',
  `time` int(11) NOT NULL COMMENT '单据时间',
  `number` varchar(32) NOT NULL COMMENT '单据编号',
  `total` decimal(10,2) NOT NULL COMMENT '单据积分',
  `actual` decimal(10,2) NOT NULL COMMENT '实际积分',
  `integral` decimal(10,2) NOT NULL COMMENT '实付积分',
  `user` int(11) NOT NULL COMMENT '制单人',
  `file` varchar(128) DEFAULT '' COMMENT '单据附件',
  `data` varchar(128) DEFAULT '' COMMENT '备注信息',
  `type` tinyint(1) NOT NULL COMMENT '审核状态[0:未审核|1:已审核]',
  `auditinguser` int(11) NOT NULL COMMENT '审核人',
  `auditingtime` int(11) NOT NULL COMMENT '审核时间',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `merchant_customer_user_type` (`merchant`,`customer`,`user`,`type`),
  KEY `time_number` (`time`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='积分兑换单';
-- ----------------------------
-- Records of is_exchangeclass
-- ----------------------------

-- ----------------------------
-- Table structure for is_exchangeinfo
-- ----------------------------
DROP TABLE IF EXISTS `is_exchangeinfo`;
CREATE TABLE `is_exchangeinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '所属ID',
  `room` int(11) NOT NULL COMMENT '仓储ID',
  `goods` int(11) NOT NULL COMMENT '商品ID(搜索用)',
  `warehouse` int(11) NOT NULL COMMENT '仓库ID(搜索用)',
  `serial` text COMMENT '串号',
  `nums` decimal(10,2) NOT NULL COMMENT '数量',
  `integral` decimal(10,2) NOT NULL COMMENT '兑换积分',
  `allintegral` decimal(10,2) NOT NULL COMMENT '总积分',
  `data` varchar(128) DEFAULT '' COMMENT '备注',
  `more` int(11) DEFAULT NULL COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `pid_goods_warehouse_room` (`pid`,`goods`,`warehouse`,`room`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='积分兑换详情表';
-- ----------------------------
-- Records of is_exchangeinfo
-- ----------------------------

-- ----------------------------
-- Table structure for is_formfield
-- ----------------------------
DROP TABLE IF EXISTS `is_formfield`;
CREATE TABLE `is_formfield` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(36) NOT NULL COMMENT '表单名称',
  `key` varchar(36) NOT NULL COMMENT '表单标识',
  `data` varchar(128) DEFAULT '' COMMENT '表单备注',
  PRIMARY KEY (`id`),
  KEY `name_key` (`name`,`key`)
) ENGINE=InnoDB AUTO_INCREMENT=162 DEFAULT CHARSET=utf8 COMMENT='表单字段';
-- ----------------------------
-- Records of is_formfield
-- ----------------------------
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('1','商户管理','merchant_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('3','商户管理','merchant_export','导出');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('4','客户管理','customer_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('5','客户管理','customer_export','导出');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('6','积分管理','integral_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('7','积分管理','integral_export','导出');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('8','供应商管理','supplier_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('9','供应商管理','supplier_export','导出');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('10','仓库管理','warehouse_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('11','仓库管理','warehouse_export','导出');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('12','资金账户管理','account_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('13','资金账户管理','account_export','导出');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('15','资金账户明细管理','accountinfo_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('16','资金账户明细管理','accountinfo_export','导出');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('17','服务项目管理','serve_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('18','服务项目管理','serve_export','导出');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('19','计量单位管理','unit_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('20','品牌管理','brand_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('21','条码管理','code_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('22','条码管理','code_export','导出');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('23','辅助属性管理','attribute_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('24','职员管理','user_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('25','数据备份','backup_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('26','权限管理','root_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('27','数据授权','auth_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('28','操作日志','log_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('29','商品管理','goods_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('30','商品管理','goods_export','导出');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('31','购货单','purchase_main','单据');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('32','基础商品信息','base_goods','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('33','购货单','purchase_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('34','购货单','purchase_export','导出-简易');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('35','购货单','purchase_exports','导出-详细');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('36','购货单','purchase_print','打印');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('37','购货核销单','purchasebill_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('38','购货核销单','purchasebill_export','导出');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('39','购货退货单','repurchase_main','单据');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('40','仓储商品信息','room_goods','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('41','购货退货单','repurchase_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('42','购货退货单','repurchase_export','导出-简易');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('43','购货退货单','repurchase_exports','导出-详细');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('44','购货退货单','repurchase_print','打印');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('45','购货退货核销单','repurchasebill_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('46','购货退货核销单','repurchasebill_export','导出');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('47','采购订单','opurchase_main','单据');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('48','采购订单','opurchase_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('49','采购订单','opurchase_export','导出-简易');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('50','采购订单','opurchase_exports','导出-详细');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('51','采购订单','opurchase_print','打印');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('52','采购入库详情单','orpurchase_form','报表-操作');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('53','采购入库详情单','orpurchase_main','单据-操作');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('54','采购入库详情单','orpurchase_export','导出-简易');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('55','采购入库详情单','orpurchase_exports','导出-详细');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('56','采购入库详情单','orpurchase_print','打印');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('57','采购入库单','rpurchase_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('58','采购入库单','rpurchase_main','单据');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('59','采购入库单','rpurchase_export','导出-简易');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('60','采购入库单','rpurchase_exports','导出-详细');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('61','采购入库单','rpurchase_print','打印');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('62','采购入库核销单','rpurchasebill_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('63','采购入库核销单','rpurchasebill_export','导出');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('64','销货单','sale_main','单据');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('65','销货单','sale_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('66','销货单','sale_export','导出-简易');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('67','销货单','sale_exports','导出-详细');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('68','销货单','sale_print','打印');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('69','销货核销单','salebill_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('70','销货核销单','salebill_export','导出');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('71','销货退货单','resale_main','单据');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('72','销货退货单','resale_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('73','销货退货单','resale_export','导出-简易');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('74','销货退货单','resale_exports','导出-详细');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('75','销货退货单','resale_print','打印');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('76','销货退货核销单','resalebill_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('77','销货退货核销单','resalebill_export','导出');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('78','零售单','cashier_main','单据');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('79','零售单','cashier_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('80','零售单','cashier_info','单据');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('81','零售单','cashier_export','导出-简易');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('82','零售单','cashier_exports','导出-详细');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('83','零售单','cashier_print','打印');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('84','零售退货单','recashier_main','单据');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('85','零售退货单','recashier_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('86','零售退货单','recashier_export','导出-简易');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('87','零售退货单','recashier_exports','导出-详细');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('88','零售退货单','recashier_print','打印');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('89','服务单','itemorder_main','单据');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('90','服务信息','serve','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('91','服务单','itemorder_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('92','服务单','itemorder_export','导出-简易');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('93','服务单','itemorder_exports','导出-详细');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('94','服务单','itemorder_print','打印');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('95','服务核销单','itemorderbill_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('96','服务核销单','itemorderbill_export','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('97','积分兑换单','exchange_main','单据');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('98','积分兑换单','exchange_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('99','积分兑换单','exchange_export','导出-简易');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('100','积分兑换单','exchange_exports','导出-详细');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('101','积分兑换单','exchange_print','打印');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('103','调拨单','allocation_main','单据');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('104','调拨单','allocation_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('105','调拨单','allocation_export','导出-简易');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('106','调拨单','allocation_exports','导出-详细');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('107','调拨单','allocation_print','打印');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('108','其他入库单','otpurchase_main','单据');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('109','其他入库单','otpurchase_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('110','其他入库单','otpurchase_export','导出-简易');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('111','其他入库单','otpurchase_exports','导出-详细');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('112','其他入库单','otpurchase_print','打印');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('113','其他出库单','otsale_main','单据');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('114','其他出库单','otsale_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('115','其他出库单','otsale_export','导出-简易');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('116','其他出库单','otsale_exports','导出-详细');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('117','其他出库单','otsale_print','打印');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('118','库存查询','room_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('119','库存查询','room_export','导出');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('120','库存详情','roominfo_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('121','库存详情','roominfo_export','导出');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('122','库存预警','roomwarning_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('123','库存预警','roomwarning_export','导出');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('124','库存盘点','roomcheck_main','单据');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('125','库存盘点','roomcheck_export','导出');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('126','收款单','gather_main','单据');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('127','收款单','gather_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('128','收款单','gather_export','导出-简易');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('129','收款单','gather_exports','导出-详细');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('130','收款单','gather_print','打印');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('131','付款单','payment_main','单据');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('132','付款单','payment_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('133','付款单','payment_export','导出-简易');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('134','付款单','payment_exports','导出-详细');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('135','付款单','payment_print','打印');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('136','其他收入单','otgather_main','单据');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('137','其他收入单','otgather_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('138','其他收入单','otgather_export','导出-简易');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('139','其他收入单','otgather_exports','导出-详细');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('140','其他收入单','otgather_print','打印');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('141','其他支出单','otpayment_main','单据');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('142','其他支出单','otpayment_export','导出-简易');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('143','其他支出单','otpayment_exports','导出-详细');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('144','其他支出单','otpayment_print','打印');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('145','其他支出单','otpayment_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('146','资金调拨单','eft_main','单据');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('147','资金调拨单','eft_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('148','资金调拨单','eft_export','导出-简易');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('149','资金调拨单','eft_exports','导出-详细');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('150','资金调拨单','eft_print','打印');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('151','商品利润表','goodsprofit_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('152','商品利润表','goodsprofit_export','导出');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('153','销售利润表','billprofit_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('154','销售利润表','billprofit_export','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('155','串码跟踪表','serial_export','导出');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('156','串码跟踪表','serial_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('157','串码跟踪详情表','serialinfo_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('158','串码跟踪详情表','serialinfo_export','导出');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('160','往来单位欠款表','arrears_form','报表');
INSERT INTO `is_formfield` (`id`,`name`,`key`,`data`) VALUES ('161','往来单位欠款表','arrears_export','导出');

-- ----------------------------
-- Table structure for is_formfieldinfo
-- ----------------------------
DROP TABLE IF EXISTS `is_formfieldinfo`;
CREATE TABLE `is_formfieldinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '所属ID',
  `info` text NOT NULL COMMENT '字段内容',
  `show` tinyint(1) NOT NULL COMMENT '显示字段[0:隐藏|1:显示]',
  PRIMARY KEY (`id`),
  KEY `pid_info_show` (`pid`,`show`)
) ENGINE=InnoDB AUTO_INCREMENT=8621 DEFAULT CHARSET=utf8 COMMENT='字段设置详情';
-- ----------------------------
-- Records of is_formfieldinfo
-- ----------------------------
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('12','3','key//name||text//商户名称||data//name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('13','3','key//number||text//商户编号||data//number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('14','3','key//contacts||text//联系人员||data//contacts','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('15','3','key//tel||text//联系电话||data//tel','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('16','3','key//add||text//商户地址||data//add','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('17','3','key//tax||text//商户税号||data//tax','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('18','3','key//bank||text//开户银行||data//bank','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('19','3','key//account||text//对公账户||data//account','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('20','3','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('21','4','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('22','4','{field: \'name\', title: \'客户名称\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('23','4','{field: \'number\', title: \'客户编号\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('24','4','{field: \'contacts\', title: \'联系人员\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('25','4','{field: \'tel\', title: \'联系电话\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('26','4','{field: \'add\', title: \'客户地址\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('27','4','{field: \'birthday\', title: \'客户生日\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('28','4','{field: \'bank\', title: \'开户银行\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('29','4','{field: \'account\', title: \'银行账户\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('30','4','{field: \'tax\', title: \'客户税号\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('31','4','{field: \'other\', title: \'社交账号\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('32','4','{field: \'email\', title: \'邮箱地址\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('33','4','{field: \'integral\', title: \'客户积分\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('34','4','{field: \'data\', title: \'备注信息\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('35','4','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('36','5','key//name||text//客户名称||data//name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('37','5','key//number||text//客户编号||data//number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('38','5','key//contacts||text//联系人员||data//contacts','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('39','5','key//tel||text//联系电话||data//tel','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('40','5','key//add||text//客户地址||data//add','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('41','5','key//birthday||text//客户生日||data//birthday','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('42','5','key//bank||text//开户银行||data//bank','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('43','5','key//account||text//银行账户||data//account','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('44','5','key//tax||text//客户税号||data//tax','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('45','5','key//other||text//社交账号||data//other','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('46','5','key//email||text//邮箱地址||data//email','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('47','5','key//integral||text//客户积分||data//integral','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('48','5','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('56','7','key//time||text//操作时间||data//time','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('57','7','key//type||text//单据类型||data//type|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('58','7','key//number||text//单据编号||data//typedata|number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('59','7','key//set||text//积分操作||data//set|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('60','7','key//integral||text//本次积分||data//integral','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('61','7','key//integral||text//本次积分||data//userinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('62','7','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('63','8','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('64','8','{field: \'name\', title: \'供应商名称\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('65','8','{field: \'number\', title: \'供应商编号\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('66','8','{field: \'contacts\', title: \'联系人员\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('67','8','{field: \'tel\', title: \'联系电话\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('68','8','{field: \'add\', title: \'供应商地址\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('69','8','{field: \'bank\', title: \'开户银行\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('70','8','{field: \'account\', title: \'银行账户\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('71','8','{field: \'tax\', title: \'供应商税号\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('72','8','{field: \'other\', title: \'社交账号\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('73','8','{field: \'email\', title: \'邮箱地址\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('74','8','{field: \'data\', title: \'备注信息\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('75','8','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('76','9','key//name||text//供应商名称||data//name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('77','9','key//number||text//供应商编号||data//number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('78','9','key//contacts||text//联系人员||data//contacts','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('79','9','key//tel||text//联系电话||data//tel','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('80','9','key//add||text//供应商地址||data//add','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('81','9','key//bank||text//开户银行||data//bank','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('82','9','key//account||text//银行账户||data//account','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('83','9','key//tax||text//供应商税号||data//tax','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('84','9','key//other||text//社交账号||data//other','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('85','9','key//email||text//邮箱地址||data//email','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('86','9','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('87','10','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('88','10','{field: \'name\', title: \'仓库名称\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('89','10','{field: \'number\', title: \'仓库编号\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('90','10','{field: \'contacts\', title: \'联系人员\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('91','10','{field: \'tel\', title: \'联系电话\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('92','10','{field: \'add\', title: \'仓库地址\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('93','10','{field: \'data\', title: \'备注信息\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('94','10','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('95','11','key//name||text//仓库名称||data//name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('96','11','key//number||text//仓库编号||data//number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('97','11','key//contacts||text//联系人员||data//contacts','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('98','11','key//tel||text//联系电话||data//tel','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('99','11','key//add||text//仓库地址||data//add','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('100','11','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('101','12','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('102','12','{field: \'name\', title: \'账户名称\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('103','12','{field: \'number\', title: \'账户编号\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('104','12','{field: \'initial\', title: \'期初余额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('105','12','{field: \'createtime\', title: \'开账时间\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('106','12','{field: \'balance\', title: \'资金余额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('107','12','{field: \'data\', title: \'备注信息\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('108','12','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('109','13','key//name||text//账户名称||data//name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('110','13','key//number||text//账户编号||data//number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('111','13','key//initial||text//期初余额||data//initial','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('112','13','key//createtime||text//开账时间||data//createtime','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('113','13','key//balance||text//资金余额||data//balance','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('114','13','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('122','16','key//time||text//操作时间||data//time','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('123','16','key//type||text//单据类型||data//type|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('124','16','key//number||text//单据编号||data//typedata|number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('125','16','key//set||text//资金操作||data//set|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('126','16','key//integral||text//资金数额||data//money','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('127','16','key//user||text//制单人||data//userinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('128','16','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('129','17','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('130','17','{field: \'name\', title: \'服务名称\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('131','17','{field: \'number\', title: \'服务编号\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('132','17','{field: \'price\', title: \'服务价格\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('133','17','{field: \'data\', title: \'备注信息\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('134','17','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('135','18','key//name||text//账户名称||data//name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('136','18','key//number||text//账户编号||data//number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('137','18','key//price||text//服务价格||data//price','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('138','18','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('139','19','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('140','19','{field: \'name\', title: \'单位名称\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('141','19','{field: \'number\', title: \'单位编号\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('142','19','{field: \'data\', title: \'备注信息\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('143','19','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('144','20','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('145','20','{field: \'name\', title: \'品牌名称\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('146','20','{field: \'number\', title: \'品牌编号\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('147','20','{field: \'data\', title: \'备注信息\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('148','20','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('149','21','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('150','21','{field: \'name\', title: \'条码名称\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('151','21','{field: \'code\', title: \'条码内容\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('152','21','{field: \'type\', title: \'条码类型\', width: 120, align:\'center\',templet: \'<div>{{d.type.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('153','21','{field: \'data\', title: \'备注信息\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('154','21','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('155','22','key//name||text//条码名称||data//name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('156','22','key//code||text//条码内容||data//code','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('157','22','key//type||text//条码类型||data//type|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('158','22','key//img||text//条码图像||data//img','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('159','22','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('160','23','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('161','23','{field: \'name\', title: \'属性名称\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('162','23','{field: \'data\', title: \'备注信息\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('163','23','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('164','24','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('165','24','{field: \'user\', title: \'职员账号\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('166','24','{field: \'name\', title: \'职员名称\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('167','24','{field: \'merchant\', title: \'所属商户\', width: 200, align:\'center\',templet: \'<div>{{d.merchantinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('168','24','{field: \'data\', title: \'备注信息\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('169','24','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('170','25','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('171','25','{field: \'time\', title: \'备份时间\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('172','25','{field: \'name\', title: \'文件名称\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('173','25','{field: \'size\', title: \'文件大小\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('174','25','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('175','26','{field: \'user\', title: \'职员账号\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('176','26','{field: \'name\', title: \'职员名称\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('177','26','{field: \'merchant\', title: \'所属商户\', width: 200, align:\'center\',templet: \'<div>{{d.merchantinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('178','26','{field: \'data\', title: \'备注信息\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('179','26','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('180','27','{field: \'user\', title: \'职员账号\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('181','27','{field: \'name\', title: \'职员名称\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('182','27','{field: \'merchant\', title: \'所属商户\', width: 200, align:\'center\',templet: \'<div>{{d.merchantinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('183','27','{field: \'data\', title: \'备注信息\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('184','27','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('188','29','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('189','29','{field: \'name\', title: \'商品名称\', width: 200, align:\'center\',fixed: true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('190','29','{field: \'number\', title: \'商品编号\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('191','29','{field: \'spec\', title: \'规格型号\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('192','29','{field: \'class\', title: \'商品分类\', width: 120, align:\'center\',templet: \'<div>{{#if(d.classinfo){}}{{d.classinfo.name}}{{#}else{}}无{{#}}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('193','29','{field: \'brand\', title: \'商品品牌\', width: 120, align:\'center\',templet: \'<div>{{#if(d.brandinfo){}}{{d.brandinfo.name}}{{#}else{}}无{{#}}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('194','29','{field: \'unit\', title: \'商品单位\', width: 120, align:\'center\',templet: \'<div>{{#if(d.unitinfo){}}{{d.unitinfo.name}}{{#}else{}}无{{#}}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('195','29','{field: \'buy\', title: \'购货价格\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('196','29','{field: \'sell\', title: \'销货价格\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('197','29','{field: \'retail\', title: \'零售价格\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('198','29','{field: \'integral\', title: \'兑换积分\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('199','29','{field: \'code\', title: \'条形码\', width: 160, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('200','29','{field: \'warehouse\', title: \'默认仓库\', width: 120, align:\'center\',templet: \'<div>{{#if(d.warehouseinfo){}}{{d.warehouseinfo.name}}{{#}else{}}无{{#}}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('201','29','{field: \'location\', title: \'商品货位\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('202','29','{field: \'stocktip\', title: \'库存阈值\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('203','29','{field: \'data\', title: \'备注信息\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('204','29','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('205','30','key//name||text//商品名称||data//name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('206','30','key//number||text//商品编号||data//number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('207','30','key//spec||text//规格型号||data//spec','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('208','30','key//class||text//商品分类||data//classinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('209','30','key//brand||text//商品品牌||data//brandinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('210','30','key//unit||text//商品单位||data//unitinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('211','30','key//buy||text//购货价格||data//buy','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('212','30','key//sell||text//销货价格||data//sell','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('213','30','key//retail||text//零售价格||data//retail','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('214','30','key//integral||text//兑换积分||data//integral','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('215','30','key//code||text//条形码||data//code','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('216','30','key//warehouse||text//默认仓库||data//warehouseinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('217','30','key//location||text//商品货位||data//location','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('218','30','key//stocktip||text//库存阈值||data//stocktip','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('219','30','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('972','15','{field: \'time\', title: \'操作时间\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('973','15','{field: \'type\', title: \'单据类型\', width: 120, align:\'center\',templet: \'<div>{{d.type.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('974','15','{field: \'number\', title: \'单据编号\', width: 200, align:\'center\',templet: \'<div>{{d.typedata.number}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('975','15','{field: \'set\', title: \'资金操作\', width: 120, align:\'center\',templet: \'<div>{{d.set.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('976','15','{field: \'money\', title: \'资金数额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('977','15','{field: \'user\', title: \'制单人\', width: 120, align:\'center\',templet: \'<div>{{d.userinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('978','15','{field: \'data\', title: \'备注信息\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('1312','32','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('1313','32','{field: \'name\', title: \'商品名称\', width: 200, align:\'center\',fixed: true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('1314','32','{field: \'img\', title: \'商品图像\', width: 150, align:\'center\',templet: \'<div><img src=\"{{d.img}}\"/></div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('1315','32','{field: \'number\', title: \'商品编号\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('1316','32','{field: \'spec\', title: \'规格型号\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('1317','32','{field: \'class\', title: \'商品分类\', width: 120, align:\'center\',templet: \'<div>{{#if(d.classinfo){}}{{d.classinfo.name}}{{#}else{}}无{{#}}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('1318','32','{field: \'brand\', title: \'商品品牌\', width: 120, align:\'center\',templet: \'<div>{{#if(d.brandinfo){}}{{d.brandinfo.name}}{{#}else{}}无{{#}}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('1319','32','{field: \'unit\', title: \'商品单位\', width: 120, align:\'center\',templet: \'<div>{{#if(d.unitinfo){}}{{d.unitinfo.name}}{{#}else{}}无{{#}}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('1320','32','{field: \'buy\', title: \'购货价格\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('1321','32','{field: \'sell\', title: \'销货价格\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('1322','32','{field: \'retail\', title: \'零售价格\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('1323','32','{field: \'integral\', title: \'兑换积分\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('1324','32','{field: \'code\', title: \'条形码\', width: 160, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('1325','32','{field: \'warehouse\', title: \'默认仓库\', width: 120, align:\'center\',templet: \'<div>{{#if(d.warehouseinfo){}}{{d.warehouseinfo.name}}{{#}else{}}无{{#}}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('1326','32','{field: \'location\', title: \'商品货位\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('1327','32','{field: \'stocktip\', title: \'库存阈值\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('1328','32','{field: \'data\', title: \'备注信息\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2312','28','{field: \'merchant\', title: \'所属商户\', width: 200, align:\'center\',templet: \'<div>{{d.merchantinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2313','28','{field: \'time\', title: \'操作时间\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2314','28','{field: \'text\', title: \'操作内容\', width: 390, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2315','28','{field: \'user\', title: \'职员\', width: 200, align:\'center\',templet: \'<div>{{d.userinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2316','33','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2317','33','{field: \'merchant\', title: \'所属商户\', width: 120, align:\'center\',templet: \'<div>{{d.merchantinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2318','33','{field: \'time\', title: \'单据日期\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2319','33','{field: \'number\', title: \'单据编号\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2320','33','{field: \'supplier\', title: \'供应商\', width: 120, align:\'center\',templet: \'<div>{{d.supplierinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2321','33','{field: \'total\', title: \'单据金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2322','33','{field: \'actual\', title: \'实际金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2323','33','{field: \'money\', title: \'实付金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2324','33','{field: \'user\', title: \'制单人\', width: 120, align:\'center\',templet: \'<div>{{d.userinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2325','33','{field: \'account\', title: \'结算账户\', width: 120, align:\'center\',templet: \'<div>{{d.accountinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2326','33','{field: \'type\', title: \'审核状态\', width: 120, align:\'center\',templet: \'<div>{{d.type.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2327','33','{field: \'billtype\', title: \'核销状态\', width: 120, align:\'center\',templet: \'<div>{{d.billtype.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2328','33','{field: \'data\', title: \'备注信息\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2329','33','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2330','37','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2331','37','{field: \'merchant\', title: \'所属商户\', width: 120, align:\'center\',templet: \'<div>{{d.merchantinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2332','37','{field: \'time\', title: \'单据日期\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2333','37','{field: \'number\', title: \'单据编号\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2334','37','{field: \'supplier\', title: \'供应商\', width: 120, align:\'center\',templet: \'<div>{{d.supplierinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2335','37','{field: \'total\', title: \'单据金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2336','37','{field: \'actual\', title: \'实际金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2337','37','{field: \'money\', title: \'实付金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2338','37','{field: \'user\', title: \'制单人\', width: 120, align:\'center\',templet: \'<div>{{d.userinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2339','37','{field: \'account\', title: \'源结算账户\', width: 120, align:\'center\',templet: \'<div>{{d.accountinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2340','37','{field: \'billtype\', title: \'核销状态\', width: 120, align:\'center\',templet: \'<div>{{d.billtype.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2341','37','{field: \'data\', title: \'备注信息\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2342','37','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2343','34','key//merchant||text//所属商户||data//merchantinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2344','34','key//time||text//单据日期||data//time','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2345','34','key//number||text//单据编号||data//number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2346','34','key//supplier||text//供应商||data//supplierinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2347','34','key//total||text//单据金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2348','34','key//actual||text//实际金额||data//actual','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2349','34','key//money||text//实付金额||data//money','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2350','34','key//user||text//制单人||data//userinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2351','34','key//account||text//结算账户||data//accountinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2352','34','key//type||text//审核状态||data//type|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2353','34','key//billtype||text//核销状态||data//billtype|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2354','34','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2355','36','key//name||text//商品名称||data//goodsinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2356','36','key//attr||text//辅助属性||data//attr|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2357','36','key//warehouse||text//所入仓库||data//warehouseinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2358','36','key//batch||text//商品批次||data//batch','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2359','36','key//serial||text//商品串码||data//serial','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2360','36','key//nums||text//数量||data//nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2361','36','key//price||text//购货单价||data//price','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2362','36','key//total||text//购货金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2363','36','key//brand||text//商品品牌||data//goodsinfo|brandinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2364','36','key//number||text//商品编号||data//goodsinfo|number','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2365','36','key//class||text//商品分类||data//goodsinfo|classinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2366','36','key//spec||text//规格型号||data//goodsinfo|spec','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2367','36','key//code||text//条形码||data//goodsinfo|code','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2368','36','key//unit||text//商品单位||data//goodsinfo|unitinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2369','36','key//stocktip||text//库存预警||data//goodsinfo|stocktip','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2370','36','key//location||text//商品货位||data//goodsinfo|location','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2371','36','key//retail_name||text//零售名称||data//goodsinfo|retail_name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2372','36','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2395','35','key//name||text//商品信息||data//goodsinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2396','35','key//attr||text//辅助属性||data//attr|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2397','35','key//warehouse||text//所入仓库||data//warehouseinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2398','35','key//batch||text//商品批次||data//batch','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2399','35','key//serial||text//商品串码||data//serial','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2400','35','key//nums||text//数量||data//nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2401','35','key//price||text//购货单价||data//price','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2402','35','key//total||text//购货金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2403','35','key//brand||text//商品品牌||data//goodsinfo|brandinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2404','35','key//number||text//商品编号||data//goodsinfo|number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2405','35','key//class||text//商品分类||data//goodsinfo|classinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2406','35','key//spec||text//规格型号||data//goodsinfo|spec','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2407','35','key//code||text//条形码||data//goodsinfo|code','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2408','35','key//unit||text//商品单位||data//goodsinfo|unitinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2409','35','key//stocktip||text//库存预警||data//goodsinfo|stocktip','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2410','35','key//location||text//商品货位||data//goodsinfo|location','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2411','35','key//retail_name||text//零售名称||data//goodsinfo|retail_name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2412','35','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2413','38','key//merchant||text//所属商户||data//merchantinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2414','38','key//time||text//单据日期||data//time','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2415','38','key//number||text//单据编号||data//number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2416','38','key//supplier||text//供应商||data//supplierinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2417','38','key//total||text//单据金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2418','38','key//actual||text//实际金额||data//actual','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2419','38','key//money||text//实付金额||data//money','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2420','38','key//user||text//制单人||data//userinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2421','38','key//account||text//源结算账户||data//accountinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2422','38','key//billtype||text//核销状态||data//billtype|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2423','38','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2448','41','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2449','41','{field: \'merchant\', title: \'所属商户\', width: 120, align:\'center\',templet: \'<div>{{d.merchantinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2450','41','{field: \'time\', title: \'单据日期\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2451','41','{field: \'number\', title: \'单据编号\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2452','41','{field: \'supplier\', title: \'供应商\', width: 120, align:\'center\',templet: \'<div>{{d.supplierinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2453','41','{field: \'total\', title: \'单据金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2454','41','{field: \'actual\', title: \'实际金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2455','41','{field: \'money\', title: \'实收金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2456','41','{field: \'user\', title: \'制单人\', width: 120, align:\'center\',templet: \'<div>{{d.userinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2457','41','{field: \'account\', title: \'结算账户\', width: 120, align:\'center\',templet: \'<div>{{d.accountinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2458','41','{field: \'type\', title: \'审核状态\', width: 120, align:\'center\',templet: \'<div>{{d.type.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2459','41','{field: \'billtype\', title: \'核销状态\', width: 120, align:\'center\',templet: \'<div>{{d.billtype.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2460','41','{field: \'data\', title: \'备注信息\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2461','41','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2462','42','key//merchant||text//所属商户||data//merchantinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2463','42','key//time||text//单据日期||data//time','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2464','42','key//number||text//单据编号||data//number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2465','42','key//supplier||text//供应商||data//supplierinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2466','42','key//total||text//单据金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2467','42','key//actual||text//实际金额||data//actual','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2468','42','key//money||text//实收金额||data//money','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2469','42','key//user||text//制单人||data//userinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2470','42','key//account||text//结算账户||data//accountinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2471','42','key//type||text//审核状态||data//type|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2472','42','key//billtype||text//核销状态||data//billtype|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2473','42','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2493','43','key//name||text//商品信息||data//goodsinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2494','43','key//attr||text//辅助属性||data//roominfo|attr|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2495','43','key//warehouse||text//所属仓库||data//warehouseinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2496','43','key//stock||text//当前库存||data//roominfo|nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2497','43','key//serial||text//商品串码||data//serial','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2498','43','key//nums||text//数量||data//nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2499','43','key//price||text//退货单价||data//price','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2500','43','key//total||text//退货金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2501','43','key//batch||text//商品批次||data//roominfo|batch','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2502','43','key//brand||text//商品品牌||data//goodsinfo|brandinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2503','43','key//number||text//商品编号||data//goodsinfo|number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2504','43','key//class||text//商品分类||data//goodsinfo|classinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2505','43','key//spec||text//规格型号||data//goodsinfo|spec','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2506','43','key//code||text//条形码||data//goodsinfo|code','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2507','43','key//unit||text//商品单位||data//goodsinfo|unitinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2508','43','key//stocktip||text//库存预警||data//goodsinfo|stocktip','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2509','43','key//location||text//商品货位||data//goodsinfo|location','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2510','43','key//retail_name||text//零售名称||data//goodsinfo|retail_name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2511','43','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2512','44','key//name||text//商品信息||data//goodsinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2513','44','key//attr||text//辅助属性||data//roominfo|attr|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2514','44','key//warehouse||text//所属仓库||data//warehouseinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2515','44','key//stock||text//当前库存||data//roominfo|nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2516','44','key//serial||text//商品串码||data//serial','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2517','44','key//nums||text//数量||data//nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2518','44','key//price||text//退货单价||data//price','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2519','44','key//total||text//退货金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2520','44','key//batch||text//商品批次||data//roominfo|batch','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2521','44','key//brand||text//商品品牌||data//goodsinfo|brandinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2522','44','key//number||text//商品编号||data//goodsinfo|number','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2523','44','key//class||text//商品分类||data//goodsinfo|classinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2524','44','key//spec||text//规格型号||data//goodsinfo|spec','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2525','44','key//code||text//条形码||data//goodsinfo|code','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2526','44','key//unit||text//商品单位||data//goodsinfo|unitinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2527','44','key//stocktip||text//库存预警||data//goodsinfo|stocktip','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2528','44','key//location||text//商品货位||data//goodsinfo|location','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2529','44','key//retail_name||text//零售名称||data//goodsinfo|retail_name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2530','44','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2531','45','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2532','45','{field: \'merchant\', title: \'所属商户\', width: 120, align:\'center\',templet: \'<div>{{d.merchantinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2533','45','{field: \'time\', title: \'单据日期\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2534','45','{field: \'number\', title: \'单据编号\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2535','45','{field: \'supplier\', title: \'供应商\', width: 120, align:\'center\',templet: \'<div>{{d.supplierinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2536','45','{field: \'total\', title: \'单据金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2537','45','{field: \'actual\', title: \'实际金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2538','45','{field: \'money\', title: \'实收金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2539','45','{field: \'user\', title: \'制单人\', width: 120, align:\'center\',templet: \'<div>{{d.userinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2540','45','{field: \'account\', title: \'源结算账户\', width: 120, align:\'center\',templet: \'<div>{{d.accountinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2541','45','{field: \'billtype\', title: \'核销状态\', width: 120, align:\'center\',templet: \'<div>{{d.billtype.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2542','45','{field: \'data\', title: \'备注信息\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2543','45','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2544','46','key//merchant||text//所属商户||data//merchantinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2545','46','key//time||text//单据日期||data//time','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2546','46','key//number||text//单据编号||data//number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2547','46','key//supplier||text//供应商||data//supplierinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2548','46','key//total||text//单据金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2549','46','key//actual||text//实际金额||data//actual','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2550','46','key//money||text//实收金额||data//money','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2551','46','key//user||text//制单人||data//userinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2552','46','key//account||text//源结算账户||data//accountinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2553','46','key//billtype||text//核销状态||data//billtype|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2554','46','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2619','48','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2620','48','{field: \'merchant\', title: \'所属商户\', width: 120, align:\'center\',templet: \'<div>{{d.merchantinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2621','48','{field: \'time\', title: \'单据日期\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2622','48','{field: \'number\', title: \'单据编号\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2623','48','{field: \'user\', title: \'制单人\', width: 120, align:\'center\',templet: \'<div>{{d.userinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2624','48','{field: \'type\', title: \'审核状态\', width: 120, align:\'center\',templet: \'<div>{{d.type.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2625','48','{field: \'data\', title: \'备注信息\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2626','48','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2643','49','key//merchant||text//所属商户||data//merchantinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2644','49','key//time||text//单据日期||data//time','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2645','49','key//number||text//单据编号||data//number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2646','49','key//user||text//制单人||data//userinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2647','49','key//type||text//审核状态||data//type|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2648','49','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2726','51','key//name||text//商品名称||data//goodsinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2727','51','key//attr||text//辅助属性||data//attr|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2728','51','key//nums||text//数量||data//nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2729','51','key//brand||text//商品品牌||data//goodsinfo|brandinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2730','51','key//number||text//商品编号||data//goodsinfo|number','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2731','51','key//class||text//商品分类||data//goodsinfo|classinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2732','51','key//spec||text//规格型号||data//goodsinfo|spec','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2733','51','key//code||text//条形码||data//goodsinfo|code','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2734','51','key//unit||text//商品单位||data//goodsinfo|unitinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2735','51','key//stocktip||text//库存预警||data//goodsinfo|stocktip','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2736','51','key//location||text//商品货位||data//goodsinfo|location','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2737','51','key//retail_name||text//零售名称||data//goodsinfo|retail_name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2738','51','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2936','54','key//merchant||text//所属商户||data//merchantinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2937','54','key//time||text//单据日期||data//time','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2938','54','key//number||text//单据编号||data//number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2939','54','key//user||text//制单人||data//userinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2940','54','key//storage||text//入库状态||data//storage|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2941','54','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2943','52','{field: \'merchant\', title: \'所属商户\', width: 120, align:\'center\',templet: \'<div>{{d.merchantinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2944','52','{field: \'time\', title: \'单据日期\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2945','52','{field: \'number\', title: \'单据编号\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2946','52','{field: \'user\', title: \'制单人\', width: 120, align:\'center\',templet: \'<div>{{d.userinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2947','52','{field: \'storage\', title: \'入库状态\', width: 120, align:\'center\',templet: \'<div>{{d.storage.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2948','52','{field: \'data\', title: \'备注信息\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('2949','52','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3035','50','key//name||text//商品信息||data//goodsinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3036','50','key//attr||text//辅助属性||data//attr|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3037','50','key//nums||text//数量||data//nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3038','50','key//brand||text//商品品牌||data//goodsinfo|brandinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3039','50','key//number||text//商品编号||data//goodsinfo|number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3040','50','key//class||text//商品分类||data//goodsinfo|classinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3041','50','key//spec||text//规格型号||data//goodsinfo|spec','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3042','50','key//code||text//条形码||data//goodsinfo|code','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3043','50','key//unit||text//商品单位||data//goodsinfo|unitinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3044','50','key//stocktip||text//库存预警||data//goodsinfo|stocktip','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3045','50','key//location||text//商品货位||data//goodsinfo|location','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3046','50','key//retail_name||text//零售名称||data//goodsinfo|retail_name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3047','50','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3048','55','key//name||text//商品信息||data//goodsinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3049','55','key//attr||text//辅助属性||data//attr|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3050','55','key//nums||text//总数量||data//nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3051','55','key//readynums||text//已入库数量||data//readynums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3052','55','key//surplusnums||text//剩余数量||data//surplusnums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3053','55','key//brand||text//商品品牌||data//goodsinfo|brandinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3054','55','key//number||text//商品编号||data//goodsinfo|number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3055','55','key//class||text//商品分类||data//goodsinfo|classinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3056','55','key//spec||text//规格型号||data//goodsinfo|spec','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3057','55','key//code||text//条形码||data//goodsinfo|code','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3058','55','key//unit||text//商品单位||data//goodsinfo|unitinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3059','55','key//stocktip||text//库存预警||data//goodsinfo|stocktip','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3060','55','key//location||text//商品货位||data//goodsinfo|location','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3061','55','key//retail_name||text//零售名称||data//goodsinfo|retail_name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3062','55','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3095','56','key//name||text//商品名称||data//goodsinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3096','56','key//attr||text//辅助属性||data//attr|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3097','56','key//nums||text//总数量||data//nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3098','56','key//readynums||text//已入库数量||data//readynums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3099','56','key//surplusnums||text//剩余数量||data//surplusnums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3100','56','key//brand||text//商品品牌||data//goodsinfo|brandinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3101','56','key//number||text//商品编号||data//goodsinfo|number','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3102','56','key//class||text//商品分类||data//goodsinfo|classinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3103','56','key//spec||text//规格型号||data//goodsinfo|spec','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3104','56','key//code||text//条形码||data//goodsinfo|code','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3105','56','key//unit||text//商品单位||data//goodsinfo|unitinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3106','56','key//stocktip||text//库存预警||data//goodsinfo|stocktip','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3107','56','key//location||text//商品货位||data//goodsinfo|location','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3108','56','key//retail_name||text//零售名称||data//goodsinfo|retail_name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3109','56','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3156','57','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3157','57','{field: \'merchant\', title: \'所属商户\', width: 120, align:\'center\',templet: \'<div>{{d.merchantinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3158','57','{field: \'time\', title: \'单据日期\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3159','57','{field: \'onumber\', title: \'订单编号\', width: 200, align:\'center\',templet: \'<div>{{d.oidinfo.number}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3160','57','{field: \'number\', title: \'单据编号\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3161','57','{field: \'supplier\', title: \'供应商\', width: 120, align:\'center\',templet: \'<div>{{d.supplierinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3162','57','{field: \'total\', title: \'单据金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3163','57','{field: \'actual\', title: \'实际金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3164','57','{field: \'money\', title: \'实付金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3165','57','{field: \'user\', title: \'制单人\', width: 120, align:\'center\',templet: \'<div>{{d.userinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3166','57','{field: \'account\', title: \'结算账户\', width: 120, align:\'center\',templet: \'<div>{{d.accountinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3167','57','{field: \'type\', title: \'审核状态\', width: 120, align:\'center\',templet: \'<div>{{d.type.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3168','57','{field: \'billtype\', title: \'核销状态\', width: 120, align:\'center\',templet: \'<div>{{d.billtype.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3169','57','{field: \'data\', title: \'备注信息\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3170','57','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3274','59','key//merchant||text//所属商户||data//merchantinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3275','59','key//time||text//单据日期||data//time','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3276','59','key//onumber||text//订单编号||data//oidinfo|number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3277','59','key//number||text//单据编号||data//number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3278','59','key//supplier||text//供应商||data//supplierinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3279','59','key//total||text//单据金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3280','59','key//actual||text//实际金额||data//actual','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3281','59','key//money||text//实付金额||data//money','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3282','59','key//user||text//制单人||data//userinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3283','59','key//account||text//结算账户||data//accountinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3284','59','key//type||text//审核状态||data//type|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3285','59','key//billtype||text//核销状态||data//billtype|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3286','59','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3351','61','key//name||text//商品名称||data//goodsinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3352','61','key//attr||text//辅助属性||data//attr|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3353','61','key//warehouse||text//所入仓库||data//warehouseinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3354','61','key//batch||text//商品批次||data//batch','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3355','61','key//serial||text//商品串码||data//serial','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3356','61','key//nums||text//数量||data//nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3357','61','key//price||text//采购单价||data//price','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3358','61','key//total||text//采购金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3359','61','key//brand||text//商品品牌||data//goodsinfo|brandinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3360','61','key//number||text//商品编号||data//goodsinfo|number','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3361','61','key//class||text//商品分类||data//goodsinfo|classinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3362','61','key//spec||text//规格型号||data//goodsinfo|spec','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3363','61','key//code||text//条形码||data//goodsinfo|code','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3364','61','key//unit||text//商品单位||data//goodsinfo|unitinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3365','61','key//stocktip||text//库存预警||data//goodsinfo|stocktip','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3366','61','key//location||text//商品货位||data//goodsinfo|location','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3367','61','key//retail_name||text//零售名称||data//goodsinfo|retail_name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3368','61','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3369','60','key//name||text//商品信息||data//goodsinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3370','60','key//attr||text//辅助属性||data//attr|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3371','60','key//warehouse||text//所入仓库||data//warehouseinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3372','60','key//batch||text//商品批次||data//batch','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3373','60','key//serial||text//商品串码||data//serial','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3374','60','key//nums||text//数量||data//nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3375','60','key//price||text//采购单价||data//price','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3376','60','key//total||text//采购金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3377','60','key//brand||text//商品品牌||data//goodsinfo|brandinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3378','60','key//number||text//商品编号||data//goodsinfo|number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3379','60','key//class||text//商品分类||data//goodsinfo|classinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3380','60','key//spec||text//规格型号||data//goodsinfo|spec','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3381','60','key//code||text//条形码||data//goodsinfo|code','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3382','60','key//unit||text//商品单位||data//goodsinfo|unitinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3383','60','key//stocktip||text//库存预警||data//goodsinfo|stocktip','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3384','60','key//location||text//商品货位||data//goodsinfo|location','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3385','60','key//retail_name||text//零售名称||data//goodsinfo|retail_name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3386','60','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3388','62','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3389','62','{field: \'merchant\', title: \'所属商户\', width: 120, align:\'center\',templet: \'<div>{{d.merchantinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3390','62','{field: \'time\', title: \'单据日期\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3391','62','{field: \'number\', title: \'单据编号\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3392','62','{field: \'supplier\', title: \'供应商\', width: 120, align:\'center\',templet: \'<div>{{d.supplierinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3393','62','{field: \'total\', title: \'单据金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3394','62','{field: \'actual\', title: \'实际金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3395','62','{field: \'money\', title: \'实付金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3396','62','{field: \'user\', title: \'制单人\', width: 120, align:\'center\',templet: \'<div>{{d.userinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3397','62','{field: \'account\', title: \'源结算账户\', width: 120, align:\'center\',templet: \'<div>{{d.accountinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3398','62','{field: \'billtype\', title: \'核销状态\', width: 120, align:\'center\',templet: \'<div>{{d.billtype.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3399','62','{field: \'data\', title: \'备注信息\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3400','62','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3404','63','key//merchant||text//所属商户||data//merchantinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3405','63','key//time||text//单据日期||data//time','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3406','63','key//number||text//单据编号||data//number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3407','63','key//supplier||text//供应商||data//supplierinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3408','63','key//total||text//单据金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3409','63','key//actual||text//实际金额||data//actual','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3410','63','key//money||text//实付金额||data//money','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3411','63','key//user||text//制单人||data//userinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3412','63','key//account||text//源结算账户||data//accountinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3413','63','key//billtype||text//核销状态||data//billtype|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3414','63','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3512','65','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3513','65','{field: \'merchant\', title: \'所属商户\', width: 120, align:\'center\',templet: \'<div>{{d.merchantinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3514','65','{field: \'time\', title: \'单据日期\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3515','65','{field: \'number\', title: \'单据编号\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3516','65','{field: \'customer\', title: \'客户\', width: 120, align:\'center\',templet: \'<div>{{d.customerinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3517','65','{field: \'total\', title: \'单据金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3518','65','{field: \'actual\', title: \'实际金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3519','65','{field: \'money\', title: \'实收金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3520','65','{field: \'user\', title: \'制单人\', width: 120, align:\'center\',templet: \'<div>{{d.userinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3521','65','{field: \'account\', title: \'结算账户\', width: 120, align:\'center\',templet: \'<div>{{d.accountinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3522','65','{field: \'type\', title: \'审核状态\', width: 120, align:\'center\',templet: \'<div>{{d.type.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3523','65','{field: \'billtype\', title: \'核销状态\', width: 120, align:\'center\',templet: \'<div>{{d.billtype.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3524','65','{field: \'data\', title: \'备注信息\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3525','65','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3542','66','key//merchant||text//所属商户||data//merchantinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3543','66','key//time||text//单据日期||data//time','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3544','66','key//number||text//单据编号||data//number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3545','66','key//customer||text//客户||data//customerinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3546','66','key//total||text//单据金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3547','66','key//actual||text//实际金额||data//actual','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3548','66','key//money||text//实收金额||data//money','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3549','66','key//user||text//制单人||data//userinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3550','66','key//account||text//结算账户||data//accountinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3551','66','key//type||text//审核状态||data//type|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3552','66','key//billtype||text//核销状态||data//billtype|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3553','66','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3586','67','key//name||text//商品信息||data//goodsinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3587','67','key//attr||text//辅助属性||data//roominfo|attr|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3588','67','key//warehouse||text//所属仓库||data//warehouseinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3589','67','key//stock||text//当前库存||data//roominfo|nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3590','67','key//serial||text//商品串码||data//serial','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3591','67','key//nums||text//数量||data//nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3592','67','key//price||text//销货单价||data//price','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3593','67','key//discount||text//折扣||data//discount','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3594','67','key//total||text//销货金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3595','67','key//batch||text//商品批次||data//roominfo|batch','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3596','67','key//brand||text//商品品牌||data//goodsinfo|brandinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3597','67','key//number||text//商品编号||data//goodsinfo|number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3598','67','key//class||text//商品分类||data//goodsinfo|classinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3599','67','key//spec||text//规格型号||data//goodsinfo|spec','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3600','67','key//code||text//条形码||data//goodsinfo|code','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3601','67','key//unit||text//商品单位||data//goodsinfo|unitinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3602','67','key//stocktip||text//库存预警||data//goodsinfo|stocktip','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3603','67','key//location||text//商品货位||data//goodsinfo|location','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3604','67','key//retail_name||text//零售名称||data//goodsinfo|retail_name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3605','67','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3638','68','key//name||text//商品信息||data//goodsinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3639','68','key//attr||text//辅助属性||data//roominfo|attr|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3640','68','key//warehouse||text//所属仓库||data//warehouseinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3641','68','key//stock||text//当前库存||data//roominfo|nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3642','68','key//serial||text//商品串码||data//serial','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3643','68','key//nums||text//数量||data//nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3644','68','key//price||text//销货单价||data//price','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3645','68','key//discount||text//折扣||data//discount','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3646','68','key//total||text//销货金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3647','68','key//batch||text//商品批次||data//roominfo|batch','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3648','68','key//brand||text//商品品牌||data//goodsinfo|brandinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3649','68','key//number||text//商品编号||data//goodsinfo|number','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3650','68','key//class||text//商品分类||data//goodsinfo|classinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3651','68','key//spec||text//规格型号||data//goodsinfo|spec','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3652','68','key//code||text//条形码||data//goodsinfo|code','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3653','68','key//unit||text//商品单位||data//goodsinfo|unitinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3654','68','key//stocktip||text//库存预警||data//goodsinfo|stocktip','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3655','68','key//location||text//商品货位||data//goodsinfo|location','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3656','68','key//retail_name||text//零售名称||data//goodsinfo|retail_name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3657','68','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3674','69','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3675','69','{field: \'merchant\', title: \'所属商户\', width: 120, align:\'center\',templet: \'<div>{{d.merchantinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3676','69','{field: \'time\', title: \'单据日期\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3677','69','{field: \'number\', title: \'单据编号\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3678','69','{field: \'customer\', title: \'客户\', width: 120, align:\'center\',templet: \'<div>{{d.customerinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3679','69','{field: \'total\', title: \'单据金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3680','69','{field: \'actual\', title: \'实际金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3681','69','{field: \'money\', title: \'实收金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3682','69','{field: \'user\', title: \'制单人\', width: 120, align:\'center\',templet: \'<div>{{d.userinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3683','69','{field: \'account\', title: \'源结算账户\', width: 120, align:\'center\',templet: \'<div>{{d.accountinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3684','69','{field: \'billtype\', title: \'核销状态\', width: 120, align:\'center\',templet: \'<div>{{d.billtype.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3685','69','{field: \'data\', title: \'备注信息\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3686','69','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3703','70','key//merchant||text//所属商户||data//merchantinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3704','70','key//time||text//单据日期||data//time','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3705','70','key//number||text//单据编号||data//number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3706','70','key//customer||text//客户||data//customerinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3707','70','key//total||text//单据金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3708','70','key//actual||text//实际金额||data//actual','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3709','70','key//money||text//实收金额||data//money','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3710','70','key//user||text//制单人||data//userinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3711','70','key//account||text//源结算账户||data//accountinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3712','70','key//billtype||text//核销状态||data//billtype|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3713','70','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3858','72','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3859','72','{field: \'merchant\', title: \'所属商户\', width: 120, align:\'center\',templet: \'<div>{{d.merchantinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3860','72','{field: \'time\', title: \'单据日期\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3861','72','{field: \'number\', title: \'单据编号\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3862','72','{field: \'customer\', title: \'客户\', width: 120, align:\'center\',templet: \'<div>{{d.customerinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3863','72','{field: \'total\', title: \'单据金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3864','72','{field: \'actual\', title: \'实际金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3865','72','{field: \'money\', title: \'实付金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3866','72','{field: \'user\', title: \'制单人\', width: 120, align:\'center\',templet: \'<div>{{d.userinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3867','72','{field: \'account\', title: \'结算账户\', width: 120, align:\'center\',templet: \'<div>{{d.accountinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3868','72','{field: \'type\', title: \'审核状态\', width: 120, align:\'center\',templet: \'<div>{{d.type.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3869','72','{field: \'billtype\', title: \'核销状态\', width: 120, align:\'center\',templet: \'<div>{{d.billtype.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3870','72','{field: \'data\', title: \'备注信息\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3871','72','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3888','73','key//merchant||text//所属商户||data//merchantinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3889','73','key//time||text//单据日期||data//time','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3890','73','key//number||text//单据编号||data//number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3891','73','key//customer||text//客户||data//customerinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3892','73','key//total||text//单据金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3893','73','key//actual||text//实际金额||data//actual','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3894','73','key//money||text//实付金额||data//money','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3895','73','key//user||text//制单人||data//userinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3896','73','key//account||text//结算账户||data//accountinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3897','73','key//type||text//审核状态||data//type|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3898','73','key//billtype||text//核销状态||data//billtype|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3899','73','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3932','74','key//name||text//商品信息||data//goodsinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3933','74','key//attr||text//辅助属性||data//roominfo|attr|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3934','74','key//warehouse||text//所属仓库||data//warehouseinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3935','74','key//stock||text//当前库存||data//roominfo|nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3936','74','key//serial||text//商品串码||data//serial','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3937','74','key//nums||text//数量||data//nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3938','74','key//price||text//退货单价||data//price','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3939','74','key//total||text//退货金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3940','74','key//batch||text//商品批次||data//roominfo|batch','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3941','74','key//brand||text//商品品牌||data//goodsinfo|brandinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3942','74','key//number||text//商品编号||data//goodsinfo|number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3943','74','key//class||text//商品分类||data//goodsinfo|classinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3944','74','key//spec||text//规格型号||data//goodsinfo|spec','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3945','74','key//code||text//条形码||data//goodsinfo|code','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3946','74','key//unit||text//商品单位||data//goodsinfo|unitinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3947','74','key//stocktip||text//库存预警||data//goodsinfo|stocktip','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3948','74','key//location||text//商品货位||data//goodsinfo|location','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3949','74','key//retail_name||text//零售名称||data//goodsinfo|retail_name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3950','74','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3983','75','key//name||text//商品信息||data//goodsinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3984','75','key//attr||text//辅助属性||data//roominfo|attr|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3985','75','key//warehouse||text//所属仓库||data//warehouseinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3986','75','key//stock||text//当前库存||data//roominfo|nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3987','75','key//serial||text//商品串码||data//serial','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3988','75','key//nums||text//数量||data//nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3989','75','key//price||text//退货单价||data//price','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3990','75','key//total||text//退货金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3991','75','key//batch||text//商品批次||data//roominfo|batch','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3992','75','key//brand||text//商品品牌||data//goodsinfo|brandinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3993','75','key//number||text//商品编号||data//goodsinfo|number','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3994','75','key//class||text//商品分类||data//goodsinfo|classinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3995','75','key//spec||text//规格型号||data//goodsinfo|spec','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3996','75','key//code||text//条形码||data//goodsinfo|code','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3997','75','key//unit||text//商品单位||data//goodsinfo|unitinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3998','75','key//stocktip||text//库存预警||data//goodsinfo|stocktip','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('3999','75','key//location||text//商品货位||data//goodsinfo|location','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4000','75','key//retail_name||text//零售名称||data//goodsinfo|retail_name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4001','75','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4018','76','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4019','76','{field: \'merchant\', title: \'所属商户\', width: 120, align:\'center\',templet: \'<div>{{d.merchantinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4020','76','{field: \'time\', title: \'单据日期\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4021','76','{field: \'number\', title: \'单据编号\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4022','76','{field: \'customer\', title: \'客户\', width: 120, align:\'center\',templet: \'<div>{{d.customerinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4023','76','{field: \'total\', title: \'单据金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4024','76','{field: \'actual\', title: \'实际金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4025','76','{field: \'money\', title: \'实付金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4026','76','{field: \'user\', title: \'制单人\', width: 120, align:\'center\',templet: \'<div>{{d.userinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4027','76','{field: \'account\', title: \'源结算账户\', width: 120, align:\'center\',templet: \'<div>{{d.accountinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4028','76','{field: \'billtype\', title: \'核销状态\', width: 120, align:\'center\',templet: \'<div>{{d.billtype.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4029','76','{field: \'data\', title: \'备注信息\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4030','76','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4047','77','key//merchant||text//所属商户||data//merchantinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4048','77','key//time||text//单据日期||data//time','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4049','77','key//number||text//单据编号||data//number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4050','77','key//customer||text//客户||data//customerinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4051','77','key//total||text//单据金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4052','77','key//actual||text//实际金额||data//actual','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4053','77','key//money||text//实付金额||data//money','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4054','77','key//user||text//制单人||data//userinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4055','77','key//account||text//源结算账户||data//accountinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4056','77','key//billtype||text//核销状态||data//billtype|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4057','77','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4656','80','name//仓储ID||model//{name: \'set_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4657','80','name//商品ID||model//{name: \'goods_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4658','80','name//仓库ID||model//{name: \'warehouse_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4659','80','name//串码详情||model//{name: \'serial_info\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4660','80','name//操作||model//{name:\'set\',align:\"center\",width:60,sortable:false,formatter:set_formatter}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4661','80','name//商品信息<span class=\"sm_false\" onclick=\"set_sm(this);\">扫码枪</span>||model//{name:\'name\',index:\'name\',width:\'150px\',editable:true,edittype:\"custom\",editoptions:{custom_element:name_elem,custom_value:name_value}}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4662','80','name//辅助属性||model//{name:\'attr\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4663','80','name//所属仓库||model//{name:\'warehouse\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4664','80','name//当前库存||model//{name:\'stock\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4665','80','name//商品串码||model//{name:\'serial\',editable:true,edittype:\"custom\",editoptions:{custom_element:serial_elem,custom_value:serial_value},hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4666','80','name//数量||model//{name:\'nums\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4667','80','name//零售单价||model//{name:\'price\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4668','80','name//折扣||model//{name:\'discount\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4669','80','name//零售金额||model//{name:\'total\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4670','80','name//商品批次||model//{name:\'batch\',align:\"center\",hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4671','80','name//商品品牌||model//{name:\'brand\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4672','80','name//商品编号||model//{name:\'number\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4673','80','name//商品分类||model//{name:\'class\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4674','80','name//规格型号||model//{name:\'spec\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4675','80','name//条形码||model//{name:\'code\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4676','80','name//商品单位||model//{name:\'unit\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4677','80','name//库存预警||model//{name:\'stocktip\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4678','80','name//商品货位||model//{name:\'location\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4679','80','name//零售名称||model//{name:\'retail_name\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4680','80','name//备注信息||model//{name:\'data\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4750','82','key//name||text//商品信息||data//goodsinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4751','82','key//attr||text//辅助属性||data//roominfo|attr|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4752','82','key//warehouse||text//所属仓库||data//warehouseinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4753','82','key//stock||text//当前库存||data//roominfo|nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4754','82','key//serial||text//商品串码||data//serial','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4755','82','key//nums||text//数量||data//nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4756','82','key//price||text//零售单价||data//price','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4757','82','key//discount||text//折扣||data//discount','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4758','82','key//total||text//零售金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4759','82','key//batch||text//商品批次||data//roominfo|batch','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4760','82','key//brand||text//商品品牌||data//goodsinfo|brandinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4761','82','key//number||text//商品编号||data//goodsinfo|number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4762','82','key//class||text//商品分类||data//goodsinfo|classinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4763','82','key//spec||text//规格型号||data//goodsinfo|spec','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4764','82','key//code||text//条形码||data//goodsinfo|code','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4765','82','key//unit||text//商品单位||data//goodsinfo|unitinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4766','82','key//stocktip||text//库存预警||data//goodsinfo|stocktip','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4767','82','key//location||text//商品货位||data//goodsinfo|location','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4768','82','key//retail_name||text//零售名称||data//goodsinfo|retail_name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4769','82','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4770','81','key//merchant||text//所属商户||data//merchantinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4771','81','key//time||text//单据日期||data//time','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4772','81','key//number||text//单据编号||data//number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4773','81','key//customer||text//客户||data//customerinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4774','81','key//total||text//单据金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4775','81','key//actual||text//实际金额||data//actual','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4776','81','key//money||text//实收金额||data//money','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4777','81','key//user||text//制单人||data//userinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4778','81','key//user||text//付款方式||data//paytype|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4779','81','key//type||text//审核状态||data//type|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4780','81','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4781','79','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4782','79','{field: \'merchant\', title: \'所属商户\', width: 120, align:\'center\',templet: \'<div>{{d.merchantinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4783','79','{field: \'time\', title: \'单据日期\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4784','79','{field: \'number\', title: \'单据编号\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4785','79','{field: \'customer\', title: \'客户\', width: 120, align:\'center\',templet: \'<div>{{d.customerinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4786','79','{field: \'total\', title: \'单据金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4787','79','{field: \'actual\', title: \'实际金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4788','79','{field: \'money\', title: \'实收金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4789','79','{field: \'user\', title: \'制单人\', width: 120, align:\'center\',templet: \'<div>{{d.userinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4790','79','{field: \'paytype\', title: \'付款方式\', width: 120, align:\'center\',templet: \'<div>{{d.paytype.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4791','79','{field: \'type\', title: \'审核状态\', width: 120, align:\'center\',templet: \'<div>{{d.type.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4792','79','{field: \'data\', title: \'备注信息\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4793','79','{field: \'set\', title: \'相关操作\', width: 220, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4826','83','key//name||text//商品信息||data//goodsinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4827','83','key//attr||text//辅助属性||data//roominfo|attr|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4828','83','key//warehouse||text//所属仓库||data//warehouseinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4829','83','key//stock||text//当前库存||data//roominfo|nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4830','83','key//serial||text//商品串码||data//serial','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4831','83','key//nums||text//数量||data//nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4832','83','key//price||text//零售单价||data//price','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4833','83','key//discount||text//折扣||data//discount','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4834','83','key//total||text//零售金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4835','83','key//batch||text//商品批次||data//roominfo|batch','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4836','83','key//brand||text//商品品牌||data//goodsinfo|brandinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4837','83','key//number||text//商品编号||data//goodsinfo|number','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4838','83','key//class||text//商品分类||data//goodsinfo|classinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4839','83','key//spec||text//规格型号||data//goodsinfo|spec','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4840','83','key//code||text//条形码||data//goodsinfo|code','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4841','83','key//unit||text//商品单位||data//goodsinfo|unitinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4842','83','key//stocktip||text//库存预警||data//goodsinfo|stocktip','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4843','83','key//location||text//商品货位||data//goodsinfo|location','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4844','83','key//retail_name||text//零售名称||data//goodsinfo|retail_name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4845','83','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4942','85','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4943','85','{field: \'merchant\', title: \'所属商户\', width: 120, align:\'center\',templet: \'<div>{{d.merchantinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4944','85','{field: \'time\', title: \'单据日期\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4945','85','{field: \'number\', title: \'单据编号\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4946','85','{field: \'customer\', title: \'客户\', width: 120, align:\'center\',templet: \'<div>{{d.customerinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4947','85','{field: \'total\', title: \'单据金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4948','85','{field: \'actual\', title: \'实际金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4949','85','{field: \'money\', title: \'实付金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4950','85','{field: \'user\', title: \'制单人\', width: 120, align:\'center\',templet: \'<div>{{d.userinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4951','85','{field: \'account\', title: \'结算账户\', width: 120, align:\'center\',templet: \'<div>{{d.accountinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4952','85','{field: \'type\', title: \'审核状态\', width: 120, align:\'center\',templet: \'<div>{{d.type.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4953','85','{field: \'data\', title: \'备注信息\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4954','85','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4971','86','key//merchant||text//所属商户||data//merchantinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4972','86','key//time||text//单据日期||data//time','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4973','86','key//number||text//单据编号||data//number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4974','86','key//customer||text//客户||data//customerinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4975','86','key//total||text//单据金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4976','86','key//actual||text//实际金额||data//actual','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4977','86','key//money||text//实付金额||data//money','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4978','86','key//user||text//制单人||data//userinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4979','86','key//account||text//结算账户||data//accountinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4980','86','key//type||text//审核状态||data//type|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4981','86','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4983','87','key//name||text//商品信息||data//goodsinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4984','87','key//attr||text//辅助属性||data//roominfo|attr|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4985','87','key//warehouse||text//所属仓库||data//warehouseinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4986','87','key//stock||text//当前库存||data//roominfo|nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4987','87','key//serial||text//商品串码||data//serial','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4988','87','key//nums||text//数量||data//nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4989','87','key//price||text//退货单价||data//price','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4990','87','key//total||text//退货金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4991','87','key//batch||text//商品批次||data//roominfo|batch','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4992','87','key//brand||text//商品品牌||data//goodsinfo|brandinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4993','87','key//number||text//商品编号||data//goodsinfo|number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4994','87','key//class||text//商品分类||data//goodsinfo|classinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4995','87','key//spec||text//规格型号||data//goodsinfo|spec','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4996','87','key//code||text//条形码||data//goodsinfo|code','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4997','87','key//unit||text//商品单位||data//goodsinfo|unitinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4998','87','key//stocktip||text//库存预警||data//goodsinfo|stocktip','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('4999','87','key//location||text//商品货位||data//goodsinfo|location','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5000','87','key//retail_name||text//零售名称||data//goodsinfo|retail_name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5001','87','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5015','88','key//name||text//商品信息||data//goodsinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5016','88','key//attr||text//辅助属性||data//roominfo|attr|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5017','88','key//warehouse||text//所属仓库||data//warehouseinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5018','88','key//stock||text//当前库存||data//roominfo|nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5019','88','key//serial||text//商品串码||data//serial','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5020','88','key//nums||text//数量||data//nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5021','88','key//price||text//退货单价||data//price','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5022','88','key//total||text//退货金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5023','88','key//batch||text//商品批次||data//roominfo|batch','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5024','88','key//brand||text//商品品牌||data//goodsinfo|brandinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5025','88','key//number||text//商品编号||data//goodsinfo|number','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5026','88','key//class||text//商品分类||data//goodsinfo|classinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5027','88','key//spec||text//规格型号||data//goodsinfo|spec','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5028','88','key//code||text//条形码||data//goodsinfo|code','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5029','88','key//unit||text//商品单位||data//goodsinfo|unitinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5030','88','key//stocktip||text//库存预警||data//goodsinfo|stocktip','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5031','88','key//location||text//商品货位||data//goodsinfo|location','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5032','88','key//retail_name||text//零售名称||data//goodsinfo|retail_name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5033','88','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5066','89','name//服务ID||model//{name: \'set_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5067','89','name//操作||model//{name:\'set\',align:\"center\",width:60,sortable:false,formatter:set_formatter}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5068','89','name//服务项目||model//{name:\'name\',width:\'150px\',editable:true,edittype:\"custom\",editoptions:{custom_element:serve_elem,custom_value:serve_value}}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5069','89','name//数量||model//{name:\'nums\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5070','89','name//服务单价||model//{name:\'price\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5071','89','name//服务金额||model//{name:\'total\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5072','89','name//备注信息||model//{name:\'data\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5112','90','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5113','90','{field: \'name\', title: \'服务名称\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5114','90','{field: \'price\', title: \'服务价格\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5115','90','{field: \'data\', title: \'备注信息\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5117','91','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5118','91','{field: \'merchant\', title: \'所属商户\', width: 120, align:\'center\',templet: \'<div>{{d.merchantinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5119','91','{field: \'time\', title: \'单据日期\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5120','91','{field: \'number\', title: \'单据编号\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5121','91','{field: \'customer\', title: \'客户\', width: 120, align:\'center\',templet: \'<div>{{d.customerinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5122','91','{field: \'total\', title: \'单据金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5123','91','{field: \'actual\', title: \'实际金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5124','91','{field: \'money\', title: \'实收金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5125','91','{field: \'user\', title: \'制单人\', width: 120, align:\'center\',templet: \'<div>{{d.userinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5126','91','{field: \'account\', title: \'结算账户\', width: 120, align:\'center\',templet: \'<div>{{d.accountinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5127','91','{field: \'type\', title: \'审核状态\', width: 120, align:\'center\',templet: \'<div>{{d.type.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5128','91','{field: \'billtype\', title: \'核销状态\', width: 120, align:\'center\',templet: \'<div>{{d.billtype.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5129','91','{field: \'data\', title: \'备注信息\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5130','91','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5133','92','key//merchant||text//所属商户||data//merchantinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5134','92','key//time||text//单据日期||data//time','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5135','92','key//number||text//单据编号||data//number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5136','92','key//customer||text//客户||data//customerinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5137','92','key//total||text//单据金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5138','92','key//actual||text//实际金额||data//actual','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5139','92','key//money||text//实收金额||data//money','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5140','92','key//user||text//制单人||data//userinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5141','92','key//account||text//结算账户||data//accountinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5142','92','key//type||text//审核状态||data//type|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5143','92','key//billtype||text//核销状态||data//billtype|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5144','92','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5180','93','key//name||text//服务项目||data//serveinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5181','93','key//nums||text//数量||data//nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5182','93','key//price||text//服务单价||data//price','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5183','93','key//total||text//服务金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5184','93','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5217','94','key//name||text//服务项目||data//serveinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5218','94','key//nums||text//数量||data//nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5219','94','key//price||text//服务单价||data//price','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5220','94','key//total||text//服务金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5221','94','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5223','95','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5224','95','{field: \'merchant\', title: \'所属商户\', width: 120, align:\'center\',templet: \'<div>{{d.merchantinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5225','95','{field: \'time\', title: \'单据日期\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5226','95','{field: \'number\', title: \'单据编号\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5227','95','{field: \'customer\', title: \'客户\', width: 120, align:\'center\',templet: \'<div>{{d.customerinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5228','95','{field: \'total\', title: \'单据金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5229','95','{field: \'actual\', title: \'实际金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5230','95','{field: \'money\', title: \'实收金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5231','95','{field: \'user\', title: \'制单人\', width: 120, align:\'center\',templet: \'<div>{{d.userinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5232','95','{field: \'account\', title: \'源结算账户\', width: 120, align:\'center\',templet: \'<div>{{d.accountinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5233','95','{field: \'billtype\', title: \'核销状态\', width: 120, align:\'center\',templet: \'<div>{{d.billtype.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5234','95','{field: \'data\', title: \'备注信息\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5235','95','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5239','96','key//merchant||text//所属商户||data//merchantinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5240','96','key//time||text//单据日期||data//time','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5241','96','key//number||text//单据编号||data//number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5242','96','key//customer||text//客户||data//customerinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5243','96','key//total||text//单据金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5244','96','key//actual||text//实际金额||data//actual','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5245','96','key//money||text//实收金额||data//money','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5246','96','key//user||text//制单人||data//userinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5247','96','key//account||text//源结算账户||data//accountinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5248','96','key//billtype||text//核销状态||data//billtype|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5249','96','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5334','98','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5335','98','{field: \'merchant\', title: \'所属商户\', width: 120, align:\'center\',templet: \'<div>{{d.merchantinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5336','98','{field: \'time\', title: \'单据日期\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5337','98','{field: \'number\', title: \'单据编号\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5338','98','{field: \'customer\', title: \'客户\', width: 120, align:\'center\',templet: \'<div>{{d.customerinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5339','98','{field: \'total\', title: \'单据积分\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5340','98','{field: \'actual\', title: \'实际积分\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5341','98','{field: \'integral\', title: \'实收积分\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5342','98','{field: \'user\', title: \'制单人\', width: 120, align:\'center\',templet: \'<div>{{d.userinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5343','98','{field: \'type\', title: \'审核状态\', width: 120, align:\'center\',templet: \'<div>{{d.type.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5344','98','{field: \'data\', title: \'备注信息\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5345','98','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5372','99','key//merchant||text//所属商户||data//merchantinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5373','99','key//time||text//单据日期||data//time','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5374','99','key//number||text//单据编号||data//number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5375','99','key//customer||text//客户||data//customerinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5376','99','key//total||text//单据积分||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5377','99','key//actual||text//实际积分||data//actual','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5378','99','key//integral||text//实收积分||data//integral','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5379','99','key//user||text//制单人||data//userinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5380','99','key//type||text//审核状态||data//type|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5381','99','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5414','100','key//name||text//商品信息||data//goodsinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5415','100','key//attr||text//辅助属性||data//roominfo|attr|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5416','100','key//warehouse||text//所属仓库||data//warehouseinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5417','100','key//stock||text//当前库存||data//roominfo|nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5418','100','key//serial||text//商品串码||data//serial','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5419','100','key//nums||text//数量||data//nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5420','100','key//integral||text//兑换积分||data//integral','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5421','100','key//allintegral||text//总积分||data//allintegral','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5422','100','key//batch||text//商品批次||data//roominfo|batch','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5423','100','key//brand||text//商品品牌||data//goodsinfo|brandinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5424','100','key//number||text//商品编号||data//goodsinfo|number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5425','100','key//class||text//商品分类||data//goodsinfo|classinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5426','100','key//spec||text//规格型号||data//goodsinfo|spec','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5427','100','key//code||text//条形码||data//goodsinfo|code','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5428','100','key//unit||text//商品单位||data//goodsinfo|unitinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5429','100','key//stocktip||text//库存预警||data//goodsinfo|stocktip','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5430','100','key//location||text//商品货位||data//goodsinfo|location','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5431','100','key//retail_name||text//零售名称||data//goodsinfo|retail_name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5432','100','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5465','101','key//name||text//商品信息||data//goodsinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5466','101','key//attr||text//辅助属性||data//roominfo|attr|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5467','101','key//warehouse||text//所属仓库||data//warehouseinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5468','101','key//stock||text//当前库存||data//roominfo|nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5469','101','key//serial||text//商品串码||data//serial','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5470','101','key//nums||text//数量||data//nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5471','101','key//integral||text//兑换积分||data//integral','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5472','101','key//allintegral||text//总积分||data//allintegral','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5473','101','key//batch||text//商品批次||data//roominfo|batch','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5474','101','key//brand||text//商品品牌||data//goodsinfo|brandinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5475','101','key//number||text//商品编号||data//goodsinfo|number','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5476','101','key//class||text//商品分类||data//goodsinfo|classinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5477','101','key//spec||text//规格型号||data//goodsinfo|spec','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5478','101','key//code||text//条形码||data//goodsinfo|code','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5479','101','key//unit||text//商品单位||data//goodsinfo|unitinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5480','101','key//stocktip||text//库存预警||data//goodsinfo|stocktip','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5481','101','key//location||text//商品货位||data//goodsinfo|location','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5482','101','key//retail_name||text//零售名称||data//goodsinfo|retail_name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5483','101','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5642','104','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5643','104','{field: \'merchant\', title: \'所属商户\', width: 120, align:\'center\',templet: \'<div>{{d.merchantinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5644','104','{field: \'time\', title: \'单据日期\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5645','104','{field: \'number\', title: \'单据编号\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5646','104','{field: \'user\', title: \'制单人\', width: 120, align:\'center\',templet: \'<div>{{d.userinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5647','104','{field: \'type\', title: \'审核状态\', width: 120, align:\'center\',templet: \'<div>{{d.type.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5648','104','{field: \'data\', title: \'备注信息\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5649','104','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5682','105','key//merchant||text//所属商户||data//merchantinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5683','105','key//time||text//单据日期||data//time','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5684','105','key//number||text//单据编号||data//number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5685','105','key//user||text//制单人||data//userinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5686','105','key//type||text//审核状态||data//type|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5687','105','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5688','106','key//name||text//商品信息||data//goodsinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5689','106','key//attr||text//辅助属性||data//roominfo|attr|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5690','106','key//warehouse||text//所属仓库||data//warehouseinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5691','106','key//stock||text//当前库存||data//roominfo|nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5692','106','key//serial||text//商品串码||data//serial','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5693','106','key//nums||text//调拨数量||data//nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5694','106','key//towarehouse||text//调拨仓库||data//towarehouseinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5695','106','key//batch||text//商品批次||data//roominfo|batch','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5696','106','key//brand||text//商品品牌||data//goodsinfo|brandinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5697','106','key//number||text//商品编号||data//goodsinfo|number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5698','106','key//class||text//商品分类||data//goodsinfo|classinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5699','106','key//spec||text//规格型号||data//goodsinfo|spec','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5700','106','key//code||text//条形码||data//goodsinfo|code','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5701','106','key//unit||text//商品单位||data//goodsinfo|unitinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5702','106','key//stocktip||text//库存预警||data//goodsinfo|stocktip','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5703','106','key//location||text//商品货位||data//goodsinfo|location','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5704','106','key//retail_name||text//零售名称||data//goodsinfo|retail_name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5705','106','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5726','107','key//name||text//商品信息||data//goodsinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5727','107','key//attr||text//辅助属性||data//roominfo|attr|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5728','107','key//warehouse||text//所属仓库||data//warehouseinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5729','107','key//stock||text//当前库存||data//roominfo|nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5730','107','key//serial||text//商品串码||data//serial','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5731','107','key//nums||text//调拨数量||data//nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5732','107','key//towarehouse||text//调拨仓库||data//towarehouseinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5733','107','key//batch||text//商品批次||data//roominfo|batch','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5734','107','key//brand||text//商品品牌||data//goodsinfo|brandinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5735','107','key//number||text//商品编号||data//goodsinfo|number','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5736','107','key//class||text//商品分类||data//goodsinfo|classinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5737','107','key//spec||text//规格型号||data//goodsinfo|spec','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5738','107','key//code||text//条形码||data//goodsinfo|code','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5739','107','key//unit||text//商品单位||data//goodsinfo|unitinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5740','107','key//stocktip||text//库存预警||data//goodsinfo|stocktip','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5741','107','key//location||text//商品货位||data//goodsinfo|location','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5742','107','key//retail_name||text//零售名称||data//goodsinfo|retail_name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5743','107','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5809','109','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5810','109','{field: \'merchant\', title: \'所属商户\', width: 120, align:\'center\',templet: \'<div>{{d.merchantinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5811','109','{field: \'time\', title: \'单据日期\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5812','109','{field: \'number\', title: \'单据编号\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5813','109','{field: \'pagetype\', title: \'单据类型\', width: 120, align:\'center\',templet: \'<div>{{d.pagetype.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5814','109','{field: \'user\', title: \'制单人\', width: 120, align:\'center\',templet: \'<div>{{d.userinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5815','109','{field: \'type\', title: \'审核状态\', width: 120, align:\'center\',templet: \'<div>{{d.type.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5816','109','{field: \'data\', title: \'备注信息\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5817','109','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5830','110','key//merchant||text//所属商户||data//merchantinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5831','110','key//time||text//单据日期||data//time','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5832','110','key//number||text//单据编号||data//number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5833','110','key//pagetype||text//单据类型||data//pagetype|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5834','110','key//user||text//制单人||data//userinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5835','110','key//type||text//审核状态||data//type|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5836','110','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5855','111','key//name||text//商品信息||data//goodsinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5856','111','key//attr||text//辅助属性||data//attr|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5857','111','key//warehouse||text//所入仓库||data//warehouseinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5858','111','key//batch||text//商品批次||data//batch','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5859','111','key//serial||text//商品串码||data//serial','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5860','111','key//nums||text//数量||data//nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5861','111','key//brand||text//商品品牌||data//goodsinfo|brandinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5862','111','key//number||text//商品编号||data//goodsinfo|number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5863','111','key//class||text//商品分类||data//goodsinfo|classinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5864','111','key//spec||text//规格型号||data//goodsinfo|spec','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5865','111','key//code||text//条形码||data//goodsinfo|code','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5866','111','key//unit||text//商品单位||data//goodsinfo|unitinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5867','111','key//stocktip||text//库存预警||data//goodsinfo|stocktip','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5868','111','key//location||text//商品货位||data//goodsinfo|location','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5869','111','key//retail_name||text//零售名称||data//goodsinfo|retail_name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5870','111','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5889','112','key//name||text//商品名称||data//goodsinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5890','112','key//attr||text//辅助属性||data//attr|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5891','112','key//warehouse||text//所入仓库||data//warehouseinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5892','112','key//batch||text//商品批次||data//batch','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5893','112','key//serial||text//商品串码||data//serial','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5894','112','key//nums||text//数量||data//nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5895','112','key//brand||text//商品品牌||data//goodsinfo|brandinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5896','112','key//number||text//商品编号||data//goodsinfo|number','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5897','112','key//class||text//商品分类||data//goodsinfo|classinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5898','112','key//spec||text//规格型号||data//goodsinfo|spec','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5899','112','key//code||text//条形码||data//goodsinfo|code','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5900','112','key//unit||text//商品单位||data//goodsinfo|unitinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5901','112','key//stocktip||text//库存预警||data//goodsinfo|stocktip','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5902','112','key//location||text//商品货位||data//goodsinfo|location','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5903','112','key//retail_name||text//零售名称||data//goodsinfo|retail_name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5904','112','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5992','114','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5993','114','{field: \'merchant\', title: \'所属商户\', width: 120, align:\'center\',templet: \'<div>{{d.merchantinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5994','114','{field: \'time\', title: \'单据日期\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5995','114','{field: \'number\', title: \'单据编号\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5996','114','{field: \'pagetype\', title: \'单据类型\', width: 120, align:\'center\',templet: \'<div>{{d.pagetype.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5997','114','{field: \'user\', title: \'制单人\', width: 120, align:\'center\',templet: \'<div>{{d.userinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5998','114','{field: \'type\', title: \'审核状态\', width: 120, align:\'center\',templet: \'<div>{{d.type.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('5999','114','{field: \'data\', title: \'备注信息\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6000','114','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6053','115','key//merchant||text//所属商户||data//merchantinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6054','115','key//time||text//单据日期||data//time','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6055','115','key//number||text//单据编号||data//number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6056','115','key//pagetype||text//单据类型||data//pagetype|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6057','115','key//user||text//制单人||data//userinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6058','115','key//type||text//审核状态||data//type|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6059','115','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6060','116','key//name||text//商品信息||data//goodsinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6061','116','key//attr||text//辅助属性||data//roominfo|attr|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6062','116','key//warehouse||text//所属仓库||data//warehouseinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6063','116','key//stock||text//当前库存||data//roominfo|nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6064','116','key//serial||text//商品串码||data//serial','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6065','116','key//nums||text//数量||data//nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6066','116','key//batch||text//商品批次||data//roominfo|batch','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6067','116','key//brand||text//商品品牌||data//goodsinfo|brandinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6068','116','key//number||text//商品编号||data//goodsinfo|number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6069','116','key//class||text//商品分类||data//goodsinfo|classinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6070','116','key//spec||text//规格型号||data//goodsinfo|spec','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6071','116','key//code||text//条形码||data//goodsinfo|code','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6072','116','key//unit||text//商品单位||data//goodsinfo|unitinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6073','116','key//stocktip||text//库存预警||data//goodsinfo|stocktip','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6074','116','key//location||text//商品货位||data//goodsinfo|location','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6075','116','key//retail_name||text//零售名称||data//goodsinfo|retail_name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6076','116','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6077','117','key//name||text//商品信息||data//goodsinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6078','117','key//attr||text//辅助属性||data//roominfo|attr|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6079','117','key//warehouse||text//所属仓库||data//warehouseinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6080','117','key//stock||text//当前库存||data//roominfo|nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6081','117','key//serial||text//商品串码||data//serial','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6082','117','key//nums||text//数量||data//nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6083','117','key//batch||text//商品批次||data//roominfo|batch','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6084','117','key//brand||text//商品品牌||data//goodsinfo|brandinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6085','117','key//number||text//商品编号||data//goodsinfo|number','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6086','117','key//class||text//商品分类||data//goodsinfo|classinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6087','117','key//spec||text//规格型号||data//goodsinfo|spec','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6088','117','key//code||text//条形码||data//goodsinfo|code','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6089','117','key//unit||text//商品单位||data//goodsinfo|unitinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6090','117','key//stocktip||text//库存预警||data//goodsinfo|stocktip','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6091','117','key//location||text//商品货位||data//goodsinfo|location','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6092','117','key//retail_name||text//零售名称||data//goodsinfo|retail_name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6093','117','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6513','118','{field: \'goods\', title: \'商品ID\',hide:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6514','118','{field: \'name\', title: \'商品名称\',width:200, align:\'center\',fixed: \'left\',templet: \'<div>{{d.goodsinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6515','118','{field: \'img\', title: \'商品图像\', width: 150,align:\'center\',templet: \'<div><img src=\"{{d.goodsinfo.img}}\"/></div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6516','118','{field: \'attr\', title: \'辅助属性\', width: 120, align:\'center\',templet: \'<div>{{d.attr.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6517','118','{field: \'warehouse\', title: \'所属仓库\', width: 120, align:\'center\',templet: \'<div>{{d.warehouseinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6518','118','{field: \'nums\', title: \'当前库存\', width: 150, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6519','118','{field: \'batch\', title: \'商品批次\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6520','118','{field: \'number\', title: \'商品编号\', width: 120, align:\'center\',templet: \'<div>{{d.goodsinfo.number}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6521','118','{field: \'spec\', title: \'规格型号\', width: 120, align:\'center\',templet: \'<div>{{d.goodsinfo.spec}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6522','118','{field: \'class\', title: \'商品分类\', width: 120, align:\'center\',templet: \'<div>{{#if(d.goodsinfo.classinfo){}}{{d.goodsinfo.classinfo.name}}{{#}else{}}无{{#}}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6523','118','{field: \'brand\', title: \'商品品牌\', width: 120, align:\'center\',templet: \'<div>{{#if(d.goodsinfo.brandinfo){}}{{d.goodsinfo.brandinfo.name}}{{#}else{}}无{{#}}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6524','118','{field: \'unit\', title: \'商品单位\', width: 120, align:\'center\',templet: \'<div>{{#if(d.goodsinfo.unitinfo){}}{{d.goodsinfo.unitinfo.name}}{{#}else{}}无{{#}}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6525','118','{field: \'buy\', title: \'购货价格\', width: 120, align:\'center\',templet: \'<div>{{d.goodsinfo.buy}}</div>\'}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6526','118','{field: \'sell\', title: \'销货价格\', width: 120, align:\'center\',templet: \'<div>{{d.goodsinfo.sell}}</div>\'}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6527','118','{field: \'retail\', title: \'零售价格\', width: 120, align:\'center\',templet: \'<div>{{d.goodsinfo.retail}}</div>\'}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6528','118','{field: \'integral\', title: \'兑换积分\', width: 120, align:\'center\',templet: \'<div>{{d.goodsinfo.integral}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6529','118','{field: \'code\', title: \'条形码\', width: 160, align:\'center\',templet: \'<div>{{d.goodsinfo.code}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6530','118','{field: \'location\', title: \'商品货位\', width: 120, align:\'center\',templet: \'<div>{{d.goodsinfo.location}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6531','118','{field: \'stocktip\', title: \'库存阈值\', width: 120, align:\'center\',templet: \'<div>{{d.goodsinfo.stocktip}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6532','118','{field: \'data\', title: \'备注信息\', width: 120, align:\'center\',templet: \'<div>{{d.goodsinfo.data}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6533','118','{field: \'set\', title: \'相关操作\', width: 120, align:\'center\',fixed: \'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6534','40','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6535','40','{field: \'goods\', title: \'商品ID\',hide:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6536','40','{field: \'name\', title: \'商品名称\',width:200, align:\'center\',fixed: \'left\',templet: \'<div>{{d.goodsinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6537','40','{field: \'img\', title: \'商品图像\', width: 150, align:\'center\',templet: \'<div><img src=\"{{d.goodsinfo.img}}\"/></div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6538','40','{field: \'attr\', title: \'辅助属性\', width: 120, align:\'center\',templet: \'<div>{{d.attr.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6539','40','{field: \'warehouse\', title: \'所属仓库\', width: 120, align:\'center\',templet: \'<div>{{d.warehouseinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6540','40','{field: \'nums\', title: \'当前库存\', width: 150, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6541','40','{field: \'batch\', title: \'商品批次\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6542','40','{field: \'number\', title: \'商品编号\', width: 120, align:\'center\',templet: \'<div>{{d.goodsinfo.number}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6543','40','{field: \'spec\', title: \'规格型号\', width: 120, align:\'center\',templet: \'<div>{{d.goodsinfo.spec}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6544','40','{field: \'class\', title: \'商品分类\', width: 120, align:\'center\',templet: \'<div>{{#if(d.goodsinfo.classinfo){}}{{d.goodsinfo.classinfo.name}}{{#}else{}}无{{#}}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6545','40','{field: \'brand\', title: \'商品品牌\', width: 120, align:\'center\',templet: \'<div>{{#if(d.goodsinfo.brandinfo){}}{{d.goodsinfo.brandinfo.name}}{{#}else{}}无{{#}}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6546','40','{field: \'unit\', title: \'商品单位\', width: 120, align:\'center\',templet: \'<div>{{#if(d.goodsinfo.unitinfo){}}{{d.goodsinfo.unitinfo.name}}{{#}else{}}无{{#}}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6547','40','{field: \'buy\', title: \'购货价格\', width: 120, align:\'center\',templet: \'<div>{{d.goodsinfo.buy}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6548','40','{field: \'sell\', title: \'销货价格\', width: 120, align:\'center\',templet: \'<div>{{d.goodsinfo.sell}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6549','40','{field: \'retail\', title: \'零售价格\', width: 120, align:\'center\',templet: \'<div>{{d.goodsinfo.retail}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6550','40','{field: \'integral\', title: \'兑换积分\', width: 120, align:\'center\',templet: \'<div>{{d.goodsinfo.integral}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6551','40','{field: \'code\', title: \'条形码\', width: 160, align:\'center\',templet: \'<div>{{d.goodsinfo.code}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6552','40','{field: \'location\', title: \'商品货位\', width: 120, align:\'center\',templet: \'<div>{{d.goodsinfo.location}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6553','40','{field: \'stocktip\', title: \'库存阈值\', width: 120, align:\'center\',templet: \'<div>{{d.goodsinfo.stocktip}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6554','40','{field: \'data\', title: \'备注信息\', width: 120, align:\'center\',templet: \'<div>{{d.goodsinfo.data}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6597','119','key//name||text//商品名称||data//goodsinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6598','119','key//attr||text//辅助属性||data//attr|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6599','119','key//warehouse||text//所属仓库||data//warehouseinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6600','119','key//nums||text//当前库存||data//nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6601','119','key//batch||text//商品批次||data//batch','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6602','119','key//number||text//商品编号||data//goodsinfo|number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6603','119','key//spec||text//规格型号||data//goodsinfo|spec','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6604','119','key//class||text//商品分类||data//goodsinfo|classinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6605','119','key//brand||text//商品品牌||data//goodsinfo|brandinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6606','119','key//unit||text//商品单位||data//goodsinfo|unitinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6607','119','key//buy||text//购货价格||data//goodsinfo|buy','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6608','119','key//sell||text//销货价格||data//goodsinfo|sell','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6609','119','key//retail||text//零售价格||data//goodsinfo|retail','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6610','119','key//integral||text//兑换积分||data//goodsinfo|integral','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6611','119','key//code||text//条形码||data//goodsinfo|code','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6612','119','key//location||text//商品货位||data//goodsinfo|location','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6613','119','key//stocktip||text//库存阈值||data//goodsinfo|stocktip','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6614','119','key//data||text//备注信息||data//goodsinfo|data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6689','121','key//merchant||text//所属商户||data//typedata|merchantinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6690','121','key//time||text//操作时间||data//typedata|time','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6691','121','key//type||text//单据类型||data//type|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6692','121','key//number||text//单据编号||data//typedata|number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6693','121','key//trend||text//操作类型||data//type|trend','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6694','121','key//nums||text//商品数量||data//nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6695','121','key//user||text//制单人||data//typedata|userinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6696','121','key//data||text//备注信息||data//typedata|data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6705','120','{field: \'merchant\', title: \'所属商户\', width: 120, align:\'center\',templet: \'<div>{{d.typedata.merchantinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6706','120','{field: \'time\', title: \'操作时间\', width: 120, align:\'center\',templet: \'<div>{{d.typedata.time}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6707','120','{field: \'type\', title: \'单据类型\', width: 120, align:\'center\',templet: \'<div>{{d.type.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6708','120','{field: \'number\', title: \'单据编号\', width: 200, align:\'center\',templet: \'<div>{{d.typedata.number}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6709','120','{field: \'trend\', title: \'操作类型\', width: 120, align:\'center\',templet: \'<div>{{d.type.trend}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6710','120','{field: \'nums\', title: \'商品数量\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6711','120','{field: \'user\', title: \'制单人\', width: 120, align:\'center\',templet: \'<div>{{d.typedata.userinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6712','120','{field: \'data\', title: \'备注信息\', width: 200, align:\'center\',templet: \'<div>{{d.typedata.data}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6754','122','{field: \'goods\', title: \'商品ID\',hide:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6755','122','{field: \'name\', title: \'商品名称\',width:200, align:\'center\',fixed: \'left\',templet: \'<div>{{d.goodsinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6756','122','{field: \'img\', title: \'商品图像\', width: 150,align:\'center\',templet: \'<div><img src=\"{{d.goodsinfo.img}}\"/></div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6757','122','{field: \'attr\', title: \'辅助属性\', width: 120, align:\'center\',templet: \'<div>{{d.attr.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6758','122','{field: \'warehouse\', title: \'所属仓库\', width: 120, align:\'center\',templet: \'<div>{{d.warehouseinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6759','122','{field: \'nums\', title: \'当前库存\', width: 150, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6760','122','{field: \'stocktip\', title: \'库存阈值\', width: 120, align:\'center\',templet: \'<div>{{d.goodsinfo.stocktip}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6761','122','{field: \'batch\', title: \'商品批次\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6762','122','{field: \'number\', title: \'商品编号\', width: 120, align:\'center\',templet: \'<div>{{d.goodsinfo.number}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6763','122','{field: \'spec\', title: \'规格型号\', width: 120, align:\'center\',templet: \'<div>{{d.goodsinfo.spec}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6764','122','{field: \'class\', title: \'商品分类\', width: 120, align:\'center\',templet: \'<div>{{#if(d.goodsinfo.classinfo){}}{{d.goodsinfo.classinfo.name}}{{#}else{}}无{{#}}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6765','122','{field: \'brand\', title: \'商品品牌\', width: 120, align:\'center\',templet: \'<div>{{#if(d.goodsinfo.brandinfo){}}{{d.goodsinfo.brandinfo.name}}{{#}else{}}无{{#}}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6766','122','{field: \'unit\', title: \'商品单位\', width: 120, align:\'center\',templet: \'<div>{{#if(d.goodsinfo.unitinfo){}}{{d.goodsinfo.unitinfo.name}}{{#}else{}}无{{#}}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6767','122','{field: \'buy\', title: \'购货价格\', width: 120, align:\'center\',templet: \'<div>{{d.goodsinfo.buy}}</div>\'}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6768','122','{field: \'sell\', title: \'销货价格\', width: 120, align:\'center\',templet: \'<div>{{d.goodsinfo.sell}}</div>\'}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6769','122','{field: \'retail\', title: \'零售价格\', width: 120, align:\'center\',templet: \'<div>{{d.goodsinfo.retail}}</div>\'}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6770','122','{field: \'integral\', title: \'兑换积分\', width: 120, align:\'center\',templet: \'<div>{{d.goodsinfo.integral}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6771','122','{field: \'code\', title: \'条形码\', width: 160, align:\'center\',templet: \'<div>{{d.goodsinfo.code}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6772','122','{field: \'location\', title: \'商品货位\', width: 120, align:\'center\',templet: \'<div>{{d.goodsinfo.location}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6773','122','{field: \'data\', title: \'备注信息\', width: 120, align:\'center\',templet: \'<div>{{d.goodsinfo.data}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6792','123','key//name||text//商品名称||data//goodsinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6793','123','key//attr||text//辅助属性||data//attr|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6794','123','key//warehouse||text//所属仓库||data//warehouseinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6795','123','key//nums||text//当前库存||data//nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6796','123','key//stocktip||text//库存阈值||data//goodsinfo|stocktip','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6797','123','key//batch||text//商品批次||data//batch','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6798','123','key//number||text//商品编号||data//goodsinfo|number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6799','123','key//spec||text//规格型号||data//goodsinfo|spec','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6800','123','key//class||text//商品分类||data//goodsinfo|classinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6801','123','key//brand||text//商品品牌||data//goodsinfo|brandinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6802','123','key//unit||text//商品单位||data//goodsinfo|unitinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6803','123','key//buy||text//购货价格||data//goodsinfo|buy','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6804','123','key//sell||text//销货价格||data//goodsinfo|sell','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6805','123','key//retail||text//零售价格||data//goodsinfo|retail','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6806','123','key//integral||text//兑换积分||data//goodsinfo|integral','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6807','123','key//code||text//条形码||data//goodsinfo|code','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6808','123','key//location||text//商品货位||data//goodsinfo|location','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('6809','123','key//data||text//备注信息||data//goodsinfo|data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7154','125','key//name||text//商品名称||data//goodsinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7155','125','key//attr||text//辅助属性||data//attr|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7156','125','key//warehouse||text//所属仓库||data//warehouseinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7157','125','key//nums||text//当前库存||data//nums','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7158','125','key//stock||text//盘点数量||data//stock','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7159','125','key//batch||text//商品批次||data//batch','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7160','125','key//number||text//商品编号||data//goodsinfo|number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7161','125','key//spec||text//规格型号||data//goodsinfo|spec','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7162','125','key//class||text//商品分类||data//goodsinfo|classinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7163','125','key//brand||text//商品品牌||data//goodsinfo|brandinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7164','125','key//unit||text//商品单位||data//goodsinfo|unitinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7165','125','key//integral||text//兑换积分||data//goodsinfo|integral','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7166','125','key//code||text//条形码||data//goodsinfo|code','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7167','125','key//location||text//商品货位||data//goodsinfo|location','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7168','125','key//stocktip||text//库存阈值||data//goodsinfo|stocktip','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7169','125','key//retail_name||text//零售名称||data//goodsinfo|retail_name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7170','125','key//data||text//备注信息||data//goodsinfo|data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7260','127','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7261','127','{field: \'merchant\', title: \'所属商户\', width: 120, align:\'center\',templet: \'<div>{{d.merchantinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7262','127','{field: \'time\', title: \'单据日期\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7263','127','{field: \'number\', title: \'单据编号\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7264','127','{field: \'customer\', title: \'客户\', width: 120, align:\'center\',templet: \'<div>{{d.customerinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7265','127','{field: \'user\', title: \'制单人\', width: 120, align:\'center\',templet: \'<div>{{d.userinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7266','127','{field: \'type\', title: \'审核状态\', width: 120, align:\'center\',templet: \'<div>{{d.type.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7267','127','{field: \'data\', title: \'备注信息\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7268','127','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7321','128','key//merchant||text//所属商户||data//merchantinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7322','128','key//time||text//单据日期||data//time','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7323','128','key//number||text//单据编号||data//number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7324','128','key//customer||text//客户||data//customerinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7325','128','key//user||text//制单人||data//userinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7326','128','key//type||text//审核状态||data//type|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7327','128','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7337','129','key//name||text//结算账户||data//accountinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7338','129','key//total||text//结算金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7339','129','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7340','130','key//name||text//结算账户||data//accountinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7341','130','key//total||text//结算金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7342','130','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7370','131','name//结算账户ID||model//{name: \'set_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7371','131','name//操作||model//{name:\'set\',align:\"center\",width:60,sortable:false,formatter:set_formatter}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7372','131','name//结算账户||model//{name:\'account\',width:\'150px\',align:\"center\",editable:true,edittype:\"select\",editoptions:account_arr.jqgrid}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7373','131','name//结算金额||model//{name:\'total\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7374','131','name//备注信息||model//{name:\'data\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7375','132','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7376','132','{field: \'merchant\', title: \'所属商户\', width: 120, align:\'center\',templet: \'<div>{{d.merchantinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7377','132','{field: \'time\', title: \'单据日期\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7378','132','{field: \'number\', title: \'单据编号\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7379','132','{field: \'supplier\', title: \'供应商\', width: 120, align:\'center\',templet: \'<div>{{d.supplierinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7380','132','{field: \'user\', title: \'制单人\', width: 120, align:\'center\',templet: \'<div>{{d.userinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7381','132','{field: \'type\', title: \'审核状态\', width: 120, align:\'center\',templet: \'<div>{{d.type.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7382','132','{field: \'data\', title: \'备注信息\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7383','132','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7384','133','key//merchant||text//所属商户||data//merchantinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7385','133','key//time||text//单据日期||data//time','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7386','133','key//number||text//单据编号||data//number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7387','133','key//supplier||text//供应商||data//supplierinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7388','133','key//user||text//制单人||data//userinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7389','133','key//type||text//审核状态||data//type|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7390','133','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7391','134','key//name||text//结算账户||data//accountinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7392','134','key//total||text//结算金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7393','134','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7394','135','key//name||text//结算账户||data//accountinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7395','135','key//total||text//结算金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7396','135','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7424','136','name//结算账户ID||model//{name: \'set_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7425','136','name//操作||model//{name:\'set\',align:\"center\",width:60,sortable:false,formatter:set_formatter}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7426','136','name//结算账户||model//{name:\'account\',width:\'150px\',align:\"center\",editable:true,edittype:\"select\",editoptions:account_arr.jqgrid}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7427','136','name//结算金额||model//{name:\'total\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7428','136','name//备注信息||model//{name:\'data\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7429','137','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7430','137','{field: \'merchant\', title: \'所属商户\', width: 120, align:\'center\',templet: \'<div>{{d.merchantinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7431','137','{field: \'time\', title: \'单据日期\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7432','137','{field: \'number\', title: \'单据编号\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7433','137','{field: \'user\', title: \'制单人\', width: 120, align:\'center\',templet: \'<div>{{d.userinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7434','137','{field: \'type\', title: \'审核状态\', width: 120, align:\'center\',templet: \'<div>{{d.type.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7435','137','{field: \'data\', title: \'备注信息\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7436','137','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7437','138','key//merchant||text//所属商户||data//merchantinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7438','138','key//time||text//单据日期||data//time','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7439','138','key//number||text//单据编号||data//number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7440','138','key//user||text//制单人||data//userinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7441','138','key//type||text//审核状态||data//type|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7442','138','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7443','139','key//name||text//结算账户||data//accountinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7444','139','key//total||text//结算金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7445','139','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7446','140','key//name||text//结算账户||data//accountinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7447','140','key//total||text//结算金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7448','140','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7476','141','name//结算账户ID||model//{name: \'set_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7477','141','name//操作||model//{name:\'set\',align:\"center\",width:60,sortable:false,formatter:set_formatter}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7478','141','name//结算账户||model//{name:\'account\',width:\'150px\',align:\"center\",editable:true,edittype:\"select\",editoptions:account_arr.jqgrid}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7479','141','name//结算金额||model//{name:\'total\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7480','141','name//备注信息||model//{name:\'data\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7481','142','key//merchant||text//所属商户||data//merchantinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7482','142','key//time||text//单据日期||data//time','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7483','142','key//number||text//单据编号||data//number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7484','142','key//user||text//制单人||data//userinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7485','142','key//type||text//审核状态||data//type|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7486','142','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7487','143','key//name||text//结算账户||data//accountinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7488','143','key//total||text//结算金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7489','143','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7490','144','key//name||text//结算账户||data//accountinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7491','144','key//total||text//结算金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7492','144','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7493','145','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7494','145','{field: \'merchant\', title: \'所属商户\', width: 120, align:\'center\',templet: \'<div>{{d.merchantinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7495','145','{field: \'time\', title: \'单据日期\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7496','145','{field: \'number\', title: \'单据编号\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7497','145','{field: \'user\', title: \'制单人\', width: 120, align:\'center\',templet: \'<div>{{d.userinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7498','145','{field: \'type\', title: \'审核状态\', width: 120, align:\'center\',templet: \'<div>{{d.type.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7499','145','{field: \'data\', title: \'备注信息\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7500','145','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7545','126','name//结算账户ID||model//{name: \'set_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7546','126','name//操作||model//{name:\'set\',align:\"center\",width:60,sortable:false,formatter:set_formatter}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7547','126','name//结算账户||model//{name:\'account\',width:\'150px\',align:\"center\",editable:true,edittype:\"select\",editoptions:account_arr.jqgrid}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7548','126','name//结算金额||model//{name:\'total\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7549','126','name//备注信息||model//{name:\'data\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7550','146','name//调出结算账户ID||model//{name: \'set_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7551','146','name//调入结算账户ID||model//{name: \'toaccount_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7552','146','name//操作||model//{name:\'set\',align:\"center\",width:60,sortable:false,formatter:set_formatter}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7553','146','name//调出账户||model//{name:\'account\',width:\'150px\',align:\"center\",editable:true,edittype:\"select\",editoptions:account_arr.jqgrid}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7554','146','name//调入账户||model//{name:\'toaccount\',width:\'150px\',align:\"center\",editable:true,edittype:\"select\",editoptions:account_arr.jqgrid}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7555','146','name//调拨金额||model//{name:\'total\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7556','146','name//备注信息||model//{name:\'data\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7557','147','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7558','147','{field: \'merchant\', title: \'所属商户\', width: 120, align:\'center\',templet: \'<div>{{d.merchantinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7559','147','{field: \'time\', title: \'单据日期\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7560','147','{field: \'number\', title: \'单据编号\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7561','147','{field: \'user\', title: \'制单人\', width: 120, align:\'center\',templet: \'<div>{{d.userinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7562','147','{field: \'type\', title: \'审核状态\', width: 120, align:\'center\',templet: \'<div>{{d.type.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7563','147','{field: \'data\', title: \'备注信息\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7564','147','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7565','148','key//merchant||text//所属商户||data//merchantinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7566','148','key//time||text//单据日期||data//time','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7567','148','key//number||text//单据编号||data//number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7568','148','key//user||text//制单人||data//userinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7569','148','key//type||text//审核状态||data//type|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7570','148','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7571','149','key//account||text//调出账户||data//accountinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7572','149','key//toaccount||text//调入账户||data//toaccountinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7573','149','key//total||text//调拨金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7574','149','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7575','150','key//account||text//调出账户||data//accountinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7576','150','key//toaccount||text//调入账户||data//toaccountinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7577','150','key//total||text//调拨金额||data//total','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7578','150','key//data||text//备注信息||data//data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7579','6','{field: \'time\', title: \'操作时间\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7580','6','{field: \'type\', title: \'单据类型\', width: 120, align:\'center\',templet: \'<div>{{d.type.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7581','6','{field: \'number\', title: \'单据编号\', width: 200, align:\'center\',templet: \'<div>{{d.typedata.number}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7582','6','{field: \'set\', title: \'积分操作\', width: 120, align:\'center\',templet: \'<div>{{d.set.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7583','6','{field: \'integral\', title: \'本次积分\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7584','6','{field: \'number\', title: \'制单人\', width: 120, align:\'center\',templet: \'<div>{{d.userinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7585','6','{field: \'data\', title: \'备注信息\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7882','151','{field: \'goods\', title: \'商品ID\',hide:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7883','151','{field: \'name\', title: \'商品名称\',width:200, align:\'center\',fixed: \'left\',templet: \'<div>{{d.goodsinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7884','151','{field: \'img\', title: \'商品图像\', width: 150,align:\'center\',templet: \'<div><img src=\"{{d.goodsinfo.img}}\"/></div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7885','151','{field: \'attr\', title: \'辅助属性\', width: 120, align:\'center\',templet: \'<div>{{d.attr.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7886','151','{field: \'warehouse\', title: \'所属仓库\', width: 120, align:\'center\',templet: \'<div>{{d.warehouseinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7887','151','{field: \'nums\', title: \'当前库存\', width: 150, align:\'center\',templet: \'<div>{{d.roominfo.nums}}</div>\'}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7888','151','{field: \'sale\', title: \'销货金额\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7889','151','{field: \'cashier\', title: \'零售金额\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7890','151','{field: \'sales_revenue\', title: \'销售收入\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7891','151','{field: \'sales_cost\', title: \'销售成本\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7892','151','{field: \'sales_maori\', title: \'销售毛利\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7893','151','{field: \'gross_interest_rate\', title: \'销售毛利率\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7894','151','{field: \'batch\', title: \'商品批次\', width: 120, align:\'center\'}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7895','151','{field: \'number\', title: \'商品编号\', width: 120, align:\'center\',templet: \'<div>{{d.goodsinfo.number}}</div>\'}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7896','151','{field: \'spec\', title: \'规格型号\', width: 120, align:\'center\',templet: \'<div>{{d.goodsinfo.spec}}</div>\'}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7897','151','{field: \'class\', title: \'商品分类\', width: 120, align:\'center\',templet: \'<div>{{#if(d.goodsinfo.classinfo){}}{{d.goodsinfo.classinfo.name}}{{#}else{}}无{{#}}}</div>\'}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7898','151','{field: \'brand\', title: \'商品品牌\', width: 120, align:\'center\',templet: \'<div>{{#if(d.goodsinfo.brandinfo){}}{{d.goodsinfo.brandinfo.name}}{{#}else{}}无{{#}}}</div>\'}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7899','151','{field: \'unit\', title: \'商品单位\', width: 120, align:\'center\',templet: \'<div>{{#if(d.goodsinfo.unitinfo){}}{{d.goodsinfo.unitinfo.name}}{{#}else{}}无{{#}}}</div>\'}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7900','151','{field: \'integral\', title: \'兑换积分\', width: 120, align:\'center\',templet: \'<div>{{d.goodsinfo.integral}}</div>\'}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7901','151','{field: \'code\', title: \'条形码\', width: 160, align:\'center\',templet: \'<div>{{d.goodsinfo.code}}</div>\'}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7902','151','{field: \'location\', title: \'商品货位\', width: 120, align:\'center\',templet: \'<div>{{d.goodsinfo.location}}</div>\'}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7903','151','{field: \'stocktip\', title: \'库存阈值\', width: 120, align:\'center\',templet: \'<div>{{d.goodsinfo.stocktip}}</div>\'}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7904','151','{field: \'data\', title: \'备注信息\', width: 120, align:\'center\',templet: \'<div>{{d.goodsinfo.data}}</div>\'}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7905','152','key//name||text//商品名称||data//goodsinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7906','152','key//attr||text//辅助属性||data//attr|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7907','152','key//warehouse||text//所属仓库||data//warehouseinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7908','152','key//nums||text//当前库存||data//roominfo|nums','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7909','152','key//sale||text//销货金额||data//sale','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7910','152','key//cashier||text//零售金额||data//cashier','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7911','152','key//sales_revenue||text//销售收入||data//sales_revenue','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7912','152','key//sales_cost||text//销售成本||data//sales_cost','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7913','152','key//sales_maori||text//销售毛利||data//sales_maori','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7914','152','key//gross_interest_rate||text//销售毛利率||data//gross_interest_rate','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7915','152','key//batch||text//商品批次||data//batch','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7916','152','key//number||text//商品编号||data//goodsinfo|number','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7917','152','key//spec||text//规格型号||data//goodsinfo|spec','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7918','152','key//class||text//商品分类||data//goodsinfo|classinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7919','152','key//brand||text//商品分类||data//goodsinfo|brandinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7920','152','key//unit||text//商品单位||data//goodsinfo|unitinfo|name','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7921','152','key//integral||text//兑换积分||data//goodsinfo|integral','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7922','152','key//code||text//条形码||data//goodsinfo|code','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7923','152','key//location||text//商品货位||data//goodsinfo|location','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7924','152','key//stocktip||text//库存阈值||data//goodsinfo|stocktip','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('7925','152','key//data||text//备注信息||data//goodsinfo|data','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8121','155','key//name||text//商品名称||data//goodsinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8122','155','key//attr||text//辅助属性||data//roominfo|attr|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8123','155','key//code||text//串码||data//code','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8124','155','key//type||text//串码状态||data//type|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8175','156','{field: \'goods\', title: \'商品ID\',hide:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8176','156','{field: \'name\', title: \'商品名称\', width: 200, align:\'center\',templet: \'<div>{{d.goodsinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8177','156','{field: \'attr\', title: \'辅助属性\', width: 120, align:\'center\',templet: \'<div>{{d.roominfo.attr.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8178','156','{field: \'code\', title: \'串码\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8179','156','{field: \'type\', title: \'串码状态\', width: 120, align:\'center\',templet: \'<div>{{d.type.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8180','156','{field: \'set\', title: \'相关操作\', width: 120, align:\'center\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8187','157','{field: \'time\', title: \'单据时间\', width: 120, align:\'center\',templet: \'<div>{{d.typedata.time}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8188','157','{field: \'type\', title: \'单据类型\', width: 200, align:\'center\',templet: \'<div>{{d.type.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8189','157','{field: \'number\', title: \'单据编号\', width: 200, align:\'center\',templet: \'<div>{{d.typedata.number}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8196','158','key//time||text//单据日期||data//typedata|time','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8197','158','key//type||text//单据类型||data//type|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8198','158','key//number||text//单据编号||data//typedata|number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8227','160','{field: \'type\', title: \'单位类型\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8228','160','{field: \'name\', title: \'单位名称\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8229','160','{field: \'number\', title: \'单位编号\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8230','160','{field: \'money\', title: \'欠款金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8235','161','key//type||text//单据类型||data//type','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8236','161','key//name||text//单位名称||data//name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8237','161','key//number||text//单位编号||data//number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8238','161','key//money||text//欠款金额||data//money','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8239','153','{field: \'merchant\', title: \'所属商户\', width: 120, align:\'center\',templet: \'<div>{{d.merchantinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8240','153','{field: \'time\', title: \'单据日期\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8241','153','{field: \'type\', title: \'单据类型\', width: 120, align:\'center\',templet: \'<div>{{d.type.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8242','153','{field: \'number\', title: \'单据编号\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8243','153','{field: \'customer\', title: \'客户\', width: 120, align:\'center\',templet: \'<div>{{d.customerinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8244','153','{field: \'user\', title: \'制单人\', width: 120, align:\'center\',templet: \'<div>{{d.userinfo.name}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8245','153','{field: \'sales_revenue\', title: \'销售收入\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8246','153','{field: \'selling_cost\', title: \'销售成本\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8247','153','{field: \'gross_margin\', title: \'销售毛利\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8248','153','{field: \'gross_profit_margin\', title: \'毛利率\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8249','153','{field: \'discount\', title: \'优惠金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8250','153','{field: \'net_profit\', title: \'销售净利润\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8251','153','{field: \'net_profit_margin\', title: \'净利润率\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8252','153','{field: \'receivable\', title: \'实际金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8253','153','{field: \'money\', title: \'实收金额\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8254','153','{field: \'data\', title: \'单据备注\', width: 200, align:\'center\',templet: \'<div>{{d.typedata.data}}</div>\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8255','154','key//merchant||text//所属商户||data//merchantinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8256','154','key//time||text//单据日期||data//time','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8257','154','key//type||text//单据类型||data//type|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8258','154','key//number||text//单据编号||data//number','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8259','154','key//customer||text//客户||data//customerinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8260','154','key//user||text//制单人||data//userinfo|name','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8261','154','key//sales_revenue||text//销售收入||data//sales_revenue','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8262','154','key//selling_cost||text//销售收入||data//selling_cost','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8263','154','key//gross_margin||text//销售毛利||data//gross_margin','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8264','154','key//gross_profit_margin||text//毛利率||data//gross_profit_margin','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8265','154','key//discount||text//优惠金额||data//discount','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8266','154','key//net_profit||text//销售净利润||data//net_profit','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8267','154','key//net_profit_margin||text//净利润率||data//net_profit_margin','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8268','154','key//receivable||text//实际金额||data//receivable','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8269','154','key//money||text//实收金额||data//money','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8270','154','key//data||text//单据备注||data//typedata|data','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8282','1','{type:\'checkbox\',fixed: \'left\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8283','1','{field: \'name\', title: \'商户名称\', width: 200, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8284','1','{field: \'number\', title: \'商户编号\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8285','1','{field: \'contacts\', title: \'联系人员\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8286','1','{field: \'tel\', title: \'联系电话\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8287','1','{field: \'add\', title: \'商户地址\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8288','1','{field: \'tax\', title: \'商户税号\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8289','1','{field: \'bank\', title: \'开户银行\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8290','1','{field: \'account\', title: \'对公账户\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8291','1','{field: \'data\', title: \'备注信息\', width: 120, align:\'center\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8292','1','{field: \'set\', title: \'相关操作\', width: 200, align:\'center\',fixed:\'right\',toolbar:\'#bar_info\'}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8313','31','name//商品ID||model//{name: \'set_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8314','31','name//仓库ID||model//{name: \'warehouse_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8315','31','name//属性标识||model//{name: \'attr_nod\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8316','31','name//操作||model//{name:\'set\',align:\"center\",width:60,sortable:false,formatter:set_formatter}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8317','31','name//商品信息<span class=\"sm_false\" onclick=\"set_sm(this);\">扫码枪</span>||model//{name:\'name\',index:\'name\',width:\'150px\',editable:true,edittype:\"custom\",editoptions:{custom_element:name_elem,custom_value:name_value}}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8318','31','name//辅助属性||model//{name:\'attr\',align:\"center\",editable:true,edittype:\"custom\",editoptions:{custom_element:attr_elem,custom_value:attr_value}}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8319','31','name//所入仓库<span onclick=\"set_warehouse();\">（批量）</span>||model//{name:\'warehouse\',width:\'150px\',align:\"center\",editable:true,edittype:\"select\",editoptions:warehouse_arr.jqgrid}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8320','31','name//商品批次||model//{name:\'batch\',align:\"center\",editable:true,hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8321','31','name//商品串码||model//{name:\'serial\',editable:true,edittype:\"custom\",editoptions:{custom_element:serial_elem,custom_value:serial_value},hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8322','31','name//数量||model//{name:\'nums\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8323','31','name//购货单价||model//{name:\'price\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8324','31','name//购货金额||model//{name:\'total\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8325','31','name//商品品牌||model//{name:\'brand\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8326','31','name//商品编号||model//{name:\'number\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8327','31','name//商品分类||model//{name:\'class\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8328','31','name//规格型号||model//{name:\'spec\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8329','31','name//条形码||model//{name:\'code\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8330','31','name//商品单位||model//{name:\'unit\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8331','31','name//库存预警||model//{name:\'stocktip\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8332','31','name//商品货位||model//{name:\'location\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8333','31','name//零售名称||model//{name:\'retail_name\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8334','31','name//备注信息||model//{name:\'data\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8335','124','name//仓储ID||model//{name: \'set_id\',hidden:true,formatter:function(cellvalue, options, row){return row.id}}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8336','124','name//商品ID||model//{name: \'goods_id\',hidden:true,formatter:function(cellvalue, options, row){return row.goods}}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8337','124','name//辅助属性标识||model//{name: \'attr_nod\',hidden:true,formatter:function(cellvalue, options, row){return row.attr.nod}}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8338','124','name//仓库ID||model//{name: \'warehouse_id\',hidden:true,formatter:function(cellvalue, options, row){return row.warehouse}}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8339','124','name//商品信息||model//{name:\'name\',align:\"center\",sortable:false,formatter:function(cellvalue, options, row){return row.goodsinfo.name}}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8340','124','name//辅助属性||model//{name:\'attr\',align:\"center\",sortable:false,formatter:function(cellvalue, options, row){return row.attr.name}}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8341','124','name//所属仓库||model//{name:\'warehouse\',align:\"center\",sortable:false,formatter:function(cellvalue, options, row){return row.warehouseinfo.name}}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8342','124','name//当前库存||model//{name:\'nums\',align:\"center\",sortable:false}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8343','124','name//盘点数量||model//{name:\'stock\',align:\"center\",editable:true,sortable:false}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8344','124','name//盘盈盘亏||model//{name:\'check\',align:\"center\",sortable:false}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8345','124','name//商品批次||model//{name:\'batch\',align:\"center\",sortable:false,hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8346','124','name//商品编号||model//{name:\'number\',align:\"center\",sortable:false,formatter:function(cellvalue, options, row){return row.goodsinfo.number}}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8347','124','name//规格型号||model//{name:\'spec\',align:\"center\",sortable:false,formatter:function(cellvalue, options, row){return row.goodsinfo.spec}}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8348','124','name//商品分类||model//{name:\'class\',align:\"center\",sortable:false,formatter:function(cellvalue, options, row){return row.goodsinfo.classinfo?row.goodsinfo.classinfo.name:\'\'}}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8349','124','name//商品品牌||model//{name:\'brand\',align:\"center\",sortable:false,formatter:function(cellvalue, options, row){return row.goodsinfo.brandinfo?row.goodsinfo.brandinfo.name:\'\'}}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8350','124','name//商品单位||model//{name:\'unit\',align:\"center\",sortable:false,formatter:function(cellvalue, options, row){return row.goodsinfo.unitinfo?row.goodsinfo.unitinfo.name:\'\'}}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8351','124','name//兑换积分||model//{name:\'integral\',align:\"center\",sortable:false,formatter:function(cellvalue, options, row){return row.goodsinfo.integral}}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8352','124','name//条形码||model//{name:\'code\',align:\"center\",sortable:false,formatter:function(cellvalue, options, row){return row.goodsinfo.code}}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8353','124','name//商品货位||model//{name:\'location\',align:\"center\",sortable:false,formatter:function(cellvalue, options, row){return row.goodsinfo.location}}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8354','124','name//预警阈值||model//{name:\'stocktip\',align:\"center\",sortable:false,formatter:function(cellvalue, options, row){return row.goodsinfo.stocktip}}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8355','124','name//零售名称||model//{name:\'retail_name\',align:\"center\",sortable:false,formatter:function(cellvalue, options, row){return row.goodsinfo.retail_name}}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8356','124','name//备注信息||model//{name:\'data\',align:\"center\",sortable:false,formatter:function(cellvalue, options, row){return row.goodsinfo.data}}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8357','113','name//仓储ID||model//{name: \'set_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8358','113','name//商品ID||model//{name: \'goods_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8359','113','name//仓库ID||model//{name: \'warehouse_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8360','113','name//串码详情||model//{name: \'serial_info\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8361','113','name//操作||model//{name:\'set\',align:\"center\",width:60,sortable:false,formatter:set_formatter}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8362','113','name//商品信息<span class=\"sm_false\" onclick=\"set_sm(this);\">扫码枪</span>||model//{name:\'name\',index:\'name\',width:\'150px\',editable:true,edittype:\"custom\",editoptions:{custom_element:name_elem,custom_value:name_value}}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8363','113','name//辅助属性||model//{name:\'attr\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8364','113','name//所属仓库||model//{name:\'warehouse\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8365','113','name//当前库存||model//{name:\'stock\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8366','113','name//商品串码||model//{name:\'serial\',editable:true,edittype:\"custom\",editoptions:{custom_element:serial_elem,custom_value:serial_value},hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8367','113','name//数量||model//{name:\'nums\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8368','113','name//商品批次||model//{name:\'batch\',align:\"center\",hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8369','113','name//商品品牌||model//{name:\'brand\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8370','113','name//商品编号||model//{name:\'number\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8371','113','name//商品分类||model//{name:\'class\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8372','113','name//规格型号||model//{name:\'spec\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8373','113','name//条形码||model//{name:\'code\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8374','113','name//商品单位||model//{name:\'unit\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8375','113','name//库存预警||model//{name:\'stocktip\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8376','113','name//商品货位||model//{name:\'location\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8377','113','name//零售名称||model//{name:\'retail_name\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8378','113','name//备注信息||model//{name:\'data\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8379','108','name//商品ID||model//{name: \'set_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8380','108','name//仓库ID||model//{name: \'warehouse_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8381','108','name//属性标识||model//{name: \'attr_nod\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8382','108','name//操作||model//{name:\'set\',align:\"center\",width:60,sortable:false,formatter:set_formatter}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8383','108','name//商品信息<span class=\"sm_false\" onclick=\"set_sm(this);\">扫码枪</span>||model//{name:\'name\',index:\'name\',width:\'150px\',editable:true,edittype:\"custom\",editoptions:{custom_element:name_elem,custom_value:name_value}}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8384','108','name//辅助属性||model//{name:\'attr\',align:\"center\",editable:true,edittype:\"custom\",editoptions:{custom_element:attr_elem,custom_value:attr_value}}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8385','108','name//所入仓库<span onclick=\"set_warehouse();\">（批量）</span>||model//{name:\'warehouse\',width:\'150px\',align:\"center\",editable:true,edittype:\"select\",editoptions:warehouse_arr.jqgrid}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8386','108','name//商品批次||model//{name:\'batch\',align:\"center\",editable:true,hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8387','108','name//商品串码||model//{name:\'serial\',editable:true,edittype:\"custom\",editoptions:{custom_element:serial_elem,custom_value:serial_value},hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8388','108','name//数量||model//{name:\'nums\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8389','108','name//商品品牌||model//{name:\'brand\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8390','108','name//商品编号||model//{name:\'number\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8391','108','name//商品分类||model//{name:\'class\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8392','108','name//规格型号||model//{name:\'spec\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8393','108','name//条形码||model//{name:\'code\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8394','108','name//商品单位||model//{name:\'unit\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8395','108','name//库存预警||model//{name:\'stocktip\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8396','108','name//商品货位||model//{name:\'location\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8397','108','name//零售名称||model//{name:\'retail_name\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8398','108','name//备注信息||model//{name:\'data\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8399','103','name//仓储ID||model//{name: \'set_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8400','103','name//商品ID||model//{name: \'goods_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8401','103','name//仓库ID||model//{name: \'warehouse_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8402','103','name//调拨仓库ID||model//{name: \'towarehouse_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8403','103','name//串码详情||model//{name: \'serial_info\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8404','103','name//操作||model//{name:\'set\',align:\"center\",width:60,sortable:false,formatter:set_formatter}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8405','103','name//商品信息<span class=\"sm_false\" onclick=\"set_sm(this);\">扫码枪</span>||model//{name:\'name\',index:\'name\',width:\'150px\',editable:true,edittype:\"custom\",editoptions:{custom_element:name_elem,custom_value:name_value}}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8406','103','name//辅助属性||model//{name:\'attr\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8407','103','name//所属仓库||model//{name:\'warehouse\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8408','103','name//当前库存||model//{name:\'stock\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8409','103','name//商品串码||model//{name:\'serial\',editable:true,edittype:\"custom\",editoptions:{custom_element:serial_elem,custom_value:serial_value},hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8410','103','name//调拨数量||model//{name:\'nums\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8411','103','name//调拨仓库<span onclick=\"set_towarehouse();\">（批量）</span>||model//{name:\'towarehouse\',width:\'150px\',align:\"center\",editable:true,edittype:\"select\",editoptions:warehouse_arr.jqgrid}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8412','103','name//商品批次||model//{name:\'batch\',align:\"center\",hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8413','103','name//商品品牌||model//{name:\'brand\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8414','103','name//商品编号||model//{name:\'number\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8415','103','name//商品分类||model//{name:\'class\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8416','103','name//规格型号||model//{name:\'spec\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8417','103','name//条形码||model//{name:\'code\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8418','103','name//商品单位||model//{name:\'unit\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8419','103','name//库存预警||model//{name:\'stocktip\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8420','103','name//商品货位||model//{name:\'location\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8421','103','name//零售名称||model//{name:\'retail_name\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8422','103','name//备注信息||model//{name:\'data\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8423','97','name//仓储ID||model//{name: \'set_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8424','97','name//商品ID||model//{name: \'goods_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8425','97','name//仓库ID||model//{name: \'warehouse_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8426','97','name//串码详情||model//{name: \'serial_info\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8427','97','name//操作||model//{name:\'set\',align:\"center\",width:60,sortable:false,formatter:set_formatter}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8428','97','name//商品信息<span class=\"sm_false\" onclick=\"set_sm(this);\">扫码枪</span>||model//{name:\'name\',index:\'name\',width:\'150px\',editable:true,edittype:\"custom\",editoptions:{custom_element:name_elem,custom_value:name_value}}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8429','97','name//辅助属性||model//{name:\'attr\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8430','97','name//所属仓库||model//{name:\'warehouse\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8431','97','name//当前库存||model//{name:\'stock\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8432','97','name//商品串码||model//{name:\'serial\',editable:true,edittype:\"custom\",editoptions:{custom_element:serial_elem,custom_value:serial_value},hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8433','97','name//数量||model//{name:\'nums\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8434','97','name//兑换积分||model//{name:\'integral\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8435','97','name//总积分||model//{name:\'allintegral\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8436','97','name//商品批次||model//{name:\'batch\',align:\"center\",hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8437','97','name//商品品牌||model//{name:\'brand\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8438','97','name//商品编号||model//{name:\'number\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8439','97','name//商品分类||model//{name:\'class\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8440','97','name//规格型号||model//{name:\'spec\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8441','97','name//条形码||model//{name:\'code\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8442','97','name//商品单位||model//{name:\'unit\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8443','97','name//库存预警||model//{name:\'stocktip\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8444','97','name//商品货位||model//{name:\'location\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8445','97','name//零售名称||model//{name:\'retail_name\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8446','97','name//备注信息||model//{name:\'data\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8447','84','name//仓储ID||model//{name: \'set_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8448','84','name//商品ID||model//{name: \'goods_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8449','84','name//仓库ID||model//{name: \'warehouse_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8450','84','name//串码详情||model//{name: \'serial_info\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8451','84','name//操作||model//{name:\'set\',align:\"center\",width:60,sortable:false,formatter:set_formatter}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8452','84','name//商品信息<span class=\"sm_false\" onclick=\"set_sm(this);\">扫码枪</span>||model//{name:\'name\',index:\'name\',width:\'150px\',editable:true,edittype:\"custom\",editoptions:{custom_element:name_elem,custom_value:name_value}}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8453','84','name//辅助属性||model//{name:\'attr\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8454','84','name//所属仓库||model//{name:\'warehouse\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8455','84','name//当前库存||model//{name:\'stock\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8456','84','name//商品串码||model//{name:\'serial\',editable:true,edittype:\"custom\",editoptions:{custom_element:serial_elem,custom_value:serial_value},hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8457','84','name//数量||model//{name:\'nums\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8458','84','name//退货单价||model//{name:\'price\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8459','84','name//退货金额||model//{name:\'total\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8460','84','name//商品批次||model//{name:\'batch\',align:\"center\",hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8461','84','name//商品品牌||model//{name:\'brand\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8462','84','name//商品编号||model//{name:\'number\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8463','84','name//商品分类||model//{name:\'class\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8464','84','name//规格型号||model//{name:\'spec\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8465','84','name//条形码||model//{name:\'code\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8466','84','name//商品单位||model//{name:\'unit\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8467','84','name//库存预警||model//{name:\'stocktip\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8468','84','name//商品货位||model//{name:\'location\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8469','84','name//零售名称||model//{name:\'retail_name\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8470','84','name//备注信息||model//{name:\'data\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8471','78','<div class=\"layui-form-item\"><label class=\"layui-form-label\">商品名称</label><div class=\"layui-input-block\"><input type=\"text\"class=\"layui-input\"source=\"goodsinfo|name\"disabled></div></div>','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8472','78','<div class=\"layui-form-item\"><label class=\"layui-form-label\">辅助属性</label><div class=\"layui-input-block\"><input type=\"text\"class=\"layui-input\"source=\"attr|name\"disabled></div></div>','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8473','78','<div class=\"layui-form-item\"><label class=\"layui-form-label\">所属仓库</label><div class=\"layui-input-block\"><input type=\"text\"class=\"layui-input\"source=\"warehouseinfo|name\"disabled></div></div>','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8474','78','<div class=\"layui-form-item\"><label class=\"layui-form-label\">当前库存</label><div class=\"layui-input-block\"><input type=\"text\"class=\"layui-input\"source=\"nums\"disabled></div></div>','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8475','78','<div class=\"layui-form-item\"><label class=\"layui-form-label\">商品串码</label><div class=\"layui-input-block\"><select id=\"set_serial\"class=\"layui-input\"multiple lay-ignore></select></div></div>','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8476','78','<div class=\"layui-form-item show_border\"><label class=\"layui-form-label\">数量</label><div class=\"layui-input-block\"><input type=\"text\"id=\"set_nums\"class=\"layui-input\"source=\"set_nums\"></div></div>','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8477','78','<div class=\"layui-form-item show_border\"><label class=\"layui-form-label\">零售单价</label><div class=\"layui-input-block\"><input type=\"text\"id=\"set_price\"class=\"layui-input\"source=\"set_price\"></div></div>','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8478','78','<div class=\"layui-form-item\"><label class=\"layui-form-label\">折扣</label><div class=\"layui-input-block\"><input type=\"text\"id=\"set_discount\"class=\"layui-input\"source=\"set_discount\"></div></div>','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8479','78','<div class=\"layui-form-item\"><label class=\"layui-form-label\">零售金额</label><div class=\"layui-input-block\"><input type=\"text\"id=\"set_total\"class=\"layui-input total\"source=\"set_total\"disabled></div></div>','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8480','78','<div class=\"layui-form-item\"><label class=\"layui-form-label\">商品批次</label><div class=\"layui-input-block\"><input type=\"text\"class=\"layui-input\"source=\"batch\"disabled></div></div>','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8481','78','<div class=\"layui-form-item\"><label class=\"layui-form-label\">商品品牌</label><div class=\"layui-input-block\"><input type=\"text\"class=\"layui-input\"source=\"goodsinfo|brandinfo|name\"disabled></div></div>','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8482','78','<div class=\"layui-form-item\"><label class=\"layui-form-label\">商品编号</label><div class=\"layui-input-block\"><input type=\"text\"class=\"layui-input\"source=\"goodsinfo|number\"disabled></div></div>','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8483','78','<div class=\"layui-form-item\"><label class=\"layui-form-label\">商品分类</label><div class=\"layui-input-block\"><input type=\"text\"class=\"layui-input\"source=\"goodsinfo|classinfo|name\"disabled></div></div>','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8484','78','<div class=\"layui-form-item\"><label class=\"layui-form-label\">规格型号</label><div class=\"layui-input-block\"><input type=\"text\"class=\"layui-input\"source=\"goodsinfo|spec\"disabled></div></div>','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8485','78','<div class=\"layui-form-item\"><label class=\"layui-form-label\">条形码</label><div class=\"layui-input-block\"><input type=\"text\"class=\"layui-input\"source=\"goodsinfo|code\"disabled></div></div>','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8486','78','<div class=\"layui-form-item\"><label class=\"layui-form-label\">商品单位</label><div class=\"layui-input-block\"><input type=\"text\"class=\"layui-input\"source=\"goodsinfo|unitinfo|name\"disabled></div></div>','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8487','78','<div class=\"layui-form-item\"><label class=\"layui-form-label\">库存预警</label><div class=\"layui-input-block\"><input type=\"text\"class=\"layui-input\"source=\"goodsinfo|stocktip\"disabled></div></div>','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8488','78','<div class=\"layui-form-item\"><label class=\"layui-form-label\">商品货位</label><div class=\"layui-input-block\"><input type=\"text\"class=\"layui-input\"source=\"goodsinfo|location\"disabled></div></div>','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8489','78','<div class=\"layui-form-item\"><label class=\"layui-form-label\">备注信息</label><div class=\"layui-input-block\"><input type=\"text\"id=\"data\"class=\"layui-input\"source=\"data\"></div></div>','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8490','71','name//仓储ID||model//{name: \'set_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8491','71','name//商品ID||model//{name: \'goods_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8492','71','name//仓库ID||model//{name: \'warehouse_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8493','71','name//串码详情||model//{name: \'serial_info\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8494','71','name//操作||model//{name:\'set\',align:\"center\",width:60,sortable:false,formatter:set_formatter}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8495','71','name//商品信息<span class=\"sm_false\" onclick=\"set_sm(this);\">扫码枪</span>||model//{name:\'name\',index:\'name\',width:\'150px\',editable:true,edittype:\"custom\",editoptions:{custom_element:name_elem,custom_value:name_value}}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8496','71','name//辅助属性||model//{name:\'attr\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8497','71','name//所属仓库||model//{name:\'warehouse\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8498','71','name//当前库存||model//{name:\'stock\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8499','71','name//商品串码||model//{name:\'serial\',editable:true,edittype:\"custom\",editoptions:{custom_element:serial_elem,custom_value:serial_value},hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8500','71','name//数量||model//{name:\'nums\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8501','71','name//退货单价||model//{name:\'price\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8502','71','name//退货金额||model//{name:\'total\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8503','71','name//商品批次||model//{name:\'batch\',align:\"center\",hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8504','71','name//商品品牌||model//{name:\'brand\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8505','71','name//商品编号||model//{name:\'number\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8506','71','name//商品分类||model//{name:\'class\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8507','71','name//规格型号||model//{name:\'spec\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8508','71','name//条形码||model//{name:\'code\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8509','71','name//商品单位||model//{name:\'unit\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8510','71','name//库存预警||model//{name:\'stocktip\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8511','71','name//商品货位||model//{name:\'location\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8512','71','name//零售名称||model//{name:\'retail_name\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8513','71','name//备注信息||model//{name:\'data\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8514','64','name//仓储ID||model//{name: \'set_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8515','64','name//商品ID||model//{name: \'goods_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8516','64','name//仓库ID||model//{name: \'warehouse_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8517','64','name//串码详情||model//{name: \'serial_info\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8518','64','name//操作||model//{name:\'set\',align:\"center\",width:60,sortable:false,formatter:set_formatter}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8519','64','name//商品信息<span class=\"sm_false\" onclick=\"set_sm(this);\">扫码枪</span>||model//{name:\'name\',index:\'name\',width:\'150px\',editable:true,edittype:\"custom\",editoptions:{custom_element:name_elem,custom_value:name_value}}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8520','64','name//辅助属性||model//{name:\'attr\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8521','64','name//所属仓库||model//{name:\'warehouse\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8522','64','name//当前库存||model//{name:\'stock\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8523','64','name//商品串码||model//{name:\'serial\',editable:true,edittype:\"custom\",editoptions:{custom_element:serial_elem,custom_value:serial_value},hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8524','64','name//数量||model//{name:\'nums\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8525','64','name//销货单价||model//{name:\'price\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8526','64','name//折扣||model//{name:\'discount\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8527','64','name//销货金额||model//{name:\'total\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8528','64','name//商品批次||model//{name:\'batch\',align:\"center\",hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8529','64','name//商品品牌||model//{name:\'brand\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8530','64','name//商品编号||model//{name:\'number\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8531','64','name//商品分类||model//{name:\'class\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8532','64','name//规格型号||model//{name:\'spec\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8533','64','name//条形码||model//{name:\'code\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8534','64','name//商品单位||model//{name:\'unit\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8535','64','name//库存预警||model//{name:\'stocktip\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8536','64','name//商品货位||model//{name:\'location\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8537','64','name//零售名称||model//{name:\'retail_name\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8538','64','name//备注信息||model//{name:\'data\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8539','58','name//存储ID||model//{name: \'set_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8540','58','name//仓库ID||model//{name: \'warehouse_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8541','58','name//商品信息||model//{name:\'name\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8542','58','name//辅助属性||model//{name:\'attr\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8543','58','name//所入仓库<span onclick=\"set_warehouse();\">（批量）</span>||model//{name:\'warehouse\',width:\'150px\',align:\"center\",editable:true,edittype:\"select\",editoptions:warehouse_arr.jqgrid}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8544','58','name//商品批次||model//{name:\'batch\',align:\"center\",editable:true,hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8545','58','name//商品串码||model//{name:\'serial\',editable:true,edittype:\"custom\",editoptions:{custom_element:serial_elem,custom_value:serial_value},hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8546','58','name//数量||model//{name:\'nums\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8547','58','name//采购单价||model//{name:\'price\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8548','58','name//采购金额||model//{name:\'total\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8549','58','name//商品品牌||model//{name:\'brand\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8550','58','name//商品编号||model//{name:\'number\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8551','58','name//商品分类||model//{name:\'class\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8552','58','name//规格型号||model//{name:\'spec\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8553','58','name//条形码||model//{name:\'code\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8554','58','name//商品单位||model//{name:\'unit\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8555','58','name//库存预警||model//{name:\'stocktip\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8556','58','name//商品货位||model//{name:\'location\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8557','58','name//零售名称||model//{name:\'retail_name\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8558','58','name//备注信息||model//{name:\'data\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8559','53','name//存储ID||model//{name: \'set_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8560','53','name//仓库ID||model//{name: \'warehouse_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8561','53','name//商品信息||model//{name:\'name\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8562','53','name//辅助属性||model//{name:\'attr\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8563','53','name//所入仓库<span onclick=\"set_warehouse();\">（批量）</span>||model//{name:\'warehouse\',width:\'150px\',align:\"center\",editable:true,edittype:\"select\",editoptions:warehouse_arr.jqgrid}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8564','53','name//商品批次||model//{name:\'batch\',align:\"center\",editable:true,hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8565','53','name//商品串码||model//{name:\'serial\',editable:true,edittype:\"custom\",editoptions:{custom_element:serial_elem,custom_value:serial_value},hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8566','53','name//总数量||model//{name:\'allnums\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8567','53','name//剩余数量||model//{name:\'surplusnums\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8568','53','name//本次数量||model//{name:\'nums\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8569','53','name//采购单价||model//{name:\'price\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8570','53','name//采购金额||model//{name:\'total\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8571','53','name//商品品牌||model//{name:\'brand\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8572','53','name//商品编号||model//{name:\'number\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8573','53','name//商品分类||model//{name:\'class\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8574','53','name//规格型号||model//{name:\'spec\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8575','53','name//条形码||model//{name:\'code\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8576','53','name//商品单位||model//{name:\'unit\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8577','53','name//库存预警||model//{name:\'stocktip\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8578','53','name//商品货位||model//{name:\'location\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8579','53','name//零售名称||model//{name:\'retail_name\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8580','53','name//备注信息||model//{name:\'data\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8581','47','name//商品ID||model//{name: \'set_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8582','47','name//属性标识||model//{name: \'attr_nod\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8583','47','name//操作||model//{name:\'set\',align:\"center\",width:60,sortable:false,formatter:set_formatter}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8584','47','name//商品信息<span class=\"sm_false\" onclick=\"set_sm(this);\">扫码枪</span>||model//{name:\'name\',index:\'name\',width:\'150px\',editable:true,edittype:\"custom\",editoptions:{custom_element:name_elem,custom_value:name_value}}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8585','47','name//辅助属性||model//{name:\'attr\',align:\"center\",editable:true,edittype:\"custom\",editoptions:{custom_element:attr_elem,custom_value:attr_value}}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8586','47','name//数量||model//{name:\'nums\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8587','47','name//商品品牌||model//{name:\'brand\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8588','47','name//商品编号||model//{name:\'number\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8589','47','name//商品分类||model//{name:\'class\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8590','47','name//规格型号||model//{name:\'spec\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8591','47','name//条形码||model//{name:\'code\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8592','47','name//商品单位||model//{name:\'unit\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8593','47','name//库存预警||model//{name:\'stocktip\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8594','47','name//商品货位||model//{name:\'location\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8595','47','name//零售名称||model//{name:\'retail_name\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8596','47','name//备注信息||model//{name:\'data\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8597','39','name//仓储ID||model//{name: \'set_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8598','39','name//商品ID||model//{name: \'goods_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8599','39','name//仓库ID||model//{name: \'warehouse_id\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8600','39','name//串码详情||model//{name: \'serial_info\',hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8601','39','name//操作||model//{name:\'set\',align:\"center\",width:60,sortable:false,formatter:set_formatter}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8602','39','name//商品信息<span class=\"sm_false\" onclick=\"set_sm(this);\">扫码枪</span>||model//{name:\'name\',index:\'name\',width:\'150px\',editable:true,edittype:\"custom\",editoptions:{custom_element:name_elem,custom_value:name_value}}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8603','39','name//辅助属性||model//{name:\'attr\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8604','39','name//所属仓库||model//{name:\'warehouse\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8605','39','name//当前库存||model//{name:\'stock\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8606','39','name//商品串码||model//{name:\'serial\',editable:true,edittype:\"custom\",editoptions:{custom_element:serial_elem,custom_value:serial_value},hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8607','39','name//数量||model//{name:\'nums\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8608','39','name//退货单价||model//{name:\'price\',align:\"center\",editable:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8609','39','name//退货金额||model//{name:\'total\',align:\"center\"}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8610','39','name//商品批次||model//{name:\'batch\',align:\"center\",hidden:true}','1');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8611','39','name//商品品牌||model//{name:\'brand\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8612','39','name//商品编号||model//{name:\'number\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8613','39','name//商品分类||model//{name:\'class\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8614','39','name//规格型号||model//{name:\'spec\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8615','39','name//条形码||model//{name:\'code\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8616','39','name//商品单位||model//{name:\'unit\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8617','39','name//库存预警||model//{name:\'stocktip\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8618','39','name//商品货位||model//{name:\'location\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8619','39','name//零售名称||model//{name:\'retail_name\',align:\"center\"}','0');
INSERT INTO `is_formfieldinfo` (`id`,`pid`,`info`,`show`) VALUES ('8620','39','name//备注信息||model//{name:\'data\',align:\"center\",editable:true}','1');

-- ----------------------------
-- Table structure for is_gatherclass
-- ----------------------------
DROP TABLE IF EXISTS `is_gatherclass`;
CREATE TABLE `is_gatherclass` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `merchant` int(11) NOT NULL COMMENT '所属商户',
  `customer` int(11) NOT NULL COMMENT '客户ID',
  `time` int(11) NOT NULL COMMENT '单据时间',
  `number` varchar(32) NOT NULL COMMENT '单据编号',
  `user` int(11) NOT NULL COMMENT '制单人',
  `file` varchar(128) DEFAULT '' COMMENT '单据附件',
  `data` varchar(128) DEFAULT '' COMMENT '备注信息',
  `type` tinyint(1) NOT NULL COMMENT '审核状态[0:未审核|1:已审核]',
  `auditinguser` int(11) NOT NULL COMMENT '审核人',
  `auditingtime` int(11) NOT NULL COMMENT '审核时间',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `merchant_customer_user_type` (`merchant`,`customer`,`user`,`type`),
  KEY `time_number_user` (`time`,`number`,`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收款单';
-- ----------------------------
-- Records of is_gatherclass
-- ----------------------------

-- ----------------------------
-- Table structure for is_gatherinfo
-- ----------------------------
DROP TABLE IF EXISTS `is_gatherinfo`;
CREATE TABLE `is_gatherinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '所属ID',
  `account` int(11) NOT NULL COMMENT '资金账户ID',
  `total` decimal(10,2) NOT NULL COMMENT '结算金额',
  `data` varchar(128) DEFAULT '' COMMENT '备注',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `pid_account` (`pid`,`account`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收款详情表';
-- ----------------------------
-- Records of is_gatherinfo
-- ----------------------------

-- ----------------------------
-- Table structure for is_goods
-- ----------------------------
DROP TABLE IF EXISTS `is_goods`;
CREATE TABLE `is_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL COMMENT '商品名称',
  `py` varchar(32) NOT NULL COMMENT '首拼字母',
  `number` varchar(32) DEFAULT '' COMMENT '商品编号',
  `spec` varchar(32) DEFAULT '' COMMENT '规格型号',
  `class` int(11) NOT NULL COMMENT '商品分类',
  `brand` int(11) NOT NULL COMMENT '商品品牌',
  `unit` int(11) NOT NULL COMMENT '商品单位',
  `buy` decimal(10,2) DEFAULT '0.00' COMMENT '购货价格',
  `sell` decimal(10,2) DEFAULT '0.00' COMMENT '销货价格',
  `retail` decimal(10,2) DEFAULT '0.00' COMMENT '零售价格',
  `integral` decimal(10,2) DEFAULT '0.00' COMMENT '兑换积分',
  `code` varchar(32) DEFAULT '' COMMENT '条形码',
  `warehouse` int(11) NOT NULL COMMENT '默认仓库',
  `location` varchar(32) DEFAULT '' COMMENT '商品货位',
  `stocktip` decimal(10,2) DEFAULT '0.00' COMMENT '库存阈值',
  `retail_name` varchar(64) DEFAULT '' COMMENT '零售名称',
  `imgs` text COMMENT '商品图片',
  `details` text COMMENT '商品详情',
  `data` varchar(128) DEFAULT '' COMMENT '备注信息',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `name_py_number_code` (`name`,`py`,`number`,`code`),
  KEY `brand_unit_warehouse` (`brand`,`unit`,`warehouse`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品表';
-- ----------------------------
-- Records of is_goods
-- ----------------------------

-- ----------------------------
-- Table structure for is_goodsclass
-- ----------------------------
DROP TABLE IF EXISTS `is_goodsclass`;
CREATE TABLE `is_goodsclass` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '所属ID',
  `name` varchar(36) NOT NULL COMMENT '分类名称',
  `data` varchar(128) DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`id`),
  KEY `pid_name` (`pid`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='商品分类表';
-- ----------------------------
-- Records of is_goodsclass
-- ----------------------------
INSERT INTO `is_goodsclass` (`id`,`pid`,`name`,`data`) VALUES ('1','0','手机','手机');

-- ----------------------------
-- Table structure for is_integral
-- ----------------------------
DROP TABLE IF EXISTS `is_integral`;
CREATE TABLE `is_integral` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '所属ID',
  `set` tinyint(1) NOT NULL COMMENT '积分操作[0:积分减少|1:积分增加]',
  `integral` decimal(10,2) DEFAULT '0.00' COMMENT '本次积分',
  `type` int(11) NOT NULL COMMENT '来源类型[1:零售单|2:零售退货单|3:人工操作|4:积分兑换单]',
  `time` int(11) NOT NULL COMMENT '时间',
  `user` int(11) NOT NULL COMMENT '制单人',
  `class` int(11) NOT NULL COMMENT '类ID',
  `data` varchar(128) DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`id`),
  KEY `pid_type_user_class` (`pid`,`type`,`user`,`class`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户积分表';
-- ----------------------------
-- Records of is_integral
-- ----------------------------

-- ----------------------------
-- Table structure for is_itemorderbill
-- ----------------------------
DROP TABLE IF EXISTS `is_itemorderbill`;
CREATE TABLE `is_itemorderbill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '所属ID',
  `account` int(11) NOT NULL COMMENT '结算账户',
  `money` decimal(10,2) NOT NULL COMMENT '金额',
  `data` varchar(128) NOT NULL COMMENT '备注信息',
  `user` int(11) NOT NULL COMMENT '操作人',
  `time` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `pid_account_user` (`pid`,`account`,`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='服务对账单';
-- ----------------------------
-- Records of is_itemorderbill
-- ----------------------------

-- ----------------------------
-- Table structure for is_itemorderclass
-- ----------------------------
DROP TABLE IF EXISTS `is_itemorderclass`;
CREATE TABLE `is_itemorderclass` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `merchant` int(11) NOT NULL COMMENT '所属商户',
  `customer` int(11) NOT NULL COMMENT '客户ID',
  `time` int(11) NOT NULL COMMENT '单据时间',
  `number` varchar(32) NOT NULL COMMENT '单据编号',
  `total` decimal(10,2) NOT NULL COMMENT '单据金额',
  `actual` decimal(10,2) NOT NULL COMMENT '实际金额',
  `money` decimal(10,2) NOT NULL COMMENT '实收金额',
  `user` int(11) NOT NULL COMMENT '制单人',
  `account` int(11) NOT NULL COMMENT '结算账户',
  `file` varchar(128) DEFAULT '' COMMENT '合同文件',
  `data` varchar(128) DEFAULT '' COMMENT '备注信息',
  `type` tinyint(1) NOT NULL COMMENT '审核状态[0:未审核|1:已审核]',
  `auditinguser` int(11) NOT NULL COMMENT '审核人',
  `auditingtime` int(11) NOT NULL COMMENT '审核时间',
  `billtype` tinyint(1) DEFAULT '-1' COMMENT '核销类型[-1:未处理|0:未核销|1:部分核销|2:已核销]',
  `more` int(11) NOT NULL COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `merchant_customer_user_account_type` (`merchant`,`customer`,`user`,`account`,`type`),
  KEY `time_number` (`time`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='服务订单';
-- ----------------------------
-- Records of is_itemorderclass
-- ----------------------------

-- ----------------------------
-- Table structure for is_itemorderinfo
-- ----------------------------
DROP TABLE IF EXISTS `is_itemorderinfo`;
CREATE TABLE `is_itemorderinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '所属ID',
  `serve` int(11) NOT NULL COMMENT '服务ID',
  `nums` decimal(10,2) NOT NULL COMMENT '数量',
  `price` decimal(10,2) NOT NULL COMMENT '单价',
  `total` decimal(10,2) NOT NULL COMMENT '总价',
  `data` varchar(128) DEFAULT '' COMMENT '备注',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `pid_item` (`pid`,`serve`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='服务订单详情表';
-- ----------------------------
-- Records of is_itemorderinfo
-- ----------------------------

-- ----------------------------
-- Table structure for is_log
-- ----------------------------
DROP TABLE IF EXISTS `is_log`;
CREATE TABLE `is_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `merchant` int(11) NOT NULL COMMENT '所属商户',
  `time` int(11) NOT NULL COMMENT '操作时间',
  `text` varchar(256) NOT NULL COMMENT '操作内容',
  `user` int(11) NOT NULL COMMENT '操作人',
  PRIMARY KEY (`id`),
  KEY `merchant_user` (`merchant`,`user`),
  KEY `time_text` (`time`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='操作日志表';
-- ----------------------------
-- Records of is_log
-- ----------------------------
INSERT INTO `is_log` (`id`,`merchant`,`time`,`text`,`user`) VALUES ('1','1','1691034476','登录系统成功','1');
INSERT INTO `is_log` (`id`,`merchant`,`time`,`text`,`user`) VALUES ('2','1','1691034778','新增职员信息[ liupeng ]','1');
INSERT INTO `is_log` (`id`,`merchant`,`time`,`text`,`user`) VALUES ('3','1','1691034818','设置功能权限[ liupeng ]','1');
INSERT INTO `is_log` (`id`,`merchant`,`time`,`text`,`user`) VALUES ('4','1','1691034860','导出供应商信息','1');
INSERT INTO `is_log` (`id`,`merchant`,`time`,`text`,`user`) VALUES ('5','1','1691035106','设置功能权限[ liupeng ]','1');

-- ----------------------------
-- Table structure for is_menu
-- ----------------------------
DROP TABLE IF EXISTS `is_menu`;
CREATE TABLE `is_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '所属菜单',
  `name` varchar(36) NOT NULL COMMENT '菜单名称',
  `more` varchar(36) DEFAULT '' COMMENT '扩展名称',
  `type` tinyint(4) NOT NULL COMMENT '菜单类型[0:独立菜单|1:附属菜单]',
  `jump` tinyint(4) NOT NULL COMMENT '跳转类型[0:iframe模式|1:独立窗口]',
  `url` varchar(128) DEFAULT '/' COMMENT '跳转网址',
  `sort` int(11) NOT NULL COMMENT '菜单排序',
  `ico` varchar(36) DEFAULT '' COMMENT '菜单图标',
  `root` varchar(36) DEFAULT '' COMMENT '权限标识',
  `data` varchar(256) DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`id`),
  KEY `pid_type_jump` (`pid`,`type`,`jump`),
  KEY `name_url` (`name`,`url`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8 COMMENT='菜单信息';
-- ----------------------------
-- Records of is_menu
-- ----------------------------
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('1','0','首页','','0','0','/index/main/home.html','1','layui-icon-home','','系统首页');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('2','0','购货','','0','0','/','2','nod-icon nod-icon-gouhuo','','购货组');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('3','2','购货单','','0','0','/index/purchase/main.html','1','','purchase_add','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('4','3','购货单报表','报表','1','0','/index/purchase/form.html','0','','purchase_form','购货单报表');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('5','85','采购订单','','0','0','/index/opurchase/main.html','1','','opurchase_add','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('6','5','采购订单报表','报表','1','0','/index/opurchase/form.html','0','','opurchase_form','采购订单报表');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('7','85','采购入库单','','0','0','/index/orpurchase/form.html','2','','rpurchase_add','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('8','7','采购入库单报表','报表','1','0','/index/rpurchase/form.html','0','','rpurchase_form','采购订单报表');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('9','2','购货退货单','','0','0','/index/repurchase/main.html','2','','repurchase_add','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('10','9','购货退货单报表','报表','1','0','/index/repurchase/form.html','0','','repurchase_form','购货退货单报表');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('11','0','销货','','0','0','/','4','nod-icon nod-icon-xiaohuo','','销货组');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('12','11','销货单','','0','0','/index/sale/main.html','1','','sale_add','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('13','12','销货单报表','报表','1','0','/index/sale/form.html','0','','sale_form','销货单报表');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('14','11','销货退货单','','0','0','/index/resale/main.html','2','','resale_add','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('15','14','销货退货单报表','报表','1','0','/index/resale/form.html','0','','resale_form','销货退货单报表');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('16','0','零售','','0','0','/','5','nod-icon nod-icon-lingshou','','零售组');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('17','16','零售单','','0','1','/index/cashier/main.html','1','','cashier_add','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('18','17','零售单报表','报表','1','0','/index/cashier/form.html','0','','cashier_form','零售单报表');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('19','16','零售退货单','','0','0','/index/recashier/main.html','2','','recashier_add','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('20','19','零售退货单报表','报表','1','0','/index/recashier/form.html','0','','recashier_form','零售退货单报表');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('21','16','服务单','','0','0','/index/itemorder/main.html','3','','itemorder_add','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('22','21','服务单报表','报表','1','0','/index/itemorder/form.html','0','','itemorder_form','服务单报表');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('23','16','积分兑换单','','0','0','/index/exchange/main.html','4','','exchange_add','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('24','23','积分兑换单报表','报表','1','0','/index/exchange/form.html','0','','exchange_form','积分兑换单报表');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('25','0','仓库','','0','0','/','6','nod-icon nod-icon-cangku','','仓库组');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('26','25','调拨单','','0','0','/index/allocation/main.html','4','','allocation_add','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('27','26','调拨单报表','报表','1','0','/index/allocation/form.html','0','','allocation_form','调拨单报表');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('28','25','库存查询','','0','0','/index/main/room.html','1','','room_add','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('29','25','库存盘点','','0','0','/index/main/room_check.html','2','','room_add','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('30','25','库存预警','','0','0','/index/main/room_warning.html','3','','room_add','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('31','25','其他入库单','','0','0','/index/otpurchase/main.html','5','','otpurchase_add','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('32','31','其他入库单报表','报表','1','0','/index/otpurchase/form.html','0','','otpurchase_form','其他入库单报表');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('33','25','其他出库单','','0','0','/index/otsale/main.html','6','','otsale_add','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('34','33','其他出库单报表','报表','1','0','/index/otsale/form.html','0','','otsale_form','其他出库单报表');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('35','0','资金','','0','0','/','7','nod-icon nod-icon-zijin','','资金组');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('36','35','收款单','','0','0','/index/gather/main.html','1','','gather_add','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('37','36','收款单报表','报表','1','0','/index/gather/form.html','0','','gather_form','收款单报表');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('38','35','付款单','','0','0','/index/payment/main.html','2','','payment_add','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('39','38','付款单报表','报表','1','0','/index/payment/form.html','0','','payment_form','付款单报表');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('40','35','其他收入单','','0','0','/index/otgather/main.html','3','','otgather_add','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('41','40','其他收入单报表','报表','1','0','/index/otgather/form.html','0','','otgather_form','其他收入单报表');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('42','35','其他支出单','','0','0','/index/otpayment/main.html','4','','otpayment_add','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('43','42','其他支出单报表','报表','1','0','/index/otpayment/form.html','0','','otpayment_form','其他支出单报表');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('44','35','资金调拨单','','0','0','/index/eft/main.html','5','','eft_add','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('45','44','资金调拨单报表','报表','1','0','/index/eft/form.html','0','','eft_form','资金调拨单报表');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('46','0','报表','','0','0','/','8','nod-icon nod-icon-pigform','','报表组');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('47','46','单据核销单','','0','0','/','1','','','单据对账单组');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('48','47','购货核销单','','0','0','/index/purchase/bill.html','1','','purchase_form','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('49','47','采购入库核销单','','0','0','/index/rpurchase/bill.html','3','','rpurchase_form','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('50','47','购货退货核销单','','0','0','/index/repurchase/bill.html','2','','repurchase_form','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('51','47','销货核销单','','0','0','/index/sale/bill.html','4','','sale_form','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('52','47','销货退货核销单','','0','0','/index/resale/bill.html','5','','resale_form','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('53','47','服务核销单','','0','0','/index/itemorder/bill.html','6','','itemorder_form','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('54','46','数据报表','','0','0','/','2','','','数据报表组');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('55','54','统计初始化','','0','0','/index/main/summary.html','1','','data_form','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('56','54','商品利润表','','0','0','/index/main/goods_profit.html','2','','data_form','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('57','54','销售利润表','','0','0','/index/main/bill_profit.html','3','','data_form','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('58','54','串码跟踪表','','0','0','/index/main/serial.html','4','','data_form','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('59','54','往来单位欠款表','','0','0','/index/main/arrears.html','5','','data_form','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('60','0','设置','','0','0','/','9','nod-icon nod-icon-jichu','','设置组');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('61','60','基础资料','','0','0','/','1','','','基础资料组');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('64','60','辅助资料','','0','0','/','2','','','辅助资料组');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('65','60','高级设置','','0','0','/','3','','','高级设置组');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('66','61','客户管理','','0','0','/index/customer/main.html','1','','basics_form','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('67','61','供应商管理','','0','0','/index/supplier/main.html','2','','basics_form','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('68','61','商品管理','','0','0','/index/goods/main.html','3','','basics_form','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('69','61','仓库管理','','0','0','/index/warehouse/main.html','4','','basics_form','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('70','61','资金账户','','0','0','/index/account/main.html','5','','basics_form','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('71','61','服务管理','','0','0','/index/serve/main.html','6','','basics_form','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('72','64','商品类别','','0','0','/index/goodsclass/main.html','1','','auxiliary_form','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('73','64','计量单位','','0','0','/index/unit/main.html','2','','auxiliary_form','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('74','64','品牌管理','','0','0','/index/brand/main.html','3','','auxiliary_form','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('75','64','条码管理','','0','0','/index/code/main.html','4','','auxiliary_form','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('76','64','辅助属性','','0','0','/index/attribute/main.html','5','','auxiliary_form','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('77','64','常用功能','','0','0','/index/often/main.html','6','','auxiliary_form','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('78','65','系统参数','','0','0','/index/sys/main.html','1','','senior_form','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('79','65','职员管理','','0','0','/index/user/main.html','2','','senior_form','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('80','65','数据备份','','0','0','/index/backup/main.html','3','','senior_form','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('81','65','权限设置','','0','0','/index/root/main.html','4','','senior_form','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('82','65','数据授权','','0','0','/index/auth/main.html','5','','senior_form','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('83','65','操作日志','','0','0','/index/log/main.html','6','','senior_form','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('84','61','商户管理','','0','0','/index/merchant/main.html','7','','basics_form','');
INSERT INTO `is_menu` (`id`,`pid`,`name`,`more`,`type`,`jump`,`url`,`sort`,`ico`,`root`,`data`) VALUES ('85','0','采购','','0','0','/','3','nod-icon nod-icon-caigou','','采购组');

-- ----------------------------
-- Table structure for is_merchant
-- ----------------------------
DROP TABLE IF EXISTS `is_merchant`;
CREATE TABLE `is_merchant` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL COMMENT '商户名称',
  `py` varchar(32) DEFAULT '' COMMENT '首拼信息',
  `number` varchar(32) DEFAULT '' COMMENT '商户编号',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '商户类型[0:主商户|1:附属商户]',
  `contacts` varchar(32) DEFAULT '' COMMENT '联系人员',
  `tel` varchar(32) DEFAULT '' COMMENT '联系电话',
  `add` varchar(64) DEFAULT '' COMMENT '商户地址',
  `tax` varchar(32) DEFAULT '' COMMENT '商户税号',
  `bank` varchar(64) DEFAULT '' COMMENT '开户银行',
  `account` varchar(32) DEFAULT '' COMMENT '对公账户',
  `data` varchar(128) DEFAULT '' COMMENT '备注信息',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='商户表';
-- ----------------------------
-- Records of is_merchant
-- ----------------------------
INSERT INTO `is_merchant` (`id`,`name`,`py`,`number`,`type`,`contacts`,`tel`,`add`,`tax`,`bank`,`account`,`data`,`more`) VALUES ('1','主商户','zsh','001','0','','','','','','','','');

-- ----------------------------
-- Table structure for is_often
-- ----------------------------
DROP TABLE IF EXISTS `is_often`;
CREATE TABLE `is_often` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL COMMENT '功能名称',
  `root` varchar(32) NOT NULL COMMENT '权限标识',
  `set` varchar(128) NOT NULL COMMENT '设置项',
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='常用功能表';
-- ----------------------------
-- Records of is_often
-- ----------------------------

-- ----------------------------
-- Table structure for is_opurchaseclass
-- ----------------------------
DROP TABLE IF EXISTS `is_opurchaseclass`;
CREATE TABLE `is_opurchaseclass` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `merchant` int(11) NOT NULL COMMENT '所属商户',
  `time` int(11) NOT NULL COMMENT '单据时间',
  `number` varchar(32) NOT NULL COMMENT '单据编号',
  `user` int(11) NOT NULL COMMENT '制单人',
  `file` varchar(128) DEFAULT '' COMMENT '单据附件',
  `data` varchar(128) DEFAULT '' COMMENT '备注信息',
  `type` tinyint(1) NOT NULL COMMENT '审核状态[0:未审核|1:已审核]',
  `auditinguser` int(11) NOT NULL COMMENT '审核人',
  `auditingtime` int(11) NOT NULL COMMENT '审核时间',
  `storage` tinyint(1) NOT NULL COMMENT '入库状态[0:未入库|1:部分入库|2:已入库]',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `merchant_user_type` (`merchant`,`user`,`type`),
  KEY `time_number` (`time`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采购订单';
-- ----------------------------
-- Records of is_opurchaseclass
-- ----------------------------

-- ----------------------------
-- Table structure for is_opurchaseinfo
-- ----------------------------
DROP TABLE IF EXISTS `is_opurchaseinfo`;
CREATE TABLE `is_opurchaseinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '所属ID',
  `goods` int(11) NOT NULL COMMENT '商品ID',
  `attr` varchar(32) DEFAULT '' COMMENT '辅助属性',
  `nums` decimal(10,2) NOT NULL COMMENT '采购总数量',
  `readynums` decimal(10,2) NOT NULL COMMENT '已采购数量',
  `data` varchar(128) DEFAULT '' COMMENT '备注',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `pid_goods` (`pid`,`goods`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采购订单详情表';
-- ----------------------------
-- Records of is_opurchaseinfo
-- ----------------------------

-- ----------------------------
-- Table structure for is_otgatherclass
-- ----------------------------
DROP TABLE IF EXISTS `is_otgatherclass`;
CREATE TABLE `is_otgatherclass` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `merchant` int(11) NOT NULL COMMENT '所属商户',
  `time` int(11) NOT NULL COMMENT '单据时间',
  `number` varchar(32) NOT NULL COMMENT '单据编号',
  `user` int(11) NOT NULL COMMENT '制单人',
  `file` varchar(128) DEFAULT '' COMMENT '单据附件',
  `data` varchar(128) DEFAULT '' COMMENT '备注信息',
  `type` tinyint(1) NOT NULL COMMENT '审核状态[0:未审核|1:已审核]',
  `auditinguser` int(11) NOT NULL COMMENT '审核人',
  `auditingtime` int(11) NOT NULL COMMENT '审核时间',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `merchant_user_type` (`merchant`,`user`,`type`),
  KEY `time_number` (`time`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='其他收入单';
-- ----------------------------
-- Records of is_otgatherclass
-- ----------------------------

-- ----------------------------
-- Table structure for is_otgatherinfo
-- ----------------------------
DROP TABLE IF EXISTS `is_otgatherinfo`;
CREATE TABLE `is_otgatherinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '所属ID',
  `account` int(11) NOT NULL COMMENT '资金账户ID',
  `total` decimal(10,2) NOT NULL COMMENT '结算金额',
  `data` varchar(128) DEFAULT '' COMMENT '备注',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `pid_account` (`pid`,`account`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='其他收入详情表';
-- ----------------------------
-- Records of is_otgatherinfo
-- ----------------------------

-- ----------------------------
-- Table structure for is_otpaymentclass
-- ----------------------------
DROP TABLE IF EXISTS `is_otpaymentclass`;
CREATE TABLE `is_otpaymentclass` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `merchant` int(11) NOT NULL COMMENT '所属商户',
  `time` int(11) NOT NULL COMMENT '单据时间',
  `number` varchar(32) NOT NULL COMMENT '单据编号',
  `user` int(11) NOT NULL COMMENT '制单人',
  `file` varchar(128) DEFAULT '' COMMENT '单据附件',
  `data` varchar(128) DEFAULT ' ' COMMENT '备注信息',
  `type` tinyint(1) NOT NULL COMMENT '审核状态[0:未审核|1:已审核]',
  `auditinguser` int(11) NOT NULL COMMENT '审核人',
  `auditingtime` int(11) NOT NULL COMMENT '审核时间',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `merchant_user_type` (`merchant`,`user`,`type`),
  KEY `time_number` (`time`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='其他支出单分类';
-- ----------------------------
-- Records of is_otpaymentclass
-- ----------------------------

-- ----------------------------
-- Table structure for is_otpaymentinfo
-- ----------------------------
DROP TABLE IF EXISTS `is_otpaymentinfo`;
CREATE TABLE `is_otpaymentinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '所属ID',
  `account` int(11) NOT NULL COMMENT '资金账户ID',
  `total` decimal(10,2) NOT NULL COMMENT '结算金额',
  `data` varchar(128) DEFAULT ' ' COMMENT '备注',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `pid_account` (`pid`,`account`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='其他支出单详情';
-- ----------------------------
-- Records of is_otpaymentinfo
-- ----------------------------

-- ----------------------------
-- Table structure for is_otpurchaseclass
-- ----------------------------
DROP TABLE IF EXISTS `is_otpurchaseclass`;
CREATE TABLE `is_otpurchaseclass` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `merchant` int(11) NOT NULL COMMENT '所属商户',
  `time` int(11) NOT NULL COMMENT '单据时间',
  `number` varchar(32) NOT NULL COMMENT '单据编号',
  `pagetype` tinyint(1) NOT NULL COMMENT '单据类型[0:其他入库单|1:盘盈单]',
  `user` int(11) NOT NULL COMMENT '制单人',
  `file` varchar(128) DEFAULT '' COMMENT '单据附件',
  `data` varchar(128) DEFAULT '' COMMENT '备注信息',
  `type` tinyint(1) NOT NULL COMMENT '审核状态[0:未审核|1:已审核]',
  `auditinguser` int(11) NOT NULL COMMENT '审核人',
  `auditingtime` int(11) NOT NULL COMMENT '审核时间',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `merchant_pagetype_user_type` (`merchant`,`pagetype`,`user`,`type`),
  KEY `time_number` (`time`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='其他入库单';
-- ----------------------------
-- Records of is_otpurchaseclass
-- ----------------------------

-- ----------------------------
-- Table structure for is_otpurchaseinfo
-- ----------------------------
DROP TABLE IF EXISTS `is_otpurchaseinfo`;
CREATE TABLE `is_otpurchaseinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '所属ID',
  `goods` int(11) NOT NULL COMMENT '商品ID',
  `attr` varchar(32) DEFAULT '' COMMENT '辅助属性',
  `warehouse` int(11) NOT NULL COMMENT '仓库ID',
  `batch` varchar(32) DEFAULT '' COMMENT '批次',
  `serial` text COMMENT '串码',
  `nums` decimal(10,2) NOT NULL COMMENT '数量',
  `data` varchar(128) DEFAULT '' COMMENT '备注',
  `room` int(11) NOT NULL COMMENT '仓储ID',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `pid_goods_warehouse` (`pid`,`goods`,`warehouse`) USING BTREE,
  KEY `goods_warehouse` (`goods`,`warehouse`) USING BTREE,
  KEY `warehouse` (`warehouse`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='其他入库单详情表';
-- ----------------------------
-- Records of is_otpurchaseinfo
-- ----------------------------

-- ----------------------------
-- Table structure for is_otsaleclass
-- ----------------------------
DROP TABLE IF EXISTS `is_otsaleclass`;
CREATE TABLE `is_otsaleclass` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `merchant` int(11) NOT NULL COMMENT '所属商户',
  `time` int(11) NOT NULL COMMENT '单据时间',
  `number` varchar(32) NOT NULL COMMENT '单据编号',
  `pagetype` tinyint(1) NOT NULL COMMENT '单据类型[0:其他出库单|1:盘亏单]',
  `user` int(11) NOT NULL COMMENT '制单人',
  `file` varchar(128) DEFAULT '' COMMENT '单据附件',
  `data` varchar(128) DEFAULT '' COMMENT '备注信息',
  `type` tinyint(1) NOT NULL COMMENT '审核状态[0:未审核|1:已审核]',
  `auditinguser` int(11) NOT NULL COMMENT '审核人',
  `auditingtime` int(11) NOT NULL COMMENT '审核时间',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `merchant_pagetype_user_type` (`merchant`,`pagetype`,`user`,`type`),
  KEY `time_number` (`time`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='其他出库单';
-- ----------------------------
-- Records of is_otsaleclass
-- ----------------------------

-- ----------------------------
-- Table structure for is_otsaleinfo
-- ----------------------------
DROP TABLE IF EXISTS `is_otsaleinfo`;
CREATE TABLE `is_otsaleinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '所属ID',
  `room` int(11) NOT NULL COMMENT '仓储ID',
  `goods` int(11) NOT NULL COMMENT '商品ID(搜索用)',
  `warehouse` int(11) NOT NULL COMMENT '仓库ID(搜索用)',
  `serial` text COMMENT '串号',
  `nums` decimal(10,2) NOT NULL COMMENT '数量',
  `data` varchar(128) DEFAULT '' COMMENT '备注',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `pid_room_goods_warehouse` (`pid`,`room`,`goods`,`warehouse`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='其他出库详情表';
-- ----------------------------
-- Records of is_otsaleinfo
-- ----------------------------

-- ----------------------------
-- Table structure for is_pagemore
-- ----------------------------
DROP TABLE IF EXISTS `is_pagemore`;
CREATE TABLE `is_pagemore` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL COMMENT '配置名称',
  `type` varchar(32) NOT NULL COMMENT '配置类型[js|css]',
  `info` text COMMENT '配置内容',
  `data` varchar(256) DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='静态文件扩展-创建插件[pagemore]';
-- ----------------------------
-- Records of is_pagemore
-- ----------------------------
INSERT INTO `is_pagemore` (`id`,`name`,`type`,`info`,`data`) VALUES ('1','extend','css','<link rel=\"stylesheet\" href=\"/skin/pagemore/css/more_font.css\" media=\"all\">','插件自动创建');
INSERT INTO `is_pagemore` (`id`,`name`,`type`,`info`,`data`) VALUES ('2','public','css','<link rel=\"stylesheet\" href=\"/skin/pagemore/css/more_font.css\" media=\"all\">','插件自动创建');

-- ----------------------------
-- Table structure for is_paymentclass
-- ----------------------------
DROP TABLE IF EXISTS `is_paymentclass`;
CREATE TABLE `is_paymentclass` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `merchant` int(11) NOT NULL COMMENT '所属商户',
  `supplier` int(11) NOT NULL COMMENT '供应商ID',
  `time` int(11) NOT NULL COMMENT '单据时间',
  `number` varchar(32) NOT NULL COMMENT '单据编号',
  `user` int(11) NOT NULL COMMENT '制单人',
  `file` varchar(128) DEFAULT '' COMMENT '单据附件',
  `data` varchar(128) DEFAULT ' ' COMMENT '备注信息',
  `type` tinyint(1) NOT NULL COMMENT '审核状态[0:未审核|1:已审核]',
  `auditinguser` int(11) NOT NULL COMMENT '审核人',
  `auditingtime` int(11) NOT NULL COMMENT '审核时间',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `merchant_supplier_user_type` (`merchant`,`supplier`,`user`,`type`),
  KEY `time_number` (`time`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='付款单';
-- ----------------------------
-- Records of is_paymentclass
-- ----------------------------

-- ----------------------------
-- Table structure for is_paymentinfo
-- ----------------------------
DROP TABLE IF EXISTS `is_paymentinfo`;
CREATE TABLE `is_paymentinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '所属ID',
  `account` int(11) NOT NULL COMMENT '资金账户ID',
  `total` decimal(10,2) NOT NULL COMMENT '结算金额',
  `data` varchar(128) DEFAULT ' ' COMMENT '备注',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `pid_account` (`pid`,`account`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='付款单详情';
-- ----------------------------
-- Records of is_paymentinfo
-- ----------------------------

-- ----------------------------
-- Table structure for is_plug
-- ----------------------------
DROP TABLE IF EXISTS `is_plug`;
CREATE TABLE `is_plug` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(36) NOT NULL COMMENT '插件名称',
  `info` varchar(256) DEFAULT ' ' COMMENT '插件介绍',
  `only` varchar(128) NOT NULL COMMENT '插件标识',
  `ver` varchar(12) DEFAULT '' COMMENT '插件版本',
  `author` varchar(36) DEFAULT ' ' COMMENT '插件作者',
  `state` tinyint(1) NOT NULL COMMENT '插件状态[0:禁用|1:正常]',
  `config` text COMMENT '配置信息',
  PRIMARY KEY (`id`),
  KEY `name_info_only` (`name`,`only`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='插件表';
-- ----------------------------
-- Records of is_plug
-- ----------------------------
INSERT INTO `is_plug` (`id`,`name`,`info`,`only`,`ver`,`author`,`state`,`config`) VALUES ('1','静态文件扩展','页面[JS,CSS]静态文件扩展','pagemore','1.0','NODCLOUD.COM','1','{\"by\":\"nodcloud.com\"}');

-- ----------------------------
-- Table structure for is_prints
-- ----------------------------
DROP TABLE IF EXISTS `is_prints`;
CREATE TABLE `is_prints` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL COMMENT '报表名称',
  `paper4` text NOT NULL COMMENT 'A4纸张',
  `paper2` text NOT NULL COMMENT '2等分纸',
  `paper4default` text NOT NULL COMMENT 'A4纸张默认',
  `paper2default` text NOT NULL COMMENT '2等分纸默认',
  `data` varchar(32) DEFAULT '' COMMENT '报表中文名称',
  PRIMARY KEY (`id`),
  KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='打印模板';
-- ----------------------------
-- Records of is_prints
-- ----------------------------
INSERT INTO `is_prints` (`id`,`name`,`paper4`,`paper2`,`paper4default`,`paper2default`,`data`) VALUES ('1','purchase','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi6LSt6LSn5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkwLjA1MyUiLCIwLjk5NSUiLDEwMTEsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIui0rei0p+WNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiMy44NzklIiwiOS4yNDQlIiwiMi4wNSUiLCLkvpvlupTllYbvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjEwLjMwMiUiLCIxNy40MzElIiwiMi4wNSUiLHN1cHBsaWVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJzdXBwbGllciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjM1LjIzOSUiLCIxMC4wNzYlIiwiMi4wNSUiLCLljZXmja7ml6XmnJ/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjQzLjQyNiUiLCIxOC4wNiUiLCIyLjA1JSIsdGltZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidGltZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjcwLjI1MiUiLCIxMC4wNzYlIiwiMi4wNSUiLCLljZXmja7nvJblj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjc4LjE4NiUiLCIxOC4wNiUiLCIyLjA1JSIsbnVtYmVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJudW1iZXIiKTsNCkxPRE9QLkFERF9QUklOVF9UQUJMRSgiMTIuNzM2JSIsIjIuMDAzJSIsIjk1Ljk5NSUiLCI3NC4zNzYlIixodG1sX3RhYmxlKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiVm9yaWVudCIsMyk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImh0bWxfdGFibGUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiMy44NzklIiwiMTAuMTI2JSIsIjIuMDUlIiwi5Y2V5o2u6YeR6aKd77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiMTIuMDY1JSIsIjE1LjExMyUiLCIyLjA1JSIsdG90YWwpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRvdGFsIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNjc2JSIsIjM2LjYyNSUiLCIxMC4xMjYlIiwiMi4wNSUiLCLlrp7pmYXph5Hpop06Iik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiNDQuOTM3JSIsIjE1LjExMyUiLCIyLjA1JSIsYWN0dWFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJhY3R1YWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiNzAuMjUyJSIsIjEwLjEyNiUiLCIyLjA1JSIsIuWunuS7mOmHkeminToiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkxLjY3NiUiLCI3OC41NjQlIiwiMTUuMTEzJSIsIjIuMDUlIixtb25leSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwibW9uZXkiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNDMlIiwiMy44NzklIiwiMTAuMTI2JSIsIjIuMDUlIiwi5Yi25Y2V5Lq677yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiMTIuMzQzJSIsIjE1LjExMyUiLCIyLjA1JSIsdXNlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidXNlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCIzNi45MDIlIiwiMTAuMDc2JSIsIjIuMDUlIiwi57uT566X6LSm5oi377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiNDUuMjE0JSIsIjE1LjExMyUiLCIyLjA1JSIsYWNjb3VudCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiYWNjb3VudCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCI3MC41MjklIiwiMTAuODMxJSIsIjIuMDUlIiwi5aSH5rOo5L+h5oGv77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiNzguODQxJSIsIjE1LjExMyUiLCIyLjA1JSIsZGF0YSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiZGF0YSIpOw0K','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi6LSt6LSn5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjg1LjUyNCUiLCIwLjk5NSUiLCI4NS43MTQlIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiOTEuODQ4JSIsIjAuOTk1JSIsIjkyLjAzOCUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIzLjI1NyUiLCI0MCUiLCIyMCUiLCI2LjMyNCUiLCLotK3otKfljZUiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDE0KTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQWxpZ25tZW50IiwyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQm9sZCIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMy44NzklIiwiOC42MTUlIiwiMy45MjQlIiwi5L6b5bqU5ZWG77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMTAuMzAyJSIsIjE3LjQzMSUiLCIzLjkyNCUiLHN1cHBsaWVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJzdXBwbGllciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE3MSUiLCIzNS4yMzklIiwiMTAuMDc2JSIsIjMuOTI0JSIsIuWNleaNruaXpeacn++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjQzLjQyNiUiLCIxOC4wNiUiLCIzLjkyNCUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMS45ODElIiwiNzAuMjUyJSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7nvJblj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjExLjk4MSUiLCI3OC4xODYlIiwiMTguMDYlIiwiMy45MjQlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIxOS43MzMlIiwiMi4wMDMlIiwiOTUuOTk1JSIsIjYxLjE4MSUiLGh0bWxfdGFibGUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJWb3JpZW50IiwzKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiaHRtbF90YWJsZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCIzLjg3OSUiLCIxMC4xMjYlIiwiMy45MjQlIiwi5Y2V5o2u6YeR6aKd77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI4Ni45NTIlIiwiMTIuMDY1JSIsIjE1LjEyNiUiLCIzLjkyNCUiLHRvdGFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0b3RhbCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCIzNi42MjUlIiwiMTAuMTI2JSIsIjMuOTI0JSIsIuWunumZhemHkeminToiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCI0NC45MzclIiwiMTUuMTI2JSIsIjMuOTI0JSIsYWN0dWFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJhY3R1YWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI4Ni45NTIlIiwiNzAuMjUyJSIsIjEwLjEyNiUiLCIzLjkyNCUiLCLlrp7ku5jph5Hpop06Iik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI4Ni45NTIlIiwiNzguNTY0JSIsIjE1LjEyNiUiLCIzLjkyNCUiLG1vbmV5KTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJtb25leSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjc3MSUiLCIzLjg3OSUiLCIxMC4xMjYlIiwiMy45MjQlIiwi5Yi25Y2V5Lq677yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My42MzglIiwiMTIuMzQzJSIsIjE1LjEyNiUiLCIzLjkyNCUiLHVzZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInVzZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My44MjklIiwiMzYuOTE0JSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLnu5PnrpfotKbmiLfvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCI0NC43NzMlIiwiMTUuMTI2JSIsIjMuOTI0JSIsYWNjb3VudCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiYWNjb3VudCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCI3MC41MjklIiwiMTAuODMxJSIsIjMuOTI0JSIsIuWkh+azqOS/oeaBr++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuODI5JSIsIjc4Ljg0MSUiLCIxNS4xMjYlIiwiMy45MjQlIixkYXRhKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJkYXRhIik7DQo=','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi6LSt6LSn5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkwLjA1MyUiLCIwLjk5NSUiLDEwMTEsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIui0rei0p+WNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiMy44NzklIiwiOS4yNDQlIiwiMi4wNSUiLCLkvpvlupTllYbvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjEwLjMwMiUiLCIxNy40MzElIiwiMi4wNSUiLHN1cHBsaWVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJzdXBwbGllciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjM1LjIzOSUiLCIxMC4wNzYlIiwiMi4wNSUiLCLljZXmja7ml6XmnJ/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjQzLjQyNiUiLCIxOC4wNiUiLCIyLjA1JSIsdGltZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidGltZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjcwLjI1MiUiLCIxMC4wNzYlIiwiMi4wNSUiLCLljZXmja7nvJblj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjc4LjE4NiUiLCIxOC4wNiUiLCIyLjA1JSIsbnVtYmVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJudW1iZXIiKTsNCkxPRE9QLkFERF9QUklOVF9UQUJMRSgiMTIuNzM2JSIsIjIuMDAzJSIsIjk1Ljk5NSUiLCI3NC4zNzYlIixodG1sX3RhYmxlKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiVm9yaWVudCIsMyk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImh0bWxfdGFibGUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiMy44NzklIiwiMTAuMTI2JSIsIjIuMDUlIiwi5Y2V5o2u6YeR6aKd77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiMTIuMDY1JSIsIjE1LjExMyUiLCIyLjA1JSIsdG90YWwpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRvdGFsIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNjc2JSIsIjM2LjYyNSUiLCIxMC4xMjYlIiwiMi4wNSUiLCLlrp7pmYXph5Hpop06Iik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiNDQuOTM3JSIsIjE1LjExMyUiLCIyLjA1JSIsYWN0dWFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJhY3R1YWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiNzAuMjUyJSIsIjEwLjEyNiUiLCIyLjA1JSIsIuWunuS7mOmHkeminToiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkxLjY3NiUiLCI3OC41NjQlIiwiMTUuMTEzJSIsIjIuMDUlIixtb25leSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwibW9uZXkiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNDMlIiwiMy44NzklIiwiMTAuMTI2JSIsIjIuMDUlIiwi5Yi25Y2V5Lq677yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiMTIuMzQzJSIsIjE1LjExMyUiLCIyLjA1JSIsdXNlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidXNlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCIzNi45MDIlIiwiMTAuMDc2JSIsIjIuMDUlIiwi57uT566X6LSm5oi377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiNDUuMjE0JSIsIjE1LjExMyUiLCIyLjA1JSIsYWNjb3VudCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiYWNjb3VudCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCI3MC41MjklIiwiMTAuODMxJSIsIjIuMDUlIiwi5aSH5rOo5L+h5oGv77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiNzguODQxJSIsIjE1LjExMyUiLCIyLjA1JSIsZGF0YSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiZGF0YSIpOw0K','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi6LSt6LSn5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjg1LjUyNCUiLCIwLjk5NSUiLCI4NS43MTQlIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiOTEuODQ4JSIsIjAuOTk1JSIsIjkyLjAzOCUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIzLjI1NyUiLCI0MCUiLCIyMCUiLCI2LjMyNCUiLCLotK3otKfljZUiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDE0KTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQWxpZ25tZW50IiwyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQm9sZCIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMy44NzklIiwiOC42MTUlIiwiMy45MjQlIiwi5L6b5bqU5ZWG77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMTAuMzAyJSIsIjE3LjQzMSUiLCIzLjkyNCUiLHN1cHBsaWVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJzdXBwbGllciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE3MSUiLCIzNS4yMzklIiwiMTAuMDc2JSIsIjMuOTI0JSIsIuWNleaNruaXpeacn++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjQzLjQyNiUiLCIxOC4wNiUiLCIzLjkyNCUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMS45ODElIiwiNzAuMjUyJSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7nvJblj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjExLjk4MSUiLCI3OC4xODYlIiwiMTguMDYlIiwiMy45MjQlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIyMC4zMDUlIiwiMi4wMDMlIiwiOTUuOTk1JSIsIjU3LjM3MSUiLGh0bWxfdGFibGUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJWb3JpZW50IiwzKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiaHRtbF90YWJsZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCIzLjg3OSUiLCIxMC4xMjYlIiwiMy45MjQlIiwi5Y2V5o2u6YeR6aKd77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI4Ni45NTIlIiwiMTIuMDY1JSIsIjE1LjEyNiUiLCIzLjkyNCUiLHRvdGFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0b3RhbCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCIzNi42MjUlIiwiMTAuMTI2JSIsIjMuOTI0JSIsIuWunumZhemHkeminToiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCI0NC45MzclIiwiMTUuMTI2JSIsIjMuOTI0JSIsYWN0dWFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJhY3R1YWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI4Ni45NTIlIiwiNzAuMjUyJSIsIjEwLjEyNiUiLCIzLjkyNCUiLCLlrp7ku5jph5Hpop06Iik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI4Ni45NTIlIiwiNzguNTY0JSIsIjE1LjEyNiUiLCIzLjkyNCUiLG1vbmV5KTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJtb25leSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjc3MSUiLCIzLjg3OSUiLCIxMC4xMjYlIiwiMy45MjQlIiwi5Yi25Y2V5Lq677yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My42MzglIiwiMTIuMzQzJSIsIjE1LjEyNiUiLCIzLjkyNCUiLHVzZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInVzZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My44MjklIiwiMzYuOTE0JSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLnu5PnrpfotKbmiLfvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCI0NC43NzMlIiwiMTUuMTI2JSIsIjMuOTI0JSIsYWNjb3VudCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiYWNjb3VudCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCI3MC41MjklIiwiMTAuODMxJSIsIjMuOTI0JSIsIuWkh+azqOS/oeaBr++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuODI5JSIsIjc4Ljg0MSUiLCIxNS4xMjYlIiwiMy45MjQlIixkYXRhKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJkYXRhIik7DQo=','购货单');
INSERT INTO `is_prints` (`id`,`name`,`paper4`,`paper2`,`paper4default`,`paper2default`,`data`) VALUES ('2','sale','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi6ZSA6LSn5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkwLjA1MyUiLCIwLjk5NSUiLDEwMTEsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIumUgOi0p+WNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJCb2xkIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjMuODc5JSIsIjYuNzI1JSIsIjIuMDUlIiwi5a6i5oi377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIxMC40MjglIiwiMTMuNTI2JSIsIjIuMDUlIixjdXN0b21lcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiY3VzdG9tZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIzNS4yMzklIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u5pel5pyf77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI0My40MjYlIiwiMTguMDYlIiwiMi4wNSUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI3MC4yNTIlIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u57yW5Y+377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI3OC4xODYlIiwiMTguMDYlIiwiMi4wNSUiLG51bWJlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwibnVtYmVyIik7DQpMT0RPUC5BRERfUFJJTlRfVEFCTEUoIjExLjMxJSIsIjIuMDAzJSIsIjk1Ljk5NSUiLCI3Ny4xMzklIixodG1sX3RhYmxlKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiVm9yaWVudCIsMyk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImh0bWxfdGFibGUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiMy44NzklIiwiMTAuMTI2JSIsIjIuMDUlIiwi5Y2V5o2u6YeR6aKd77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiMTIuMDY1JSIsIjE1LjExMyUiLCIyLjA1JSIsdG90YWwpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRvdGFsIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNjc2JSIsIjM2LjYyNSUiLCIxMC4xMjYlIiwiMi4wNSUiLCLlrp7pmYXph5Hpop06Iik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiNDQuOTM3JSIsIjE1LjExMyUiLCIyLjA1JSIsYWN0dWFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJhY3R1YWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiNzAuMjUyJSIsIjEwLjEyNiUiLCIyLjA1JSIsIuWunuaUtumHkeminToiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkxLjY3NiUiLCI3OC41NjQlIiwiMTUuMTEzJSIsIjIuMDUlIixtb25leSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwibW9uZXkiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNDMlIiwiMy44NzklIiwiOC44NjYlIiwiMi4wNSUiLCLliLbljZXkurrvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCIxMS4yMDklIiwiMTQuOTg3JSIsIjIuMDUlIix1c2VyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ1c2VyIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjM2LjkwMiUiLCIxMC4wNzYlIiwiMi4wNSUiLCLnu5PnrpfotKbmiLfvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCI0NS4yMTQlIiwiMTUuMTEzJSIsIjIuMDUlIixhY2NvdW50KTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJhY2NvdW50Iik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjcwLjUyOSUiLCIxMC44MzElIiwiMi4wNSUiLCLlpIfms6jkv6Hmga/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCI3OC44NDElIiwiMTUuMTEzJSIsIjIuMDUlIixkYXRhKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJkYXRhIik7DQo=','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi6ZSA6LSn5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjg1LjUyNCUiLCIwLjk5NSUiLCI4NS43MTQlIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiOTEuODQ4JSIsIjAuOTk1JSIsIjkyLjAzOCUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIzLjI1NyUiLCI0MCUiLCIyMCUiLCI2LjMyNCUiLCLplIDotKfljZUiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDE0KTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQWxpZ25tZW50IiwyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQm9sZCIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMy44NzklIiwiNi43MjUlIiwiMy45MjQlIiwi5a6i5oi377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMTAuMzAyJSIsIjE1LjAzOCUiLCIzLjkyNCUiLGN1c3RvbWVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJjdXN0b21lciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjM2MiUiLCIzNS4yMzklIiwiMTAuMDc2JSIsIjMuOTI0JSIsIuWNleaNruaXpeacn++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMzYyJSIsIjQzLjQyNiUiLCIxOC4wNiUiLCIzLjkyNCUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiNjkuODc0JSIsIjEwLjQ1MyUiLCIzLjkyNCUiLCLljZXmja7nvJblj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjM2MiUiLCI3OC4xODYlIiwiMTguNjklIiwiMy45MjQlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIxOC45NzElIiwiMi4wMDMlIiwiOTUuOTk1JSIsIjY0LjAzOCUiLGh0bWxfdGFibGUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJWb3JpZW50IiwzKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiaHRtbF90YWJsZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCIzLjg3OSUiLCI5LjM3JSIsIjMuOTI0JSIsIuWNleaNrumHkemine+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiODYuOTUyJSIsIjEyLjA2NSUiLCIxNS4xMjYlIiwiMy45MjQlIix0b3RhbCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidG90YWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI4Ni45NTIlIiwiMzYuNjI1JSIsIjEwLjEyNiUiLCIzLjkyNCUiLCLlrp7pmYXph5Hpop06Iik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI4Ni45NTIlIiwiNDQuOTM3JSIsIjE1LjEyNiUiLCIzLjkyNCUiLGFjdHVhbCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiYWN0dWFsIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiODYuOTUyJSIsIjcwLjI1MiUiLCIxMC4xMjYlIiwiMy45MjQlIiwi5a6e5pS26YeR6aKdOiIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiODYuOTUyJSIsIjc4LjU2NCUiLCIxNS4xMjYlIiwiMy45MjQlIixtb25leSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwibW9uZXkiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My45NjIlIiwiMy44NzklIiwiOC4xMTElIiwiMy45MjQlIiwi5Yi25Y2V5Lq677yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My44MjklIiwiMTEuNzEzJSIsIjE1LjM3OCUiLCIzLjkyNCUiLHVzZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInVzZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My44MjklIiwiMzYuOTE0JSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLnu5PnrpfotKbmiLfvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCI0NC43NzMlIiwiMTUuMTI2JSIsIjMuOTI0JSIsYWNjb3VudCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiYWNjb3VudCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCI3MC41MjklIiwiMTAuODMxJSIsIjMuOTI0JSIsIuWkh+azqOS/oeaBr++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuODI5JSIsIjc4Ljg0MSUiLCIxNS4xMjYlIiwiMy45MjQlIixkYXRhKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJkYXRhIik7DQo=','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi6ZSA6LSn5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkwLjA1MyUiLCIwLjk5NSUiLDEwMTEsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIumUgOi0p+WNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJCb2xkIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjMuODc5JSIsIjYuNzI1JSIsIjIuMDUlIiwi5a6i5oi377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIxMC40MjglIiwiMTMuNTI2JSIsIjIuMDUlIixjdXN0b21lcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiY3VzdG9tZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIzNS4yMzklIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u5pel5pyf77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI0My40MjYlIiwiMTguMDYlIiwiMi4wNSUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI3MC4yNTIlIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u57yW5Y+377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI3OC4xODYlIiwiMTguMDYlIiwiMi4wNSUiLG51bWJlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwibnVtYmVyIik7DQpMT0RPUC5BRERfUFJJTlRfVEFCTEUoIjExLjMxJSIsIjIuMDAzJSIsIjk1Ljk5NSUiLCI3Ny4xMzklIixodG1sX3RhYmxlKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiVm9yaWVudCIsMyk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImh0bWxfdGFibGUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiMy44NzklIiwiMTAuMTI2JSIsIjIuMDUlIiwi5Y2V5o2u6YeR6aKd77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiMTIuMDY1JSIsIjE1LjExMyUiLCIyLjA1JSIsdG90YWwpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRvdGFsIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNjc2JSIsIjM2LjYyNSUiLCIxMC4xMjYlIiwiMi4wNSUiLCLlrp7pmYXph5Hpop06Iik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiNDQuOTM3JSIsIjE1LjExMyUiLCIyLjA1JSIsYWN0dWFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJhY3R1YWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiNzAuMjUyJSIsIjEwLjEyNiUiLCIyLjA1JSIsIuWunuaUtumHkeminToiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkxLjY3NiUiLCI3OC41NjQlIiwiMTUuMTEzJSIsIjIuMDUlIixtb25leSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwibW9uZXkiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNDMlIiwiMy44NzklIiwiOC44NjYlIiwiMi4wNSUiLCLliLbljZXkurrvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCIxMS4yMDklIiwiMTQuOTg3JSIsIjIuMDUlIix1c2VyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ1c2VyIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjM2LjkwMiUiLCIxMC4wNzYlIiwiMi4wNSUiLCLnu5PnrpfotKbmiLfvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCI0NS4yMTQlIiwiMTUuMTEzJSIsIjIuMDUlIixhY2NvdW50KTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJhY2NvdW50Iik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjcwLjUyOSUiLCIxMC44MzElIiwiMi4wNSUiLCLlpIfms6jkv6Hmga/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCI3OC44NDElIiwiMTUuMTEzJSIsIjIuMDUlIixkYXRhKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJkYXRhIik7DQo=','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi6ZSA6LSn5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjg1LjUyNCUiLCIwLjk5NSUiLCI4NS43MTQlIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiOTEuODQ4JSIsIjAuOTk1JSIsIjkyLjAzOCUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIzLjI1NyUiLCI0MCUiLCIyMCUiLCI2LjMyNCUiLCLplIDotKfljZUiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDE0KTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQWxpZ25tZW50IiwyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQm9sZCIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMy44NzklIiwiNi43MjUlIiwiMy45MjQlIiwi5a6i5oi377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMTAuMzAyJSIsIjE1LjAzOCUiLCIzLjkyNCUiLGN1c3RvbWVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJjdXN0b21lciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjM2MiUiLCIzNS4yMzklIiwiMTAuMDc2JSIsIjMuOTI0JSIsIuWNleaNruaXpeacn++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMzYyJSIsIjQzLjQyNiUiLCIxOC4wNiUiLCIzLjkyNCUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiNjkuODc0JSIsIjEwLjQ1MyUiLCIzLjkyNCUiLCLljZXmja7nvJblj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjM2MiUiLCI3OC4xODYlIiwiMTguNjklIiwiMy45MjQlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIxOC45NzElIiwiMi4wMDMlIiwiOTUuOTk1JSIsIjY0LjAzOCUiLGh0bWxfdGFibGUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJWb3JpZW50IiwzKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiaHRtbF90YWJsZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCIzLjg3OSUiLCI5LjM3JSIsIjMuOTI0JSIsIuWNleaNrumHkemine+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiODYuOTUyJSIsIjEyLjA2NSUiLCIxNS4xMjYlIiwiMy45MjQlIix0b3RhbCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidG90YWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI4Ni45NTIlIiwiMzYuNjI1JSIsIjEwLjEyNiUiLCIzLjkyNCUiLCLlrp7pmYXph5Hpop06Iik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI4Ni45NTIlIiwiNDQuOTM3JSIsIjE1LjEyNiUiLCIzLjkyNCUiLGFjdHVhbCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiYWN0dWFsIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiODYuOTUyJSIsIjcwLjI1MiUiLCIxMC4xMjYlIiwiMy45MjQlIiwi5a6e5pS26YeR6aKdOiIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiODYuOTUyJSIsIjc4LjU2NCUiLCIxNS4xMjYlIiwiMy45MjQlIixtb25leSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwibW9uZXkiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My45NjIlIiwiMy44NzklIiwiOC4xMTElIiwiMy45MjQlIiwi5Yi25Y2V5Lq677yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My44MjklIiwiMTEuNzEzJSIsIjE1LjM3OCUiLCIzLjkyNCUiLHVzZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInVzZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My44MjklIiwiMzYuOTE0JSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLnu5PnrpfotKbmiLfvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCI0NC43NzMlIiwiMTUuMTI2JSIsIjMuOTI0JSIsYWNjb3VudCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiYWNjb3VudCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCI3MC41MjklIiwiMTAuODMxJSIsIjMuOTI0JSIsIuWkh+azqOS/oeaBr++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuODI5JSIsIjc4Ljg0MSUiLCIxNS4xMjYlIiwiMy45MjQlIixkYXRhKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJkYXRhIik7DQo=','销货单');
INSERT INTO `is_prints` (`id`,`name`,`paper4`,`paper2`,`paper4default`,`paper2default`,`data`) VALUES ('3','repurchase','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi6LSt6LSn6YCA6LSn5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkwLjA1MyUiLCIwLjk5NSUiLDEwMTEsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIui0rei0p+mAgOi0p+WNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiMy44NzklIiwiOS4yNDQlIiwiMi4wNSUiLCLkvpvlupTllYbvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjEwLjMwMiUiLCIxNy40MzElIiwiMi4wNSUiLHN1cHBsaWVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJzdXBwbGllciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjM1LjIzOSUiLCIxMC4wNzYlIiwiMi4wNSUiLCLljZXmja7ml6XmnJ/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjQzLjQyNiUiLCIxOC4wNiUiLCIyLjA1JSIsdGltZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidGltZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjcwLjI1MiUiLCIxMC4wNzYlIiwiMi4wNSUiLCLljZXmja7nvJblj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjc4LjE4NiUiLCIxOS4zMiUiLCIyLjA1JSIsbnVtYmVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJudW1iZXIiKTsNCkxPRE9QLkFERF9QUklOVF9UQUJMRSgiMTEuMTMyJSIsIjIuMDAzJSIsIjk1Ljk5NSUiLCI3Ni42MDQlIixodG1sX3RhYmxlKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiVm9yaWVudCIsMyk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImh0bWxfdGFibGUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiMy44NzklIiwiMTAuMTI2JSIsIjIuMDUlIiwi5Y2V5o2u6YeR6aKd77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiMTIuMDY1JSIsIjE1LjExMyUiLCIyLjA1JSIsdG90YWwpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRvdGFsIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNjc2JSIsIjM2LjYyNSUiLCIxMC4xMjYlIiwiMi4wNSUiLCLlrp7pmYXph5Hpop06Iik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiNDQuOTM3JSIsIjE1LjExMyUiLCIyLjA1JSIsYWN0dWFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJhY3R1YWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiNzAuMjUyJSIsIjEwLjEyNiUiLCIyLjA1JSIsIuWunuaUtumHkeminToiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkxLjY3NiUiLCI3OC41NjQlIiwiMTUuMTEzJSIsIjIuMDUlIixtb25leSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwibW9uZXkiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNDMlIiwiMy44NzklIiwiMTAuMTI2JSIsIjIuMDUlIiwi5Yi25Y2V5Lq677yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiMTAuMzI3JSIsIjE1LjExMyUiLCIyLjA1JSIsdXNlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidXNlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCIzNi45MDIlIiwiMTAuMDc2JSIsIjIuMDUlIiwi57uT566X6LSm5oi377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiNDUuMjE0JSIsIjE1LjExMyUiLCIyLjA1JSIsYWNjb3VudCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiYWNjb3VudCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCI3MC41MjklIiwiMTAuODMxJSIsIjIuMDUlIiwi5aSH5rOo5L+h5oGv77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiNzguODQxJSIsIjE1LjExMyUiLCIyLjA1JSIsZGF0YSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiZGF0YSIpOw0K','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi6LSt6LSn6YCA6LSn5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjg1LjUyNCUiLCIwLjk5NSUiLCI4NS43MTQlIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiOTEuODQ4JSIsIjAuOTk1JSIsIjkyLjAzOCUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIzLjQ0OCUiLCI0MCUiLCIyMCUiLCI2LjMyNCUiLCLotK3otKfpgIDotKfljZUiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDE0KTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQWxpZ25tZW50IiwyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQm9sZCIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMy44NzklIiwiOS44NzQlIiwiMy45MjQlIiwi5L6b5bqU5ZWG77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMTAuNTU0JSIsIjE3LjQzMSUiLCIzLjkyNCUiLHN1cHBsaWVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJzdXBwbGllciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjM2MiUiLCIzNS4yMzklIiwiMTAuMDc2JSIsIjMuOTI0JSIsIuWNleaNruaXpeacn++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMzYyJSIsIjQzLjQyNiUiLCIxOC4wNiUiLCIzLjkyNCUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiNzAuMjUyJSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7nvJblj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjM2MiUiLCI3OC4xODYlIiwiMTkuMzIlIiwiMy45MjQlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIxOC41OSUiLCIyLjAwMyUiLCI5NS45OTUlIiwiNjMuMDg2JSIsaHRtbF90YWJsZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIlZvcmllbnQiLDMpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJodG1sX3RhYmxlIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiODYuOTUyJSIsIjMuODc5JSIsIjEwLjEyNiUiLCIzLjkyNCUiLCLljZXmja7ph5Hpop3vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCIxMi4wNjUlIiwiMTUuMTI2JSIsIjMuOTI0JSIsdG90YWwpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRvdGFsIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiODYuOTUyJSIsIjM2LjYyNSUiLCIxMC4xMjYlIiwiMy45MjQlIiwi5a6e6ZmF6YeR6aKdOiIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiODYuOTUyJSIsIjQ0LjkzNyUiLCIxNS4xMjYlIiwiMy45MjQlIixhY3R1YWwpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImFjdHVhbCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCI3MC4yNTIlIiwiMTAuMTI2JSIsIjMuOTI0JSIsIuWunuaUtumHkeminToiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCI3OC41NjQlIiwiMTUuMTI2JSIsIjMuOTI0JSIsbW9uZXkpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm1vbmV5Iik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuOTYyJSIsIjMuODc5JSIsIjEwLjEyNiUiLCIzLjkyNCUiLCLliLbljZXkurrvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCIxMC40NTMlIiwiMTUuMTI2JSIsIjMuOTI0JSIsdXNlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidXNlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCIzNi45MTQlIiwiMTAuMDc2JSIsIjMuOTI0JSIsIue7k+eul+i0puaIt++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuODI5JSIsIjQ0Ljc3MyUiLCIxNS4xMjYlIiwiMy45MjQlIixhY2NvdW50KTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJhY2NvdW50Iik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuODI5JSIsIjcwLjUyOSUiLCIxMC44MzElIiwiMy45MjQlIiwi5aSH5rOo5L+h5oGv77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My44MjklIiwiNzguODQxJSIsIjE1LjEyNiUiLCIzLjkyNCUiLGRhdGEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImRhdGEiKTsNCg==','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi6LSt6LSn6YCA6LSn5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkwLjA1MyUiLCIwLjk5NSUiLDEwMTEsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIui0rei0p+mAgOi0p+WNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiMy44NzklIiwiOS4yNDQlIiwiMi4wNSUiLCLkvpvlupTllYbvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjEwLjMwMiUiLCIxNy40MzElIiwiMi4wNSUiLHN1cHBsaWVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJzdXBwbGllciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjM1LjIzOSUiLCIxMC4wNzYlIiwiMi4wNSUiLCLljZXmja7ml6XmnJ/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjQzLjQyNiUiLCIxOC4wNiUiLCIyLjA1JSIsdGltZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidGltZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjcwLjI1MiUiLCIxMC4wNzYlIiwiMi4wNSUiLCLljZXmja7nvJblj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjc4LjE4NiUiLCIxOS4zMiUiLCIyLjA1JSIsbnVtYmVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJudW1iZXIiKTsNCkxPRE9QLkFERF9QUklOVF9UQUJMRSgiMTEuMTMyJSIsIjIuMDAzJSIsIjk1Ljk5NSUiLCI3Ni42MDQlIixodG1sX3RhYmxlKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiVm9yaWVudCIsMyk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImh0bWxfdGFibGUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiMy44NzklIiwiMTAuMTI2JSIsIjIuMDUlIiwi5Y2V5o2u6YeR6aKd77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiMTIuMDY1JSIsIjE1LjExMyUiLCIyLjA1JSIsdG90YWwpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRvdGFsIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNjc2JSIsIjM2LjYyNSUiLCIxMC4xMjYlIiwiMi4wNSUiLCLlrp7pmYXph5Hpop06Iik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiNDQuOTM3JSIsIjE1LjExMyUiLCIyLjA1JSIsYWN0dWFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJhY3R1YWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiNzAuMjUyJSIsIjEwLjEyNiUiLCIyLjA1JSIsIuWunuaUtumHkeminToiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkxLjY3NiUiLCI3OC41NjQlIiwiMTUuMTEzJSIsIjIuMDUlIixtb25leSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwibW9uZXkiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNDMlIiwiMy44NzklIiwiMTAuMTI2JSIsIjIuMDUlIiwi5Yi25Y2V5Lq677yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiMTAuMzI3JSIsIjE1LjExMyUiLCIyLjA1JSIsdXNlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidXNlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCIzNi45MDIlIiwiMTAuMDc2JSIsIjIuMDUlIiwi57uT566X6LSm5oi377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiNDUuMjE0JSIsIjE1LjExMyUiLCIyLjA1JSIsYWNjb3VudCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiYWNjb3VudCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCI3MC41MjklIiwiMTAuODMxJSIsIjIuMDUlIiwi5aSH5rOo5L+h5oGv77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiNzguODQxJSIsIjE1LjExMyUiLCIyLjA1JSIsZGF0YSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiZGF0YSIpOw0K','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi6LSt6LSn6YCA6LSn5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjg1LjUyNCUiLCIwLjk5NSUiLCI4NS43MTQlIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiOTEuODQ4JSIsIjAuOTk1JSIsIjkyLjAzOCUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIzLjQ0OCUiLCI0MCUiLCIyMCUiLCI2LjMyNCUiLCLotK3otKfpgIDotKfljZUiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDE0KTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQWxpZ25tZW50IiwyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQm9sZCIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMy44NzklIiwiOS44NzQlIiwiMy45MjQlIiwi5L6b5bqU5ZWG77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMTAuNTU0JSIsIjE3LjQzMSUiLCIzLjkyNCUiLHN1cHBsaWVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJzdXBwbGllciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjM2MiUiLCIzNS4yMzklIiwiMTAuMDc2JSIsIjMuOTI0JSIsIuWNleaNruaXpeacn++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMzYyJSIsIjQzLjQyNiUiLCIxOC4wNiUiLCIzLjkyNCUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiNzAuMjUyJSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7nvJblj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjM2MiUiLCI3OC4xODYlIiwiMTkuMzIlIiwiMy45MjQlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIxOC41OSUiLCIyLjAwMyUiLCI5NS45OTUlIiwiNjMuMDg2JSIsaHRtbF90YWJsZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIlZvcmllbnQiLDMpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJodG1sX3RhYmxlIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiODYuOTUyJSIsIjMuODc5JSIsIjEwLjEyNiUiLCIzLjkyNCUiLCLljZXmja7ph5Hpop3vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCIxMi4wNjUlIiwiMTUuMTI2JSIsIjMuOTI0JSIsdG90YWwpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRvdGFsIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiODYuOTUyJSIsIjM2LjYyNSUiLCIxMC4xMjYlIiwiMy45MjQlIiwi5a6e6ZmF6YeR6aKdOiIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiODYuOTUyJSIsIjQ0LjkzNyUiLCIxNS4xMjYlIiwiMy45MjQlIixhY3R1YWwpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImFjdHVhbCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCI3MC4yNTIlIiwiMTAuMTI2JSIsIjMuOTI0JSIsIuWunuaUtumHkeminToiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCI3OC41NjQlIiwiMTUuMTI2JSIsIjMuOTI0JSIsbW9uZXkpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm1vbmV5Iik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuOTYyJSIsIjMuODc5JSIsIjEwLjEyNiUiLCIzLjkyNCUiLCLliLbljZXkurrvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCIxMC40NTMlIiwiMTUuMTI2JSIsIjMuOTI0JSIsdXNlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidXNlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCIzNi45MTQlIiwiMTAuMDc2JSIsIjMuOTI0JSIsIue7k+eul+i0puaIt++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuODI5JSIsIjQ0Ljc3MyUiLCIxNS4xMjYlIiwiMy45MjQlIixhY2NvdW50KTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJhY2NvdW50Iik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuODI5JSIsIjcwLjUyOSUiLCIxMC44MzElIiwiMy45MjQlIiwi5aSH5rOo5L+h5oGv77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My44MjklIiwiNzguODQxJSIsIjE1LjEyNiUiLCIzLjkyNCUiLGRhdGEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImRhdGEiKTsNCg==','购货退货单');
INSERT INTO `is_prints` (`id`,`name`,`paper4`,`paper2`,`paper4default`,`paper2default`,`data`) VALUES ('4','resale','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi6ZSA6LSn6YCA6LSn5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkwLjA1MyUiLCIwLjk5NSUiLDEwMTEsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIumUgOi0p+mAgOi0p+WNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiMy44NzklIiwiNi43MjUlIiwiMi4wNSUiLCLlrqLmiLfvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjkuNDIxJSIsIjIyLjQ2OSUiLCIyLjA1JSIsY3VzdG9tZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImN1c3RvbWVyIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiMzUuMjM5JSIsIjEwLjA3NiUiLCIyLjA1JSIsIuWNleaNruaXpeacn++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiNDMuNDI2JSIsIjE4LjA2JSIsIjIuMDUlIix0aW1lKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0aW1lIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiNzAuMjUyJSIsIjEwLjA3NiUiLCIyLjA1JSIsIuWNleaNrue8luWPt++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiNzguMTg2JSIsIjE5Ljk1JSIsIjIuMDUlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIxMS4zMSUiLCIyLjAwMyUiLCI5NS45OTUlIiwiNzcuMTM5JSIsaHRtbF90YWJsZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIlZvcmllbnQiLDMpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJodG1sX3RhYmxlIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNjc2JSIsIjMuODc5JSIsIjEwLjEyNiUiLCIyLjA1JSIsIuWNleaNrumHkemine+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNjc2JSIsIjEyLjA2NSUiLCIxMy44NTQlIiwiMi4wNSUiLHRvdGFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0b3RhbCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkxLjY3NiUiLCIzNi42MjUlIiwiMTAuMTI2JSIsIjIuMDUlIiwi5a6e6ZmF6YeR6aKdOiIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNjc2JSIsIjQ0LjkzNyUiLCIxNS4xMTMlIiwiMi4wNSUiLGFjdHVhbCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiYWN0dWFsIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNjc2JSIsIjcwLjI1MiUiLCIxMC4xMjYlIiwiMi4wNSUiLCLlrp7ku5jph5Hpop06Iik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiNzguNTY0JSIsIjE1LjExMyUiLCIyLjA1JSIsbW9uZXkpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm1vbmV5Iik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDQzJSIsIjMuODc5JSIsIjEwLjEyNiUiLCIyLjA1JSIsIuWItuWNleS6uu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjEwLjIwMiUiLCIxNS44NjklIiwiMi4wNSUiLHVzZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInVzZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiMzYuOTAyJSIsIjEwLjA3NiUiLCIyLjA1JSIsIue7k+eul+i0puaIt++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjQ1LjIxNCUiLCIxNS4xMTMlIiwiMi4wNSUiLGFjY291bnQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImFjY291bnQiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiNzAuNTI5JSIsIjEwLjgzMSUiLCIyLjA1JSIsIuWkh+azqOS/oeaBr++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjc4Ljg0MSUiLCIxNS4xMTMlIiwiMi4wNSUiLGRhdGEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImRhdGEiKTsNCg==','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi6ZSA6LSn6YCA6LSn5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjg1LjUyNCUiLCIwLjk5NSUiLCI4NS43MTQlIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiOTEuODQ4JSIsIjAuOTk1JSIsIjkyLjAzOCUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIzLjI1NyUiLCI0MCUiLCIyMCUiLCI2LjMyNCUiLCLplIDotKfpgIDotKfljZUiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDE0KTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQWxpZ25tZW50IiwyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQm9sZCIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMy44NzklIiwiNy42MDclIiwiMy45MjQlIiwi5a6i5oi377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMTAuMDUlIiwiMTkuOTUlIiwiMy45MjQlIixjdXN0b21lcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiY3VzdG9tZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4xNzElIiwiMzUuMjM5JSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7ml6XmnJ/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE3MSUiLCI0My40MjYlIiwiMTQuMDMlIiwiMy45MjQlIix0aW1lKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0aW1lIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjY5LjM3JSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7nvJblj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE3MSUiLCI3Ny4zMDUlIiwiMTkuMzIlIiwiMy45MjQlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIxOS4zNTIlIiwiMi4wMDMlIiwiOTUuOTk1JSIsIjYxLjk0MyUiLGh0bWxfdGFibGUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJWb3JpZW50IiwzKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiaHRtbF90YWJsZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCIzLjg3OSUiLCIxMC4xMjYlIiwiMy45MjQlIiwi5Y2V5o2u6YeR6aKd77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI4Ni45NTIlIiwiMTIuMDY1JSIsIjE1LjEyNiUiLCIzLjkyNCUiLHRvdGFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0b3RhbCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCIzNi42MjUlIiwiMTAuMTI2JSIsIjMuOTI0JSIsIuWunumZhemHkeminToiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCI0NC45MzclIiwiMTUuMTI2JSIsIjMuOTI0JSIsYWN0dWFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJhY3R1YWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI4Ni45NTIlIiwiNzAuMjUyJSIsIjEwLjEyNiUiLCIzLjkyNCUiLCLlrp7ku5jph5Hpop06Iik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI4Ni45NTIlIiwiNzguNTY0JSIsIjE1LjEyNiUiLCIzLjkyNCUiLG1vbmV5KTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJtb25leSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjc3MSUiLCIzLjg3OSUiLCIxMC4xMjYlIiwiMy45MjQlIiwi5Yi25Y2V5Lq677yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My42MzglIiwiMTAuMjAyJSIsIjE1LjEyNiUiLCIzLjkyNCUiLHVzZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInVzZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My44MjklIiwiMzYuOTE0JSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLnu5PnrpfotKbmiLfvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCI0NC43NzMlIiwiMTUuMTI2JSIsIjMuOTI0JSIsYWNjb3VudCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiYWNjb3VudCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCI3MC41MjklIiwiMTAuODMxJSIsIjMuOTI0JSIsIuWkh+azqOS/oeaBr++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuODI5JSIsIjc4Ljg0MSUiLCIxNS4xMjYlIiwiMy45MjQlIixkYXRhKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJkYXRhIik7DQo=','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi6ZSA6LSn6YCA6LSn5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkwLjA1MyUiLCIwLjk5NSUiLDEwMTEsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIumUgOi0p+mAgOi0p+WNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiMy44NzklIiwiNi43MjUlIiwiMi4wNSUiLCLlrqLmiLfvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjkuNDIxJSIsIjIyLjQ2OSUiLCIyLjA1JSIsY3VzdG9tZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImN1c3RvbWVyIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiMzUuMjM5JSIsIjEwLjA3NiUiLCIyLjA1JSIsIuWNleaNruaXpeacn++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiNDMuNDI2JSIsIjE4LjA2JSIsIjIuMDUlIix0aW1lKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0aW1lIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiNzAuMjUyJSIsIjEwLjA3NiUiLCIyLjA1JSIsIuWNleaNrue8luWPt++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiNzguMTg2JSIsIjE5Ljk1JSIsIjIuMDUlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIxMS4zMSUiLCIyLjAwMyUiLCI5NS45OTUlIiwiNzcuMTM5JSIsaHRtbF90YWJsZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIlZvcmllbnQiLDMpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJodG1sX3RhYmxlIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNjc2JSIsIjMuODc5JSIsIjEwLjEyNiUiLCIyLjA1JSIsIuWNleaNrumHkemine+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNjc2JSIsIjEyLjA2NSUiLCIxMy44NTQlIiwiMi4wNSUiLHRvdGFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0b3RhbCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkxLjY3NiUiLCIzNi42MjUlIiwiMTAuMTI2JSIsIjIuMDUlIiwi5a6e6ZmF6YeR6aKdOiIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNjc2JSIsIjQ0LjkzNyUiLCIxNS4xMTMlIiwiMi4wNSUiLGFjdHVhbCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiYWN0dWFsIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNjc2JSIsIjcwLjI1MiUiLCIxMC4xMjYlIiwiMi4wNSUiLCLlrp7ku5jph5Hpop06Iik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiNzguNTY0JSIsIjE1LjExMyUiLCIyLjA1JSIsbW9uZXkpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm1vbmV5Iik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDQzJSIsIjMuODc5JSIsIjEwLjEyNiUiLCIyLjA1JSIsIuWItuWNleS6uu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjEwLjIwMiUiLCIxNS44NjklIiwiMi4wNSUiLHVzZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInVzZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiMzYuOTAyJSIsIjEwLjA3NiUiLCIyLjA1JSIsIue7k+eul+i0puaIt++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjQ1LjIxNCUiLCIxNS4xMTMlIiwiMi4wNSUiLGFjY291bnQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImFjY291bnQiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiNzAuNTI5JSIsIjEwLjgzMSUiLCIyLjA1JSIsIuWkh+azqOS/oeaBr++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjc4Ljg0MSUiLCIxNS4xMTMlIiwiMi4wNSUiLGRhdGEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImRhdGEiKTsNCg==','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi6ZSA6LSn6YCA6LSn5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjg1LjUyNCUiLCIwLjk5NSUiLCI4NS43MTQlIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiOTEuODQ4JSIsIjAuOTk1JSIsIjkyLjAzOCUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIzLjI1NyUiLCI0MCUiLCIyMCUiLCI2LjMyNCUiLCLplIDotKfpgIDotKfljZUiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDE0KTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQWxpZ25tZW50IiwyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQm9sZCIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMy44NzklIiwiNy42MDclIiwiMy45MjQlIiwi5a6i5oi377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMTAuMDUlIiwiMTkuOTUlIiwiMy45MjQlIixjdXN0b21lcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiY3VzdG9tZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4xNzElIiwiMzUuMjM5JSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7ml6XmnJ/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE3MSUiLCI0My40MjYlIiwiMTQuMDMlIiwiMy45MjQlIix0aW1lKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0aW1lIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjY5LjM3JSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7nvJblj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE3MSUiLCI3Ny4zMDUlIiwiMTkuMzIlIiwiMy45MjQlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIxOS4zNTIlIiwiMi4wMDMlIiwiOTUuOTk1JSIsIjYxLjk0MyUiLGh0bWxfdGFibGUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJWb3JpZW50IiwzKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiaHRtbF90YWJsZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCIzLjg3OSUiLCIxMC4xMjYlIiwiMy45MjQlIiwi5Y2V5o2u6YeR6aKd77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI4Ni45NTIlIiwiMTIuMDY1JSIsIjE1LjEyNiUiLCIzLjkyNCUiLHRvdGFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0b3RhbCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCIzNi42MjUlIiwiMTAuMTI2JSIsIjMuOTI0JSIsIuWunumZhemHkeminToiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCI0NC45MzclIiwiMTUuMTI2JSIsIjMuOTI0JSIsYWN0dWFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJhY3R1YWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI4Ni45NTIlIiwiNzAuMjUyJSIsIjEwLjEyNiUiLCIzLjkyNCUiLCLlrp7ku5jph5Hpop06Iik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI4Ni45NTIlIiwiNzguNTY0JSIsIjE1LjEyNiUiLCIzLjkyNCUiLG1vbmV5KTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJtb25leSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjc3MSUiLCIzLjg3OSUiLCIxMC4xMjYlIiwiMy45MjQlIiwi5Yi25Y2V5Lq677yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My42MzglIiwiMTAuMjAyJSIsIjE1LjEyNiUiLCIzLjkyNCUiLHVzZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInVzZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My44MjklIiwiMzYuOTE0JSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLnu5PnrpfotKbmiLfvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCI0NC43NzMlIiwiMTUuMTI2JSIsIjMuOTI0JSIsYWNjb3VudCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiYWNjb3VudCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCI3MC41MjklIiwiMTAuODMxJSIsIjMuOTI0JSIsIuWkh+azqOS/oeaBr++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuODI5JSIsIjc4Ljg0MSUiLCIxNS4xMjYlIiwiMy45MjQlIixkYXRhKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJkYXRhIik7DQo=','销货退货单');
INSERT INTO `is_prints` (`id`,`name`,`paper4`,`paper2`,`paper4default`,`paper2default`,`data`) VALUES ('5','allocation','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi6LCD5ouo5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIuiwg+aLqOWNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJCb2xkIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNjIlIiwiMi4zMTclIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u5pel5pyf77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjYyJSIsIjEwLjA1JSIsIjE4LjA2JSIsIjIuMDUlIix0aW1lKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0aW1lIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy42MiUiLCIzNi4xOTYlIiwiMTAuMzI3JSIsIjIuMDUlIiwi5Y2V5o2u57yW5Y+377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjYyJSIsIjQ0LjQzMyUiLCIxOC4wNiUiLCIyLjA1JSIsbnVtYmVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJudW1iZXIiKTsNCkxPRE9QLkFERF9QUklOVF9UQUJMRSgiMTEuMjIxJSIsIjIuMDAzJSIsIjk1Ljk5NSUiLCI4MS42ODQlIixodG1sX3RhYmxlKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiVm9yaWVudCIsMyk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImh0bWxfdGFibGUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNDMlIiwiMy4xOTklIiwiMTAuMTI2JSIsIjIuMDUlIiwi5Yi25Y2V5Lq677yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiOS42OTglIiwiMTUuMTEzJSIsIjIuMDUlIix1c2VyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ1c2VyIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjM2LjgyNiUiLCIxMC44MzElIiwiMi4wNSUiLCLlpIfms6jkv6Hmga/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCI0NS4wODglIiwiMTUuMTEzJSIsIjIuMDUlIixkYXRhKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJkYXRhIik7DQo=','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi6LCD5ouo5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkxLjg0OCUiLCIwLjk5NSUiLCI5Mi4wMzglIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMy4yNTclIiwiNDAlIiwiMjAlIiwiNi4zMjQlIiwi6LCD5ouo5Y2VIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxNCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkFsaWdubWVudCIsMik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkJvbGQiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMzYyJSIsIjIuMzE3JSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7ml6XmnJ/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjM2MiUiLCIxMC4xNzYlIiwiMTguMDYlIiwiMy45MjQlIix0aW1lKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0aW1lIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjQwLjA2MyUiLCIxMC4wNzYlIiwiMy45MjQlIiwi5Y2V5o2u57yW5Y+377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4xNzElIiwiNDguMjEyJSIsIjE4LjA2JSIsIjMuOTI0JSIsbnVtYmVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJudW1iZXIiKTsNCkxPRE9QLkFERF9QUklOVF9UQUJMRSgiMTguNzgxJSIsIjIuMDAzJSIsIjk1Ljk5NSUiLCI3MC43MDUlIixodG1sX3RhYmxlKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiVm9yaWVudCIsMyk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImh0bWxfdGFibGUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My41ODElIiwiMi45NDclIiwiMTAuMTI2JSIsIjMuOTI0JSIsIuWItuWNleS6uu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNDQ4JSIsIjkuNTcyJSIsIjE1LjEyNiUiLCIzLjkyNCUiLHVzZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInVzZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My40NDglIiwiNDAuNDQxJSIsIjEwLjgzMSUiLCIzLjkyNCUiLCLlpIfms6jkv6Hmga/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjQ0OCUiLCI0OC42MTUlIiwiMTUuMTI2JSIsIjMuOTI0JSIsZGF0YSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiZGF0YSIpOw0K','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi6LCD5ouo5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIuiwg+aLqOWNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJCb2xkIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNjIlIiwiMi4zMTclIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u5pel5pyf77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjYyJSIsIjEwLjA1JSIsIjE4LjA2JSIsIjIuMDUlIix0aW1lKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0aW1lIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy42MiUiLCIzNi4xOTYlIiwiMTAuMzI3JSIsIjIuMDUlIiwi5Y2V5o2u57yW5Y+377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjYyJSIsIjQ0LjQzMyUiLCIxOC4wNiUiLCIyLjA1JSIsbnVtYmVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJudW1iZXIiKTsNCkxPRE9QLkFERF9QUklOVF9UQUJMRSgiMTEuMjIxJSIsIjIuMDAzJSIsIjk1Ljk5NSUiLCI4MS42ODQlIixodG1sX3RhYmxlKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiVm9yaWVudCIsMyk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImh0bWxfdGFibGUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNDMlIiwiMy4xOTklIiwiMTAuMTI2JSIsIjIuMDUlIiwi5Yi25Y2V5Lq677yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiOS42OTglIiwiMTUuMTEzJSIsIjIuMDUlIix1c2VyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ1c2VyIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjM2LjgyNiUiLCIxMC44MzElIiwiMi4wNSUiLCLlpIfms6jkv6Hmga/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCI0NS4wODglIiwiMTUuMTEzJSIsIjIuMDUlIixkYXRhKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJkYXRhIik7DQo=','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi6LCD5ouo5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkxLjg0OCUiLCIwLjk5NSUiLCI5Mi4wMzglIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMy4yNTclIiwiNDAlIiwiMjAlIiwiNi4zMjQlIiwi6LCD5ouo5Y2VIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxNCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkFsaWdubWVudCIsMik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkJvbGQiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMzYyJSIsIjIuMzE3JSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7ml6XmnJ/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjM2MiUiLCIxMC4xNzYlIiwiMTguMDYlIiwiMy45MjQlIix0aW1lKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0aW1lIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjQwLjA2MyUiLCIxMC4wNzYlIiwiMy45MjQlIiwi5Y2V5o2u57yW5Y+377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4xNzElIiwiNDguMjEyJSIsIjE4LjA2JSIsIjMuOTI0JSIsbnVtYmVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJudW1iZXIiKTsNCkxPRE9QLkFERF9QUklOVF9UQUJMRSgiMTguNzgxJSIsIjIuMDAzJSIsIjk1Ljk5NSUiLCI3MC43MDUlIixodG1sX3RhYmxlKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiVm9yaWVudCIsMyk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImh0bWxfdGFibGUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My41ODElIiwiMi45NDclIiwiMTAuMTI2JSIsIjMuOTI0JSIsIuWItuWNleS6uu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNDQ4JSIsIjkuNTcyJSIsIjE1LjEyNiUiLCIzLjkyNCUiLHVzZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInVzZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My40NDglIiwiNDAuNDQxJSIsIjEwLjgzMSUiLCIzLjkyNCUiLCLlpIfms6jkv6Hmga/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjQ0OCUiLCI0OC42MTUlIiwiMTUuMTI2JSIsIjMuOTI0JSIsZGF0YSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiZGF0YSIpOw0K','调拨单');
INSERT INTO `is_prints` (`id`,`name`,`paper4`,`paper2`,`paper4default`,`paper2default`,`data`) VALUES ('6','otpurchase','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi5YW25LuW5YWl5bqT5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIuWFtuS7luWFpeW6k+WNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJCb2xkIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNTMxJSIsIjUuNTkyJSIsIjEwLjA3NiUiLCIyLjA1JSIsIuWNleaNruaXpeacn++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy41MzElIiwiMTMuMzI1JSIsIjE4LjA2JSIsIjIuMDUlIix0aW1lKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0aW1lIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy41MzElIiwiMzcuMjA0JSIsIjEwLjA3NiUiLCIyLjA1JSIsIuWNleaNrue8luWPt++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy41MzElIiwiNDUuMzE1JSIsIjIxLjMzNSUiLCIyLjA1JSIsbnVtYmVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJudW1iZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjU1OCUiLCI3Mi43OTYlIiwiMTIuNTk0JSIsIjIuMDUlIiwi5Y2V5o2u57G75Z6L77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjU1OCUiLCI4MC44NTYlIiwiMTIuNTk0JSIsIjIuMDUlIixwYWdldHlwZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwicGFnZXR5cGUiKTsNCkxPRE9QLkFERF9QUklOVF9UQUJMRSgiMTEuMzElIiwiMi4wMDMlIiwiOTUuOTk1JSIsIjgxLjk1MiUiLGh0bWxfdGFibGUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJWb3JpZW50IiwzKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiaHRtbF90YWJsZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA0MyUiLCI1Ljg0NCUiLCIxMC4xMjYlIiwiMi4wNSUiLCLliLbljZXkurrvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCIxMi4zNDMlIiwiMTUuMTEzJSIsIjIuMDUlIix1c2VyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ1c2VyIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjM2LjclIiwiMTAuODMxJSIsIjIuMDUlIiwi5aSH5rOo5L+h5oGv77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiNDQuOTYyJSIsIjE1LjExMyUiLCIyLjA1JSIsZGF0YSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiZGF0YSIpOw0K','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi5YW25LuW5YWl5bqT5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkxLjg0OCUiLCIwLjk5NSUiLCI5Mi4wMzglIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMy4yNTclIiwiNDAlIiwiMjAlIiwiNi4zMjQlIiwi5YW25LuW5YWl5bqT5Y2VIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxNCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkFsaWdubWVudCIsMik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkJvbGQiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMzYyJSIsIjQuMDgxJSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7ml6XmnJ/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjM2MiUiLCIxMS44MTQlIiwiMTguMDYlIiwiMy45MjQlIix0aW1lKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0aW1lIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMzYyJSIsIjM1LjUyOSUiLCI5LjY5OCUiLCIzLjkyNCUiLCLljZXmja7nvJblj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjM2MiUiLCI0NC4wNTUlIiwiMjEuNTg3JSIsIjMuOTI0JSIsbnVtYmVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJudW1iZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zODElIiwiNzIuNzk2JSIsIjEyLjU5NCUiLCIzLjkyNCUiLCLljZXmja7nsbvlnovvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjM4MSUiLCI4MC43MyUiLCIxNC40ODQlIiwiMy45MjQlIixwYWdldHlwZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwicGFnZXR5cGUiKTsNCkxPRE9QLkFERF9QUklOVF9UQUJMRSgiMTguNzgxJSIsIjIuMDAzJSIsIjk1Ljk5NSUiLCI3MC44OTUlIixodG1sX3RhYmxlKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiVm9yaWVudCIsMyk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImh0bWxfdGFibGUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My43NzElIiwiNC41ODQlIiwiMTAuMTI2JSIsIjMuOTI0JSIsIuWItuWNleS6uu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNjM4JSIsIjExLjIwOSUiLCIxNS4xMjYlIiwiMy45MjQlIix1c2VyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ1c2VyIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNjM4JSIsIjM2LjE1OSUiLCIxMC44MzElIiwiMy45MjQlIiwi5aSH5rOo5L+h5oGv77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My42MzglIiwiNDQuMzMyJSIsIjE1LjEyNiUiLCIzLjkyNCUiLGRhdGEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImRhdGEiKTsNCg==','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi5YW25LuW5YWl5bqT5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIuWFtuS7luWFpeW6k+WNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJCb2xkIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNTMxJSIsIjUuNTkyJSIsIjEwLjA3NiUiLCIyLjA1JSIsIuWNleaNruaXpeacn++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy41MzElIiwiMTMuMzI1JSIsIjE4LjA2JSIsIjIuMDUlIix0aW1lKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0aW1lIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy41MzElIiwiMzcuMjA0JSIsIjEwLjA3NiUiLCIyLjA1JSIsIuWNleaNrue8luWPt++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy41MzElIiwiNDUuMzE1JSIsIjIxLjMzNSUiLCIyLjA1JSIsbnVtYmVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJudW1iZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjU1OCUiLCI3Mi43OTYlIiwiMTIuNTk0JSIsIjIuMDUlIiwi5Y2V5o2u57G75Z6L77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjU1OCUiLCI4MC44NTYlIiwiMTIuNTk0JSIsIjIuMDUlIixwYWdldHlwZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwicGFnZXR5cGUiKTsNCkxPRE9QLkFERF9QUklOVF9UQUJMRSgiMTEuMzElIiwiMi4wMDMlIiwiOTUuOTk1JSIsIjgxLjk1MiUiLGh0bWxfdGFibGUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJWb3JpZW50IiwzKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiaHRtbF90YWJsZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA0MyUiLCI1Ljg0NCUiLCIxMC4xMjYlIiwiMi4wNSUiLCLliLbljZXkurrvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCIxMi4zNDMlIiwiMTUuMTEzJSIsIjIuMDUlIix1c2VyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ1c2VyIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjM2LjclIiwiMTAuODMxJSIsIjIuMDUlIiwi5aSH5rOo5L+h5oGv77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiNDQuOTYyJSIsIjE1LjExMyUiLCIyLjA1JSIsZGF0YSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiZGF0YSIpOw0K','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi5YW25LuW5YWl5bqT5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkxLjg0OCUiLCIwLjk5NSUiLCI5Mi4wMzglIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMy4yNTclIiwiNDAlIiwiMjAlIiwiNi4zMjQlIiwi5YW25LuW5YWl5bqT5Y2VIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxNCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkFsaWdubWVudCIsMik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkJvbGQiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMzYyJSIsIjQuMDgxJSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7ml6XmnJ/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjM2MiUiLCIxMS44MTQlIiwiMTguMDYlIiwiMy45MjQlIix0aW1lKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0aW1lIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMzYyJSIsIjM1LjUyOSUiLCI5LjY5OCUiLCIzLjkyNCUiLCLljZXmja7nvJblj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjM2MiUiLCI0NC4wNTUlIiwiMjEuNTg3JSIsIjMuOTI0JSIsbnVtYmVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJudW1iZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zODElIiwiNzIuNzk2JSIsIjEyLjU5NCUiLCIzLjkyNCUiLCLljZXmja7nsbvlnovvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjM4MSUiLCI4MC43MyUiLCIxNC40ODQlIiwiMy45MjQlIixwYWdldHlwZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwicGFnZXR5cGUiKTsNCkxPRE9QLkFERF9QUklOVF9UQUJMRSgiMTguNzgxJSIsIjIuMDAzJSIsIjk1Ljk5NSUiLCI3MC44OTUlIixodG1sX3RhYmxlKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiVm9yaWVudCIsMyk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImh0bWxfdGFibGUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My43NzElIiwiNC41ODQlIiwiMTAuMTI2JSIsIjMuOTI0JSIsIuWItuWNleS6uu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNjM4JSIsIjExLjIwOSUiLCIxNS4xMjYlIiwiMy45MjQlIix1c2VyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ1c2VyIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNjM4JSIsIjM2LjE1OSUiLCIxMC44MzElIiwiMy45MjQlIiwi5aSH5rOo5L+h5oGv77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My42MzglIiwiNDQuMzMyJSIsIjE1LjEyNiUiLCIzLjkyNCUiLGRhdGEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImRhdGEiKTsNCg==','其他入库单');
INSERT INTO `is_prints` (`id`,`name`,`paper4`,`paper2`,`paper4default`,`paper2default`,`data`) VALUES ('7','otsale','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi5YW25LuW5Ye65bqT5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIuWFtuS7luWHuuW6k+WNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy41MzElIiwiNS41OTIlIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u5pel5pyf77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjUzMSUiLCIxMy4zMjUlIiwiMTguMDYlIiwiMi4wNSUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjUzMSUiLCIzNy4yMDQlIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u57yW5Y+377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjUzMSUiLCI0NS4zMTUlIiwiMjAuNTc5JSIsIjIuMDUlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNTU4JSIsIjcyLjc5NiUiLCIxMi41OTQlIiwiMi4wNSUiLCLljZXmja7nsbvlnovvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNTU4JSIsIjgwLjg1NiUiLCIxMi41OTQlIiwiMi4wNSUiLHBhZ2V0eXBlKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJwYWdldHlwZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIxMS4yMjElIiwiMi4wMDMlIiwiOTUuOTk1JSIsIjgxLjk1MiUiLGh0bWxfdGFibGUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJWb3JpZW50IiwzKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiaHRtbF90YWJsZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA0MyUiLCI1LjcxOCUiLCIxMC4xMjYlIiwiMi4wNSUiLCLliLbljZXkurrvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCIxMi4yMTclIiwiMTUuMTEzJSIsIjIuMDUlIix1c2VyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ1c2VyIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjMzLjkyOSUiLCIxMC44MzElIiwiMi4wNSUiLCLlpIfms6jkv6Hmga/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCI0Mi4xOTElIiwiMjYuODI2JSIsIjIuMDUlIixkYXRhKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJkYXRhIik7DQo=','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi5YW25LuW5Ye65bqT5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkxLjg0OCUiLCIwLjk5NSUiLCI5Mi4wMzglIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMy4yNTclIiwiNDAlIiwiMjAlIiwiNi4zMjQlIiwi5YW25LuW5Ye65bqT5Y2VIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxNCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkFsaWdubWVudCIsMik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkJvbGQiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMzYyJSIsIjQuMDgxJSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7ml6XmnJ/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjM2MiUiLCIxMS44MTQlIiwiMTIuMTQxJSIsIjMuOTI0JSIsdGltZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidGltZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjM2MiUiLCIzNy45MjIlIiwiMTAuMDc2JSIsIjMuOTI0JSIsIuWNleaNrue8luWPt++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMzYyJSIsIjQ1Ljk0NSUiLCIyMS4yMDklIiwiMy45MjQlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjM4MSUiLCI3Mi43OTYlIiwiMTIuNTk0JSIsIjMuOTI0JSIsIuWNleaNruexu+Wei++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMzgxJSIsIjgwLjczJSIsIjEyLjU5NCUiLCIzLjkyNCUiLHBhZ2V0eXBlKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJwYWdldHlwZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIxOC41OSUiLCIyLjAwMyUiLCI5NS45OTUlIiwiNzAuNzA1JSIsaHRtbF90YWJsZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIlZvcmllbnQiLDMpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJodG1sX3RhYmxlIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNzcxJSIsIjQuODM2JSIsIjEwLjEyNiUiLCIzLjkyNCUiLCLliLbljZXkurrvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjYzOCUiLCIxMS40NjElIiwiMTUuMTI2JSIsIjMuOTI0JSIsdXNlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidXNlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjYzOCUiLCIzOC4xNzQlIiwiMTAuMjAyJSIsIjMuOTI0JSIsIuWkh+azqOS/oeaBr++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNjM4JSIsIjQ2LjM0OCUiLCIxOC4yNzUlIiwiMy45MjQlIixkYXRhKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJkYXRhIik7DQo=','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi5YW25LuW5Ye65bqT5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIuWFtuS7luWHuuW6k+WNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy41MzElIiwiNS41OTIlIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u5pel5pyf77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjUzMSUiLCIxMy4zMjUlIiwiMTguMDYlIiwiMi4wNSUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjUzMSUiLCIzNy4yMDQlIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u57yW5Y+377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjUzMSUiLCI0NS4zMTUlIiwiMjAuNTc5JSIsIjIuMDUlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNTU4JSIsIjcyLjc5NiUiLCIxMi41OTQlIiwiMi4wNSUiLCLljZXmja7nsbvlnovvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNTU4JSIsIjgwLjg1NiUiLCIxMi41OTQlIiwiMi4wNSUiLHBhZ2V0eXBlKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJwYWdldHlwZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIxMS4yMjElIiwiMi4wMDMlIiwiOTUuOTk1JSIsIjgxLjk1MiUiLGh0bWxfdGFibGUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJWb3JpZW50IiwzKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiaHRtbF90YWJsZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA0MyUiLCI1LjcxOCUiLCIxMC4xMjYlIiwiMi4wNSUiLCLliLbljZXkurrvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCIxMi4yMTclIiwiMTUuMTEzJSIsIjIuMDUlIix1c2VyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ1c2VyIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjMzLjkyOSUiLCIxMC44MzElIiwiMi4wNSUiLCLlpIfms6jkv6Hmga/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCI0Mi4xOTElIiwiMjYuODI2JSIsIjIuMDUlIixkYXRhKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJkYXRhIik7DQo=','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi5YW25LuW5Ye65bqT5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkxLjg0OCUiLCIwLjk5NSUiLCI5Mi4wMzglIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMy4yNTclIiwiNDAlIiwiMjAlIiwiNi4zMjQlIiwi5YW25LuW5Ye65bqT5Y2VIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxNCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkFsaWdubWVudCIsMik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkJvbGQiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMzYyJSIsIjQuMDgxJSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7ml6XmnJ/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjM2MiUiLCIxMS44MTQlIiwiMTIuMTQxJSIsIjMuOTI0JSIsdGltZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidGltZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjM2MiUiLCIzNy45MjIlIiwiMTAuMDc2JSIsIjMuOTI0JSIsIuWNleaNrue8luWPt++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMzYyJSIsIjQ1Ljk0NSUiLCIyMS4yMDklIiwiMy45MjQlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjM4MSUiLCI3Mi43OTYlIiwiMTIuNTk0JSIsIjMuOTI0JSIsIuWNleaNruexu+Wei++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMzgxJSIsIjgwLjczJSIsIjEyLjU5NCUiLCIzLjkyNCUiLHBhZ2V0eXBlKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJwYWdldHlwZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIxOC41OSUiLCIyLjAwMyUiLCI5NS45OTUlIiwiNzAuNzA1JSIsaHRtbF90YWJsZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIlZvcmllbnQiLDMpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJodG1sX3RhYmxlIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNzcxJSIsIjQuODM2JSIsIjEwLjEyNiUiLCIzLjkyNCUiLCLliLbljZXkurrvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjYzOCUiLCIxMS40NjElIiwiMTUuMTI2JSIsIjMuOTI0JSIsdXNlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidXNlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjYzOCUiLCIzOC4xNzQlIiwiMTAuMjAyJSIsIjMuOTI0JSIsIuWkh+azqOS/oeaBr++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNjM4JSIsIjQ2LjM0OCUiLCIxOC4yNzUlIiwiMy45MjQlIixkYXRhKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJkYXRhIik7DQo=','其他出库单');
INSERT INTO `is_prints` (`id`,`name`,`paper4`,`paper2`,`paper4default`,`paper2default`,`data`) VALUES ('8','gather','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi5pS25qy+5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIuaUtuasvuWNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiMzYuNDQ4JSIsIjEwLjA3NiUiLCIyLjA1JSIsIuWNleaNruaXpeacn++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiNDQuNDMzJSIsIjE4LjA2JSIsIjIuMDUlIix0aW1lKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0aW1lIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiNzAuMzc4JSIsIjEwLjA3NiUiLCIyLjA1JSIsIuWNleaNrue8luWPt++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiNzguMTExJSIsIjE4LjA2JSIsIjIuMDUlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDY5JSIsIjUuNTA0JSIsIjEyLjU5NCUiLCIyLjA1JSIsIuWuouaIt+WQjeensO+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NjklIiwiMTMuMyUiLCIxMi41OTQlIiwiMi4wNSUiLGN1c3RvbWVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJjdXN0b21lciIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIxMS4zMSUiLCIyLjAwMyUiLCI5NS45OTUlIiwiODIuNDg3JSIsaHRtbF90YWJsZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIlZvcmllbnQiLDMpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJodG1sX3RhYmxlIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDQzJSIsIjUuMzQlIiwiMTAuMTI2JSIsIjIuMDUlIiwi5Yi25Y2V5Lq677yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiMTEuODM5JSIsIjE1LjExMyUiLCIyLjA1JSIsdXNlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidXNlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCIzNi44MjYlIiwiMTAuODMxJSIsIjIuMDUlIiwi5aSH5rOo5L+h5oGv77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiNDUuMDg4JSIsIjE1LjExMyUiLCIyLjA1JSIsZGF0YSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiZGF0YSIpOw0K','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi5pS25qy+5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkxLjg0OCUiLCIwLjk5NSUiLCI5Mi4wMzglIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMy4yNTclIiwiNDAlIiwiMjAlIiwiNi4zMjQlIiwi5pS25qy+5Y2VIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxNCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkFsaWdubWVudCIsMik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkJvbGQiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjM3LjMzJSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7ml6XmnJ/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE3MSUiLCI0NC45MzclIiwiMTguMDYlIiwiMy45MjQlIix0aW1lKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0aW1lIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjcwJSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7nvJblj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE3MSUiLCI3OC4yMzclIiwiMTguNjklIiwiMy45MjQlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE5JSIsIjYuMjU5JSIsIjEyLjU5NCUiLCIzLjkyNCUiLCLlrqLmiLflkI3np7DvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE5JSIsIjE0LjA1NSUiLCIxMi41OTQlIiwiMy45MjQlIixjdXN0b21lcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiY3VzdG9tZXIiKTsNCkxPRE9QLkFERF9QUklOVF9UQUJMRSgiMTguOTcxJSIsIjIuMDAzJSIsIjk1Ljk5NSUiLCI3MS4wODYlIixodG1sX3RhYmxlKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiVm9yaWVudCIsMyk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImh0bWxfdGFibGUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My43NzElIiwiNi4wOTYlIiwiMTAuMTI2JSIsIjMuOTI0JSIsIuWItuWNleS6uu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNjM4JSIsIjEyLjcyJSIsIjE1LjEyNiUiLCIzLjkyNCUiLHVzZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInVzZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My44MjklIiwiMzcuOTIyJSIsIjEwLjgzMSUiLCIzLjkyNCUiLCLlpIfms6jkv6Hmga/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCI0Ni4wOTYlIiwiMTUuMTI2JSIsIjMuOTI0JSIsZGF0YSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiZGF0YSIpOw0K','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi5pS25qy+5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIuaUtuasvuWNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiMzYuNDQ4JSIsIjEwLjA3NiUiLCIyLjA1JSIsIuWNleaNruaXpeacn++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiNDQuNDMzJSIsIjE4LjA2JSIsIjIuMDUlIix0aW1lKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0aW1lIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiNzAuMzc4JSIsIjEwLjA3NiUiLCIyLjA1JSIsIuWNleaNrue8luWPt++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiNzguMTExJSIsIjE4LjA2JSIsIjIuMDUlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDY5JSIsIjUuNTA0JSIsIjEyLjU5NCUiLCIyLjA1JSIsIuWuouaIt+WQjeensO+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NjklIiwiMTMuMyUiLCIxMi41OTQlIiwiMi4wNSUiLGN1c3RvbWVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJjdXN0b21lciIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIxMS4zMSUiLCIyLjAwMyUiLCI5NS45OTUlIiwiODIuNDg3JSIsaHRtbF90YWJsZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIlZvcmllbnQiLDMpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJodG1sX3RhYmxlIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDQzJSIsIjUuMzQlIiwiMTAuMTI2JSIsIjIuMDUlIiwi5Yi25Y2V5Lq677yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiMTEuODM5JSIsIjE1LjExMyUiLCIyLjA1JSIsdXNlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidXNlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCIzNi44MjYlIiwiMTAuODMxJSIsIjIuMDUlIiwi5aSH5rOo5L+h5oGv77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiNDUuMDg4JSIsIjE1LjExMyUiLCIyLjA1JSIsZGF0YSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiZGF0YSIpOw0K','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi5pS25qy+5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkxLjg0OCUiLCIwLjk5NSUiLCI5Mi4wMzglIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMy4yNTclIiwiNDAlIiwiMjAlIiwiNi4zMjQlIiwi5pS25qy+5Y2VIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxNCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkFsaWdubWVudCIsMik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkJvbGQiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjM3LjMzJSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7ml6XmnJ/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE3MSUiLCI0NC45MzclIiwiMTguMDYlIiwiMy45MjQlIix0aW1lKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0aW1lIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjcwJSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7nvJblj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE3MSUiLCI3OC4yMzclIiwiMTguNjklIiwiMy45MjQlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE5JSIsIjYuMjU5JSIsIjEyLjU5NCUiLCIzLjkyNCUiLCLlrqLmiLflkI3np7DvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE5JSIsIjE0LjA1NSUiLCIxMi41OTQlIiwiMy45MjQlIixjdXN0b21lcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiY3VzdG9tZXIiKTsNCkxPRE9QLkFERF9QUklOVF9UQUJMRSgiMTguOTcxJSIsIjIuMDAzJSIsIjk1Ljk5NSUiLCI3MS4wODYlIixodG1sX3RhYmxlKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiVm9yaWVudCIsMyk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImh0bWxfdGFibGUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My43NzElIiwiNi4wOTYlIiwiMTAuMTI2JSIsIjMuOTI0JSIsIuWItuWNleS6uu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNjM4JSIsIjEyLjcyJSIsIjE1LjEyNiUiLCIzLjkyNCUiLHVzZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInVzZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My44MjklIiwiMzcuOTIyJSIsIjEwLjgzMSUiLCIzLjkyNCUiLCLlpIfms6jkv6Hmga/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCI0Ni4wOTYlIiwiMTUuMTI2JSIsIjMuOTI0JSIsZGF0YSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiZGF0YSIpOw0K','收款单');
INSERT INTO `is_prints` (`id`,`name`,`paper4`,`paper2`,`paper4default`,`paper2default`,`data`) VALUES ('9','payment','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi5LuY5qy+5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIuS7mOasvuWNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiMzYuNDQ4JSIsIjEwLjA3NiUiLCIyLjA1JSIsIuWNleaNruaXpeacn++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiNDQuNDMzJSIsIjE4LjA2JSIsIjIuMDUlIix0aW1lKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0aW1lIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiNzAuMzc4JSIsIjEwLjA3NiUiLCIyLjA1JSIsIuWNleaNrue8luWPt++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiNzguMTExJSIsIjE4LjA2JSIsIjIuMDUlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDY5JSIsIjUuNTA0JSIsIjEyLjU5NCUiLCIyLjA1JSIsIuS+m+W6lOWVhu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NjklIiwiMTMuMyUiLCIxMi41OTQlIiwiMi4wNSUiLHN1cHBsaWVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJzdXBwbGllciIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIxMS4yMjElIiwiMi4wMDMlIiwiOTUuOTk1JSIsIjgyLjQ4NyUiLGh0bWxfdGFibGUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJWb3JpZW50IiwzKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiaHRtbF90YWJsZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA0MyUiLCI0LjQ1OCUiLCIxMC4xMjYlIiwiMi4wNSUiLCLliLbljZXkurrvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCIxMC45NTclIiwiMTUuMTEzJSIsIjIuMDUlIix1c2VyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ1c2VyIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjM1LjMxNSUiLCIxMC44MzElIiwiMi4wNSUiLCLlpIfms6jkv6Hmga/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCI0My41NzclIiwiMTUuMTEzJSIsIjIuMDUlIixkYXRhKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJkYXRhIik7DQo=','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi5LuY5qy+5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkxLjg0OCUiLCIwLjk5NSUiLCI5Mi4wMzglIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMy4yNTclIiwiNDAlIiwiMjAlIiwiNi4zMjQlIiwi5LuY5qy+5Y2VIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxNCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkFsaWdubWVudCIsMik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkJvbGQiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjM3LjMzJSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7ml6XmnJ/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE3MSUiLCI0NC45MzclIiwiMTguMDYlIiwiMy45MjQlIix0aW1lKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0aW1lIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjcwJSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7nvJblj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE3MSUiLCI3OC4yMzclIiwiMTguMDYlIiwiMy45MjQlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE5JSIsIjYuMjU5JSIsIjEyLjU5NCUiLCIzLjkyNCUiLCLkvpvlupTllYbvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE5JSIsIjE0LjA1NSUiLCIxMi41OTQlIiwiMy45MjQlIixzdXBwbGllcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwic3VwcGxpZXIiKTsNCkxPRE9QLkFERF9QUklOVF9UQUJMRSgiMTguOTcxJSIsIjIuMDAzJSIsIjk1Ljk5NSUiLCI3MC41MTQlIixodG1sX3RhYmxlKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiVm9yaWVudCIsMyk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImh0bWxfdGFibGUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My43NzElIiwiNy42MDclIiwiMTAuMTI2JSIsIjMuOTI0JSIsIuWItuWNleS6uu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNjM4JSIsIjE0LjIzMiUiLCIxNS4xMjYlIiwiMy45MjQlIix1c2VyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ1c2VyIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNjM4JSIsIjM3Ljc5NiUiLCIxMS4yMDklIiwiMy45MjQlIiwi5aSH5rOo5L+h5oGv77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My42MzglIiwiNDYuMzQ4JSIsIjE1LjEyNiUiLCIzLjkyNCUiLGRhdGEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImRhdGEiKTsNCg==','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi5LuY5qy+5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIuS7mOasvuWNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiMzYuNDQ4JSIsIjEwLjA3NiUiLCIyLjA1JSIsIuWNleaNruaXpeacn++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiNDQuNDMzJSIsIjE4LjA2JSIsIjIuMDUlIix0aW1lKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0aW1lIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiNzAuMzc4JSIsIjEwLjA3NiUiLCIyLjA1JSIsIuWNleaNrue8luWPt++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiNzguMTExJSIsIjE4LjA2JSIsIjIuMDUlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDY5JSIsIjUuNTA0JSIsIjEyLjU5NCUiLCIyLjA1JSIsIuS+m+W6lOWVhu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NjklIiwiMTMuMyUiLCIxMi41OTQlIiwiMi4wNSUiLHN1cHBsaWVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJzdXBwbGllciIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIxMS4yMjElIiwiMi4wMDMlIiwiOTUuOTk1JSIsIjgyLjQ4NyUiLGh0bWxfdGFibGUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJWb3JpZW50IiwzKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiaHRtbF90YWJsZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA0MyUiLCI0LjQ1OCUiLCIxMC4xMjYlIiwiMi4wNSUiLCLliLbljZXkurrvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCIxMC45NTclIiwiMTUuMTEzJSIsIjIuMDUlIix1c2VyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ1c2VyIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjM1LjMxNSUiLCIxMC44MzElIiwiMi4wNSUiLCLlpIfms6jkv6Hmga/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCI0My41NzclIiwiMTUuMTEzJSIsIjIuMDUlIixkYXRhKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJkYXRhIik7DQo=','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi5LuY5qy+5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkxLjg0OCUiLCIwLjk5NSUiLCI5Mi4wMzglIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMy4yNTclIiwiNDAlIiwiMjAlIiwiNi4zMjQlIiwi5LuY5qy+5Y2VIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxNCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkFsaWdubWVudCIsMik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkJvbGQiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjM3LjMzJSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7ml6XmnJ/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE3MSUiLCI0NC45MzclIiwiMTguMDYlIiwiMy45MjQlIix0aW1lKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0aW1lIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjcwJSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7nvJblj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE3MSUiLCI3OC4yMzclIiwiMTguMDYlIiwiMy45MjQlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE5JSIsIjYuMjU5JSIsIjEyLjU5NCUiLCIzLjkyNCUiLCLkvpvlupTllYbvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE5JSIsIjE0LjA1NSUiLCIxMi41OTQlIiwiMy45MjQlIixzdXBwbGllcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwic3VwcGxpZXIiKTsNCkxPRE9QLkFERF9QUklOVF9UQUJMRSgiMTguOTcxJSIsIjIuMDAzJSIsIjk1Ljk5NSUiLCI3MC41MTQlIixodG1sX3RhYmxlKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiVm9yaWVudCIsMyk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImh0bWxfdGFibGUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My43NzElIiwiNy42MDclIiwiMTAuMTI2JSIsIjMuOTI0JSIsIuWItuWNleS6uu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNjM4JSIsIjE0LjIzMiUiLCIxNS4xMjYlIiwiMy45MjQlIix1c2VyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ1c2VyIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNjM4JSIsIjM3Ljc5NiUiLCIxMS4yMDklIiwiMy45MjQlIiwi5aSH5rOo5L+h5oGv77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My42MzglIiwiNDYuMzQ4JSIsIjE1LjEyNiUiLCIzLjkyNCUiLGRhdGEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImRhdGEiKTsNCg==','付款单');
INSERT INTO `is_prints` (`id`,`name`,`paper4`,`paper2`,`paper4default`,`paper2default`,`data`) VALUES ('10','otgather','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi5YW25LuW5pS25YWl5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIuWFtuS7luaUtuWFpeWNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiMy45NTUlIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u5pel5pyf77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIxMS41NjIlIiwiMTguMDYlIiwiMi4wNSUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIzNy43MDglIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u57yW5Y+377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI0NS40MDMlIiwiMjIuNDY5JSIsIjIuMDUlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIxMS4yMjElIiwiMi4wMDMlIiwiOTUuOTk1JSIsIjc0LjM3NiUiLGh0bWxfdGFibGUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJWb3JpZW50IiwzKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiaHRtbF90YWJsZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA0MyUiLCI1Ljg0NCUiLCIxMC4xMjYlIiwiMi4wNSUiLCLliLbljZXkurrvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCIxMi4zNDMlIiwiMTUuMTEzJSIsIjIuMDUlIix1c2VyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ1c2VyIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjM3Ljk2JSIsIjEwLjgzMSUiLCIyLjA1JSIsIuWkh+azqOS/oeaBr++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjQ2LjIyMiUiLCIxNS4xMTMlIiwiMi4wNSUiLGRhdGEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImRhdGEiKTsNCg==','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi5YW25LuW5pS25YWl5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkxLjg0OCUiLCIwLjk5NSUiLCI5Mi4wMzglIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMy4yNTclIiwiNDAlIiwiMjAlIiwiNi4zMjQlIiwi5YW25LuW5pS25YWl5Y2VIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxNCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkFsaWdubWVudCIsMik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkJvbGQiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjQuODM2JSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7ml6XmnJ/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE3MSUiLCIxMi41OTQlIiwiMTguMDYlIiwiMy45MjQlIix0aW1lKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0aW1lIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjM3LjE2NiUiLCIxMC4wNzYlIiwiMy45MjQlIiwi5Y2V5o2u57yW5Y+377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4xNzElIiwiNDQuOTg3JSIsIjIzLjcyOCUiLCIzLjkyNCUiLG51bWJlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwibnVtYmVyIik7DQpMT0RPUC5BRERfUFJJTlRfVEFCTEUoIjE4Ljk3MSUiLCIyLjAwMyUiLCI5NS45OTUlIiwiNzAuMTMzJSIsaHRtbF90YWJsZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIlZvcmllbnQiLDMpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJodG1sX3RhYmxlIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNzcxJSIsIjUuNzE4JSIsIjEwLjEyNiUiLCIzLjkyNCUiLCLliLbljZXkurrvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjYzOCUiLCIxMi4zNDMlIiwiMTUuMTI2JSIsIjMuOTI0JSIsdXNlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidXNlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCIzNi45MTQlIiwiMTAuODMxJSIsIjMuOTI0JSIsIuWkh+azqOS/oeaBr++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuODI5JSIsIjQ1LjA4OCUiLCIxNS4xMjYlIiwiMy45MjQlIixkYXRhKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJkYXRhIik7DQo=','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi5YW25LuW5pS25YWl5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIuWFtuS7luaUtuWFpeWNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiMy45NTUlIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u5pel5pyf77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIxMS41NjIlIiwiMTguMDYlIiwiMi4wNSUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIzNy43MDglIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u57yW5Y+377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI0NS40MDMlIiwiMjIuNDY5JSIsIjIuMDUlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIxMS4yMjElIiwiMi4wMDMlIiwiOTUuOTk1JSIsIjc0LjM3NiUiLGh0bWxfdGFibGUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJWb3JpZW50IiwzKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiaHRtbF90YWJsZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA0MyUiLCI1Ljg0NCUiLCIxMC4xMjYlIiwiMi4wNSUiLCLliLbljZXkurrvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCIxMi4zNDMlIiwiMTUuMTEzJSIsIjIuMDUlIix1c2VyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ1c2VyIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjM3Ljk2JSIsIjEwLjgzMSUiLCIyLjA1JSIsIuWkh+azqOS/oeaBr++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjQ2LjIyMiUiLCIxNS4xMTMlIiwiMi4wNSUiLGRhdGEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImRhdGEiKTsNCg==','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi5YW25LuW5pS25YWl5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkxLjg0OCUiLCIwLjk5NSUiLCI5Mi4wMzglIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMy4yNTclIiwiNDAlIiwiMjAlIiwiNi4zMjQlIiwi5YW25LuW5pS25YWl5Y2VIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxNCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkFsaWdubWVudCIsMik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkJvbGQiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjQuODM2JSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7ml6XmnJ/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE3MSUiLCIxMi41OTQlIiwiMTguMDYlIiwiMy45MjQlIix0aW1lKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0aW1lIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjM3LjE2NiUiLCIxMC4wNzYlIiwiMy45MjQlIiwi5Y2V5o2u57yW5Y+377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4xNzElIiwiNDQuOTg3JSIsIjIzLjcyOCUiLCIzLjkyNCUiLG51bWJlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwibnVtYmVyIik7DQpMT0RPUC5BRERfUFJJTlRfVEFCTEUoIjE4Ljk3MSUiLCIyLjAwMyUiLCI5NS45OTUlIiwiNzAuMTMzJSIsaHRtbF90YWJsZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIlZvcmllbnQiLDMpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJodG1sX3RhYmxlIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNzcxJSIsIjUuNzE4JSIsIjEwLjEyNiUiLCIzLjkyNCUiLCLliLbljZXkurrvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjYzOCUiLCIxMi4zNDMlIiwiMTUuMTI2JSIsIjMuOTI0JSIsdXNlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidXNlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCIzNi45MTQlIiwiMTAuODMxJSIsIjMuOTI0JSIsIuWkh+azqOS/oeaBr++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuODI5JSIsIjQ1LjA4OCUiLCIxNS4xMjYlIiwiMy45MjQlIixkYXRhKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJkYXRhIik7DQo=','其他收入单');
INSERT INTO `is_prints` (`id`,`name`,`paper4`,`paper2`,`paper4default`,`paper2default`,`data`) VALUES ('11','otpayment','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi5YW25LuW5pSv5Ye65Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIuWFtuS7luaUr+WHuuWNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiNC4yMDclIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u5pel5pyf77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIxMS44MTQlIiwiMTguMDYlIiwiMi4wNSUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIzNy45MjIlIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u57yW5Y+377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI0NS43NDMlIiwiMjAuNTc5JSIsIjIuMDUlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIxMS4zMSUiLCIyLjAwMyUiLCI5NS45OTUlIiwiODIuNDg3JSIsaHRtbF90YWJsZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIlZvcmllbnQiLDMpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJodG1sX3RhYmxlIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDQzJSIsIjQuOTYyJSIsIjEwLjEyNiUiLCIyLjA1JSIsIuWItuWNleS6uu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjExLjQ2MSUiLCIxNS4xMTMlIiwiMi4wNSUiLHVzZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInVzZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiMzUuNTY3JSIsIjEwLjgzMSUiLCIyLjA1JSIsIuWkh+azqOS/oeaBr++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjQzLjgyOSUiLCIxNS4xMTMlIiwiMi4wNSUiLGRhdGEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImRhdGEiKTsNCg==','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi5YW25LuW5pSv5Ye65Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkxLjg0OCUiLCIwLjk5NSUiLCI5Mi4wMzglIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMy4yNTclIiwiNDAlIiwiMjAlIiwiNi4zMjQlIiwi5YW25LuW5pSv5Ye65Y2VIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxNCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkFsaWdubWVudCIsMik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkJvbGQiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjMuODI5JSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7ml6XmnJ/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE3MSUiLCIxMS42ODglIiwiMTguMDYlIiwiMy45MjQlIix0aW1lKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0aW1lIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjM4LjMlIiwiMTAuMDc2JSIsIjMuOTI0JSIsIuWNleaNrue8luWPt++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjQ2LjEyMSUiLCIyMC41NzklIiwiMy45MjQlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIxOC41OSUiLCIyLjAwMyUiLCI5NS45OTUlIiwiNzAuNzA1JSIsaHRtbF90YWJsZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIlZvcmllbnQiLDMpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJodG1sX3RhYmxlIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNzcxJSIsIjQuMzMyJSIsIjEwLjEyNiUiLCIzLjkyNCUiLCLliLbljZXkurrvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjYzOCUiLCIxMC45NTclIiwiMTUuMTI2JSIsIjMuOTI0JSIsdXNlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidXNlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCIzOC40MjYlIiwiMTAuODMxJSIsIjMuOTI0JSIsIuWkh+azqOS/oeaBr++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuODI5JSIsIjQ2LjU5OSUiLCIxNy42NDUlIiwiMy45MjQlIixkYXRhKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJkYXRhIik7DQo=','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi5YW25LuW5pSv5Ye65Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIuWFtuS7luaUr+WHuuWNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiNC4yMDclIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u5pel5pyf77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIxMS44MTQlIiwiMTguMDYlIiwiMi4wNSUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIzNy45MjIlIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u57yW5Y+377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI0NS43NDMlIiwiMjAuNTc5JSIsIjIuMDUlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIxMS4zMSUiLCIyLjAwMyUiLCI5NS45OTUlIiwiODIuNDg3JSIsaHRtbF90YWJsZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIlZvcmllbnQiLDMpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJodG1sX3RhYmxlIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDQzJSIsIjQuOTYyJSIsIjEwLjEyNiUiLCIyLjA1JSIsIuWItuWNleS6uu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjExLjQ2MSUiLCIxNS4xMTMlIiwiMi4wNSUiLHVzZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInVzZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiMzUuNTY3JSIsIjEwLjgzMSUiLCIyLjA1JSIsIuWkh+azqOS/oeaBr++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjQzLjgyOSUiLCIxNS4xMTMlIiwiMi4wNSUiLGRhdGEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImRhdGEiKTsNCg==','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi5YW25LuW5pSv5Ye65Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkxLjg0OCUiLCIwLjk5NSUiLCI5Mi4wMzglIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMy4yNTclIiwiNDAlIiwiMjAlIiwiNi4zMjQlIiwi5YW25LuW5pSv5Ye65Y2VIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxNCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkFsaWdubWVudCIsMik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkJvbGQiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjMuODI5JSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7ml6XmnJ/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE3MSUiLCIxMS42ODglIiwiMTguMDYlIiwiMy45MjQlIix0aW1lKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0aW1lIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjM4LjMlIiwiMTAuMDc2JSIsIjMuOTI0JSIsIuWNleaNrue8luWPt++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjQ2LjEyMSUiLCIyMC41NzklIiwiMy45MjQlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIxOC41OSUiLCIyLjAwMyUiLCI5NS45OTUlIiwiNzAuNzA1JSIsaHRtbF90YWJsZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIlZvcmllbnQiLDMpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJodG1sX3RhYmxlIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNzcxJSIsIjQuMzMyJSIsIjEwLjEyNiUiLCIzLjkyNCUiLCLliLbljZXkurrvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjYzOCUiLCIxMC45NTclIiwiMTUuMTI2JSIsIjMuOTI0JSIsdXNlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidXNlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCIzOC40MjYlIiwiMTAuODMxJSIsIjMuOTI0JSIsIuWkh+azqOS/oeaBr++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuODI5JSIsIjQ2LjU5OSUiLCIxNy42NDUlIiwiMy45MjQlIixkYXRhKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJkYXRhIik7DQo=','其他支出单');
INSERT INTO `is_prints` (`id`,`name`,`paper4`,`paper2`,`paper4default`,`paper2default`,`data`) VALUES ('12','cashier','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi6Zu25ZSu5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkwLjA1MyUiLCIwLjk5NSUiLDEwMTEsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIumbtuWUruWNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJCb2xkIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjMuODc5JSIsIjkuODc0JSIsIjIuMDUlIiwi6LSt5Lmw5a6i5oi377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIxMS44MTQlIiwiMTcuNDMxJSIsIjIuMDUlIixjdXN0b21lcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiY3VzdG9tZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIzNS4yMzklIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u5pel5pyf77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI0My40MjYlIiwiMTguMDYlIiwiMi4wNSUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI3MC4yNTIlIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u57yW5Y+377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI3OC4xODYlIiwiMTguMDYlIiwiMi4wNSUiLG51bWJlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwibnVtYmVyIik7DQpMT0RPUC5BRERfUFJJTlRfVEFCTEUoIjExLjIyMSUiLCIyLjAwMyUiLCI5NS45OTUlIiwiNzcuMDUlIixodG1sX3RhYmxlKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiVm9yaWVudCIsMyk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImh0bWxfdGFibGUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiMy44NzklIiwiMTAuMTI2JSIsIjIuMDUlIiwi5Y2V5o2u6YeR6aKd77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiMTEuODE0JSIsIjEyLjAwMyUiLCIyLjA1JSIsdG90YWwpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRvdGFsIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNjc2JSIsIjMwLjMyNyUiLCIxMC4xMjYlIiwiMi4wNSUiLCLlrp7pmYXph5Hpop06Iik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiMzcuODg0JSIsIjEyLjAwMyUiLCIyLjA1JSIsYWN0dWFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJhY3R1YWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiNTUuMDEzJSIsIjEwLjEyNiUiLCIyLjA1JSIsIuWunuaUtumHkeminToiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkxLjY3NiUiLCI2Mi41NjklIiwiMTIuMDAzJSIsIjIuMDUlIixtb25leSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwibW9uZXkiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNDMlIiwiMy44NzklIiwiOC4yMzclIiwiMi4wNSUiLCLliLbljZXkurrvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCIxMC41NzklIiwiMTUuMTEzJSIsIjIuMDUlIix1c2VyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ1c2VyIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjM4Ljc5MSUiLCIxMC4wNzYlIiwiMi4wNSUiLCLku5jmrL7mlrnlvI/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCI0Ny4xMDMlIiwiMTUuMTEzJSIsIjIuMDUlIixwYXl0eXBlKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJwYXl0eXBlIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNzExJSIsIjc3LjMzJSIsIjEwLjA3NiUiLCIyLjA1JSIsIui1oOmAgeenr+WIhu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNzExJSIsIjg0Ljg4NyUiLCIxMi4wMDMlIiwiMi4wNSUiLGludGVncmFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJpbnRlZ3JhbCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCI3My41NTIlIiwiMTAuODMxJSIsIjIuMDUlIiwi5aSH5rOo5L+h5oGv77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiODEuODY0JSIsIjE1LjExMyUiLCIyLjA1JSIsZGF0YSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiZGF0YSIpOw0K','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi6Zu25ZSu5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjg1LjUyNCUiLCIwLjk5NSUiLCI4NS43MTQlIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiOTEuODQ4JSIsIjAuOTk1JSIsIjkyLjAzOCUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIzLjI1NyUiLCI0MCUiLCIyMCUiLCI2LjMyNCUiLCLpm7bllK7ljZUiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDE0KTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQWxpZ25tZW50IiwyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQm9sZCIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMy44NzklIiwiOS44NzQlIiwiMy45MjQlIiwi6LSt5Lmw5a6i5oi377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMTEuODE0JSIsIjE3LjQzMSUiLCIzLjkyNCUiLGN1c3RvbWVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJjdXN0b21lciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE3MSUiLCIzNS4yMzklIiwiMTAuMDc2JSIsIjMuOTI0JSIsIuWNleaNruaXpeacn++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjQzLjQyNiUiLCIxOC4wNiUiLCIzLjkyNCUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMS45ODElIiwiNzAuMjUyJSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7nvJblj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjExLjk4MSUiLCI3OC4xODYlIiwiMTguMDYlIiwiMy45MjQlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIyMC4zMDUlIiwiMi4wMDMlIiwiOTUuOTk1JSIsIjYxLjE4MSUiLGh0bWxfdGFibGUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJWb3JpZW50IiwzKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiaHRtbF90YWJsZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCIzLjg3OSUiLCIxMC4xMjYlIiwiMy45MjQlIiwi5Y2V5o2u6YeR6aKd77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI4Ni45NTIlIiwiMTIuMDY1JSIsIjEyLjAwMyUiLCIzLjkyNCUiLHRvdGFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0b3RhbCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCIyOC41NjQlIiwiMTAuMTI2JSIsIjMuOTI0JSIsIuWunumZhemHkeminToiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCIzNi4zNzMlIiwiMTIuMDAzJSIsIjMuOTI0JSIsYWN0dWFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJhY3R1YWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI4Ni45NTIlIiwiNTEuOTklIiwiMTAuMTI2JSIsIjMuOTI0JSIsIuWunuaUtumHkeminToiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCI1OS41NDclIiwiMTIuMDAzJSIsIjMuOTI0JSIsbW9uZXkpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm1vbmV5Iik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNzcxJSIsIjMuODc5JSIsIjguMjM3JSIsIjMuOTI0JSIsIuWItuWNleS6uu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNjM4JSIsIjEwLjU3OSUiLCIxNS4xMjYlIiwiMy45MjQlIix1c2VyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ1c2VyIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuODI5JSIsIjM3LjY3JSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLku5jmrL7mlrnlvI/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCI0NS41MjklIiwiMTUuMTI2JSIsIjMuOTI0JSIscGF5dHlwZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwicGF5dHlwZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljc4MSUiLCI3Ni41ODclIiwiMTAuMDc2JSIsIjMuOTI0JSIsIui1oOmAgeenr+WIhu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiODYuNzgxJSIsIjg0LjMyJSIsIjEyLjAwMyUiLCIzLjkyNCUiLGludGVncmFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJpbnRlZ3JhbCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCI3Mi45MjIlIiwiMTAuODMxJSIsIjMuOTI0JSIsIuWkh+azqOS/oeaBr++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuODI5JSIsIjgxLjIzNCUiLCIxNS4xMjYlIiwiMy45MjQlIixkYXRhKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJkYXRhIik7DQo=','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi6Zu25ZSu5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkwLjA1MyUiLCIwLjk5NSUiLDEwMTEsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIumbtuWUruWNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJCb2xkIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjMuODc5JSIsIjkuODc0JSIsIjIuMDUlIiwi6LSt5Lmw5a6i5oi377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIxMS44MTQlIiwiMTcuNDMxJSIsIjIuMDUlIixjdXN0b21lcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiY3VzdG9tZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIzNS4yMzklIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u5pel5pyf77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI0My40MjYlIiwiMTguMDYlIiwiMi4wNSUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI3MC4yNTIlIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u57yW5Y+377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI3OC4xODYlIiwiMTguMDYlIiwiMi4wNSUiLG51bWJlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwibnVtYmVyIik7DQpMT0RPUC5BRERfUFJJTlRfVEFCTEUoIjExLjIyMSUiLCIyLjAwMyUiLCI5NS45OTUlIiwiNzcuMDUlIixodG1sX3RhYmxlKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiVm9yaWVudCIsMyk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImh0bWxfdGFibGUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiMy44NzklIiwiMTAuMTI2JSIsIjIuMDUlIiwi5Y2V5o2u6YeR6aKd77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiMTEuODE0JSIsIjEyLjAwMyUiLCIyLjA1JSIsdG90YWwpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRvdGFsIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNjc2JSIsIjMwLjMyNyUiLCIxMC4xMjYlIiwiMi4wNSUiLCLlrp7pmYXph5Hpop06Iik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiMzcuODg0JSIsIjEyLjAwMyUiLCIyLjA1JSIsYWN0dWFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJhY3R1YWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiNTUuMDEzJSIsIjEwLjEyNiUiLCIyLjA1JSIsIuWunuaUtumHkeminToiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkxLjY3NiUiLCI2Mi41NjklIiwiMTIuMDAzJSIsIjIuMDUlIixtb25leSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwibW9uZXkiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNDMlIiwiMy44NzklIiwiOC4yMzclIiwiMi4wNSUiLCLliLbljZXkurrvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCIxMC41NzklIiwiMTUuMTEzJSIsIjIuMDUlIix1c2VyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ1c2VyIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjM4Ljc5MSUiLCIxMC4wNzYlIiwiMi4wNSUiLCLku5jmrL7mlrnlvI/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCI0Ny4xMDMlIiwiMTUuMTEzJSIsIjIuMDUlIixwYXl0eXBlKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJwYXl0eXBlIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNzExJSIsIjc3LjMzJSIsIjEwLjA3NiUiLCIyLjA1JSIsIui1oOmAgeenr+WIhu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNzExJSIsIjg0Ljg4NyUiLCIxMi4wMDMlIiwiMi4wNSUiLGludGVncmFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJpbnRlZ3JhbCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCI3My41NTIlIiwiMTAuODMxJSIsIjIuMDUlIiwi5aSH5rOo5L+h5oGv77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiODEuODY0JSIsIjE1LjExMyUiLCIyLjA1JSIsZGF0YSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiZGF0YSIpOw0K','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi6Zu25ZSu5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjg1LjUyNCUiLCIwLjk5NSUiLCI4NS43MTQlIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiOTEuODQ4JSIsIjAuOTk1JSIsIjkyLjAzOCUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIzLjI1NyUiLCI0MCUiLCIyMCUiLCI2LjMyNCUiLCLpm7bllK7ljZUiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDE0KTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQWxpZ25tZW50IiwyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQm9sZCIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMy44NzklIiwiOS44NzQlIiwiMy45MjQlIiwi6LSt5Lmw5a6i5oi377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMTEuODE0JSIsIjE3LjQzMSUiLCIzLjkyNCUiLGN1c3RvbWVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJjdXN0b21lciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE3MSUiLCIzNS4yMzklIiwiMTAuMDc2JSIsIjMuOTI0JSIsIuWNleaNruaXpeacn++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjQzLjQyNiUiLCIxOC4wNiUiLCIzLjkyNCUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMS45ODElIiwiNzAuMjUyJSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7nvJblj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjExLjk4MSUiLCI3OC4xODYlIiwiMTguMDYlIiwiMy45MjQlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIyMC4zMDUlIiwiMi4wMDMlIiwiOTUuOTk1JSIsIjYxLjE4MSUiLGh0bWxfdGFibGUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJWb3JpZW50IiwzKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiaHRtbF90YWJsZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCIzLjg3OSUiLCIxMC4xMjYlIiwiMy45MjQlIiwi5Y2V5o2u6YeR6aKd77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI4Ni45NTIlIiwiMTIuMDY1JSIsIjEyLjAwMyUiLCIzLjkyNCUiLHRvdGFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0b3RhbCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCIyOC41NjQlIiwiMTAuMTI2JSIsIjMuOTI0JSIsIuWunumZhemHkeminToiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCIzNi4zNzMlIiwiMTIuMDAzJSIsIjMuOTI0JSIsYWN0dWFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJhY3R1YWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI4Ni45NTIlIiwiNTEuOTklIiwiMTAuMTI2JSIsIjMuOTI0JSIsIuWunuaUtumHkeminToiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCI1OS41NDclIiwiMTIuMDAzJSIsIjMuOTI0JSIsbW9uZXkpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm1vbmV5Iik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNzcxJSIsIjMuODc5JSIsIjguMjM3JSIsIjMuOTI0JSIsIuWItuWNleS6uu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNjM4JSIsIjEwLjU3OSUiLCIxNS4xMjYlIiwiMy45MjQlIix1c2VyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ1c2VyIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuODI5JSIsIjM3LjY3JSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLku5jmrL7mlrnlvI/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCI0NS41MjklIiwiMTUuMTI2JSIsIjMuOTI0JSIscGF5dHlwZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwicGF5dHlwZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljc4MSUiLCI3Ni41ODclIiwiMTAuMDc2JSIsIjMuOTI0JSIsIui1oOmAgeenr+WIhu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiODYuNzgxJSIsIjg0LjMyJSIsIjEyLjAwMyUiLCIzLjkyNCUiLGludGVncmFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJpbnRlZ3JhbCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCI3Mi45MjIlIiwiMTAuODMxJSIsIjMuOTI0JSIsIuWkh+azqOS/oeaBr++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuODI5JSIsIjgxLjIzNCUiLCIxNS4xMjYlIiwiMy45MjQlIixkYXRhKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJkYXRhIik7DQo=','零售单');
INSERT INTO `is_prints` (`id`,`name`,`paper4`,`paper2`,`paper4default`,`paper2default`,`data`) VALUES ('13','cashiermin','','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLDE4MSwoaHRtbF9oZWlnaHQrMzAwKSwi6Zu25ZSu5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMyw0ODAsMCwiIik7DQpMT0RPUC5TRVRfUFJJTlRfTU9ERSgiUFJPR1JBTV9DT05URU5UX0JZVkFSIix0cnVlKTsNCkxPRE9QLlNFVF9QUklOVF9NT0RFKCJQUklOVF9OT0NPTExBVEUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1JFQ1QoIjAuMTA1JSIsIjAuMTElIiwiOTkuNzc5JSIsIjk5LjgwOCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKDM5LDEsMzgsMTgxLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKDEwOSwxLDExMCwxODEsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoMTEsMjUsMTM4LDI1LCLpm7Yg5ZSuIOWNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJCb2xkIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKDg4LDQsNTEsMTgsIuWuouaIt++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoODgsNDIsMTM2LDE4LGN1c3RvbWVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiY3VzdG9tZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKDY2LDQsNTIsMTgsIuaXpeacn++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoNjYsNDIsMTM2LDE4LHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0aW1lIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCg0NCw0LDU3LDE4LCLljZXlj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKDQ0LDQyLDEzNiwxOCxudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJudW1iZXIiKTsNCkxPRE9QLkFERF9QUklOVF9UQUJMRSgxMTQsNywxNjUsaHRtbF9oZWlnaHQsaHRtbF90YWJsZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIlZvcmllbnQiLDMpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJodG1sX3RhYmxlIik7DQpMT0RPUC5BRERfUFJJTlRfTElORSgoaHRtbF9oZWlnaHQrMTE0KSwxLChodG1sX2hlaWdodCsxMTUpLDE4MSwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgoaHRtbF9oZWlnaHQrMjM1KSwxLChodG1sX2hlaWdodCsyMzYpLDE4MSwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgoaHRtbF9oZWlnaHQrMTIxKSw4LDgwLDE5LCLljZXmja7ph5Hpop3vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKChodG1sX2hlaWdodCsxMjEpLDk1LDc3LDE5LHRvdGFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQWxpZ25tZW50IiwzKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidG90YWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKChodG1sX2hlaWdodCsxNDMpLDgsODAsMTksIuWunumZhemHkemine+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoKGh0bWxfaGVpZ2h0KzE0MyksOTUsNzcsMTksYWN0dWFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQWxpZ25tZW50IiwzKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiYWN0dWFsIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgoaHRtbF9oZWlnaHQrMTY2KSw4LDgwLDE5LCLlrp7mlLbph5Hpop3vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKChodG1sX2hlaWdodCsxNjYpLDk1LDc3LDE5LG1vbmV5KTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQWxpZ25tZW50IiwzKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwibW9uZXkiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKChodG1sX2hlaWdodCsxODkpLDgsODAsMTksIui1oOmAgeenr+WIhu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoKGh0bWxfaGVpZ2h0KzE4OSksOTUsNzcsMTksaW50ZWdyYWwpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDMpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJpbnRlZ3JhbCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoKGh0bWxfaGVpZ2h0KzIxMyksOSw4MCwxOSwi5Ymp5L2Z56ev5YiG77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgoaHRtbF9oZWlnaHQrMjEzKSw5NCw3NywxOSxhbHRfaW50ZWdyYWwpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDMpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJhbHRfaW50ZWdyYWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKChodG1sX2hlaWdodCsyNDEpLDYsMTY3LDUyLCLoh6rlrprkuYnljLrln58iKTsNCg==','','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLDE4MSwoaHRtbF9oZWlnaHQrMzAwKSwi6Zu25ZSu5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMyw0ODAsMCwiIik7DQpMT0RPUC5TRVRfUFJJTlRfTU9ERSgiUFJPR1JBTV9DT05URU5UX0JZVkFSIix0cnVlKTsNCkxPRE9QLlNFVF9QUklOVF9NT0RFKCJQUklOVF9OT0NPTExBVEUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1JFQ1QoIjAuMTA1JSIsIjAuMTElIiwiOTkuNzc5JSIsIjk5LjgwOCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKDM5LDEsMzgsMTgxLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKDEwOSwxLDExMCwxODEsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoMTEsMjUsMTM4LDI1LCLpm7Yg5ZSuIOWNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJCb2xkIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKDg4LDQsNTEsMTgsIuWuouaIt++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoODgsNDIsMTM2LDE4LGN1c3RvbWVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiY3VzdG9tZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKDY2LDQsNTIsMTgsIuaXpeacn++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoNjYsNDIsMTM2LDE4LHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0aW1lIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCg0NCw0LDU3LDE4LCLljZXlj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKDQ0LDQyLDEzNiwxOCxudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJudW1iZXIiKTsNCkxPRE9QLkFERF9QUklOVF9UQUJMRSgxMTQsNywxNjUsaHRtbF9oZWlnaHQsaHRtbF90YWJsZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIlZvcmllbnQiLDMpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJodG1sX3RhYmxlIik7DQpMT0RPUC5BRERfUFJJTlRfTElORSgoaHRtbF9oZWlnaHQrMTE0KSwxLChodG1sX2hlaWdodCsxMTUpLDE4MSwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgoaHRtbF9oZWlnaHQrMjM1KSwxLChodG1sX2hlaWdodCsyMzYpLDE4MSwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgoaHRtbF9oZWlnaHQrMTIxKSw4LDgwLDE5LCLljZXmja7ph5Hpop3vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKChodG1sX2hlaWdodCsxMjEpLDk1LDc3LDE5LHRvdGFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQWxpZ25tZW50IiwzKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidG90YWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKChodG1sX2hlaWdodCsxNDMpLDgsODAsMTksIuWunumZhemHkemine+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoKGh0bWxfaGVpZ2h0KzE0MyksOTUsNzcsMTksYWN0dWFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQWxpZ25tZW50IiwzKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiYWN0dWFsIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgoaHRtbF9oZWlnaHQrMTY2KSw4LDgwLDE5LCLlrp7mlLbph5Hpop3vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKChodG1sX2hlaWdodCsxNjYpLDk1LDc3LDE5LG1vbmV5KTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQWxpZ25tZW50IiwzKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwibW9uZXkiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKChodG1sX2hlaWdodCsxODkpLDgsODAsMTksIui1oOmAgeenr+WIhu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoKGh0bWxfaGVpZ2h0KzE4OSksOTUsNzcsMTksaW50ZWdyYWwpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDMpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJpbnRlZ3JhbCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoKGh0bWxfaGVpZ2h0KzIxMyksOSw4MCwxOSwi5Ymp5L2Z56ev5YiG77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgoaHRtbF9oZWlnaHQrMjEzKSw5NCw3NywxOSxhbHRfaW50ZWdyYWwpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDMpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJhbHRfaW50ZWdyYWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKChodG1sX2hlaWdodCsyNDEpLDYsMTY3LDUyLCLoh6rlrprkuYnljLrln58iKTsNCg==','零售单');
INSERT INTO `is_prints` (`id`,`name`,`paper4`,`paper2`,`paper4default`,`paper2default`,`data`) VALUES ('14','recashier','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi6Zu25ZSu6YCA6LSn5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkwLjA1MyUiLCIwLjk5NSUiLDEwMTEsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIumbtuWUrumAgOi0p+WNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJCb2xkIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjMuODc5JSIsIjkuODc0JSIsIjIuMDUlIiwi6LSt5Lmw5a6i5oi377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIxMS44MTQlIiwiMTcuNDMxJSIsIjIuMDUlIixjdXN0b21lcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiY3VzdG9tZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIzNS4yMzklIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u5pel5pyf77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI0My40MjYlIiwiMTguMDYlIiwiMi4wNSUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI3MC4yNTIlIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u57yW5Y+377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI3OC4xODYlIiwiMTkuOTUlIiwiMi4wNSUiLG51bWJlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwibnVtYmVyIik7DQpMT0RPUC5BRERfUFJJTlRfVEFCTEUoIjExLjEzMiUiLCIyLjEyOCUiLCI5NS45OTUlIiwiNzcuNTA0JSIsaHRtbF90YWJsZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIlZvcmllbnQiLDMpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJodG1sX3RhYmxlIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNjc2JSIsIjYuOTAyJSIsIjEwLjEyNiUiLCIyLjA1JSIsIuWNleaNrumHkemine+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNjc2JSIsIjE0LjU4NCUiLCIxMi4wMDMlIiwiMi4wNSUiLHRvdGFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0b3RhbCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkxLjY3NiUiLCIzOC44OTIlIiwiMTAuMTI2JSIsIjIuMDUlIiwi5a6e6ZmF6YeR6aKd77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiNDYuNTc0JSIsIjEyLjAwMyUiLCIyLjA1JSIsYWN0dWFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJhY3R1YWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiNzQuNTM0JSIsIjEwLjEyNiUiLCIyLjA1JSIsIuWunuS7mOmHkemine+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNjc2JSIsIjgyLjM0MyUiLCIxNS4xNTElIiwiMi4wNSUiLG1vbmV5KTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJtb25leSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA0MyUiLCI2LjkwMiUiLCIxMC4xMjYlIiwiMi4wNSUiLCLliLbljZXkurrvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCIxMy4wOTglIiwiMTAuNTc5JSIsIjIuMDUlIix1c2VyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ1c2VyIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjI5LjQ3MSUiLCIxMC4wNzYlIiwiMi4wNSUiLCLnu5PnrpfotKbmiLfvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCIzNy4xNTQlIiwiOS4xOTQlIiwiMi4wNSUiLGFjY291bnQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImFjY291bnQiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiNTAuNTA0JSIsIjEwLjA3NiUiLCIyLjA1JSIsIuaJo+mZpOenr+WIhu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjU4LjMxMiUiLCIxMi4wMDMlIiwiMi4wNSUiLGludGVncmFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJpbnRlZ3JhbCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCI3NC41NTklIiwiMTAuODMxJSIsIjIuMDUlIiwi5aSH5rOo5L+h5oGv77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiODIuMzY4JSIsIjE1LjExMyUiLCIyLjA1JSIsZGF0YSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiZGF0YSIpOw0K','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi6Zu25ZSu6YCA6LSn5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjg1LjUyNCUiLCIwLjk5NSUiLCI4NS43MTQlIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiOTEuODQ4JSIsIjAuOTk1JSIsIjkyLjAzOCUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIzLjI1NyUiLCI0MCUiLCIyMCUiLCI2LjMyNCUiLCLpm7bllK7pgIDotKfljZUiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDE0KTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQWxpZ25tZW50IiwyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQm9sZCIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMy44NzklIiwiOS44NzQlIiwiMy45MjQlIiwi6LSt5Lmw5a6i5oi377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMTIuMDY1JSIsIjE3LjQzMSUiLCIzLjkyNCUiLGN1c3RvbWVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJjdXN0b21lciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjM2MiUiLCIzNS4yMzklIiwiMTAuMDc2JSIsIjMuOTI0JSIsIuWNleaNruaXpeacn++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMzYyJSIsIjQzLjQyNiUiLCIxOC4wNiUiLCIzLjkyNCUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiNjkuMzclIiwiMTAuMDc2JSIsIjMuOTI0JSIsIuWNleaNrue8luWPt++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMzYyJSIsIjc3LjMwNSUiLCIxOS45NSUiLCIzLjkyNCUiLG51bWJlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwibnVtYmVyIik7DQpMT0RPUC5BRERfUFJJTlRfVEFCTEUoIjE4LjU5JSIsIjIuMDAzJSIsIjk1Ljk5NSUiLCI2My4wODYlIixodG1sX3RhYmxlKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiVm9yaWVudCIsMyk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImh0bWxfdGFibGUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI4Ny4xNDMlIiwiNS44OTQlIiwiMTAuMTI2JSIsIjMuOTI0JSIsIuWNleaNrumHkemine+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiODcuMTQzJSIsIjEzLjU3NyUiLCIxMi4wMDMlIiwiMy45MjQlIix0b3RhbCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidG90YWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI4Ny4xNDMlIiwiMzkuNTIxJSIsIjEwLjEyNiUiLCIzLjkyNCUiLCLlrp7pmYXph5Hpop3vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg3LjE0MyUiLCI0Ny4yMDQlIiwiMTIuMDAzJSIsIjMuOTI0JSIsYWN0dWFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJhY3R1YWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI4Ny4xNDMlIiwiNzMuOTA0JSIsIjEwLjEyNiUiLCIzLjkyNCUiLCLlrp7ku5jph5Hpop3vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg3LjE0MyUiLCI4MS41ODclIiwiMTIuMDAzJSIsIjMuOTI0JSIsbW9uZXkpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm1vbmV5Iik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNzcxJSIsIjUuODk0JSIsIjEwLjEyNiUiLCIzLjkyNCUiLCLliLbljZXkurrvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjYzOCUiLCIxMi4zNDMlIiwiOC43MDMlIiwiMy45MjQlIix1c2VyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ1c2VyIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNjM4JSIsIjI2LjQ2MSUiLCIxMC4wNzYlIiwiMy45MjQlIiwi57uT566X6LSm5oi377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My42MzglIiwiMzQuNDQ2JSIsIjExLjg1MSUiLCIzLjkyNCUiLGFjY291bnQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImFjY291bnQiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My42MzglIiwiNTEuNTI0JSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLmiaPpmaTnp6/liIbvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjYzOCUiLCI1OS4zODMlIiwiMTIuMDAzJSIsIjMuOTI0JSIsaW50ZWdyYWwpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImludGVncmFsIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNjM4JSIsIjczLjkyOSUiLCIxMC44MzElIiwiMy45MjQlIiwi5aSH5rOo5L+h5oGv77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My42MzglIiwiODEuNzM4JSIsIjE1LjEyNiUiLCIzLjkyNCUiLGRhdGEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImRhdGEiKTsNCg==','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi6Zu25ZSu6YCA6LSn5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkwLjA1MyUiLCIwLjk5NSUiLDEwMTEsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIumbtuWUrumAgOi0p+WNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJCb2xkIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjMuODc5JSIsIjkuODc0JSIsIjIuMDUlIiwi6LSt5Lmw5a6i5oi377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIxMS44MTQlIiwiMTcuNDMxJSIsIjIuMDUlIixjdXN0b21lcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiY3VzdG9tZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIzNS4yMzklIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u5pel5pyf77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI0My40MjYlIiwiMTguMDYlIiwiMi4wNSUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI3MC4yNTIlIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u57yW5Y+377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI3OC4xODYlIiwiMTkuOTUlIiwiMi4wNSUiLG51bWJlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwibnVtYmVyIik7DQpMT0RPUC5BRERfUFJJTlRfVEFCTEUoIjExLjEzMiUiLCIyLjEyOCUiLCI5NS45OTUlIiwiNzcuNTA0JSIsaHRtbF90YWJsZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIlZvcmllbnQiLDMpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJodG1sX3RhYmxlIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNjc2JSIsIjYuOTAyJSIsIjEwLjEyNiUiLCIyLjA1JSIsIuWNleaNrumHkemine+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNjc2JSIsIjE0LjU4NCUiLCIxMi4wMDMlIiwiMi4wNSUiLHRvdGFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0b3RhbCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkxLjY3NiUiLCIzOC44OTIlIiwiMTAuMTI2JSIsIjIuMDUlIiwi5a6e6ZmF6YeR6aKd77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiNDYuNTc0JSIsIjEyLjAwMyUiLCIyLjA1JSIsYWN0dWFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJhY3R1YWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiNzQuNTM0JSIsIjEwLjEyNiUiLCIyLjA1JSIsIuWunuS7mOmHkemine+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNjc2JSIsIjgyLjM0MyUiLCIxNS4xNTElIiwiMi4wNSUiLG1vbmV5KTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJtb25leSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA0MyUiLCI2LjkwMiUiLCIxMC4xMjYlIiwiMi4wNSUiLCLliLbljZXkurrvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCIxMy4wOTglIiwiMTAuNTc5JSIsIjIuMDUlIix1c2VyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ1c2VyIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjI5LjQ3MSUiLCIxMC4wNzYlIiwiMi4wNSUiLCLnu5PnrpfotKbmiLfvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCIzNy4xNTQlIiwiOS4xOTQlIiwiMi4wNSUiLGFjY291bnQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImFjY291bnQiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiNTAuNTA0JSIsIjEwLjA3NiUiLCIyLjA1JSIsIuaJo+mZpOenr+WIhu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjU4LjMxMiUiLCIxMi4wMDMlIiwiMi4wNSUiLGludGVncmFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJpbnRlZ3JhbCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCI3NC41NTklIiwiMTAuODMxJSIsIjIuMDUlIiwi5aSH5rOo5L+h5oGv77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiODIuMzY4JSIsIjE1LjExMyUiLCIyLjA1JSIsZGF0YSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiZGF0YSIpOw0K','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi6Zu25ZSu6YCA6LSn5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjg1LjUyNCUiLCIwLjk5NSUiLCI4NS43MTQlIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiOTEuODQ4JSIsIjAuOTk1JSIsIjkyLjAzOCUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIzLjI1NyUiLCI0MCUiLCIyMCUiLCI2LjMyNCUiLCLpm7bllK7pgIDotKfljZUiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDE0KTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQWxpZ25tZW50IiwyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQm9sZCIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMy44NzklIiwiOS44NzQlIiwiMy45MjQlIiwi6LSt5Lmw5a6i5oi377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMTIuMDY1JSIsIjE3LjQzMSUiLCIzLjkyNCUiLGN1c3RvbWVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJjdXN0b21lciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjM2MiUiLCIzNS4yMzklIiwiMTAuMDc2JSIsIjMuOTI0JSIsIuWNleaNruaXpeacn++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMzYyJSIsIjQzLjQyNiUiLCIxOC4wNiUiLCIzLjkyNCUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiNjkuMzclIiwiMTAuMDc2JSIsIjMuOTI0JSIsIuWNleaNrue8luWPt++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMzYyJSIsIjc3LjMwNSUiLCIxOS45NSUiLCIzLjkyNCUiLG51bWJlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwibnVtYmVyIik7DQpMT0RPUC5BRERfUFJJTlRfVEFCTEUoIjE4LjU5JSIsIjIuMDAzJSIsIjk1Ljk5NSUiLCI2My4wODYlIixodG1sX3RhYmxlKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiVm9yaWVudCIsMyk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImh0bWxfdGFibGUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI4Ny4xNDMlIiwiNS44OTQlIiwiMTAuMTI2JSIsIjMuOTI0JSIsIuWNleaNrumHkemine+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiODcuMTQzJSIsIjEzLjU3NyUiLCIxMi4wMDMlIiwiMy45MjQlIix0b3RhbCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidG90YWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI4Ny4xNDMlIiwiMzkuNTIxJSIsIjEwLjEyNiUiLCIzLjkyNCUiLCLlrp7pmYXph5Hpop3vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg3LjE0MyUiLCI0Ny4yMDQlIiwiMTIuMDAzJSIsIjMuOTI0JSIsYWN0dWFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJhY3R1YWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI4Ny4xNDMlIiwiNzMuOTA0JSIsIjEwLjEyNiUiLCIzLjkyNCUiLCLlrp7ku5jph5Hpop3vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg3LjE0MyUiLCI4MS41ODclIiwiMTIuMDAzJSIsIjMuOTI0JSIsbW9uZXkpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm1vbmV5Iik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNzcxJSIsIjUuODk0JSIsIjEwLjEyNiUiLCIzLjkyNCUiLCLliLbljZXkurrvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjYzOCUiLCIxMi4zNDMlIiwiOC43MDMlIiwiMy45MjQlIix1c2VyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ1c2VyIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNjM4JSIsIjI2LjQ2MSUiLCIxMC4wNzYlIiwiMy45MjQlIiwi57uT566X6LSm5oi377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My42MzglIiwiMzQuNDQ2JSIsIjExLjg1MSUiLCIzLjkyNCUiLGFjY291bnQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImFjY291bnQiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My42MzglIiwiNTEuNTI0JSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLmiaPpmaTnp6/liIbvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjYzOCUiLCI1OS4zODMlIiwiMTIuMDAzJSIsIjMuOTI0JSIsaW50ZWdyYWwpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImludGVncmFsIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNjM4JSIsIjczLjkyOSUiLCIxMC44MzElIiwiMy45MjQlIiwi5aSH5rOo5L+h5oGv77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My42MzglIiwiODEuNzM4JSIsIjE1LjEyNiUiLCIzLjkyNCUiLGRhdGEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImRhdGEiKTsNCg==','零售退货单');
INSERT INTO `is_prints` (`id`,`name`,`paper4`,`paper2`,`paper4default`,`paper2default`,`data`) VALUES ('15','opurchase','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi6YeH6LSt6K6i5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIumHh+i0reiuouWNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiMi40OTQlIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u5pel5pyf77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIxMC42OCUiLCIxOC4wNiUiLCIyLjA1JSIsdGltZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidGltZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjM3LjUwNiUiLCIxMC4wNzYlIiwiMi4wNSUiLCLljZXmja7nvJblj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjQ1LjQ0MSUiLCIxOS4zMiUiLCIyLjA1JSIsbnVtYmVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJudW1iZXIiKTsNCkxPRE9QLkFERF9QUklOVF9UQUJMRSgiMTEuMjIxJSIsIjIuMDAzJSIsIjk1Ljk5NSUiLCI4MS41MDYlIixodG1sX3RhYmxlKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiVm9yaWVudCIsMyk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImh0bWxfdGFibGUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNDMlIiwiMy44NzklIiwiMTAuMTI2JSIsIjIuMDUlIiwi5Yi25Y2V5Lq677yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiMTIuMzQzJSIsIjE1LjExMyUiLCIyLjA1JSIsdXNlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidXNlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCIzNS43NjglIiwiMTAuODMxJSIsIjIuMDUlIiwi5aSH5rOo5L+h5oGv77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiNDQuMDgxJSIsIjE1LjExMyUiLCIyLjA1JSIsZGF0YSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiZGF0YSIpOw0K','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi6YeH6LSt6K6i5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkxLjg0OCUiLCIwLjk5NSUiLCI5Mi4wMzglIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMy4yNTclIiwiNDAlIiwiMjAlIiwiNi4zMjQlIiwi6YeH6LSt6K6i5Y2VIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxNCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkFsaWdubWVudCIsMik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkJvbGQiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjIuNDk0JSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7ml6XmnJ/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE3MSUiLCIxMC42OCUiLCIxOC4wNiUiLCIzLjkyNCUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMS45ODElIiwiMzcuNTA2JSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7nvJblj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjExLjk4MSUiLCI0NS40NDElIiwiMTguMDYlIiwiMy45MjQlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIxOC45NzElIiwiMi4wMDMlIiwiOTUuOTk1JSIsIjY5Ljc1MiUiLGh0bWxfdGFibGUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJWb3JpZW50IiwzKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiaHRtbF90YWJsZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjc3MSUiLCIzLjg3OSUiLCIxMC4xMjYlIiwiMy45MjQlIiwi5Yi25Y2V5Lq677yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My42MzglIiwiMTIuMzQzJSIsIjE1LjEyNiUiLCIzLjkyNCUiLHVzZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInVzZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My44MjklIiwiMzguMDM1JSIsIjEwLjgzMSUiLCIzLjkyNCUiLCLlpIfms6jkv6Hmga/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCI0Ni4zNDglIiwiMTUuMTI2JSIsIjMuOTI0JSIsZGF0YSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiZGF0YSIpOw0K','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi6YeH6LSt6K6i5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIumHh+i0reiuouWNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiMi40OTQlIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u5pel5pyf77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIxMC42OCUiLCIxOC4wNiUiLCIyLjA1JSIsdGltZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidGltZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjM3LjUwNiUiLCIxMC4wNzYlIiwiMi4wNSUiLCLljZXmja7nvJblj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjQ1LjQ0MSUiLCIxOS4zMiUiLCIyLjA1JSIsbnVtYmVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJudW1iZXIiKTsNCkxPRE9QLkFERF9QUklOVF9UQUJMRSgiMTEuMjIxJSIsIjIuMDAzJSIsIjk1Ljk5NSUiLCI4MS41MDYlIixodG1sX3RhYmxlKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiVm9yaWVudCIsMyk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImh0bWxfdGFibGUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNDMlIiwiMy44NzklIiwiMTAuMTI2JSIsIjIuMDUlIiwi5Yi25Y2V5Lq677yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiMTIuMzQzJSIsIjE1LjExMyUiLCIyLjA1JSIsdXNlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidXNlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCIzNS43NjglIiwiMTAuODMxJSIsIjIuMDUlIiwi5aSH5rOo5L+h5oGv77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiNDQuMDgxJSIsIjE1LjExMyUiLCIyLjA1JSIsZGF0YSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiZGF0YSIpOw0K','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi6YeH6LSt6K6i5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkxLjg0OCUiLCIwLjk5NSUiLCI5Mi4wMzglIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMy4yNTclIiwiNDAlIiwiMjAlIiwiNi4zMjQlIiwi6YeH6LSt6K6i5Y2VIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxNCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkFsaWdubWVudCIsMik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkJvbGQiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjIuNDk0JSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7ml6XmnJ/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE3MSUiLCIxMC42OCUiLCIxOC4wNiUiLCIzLjkyNCUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMS45ODElIiwiMzcuNTA2JSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7nvJblj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjExLjk4MSUiLCI0NS40NDElIiwiMTguMDYlIiwiMy45MjQlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIxOC45NzElIiwiMi4wMDMlIiwiOTUuOTk1JSIsIjY5Ljc1MiUiLGh0bWxfdGFibGUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJWb3JpZW50IiwzKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiaHRtbF90YWJsZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjc3MSUiLCIzLjg3OSUiLCIxMC4xMjYlIiwiMy45MjQlIiwi5Yi25Y2V5Lq677yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My42MzglIiwiMTIuMzQzJSIsIjE1LjEyNiUiLCIzLjkyNCUiLHVzZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInVzZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My44MjklIiwiMzguMDM1JSIsIjEwLjgzMSUiLCIzLjkyNCUiLCLlpIfms6jkv6Hmga/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCI0Ni4zNDglIiwiMTUuMTI2JSIsIjMuOTI0JSIsZGF0YSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiZGF0YSIpOw0K','采购订单');
INSERT INTO `is_prints` (`id`,`name`,`paper4`,`paper2`,`paper4default`,`paper2default`,`data`) VALUES ('16','orpurchase','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi6YeH6LSt5YWl5bqT6K+m5oOF5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIumHh+i0reWFpeW6k+ivpuaDheWNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiMi40OTQlIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u5pel5pyf77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIxMC42OCUiLCIxOC4wNiUiLCIyLjA1JSIsdGltZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidGltZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjM3LjUwNiUiLCIxMC4wNzYlIiwiMi4wNSUiLCLljZXmja7nvJblj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjQ1LjQ0MSUiLCIxOC4wNiUiLCIyLjA1JSIsbnVtYmVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJudW1iZXIiKTsNCkxPRE9QLkFERF9QUklOVF9UQUJMRSgiMTEuMzElIiwiMi4wMDMlIiwiOTUuOTk1JSIsIjgxLjc3NCUiLGh0bWxfdGFibGUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJWb3JpZW50IiwzKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiaHRtbF90YWJsZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA0MyUiLCIzLjg3OSUiLCIxMC4xMjYlIiwiMi4wNSUiLCLliLbljZXkurrvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCIxMi4zNDMlIiwiMTUuMTEzJSIsIjIuMDUlIix1c2VyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ1c2VyIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjM1Ljc2OCUiLCIxMC44MzElIiwiMi4wNSUiLCLlpIfms6jkv6Hmga/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCI0NC4wODElIiwiMTUuMTEzJSIsIjIuMDUlIixkYXRhKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJkYXRhIik7DQo=','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi6YeH6LSt5YWl5bqT6K+m5oOF5Y2VIC0g5omT5Y2wIik7CkxPRE9QLlNFVF9QUklOVF9QQUdFU0laRSgxLDIxMDAsMTM5MCwiIik7CkxPRE9QLlNFVF9QUklOVF9NT0RFKCJQUk9HUkFNX0NPTlRFTlRfQllWQVIiLHRydWUpOwpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOwpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsKTE9ET1AuQUREX1BSSU5UX0xJTkUoIjEwLjM0MyUiLCIwLjk5NSUiLCIxMC41MzMlIiwiOTguOTglIiwwLDEpOwpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsKTE9ET1AuQUREX1BSSU5UX0xJTkUoIjE3LjM1MiUiLCIwLjk5NSUiLCIxNy41NDMlIiwiOTguOTglIiwwLDEpOwpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsKTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkxLjg0OCUiLCIwLjk5NSUiLCI5Mi4wMzglIiwiOTguOTglIiwwLDEpOwpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsKTE9ET1AuQUREX1BSSU5UX1RFWFQoIjMuMjU3JSIsIjQwJSIsIjIwJSIsIjYuMzI0JSIsIumHh+i0reWFpeW6k+ivpuaDheWNlSIpOwpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxNCk7CkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQWxpZ25tZW50IiwyKTsKTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJCb2xkIiwxKTsKTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7CkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4xNzElIiwiMi40OTQlIiwiMTAuMDc2JSIsIjMuOTI0JSIsIuWNleaNruaXpeacn++8miIpOwpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7CkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOwpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjEwLjY4JSIsIjE4LjA2JSIsIjMuOTI0JSIsdGltZSk7CkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsKTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7CkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidGltZSIpOwpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTEuOTgxJSIsIjM3LjUwNiUiLCIxMC4wNzYlIiwiMy45MjQlIiwi5Y2V5o2u57yW5Y+377yaIik7CkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsKTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7CkxPRE9QLkFERF9QUklOVF9URVhUKCIxMS45ODElIiwiNDUuNDQxJSIsIjE4LjA2JSIsIjMuOTI0JSIsbnVtYmVyKTsKTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOwpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsKTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJudW1iZXIiKTsKTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIyMC4zMDUlIiwiMi4wMDMlIiwiOTUuOTk1JSIsIjY5Ljc1MiUiLGh0bWxfdGFibGUpOwpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIlZvcmllbnQiLDMpOwpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImh0bWxfdGFibGUiKTsKTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjc3MSUiLCIzLjg3OSUiLCIxMC4xMjYlIiwiMy45MjQlIiwi5Yi25Y2V5Lq677yaIik7CkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsKTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7CkxPRE9QLkFERF9QUklOVF9URVhUKCI5My42MzglIiwiMTIuMzQzJSIsIjE1LjEyNiUiLCIzLjkyNCUiLHVzZXIpOwpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7CkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOwpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInVzZXIiKTsKTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCIzOC4wMzUlIiwiMTAuODMxJSIsIjMuOTI0JSIsIuWkh+azqOS/oeaBr++8miIpOwpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7CkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOwpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuODI5JSIsIjQ2LjM0OCUiLCIxNS4xMjYlIiwiMy45MjQlIixkYXRhKTsKTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOwpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsKTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJkYXRhIik7','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi6YeH6LSt5YWl5bqT6K+m5oOF5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIumHh+i0reWFpeW6k+ivpuaDheWNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiMi40OTQlIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u5pel5pyf77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIxMC42OCUiLCIxOC4wNiUiLCIyLjA1JSIsdGltZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidGltZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjM3LjUwNiUiLCIxMC4wNzYlIiwiMi4wNSUiLCLljZXmja7nvJblj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjQ1LjQ0MSUiLCIxOC4wNiUiLCIyLjA1JSIsbnVtYmVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJudW1iZXIiKTsNCkxPRE9QLkFERF9QUklOVF9UQUJMRSgiMTEuMzElIiwiMi4wMDMlIiwiOTUuOTk1JSIsIjgxLjc3NCUiLGh0bWxfdGFibGUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJWb3JpZW50IiwzKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiaHRtbF90YWJsZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA0MyUiLCIzLjg3OSUiLCIxMC4xMjYlIiwiMi4wNSUiLCLliLbljZXkurrvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCIxMi4zNDMlIiwiMTUuMTEzJSIsIjIuMDUlIix1c2VyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ1c2VyIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjM1Ljc2OCUiLCIxMC44MzElIiwiMi4wNSUiLCLlpIfms6jkv6Hmga/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCI0NC4wODElIiwiMTUuMTEzJSIsIjIuMDUlIixkYXRhKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJkYXRhIik7DQo=','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi6YeH6LSt5YWl5bqT6K+m5oOF5Y2VIC0g5omT5Y2wIik7CkxPRE9QLlNFVF9QUklOVF9QQUdFU0laRSgxLDIxMDAsMTM5MCwiIik7CkxPRE9QLlNFVF9QUklOVF9NT0RFKCJQUk9HUkFNX0NPTlRFTlRfQllWQVIiLHRydWUpOwpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOwpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsKTE9ET1AuQUREX1BSSU5UX0xJTkUoIjEwLjM0MyUiLCIwLjk5NSUiLCIxMC41MzMlIiwiOTguOTglIiwwLDEpOwpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsKTE9ET1AuQUREX1BSSU5UX0xJTkUoIjE3LjM1MiUiLCIwLjk5NSUiLCIxNy41NDMlIiwiOTguOTglIiwwLDEpOwpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsKTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkxLjg0OCUiLCIwLjk5NSUiLCI5Mi4wMzglIiwiOTguOTglIiwwLDEpOwpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsKTE9ET1AuQUREX1BSSU5UX1RFWFQoIjMuMjU3JSIsIjQwJSIsIjIwJSIsIjYuMzI0JSIsIumHh+i0reWFpeW6k+ivpuaDheWNlSIpOwpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxNCk7CkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQWxpZ25tZW50IiwyKTsKTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJCb2xkIiwxKTsKTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7CkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4xNzElIiwiMi40OTQlIiwiMTAuMDc2JSIsIjMuOTI0JSIsIuWNleaNruaXpeacn++8miIpOwpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7CkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOwpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjEwLjY4JSIsIjE4LjA2JSIsIjMuOTI0JSIsdGltZSk7CkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsKTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7CkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidGltZSIpOwpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTEuOTgxJSIsIjM3LjUwNiUiLCIxMC4wNzYlIiwiMy45MjQlIiwi5Y2V5o2u57yW5Y+377yaIik7CkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsKTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7CkxPRE9QLkFERF9QUklOVF9URVhUKCIxMS45ODElIiwiNDUuNDQxJSIsIjE4LjA2JSIsIjMuOTI0JSIsbnVtYmVyKTsKTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOwpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsKTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJudW1iZXIiKTsKTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIyMC4zMDUlIiwiMi4wMDMlIiwiOTUuOTk1JSIsIjY5Ljc1MiUiLGh0bWxfdGFibGUpOwpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIlZvcmllbnQiLDMpOwpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImh0bWxfdGFibGUiKTsKTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjc3MSUiLCIzLjg3OSUiLCIxMC4xMjYlIiwiMy45MjQlIiwi5Yi25Y2V5Lq677yaIik7CkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsKTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7CkxPRE9QLkFERF9QUklOVF9URVhUKCI5My42MzglIiwiMTIuMzQzJSIsIjE1LjEyNiUiLCIzLjkyNCUiLHVzZXIpOwpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7CkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOwpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInVzZXIiKTsKTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCIzOC4wMzUlIiwiMTAuODMxJSIsIjMuOTI0JSIsIuWkh+azqOS/oeaBr++8miIpOwpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7CkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOwpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuODI5JSIsIjQ2LjM0OCUiLCIxNS4xMjYlIiwiMy45MjQlIixkYXRhKTsKTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOwpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsKTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJkYXRhIik7','采购入库详情单');
INSERT INTO `is_prints` (`id`,`name`,`paper4`,`paper2`,`paper4default`,`paper2default`,`data`) VALUES ('17','rpurchase','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi6YeH6LSt5YWl5bqT5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkwLjA1MyUiLCIwLjk5NSUiLDEwMTEsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIumHh+i0reWFpeW6k+WNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiMy44NzklIiwiOS4yNDQlIiwiMi4wNSUiLCLkvpvlupTllYbvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjEwLjMwMiUiLCIxNy40MzElIiwiMi4wNSUiLHN1cHBsaWVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJzdXBwbGllciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjM1LjIzOSUiLCIxMC4wNzYlIiwiMi4wNSUiLCLljZXmja7ml6XmnJ/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjQzLjQyNiUiLCIxOC4wNiUiLCIyLjA1JSIsdGltZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidGltZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjcwLjI1MiUiLCIxMC4wNzYlIiwiMi4wNSUiLCLljZXmja7nvJblj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjc4LjE4NiUiLCIxOS45NSUiLCIyLjA1JSIsbnVtYmVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJudW1iZXIiKTsNCkxPRE9QLkFERF9QUklOVF9UQUJMRSgiMTEuNDg4JSIsIjIuMDAzJSIsIjk1Ljk5NSUiLCI3Ni42MDQlIixodG1sX3RhYmxlKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiVm9yaWVudCIsMyk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImh0bWxfdGFibGUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiMy44NzklIiwiMTAuMTI2JSIsIjIuMDUlIiwi5Y2V5o2u6YeR6aKd77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiMTIuMDY1JSIsIjE1LjExMyUiLCIyLjA1JSIsdG90YWwpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRvdGFsIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNjc2JSIsIjM2LjYyNSUiLCIxMC4xMjYlIiwiMi4wNSUiLCLlrp7pmYXph5Hpop06Iik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiNDQuOTM3JSIsIjE1LjExMyUiLCIyLjA1JSIsYWN0dWFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJhY3R1YWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiNzAuMjUyJSIsIjEwLjEyNiUiLCIyLjA1JSIsIuWunuS7mOmHkeminToiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkxLjY3NiUiLCI3OC41NjQlIiwiMTUuMTEzJSIsIjIuMDUlIixtb25leSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwibW9uZXkiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNDMlIiwiMy44NzklIiwiMTAuMTI2JSIsIjIuMDUlIiwi5Yi25Y2V5Lq677yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiMTIuMzQzJSIsIjE1LjExMyUiLCIyLjA1JSIsdXNlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidXNlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCIzNi45MDIlIiwiMTAuMDc2JSIsIjIuMDUlIiwi57uT566X6LSm5oi377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiNDUuMjE0JSIsIjE1LjExMyUiLCIyLjA1JSIsYWNjb3VudCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiYWNjb3VudCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCI3MC41MjklIiwiMTAuODMxJSIsIjIuMDUlIiwi5aSH5rOo5L+h5oGv77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiNzguODQxJSIsIjE1LjExMyUiLCIyLjA1JSIsZGF0YSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiZGF0YSIpOw0K','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi6YeH6LSt5YWl5bqT5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjg1LjUyNCUiLCIwLjk5NSUiLCI4NS43MTQlIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiOTEuODQ4JSIsIjAuOTk1JSIsIjkyLjAzOCUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIzLjI1NyUiLCI0MCUiLCIyMCUiLCI2LjMyNCUiLCLph4fotK3lhaXlupPljZUiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDE0KTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQWxpZ25tZW50IiwyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQm9sZCIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMy44NzklIiwiOS4yNDQlIiwiMy45MjQlIiwi5L6b5bqU5ZWG77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMTAuMzAyJSIsIjE3LjQzMSUiLCIzLjkyNCUiLHN1cHBsaWVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJzdXBwbGllciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE3MSUiLCIzNS4yMzklIiwiMTAuMDc2JSIsIjMuOTI0JSIsIuWNleaNruaXpeacn++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjQzLjQyNiUiLCIxOC4wNiUiLCIzLjkyNCUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMS45ODElIiwiNzAuMjUyJSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7nvJblj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjExLjk4MSUiLCI3OC4xODYlIiwiMTkuMzIlIiwiMy45MjQlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIxOC45NzElIiwiMi4wMDMlIiwiOTUuOTk1JSIsIjY0LjAzOCUiLGh0bWxfdGFibGUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJWb3JpZW50IiwzKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiaHRtbF90YWJsZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCIzLjg3OSUiLCIxMC4xMjYlIiwiMy45MjQlIiwi5Y2V5o2u6YeR6aKd77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI4Ni45NTIlIiwiMTIuMDY1JSIsIjE1LjEyNiUiLCIzLjkyNCUiLHRvdGFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0b3RhbCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCIzNi42MjUlIiwiMTAuMTI2JSIsIjMuOTI0JSIsIuWunumZhemHkeminToiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCI0NC45MzclIiwiMTUuMTI2JSIsIjMuOTI0JSIsYWN0dWFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJhY3R1YWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI4Ni45NTIlIiwiNzAuMjUyJSIsIjEwLjEyNiUiLCIzLjkyNCUiLCLlrp7ku5jph5Hpop06Iik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI4Ni45NTIlIiwiNzguNTY0JSIsIjE1LjEyNiUiLCIzLjkyNCUiLG1vbmV5KTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJtb25leSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjc3MSUiLCIzLjg3OSUiLCIxMC4xMjYlIiwiMy45MjQlIiwi5Yi25Y2V5Lq677yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My42MzglIiwiMTIuMzQzJSIsIjE1LjEyNiUiLCIzLjkyNCUiLHVzZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInVzZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My44MjklIiwiMzYuOTE0JSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLnu5PnrpfotKbmiLfvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCI0NC43NzMlIiwiMTUuMTI2JSIsIjMuOTI0JSIsYWNjb3VudCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiYWNjb3VudCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCI3MC41MjklIiwiMTAuODMxJSIsIjMuOTI0JSIsIuWkh+azqOS/oeaBr++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuODI5JSIsIjc4Ljg0MSUiLCIxNS4xMjYlIiwiMy45MjQlIixkYXRhKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJkYXRhIik7DQo=','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi6YeH6LSt5YWl5bqT5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkwLjA1MyUiLCIwLjk5NSUiLDEwMTEsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIumHh+i0reWFpeW6k+WNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiMy44NzklIiwiOS4yNDQlIiwiMi4wNSUiLCLkvpvlupTllYbvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjEwLjMwMiUiLCIxNy40MzElIiwiMi4wNSUiLHN1cHBsaWVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJzdXBwbGllciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjM1LjIzOSUiLCIxMC4wNzYlIiwiMi4wNSUiLCLljZXmja7ml6XmnJ/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjQzLjQyNiUiLCIxOC4wNiUiLCIyLjA1JSIsdGltZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidGltZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjcwLjI1MiUiLCIxMC4wNzYlIiwiMi4wNSUiLCLljZXmja7nvJblj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjc4LjE4NiUiLCIxOS45NSUiLCIyLjA1JSIsbnVtYmVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJudW1iZXIiKTsNCkxPRE9QLkFERF9QUklOVF9UQUJMRSgiMTEuNDg4JSIsIjIuMDAzJSIsIjk1Ljk5NSUiLCI3Ni42MDQlIixodG1sX3RhYmxlKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiVm9yaWVudCIsMyk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImh0bWxfdGFibGUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiMy44NzklIiwiMTAuMTI2JSIsIjIuMDUlIiwi5Y2V5o2u6YeR6aKd77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiMTIuMDY1JSIsIjE1LjExMyUiLCIyLjA1JSIsdG90YWwpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRvdGFsIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNjc2JSIsIjM2LjYyNSUiLCIxMC4xMjYlIiwiMi4wNSUiLCLlrp7pmYXph5Hpop06Iik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiNDQuOTM3JSIsIjE1LjExMyUiLCIyLjA1JSIsYWN0dWFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJhY3R1YWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiNzAuMjUyJSIsIjEwLjEyNiUiLCIyLjA1JSIsIuWunuS7mOmHkeminToiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkxLjY3NiUiLCI3OC41NjQlIiwiMTUuMTEzJSIsIjIuMDUlIixtb25leSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwibW9uZXkiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNDMlIiwiMy44NzklIiwiMTAuMTI2JSIsIjIuMDUlIiwi5Yi25Y2V5Lq677yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiMTIuMzQzJSIsIjE1LjExMyUiLCIyLjA1JSIsdXNlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidXNlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCIzNi45MDIlIiwiMTAuMDc2JSIsIjIuMDUlIiwi57uT566X6LSm5oi377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiNDUuMjE0JSIsIjE1LjExMyUiLCIyLjA1JSIsYWNjb3VudCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiYWNjb3VudCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCI3MC41MjklIiwiMTAuODMxJSIsIjIuMDUlIiwi5aSH5rOo5L+h5oGv77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiNzguODQxJSIsIjE1LjExMyUiLCIyLjA1JSIsZGF0YSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiZGF0YSIpOw0K','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi6YeH6LSt5YWl5bqT5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjg1LjUyNCUiLCIwLjk5NSUiLCI4NS43MTQlIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiOTEuODQ4JSIsIjAuOTk1JSIsIjkyLjAzOCUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIzLjI1NyUiLCI0MCUiLCIyMCUiLCI2LjMyNCUiLCLph4fotK3lhaXlupPljZUiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDE0KTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQWxpZ25tZW50IiwyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQm9sZCIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMy44NzklIiwiOS4yNDQlIiwiMy45MjQlIiwi5L6b5bqU5ZWG77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMTAuMzAyJSIsIjE3LjQzMSUiLCIzLjkyNCUiLHN1cHBsaWVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJzdXBwbGllciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE3MSUiLCIzNS4yMzklIiwiMTAuMDc2JSIsIjMuOTI0JSIsIuWNleaNruaXpeacn++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjQzLjQyNiUiLCIxOC4wNiUiLCIzLjkyNCUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMS45ODElIiwiNzAuMjUyJSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7nvJblj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjExLjk4MSUiLCI3OC4xODYlIiwiMTkuMzIlIiwiMy45MjQlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIxOC45NzElIiwiMi4wMDMlIiwiOTUuOTk1JSIsIjY0LjAzOCUiLGh0bWxfdGFibGUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJWb3JpZW50IiwzKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiaHRtbF90YWJsZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCIzLjg3OSUiLCIxMC4xMjYlIiwiMy45MjQlIiwi5Y2V5o2u6YeR6aKd77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI4Ni45NTIlIiwiMTIuMDY1JSIsIjE1LjEyNiUiLCIzLjkyNCUiLHRvdGFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0b3RhbCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCIzNi42MjUlIiwiMTAuMTI2JSIsIjMuOTI0JSIsIuWunumZhemHkeminToiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCI0NC45MzclIiwiMTUuMTI2JSIsIjMuOTI0JSIsYWN0dWFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJhY3R1YWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI4Ni45NTIlIiwiNzAuMjUyJSIsIjEwLjEyNiUiLCIzLjkyNCUiLCLlrp7ku5jph5Hpop06Iik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI4Ni45NTIlIiwiNzguNTY0JSIsIjE1LjEyNiUiLCIzLjkyNCUiLG1vbmV5KTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJtb25leSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjc3MSUiLCIzLjg3OSUiLCIxMC4xMjYlIiwiMy45MjQlIiwi5Yi25Y2V5Lq677yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My42MzglIiwiMTIuMzQzJSIsIjE1LjEyNiUiLCIzLjkyNCUiLHVzZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInVzZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My44MjklIiwiMzYuOTE0JSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLnu5PnrpfotKbmiLfvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCI0NC43NzMlIiwiMTUuMTI2JSIsIjMuOTI0JSIsYWNjb3VudCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiYWNjb3VudCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCI3MC41MjklIiwiMTAuODMxJSIsIjMuOTI0JSIsIuWkh+azqOS/oeaBr++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuODI5JSIsIjc4Ljg0MSUiLCIxNS4xMjYlIiwiMy45MjQlIixkYXRhKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJkYXRhIik7DQo=','采购入库单');
INSERT INTO `is_prints` (`id`,`name`,`paper4`,`paper2`,`paper4default`,`paper2default`,`data`) VALUES ('18','itemorder','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi5pyN5Yqh5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkwLjA1MyUiLCIwLjk5NSUiLDEwMTEsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIuacjeWKoeWNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJCb2xkIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjMuODc5JSIsIjkuODc0JSIsIjIuMDUlIiwi6LSt5Lmw5a6i5oi377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIxMS44MTQlIiwiMTcuNDMxJSIsIjIuMDUlIixjdXN0b21lcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiY3VzdG9tZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIzNS4yMzklIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u5pel5pyf77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI0My40MjYlIiwiMTguMDYlIiwiMi4wNSUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI3MC4yNTIlIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u57yW5Y+377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI3OC4xODYlIiwiMTguMDYlIiwiMi4wNSUiLG51bWJlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwibnVtYmVyIik7DQpMT0RPUC5BRERfUFJJTlRfVEFCTEUoIjExLjMxJSIsIjIuMDAzJSIsIjk1Ljk5NSUiLCI3Ny41ODUlIixodG1sX3RhYmxlKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiVm9yaWVudCIsMyk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImh0bWxfdGFibGUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiMy44NzklIiwiMTAuMTI2JSIsIjIuMDUlIiwi5Y2V5o2u6YeR6aKd77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiMTIuMDY1JSIsIjE1LjExMyUiLCIyLjA1JSIsdG90YWwpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRvdGFsIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNjc2JSIsIjM2LjYyNSUiLCIxMC4xMjYlIiwiMi4wNSUiLCLlrp7pmYXph5Hpop06Iik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiNDQuOTM3JSIsIjE1LjExMyUiLCIyLjA1JSIsYWN0dWFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJhY3R1YWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiNzAuMjUyJSIsIjEwLjEyNiUiLCIyLjA1JSIsIuWunuaUtumHkeminToiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkxLjY3NiUiLCI3OC41NjQlIiwiMTUuMTEzJSIsIjIuMDUlIixtb25leSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwibW9uZXkiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNDMlIiwiMy44NzklIiwiMTAuMTI2JSIsIjIuMDUlIiwi5Yi25Y2V5Lq677yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiMTIuMzQzJSIsIjE1LjExMyUiLCIyLjA1JSIsdXNlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidXNlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCIzNi45MDIlIiwiMTAuMDc2JSIsIjIuMDUlIiwi57uT566X6LSm5oi377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiNDUuMjE0JSIsIjE1LjExMyUiLCIyLjA1JSIsYWNjb3VudCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiYWNjb3VudCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCI3MC41MjklIiwiMTAuODMxJSIsIjIuMDUlIiwi5aSH5rOo5L+h5oGv77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiNzguODQxJSIsIjE1LjExMyUiLCIyLjA1JSIsZGF0YSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiZGF0YSIpOw0K','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi5pyN5Yqh5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjg1LjUyNCUiLCIwLjk5NSUiLCI4NS43MTQlIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiOTEuODQ4JSIsIjAuOTk1JSIsIjkyLjAzOCUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIzLjI1NyUiLCI0MCUiLCIyMCUiLCI2LjMyNCUiLCLmnI3liqHljZUiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDE0KTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQWxpZ25tZW50IiwyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQm9sZCIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMy44NzklIiwiOS44NzQlIiwiMy45MjQlIiwi6LSt5Lmw5a6i5oi377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMTEuODE0JSIsIjE3LjQzMSUiLCIzLjkyNCUiLGN1c3RvbWVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJjdXN0b21lciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE3MSUiLCIzNS4yMzklIiwiMTAuMDc2JSIsIjMuOTI0JSIsIuWNleaNruaXpeacn++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjQzLjQyNiUiLCIxOC4wNiUiLCIzLjkyNCUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMS45ODElIiwiNzAuMjUyJSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7nvJblj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjExLjk4MSUiLCI3OC4xODYlIiwiMTguMDYlIiwiMy45MjQlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIxOC43ODElIiwiMi4wMDMlIiwiOTUuOTk1JSIsIjY0Ljk5JSIsaHRtbF90YWJsZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIlZvcmllbnQiLDMpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJodG1sX3RhYmxlIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiODYuOTUyJSIsIjMuODc5JSIsIjEwLjEyNiUiLCIzLjkyNCUiLCLljZXmja7ph5Hpop3vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCIxMi4wNjUlIiwiMTUuMTI2JSIsIjMuOTI0JSIsdG90YWwpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRvdGFsIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiODYuOTUyJSIsIjM2LjYyNSUiLCIxMC4xMjYlIiwiMy45MjQlIiwi5a6e6ZmF6YeR6aKdOiIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiODYuOTUyJSIsIjQ0LjkzNyUiLCIxNS4xMjYlIiwiMy45MjQlIixhY3R1YWwpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImFjdHVhbCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCI3MC4yNTIlIiwiMTAuMTI2JSIsIjMuOTI0JSIsIuWunuaUtumHkeminToiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCI3OC41NjQlIiwiMTUuMTI2JSIsIjMuOTI0JSIsbW9uZXkpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm1vbmV5Iik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNzcxJSIsIjMuODc5JSIsIjEwLjEyNiUiLCIzLjkyNCUiLCLliLbljZXkurrvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjYzOCUiLCIxMi4zNDMlIiwiMTUuMTI2JSIsIjMuOTI0JSIsdXNlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidXNlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCIzNi45MTQlIiwiMTAuMDc2JSIsIjMuOTI0JSIsIue7k+eul+i0puaIt++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuODI5JSIsIjQ0Ljc3MyUiLCIxNS4xMjYlIiwiMy45MjQlIixhY2NvdW50KTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJhY2NvdW50Iik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuODI5JSIsIjcwLjUyOSUiLCIxMC44MzElIiwiMy45MjQlIiwi5aSH5rOo5L+h5oGv77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My44MjklIiwiNzguODQxJSIsIjE1LjEyNiUiLCIzLjkyNCUiLGRhdGEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImRhdGEiKTsNCg==','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi5pyN5Yqh5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkwLjA1MyUiLCIwLjk5NSUiLDEwMTEsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIuacjeWKoeWNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJCb2xkIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjMuODc5JSIsIjkuODc0JSIsIjIuMDUlIiwi6LSt5Lmw5a6i5oi377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIxMS44MTQlIiwiMTcuNDMxJSIsIjIuMDUlIixjdXN0b21lcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiY3VzdG9tZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIzNS4yMzklIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u5pel5pyf77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI0My40MjYlIiwiMTguMDYlIiwiMi4wNSUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI3MC4yNTIlIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u57yW5Y+377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI3OC4xODYlIiwiMTguMDYlIiwiMi4wNSUiLG51bWJlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwibnVtYmVyIik7DQpMT0RPUC5BRERfUFJJTlRfVEFCTEUoIjExLjMxJSIsIjIuMDAzJSIsIjk1Ljk5NSUiLCI3Ny41ODUlIixodG1sX3RhYmxlKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiVm9yaWVudCIsMyk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImh0bWxfdGFibGUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiMy44NzklIiwiMTAuMTI2JSIsIjIuMDUlIiwi5Y2V5o2u6YeR6aKd77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiMTIuMDY1JSIsIjE1LjExMyUiLCIyLjA1JSIsdG90YWwpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRvdGFsIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNjc2JSIsIjM2LjYyNSUiLCIxMC4xMjYlIiwiMi4wNSUiLCLlrp7pmYXph5Hpop06Iik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiNDQuOTM3JSIsIjE1LjExMyUiLCIyLjA1JSIsYWN0dWFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJhY3R1YWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiNzAuMjUyJSIsIjEwLjEyNiUiLCIyLjA1JSIsIuWunuaUtumHkeminToiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkxLjY3NiUiLCI3OC41NjQlIiwiMTUuMTEzJSIsIjIuMDUlIixtb25leSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwibW9uZXkiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNDMlIiwiMy44NzklIiwiMTAuMTI2JSIsIjIuMDUlIiwi5Yi25Y2V5Lq677yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiMTIuMzQzJSIsIjE1LjExMyUiLCIyLjA1JSIsdXNlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidXNlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCIzNi45MDIlIiwiMTAuMDc2JSIsIjIuMDUlIiwi57uT566X6LSm5oi377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiNDUuMjE0JSIsIjE1LjExMyUiLCIyLjA1JSIsYWNjb3VudCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiYWNjb3VudCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCI3MC41MjklIiwiMTAuODMxJSIsIjIuMDUlIiwi5aSH5rOo5L+h5oGv77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiNzguODQxJSIsIjE1LjExMyUiLCIyLjA1JSIsZGF0YSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiZGF0YSIpOw0K','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi5pyN5Yqh5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjg1LjUyNCUiLCIwLjk5NSUiLCI4NS43MTQlIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiOTEuODQ4JSIsIjAuOTk1JSIsIjkyLjAzOCUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIzLjI1NyUiLCI0MCUiLCIyMCUiLCI2LjMyNCUiLCLmnI3liqHljZUiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDE0KTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQWxpZ25tZW50IiwyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQm9sZCIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMy44NzklIiwiOS44NzQlIiwiMy45MjQlIiwi6LSt5Lmw5a6i5oi377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMTEuODE0JSIsIjE3LjQzMSUiLCIzLjkyNCUiLGN1c3RvbWVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJjdXN0b21lciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE3MSUiLCIzNS4yMzklIiwiMTAuMDc2JSIsIjMuOTI0JSIsIuWNleaNruaXpeacn++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjQzLjQyNiUiLCIxOC4wNiUiLCIzLjkyNCUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMS45ODElIiwiNzAuMjUyJSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7nvJblj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjExLjk4MSUiLCI3OC4xODYlIiwiMTguMDYlIiwiMy45MjQlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIxOC43ODElIiwiMi4wMDMlIiwiOTUuOTk1JSIsIjY0Ljk5JSIsaHRtbF90YWJsZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIlZvcmllbnQiLDMpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJodG1sX3RhYmxlIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiODYuOTUyJSIsIjMuODc5JSIsIjEwLjEyNiUiLCIzLjkyNCUiLCLljZXmja7ph5Hpop3vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCIxMi4wNjUlIiwiMTUuMTI2JSIsIjMuOTI0JSIsdG90YWwpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRvdGFsIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiODYuOTUyJSIsIjM2LjYyNSUiLCIxMC4xMjYlIiwiMy45MjQlIiwi5a6e6ZmF6YeR6aKdOiIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiODYuOTUyJSIsIjQ0LjkzNyUiLCIxNS4xMjYlIiwiMy45MjQlIixhY3R1YWwpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImFjdHVhbCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCI3MC4yNTIlIiwiMTAuMTI2JSIsIjMuOTI0JSIsIuWunuaUtumHkeminToiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCI3OC41NjQlIiwiMTUuMTI2JSIsIjMuOTI0JSIsbW9uZXkpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm1vbmV5Iik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNzcxJSIsIjMuODc5JSIsIjEwLjEyNiUiLCIzLjkyNCUiLCLliLbljZXkurrvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjYzOCUiLCIxMi4zNDMlIiwiMTUuMTI2JSIsIjMuOTI0JSIsdXNlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidXNlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCIzNi45MTQlIiwiMTAuMDc2JSIsIjMuOTI0JSIsIue7k+eul+i0puaIt++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuODI5JSIsIjQ0Ljc3MyUiLCIxNS4xMjYlIiwiMy45MjQlIixhY2NvdW50KTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJhY2NvdW50Iik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuODI5JSIsIjcwLjUyOSUiLCIxMC44MzElIiwiMy45MjQlIiwi5aSH5rOo5L+h5oGv77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My44MjklIiwiNzguODQxJSIsIjE1LjEyNiUiLCIzLjkyNCUiLGRhdGEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImRhdGEiKTsNCg==','服务单');
INSERT INTO `is_prints` (`id`,`name`,`paper4`,`paper2`,`paper4default`,`paper2default`,`data`) VALUES ('19','exchange','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi56ev5YiG5YWR5o2i5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkwLjA1MyUiLCIwLjk5NSUiLDEwMTEsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIuenr+WIhuWFkeaNouWNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJCb2xkIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjMuODc5JSIsIjkuODc0JSIsIjIuMDUlIiwi6LSt5Lmw5a6i5oi377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIxMS44MTQlIiwiMTcuNDMxJSIsIjIuMDUlIixjdXN0b21lcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiY3VzdG9tZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIzNS4yMzklIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u5pel5pyf77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI0My40MjYlIiwiMTguMDYlIiwiMi4wNSUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI3MC4yNTIlIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u57yW5Y+377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI3OC4xODYlIiwiMTkuMzIlIiwiMi4wNSUiLG51bWJlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwibnVtYmVyIik7DQpMT0RPUC5BRERfUFJJTlRfVEFCTEUoIjExLjM5OSUiLCIyLjAwMyUiLCI5NS45OTUlIiwiNzcuMzE3JSIsaHRtbF90YWJsZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIlZvcmllbnQiLDMpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJodG1sX3RhYmxlIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNjc2JSIsIjMuODc5JSIsIjEwLjEyNiUiLCIyLjA1JSIsIuWNleaNruenr+WIhu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNjc2JSIsIjEyLjA2NSUiLCIxNS4xMTMlIiwiMi4wNSUiLHRvdGFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0b3RhbCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkxLjY3NiUiLCIzNi42MjUlIiwiMTAuMTI2JSIsIjIuMDUlIiwi5a6e6ZmF56ev5YiGOiIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNjc2JSIsIjQ0LjkzNyUiLCIxNS4xMTMlIiwiMi4wNSUiLGFjdHVhbCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiYWN0dWFsIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNjc2JSIsIjcwLjI1MiUiLCIxMC4xMjYlIiwiMi4wNSUiLCLlrp7ku5jnp6/liIY6Iik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiNzguNTY0JSIsIjE1LjExMyUiLCIyLjA1JSIsaW50ZWdyYWwpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImludGVncmFsIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDg3JSIsIjMuNzUzJSIsIjEwLjEyNiUiLCIyLjA1JSIsIuWuouaIt+enr+WIhu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDQzJSIsIjEyLjIxNyUiLCIxNS4xMjYlIiwiMi4wNSUiLGN1c3RvbWVyX2ludGVncmFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJjdXN0b21lcl9pbnRlZ3JhbCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA0MyUiLCIzNi42MjUlIiwiMTAuMTI2JSIsIjIuMDUlIiwi5Yi25Y2V5Lq677yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiNDUuMDg4JSIsIjE1LjExMyUiLCIyLjA1JSIsdXNlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidXNlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCI3MC4yNzclIiwiMTAuODMxJSIsIjIuMDUlIiwi5aSH5rOo5L+h5oGv77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiNzguNTg5JSIsIjE1LjExMyUiLCIyLjA1JSIsZGF0YSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiZGF0YSIpOw0K','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi56ev5YiG5YWR5o2i5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjg1LjUyNCUiLCIwLjk5NSUiLCI4NS43MTQlIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiOTEuODQ4JSIsIjAuOTk1JSIsIjkyLjAzOCUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIzLjI1NyUiLCI0MCUiLCIyMCUiLCI2LjMyNCUiLCLnp6/liIblhZHmjaLljZUiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDE0KTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQWxpZ25tZW50IiwyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQm9sZCIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMy44NzklIiwiOS44NzQlIiwiMy45MjQlIiwi6LSt5Lmw5a6i5oi377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMTEuODE0JSIsIjE3LjQzMSUiLCIzLjkyNCUiLGN1c3RvbWVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJjdXN0b21lciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE3MSUiLCIzNi4yNDclIiwiMTAuMDc2JSIsIjMuOTI0JSIsIuWNleaNruaXpeacn++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjQ0LjQzMyUiLCIxOC4wNiUiLCIzLjkyNCUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMS45ODElIiwiNzAuMjUyJSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7nvJblj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjExLjk4MSUiLCI3OC4xODYlIiwiMTkuOTUlIiwiMy45MjQlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIxOC45NzElIiwiMi4wMDMlIiwiOTUuOTk1JSIsIjYzLjA4NiUiLGh0bWxfdGFibGUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJWb3JpZW50IiwzKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiaHRtbF90YWJsZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCIzLjg3OSUiLCIxMC4xMjYlIiwiMy45MjQlIiwi5Y2V5o2u56ev5YiG77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI4Ni45NTIlIiwiMTIuMDY1JSIsIjE1LjEyNiUiLCIzLjkyNCUiLHRvdGFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0b3RhbCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCIzNi42MjUlIiwiMTAuMTI2JSIsIjMuOTI0JSIsIuWunumZheenr+WIhu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiODYuOTUyJSIsIjQ0LjkzNyUiLCIxNS4xMjYlIiwiMy45MjQlIixhY3R1YWwpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImFjdHVhbCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCI3MC4yNTIlIiwiMTAuMTI2JSIsIjMuOTI0JSIsIuWunuS7mOenr+WIhu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiODYuOTUyJSIsIjc4LjU2NCUiLCIxNS4xMjYlIiwiMy45MjQlIixpbnRlZ3JhbCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiaW50ZWdyYWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My43NzElIiwiMy44NzklIiwiMTAuMTI2JSIsIjMuOTI0JSIsIuWuouaIt+enr+WIhu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNjM4JSIsIjEyLjM0MyUiLCIxNS4xMjYlIiwiMy45MjQlIixjdXN0b21lcl9pbnRlZ3JhbCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiY3VzdG9tZXJfaW50ZWdyYWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My43NzElIiwiMzYuNjI1JSIsIjEwLjEyNiUiLCIzLjkyNCUiLCLliLbljZXkurrvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjYzOCUiLCI0NS4wODglIiwiMTUuMTI2JSIsIjMuOTI0JSIsdXNlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidXNlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCI3MC4yNzclIiwiMTAuODMxJSIsIjMuOTI0JSIsIuWkh+azqOS/oeaBr++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuODI5JSIsIjc4LjU4OSUiLCIxNS4xMTMlIiwiMy45MjQlIixkYXRhKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJkYXRhIik7DQo=','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi56ev5YiG5YWR5o2i5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkwLjA1MyUiLCIwLjk5NSUiLDEwMTEsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIuenr+WIhuWFkeaNouWNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJCb2xkIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjcuNDQyJSIsIjMuODc5JSIsIjkuODc0JSIsIjIuMDUlIiwi6LSt5Lmw5a6i5oi377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIxMS44MTQlIiwiMTcuNDMxJSIsIjIuMDUlIixjdXN0b21lcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiY3VzdG9tZXIiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIzNS4yMzklIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u5pel5pyf77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI0My40MjYlIiwiMTguMDYlIiwiMi4wNSUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI3MC4yNTIlIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u57yW5Y+377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI3OC4xODYlIiwiMTkuMzIlIiwiMi4wNSUiLG51bWJlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwibnVtYmVyIik7DQpMT0RPUC5BRERfUFJJTlRfVEFCTEUoIjExLjM5OSUiLCIyLjAwMyUiLCI5NS45OTUlIiwiNzcuMzE3JSIsaHRtbF90YWJsZSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIlZvcmllbnQiLDMpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJodG1sX3RhYmxlIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNjc2JSIsIjMuODc5JSIsIjEwLjEyNiUiLCIyLjA1JSIsIuWNleaNruenr+WIhu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNjc2JSIsIjEyLjA2NSUiLCIxNS4xMTMlIiwiMi4wNSUiLHRvdGFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0b3RhbCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkxLjY3NiUiLCIzNi42MjUlIiwiMTAuMTI2JSIsIjIuMDUlIiwi5a6e6ZmF56ev5YiGOiIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNjc2JSIsIjQ0LjkzNyUiLCIxNS4xMTMlIiwiMi4wNSUiLGFjdHVhbCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiYWN0dWFsIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTEuNjc2JSIsIjcwLjI1MiUiLCIxMC4xMjYlIiwiMi4wNSUiLCLlrp7ku5jnp6/liIY6Iik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5MS42NzYlIiwiNzguNTY0JSIsIjE1LjExMyUiLCIyLjA1JSIsaW50ZWdyYWwpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImludGVncmFsIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDg3JSIsIjMuNzUzJSIsIjEwLjEyNiUiLCIyLjA1JSIsIuWuouaIt+enr+WIhu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDQzJSIsIjEyLjIxNyUiLCIxNS4xMjYlIiwiMi4wNSUiLGN1c3RvbWVyX2ludGVncmFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJjdXN0b21lcl9pbnRlZ3JhbCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA0MyUiLCIzNi42MjUlIiwiMTAuMTI2JSIsIjIuMDUlIiwi5Yi25Y2V5Lq677yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiNDUuMDg4JSIsIjE1LjExMyUiLCIyLjA1JSIsdXNlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidXNlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCI3MC4yNzclIiwiMTAuODMxJSIsIjIuMDUlIiwi5aSH5rOo5L+h5oGv77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5Ni4wNzglIiwiNzguNTg5JSIsIjE1LjExMyUiLCIyLjA1JSIsZGF0YSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiZGF0YSIpOw0K','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi56ev5YiG5YWR5o2i5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjg1LjUyNCUiLCIwLjk5NSUiLCI4NS43MTQlIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiOTEuODQ4JSIsIjAuOTk1JSIsIjkyLjAzOCUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIzLjI1NyUiLCI0MCUiLCIyMCUiLCI2LjMyNCUiLCLnp6/liIblhZHmjaLljZUiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDE0KTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQWxpZ25tZW50IiwyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQm9sZCIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMy44NzklIiwiOS44NzQlIiwiMy45MjQlIiwi6LSt5Lmw5a6i5oi377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMi4zNjIlIiwiMTEuODE0JSIsIjE3LjQzMSUiLCIzLjkyNCUiLGN1c3RvbWVyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJjdXN0b21lciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE3MSUiLCIzNi4yNDclIiwiMTAuMDc2JSIsIjMuOTI0JSIsIuWNleaNruaXpeacn++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjQ0LjQzMyUiLCIxOC4wNiUiLCIzLjkyNCUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMS45ODElIiwiNzAuMjUyJSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7nvJblj7fvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjExLjk4MSUiLCI3OC4xODYlIiwiMTkuOTUlIiwiMy45MjQlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIxOC45NzElIiwiMi4wMDMlIiwiOTUuOTk1JSIsIjYzLjA4NiUiLGh0bWxfdGFibGUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJWb3JpZW50IiwzKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiaHRtbF90YWJsZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCIzLjg3OSUiLCIxMC4xMjYlIiwiMy45MjQlIiwi5Y2V5o2u56ev5YiG77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI4Ni45NTIlIiwiMTIuMDY1JSIsIjE1LjEyNiUiLCIzLjkyNCUiLHRvdGFsKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0b3RhbCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCIzNi42MjUlIiwiMTAuMTI2JSIsIjMuOTI0JSIsIuWunumZheenr+WIhu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiODYuOTUyJSIsIjQ0LjkzNyUiLCIxNS4xMjYlIiwiMy45MjQlIixhY3R1YWwpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImFjdHVhbCIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjg2Ljk1MiUiLCI3MC4yNTIlIiwiMTAuMTI2JSIsIjMuOTI0JSIsIuWunuS7mOenr+WIhu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiODYuOTUyJSIsIjc4LjU2NCUiLCIxNS4xMjYlIiwiMy45MjQlIixpbnRlZ3JhbCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiaW50ZWdyYWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My43NzElIiwiMy44NzklIiwiMTAuMTI2JSIsIjMuOTI0JSIsIuWuouaIt+enr+WIhu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNjM4JSIsIjEyLjM0MyUiLCIxNS4xMjYlIiwiMy45MjQlIixjdXN0b21lcl9pbnRlZ3JhbCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiY3VzdG9tZXJfaW50ZWdyYWwiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My43NzElIiwiMzYuNjI1JSIsIjEwLjEyNiUiLCIzLjkyNCUiLCLliLbljZXkurrvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjYzOCUiLCI0NS4wODglIiwiMTUuMTI2JSIsIjMuOTI0JSIsdXNlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwidXNlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjkzLjgyOSUiLCI3MC4yNzclIiwiMTAuODMxJSIsIjMuOTI0JSIsIuWkh+azqOS/oeaBr++8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuODI5JSIsIjc4LjU4OSUiLCIxNS4xMTMlIiwiMy45MjQlIixkYXRhKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJkYXRhIik7DQo=','积分兑换单');
INSERT INTO `is_prints` (`id`,`name`,`paper4`,`paper2`,`paper4default`,`paper2default`,`data`) VALUES ('20','eft','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi6LWE6YeR6LCD5ouo5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIui1hOmHkeiwg+aLqOWNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiMy45NTUlIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u5pel5pyf77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIxMS42ODglIiwiMTguMDYlIiwiMi4wNSUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIzNy43MDglIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u57yW5Y+377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI0NS42OTMlIiwiMjMuMDk4JSIsIjIuMDUlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIxMS4yMjElIiwiMi4wMDMlIiwiOTUuOTk1JSIsIjgyLjA0MSUiLGh0bWxfdGFibGUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJWb3JpZW50IiwzKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiaHRtbF90YWJsZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA0MyUiLCI1LjQ2NiUiLCIxMC4xMjYlIiwiMi4wNSUiLCLliLbljZXkurrvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCIxMS45NjUlIiwiMTUuMTEzJSIsIjIuMDUlIix1c2VyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ1c2VyIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjM3LjcwOCUiLCIxMC44MzElIiwiMi4wNSUiLCLlpIfms6jkv6Hmga/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCI0NS45NyUiLCIxNS4xMTMlIiwiMi4wNSUiLGRhdGEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImRhdGEiKTsNCg==','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi6LWE6YeR6LCD5ouo5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkxLjg0OCUiLCIwLjk5NSUiLCI5Mi4wMzglIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMy4yNTclIiwiNDAlIiwiMjAlIiwiNi4zMjQlIiwi6LWE6YeR6LCD5ouo5Y2VIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxNCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkFsaWdubWVudCIsMik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkJvbGQiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjUuMjE0JSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7ml6XmnJ/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE3MSUiLCIxMy4wNzMlIiwiMTguMDYlIiwiMy45MjQlIix0aW1lKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0aW1lIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTEuOTgxJSIsIjM4LjQyNiUiLCIxMC4wNzYlIiwiMy45MjQlIiwi5Y2V5o2u57yW5Y+377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMS45ODElIiwiNDYuNTc0JSIsIjIxLjgzOSUiLCIzLjkyNCUiLG51bWJlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwibnVtYmVyIik7DQpMT0RPUC5BRERfUFJJTlRfVEFCTEUoIjE4LjU5JSIsIjIuMDAzJSIsIjk1Ljk5NSUiLCI3MS4yNzYlIixodG1sX3RhYmxlKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiVm9yaWVudCIsMyk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImh0bWxfdGFibGUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My43NzElIiwiNS40NjYlIiwiMTAuMTI2JSIsIjMuOTI0JSIsIuWItuWNleS6uu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNjM4JSIsIjEyLjA5MSUiLCIxNS4xMjYlIiwiMy45MjQlIix1c2VyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ1c2VyIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNjM4JSIsIjM4LjY3OCUiLCIxMC44MzElIiwiMy45MjQlIiwi5aSH5rOo5L+h5oGv77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My42MzglIiwiNDYuODUxJSIsIjE1LjEyNiUiLCIzLjkyNCUiLGRhdGEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImRhdGEiKTsNCg==','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjI5Ni45OW1tIiwi6LWE6YeR6LCD5ouo5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDI5NzAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OTglIiwiMC45OTUlIiwiOTcuOTk3JSIsIjk4LjAwNCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCI1Ljk5OCUiLCIwLjk5NSUiLDY4LCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxMC41NDQlIiwiMC45OTUlIiwxMTksIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjk0LjY4OCUiLCIwLjk5NSUiLDEwNjMsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjIuNDk2JSIsIjQwJSIsIjIwJSIsIjIuNTU4JSIsIui1hOmHkeiwg+aLqOWNlSIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTQpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJBbGlnbm1lbnQiLDIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiNy40NDIlIiwiMy45NTUlIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u5pel5pyf77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIxMS42ODglIiwiMTguMDYlIiwiMi4wNSUiLHRpbWUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsInRpbWUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCIzNy43MDglIiwiMTAuMDc2JSIsIjIuMDUlIiwi5Y2V5o2u57yW5Y+377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI3LjQ0MiUiLCI0NS42OTMlIiwiMjMuMDk4JSIsIjIuMDUlIixudW1iZXIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsIm51bWJlciIpOw0KTE9ET1AuQUREX1BSSU5UX1RBQkxFKCIxMS4yMjElIiwiMi4wMDMlIiwiOTUuOTk1JSIsIjgyLjA0MSUiLGh0bWxfdGFibGUpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJWb3JpZW50IiwzKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwiaHRtbF90YWJsZSIpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA0MyUiLCI1LjQ2NiUiLCIxMC4xMjYlIiwiMi4wNSUiLCLliLbljZXkurrvvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCIxMS45NjUlIiwiMTUuMTEzJSIsIjIuMDUlIix1c2VyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ1c2VyIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTYuMDc4JSIsIjM3LjcwOCUiLCIxMC44MzElIiwiMi4wNSUiLCLlpIfms6jkv6Hmga/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjk2LjA3OCUiLCI0NS45NyUiLCIxNS4xMTMlIiwiMi4wNSUiLGRhdGEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImRhdGEiKTsNCg==','TE9ET1AuUFJJTlRfSU5JVEEoMCwwLCIyMTBtbSIsIjEzOS4wMW1tIiwi6LWE6YeR6LCD5ouo5Y2VIC0g5omT5Y2wIik7DQpMT0RPUC5TRVRfUFJJTlRfUEFHRVNJWkUoMSwyMTAwLDEzOTAsIiIpOw0KTE9ET1AuU0VUX1BSSU5UX01PREUoIlBST0dSQU1fQ09OVEVOVF9CWVZBUiIsdHJ1ZSk7DQpMT0RPUC5BRERfUFJJTlRfUkVDVCgiMC45OSUiLCIwLjk5NSUiLCI5Ny45OTclIiwiOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfTElORSgiMTAuMzQzJSIsIjAuOTk1JSIsIjEwLjUzMyUiLCI5OC45OCUiLDAsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9MSU5FKCIxNy4zNTIlIiwiMC45OTUlIiwiMTcuNTQzJSIsIjk4Ljk4JSIsMCwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX0xJTkUoIjkxLjg0OCUiLCIwLjk5NSUiLCI5Mi4wMzglIiwiOTguOTglIiwwLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMy4yNTclIiwiNDAlIiwiMjAlIiwiNi4zMjQlIiwi6LWE6YeR6LCD5ouo5Y2VIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxNCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkFsaWdubWVudCIsMik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkJvbGQiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTIuMTcxJSIsIjUuMjE0JSIsIjEwLjA3NiUiLCIzLjkyNCUiLCLljZXmja7ml6XmnJ/vvJoiKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuQUREX1BSSU5UX1RFWFQoIjEyLjE3MSUiLCIxMy4wNzMlIiwiMTguMDYlIiwiMy45MjQlIix0aW1lKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ0aW1lIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiMTEuOTgxJSIsIjM4LjQyNiUiLCIxMC4wNzYlIiwiMy45MjQlIiwi5Y2V5o2u57yW5Y+377yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCIxMS45ODElIiwiNDYuNTc0JSIsIjIxLjgzOSUiLCIzLjkyNCUiLG51bWJlcik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiQ29udGVudFZOYW1lIiwibnVtYmVyIik7DQpMT0RPUC5BRERfUFJJTlRfVEFCTEUoIjE4LjU5JSIsIjIuMDAzJSIsIjk1Ljk5NSUiLCI3MS4yNzYlIixodG1sX3RhYmxlKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiVm9yaWVudCIsMyk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImh0bWxfdGFibGUiKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My43NzElIiwiNS40NjYlIiwiMTAuMTI2JSIsIjMuOTI0JSIsIuWItuWNleS6uu+8miIpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNjM4JSIsIjEyLjA5MSUiLCIxNS4xMjYlIiwiMy45MjQlIix1c2VyKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiRm9udFNpemUiLDEwKTsNCkxPRE9QLlNFVF9QUklOVF9TVFlMRUEoMCwiSXRlbVR5cGUiLDEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJDb250ZW50Vk5hbWUiLCJ1c2VyIik7DQpMT0RPUC5BRERfUFJJTlRfVEVYVCgiOTMuNjM4JSIsIjM4LjY3OCUiLCIxMC44MzElIiwiMy45MjQlIiwi5aSH5rOo5L+h5oGv77yaIik7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkZvbnRTaXplIiwxMCk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkl0ZW1UeXBlIiwxKTsNCkxPRE9QLkFERF9QUklOVF9URVhUKCI5My42MzglIiwiNDYuODUxJSIsIjE1LjEyNiUiLCIzLjkyNCUiLGRhdGEpOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJGb250U2l6ZSIsMTApOw0KTE9ET1AuU0VUX1BSSU5UX1NUWUxFQSgwLCJJdGVtVHlwZSIsMSk7DQpMT0RPUC5TRVRfUFJJTlRfU1RZTEVBKDAsIkNvbnRlbnRWTmFtZSIsImRhdGEiKTsNCg==','资金调拨单');

-- ----------------------------
-- Table structure for is_purchasebill
-- ----------------------------
DROP TABLE IF EXISTS `is_purchasebill`;
CREATE TABLE `is_purchasebill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '所属ID',
  `account` int(11) NOT NULL COMMENT '结算账户',
  `money` decimal(10,2) NOT NULL COMMENT '金额',
  `data` varchar(128) NOT NULL COMMENT '备注信息',
  `user` int(11) NOT NULL COMMENT '操作人',
  `time` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `pid_account_user` (`pid`,`account`,`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='购货核销单';
-- ----------------------------
-- Records of is_purchasebill
-- ----------------------------

-- ----------------------------
-- Table structure for is_purchaseclass
-- ----------------------------
DROP TABLE IF EXISTS `is_purchaseclass`;
CREATE TABLE `is_purchaseclass` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `merchant` int(11) NOT NULL COMMENT '所属商户',
  `supplier` int(11) NOT NULL COMMENT '供应商ID',
  `time` int(11) NOT NULL COMMENT '单据时间',
  `number` varchar(32) NOT NULL COMMENT '单据编号',
  `total` decimal(10,2) NOT NULL COMMENT '单据金额',
  `actual` decimal(10,2) NOT NULL COMMENT '实际金额',
  `money` decimal(10,2) NOT NULL COMMENT '实付金额',
  `user` int(11) NOT NULL COMMENT '制单人',
  `account` int(11) NOT NULL COMMENT '结算账户',
  `file` varchar(128) DEFAULT '' COMMENT '单据附件',
  `data` varchar(128) DEFAULT '' COMMENT '备注信息',
  `type` tinyint(1) NOT NULL COMMENT '审核状态[0:未审核|1:已审核]',
  `auditinguser` int(11) NOT NULL COMMENT '审核人',
  `auditingtime` int(11) NOT NULL COMMENT '审核时间',
  `billtype` tinyint(1) DEFAULT '-1' COMMENT '核销类型[-1:未处理|0:未核销|1:部分核销|2:已核销|3:强制核销]',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `merchant_supplier_user_account_type` (`merchant`,`supplier`,`user`,`account`,`type`),
  KEY `time_number` (`time`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='购货单';
-- ----------------------------
-- Records of is_purchaseclass
-- ----------------------------

-- ----------------------------
-- Table structure for is_purchaseinfo
-- ----------------------------
DROP TABLE IF EXISTS `is_purchaseinfo`;
CREATE TABLE `is_purchaseinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '所属ID',
  `goods` int(11) NOT NULL COMMENT '商品ID',
  `attr` varchar(32) DEFAULT '' COMMENT '辅助属性',
  `warehouse` int(11) NOT NULL COMMENT '仓库ID',
  `batch` varchar(32) DEFAULT '' COMMENT '批次',
  `serial` text COMMENT '串码',
  `nums` decimal(10,2) NOT NULL COMMENT '数量',
  `price` decimal(10,2) NOT NULL COMMENT '单价',
  `total` decimal(10,2) NOT NULL COMMENT '总价',
  `data` varchar(128) DEFAULT '' COMMENT '备注',
  `room` int(11) NOT NULL COMMENT '仓储ID',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `pid_goods_warehouse_room` (`pid`,`goods`,`warehouse`,`room`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='购货详情单表';
-- ----------------------------
-- Records of is_purchaseinfo
-- ----------------------------

-- ----------------------------
-- Table structure for is_recashierclass
-- ----------------------------
DROP TABLE IF EXISTS `is_recashierclass`;
CREATE TABLE `is_recashierclass` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `merchant` int(11) NOT NULL COMMENT '所属商户',
  `customer` int(11) NOT NULL COMMENT '客户ID',
  `time` int(11) NOT NULL COMMENT '单据时间',
  `number` varchar(32) NOT NULL COMMENT '单据编号',
  `total` decimal(10,2) NOT NULL COMMENT '单据金额',
  `actual` decimal(10,2) NOT NULL COMMENT '实际金额',
  `money` decimal(10,2) NOT NULL COMMENT '实付金额',
  `user` int(11) NOT NULL COMMENT '制单人',
  `account` int(11) NOT NULL COMMENT '结算账户',
  `integral` decimal(10,2) NOT NULL COMMENT '扣除积分',
  `file` varchar(128) DEFAULT '' COMMENT '单据附件',
  `data` varchar(128) DEFAULT '' COMMENT '备注信息',
  `type` tinyint(1) NOT NULL COMMENT '审核状态[0:未审核|1:已审核]',
  `auditinguser` int(11) NOT NULL COMMENT '审核人',
  `auditingtime` int(11) NOT NULL COMMENT '审核时间',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `merchant_customer_user_account_type` (`merchant`,`customer`,`user`,`account`,`type`),
  KEY `time_number` (`time`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='零售退货单';
-- ----------------------------
-- Records of is_recashierclass
-- ----------------------------

-- ----------------------------
-- Table structure for is_recashierinfo
-- ----------------------------
DROP TABLE IF EXISTS `is_recashierinfo`;
CREATE TABLE `is_recashierinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '所属ID',
  `room` int(11) NOT NULL COMMENT '仓储ID',
  `goods` int(11) NOT NULL COMMENT '商品ID(搜索用)',
  `warehouse` int(11) NOT NULL COMMENT '仓库ID(搜索用)',
  `serial` text COMMENT '串号',
  `nums` decimal(10,2) NOT NULL COMMENT '数量',
  `price` decimal(10,2) NOT NULL COMMENT '单价',
  `total` decimal(10,2) NOT NULL COMMENT '总价',
  `data` varchar(128) DEFAULT '' COMMENT '备注',
  `more` text COMMENT '扩展标识',
  PRIMARY KEY (`id`),
  KEY `pid_room_goods_warehouse` (`pid`,`room`,`goods`,`warehouse`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='零售退货详情表';
-- ----------------------------
-- Records of is_recashierinfo
-- ----------------------------

-- ----------------------------
-- Table structure for is_repurchasebill
-- ----------------------------
DROP TABLE IF EXISTS `is_repurchasebill`;
CREATE TABLE `is_repurchasebill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '所属ID',
  `account` int(11) NOT NULL COMMENT '结算账户',
  `money` decimal(10,2) NOT NULL COMMENT '金额',
  `data` varchar(128) NOT NULL COMMENT '备注信息',
  `user` int(11) NOT NULL COMMENT '操作人',
  `time` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `pid_account_user` (`pid`,`account`,`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='购货退货核销单';
-- ----------------------------
-- Records of is_repurchasebill
-- ----------------------------

-- ----------------------------
-- Table structure for is_repurchaseclass
-- ----------------------------
DROP TABLE IF EXISTS `is_repurchaseclass`;
CREATE TABLE `is_repurchaseclass` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `merchant` int(11) NOT NULL COMMENT '所属商户',
  `supplier` int(11) NOT NULL COMMENT '供应商ID',
  `time` int(11) NOT NULL COMMENT '单据时间',
  `number` varchar(32) NOT NULL COMMENT '单据编号',
  `total` decimal(10,2) NOT NULL COMMENT '单据金额',
  `actual` decimal(10,2) NOT NULL COMMENT '实际金额',
  `money` decimal(10,2) NOT NULL COMMENT '实收金额',
  `user` int(11) NOT NULL COMMENT '制单人',
  `account` int(11) NOT NULL COMMENT '结算账户',
  `file` varchar(128) DEFAULT '' COMMENT '单据附件',
  `data` varchar(128) DEFAULT '' COMMENT '备注信息',
  `type` tinyint(1) NOT NULL COMMENT '审核状态[0:未审核|1:已审核]',
  `auditinguser` int(11) NOT NULL COMMENT '审核人',
  `auditingtime` int(11) NOT NULL COMMENT '审核时间',
  `billtype` tinyint(1) DEFAULT '-1' COMMENT '核销类型[-1:未处理|0:未核销|1:部分核销|2:已核销|3:强制核销]',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `merchant_supplier_user_account_type` (`merchant`,`supplier`,`user`,`account`,`type`),
  KEY `time_number` (`time`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='购货退货单';
-- ----------------------------
-- Records of is_repurchaseclass
-- ----------------------------

-- ----------------------------
-- Table structure for is_repurchaseinfo
-- ----------------------------
DROP TABLE IF EXISTS `is_repurchaseinfo`;
CREATE TABLE `is_repurchaseinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '所属ID',
  `room` int(11) NOT NULL COMMENT '仓储ID',
  `goods` int(11) NOT NULL COMMENT '商品ID(搜索用)',
  `warehouse` int(11) NOT NULL COMMENT '仓库ID(搜索用)',
  `serial` text COMMENT '串号',
  `nums` decimal(10,2) NOT NULL COMMENT '数量',
  `price` decimal(10,2) NOT NULL COMMENT '单价',
  `total` decimal(10,2) NOT NULL COMMENT '总价',
  `data` varchar(128) DEFAULT '' COMMENT '备注',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `pid_room_goods_warehouse` (`pid`,`room`,`goods`,`warehouse`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='购货退货详情表';
-- ----------------------------
-- Records of is_repurchaseinfo
-- ----------------------------

-- ----------------------------
-- Table structure for is_resalebill
-- ----------------------------
DROP TABLE IF EXISTS `is_resalebill`;
CREATE TABLE `is_resalebill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '所属ID',
  `account` int(11) NOT NULL COMMENT '结算账户',
  `money` decimal(10,2) NOT NULL COMMENT '金额',
  `data` varchar(128) NOT NULL COMMENT '备注信息',
  `user` int(11) NOT NULL COMMENT '操作人',
  `time` varchar(128) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `pid_account_user` (`pid`,`account`,`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='销货退货核销单';
-- ----------------------------
-- Records of is_resalebill
-- ----------------------------

-- ----------------------------
-- Table structure for is_resaleclass
-- ----------------------------
DROP TABLE IF EXISTS `is_resaleclass`;
CREATE TABLE `is_resaleclass` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `merchant` int(11) NOT NULL COMMENT '所属商户',
  `customer` int(11) NOT NULL COMMENT '客户ID',
  `time` int(11) NOT NULL COMMENT '单据时间',
  `number` varchar(32) NOT NULL COMMENT '单据编号',
  `total` decimal(10,2) NOT NULL COMMENT '单据金额',
  `actual` decimal(10,2) NOT NULL COMMENT '实际金额',
  `money` decimal(10,2) NOT NULL COMMENT '实收金额',
  `user` int(11) NOT NULL COMMENT '制单人',
  `account` int(11) NOT NULL COMMENT '结算账户',
  `file` varchar(128) DEFAULT '' COMMENT '单据附件',
  `data` varchar(128) DEFAULT '' COMMENT '备注信息',
  `type` tinyint(1) NOT NULL COMMENT '审核状态[0:未审核|1:已审核]',
  `auditinguser` int(11) NOT NULL COMMENT '审核人',
  `auditingtime` int(11) NOT NULL COMMENT '审核时间',
  `billtype` tinyint(1) DEFAULT '-1' COMMENT '账单类型[-1:未处理|0:未核销|1:部分核销|2:已核销]',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `merchant_customer_user_account_type` (`merchant`,`customer`,`user`,`account`,`type`),
  KEY `time_number` (`time`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='销货退货单';
-- ----------------------------
-- Records of is_resaleclass
-- ----------------------------

-- ----------------------------
-- Table structure for is_resaleinfo
-- ----------------------------
DROP TABLE IF EXISTS `is_resaleinfo`;
CREATE TABLE `is_resaleinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '所属ID',
  `room` int(11) NOT NULL COMMENT '仓储ID',
  `goods` int(11) NOT NULL COMMENT '商品ID(搜索用)',
  `warehouse` int(11) NOT NULL COMMENT '仓库ID(搜索用)',
  `serial` text COMMENT '串号',
  `nums` decimal(10,2) NOT NULL COMMENT '数量',
  `price` decimal(10,2) NOT NULL COMMENT '单价',
  `total` decimal(10,2) NOT NULL COMMENT '总价',
  `data` varchar(128) DEFAULT '' COMMENT '备注',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `pid_room_goods_warehouse` (`pid`,`room`,`goods`,`warehouse`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='销货退货详情表';
-- ----------------------------
-- Records of is_resaleinfo
-- ----------------------------

-- ----------------------------
-- Table structure for is_room
-- ----------------------------
DROP TABLE IF EXISTS `is_room`;
CREATE TABLE `is_room` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `warehouse` int(11) NOT NULL COMMENT '仓库ID',
  `goods` int(11) NOT NULL COMMENT '商品ID',
  `attr` varchar(32) DEFAULT '' COMMENT '辅助属性',
  `batch` varchar(32) DEFAULT '' COMMENT '批次信息',
  `nums` decimal(10,2) NOT NULL COMMENT '库存数',
  PRIMARY KEY (`id`),
  KEY `warehouse_goods` (`warehouse`,`goods`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='仓储信息';
-- ----------------------------
-- Records of is_room
-- ----------------------------

-- ----------------------------
-- Table structure for is_roominfo
-- ----------------------------
DROP TABLE IF EXISTS `is_roominfo`;
CREATE TABLE `is_roominfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '所属ID',
  `type` int(11) NOT NULL COMMENT '单据类型[1:购货单|2:销货单|3:购货退货单|4:销货退货单|5:调拨单-出|6:调拨单-入|7:其他入库单|8:其他出库单|9:零售单|10:零售退货单|11:采购入库单|12:积分兑换单]',
  `class` int(11) NOT NULL COMMENT '类ID',
  `info` int(11) NOT NULL COMMENT '详情ID',
  `nums` decimal(10,2) NOT NULL COMMENT '数量',
  PRIMARY KEY (`id`),
  KEY `pid_type_class` (`pid`,`type`,`class`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='仓储详情';
-- ----------------------------
-- Records of is_roominfo
-- ----------------------------

-- ----------------------------
-- Table structure for is_root
-- ----------------------------
DROP TABLE IF EXISTS `is_root`;
CREATE TABLE `is_root` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '所属用户',
  `name` varchar(32) NOT NULL COMMENT '设置名称',
  `info` tinyint(1) NOT NULL COMMENT '设置内容',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=209 DEFAULT CHARSET=utf8 COMMENT='用户权限';
-- ----------------------------
-- Records of is_root
-- ----------------------------
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('105','2','purchase_add','1');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('106','2','purchase_del','1');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('107','2','purchase_edit','1');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('108','2','purchase_form','1');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('109','2','purchase_auditing','1');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('110','2','repurchase_add','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('111','2','repurchase_del','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('112','2','repurchase_edit','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('113','2','repurchase_form','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('114','2','repurchase_auditing','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('115','2','opurchase_add','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('116','2','opurchase_del','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('117','2','opurchase_edit','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('118','2','opurchase_form','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('119','2','opurchase_auditing','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('120','2','rpurchase_add','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('121','2','rpurchase_del','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('122','2','rpurchase_edit','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('123','2','rpurchase_form','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('124','2','rpurchase_auditing','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('125','2','sale_add','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('126','2','sale_del','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('127','2','sale_edit','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('128','2','sale_form','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('129','2','sale_auditing','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('130','2','resale_add','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('131','2','resale_del','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('132','2','resale_edit','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('133','2','resale_form','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('134','2','resale_auditing','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('135','2','cashier_add','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('136','2','cashier_del','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('137','2','cashier_edit','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('138','2','cashier_form','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('139','2','cashier_auditing','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('140','2','recashier_add','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('141','2','recashier_del','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('142','2','recashier_edit','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('143','2','recashier_form','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('144','2','recashier_auditing','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('145','2','itemorder_add','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('146','2','itemorder_del','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('147','2','itemorder_edit','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('148','2','itemorder_form','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('149','2','itemorder_auditing','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('150','2','exchange_add','1');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('151','2','exchange_del','1');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('152','2','exchange_edit','1');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('153','2','exchange_form','1');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('154','2','exchange_auditing','1');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('155','2','allocation_add','1');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('156','2','allocation_del','1');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('157','2','allocation_edit','1');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('158','2','allocation_form','1');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('159','2','allocation_auditing','1');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('160','2','otpurchase_add','1');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('161','2','otpurchase_del','1');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('162','2','otpurchase_edit','1');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('163','2','otpurchase_form','1');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('164','2','otpurchase_auditing','1');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('165','2','otsale_add','1');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('166','2','otsale_del','1');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('167','2','otsale_edit','1');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('168','2','otsale_form','1');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('169','2','otsale_auditing','1');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('170','2','gather_add','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('171','2','gather_del','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('172','2','gather_edit','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('173','2','gather_form','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('174','2','gather_auditing','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('175','2','payment_add','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('176','2','payment_del','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('177','2','payment_edit','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('178','2','payment_form','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('179','2','payment_auditing','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('180','2','otgather_add','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('181','2','otgather_del','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('182','2','otgather_edit','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('183','2','otgather_form','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('184','2','otgather_auditing','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('185','2','otpayment_add','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('186','2','otpayment_del','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('187','2','otpayment_edit','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('188','2','otpayment_form','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('189','2','otpayment_auditing','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('190','2','eft_add','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('191','2','eft_del','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('192','2','eft_edit','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('193','2','eft_form','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('194','2','eft_auditing','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('195','2','room_add','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('196','2','data_form','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('197','2','basics_add','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('198','2','basics_del','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('199','2','basics_edit','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('200','2','basics_form','0');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('201','2','auxiliary_add','1');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('202','2','auxiliary_del','1');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('203','2','auxiliary_edit','1');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('204','2','auxiliary_form','1');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('205','2','senior_add','1');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('206','2','senior_del','1');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('207','2','senior_edit','1');
INSERT INTO `is_root` (`id`,`pid`,`name`,`info`) VALUES ('208','2','senior_form','1');

-- ----------------------------
-- Table structure for is_rpurchasebill
-- ----------------------------
DROP TABLE IF EXISTS `is_rpurchasebill`;
CREATE TABLE `is_rpurchasebill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '所属ID',
  `account` int(11) NOT NULL COMMENT '结算账户',
  `money` decimal(10,2) NOT NULL COMMENT '金额',
  `data` varchar(128) NOT NULL COMMENT '备注信息',
  `user` int(11) NOT NULL COMMENT '操作人',
  `time` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `pid_account_user` (`pid`,`account`,`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采购入库核销单';
-- ----------------------------
-- Records of is_rpurchasebill
-- ----------------------------

-- ----------------------------
-- Table structure for is_rpurchaseclass
-- ----------------------------
DROP TABLE IF EXISTS `is_rpurchaseclass`;
CREATE TABLE `is_rpurchaseclass` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `oid` int(11) NOT NULL COMMENT '所属采购订单ID',
  `merchant` int(11) NOT NULL COMMENT '所属商户',
  `supplier` int(11) NOT NULL COMMENT '供应商ID',
  `time` int(11) NOT NULL COMMENT '单据时间',
  `number` varchar(32) NOT NULL COMMENT '单据编号',
  `total` decimal(10,2) NOT NULL COMMENT '单据金额',
  `actual` decimal(10,2) NOT NULL COMMENT '实际金额',
  `money` decimal(10,2) NOT NULL COMMENT '实付金额',
  `user` int(11) NOT NULL COMMENT '制单人',
  `account` int(11) NOT NULL COMMENT '结算账户',
  `file` varchar(128) DEFAULT '' COMMENT '单据附件',
  `data` varchar(128) DEFAULT '' COMMENT '备注信息',
  `type` tinyint(1) NOT NULL COMMENT '审核状态[0:未审核|1:已审核]',
  `auditinguser` int(11) NOT NULL COMMENT '审核人',
  `auditingtime` int(11) NOT NULL COMMENT '审核时间',
  `billtype` tinyint(1) DEFAULT '-1' COMMENT '账单类型[-1:未处理|0:未核销|1:部分核销|2:已核销]',
  `more` text COMMENT '扩展属性',
  PRIMARY KEY (`id`),
  KEY `oid_merchant_supplier_user_type` (`oid`,`merchant`,`supplier`,`user`,`type`),
  KEY `time_number` (`time`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采购入库单';
-- ----------------------------
-- Records of is_rpurchaseclass
-- ----------------------------

-- ----------------------------
-- Table structure for is_rpurchaseinfo
-- ----------------------------
DROP TABLE IF EXISTS `is_rpurchaseinfo`;
CREATE TABLE `is_rpurchaseinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `oid` int(11) NOT NULL COMMENT '所属采购订单详情表ID',
  `pid` int(11) NOT NULL COMMENT '所属ID',
  `goods` int(11) NOT NULL COMMENT '商品ID',
  `attr` varchar(32) DEFAULT '' COMMENT '辅助属性',
  `warehouse` int(11) NOT NULL COMMENT '仓库ID',
  `batch` varchar(32) DEFAULT '' COMMENT '批次',
  `serial` text COMMENT '串码',
  `nums` decimal(10,2) NOT NULL COMMENT '数量',
  `price` decimal(10,2) NOT NULL COMMENT '单价',
  `total` decimal(10,2) NOT NULL COMMENT '总价',
  `data` varchar(128) DEFAULT '' COMMENT '备注',
  `room` int(128) NOT NULL COMMENT '仓储ID',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `oid_pid_goods_warehouse_room` (`oid`,`pid`,`goods`,`warehouse`,`room`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采购入库详情表';
-- ----------------------------
-- Records of is_rpurchaseinfo
-- ----------------------------

-- ----------------------------
-- Table structure for is_salebill
-- ----------------------------
DROP TABLE IF EXISTS `is_salebill`;
CREATE TABLE `is_salebill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '所属ID',
  `account` int(11) NOT NULL COMMENT '结算账户',
  `money` decimal(10,2) NOT NULL COMMENT '金额',
  `data` varchar(128) NOT NULL COMMENT '备注信息',
  `user` int(11) NOT NULL COMMENT '操作人',
  `time` varchar(128) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `pid_account_user` (`pid`,`account`,`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='销货核销单';
-- ----------------------------
-- Records of is_salebill
-- ----------------------------

-- ----------------------------
-- Table structure for is_saleclass
-- ----------------------------
DROP TABLE IF EXISTS `is_saleclass`;
CREATE TABLE `is_saleclass` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `merchant` int(11) NOT NULL COMMENT '所属商户',
  `customer` int(11) NOT NULL COMMENT '客户ID',
  `time` int(11) NOT NULL COMMENT '单据时间',
  `number` varchar(32) NOT NULL COMMENT '单据编号',
  `total` decimal(10,2) NOT NULL COMMENT '单据金额',
  `actual` decimal(10,2) NOT NULL COMMENT '实际金额',
  `money` decimal(10,2) NOT NULL COMMENT '实收金额',
  `user` int(11) NOT NULL COMMENT '制单人',
  `account` int(11) NOT NULL COMMENT '结算账户',
  `file` varchar(128) DEFAULT '' COMMENT '单据附件',
  `data` varchar(128) DEFAULT '' COMMENT '备注信息',
  `type` tinyint(1) NOT NULL COMMENT '审核状态[0:未审核|1:已审核]',
  `auditinguser` int(11) NOT NULL COMMENT '审核人',
  `auditingtime` int(11) NOT NULL COMMENT '审核时间',
  `billtype` tinyint(1) DEFAULT '-1' COMMENT '账单类型[-1:未处理|0:未核销|1:部分核销|2:已核销]',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `merchant_customer_user_type` (`merchant`,`customer`,`user`,`type`),
  KEY `time_number` (`time`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='销货单';
-- ----------------------------
-- Records of is_saleclass
-- ----------------------------

-- ----------------------------
-- Table structure for is_saleinfo
-- ----------------------------
DROP TABLE IF EXISTS `is_saleinfo`;
CREATE TABLE `is_saleinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '所属ID',
  `room` int(11) NOT NULL COMMENT '仓储ID',
  `goods` int(11) NOT NULL COMMENT '商品ID(搜索用)',
  `warehouse` int(11) NOT NULL COMMENT '仓库ID(搜索用)',
  `serial` text COMMENT '串号',
  `nums` decimal(10,2) NOT NULL COMMENT '数量',
  `price` decimal(10,2) NOT NULL COMMENT '单价',
  `discount` decimal(10,2) NOT NULL COMMENT '折扣',
  `total` decimal(10,2) NOT NULL COMMENT '总价',
  `data` varchar(128) DEFAULT '' COMMENT '备注',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `pid_room_goods_warehouse` (`pid`,`room`,`goods`,`warehouse`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='销货详情表';
-- ----------------------------
-- Records of is_saleinfo
-- ----------------------------

-- ----------------------------
-- Table structure for is_serial
-- ----------------------------
DROP TABLE IF EXISTS `is_serial`;
CREATE TABLE `is_serial` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(64) NOT NULL COMMENT '串码内容',
  `goods` int(11) NOT NULL COMMENT '商品ID',
  `room` int(11) NOT NULL COMMENT '仓储ID',
  `type` tinyint(1) NOT NULL COMMENT '串码状态[0:未销售|1:已销售|2:不在库]',
  PRIMARY KEY (`id`),
  KEY `code_goods_room_type` (`code`,`goods`,`room`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='串码表';
-- ----------------------------
-- Records of is_serial
-- ----------------------------

-- ----------------------------
-- Table structure for is_serialinfo
-- ----------------------------
DROP TABLE IF EXISTS `is_serialinfo`;
CREATE TABLE `is_serialinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '所属ID',
  `type` int(11) NOT NULL COMMENT '单据类型[1:购货单|2:销货单|3:购货退货单|4:销货退货单|5:调拨单|6:其他入库单|7:其他出库单|8:零售单|9:零售退货单|10:采购入库单|11:积分兑换单]',
  `class` int(11) NOT NULL COMMENT '类ID',
  `oldroom` int(11) DEFAULT '0' COMMENT '源仓储ID',
  PRIMARY KEY (`id`),
  KEY `pid_type_class` (`pid`,`type`,`class`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='串码详情';
-- ----------------------------
-- Records of is_serialinfo
-- ----------------------------

-- ----------------------------
-- Table structure for is_serve
-- ----------------------------
DROP TABLE IF EXISTS `is_serve`;
CREATE TABLE `is_serve` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL COMMENT '服务名称',
  `py` varchar(32) DEFAULT '' COMMENT '拼音信息',
  `number` varchar(32) NOT NULL COMMENT '服务编号',
  `price` decimal(10,2) DEFAULT '0.00' COMMENT '服务价格',
  `data` varchar(128) DEFAULT '' COMMENT '备注信息',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `name_py_number` (`name`,`py`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='服务详情表';
-- ----------------------------
-- Records of is_serve
-- ----------------------------

-- ----------------------------
-- Table structure for is_summary
-- ----------------------------
DROP TABLE IF EXISTS `is_summary`;
CREATE TABLE `is_summary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `merchant` int(11) NOT NULL COMMENT '所属商户',
  `type` int(11) NOT NULL COMMENT '单据类型[1:购货单|2:采购入库单|3:购货退货单|4:销货单|5:销货退货单|6:零售单|7:零售退货单|8:积分兑换单|9:调拨单|10:其他入库单|11:其他出库单]',
  `class` int(11) NOT NULL COMMENT '类ID',
  `info` int(11) NOT NULL COMMENT '详情ID',
  `supplier` int(11) NOT NULL COMMENT '供应商ID',
  `customer` int(11) NOT NULL COMMENT '客户ID',
  `time` int(11) NOT NULL COMMENT '单据时间',
  `number` varchar(32) NOT NULL COMMENT '单据编号',
  `user` int(11) NOT NULL COMMENT '制单人',
  `account` int(11) NOT NULL COMMENT '结算账户',
  `goods` int(11) NOT NULL COMMENT '商品ID',
  `warehouse` int(11) NOT NULL COMMENT '所属仓库',
  `room` int(11) NOT NULL COMMENT '关联仓储',
  `attr` varchar(32) DEFAULT '' COMMENT '辅助属性',
  `serial` text COMMENT '串码信息',
  `batch` varchar(32) DEFAULT '' COMMENT '批次信息',
  `nums` decimal(10,2) NOT NULL COMMENT '商品数量',
  `price` decimal(10,2) NOT NULL COMMENT '商品单价',
  `total` decimal(10,2) NOT NULL COMMENT '商品总价',
  `data` varchar(256) DEFAULT '' COMMENT '单据备注',
  PRIMARY KEY (`id`),
  KEY `merchant_type_class_supplier_customer_goods` (`merchant`,`type`,`class`,`supplier`,`customer`,`goods`),
  KEY `type_class_supplier_customer_goods` (`type`,`class`,`supplier`,`customer`,`goods`),
  KEY `supplier` (`supplier`),
  KEY `customer` (`customer`),
  KEY `goods` (`goods`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='统计数据表';
-- ----------------------------
-- Records of is_summary
-- ----------------------------

-- ----------------------------
-- Table structure for is_supplier
-- ----------------------------
DROP TABLE IF EXISTS `is_supplier`;
CREATE TABLE `is_supplier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL COMMENT '名称',
  `py` varchar(32) NOT NULL COMMENT '首拼信息',
  `number` varchar(32) DEFAULT '' COMMENT '编号',
  `contacts` varchar(32) DEFAULT '' COMMENT '联系人',
  `tel` varchar(32) DEFAULT '' COMMENT '联系电话',
  `add` varchar(64) DEFAULT '' COMMENT '地址',
  `bank` varchar(64) DEFAULT '' COMMENT '开户行',
  `account` varchar(64) DEFAULT '' COMMENT '银行账号',
  `tax` varchar(64) DEFAULT '' COMMENT '税号',
  `other` varchar(64) DEFAULT '' COMMENT '社交账号',
  `email` varchar(64) DEFAULT '' COMMENT '邮箱',
  `data` varchar(128) DEFAULT '' COMMENT '备注信息',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `name_py_number` (`name`,`py`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商表';
-- ----------------------------
-- Records of is_supplier
-- ----------------------------

-- ----------------------------
-- Table structure for is_sys
-- ----------------------------
DROP TABLE IF EXISTS `is_sys`;
CREATE TABLE `is_sys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL COMMENT '配置名称',
  `info` text COMMENT '配置内容',
  `data` varchar(128) DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`id`),
  KEY `name_info` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='系统设置表';
-- ----------------------------
-- Records of is_sys
-- ----------------------------
INSERT INTO `is_sys` (`id`,`name`,`info`,`data`) VALUES ('1','sys_name','点可云ERP','系统名称');
INSERT INTO `is_sys` (`id`,`name`,`info`,`data`) VALUES ('2','company_name','山西华科智软信息技术有限公司','公司名称');
INSERT INTO `is_sys` (`id`,`name`,`info`,`data`) VALUES ('3','company_tel','17701030513','公司电话');
INSERT INTO `is_sys` (`id`,`name`,`info`,`data`) VALUES ('4','company_add','太原市','公司地址');
INSERT INTO `is_sys` (`id`,`name`,`info`,`data`) VALUES ('5','room_threshold','20','库存默认阀值');
INSERT INTO `is_sys` (`id`,`name`,`info`,`data`) VALUES ('6','print_paper','0','默认打印纸张[0:A4|1:241-2]');
INSERT INTO `is_sys` (`id`,`name`,`info`,`data`) VALUES ('7','user_opt','1','制单人可选[0:否|1:是]');
INSERT INTO `is_sys` (`id`,`name`,`info`,`data`) VALUES ('8','auto_auditing','1','单据自动审核[0:否|1:是]');
INSERT INTO `is_sys` (`id`,`name`,`info`,`data`) VALUES ('9','enable_batch','0','启用批次功能[0:否|1:是]');
INSERT INTO `is_sys` (`id`,`name`,`info`,`data`) VALUES ('10','enable_serial','0','启用串码功能[0:否|1:是]');
INSERT INTO `is_sys` (`id`,`name`,`info`,`data`) VALUES ('11','cashier_title','点可云 - 收银台','零售标题');
INSERT INTO `is_sys` (`id`,`name`,`info`,`data`) VALUES ('12','cashier_customer','','默认客户');
INSERT INTO `is_sys` (`id`,`name`,`info`,`data`) VALUES ('13','cashier_account','','默认资金账户');
INSERT INTO `is_sys` (`id`,`name`,`info`,`data`) VALUES ('14','cashier_print','0','自动打印小票[0:否|1:是]');
INSERT INTO `is_sys` (`id`,`name`,`info`,`data`) VALUES ('15','form_day','7','图表天数');
INSERT INTO `is_sys` (`id`,`name`,`info`,`data`) VALUES ('16','notice','欢迎使用点可云进销存系统
官网地址：www.nodcloud.com
反馈邮箱：ceo@apeinfo.com','公告信息');
INSERT INTO `is_sys` (`id`,`name`,`info`,`data`) VALUES ('17','integral_proportion','100','积分比例');

-- ----------------------------
-- Table structure for is_tmpmodel
-- ----------------------------
DROP TABLE IF EXISTS `is_tmpmodel`;
CREATE TABLE `is_tmpmodel` (
  `id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `number` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='多态关联兼容表';
-- ----------------------------
-- Records of is_tmpmodel
-- ----------------------------
INSERT INTO `is_tmpmodel` (`id`,`name`,`number`) VALUES ('0','无','无');
INSERT INTO `is_tmpmodel` (`id`,`name`,`number`) VALUES ('1','无','无');

-- ----------------------------
-- Table structure for is_unit
-- ----------------------------
DROP TABLE IF EXISTS `is_unit`;
CREATE TABLE `is_unit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL COMMENT '单位名称',
  `py` varchar(32) DEFAULT '' COMMENT '拼音信息',
  `number` varchar(32) DEFAULT '' COMMENT '单位编号',
  `data` varchar(128) DEFAULT '' COMMENT '备注信息',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `name_py_number` (`name`,`py`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='计量单位';
-- ----------------------------
-- Records of is_unit
-- ----------------------------

-- ----------------------------
-- Table structure for is_user
-- ----------------------------
DROP TABLE IF EXISTS `is_user`;
CREATE TABLE `is_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(36) NOT NULL COMMENT '用户账号',
  `pwd` varchar(32) NOT NULL COMMENT '用户密码',
  `merchant` int(11) NOT NULL COMMENT '所属商户',
  `name` varchar(36) NOT NULL COMMENT '用户名称',
  `py` varchar(36) NOT NULL COMMENT '首拼信息',
  `img` varchar(64) DEFAULT '' COMMENT '用户头像',
  `data` varchar(128) DEFAULT '' COMMENT '备注信息',
  `token` varchar(30) DEFAULT '' COMMENT '登录秘钥',
  `type` int(11) DEFAULT '0' COMMENT '用户类型[0:普通用户|1:管理员|2:API]',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `user_pwd_merchant` (`user`,`pwd`,`merchant`),
  KEY `name_py` (`name`,`py`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用户信息表';
-- ----------------------------
-- Records of is_user
-- ----------------------------
INSERT INTO `is_user` (`id`,`user`,`pwd`,`merchant`,`name`,`py`,`img`,`data`,`token`,`type`,`more`) VALUES ('1','admin','7fef6171469e80d32c0559f88b377245','1','管理员','gly','','','e7pxK7UAhV8mwjZ7aQjl5tmhQdSZoh','1','');
INSERT INTO `is_user` (`id`,`user`,`pwd`,`merchant`,`name`,`py`,`img`,`data`,`token`,`type`,`more`) VALUES ('2','liupeng','e10adc3949ba59abbe56e057f20f883e','1','liupeng','liupeng','','','','0','');

-- ----------------------------
-- Table structure for is_warehouse
-- ----------------------------
DROP TABLE IF EXISTS `is_warehouse`;
CREATE TABLE `is_warehouse` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL COMMENT '仓库名称',
  `py` varchar(32) NOT NULL COMMENT '首拼信息',
  `number` varchar(32) DEFAULT '' COMMENT '仓库编号',
  `contacts` varchar(32) DEFAULT '' COMMENT '联系人员',
  `tel` varchar(32) DEFAULT '' COMMENT '联系电话',
  `add` varchar(64) DEFAULT '' COMMENT '仓库地址',
  `data` varchar(128) DEFAULT '' COMMENT '备注信息',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `name_py_number` (`name`,`py`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='仓库信息表';
-- ----------------------------
-- Records of is_warehouse
-- ----------------------------

