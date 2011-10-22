<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2002 osCommerce

  Released under the GNU General Public License
*/

define('HEADING_TITLE', '订单');
define('HEADING_TITLE_SEARCH', '订单 ID:');
define('HEADING_TITLE_STATUS', '状态:');

define('TABLE_HEADING_COMMENTS', '备注');
define('TABLE_HEADING_CUSTOMERS', '客户');
define('TABLE_HEADING_ORDER_TOTAL', '订单总计');
define('TABLE_HEADING_DATE_PURCHASED', '订购日期');
define('TABLE_HEADING_STATUS', '状态');
define('TABLE_HEADING_ACTION', '操作');
define('TABLE_HEADING_QUANTITY', '数量.');
define('TABLE_HEADING_PRODUCTS_MODEL', '型号');
define('TABLE_HEADING_PRODUCTS', '商品');
define('TABLE_HEADING_TAX', '税');
define('TABLE_HEADING_TOTAL', '总计');
define('TABLE_HEADING_PRICE_EXCLUDING_TAX', '价格 (不含税)');
define('TABLE_HEADING_PRICE_INCLUDING_TAX', '价格 (含税)');
define('TABLE_HEADING_TOTAL_EXCLUDING_TAX', '小计 (不含税)');
define('TABLE_HEADING_TOTAL_INCLUDING_TAX', '小计 (含税)');

define('TABLE_HEADING_CUSTOMER_NOTIFIED', '通知客户');
define('TABLE_HEADING_DATE_ADDED', '添加日期');

define('ENTRY_CUSTOMER', '客户:');
define('ENTRY_SOLD_TO', '销售给:');
define('ENTRY_DELIVERY_TO', '送货给:');
define('ENTRY_SHIP_TO', '发送到:');
define('ENTRY_SHIPPING_ADDRESS', '送货地址:');
define('ENTRY_BILLING_ADDRESS', '账单地址:');
define('ENTRY_PAYMENT_METHOD', '付款方式:');
define('ENTRY_CREDIT_CARD_TYPE', '信用卡类型:');
define('ENTRY_CREDIT_CARD_OWNER', '信用卡持有人:');
define('ENTRY_CREDIT_CARD_NUMBER', '信用卡号:');
define('ENTRY_CREDIT_CARD_EXPIRES', '有效期:');
define('ENTRY_SUB_TOTAL', '小计:');
define('ENTRY_TAX', '税:');
define('ENTRY_SHIPPING', 'Shipping:');
define('ENTRY_TOTAL', '总计:');
define('ENTRY_DATE_PURCHASED', '购买日期:');
define('ENTRY_STATUS', '状态:');
define('ENTRY_DATE_LAST_UPDATED', '更新日期:');
define('ENTRY_NOTIFY_CUSTOMER', '通知客户:');
define('ENTRY_NOTIFY_COMMENTS', '应用备注:');
define('ENTRY_PRINTABLE', '打印发票');

define('TEXT_INFO_HEADING_DELETE_ORDER', '删除订单');
define('TEXT_INFO_DELETE_INTRO', '您确认要删除该订单吗?');
define('TEXT_INFO_RESTOCK_PRODUCT_QUANTITY', '恢复库存');
define('TEXT_DATE_ORDER_CREATED', '创建日期:');
define('TEXT_DATE_ORDER_LAST_MODIFIED', '修改日期:');
define('TEXT_INFO_PAYMENT_METHOD', '支付方式:');

define('TEXT_ALL_ORDERS', '全部订单');
define('TEXT_NO_ORDER_HISTORY', '无订购历史');

define('EMAIL_SEPARATOR', '------------------------------------------------------');
define('EMAIL_TEXT_SUBJECT', '订单处理更新');
define('EMAIL_TEXT_ORDER_NUMBER', '订单号:');
define('EMAIL_TEXT_INVOICE_URL', '发票详细:');
define('EMAIL_TEXT_DATE_ORDERED', '订购日期:');
define('EMAIL_TEXT_STATUS_UPDATE', '您的订单已更新为如下状态' . "\n\n" . '新状态: %s' . "\n\n" . '有任何疑问请回复该邮件.' . "\n");
define('EMAIL_TEXT_COMMENTS_UPDATE', '订单备注' . "\n\n%s\n\n");

define('ERROR_ORDER_DOES_NOT_EXIST', '错误: 订单不存在.');
define('SUCCESS_ORDER_UPDATED', '成功: 订单成功更新.');
define('WARNING_ORDER_NOT_UPDATED', '警告: 无任何更新.');
?>