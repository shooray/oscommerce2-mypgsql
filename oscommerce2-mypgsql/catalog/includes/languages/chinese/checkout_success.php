<?php
/*
  $Id: checkout_success.php,v 1.1.2.1 2004/10/09 16:07:20 cvsadmin Exp $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com
  Copyright (c) 2002 osCommerce
  Released under the GNU General Public License
*/

define('NAVBAR_TITLE_1', '结帐');
define('NAVBAR_TITLE_2', '完成');

define('HEADING_TITLE', '您的订单已处理完毕！');

define('TEXT_SUCCESS', '您的订单已处理完毕！货物将于二至五个工作日寄达您指定的送货地址.');
define('TEXT_NOTIFY_PRODUCTS', '下列所选商品若更新时，请通知我：');
define('TEXT_SEE_ORDERS', '要查阅您的订单纪录，回到<a href="' . tep_href_link(FILENAME_ACCOUNT, '', 'SSL') . '">\'我的帐号\'</a>，并点击<a href="' . tep_href_link(FILENAME_ACCOUNT_HISTORY, '', 'SSL') . '">\'订单记录\'</a>.');
define('TEXT_CONTACT_STORE_OWNER', '有任何疑问，请<a href="' . tep_href_link(FILENAME_CONTACT_US) . '">联络我们</a>。');
define('TEXT_THANKS_FOR_SHOPPING', '谢谢您惠顾我们的网上购物商店！');

define('TABLE_HEADING_COMMENTS', '欢迎您留下宝贵的意见或建议');

define('TABLE_HEADING_DOWNLOAD_DATE', '到期日：');
define('TABLE_HEADING_DOWNLOAD_COUNT', ' 下载剩余。');
define('HEADING_DOWNLOAD', '从这里下载您的商品：');
define('FOOTER_DOWNLOAD', '您也可以稍后再来\'%s\'下载您的商品');
?>