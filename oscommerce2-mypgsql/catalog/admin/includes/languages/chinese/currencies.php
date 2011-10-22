<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2003 osCommerce

  Released under the GNU General Public License
*/

define('HEADING_TITLE', '货币管理');

define('TABLE_HEADING_CURRENCY_NAME', '货币');
define('TABLE_HEADING_CURRENCY_CODES', '代码');
define('TABLE_HEADING_CURRENCY_VALUE', '币值');
define('TABLE_HEADING_ACTION', '操作');

define('TEXT_INFO_EDIT_INTRO', '编辑货币');
define('TEXT_INFO_COMMON_CURRENCIES', '-- Common Currencies --');
define('TEXT_INFO_CURRENCY_TITLE', '名称:');
define('TEXT_INFO_CURRENCY_CODE', '货币代码（ISO）:');
define('TEXT_INFO_CURRENCY_SYMBOL_LEFT', '左侧符号:');
define('TEXT_INFO_CURRENCY_SYMBOL_RIGHT', '右侧符号:');
define('TEXT_INFO_CURRENCY_DECIMAL_POINT', '小数点:');
define('TEXT_INFO_CURRENCY_THOUSANDS_POINT', '千位符号:');
define('TEXT_INFO_CURRENCY_DECIMAL_PLACES', '小数位:');
define('TEXT_INFO_CURRENCY_LAST_UPDATED', '最后更新日期:');
define('TEXT_INFO_CURRENCY_VALUE', '币值:');
define('TEXT_INFO_CURRENCY_EXAMPLE', '样例:');
define('TEXT_INFO_INSERT_INTRO', '添加新货币');
define('TEXT_INFO_DELETE_INTRO', '您确认要删除该货币?');
define('TEXT_INFO_HEADING_NEW_CURRENCY', '新货币');
define('TEXT_INFO_HEADING_EDIT_CURRENCY', '编辑货币');
define('TEXT_INFO_HEADING_DELETE_CURRENCY', '删除货币');
define('TEXT_INFO_SET_AS_DEFAULT', TEXT_SET_DEFAULT . ' (需要手动更新汇率)');
define('TEXT_INFO_CURRENCY_UPDATED', ' %s (%s) 的汇率已通过%s成功更新!');

define('ERROR_REMOVE_DEFAULT_CURRENCY', '错误: 默认货币不能被删除.您可将其他货币设置成默认然后删除');
define('ERROR_CURRENCY_INVALID', '错误: %s (%s) 汇率跟新从 %s 失败?');
define('WARNING_PRIMARY_SERVER_FAILED', '警告: 首选汇率服务器 (%s) 失败 %s (%s) - 尝试第二服务器.');
?>
