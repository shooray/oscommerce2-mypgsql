<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2007 osCommerce

  Released under the GNU General Public License
*/

define('HEADING_TITLE', '订单状态');

define('TABLE_HEADING_ORDERS_STATUS', '订单状态管理');
define('TABLE_HEADING_PUBLIC_STATUS', '公共状态（对顾客显示）');
define('TABLE_HEADING_DOWNLOADS_STATUS', '下载状态');
define('TABLE_HEADING_ACTION', '操作');

define('TEXT_INFO_EDIT_INTRO', '编辑订单状态');
define('TEXT_INFO_ORDERS_STATUS_NAME', '订单状态:');
define('TEXT_INFO_INSERT_INTRO', '添加新订单状态');
define('TEXT_INFO_DELETE_INTRO', '您确认要删除该订单状态?');
define('TEXT_INFO_HEADING_NEW_ORDERS_STATUS', '添加新订单状态');
define('TEXT_INFO_HEADING_EDIT_ORDERS_STATUS', '编辑订单状态');
define('TEXT_INFO_HEADING_DELETE_ORDERS_STATUS', '删除订单状态');

define('TEXT_SET_PUBLIC_STATUS', '显示这个状态给客户');
define('TEXT_SET_DOWNLOADS_STATUS', '允许下载');

define('ERROR_REMOVE_DEFAULT_ORDER_STATUS', '错误: 默认订单状态不能删除.请将其他状态设置成默认然后重试');
define('ERROR_STATUS_USED_IN_ORDERS', '错误: 该状态当前有订单在使用.');
define('ERROR_STATUS_USED_IN_HISTORY', '错误: 该状态当前在订购历史中有使用.');
?>