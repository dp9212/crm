/*
Navicat MySQL Data Transfer

Source Server         : dp9212
Source Server Version : 50525
Source Host           : localhost:3306
Source Database       : crm

Target Server Type    : MYSQL
Target Server Version : 50525
File Encoding         : 65001

Date: 2016-12-25 15:51:26
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_systemlog`
-- ----------------------------
DROP TABLE IF EXISTS `t_systemlog`;
CREATE TABLE `t_systemlog` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `opUser_id` bigint(200) DEFAULT NULL,
  `opTime` datetime NOT NULL,
  `opIp` varchar(255) DEFAULT NULL,
  `function` varchar(255) DEFAULT NULL COMMENT '方法',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_systemlog
-- ----------------------------
INSERT INTO `t_systemlog` VALUES ('47', '1', '2016-12-25 14:59:56', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.DepartmentServiceImpl:getTreeData');
INSERT INTO `t_systemlog` VALUES ('48', '1', '2016-12-25 14:59:56', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.DepartmentServiceImpl:getTreeData');
INSERT INTO `t_systemlog` VALUES ('49', '1', '2016-12-25 14:59:56', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.EmployeeServiceImpl:getPageList');
INSERT INTO `t_systemlog` VALUES ('50', '1', '2016-12-25 14:59:56', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.EmployeeServiceImpl:getPageList');
INSERT INTO `t_systemlog` VALUES ('51', '1', '2016-12-25 14:59:56', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.DepartmentServiceImpl:getPageList');
INSERT INTO `t_systemlog` VALUES ('52', '1', '2016-12-25 14:59:57', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.PermissionServiceImpl:getPageList');
INSERT INTO `t_systemlog` VALUES ('53', '1', '2016-12-25 15:00:00', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.GuaranteeItemServiceImpl:getPageList');
INSERT INTO `t_systemlog` VALUES ('54', '1', '2016-12-25 15:04:38', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.CustomerTraceHistoryServiceImpl:queryItemsById');
INSERT INTO `t_systemlog` VALUES ('55', '1', '2016-12-25 15:04:38', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.CustomerServiceImpl:queryItemsById');
INSERT INTO `t_systemlog` VALUES ('56', '1', '2016-12-25 15:04:38', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.CustomerServiceImpl:queryItemsById');
INSERT INTO `t_systemlog` VALUES ('57', '1', '2016-12-25 15:04:38', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.EmployeeServiceImpl:getPageList');
INSERT INTO `t_systemlog` VALUES ('58', '1', '2016-12-25 15:04:38', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.EmployeeServiceImpl:getPageList');
INSERT INTO `t_systemlog` VALUES ('59', '1', '2016-12-25 15:04:38', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.EmployeeServiceImpl:getPageList');
INSERT INTO `t_systemlog` VALUES ('60', '1', '2016-12-25 15:04:38', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.EmployeeServiceImpl:getPageList');
INSERT INTO `t_systemlog` VALUES ('61', '1', '2016-12-25 15:04:38', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.EmployeeServiceImpl:getPageList');
INSERT INTO `t_systemlog` VALUES ('62', '1', '2016-12-25 15:04:38', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.CustomerServiceImpl:queryItemsById');
INSERT INTO `t_systemlog` VALUES ('63', '1', '2016-12-25 15:04:38', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.CustomerServiceImpl:getTotal');
INSERT INTO `t_systemlog` VALUES ('64', '1', '2016-12-25 15:04:38', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.CustomerServiceImpl:getRows');
INSERT INTO `t_systemlog` VALUES ('65', '1', '2016-12-25 15:04:45', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.CustomerServiceImpl:getAll');
INSERT INTO `t_systemlog` VALUES ('66', '1', '2016-12-25 15:04:45', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.CustomerTraceHistoryServiceImpl:queryItemsById');
INSERT INTO `t_systemlog` VALUES ('67', '1', '2016-12-25 15:04:45', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.CustomerServiceImpl:getAll');
INSERT INTO `t_systemlog` VALUES ('68', '1', '2016-12-25 15:04:45', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.EmployeeServiceImpl:getPageList');
INSERT INTO `t_systemlog` VALUES ('69', '1', '2016-12-25 15:04:45', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.EmployeeServiceImpl:getPageList');
INSERT INTO `t_systemlog` VALUES ('70', '1', '2016-12-25 15:04:45', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.EmployeeServiceImpl:getPageList');
INSERT INTO `t_systemlog` VALUES ('71', '1', '2016-12-25 15:04:45', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.CustomerTraceHistoryServiceImpl:getTotal');
INSERT INTO `t_systemlog` VALUES ('72', '1', '2016-12-25 15:04:45', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.CustomerTraceHistoryServiceImpl:getRows');
INSERT INTO `t_systemlog` VALUES ('73', '1', '2016-12-25 15:04:46', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.CustomerServiceImpl:getAll');
INSERT INTO `t_systemlog` VALUES ('74', '1', '2016-12-25 15:04:46', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.CustomerServiceImpl:getAll');
INSERT INTO `t_systemlog` VALUES ('75', '1', '2016-12-25 15:04:46', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.CustomerTransferServiceImpl:getTotal');
INSERT INTO `t_systemlog` VALUES ('76', '1', '2016-12-25 15:04:46', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.EmployeeServiceImpl:getPageList');
INSERT INTO `t_systemlog` VALUES ('77', '1', '2016-12-25 15:10:13', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.RoleServiceImpl:getPageList');
INSERT INTO `t_systemlog` VALUES ('78', '1', '2016-12-25 15:10:13', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.PermissionServiceImpl:getPageList');
INSERT INTO `t_systemlog` VALUES ('79', null, '2016-12-25 15:49:22', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.EmployeeServiceImpl:login');
INSERT INTO `t_systemlog` VALUES ('80', '1', '2016-12-25 15:49:23', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.MenuServiceImpl:getUserMenu');
INSERT INTO `t_systemlog` VALUES ('81', '1', '2016-12-25 15:49:53', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.DepartmentServiceImpl:getDept');
INSERT INTO `t_systemlog` VALUES ('82', '1', '2016-12-25 15:49:53', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.DepartmentServiceImpl:getDept');
INSERT INTO `t_systemlog` VALUES ('83', '1', '2016-12-25 15:49:54', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.EmployeeServiceImpl:getPageList');
INSERT INTO `t_systemlog` VALUES ('84', '1', '2016-12-25 15:50:01', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.MenuServiceImpl:getUserMenu');
INSERT INTO `t_systemlog` VALUES ('85', '1', '2016-12-25 15:50:15', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.DepartmentServiceImpl:getDept');
INSERT INTO `t_systemlog` VALUES ('86', '1', '2016-12-25 15:50:15', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.DepartmentServiceImpl:getDept');
INSERT INTO `t_systemlog` VALUES ('87', '1', '2016-12-25 15:50:15', '0:0:0:0:0:0:0:1', 'cn.yysg.crm.service.impl.EmployeeServiceImpl:getPageList');
