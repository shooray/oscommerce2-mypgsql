<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2002 osCommerce

  Released under the GNU General Public License
*/

define('HEADING_TITLE', '广告管理');

define('TABLE_HEADING_BANNERS', '广告名');
define('TABLE_HEADING_GROUPS', '广告组组');
define('TABLE_HEADING_STATISTICS', '展示 / 点击');
define('TABLE_HEADING_STATUS', '状态');
define('TABLE_HEADING_ACTION', '操作');

define('TEXT_BANNERS_TITLE', '广告标题:');
define('TEXT_BANNERS_URL', '广告 URL:');
define('TEXT_BANNERS_GROUP', '广告组:');
define('TEXT_BANNERS_NEW_GROUP', ', 或在下面输入新的组名');
define('TEXT_BANNERS_IMAGE', '图片:');
define('TEXT_BANNERS_IMAGE_LOCAL', ', 或在下面输入服务器图片路径');
define('TEXT_BANNERS_IMAGE_TARGET', '图片目标位置 (保存到):');
define('TEXT_BANNERS_HTML_TEXT', 'HTML 文本:');
define('TEXT_BANNERS_EXPIRES_ON', '到期日期:');
define('TEXT_BANNERS_OR_AT', ', 或在');
define('TEXT_BANNERS_IMPRESSIONS', '查看次数.');
define('TEXT_BANNERS_SCHEDULED_AT', '预定日期:');
define('TEXT_BANNERS_BANNER_NOTE', '<strong>广告:</strong><ul><li>使用图片或html做为广告 - 两者不能同时启用.</li><li>Html的优先权高于图片</li></ul>');
define('TEXT_BANNERS_INSERT_NOTE', '<strong>图片:</strong><ul><li>上传目录必须可写!</li><li>如果将图片保存到图片根目录 保存到目录 可为空</li><li>保存到 目录必须以/结尾.</li></ul>');
define('TEXT_BANNERS_EXPIRCY_NOTE', '<strong>有效期:</strong><ul><li>日期和查看次数只需要填写其中一项</li><li>两者都不填写 广告将一直起效不会到期</li></ul>');
define('TEXT_BANNERS_SCHEDULE_NOTE', '<strong>预期:</strong><ul><li>如果预期被设置, 广告将在设置日期激活.</li><li>所有预期广告将自动标记为非激活状态. 到期将自动开启</li></ul>');

define('TEXT_BANNERS_DATE_ADDED', '添加日期:');
define('TEXT_BANNERS_SCHEDULED_AT_DATE', '预定日期: <strong>%s</strong>');
define('TEXT_BANNERS_EXPIRES_AT_DATE', '到期日期: <strong>%s</strong>');
define('TEXT_BANNERS_EXPIRES_AT_IMPRESSIONS', '有效点击: <strong>%s</strong> impressions');
define('TEXT_BANNERS_STATUS_CHANGE', '状态转变: %s');

define('TEXT_BANNERS_DATA', 'D<br />A<br />T<br />A');
define('TEXT_BANNERS_LAST_3_DAYS', '最近三天');
define('TEXT_BANNERS_BANNER_VIEWS', '广告查看');
define('TEXT_BANNERS_BANNER_CLICKS', '广告点击');

define('TEXT_INFO_DELETE_INTRO', '你确认要删除广告吗?');
define('TEXT_INFO_DELETE_IMAGE', '删除广告图片');

define('SUCCESS_BANNER_INSERTED', '成功： The banner has been inserted.');
define('SUCCESS_BANNER_UPDATED', '成功： The banner has been updated.');
define('SUCCESS_BANNER_REMOVED', '成功： The banner has been removed.');
define('SUCCESS_BANNER_STATUS_UPDATED', '成功： The status of the banner has been updated.');

define('ERROR_BANNER_TITLE_REQUIRED', '错误： Banner title required.');
define('ERROR_BANNER_GROUP_REQUIRED', '错误： Banner group required.');
define('ERROR_IMAGE_DIRECTORY_DOES_NOT_EXIST', '错误： Target directory does not exist: %s');
define('ERROR_IMAGE_DIRECTORY_NOT_WRITEABLE', '错误： Target directory is not writeable: %s');
define('ERROR_IMAGE_DOES_NOT_EXIST', '错误： 图片不存在.');
define('ERROR_IMAGE_IS_NOT_WRITEABLE', '错误： 图片未被删除.');
define('ERROR_UNKNOWN_STATUS_FLAG', '错误： 未知状态标记.');

define('ERROR_GRAPHS_DIRECTORY_DOES_NOT_EXIST', '错误： 图形目录不存在. Please create a \'graphs\' directory inside \'images\'.');
define('ERROR_GRAPHS_DIRECTORY_NOT_WRITEABLE', '错误：图形目录不可写.');
?>
