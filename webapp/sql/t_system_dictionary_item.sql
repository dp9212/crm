/*
Navicat MySQL Data Transfer

Source Server         : demo
Source Server Version : 50540
Source Host           : localhost:3306
Source Database       : crm

Target Server Type    : MYSQL
Target Server Version : 50540
File Encoding         : 65001

Date: 2016-12-25 16:47:40
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_system_dictionary_item`
-- ----------------------------
DROP TABLE IF EXISTS `t_system_dictionary_item`;
CREATE TABLE `t_system_dictionary_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `sequence` int(11) DEFAULT '100',
  `intro` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_system_dictionary_item
-- ----------------------------
INSERT INTO `t_system_dictionary_item` VALUES ('1', '1', '产品经理', '100', null);
INSERT INTO `t_system_dictionary_item` VALUES ('2', '1', '测试工程师', '100', null);
INSERT INTO `t_system_dictionary_item` VALUES ('3', '2', '电话营销', '100', null);
INSERT INTO `t_system_dictionary_item` VALUES ('4', '2', '朋友介绍', '100', null);
INSERT INTO `t_system_dictionary_item` VALUES ('5', '2', '移动广告', '100', null);
INSERT INTO `t_system_dictionary_item` VALUES ('6', '3', '小马', null, '');
INSERT INTO `t_system_dictionary_item` VALUES ('7', '4', '小李', '1', '');
