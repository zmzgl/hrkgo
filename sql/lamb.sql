/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80012
 Source Host           : localhost:3306
 Source Schema         : lamb

 Target Server Type    : MySQL
 Target Server Version : 80012
 File Encoding         : 65001

 Date: 11/02/2025 15:31:29
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint(20) NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int(5) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '参数配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2024-03-21 13:19:00', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2024-03-21 13:19:00', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2024-03-21 13:19:00', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2024-03-21 13:19:00', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2024-03-21 13:19:00', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2024-03-21 13:19:00', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int(4) NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 127 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '溯光科技', 0, '北城南笙', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2024-03-21 13:19:00', 'admin', '2024-04-01 18:16:52');
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '深圳总公司', 1, '北城南笙', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2024-03-21 13:19:00', 'admin', '2024-04-01 18:17:02');
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2024-03-21 13:19:00', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '北城南笙', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2024-03-21 13:19:00', 'admin', '2024-04-01 18:17:06');
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2024-03-21 13:19:00', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '北城南笙', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2024-03-21 13:19:00', 'admin', '2024-04-01 18:17:09');
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2024-03-21 13:19:00', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2024-03-21 13:19:00', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2024-03-21 13:19:00', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2024-03-21 13:19:00', '', NULL);
INSERT INTO `sys_dept` VALUES (110, 101, '0,100,101', '1', 0, NULL, NULL, NULL, '0', '0', 'admin', '2024-04-14 15:31:46', '', NULL);
INSERT INTO `sys_dept` VALUES (111, 101, '0,100,101', '12', 0, NULL, NULL, NULL, '0', '0', 'admin', '2024-04-14 15:31:53', '', NULL);
INSERT INTO `sys_dept` VALUES (112, 101, '0,100,101', '122', 0, NULL, NULL, NULL, '0', '0', 'admin', '2024-04-14 15:32:00', '', NULL);
INSERT INTO `sys_dept` VALUES (113, 101, '0,100,101', '213', 0, NULL, NULL, NULL, '0', '0', 'admin', '2024-04-14 15:32:03', '', NULL);
INSERT INTO `sys_dept` VALUES (114, 101, '0,100,101', '123', 0, NULL, NULL, NULL, '0', '0', 'admin', '2024-04-14 15:32:06', '', NULL);
INSERT INTO `sys_dept` VALUES (115, 101, '0,100,101', '12312', 0, NULL, NULL, NULL, '0', '0', 'admin', '2024-04-14 15:32:10', '', NULL);
INSERT INTO `sys_dept` VALUES (116, 101, '0,100,101', '1234455', 0, NULL, NULL, NULL, '0', '0', 'admin', '2024-04-14 15:32:16', '', NULL);
INSERT INTO `sys_dept` VALUES (117, 116, '0,100,101,116', '123213', 0, NULL, NULL, NULL, '0', '0', 'admin', '2024-04-14 15:32:19', '', NULL);
INSERT INTO `sys_dept` VALUES (118, 101, '0,100,101', '12313', 0, NULL, NULL, NULL, '0', '0', 'admin', '2024-04-14 15:32:22', '', NULL);
INSERT INTO `sys_dept` VALUES (119, 118, '0,100,101,118', '123213', 0, NULL, NULL, NULL, '0', '0', 'admin', '2024-04-14 15:32:25', '', NULL);
INSERT INTO `sys_dept` VALUES (120, 110, '0,100,101,110', '12312321', 0, NULL, NULL, NULL, '0', '0', 'admin', '2024-04-14 15:32:28', '', NULL);
INSERT INTO `sys_dept` VALUES (121, 101, '0,100,101', 'asdasd', 0, NULL, NULL, NULL, '0', '0', 'admin', '2024-04-14 15:41:45', '', NULL);
INSERT INTO `sys_dept` VALUES (122, 101, '0,100,101', 'asdasdasd', 0, NULL, NULL, NULL, '0', '0', 'admin', '2024-04-14 15:41:49', '', NULL);
INSERT INTO `sys_dept` VALUES (123, 122, '0,100,101,122', 'asdasdasd', 0, NULL, NULL, NULL, '0', '0', 'admin', '2024-04-14 15:41:55', '', NULL);
INSERT INTO `sys_dept` VALUES (124, 120, '0,100,101,110,120', 'asdasd', 0, NULL, NULL, NULL, '0', '0', 'admin', '2024-04-14 15:42:11', '', NULL);
INSERT INTO `sys_dept` VALUES (125, 117, '0,100,101,116,117', 'asdasd', 0, NULL, NULL, NULL, '0', '0', 'admin', '2024-04-14 15:42:14', '', NULL);
INSERT INTO `sys_dept` VALUES (126, 125, '0,100,101,116,117,125', 'asdsadsad', 0, NULL, NULL, NULL, '0', '0', 'admin', '2024-04-14 15:42:16', '', NULL);
INSERT INTO `sys_dept` VALUES (127, 117, '0,100,101,116,117', 'asdad', 0, NULL, NULL, NULL, '0', '0', 'admin', '2024-04-14 15:42:18', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字典编码',
  `dict_sort` int(4) NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES ('1', 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES ('10', 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES ('11', 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES ('12', 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES ('13', 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES ('14', 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES ('15', 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES ('16', 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES ('17', 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES ('18', 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES ('19', 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES ('2', 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES ('20', 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES ('21', 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES ('22', 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES ('23', 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES ('24', 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES ('25', 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES ('26', 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES ('27', 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES ('28', 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2024-03-21 13:19:00', '1', '2025-01-14 09:20:51', '正常状态');
INSERT INTO `sys_dict_data` VALUES ('29', 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES ('3', 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES ('4', 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES ('5', 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES ('6', 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES ('7', 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES ('8', 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES ('9', 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES ('1', '用户性别', 'sys_user_sex', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES ('10', '系统状态', 'sys_common_status', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES ('2', '菜单状态', 'sys_show_hide', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES ('3', '系统开关', 'sys_normal_disable', '0', 'admin', '2024-03-21 13:19:00', '1', '2025-01-14 09:12:05', '系统开关列表');
INSERT INTO `sys_dict_type` VALUES ('4', '任务状态', 'sys_job_status', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES ('5', '任务分组', 'sys_job_group', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES ('6', '系统是否', 'sys_yes_no', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES ('7', '通知类型', 'sys_notice_type', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES ('8', '通知状态', 'sys_notice_status', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES ('9', '操作类型', 'sys_oper_type', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '操作类型列表');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2024-03-21 13:19:01', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2024-03-21 13:19:01', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2024-03-21 13:19:01', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status`) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 96 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统访问记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (1, 'admin', '39.91.1.76', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-05 15:50:20');
INSERT INTO `sys_logininfor` VALUES (2, 'admin', '39.91.1.76', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-05 18:29:46');
INSERT INTO `sys_logininfor` VALUES (3, 'admin', '39.91.1.76', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-05 19:09:41');
INSERT INTO `sys_logininfor` VALUES (4, 'admin', '39.91.1.76', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-05 19:18:29');
INSERT INTO `sys_logininfor` VALUES (5, 'admin', '39.91.1.76', 'XX XX', 'Chrome 12', 'Windows 10', '1', '验证码已失效', '2024-04-05 22:29:31');
INSERT INTO `sys_logininfor` VALUES (6, 'admin', '39.91.1.76', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-05 22:29:34');
INSERT INTO `sys_logininfor` VALUES (7, 'admin', '39.91.1.76', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-06 15:05:59');
INSERT INTO `sys_logininfor` VALUES (8, 'admin', '39.91.1.76', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-06 15:30:41');
INSERT INTO `sys_logininfor` VALUES (9, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-06 18:55:26');
INSERT INTO `sys_logininfor` VALUES (10, 'admin', '39.91.1.76', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-06 19:18:13');
INSERT INTO `sys_logininfor` VALUES (11, 'admin', '111.14.153.10', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-07 10:40:25');
INSERT INTO `sys_logininfor` VALUES (12, 'admin', '111.14.153.10', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-07 11:31:38');
INSERT INTO `sys_logininfor` VALUES (13, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2024-04-07 16:01:54');
INSERT INTO `sys_logininfor` VALUES (14, 'admin', '39.91.1.76', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-07 19:37:25');
INSERT INTO `sys_logininfor` VALUES (15, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-07 19:50:16');
INSERT INTO `sys_logininfor` VALUES (16, 'admin', '111.14.153.10', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-08 15:46:55');
INSERT INTO `sys_logininfor` VALUES (17, 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 1.x', '1', '验证码错误', '2024-04-08 17:00:44');
INSERT INTO `sys_logininfor` VALUES (18, 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2024-04-08 17:00:47');
INSERT INTO `sys_logininfor` VALUES (19, 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2024-04-08 17:01:22');
INSERT INTO `sys_logininfor` VALUES (20, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-08 17:02:33');
INSERT INTO `sys_logininfor` VALUES (21, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-04-08 18:39:47');
INSERT INTO `sys_logininfor` VALUES (22, 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2024-04-08 18:53:37');
INSERT INTO `sys_logininfor` VALUES (23, 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2024-04-08 19:06:29');
INSERT INTO `sys_logininfor` VALUES (24, 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2024-04-09 11:12:40');
INSERT INTO `sys_logininfor` VALUES (25, 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2024-04-09 11:13:11');
INSERT INTO `sys_logininfor` VALUES (26, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-09 18:54:47');
INSERT INTO `sys_logininfor` VALUES (27, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-09 19:06:52');
INSERT INTO `sys_logininfor` VALUES (28, 'admin', '111.14.153.10', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-10 11:19:49');
INSERT INTO `sys_logininfor` VALUES (29, 'admin', '111.14.153.10', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-10 13:03:22');
INSERT INTO `sys_logininfor` VALUES (30, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-10 14:03:37');
INSERT INTO `sys_logininfor` VALUES (31, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-11 08:20:17');
INSERT INTO `sys_logininfor` VALUES (32, '18531608883', '111.14.154.75', 'XX XX', 'Chrome 12', 'Windows 10', '1', '用户不存在/密码错误', '2024-04-12 14:52:57');
INSERT INTO `sys_logininfor` VALUES (33, 'admin', '111.14.154.75', 'XX XX', 'Chrome 12', 'Windows 10', '1', '验证码错误', '2024-04-12 14:53:08');
INSERT INTO `sys_logininfor` VALUES (34, 'admin', '111.14.154.75', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-12 14:53:17');
INSERT INTO `sys_logininfor` VALUES (35, 'zhaoqun', '39.91.1.76', 'XX XX', 'Chrome 12', 'Windows 10', '1', '用户不存在/密码错误', '2024-04-12 23:55:49');
INSERT INTO `sys_logininfor` VALUES (36, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-13 00:07:47');
INSERT INTO `sys_logininfor` VALUES (37, 'zhaoqun', '39.91.1.76', 'XX XX', 'Chrome 12', 'Windows 10', '1', '验证码错误', '2024-04-13 16:52:49');
INSERT INTO `sys_logininfor` VALUES (38, 'zhaoqun', '39.91.1.76', 'XX XX', 'Chrome 12', 'Windows 10', '1', '用户不存在/密码错误', '2024-04-13 16:52:52');
INSERT INTO `sys_logininfor` VALUES (39, 'admin', '39.91.1.76', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-13 16:53:09');
INSERT INTO `sys_logininfor` VALUES (40, 'admin', '39.91.1.76', 'XX XX', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-04-13 17:34:46');
INSERT INTO `sys_logininfor` VALUES (41, 'admin', '39.91.1.76', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-13 17:34:50');
INSERT INTO `sys_logininfor` VALUES (42, 'admin', '39.91.1.76', 'XX XX', 'Chrome 12', 'Windows 10', '1', '验证码已失效', '2024-04-13 17:58:20');
INSERT INTO `sys_logininfor` VALUES (43, 'admin', '39.91.1.76', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-13 17:58:23');
INSERT INTO `sys_logininfor` VALUES (44, 'admin', '39.91.1.76', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-13 19:32:56');
INSERT INTO `sys_logininfor` VALUES (45, 'admin', '39.91.1.76', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-14 10:32:35');
INSERT INTO `sys_logininfor` VALUES (46, 'admin', '39.91.1.76', 'XX XX', 'Chrome 12', 'Windows 10', '1', '验证码已失效', '2024-04-14 15:27:32');
INSERT INTO `sys_logininfor` VALUES (47, 'admin', '39.91.1.76', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-14 15:27:35');
INSERT INTO `sys_logininfor` VALUES (48, 'admin', '39.91.1.76', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-14 15:31:13');
INSERT INTO `sys_logininfor` VALUES (49, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2024-04-17 10:17:27');
INSERT INTO `sys_logininfor` VALUES (50, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '1', '验证码错误', '2024-04-17 14:52:32');
INSERT INTO `sys_logininfor` VALUES (51, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2024-04-17 14:52:37');
INSERT INTO `sys_logininfor` VALUES (52, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2024-04-17 16:56:03');
INSERT INTO `sys_logininfor` VALUES (53, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-17 16:58:44');
INSERT INTO `sys_logininfor` VALUES (54, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-19 11:35:13');
INSERT INTO `sys_logininfor` VALUES (55, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-19 13:34:45');
INSERT INTO `sys_logininfor` VALUES (56, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-23 10:41:02');
INSERT INTO `sys_logininfor` VALUES (57, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-24 10:31:59');
INSERT INTO `sys_logininfor` VALUES (58, 'admin', '116.7.213.68', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-24 10:54:59');
INSERT INTO `sys_logininfor` VALUES (59, 'admin', '43.239.249.46', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-24 15:42:45');
INSERT INTO `sys_logininfor` VALUES (60, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-25 10:30:02');
INSERT INTO `sys_logininfor` VALUES (61, 'admin', '116.7.213.68', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-25 10:45:09');
INSERT INTO `sys_logininfor` VALUES (62, 'admin', '116.7.213.68', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-25 10:45:48');
INSERT INTO `sys_logininfor` VALUES (63, 'admin', '116.7.213.68', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-25 11:16:46');
INSERT INTO `sys_logininfor` VALUES (64, 'admin', '116.7.213.68', 'XX XX', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-04-25 11:23:32');
INSERT INTO `sys_logininfor` VALUES (65, 'admin', '116.7.213.68', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-25 11:23:37');
INSERT INTO `sys_logininfor` VALUES (66, 'admin', '116.7.213.68', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-25 14:32:59');
INSERT INTO `sys_logininfor` VALUES (67, 'admin', '127.0.0.1', '内网IP', 'Apple WebKit', 'Mac OS X (iPhone)', '0', '登录成功', '2024-05-09 15:44:58');
INSERT INTO `sys_logininfor` VALUES (68, 'admin', '218.58.62.117', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-05-14 15:39:54');
INSERT INTO `sys_logininfor` VALUES (69, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-05-19 20:15:56');
INSERT INTO `sys_logininfor` VALUES (70, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-05-23 10:04:32');
INSERT INTO `sys_logininfor` VALUES (71, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-05-23 19:42:19');
INSERT INTO `sys_logininfor` VALUES (72, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2024-05-30 10:24:16');
INSERT INTO `sys_logininfor` VALUES (73, 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2024-05-30 16:09:13');
INSERT INTO `sys_logininfor` VALUES (74, 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2024-05-30 16:11:50');
INSERT INTO `sys_logininfor` VALUES (75, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-05-30 16:22:16');
INSERT INTO `sys_logininfor` VALUES (76, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-06-01 19:29:56');
INSERT INTO `sys_logininfor` VALUES (77, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-06-03 21:58:57');
INSERT INTO `sys_logininfor` VALUES (78, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-06-04 23:49:39');
INSERT INTO `sys_logininfor` VALUES (79, 'admin', '113.111.38.151', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-06-08 15:12:33');
INSERT INTO `sys_logininfor` VALUES (80, 'admin', '113.111.38.151', 'XX XX', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-06-08 15:12:45');
INSERT INTO `sys_logininfor` VALUES (81, 'admin', '113.111.38.151', 'XX XX', 'Chrome 12', 'Windows 10', '1', '验证码已失效', '2024-06-08 16:43:13');
INSERT INTO `sys_logininfor` VALUES (82, 'admin', '113.111.38.151', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-06-08 16:43:17');
INSERT INTO `sys_logininfor` VALUES (83, 'admin', '112.224.163.230', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-06-28 15:50:46');
INSERT INTO `sys_logininfor` VALUES (84, 'admin', '119.164.76.177', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-06-30 11:24:22');
INSERT INTO `sys_logininfor` VALUES (85, 'admin', '119.164.76.177', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-06-30 11:29:56');
INSERT INTO `sys_logininfor` VALUES (86, 'admin', '119.164.76.177', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-06-30 11:30:18');
INSERT INTO `sys_logininfor` VALUES (87, 'admin', '119.164.76.177', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-06-30 11:31:52');
INSERT INTO `sys_logininfor` VALUES (88, 'admin', '119.164.76.177', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-06-30 11:35:16');
INSERT INTO `sys_logininfor` VALUES (89, 'admin', '112.224.162.21', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-07-01 08:45:56');
INSERT INTO `sys_logininfor` VALUES (90, 'admin', '112.224.160.53', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-07-02 10:57:02');
INSERT INTO `sys_logininfor` VALUES (91, 'admin', '112.224.191.38', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-08-02 10:44:16');
INSERT INTO `sys_logininfor` VALUES (92, 'admin', '112.224.143.241', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-08-07 10:01:23');
INSERT INTO `sys_logininfor` VALUES (93, 'admin', '112.224.143.241', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-08-07 10:01:36');
INSERT INTO `sys_logininfor` VALUES (94, 'admin', '112.224.161.68', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-08-07 16:10:24');
INSERT INTO `sys_logininfor` VALUES (95, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-08-08 09:24:18');
INSERT INTO `sys_logininfor` VALUES (96, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-08-09 10:51:32');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '父菜单ID',
  `order_num` int(4) NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '路由参数',
  `is_frame` int(1) NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int(1) NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', '系统管理', '0', 1, 'system', NULL, '', 1, 0, 'M', '0', '0', '', 'iconfont icon-xitongshezhi', 'admin', '2024-03-21 13:19:00', 'admin', '2024-04-19 11:46:27', '系统管理目录');
INSERT INTO `sys_menu` VALUES ('100', '用户管理', '1', 1, 'user', 'system/user/index', '', 1, 0, 'C', '0', '0', 'system:user:list', 'iconfont icon-zidingyibuju', 'admin', '2024-03-21 13:19:00', 'admin', '2024-04-19 13:37:16', '用户管理菜单');
INSERT INTO `sys_menu` VALUES ('1000', '用户查询', '100', 1, '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1001', '用户新增', '100', 2, '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1002', '用户修改', '100', 3, '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1003', '用户删除', '100', 4, '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1004', '用户导出', '100', 5, '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1005', '用户导入', '100', 6, '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1006', '重置密码', '100', 7, '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1007', '角色查询', '101', 1, '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1008', '角色新增', '101', 2, '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1009', '角色修改', '101', 3, '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('101', '角色管理', '1', 2, 'role', 'system/role/index', '', 1, 0, 'C', '0', '0', 'system:role:list', 'iconfont icon-shuxingtu', 'admin', '2024-03-21 13:19:00', 'admin', '2024-04-01 16:23:45', '角色管理菜单');
INSERT INTO `sys_menu` VALUES ('1010', '角色删除', '101', 4, '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1011', '角色导出', '101', 5, '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1012', '菜单查询', '102', 1, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1013', '菜单新增', '102', 2, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1014', '菜单修改', '102', 3, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1015', '菜单删除', '102', 4, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1016', '部门查询', '103', 1, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1017', '部门新增', '103', 2, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1018', '部门修改', '103', 3, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1019', '部门删除', '103', 4, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('102', '菜单管理', '1', 3, 'menu', 'system/menu/index', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'iconfont icon-shuxingtu', 'admin', '2024-03-21 13:19:00', 'admin', '2024-04-01 17:03:22', '菜单管理菜单');
INSERT INTO `sys_menu` VALUES ('1020', '岗位查询', '104', 1, '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1021', '岗位新增', '104', 2, '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1022', '岗位修改', '104', 3, '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1023', '岗位删除', '104', 4, '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1024', '岗位导出', '104', 5, '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1025', '字典查询', '105', 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1026', '字典新增', '105', 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1027', '字典修改', '105', 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1028', '字典删除', '105', 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1029', '字典导出', '105', 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('103', '部门管理', '1', 4, 'dept', 'system/dept/index', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'iconfont icon-zhongduancanshuchaxun', 'admin', '2024-03-21 13:19:00', 'admin', '2024-04-01 17:03:32', '部门管理菜单');
INSERT INTO `sys_menu` VALUES ('1030', '参数查询', '106', 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1031', '参数新增', '106', 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1032', '参数修改', '106', 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1033', '参数删除', '106', 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1034', '参数导出', '106', 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1035', '公告查询', '107', 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1036', '公告新增', '107', 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1037', '公告修改', '107', 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1038', '公告删除', '107', 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1039', '操作查询', '500', 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('104', '岗位管理', '1', 5, 'post', 'system/post/index', '', 1, 0, 'C', '0', '0', 'system:post:list', 'iconfont icon-15tupianyulan', 'admin', '2024-03-21 13:19:00', 'admin', '2024-04-01 17:03:39', '岗位管理菜单');
INSERT INTO `sys_menu` VALUES ('1040', '操作删除', '500', 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1041', '日志导出', '500', 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1042', '登录查询', '501', 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1043', '登录删除', '501', 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1044', '日志导出', '501', 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1045', '账户解锁', '501', 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1046', '在线查询', '109', 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1047', '批量强退', '109', 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1048', '单条强退', '109', 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1049', '任务查询', '110', 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('105', '字典管理', '1', 6, 'dict', 'system/dict/index', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'iconfont icon-zidingyibuju', 'admin', '2024-03-21 13:19:00', 'admin', '2024-04-01 17:03:46', '字典管理菜单');
INSERT INTO `sys_menu` VALUES ('1050', '任务新增', '110', 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1051', '任务修改', '110', 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1052', '任务删除', '110', 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1053', '状态修改', '110', 5, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1054', '任务导出', '110', 6, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1055', '生成查询', '116', 1, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1056', '生成修改', '116', 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1057', '生成删除', '116', 3, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1058', '导入代码', '116', 4, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('1059', '预览代码', '116', 5, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('106', '参数设置', '1', 7, 'config', 'system/config/index', '', 1, 0, 'C', '0', '0', 'system:config:list', 'iconfont icon-fangkuang', 'admin', '2024-03-21 13:19:00', 'admin', '2024-04-01 17:04:00', '参数设置菜单');
INSERT INTO `sys_menu` VALUES ('1060', '生成代码', '116', 6, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES ('107', '通知公告', '1', 8, 'notice', 'system/notice/index', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'iconfont icon-zujian', 'admin', '2024-03-21 13:19:00', 'admin', '2024-04-01 17:04:08', '通知公告菜单');
INSERT INTO `sys_menu` VALUES ('108', '日志管理', '1', 9, 'log', '', '', 1, 0, 'M', '0', '0', '', 'iconfont icon-ico_shuju', 'admin', '2024-03-21 13:19:00', 'admin', '2024-04-01 22:15:35', '日志管理菜单');
INSERT INTO `sys_menu` VALUES ('109', '在线用户', '2', 1, 'online', 'monitor/online/index', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'iconfont icon-putong', 'admin', '2024-03-21 13:19:00', '1', '2025-01-14 09:11:59', '在线用户菜单');
INSERT INTO `sys_menu` VALUES ('110', '定时任务', '2', 2, 'job', 'monitor/job/index', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'iconfont icon-tongzhi3', 'admin', '2024-03-21 13:19:00', 'admin', '2024-03-21 13:37:28', '定时任务菜单');
INSERT INTO `sys_menu` VALUES ('111', '数据监控', '2', 3, 'druid', 'monitor/druid/index', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'iconfont icon-728bianjiqi_zitidaxiao', 'admin', '2024-03-21 13:19:00', 'admin', '2024-03-21 13:37:32', '数据监控菜单');
INSERT INTO `sys_menu` VALUES ('112', '服务监控', '2', 4, 'server', 'monitor/server/index', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'iconfont icon-15tupianyulan', 'admin', '2024-03-21 13:19:00', 'admin', '2024-03-21 13:37:37', '服务监控菜单');
INSERT INTO `sys_menu` VALUES ('113', '缓存监控', '2', 5, 'cache', 'monitor/cache/index', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'iconfont icon-15tupianyulan', 'admin', '2024-03-21 13:19:00', 'admin', '2024-03-21 13:37:41', '缓存监控菜单');
INSERT INTO `sys_menu` VALUES ('114', '缓存列表', '2', 6, 'cacheList', 'monitor/cache/list', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'iconfont icon-fuhao-zhongwen', 'admin', '2024-03-21 13:19:00', 'admin', '2024-03-21 13:37:46', '缓存列表菜单');
INSERT INTO `sys_menu` VALUES ('115', '表单构建', '3', 1, 'build', 'tool/build/index', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'iconfont icon-tupianyulan', 'admin', '2024-03-21 13:19:00', 'admin', '2024-03-21 13:38:00', '表单构建菜单');
INSERT INTO `sys_menu` VALUES ('116', '代码生成', '3', 2, 'gen', 'tool/gen/index', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'iconfont icon-juxingkaobei', 'admin', '2024-03-21 13:19:00', 'admin', '2024-03-21 13:38:04', '代码生成菜单');
INSERT INTO `sys_menu` VALUES ('117', '系统接口', '3', 3, 'swagger', 'tool/swagger/index', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'iconfont icon-ziti', 'admin', '2024-03-21 13:19:00', 'admin', '2024-03-21 13:38:08', '系统接口菜单');
INSERT INTO `sys_menu` VALUES ('2', '系统监控', '0', 2, 'monitor', NULL, '', 1, 0, 'M', '0', '0', '', 'iconfont icon-dongtai', 'admin', '2024-03-21 13:19:00', '1', '2025-01-09 11:04:28', '系统监控目录');
INSERT INTO `sys_menu` VALUES ('3', '系统工具', '0', 3, 'tool', NULL, '', 1, 0, 'M', '0', '0', '', 'iconfont icon-putong', 'admin', '2024-03-21 13:19:00', 'admin', '2024-04-01 14:57:20', '系统工具目录');
INSERT INTO `sys_menu` VALUES ('4', 'Source', '0', 4, 'http://lamb.vip', NULL, '', 0, 0, 'M', '0', '0', '', 'iconfont icon-diqiu', 'admin', '2024-03-21 13:19:00', '1', '2025-01-09 10:53:26', '若依官网地址');
INSERT INTO `sys_menu` VALUES ('500', '操作日志', '108', 1, 'operlog', 'monitor/operlog/index', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'iconfont icon-ziti', 'admin', '2024-03-21 13:19:00', 'admin', '2024-04-01 22:05:39', '操作日志菜单');
INSERT INTO `sys_menu` VALUES ('501', '登录日志', '108', 2, 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'iconfont icon-ziti', 'admin', '2024-03-21 13:19:00', 'admin', '2024-04-01 22:05:47', '登录日志菜单');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '通知公告表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2024-03-21 13:19:01', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2024-03-21 13:19:01', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int(2) NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int(1) NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int(1) NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint(20) NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type`) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status`) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '操作日志记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (1, '操作日志', 9, 'com.ruoyi.web.controller.monitor.SysOperlogController.clean()', 'DELETE', 1, 'admin', NULL, '/monitor/operlog/clean', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-04-03 17:23:39', 38);
INSERT INTO `sys_oper_log` VALUES (2, '登录日志', 3, 'com.ruoyi.web.controller.monitor.SysLogininforController.remove()', 'DELETE', 1, 'admin', NULL, '/monitor/logininfor/181,180,179,178,177,176,175,174,173,172', '39.91.1.76', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-04-05 15:04:21', 44);
INSERT INTO `sys_oper_log` VALUES (3, '登录日志', 3, 'com.ruoyi.web.controller.monitor.SysLogininforController.remove()', 'DELETE', 1, 'admin', NULL, '/monitor/logininfor/171,170,169,168,167,166,165,164,163,162', '39.91.1.76', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-04-05 15:04:24', 15);
INSERT INTO `sys_oper_log` VALUES (4, '登录日志', 9, 'com.ruoyi.web.controller.monitor.SysLogininforController.clean()', 'DELETE', 1, 'admin', NULL, '/monitor/logininfor/clean', '39.91.1.76', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-04-05 15:04:26', 24);
INSERT INTO `sys_oper_log` VALUES (5, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', NULL, '/system/user/profile', '39.91.1.76', 'XX XX', '{\"admin\":true,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2024-03-21 13:19:00\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"研发部门\",\"leader\":\"北城南笙\",\"orderNum\":1,\"params\":{\"@type\":\"java.util.HashMap\"},\"parentId\":101,\"status\":\"0\"},\"deptId\":103,\"email\":\"ry@163.com\",\"loginDate\":\"2024-04-05 15:50:21\",\"loginIp\":\"39.91.1.76\",\"nickName\":\"北城南笙\",\"params\":{\"@type\":\"java.util.HashMap\"},\"phonenumber\":\"15888888888\",\"remark\":\"管理员\",\"roles\":[{\"admin\":true,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{\"@type\":\"java.util.HashMap\"},\"roleId\":1,\"roleKey\":\"admin\",\"roleName\":\"超级管理员\",\"roleSort\":1,\"status\":\"0\"}],\"sex\":\"1\",\"status\":\"0\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-04-05 18:30:16', 17);
INSERT INTO `sys_oper_log` VALUES (6, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', NULL, '/system/user/profile', '39.91.1.76', 'XX XX', '{\"admin\":true,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2024-03-21 13:19:00\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"研发部门\",\"leader\":\"北城南笙\",\"orderNum\":1,\"params\":{\"@type\":\"java.util.HashMap\"},\"parentId\":101,\"status\":\"0\"},\"deptId\":103,\"email\":\"ry@163.com\",\"loginDate\":\"2024-04-05 15:50:21\",\"loginIp\":\"39.91.1.76\",\"nickName\":\"北城南笙\",\"params\":{\"@type\":\"java.util.HashMap\"},\"phonenumber\":\"15888888888\",\"remark\":\"管理员\",\"roles\":[{\"admin\":true,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{\"@type\":\"java.util.HashMap\"},\"roleId\":1,\"roleKey\":\"admin\",\"roleName\":\"超级管理员\",\"roleSort\":1,\"status\":\"0\"}],\"sex\":\"1\",\"status\":\"0\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-04-05 18:30:19', 70);
INSERT INTO `sys_oper_log` VALUES (7, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '111.14.153.10', 'XX XX', '{\"children\":[],\"createTime\":\"2024-03-21 13:19:00\",\"icon\":\"iconfont icon-diqiu\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"小羊叮叮当官网\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-04-07 13:33:49', 58);
INSERT INTO `sys_oper_log` VALUES (8, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '111.14.153.10', 'XX XX', '{\"children\":[],\"createTime\":\"2024-03-21 13:19:00\",\"icon\":\"iconfont icon-diqiu\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"小羊叮叮当官网\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"/ccc\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"修改菜单\'小羊叮叮当官网\'失败，地址必须以http(s)://开头\",\"code\":500}', 0, NULL, '2024-04-07 13:34:02', 4);
INSERT INTO `sys_oper_log` VALUES (9, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '111.14.153.10', 'XX XX', '{\"children\":[],\"createTime\":\"2024-03-21 13:19:00\",\"icon\":\"iconfont icon-diqiu\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"小羊叮叮当官网\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"http://;amb.vip\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-04-07 13:34:11', 15);
INSERT INTO `sys_oper_log` VALUES (10, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '111.14.153.10', 'XX XX', '{\"children\":[],\"createTime\":\"2024-03-21 13:19:00\",\"icon\":\"iconfont icon-diqiu\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"小羊叮叮当官网\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"http:/lamb.vip\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"修改菜单\'小羊叮叮当官网\'失败，地址必须以http(s)://开头\",\"code\":500}', 0, NULL, '2024-04-07 13:34:27', 6);
INSERT INTO `sys_oper_log` VALUES (11, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '111.14.153.10', 'XX XX', '{\"children\":[],\"createTime\":\"2024-03-21 13:19:00\",\"icon\":\"iconfont icon-diqiu\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"小羊叮叮当官网\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"http://lamb.vip\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-04-07 13:34:36', 33);
INSERT INTO `sys_oper_log` VALUES (12, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', NULL, '/system/dept', '39.91.1.76', 'XX XX', '{\"ancestors\":\"0,100,101\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"1\",\"orderNum\":0,\"params\":{},\"parentId\":101,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-04-14 15:31:46', 137);
INSERT INTO `sys_oper_log` VALUES (13, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', NULL, '/system/dept', '39.91.1.76', 'XX XX', '{\"children\":[],\"deptName\":\"1\",\"orderNum\":0,\"params\":{},\"parentId\":101,\"status\":\"0\"}', '{\"msg\":\"新增部门\'1\'失败，部门名称已存在\",\"code\":500}', 0, NULL, '2024-04-14 15:31:51', 17);
INSERT INTO `sys_oper_log` VALUES (14, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', NULL, '/system/dept', '39.91.1.76', 'XX XX', '{\"ancestors\":\"0,100,101\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"12\",\"orderNum\":0,\"params\":{},\"parentId\":101,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-04-14 15:31:53', 12);
INSERT INTO `sys_oper_log` VALUES (15, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', NULL, '/system/dept', '39.91.1.76', 'XX XX', '{\"children\":[],\"deptName\":\"12\",\"orderNum\":0,\"params\":{},\"parentId\":101,\"status\":\"0\"}', '{\"msg\":\"新增部门\'12\'失败，部门名称已存在\",\"code\":500}', 0, NULL, '2024-04-14 15:31:58', 3);
INSERT INTO `sys_oper_log` VALUES (16, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', NULL, '/system/dept', '39.91.1.76', 'XX XX', '{\"ancestors\":\"0,100,101\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"122\",\"orderNum\":0,\"params\":{},\"parentId\":101,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-04-14 15:32:00', 29);
INSERT INTO `sys_oper_log` VALUES (17, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', NULL, '/system/dept', '39.91.1.76', 'XX XX', '{\"ancestors\":\"0,100,101\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"213\",\"orderNum\":0,\"params\":{},\"parentId\":101,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-04-14 15:32:03', 24);
INSERT INTO `sys_oper_log` VALUES (18, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', NULL, '/system/dept', '39.91.1.76', 'XX XX', '{\"ancestors\":\"0,100,101\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"123\",\"orderNum\":0,\"params\":{},\"parentId\":101,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-04-14 15:32:06', 21);
INSERT INTO `sys_oper_log` VALUES (19, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', NULL, '/system/dept', '39.91.1.76', 'XX XX', '{\"ancestors\":\"0,100,101\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"12312\",\"orderNum\":0,\"params\":{},\"parentId\":101,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-04-14 15:32:10', 20);
INSERT INTO `sys_oper_log` VALUES (20, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', NULL, '/system/dept', '39.91.1.76', 'XX XX', '{\"children\":[],\"deptName\":\"123\",\"orderNum\":0,\"params\":{},\"parentId\":101,\"status\":\"0\"}', '{\"msg\":\"新增部门\'123\'失败，部门名称已存在\",\"code\":500}', 0, NULL, '2024-04-14 15:32:14', 12);
INSERT INTO `sys_oper_log` VALUES (21, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', NULL, '/system/dept', '39.91.1.76', 'XX XX', '{\"ancestors\":\"0,100,101\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"1234455\",\"orderNum\":0,\"params\":{},\"parentId\":101,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-04-14 15:32:16', 133);
INSERT INTO `sys_oper_log` VALUES (22, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', NULL, '/system/dept', '39.91.1.76', 'XX XX', '{\"ancestors\":\"0,100,101,116\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"123213\",\"orderNum\":0,\"params\":{},\"parentId\":116,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-04-14 15:32:19', 40);
INSERT INTO `sys_oper_log` VALUES (23, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', NULL, '/system/dept', '39.91.1.76', 'XX XX', '{\"ancestors\":\"0,100,101\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"12313\",\"orderNum\":0,\"params\":{},\"parentId\":101,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-04-14 15:32:22', 35);
INSERT INTO `sys_oper_log` VALUES (24, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', NULL, '/system/dept', '39.91.1.76', 'XX XX', '{\"ancestors\":\"0,100,101,118\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"123213\",\"orderNum\":0,\"params\":{},\"parentId\":118,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-04-14 15:32:25', 30);
INSERT INTO `sys_oper_log` VALUES (25, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', NULL, '/system/dept', '39.91.1.76', 'XX XX', '{\"ancestors\":\"0,100,101,110\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"12312321\",\"orderNum\":0,\"params\":{},\"parentId\":110,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-04-14 15:32:28', 15);
INSERT INTO `sys_oper_log` VALUES (26, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', NULL, '/system/dept', '39.91.1.76', 'XX XX', '{\"ancestors\":\"0,100,101\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"asdasd\",\"orderNum\":0,\"params\":{},\"parentId\":101,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-04-14 15:41:45', 21);
INSERT INTO `sys_oper_log` VALUES (27, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', NULL, '/system/dept', '39.91.1.76', 'XX XX', '{\"ancestors\":\"0,100,101\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"asdasdasd\",\"orderNum\":0,\"params\":{},\"parentId\":101,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-04-14 15:41:49', 49);
INSERT INTO `sys_oper_log` VALUES (28, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', NULL, '/system/dept', '39.91.1.76', 'XX XX', '{\"ancestors\":\"0,100,101,122\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"asdasdasd\",\"orderNum\":0,\"params\":{},\"parentId\":122,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-04-14 15:41:55', 40);
INSERT INTO `sys_oper_log` VALUES (29, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', NULL, '/system/dept', '39.91.1.76', 'XX XX', '{\"ancestors\":\"0,100,101,110,120\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"asdasd\",\"orderNum\":0,\"params\":{},\"parentId\":120,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-04-14 15:42:11', 22);
INSERT INTO `sys_oper_log` VALUES (30, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', NULL, '/system/dept', '39.91.1.76', 'XX XX', '{\"ancestors\":\"0,100,101,116,117\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"asdasd\",\"orderNum\":0,\"params\":{},\"parentId\":117,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-04-14 15:42:14', 9);
INSERT INTO `sys_oper_log` VALUES (31, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', NULL, '/system/dept', '39.91.1.76', 'XX XX', '{\"ancestors\":\"0,100,101,116,117,125\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"asdsadsad\",\"orderNum\":0,\"params\":{},\"parentId\":125,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-04-14 15:42:16', 28);
INSERT INTO `sys_oper_log` VALUES (32, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', NULL, '/system/dept', '39.91.1.76', 'XX XX', '{\"ancestors\":\"0,100,101,116,117\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"asdad\",\"orderNum\":0,\"params\":{},\"parentId\":117,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-04-14 15:42:18', 18);
INSERT INTO `sys_oper_log` VALUES (33, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/user/index\",\"createTime\":\"2024-03-21 13:19:00\",\"icon\":\"iconfont icon-zidingyibuju\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":100,\"menuName\":\"用户管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"/system/user\",\"perms\":\"system:user:list\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-04-19 11:44:59', 63);
INSERT INTO `sys_oper_log` VALUES (34, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/user/index\",\"createTime\":\"2024-03-21 13:19:00\",\"icon\":\"iconfont icon-zidingyibuju\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":100,\"menuName\":\"用户管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"/system/user\",\"perms\":\"system:user:list\",\"query\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-04-19 11:45:15', 8);
INSERT INTO `sys_oper_log` VALUES (35, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2024-03-21 13:19:00\",\"icon\":\"iconfont icon-xitongshezhi\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":1,\"menuName\":\"系统管理\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"system\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-04-19 11:46:18', 40);
INSERT INTO `sys_oper_log` VALUES (36, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2024-03-21 13:19:00\",\"icon\":\"iconfont icon-xitongshezhi\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":1,\"menuName\":\"系统管理\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"system\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-04-19 11:46:27', 10);
INSERT INTO `sys_oper_log` VALUES (37, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/user/index\",\"createTime\":\"2024-03-21 13:19:00\",\"icon\":\"iconfont icon-zidingyibuju\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":100,\"menuName\":\"用户管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"/system/user\",\"perms\":\"system:user:list\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-04-19 13:37:16', 20);
INSERT INTO `sys_oper_log` VALUES (38, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.changeStatus()', 'PUT', 1, 'admin', NULL, '/system/user/changeStatus', '127.0.0.1', '内网IP', '{\"admin\":true,\"params\":{},\"status\":\"1\",\"userId\":1}', NULL, 1, '不允许操作超级管理员用户', '2024-05-23 10:04:46', 40);
INSERT INTO `sys_oper_log` VALUES (39, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.changeStatus()', 'PUT', 1, 'admin', NULL, '/system/user/changeStatus', '127.0.0.1', '内网IP', '{\"admin\":true,\"params\":{},\"status\":\"1\",\"userId\":1}', NULL, 1, '不允许操作超级管理员用户', '2024-06-04 23:50:12', 26);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int(4) NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '岗位信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2024-03-21 13:19:00', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2024-03-21 13:19:00', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(4) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2024-03-21 13:19:00', '', NULL, '普通角色');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色ID',
  `dept_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES ('2', '100');
INSERT INTO `sys_role_dept` VALUES ('2', '101');
INSERT INTO `sys_role_dept` VALUES ('2', '105');
INSERT INTO `sys_role_dept` VALUES ('2', '123');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 117);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户ID',
  `dept_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门ID',
  `open_id` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '微信小程序id',
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', '103', '', 'admin', '北城南笙', '00', 'ry@163.com', '15888888888', '1', '', '$2a$04$3j32uNKkBp5HpOQLejmSXeYf3BLGA1.2HBB2Or9Nc3z.opbSmiefi', '0', '0', '127.0.0.1', '2024-11-04 15:47:50', 'admin', '2024-03-21 13:19:00', '', '2024-11-04 15:47:50', '管理员');
INSERT INTO `sys_user` VALUES ('2', '105', NULL, 'ry', '北城南笙', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$04$3j32uNKkBp5HpOQLejmSXeYf3BLGA1.2HBB2Or9Nc3z.opbSmiefi', '0', '0', '127.0.0.1', '2024-03-21 13:19:00', 'admin', '2024-03-21 13:19:00', 'admin', '2024-04-01 18:17:23', '测试员');

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);

SET FOREIGN_KEY_CHECKS = 1;
