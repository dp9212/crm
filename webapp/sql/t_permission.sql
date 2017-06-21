/*
Navicat MySQL Data Transfer

Source Server         : demo
Source Server Version : 50540
Source Host           : localhost:3306
Source Database       : crm

Target Server Type    : MYSQL
Target Server Version : 50540
File Encoding         : 65001

Date: 2016-12-25 16:47:13
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_permission`
-- ----------------------------
DROP TABLE IF EXISTS `t_permission`;
CREATE TABLE `t_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `resource` varchar(100) NOT NULL,
  `state` tinyint(4) NOT NULL DEFAULT '0',
  `menu_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_permission
-- ----------------------------
INSERT INTO `t_permission` VALUES ('1', '字典管理', 'cn.yysg.crm.web.controller.SystemDictionaryController.ALL', '0', '2');
INSERT INTO `t_permission` VALUES ('2', '部门管理', 'cn.yysg.crm.web.controller.DepartmentController.ALL', '0', '1');
INSERT INTO `t_permission` VALUES ('3', '员工管理', 'cn.yysg.crm.web.controller.EmployeeController.ALL', '0', '1');
INSERT INTO `t_permission` VALUES ('4', '角色管理', 'cn.yysg.crm.web.controller.RoleController.ALL', '0', '2');
INSERT INTO `t_permission` VALUES ('5', '订单管理', 'cn.yysg.crm.web.comtroller.OrderController.ALL', '0', '3');
INSERT INTO `t_permission` VALUES ('6', '保修订单', 'cn.yysg.crm.web.comtroller.GuaranteeItemController.ALL', '0', '3');
INSERT INTO `t_permission` VALUES ('7', '权限管理', 'cn.yysg.crm.web.controller.PermissionController.ALL', '0', '2');
INSERT INTO `t_permission` VALUES ('8', '菜单管理', 'cn.yysg.crm.web.comtroller.MenuController.ALL', '0', '2');
INSERT INTO `t_permission` VALUES ('9', '合同付款明细', 'cn.yysg.crm.web.comtroller.ContractitemController.ALL', '0', '3');
INSERT INTO `t_permission` VALUES ('10', '合同管理', 'cn.yysg.crm.web.comtroller.ContractController.ALL', '0', '3');
INSERT INTO `t_permission` VALUES ('11', '移交记录', 'cn.yysg.crm.web.comtroller.CustomerTransferController.ALL', '0', '4');
INSERT INTO `t_permission` VALUES ('12', '跟进历史', 'cn.yysg.crm.web.comtroller.CustomerTraceHistoryController.ALL', '0', '4');
INSERT INTO `t_permission` VALUES ('13', '客户信息', 'cn.yysg.crm.web.comtroller.CustomerController.ALL', '0', '4');
INSERT INTO `t_permission` VALUES ('14', '系统日志管理', 'cn.yysg.crm.web.controller.SystemLogController.ALL', '0', '2');
INSERT INTO `t_permission` VALUES ('15', '潜在客户', 'cn.yysg.crm.web.controller.PotentialCustomerController.ALL', '0', '1');
INSERT INTO `t_permission` VALUES ('16', '保修单', 'cn.yysg.crm.web.comtroller.GuaranteeController.ALL', '0', '3');
