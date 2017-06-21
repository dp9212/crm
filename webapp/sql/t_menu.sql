/*
Navicat MySQL Data Transfer

Source Server         : demo
Source Server Version : 50540
Source Host           : localhost:3306
Source Database       : crm

Target Server Type    : MYSQL
Target Server Version : 50540
File Encoding         : 65001

Date: 2016-12-25 16:47:04
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_menu`
-- ----------------------------
DROP TABLE IF EXISTS `t_menu`;
CREATE TABLE `t_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sn` varchar(20) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `intro` varchar(100) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  CONSTRAINT `t_menu_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `t_menu` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_menu
-- ----------------------------
INSERT INTO `t_menu` VALUES ('1', null, '组织机构', null, null, null, null);
INSERT INTO `t_menu` VALUES ('2', null, '系统管理', null, null, null, null);
INSERT INTO `t_menu` VALUES ('3', null, '部门管理', 'icon-ok', null, '1', '/department/list');
INSERT INTO `t_menu` VALUES ('4', null, '员工管理', 'icon-cut', null, '1', '/employee/list');
INSERT INTO `t_menu` VALUES ('5', null, '字典管理', 'icon-save', null, '2', '/systemDictionary/list');
INSERT INTO `t_menu` VALUES ('6', null, '角色管理', 'icon-edit', null, '2', '/role/list');
INSERT INTO `t_menu` VALUES ('7', null, '权限管理', 'icon-remove', null, '2', '/permission/list');
INSERT INTO `t_menu` VALUES ('8', null, '菜单管理', 'icon-add', null, '2', '/menu/list');
INSERT INTO `t_menu` VALUES ('9', null, '潜在客户', null, null, '1', '/potentialCustomer/list');
INSERT INTO `t_menu` VALUES ('10', null, '订单合同管理', null, null, null, null);
INSERT INTO `t_menu` VALUES ('11', null, '保修单', null, null, '10', '/guarantee/list');
INSERT INTO `t_menu` VALUES ('12', null, '保修订单', null, null, '10', '/guaranteeItem/list');
INSERT INTO `t_menu` VALUES ('13', null, '订单管理', null, null, '10', '/order/list');
INSERT INTO `t_menu` VALUES ('14', null, '合同管理', null, null, '10', '/contract/list');
INSERT INTO `t_menu` VALUES ('15', null, '合同付款明细', null, null, '10', '/contractitem/list');
INSERT INTO `t_menu` VALUES ('16', null, '客户管理', null, null, null, null);
INSERT INTO `t_menu` VALUES ('17', null, '客户信息', null, null, '16', '/customer/list');
INSERT INTO `t_menu` VALUES ('18', null, '跟进历史', null, null, '16', '/customerTraceHistory/list');
INSERT INTO `t_menu` VALUES ('19', null, '移交记录', null, null, '16', '/customerTransfer/list');
INSERT INTO `t_menu` VALUES ('20', '20', '系统日志', null, null, '1', '/systemLog/list');
