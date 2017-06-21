/*
Navicat MySQL Data Transfer

Source Server         : demo
Source Server Version : 50540
Source Host           : localhost:3306
Source Database       : crm

Target Server Type    : MYSQL
Target Server Version : 50540
File Encoding         : 65001

Date: 2016-12-25 16:47:32
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_system_dictionary`
-- ----------------------------
DROP TABLE IF EXISTS `t_system_dictionary`;
CREATE TABLE `t_system_dictionary` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sn` varchar(20) DEFAULT NULL,
  `name` varchar(50) NOT NULL DEFAULT '',
  `intro` varchar(200) DEFAULT NULL,
  `state` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_system_dictionary
-- ----------------------------
INSERT INTO `t_system_dictionary` VALUES ('1', '001', '职业', null, '1');
INSERT INTO `t_system_dictionary` VALUES ('2', '002', '客户来源', null, '1');
INSERT INTO `t_system_dictionary` VALUES ('3', '003', '用户', '', '1');
INSERT INTO `t_system_dictionary` VALUES ('4', '4', '客服', '', '1');
