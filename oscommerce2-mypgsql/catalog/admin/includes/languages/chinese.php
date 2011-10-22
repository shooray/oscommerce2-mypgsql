<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2007 osCommerce

  Released under the GNU General Public License
*/

// look in your $PATH_LOCALE/locale directory for available locales..
// on RedHat6.0 I used 'en_US'
// on FreeBSD 4.0 I use 'en_US.ISO_8859-1'
// this may not work under win32 environments..
setlocale(LC_TIME, 'en_US.ISO_8859-1');
define('DATE_FORMAT_SHORT', '%m/%d/%Y');  // this is used for strftime()
define('DATE_FORMAT_LONG', '%A %d %B, %Y'); // this is used for strftime()
define('DATE_FORMAT', 'm/d/Y'); // this is used for date()
define('PHP_DATE_TIME_FORMAT', 'm/d/Y H:i:s'); // this is used for date()
define('DATE_TIME_FORMAT', DATE_FORMAT_SHORT . ' %H:%M:%S');
define('JQUERY_DATEPICKER_I18N_CODE', ''); // leave empty for en_US; see http://jqueryui.com/demos/datepicker/#localization
define('JQUERY_DATEPICKER_FORMAT', 'mm/dd/yy'); // see http://docs.jquery.com/UI/Datepicker/formatDate

////
// Return date in raw format
// $date should be in format mm/dd/yyyy
// raw date is in format YYYYMMDD, or DDMMYYYY
function tep_date_raw($date, $reverse = false) {
  if ($reverse) {
    return substr($date, 3, 2) . substr($date, 0, 2) . substr($date, 6, 4);
  } else {
    return substr($date, 6, 4) . substr($date, 0, 2) . substr($date, 3, 2);
  }
}

// Global entries for the <html> tag
define('HTML_PARAMS','dir="ltr" lang="cn"');

// charset for web pages and emails
define('CHARSET', 'utf-8');

// page title
define('TITLE', 'osCommerce Online Merchant Administration Tool');

// header text in includes/header.php
define('HEADER_TITLE_TOP', '管理员设置');
define('HEADER_TITLE_SUPPORT_SITE', '支持站点');
define('HEADER_TITLE_ONLINE_CATALOG', '前往商店');
define('HEADER_TITLE_ADMINISTRATION', '管理首页');

// text for gender
define('MALE', '先生');
define('FEMALE', '女士');

// text for date of birth example
define('DOB_FORMAT_STRING', 'mm/dd/yyyy');

// configuration box text in includes/boxes/configuration.php
define('BOX_HEADING_CONFIGURATION', '系统设置');
define('BOX_CONFIGURATION_MYSTORE', '基本设置');
define('BOX_CONFIGURATION_LOGGING', '日志');
define('BOX_CONFIGURATION_CACHE', '缓存控制');
define('BOX_CONFIGURATION_ADMINISTRATORS', '管理员设置');
define('BOX_CONFIGURATION_STORE_LOGO', '网站 Logo');

// modules box text in includes/boxes/modules.php
define('BOX_HEADING_MODULES', '扩充模块');

// categories box text in includes/boxes/catalog.php
define('BOX_HEADING_CATALOG', '产品管理');
define('BOX_CATALOG_CATEGORIES_PRODUCTS', '分类/商品');
define('BOX_CATALOG_CATEGORIES_PRODUCTS_ATTRIBUTES', '产品属性');
define('BOX_CATALOG_MANUFACTURERS', '品牌管理');
define('BOX_CATALOG_REVIEWS', '商品评论');
define('BOX_CATALOG_SPECIALS', '特价商品');
define('BOX_CATALOG_PRODUCTS_EXPECTED', '预期商品');

// customers box text in includes/boxes/customers.php
define('BOX_HEADING_CUSTOMERS', '客户 / 订单');
define('BOX_CUSTOMERS_CUSTOMERS', '客户');
define('BOX_CUSTOMERS_ORDERS', '订单');

// taxes box text in includes/boxes/taxes.php
define('BOX_HEADING_LOCATION_AND_TAXES', '国家 / 税率');
define('BOX_TAXES_COUNTRIES', '国家');
define('BOX_TAXES_ZONES', '地区');
define('BOX_TAXES_GEO_ZONES', '税区');
define('BOX_TAXES_TAX_CLASSES', '税种');
define('BOX_TAXES_TAX_RATES', '税率');

// reports box text in includes/boxes/reports.php
define('BOX_HEADING_REPORTS', '报表');
define('BOX_REPORTS_PRODUCTS_VIEWED', '查看统计');
define('BOX_REPORTS_PRODUCTS_PURCHASED', '购买统计');
define('BOX_REPORTS_ORDERS_TOTAL', '客户统计');

// tools text in includes/boxes/tools.php
define('BOX_HEADING_TOOLS', '系统工具');
define('BOX_TOOLS_ACTION_RECORDER', '操作记录');
define('BOX_TOOLS_BACKUP', '数据库备份');
define('BOX_TOOLS_BANNER_MANAGER', '广告管理');
define('BOX_TOOLS_CACHE', '缓存控制');
define('BOX_TOOLS_DEFINE_LANGUAGE', '定义语言包');
define('BOX_TOOLS_MAIL', '发送邮件');
define('BOX_TOOLS_NEWSLETTER_MANAGER', '订阅管理');
define('BOX_TOOLS_SEC_DIR_PERMISSIONS', '目录权限');
define('BOX_TOOLS_SERVER_INFO', '服务器信息');
define('BOX_TOOLS_VERSION_CHECK', '版本检查');
define('BOX_TOOLS_WHOS_ONLINE', '在线客户');

// localizaion box text in includes/boxes/localization.php
define('BOX_HEADING_LOCALIZATION', '本地化设置');
define('BOX_LOCALIZATION_CURRENCIES', '货币设置');
define('BOX_LOCALIZATION_LANGUAGES', '语言设置');
define('BOX_LOCALIZATION_ORDERS_STATUS', '订单状态');

// javascript messages
define('JS_ERROR', 'Errors have occured during the process of your form!\nPlease make the following corrections:\n\n');

define('JS_OPTIONS_VALUE_PRICE', '* The new product atribute needs a price value\n');
define('JS_OPTIONS_VALUE_PRICE_PREFIX', '* The new product atribute needs a price prefix\n');

define('JS_PRODUCTS_NAME', '* The new product needs a name\n');
define('JS_PRODUCTS_DESCRIPTION', '* The new product needs a description\n');
define('JS_PRODUCTS_PRICE', '* The new product needs a price value\n');
define('JS_PRODUCTS_WEIGHT', '* The new product needs a weight value\n');
define('JS_PRODUCTS_QUANTITY', '* The new product needs a quantity value\n');
define('JS_PRODUCTS_MODEL', '* The new product needs a model value\n');
define('JS_PRODUCTS_IMAGE', '* The new product needs an image value\n');

define('JS_SPECIALS_PRODUCTS_PRICE', '* A new price for this product needs to be set\n');

define('JS_GENDER', '* The \'Gender\' value must be chosen.\n');
define('JS_FIRST_NAME', '* The \'First Name\' entry must have at least ' . ENTRY_FIRST_NAME_MIN_LENGTH . ' characters.\n');
define('JS_LAST_NAME', '* The \'Last Name\' entry must have at least ' . ENTRY_LAST_NAME_MIN_LENGTH . ' characters.\n');
define('JS_DOB', '* The \'Date of Birth\' entry must be in the format: xx/xx/xxxx (month/date/year).\n');
define('JS_EMAIL_ADDRESS', '* The \'E-Mail Address\' entry must have at least ' . ENTRY_EMAIL_ADDRESS_MIN_LENGTH . ' characters.\n');
define('JS_ADDRESS', '* The \'Street Address\' entry must have at least ' . ENTRY_STREET_ADDRESS_MIN_LENGTH . ' characters.\n');
define('JS_POST_CODE', '* The \'Post Code\' entry must have at least ' . ENTRY_POSTCODE_MIN_LENGTH . ' characters.\n');
define('JS_CITY', '* The \'City\' entry must have at least ' . ENTRY_CITY_MIN_LENGTH . ' characters.\n');
define('JS_STATE', '* The \'State\' entry is must be selected.\n');
define('JS_STATE_SELECT', '-- Select Above --');
define('JS_ZONE', '* The \'State\' entry must be selected from the list for this country.');
define('JS_COUNTRY', '* The \'Country\' value must be chosen.\n');
define('JS_TELEPHONE', '* The \'Telephone Number\' entry must have at least ' . ENTRY_TELEPHONE_MIN_LENGTH . ' characters.\n');
define('JS_PASSWORD', '* The \'Password\' amd \'Confirmation\' entries must match amd have at least ' . ENTRY_PASSWORD_MIN_LENGTH . ' characters.\n');

define('JS_ORDER_DOES_NOT_EXIST', 'Order Number %s does not exist!');

define('CATEGORY_PERSONAL', '个人基本资料');
define('CATEGORY_ADDRESS', '地址');
define('CATEGORY_CONTACT', '联系方式');
define('CATEGORY_COMPANY', '公司');
define('CATEGORY_OPTIONS', '可选项');

define('ENTRY_GENDER', '性别:');
define('ENTRY_GENDER_ERROR', '&nbsp;<span class="errorText">必填</span>');
define('ENTRY_FIRST_NAME', ' 名:');
define('ENTRY_FIRST_NAME_ERROR', '&nbsp;<span class="errorText">min ' . ENTRY_FIRST_NAME_MIN_LENGTH . ' chars</span>');
define('ENTRY_LAST_NAME', '姓:');
define('ENTRY_LAST_NAME_ERROR', '&nbsp;<span class="errorText">min ' . ENTRY_LAST_NAME_MIN_LENGTH . ' chars</span>');
define('ENTRY_DATE_OF_BIRTH', '出生日期:');
define('ENTRY_DATE_OF_BIRTH_ERROR', '&nbsp;<span class="errorText">(eg. 05/21/1970)</span>');
define('ENTRY_EMAIL_ADDRESS', 'E-Mail 地址:');
define('ENTRY_EMAIL_ADDRESS_ERROR', '&nbsp;<span class="errorText">min ' . ENTRY_EMAIL_ADDRESS_MIN_LENGTH . ' chars</span>');
define('ENTRY_EMAIL_ADDRESS_CHECK_ERROR', '&nbsp;<span class="errorText">The email address doesn\'t appear to be valid!</span>');
define('ENTRY_EMAIL_ADDRESS_ERROR_EXISTS', '&nbsp;<span class="errorText">This email address already exists!</span>');
define('ENTRY_COMPANY', '公司名称:');
define('ENTRY_STREET_ADDRESS', '街道地址:');
define('ENTRY_STREET_ADDRESS_ERROR', '&nbsp;<span class="errorText">min ' . ENTRY_STREET_ADDRESS_MIN_LENGTH . ' chars</span>');
define('ENTRY_SUBURB', '邻居:');
define('ENTRY_POST_CODE', '邮政编码:');
define('ENTRY_POST_CODE_ERROR', '&nbsp;<span class="errorText">min ' . ENTRY_POSTCODE_MIN_LENGTH . ' chars</span>');
define('ENTRY_CITY', '城市:');
define('ENTRY_CITY_ERROR', '&nbsp;<span class="errorText">min ' . ENTRY_CITY_MIN_LENGTH . ' chars</span>');
define('ENTRY_STATE', '省份:');
define('ENTRY_STATE_ERROR', '&nbsp;<span class="errorText">required</span>');
define('ENTRY_COUNTRY', '国家:');
define('ENTRY_COUNTRY_ERROR', 'You must select a country from the Countries pull down menu.');
define('ENTRY_TELEPHONE_NUMBER', '联系电话:');
define('ENTRY_TELEPHONE_NUMBER_ERROR', '&nbsp;<span class="errorText">min ' . ENTRY_TELEPHONE_MIN_LENGTH . ' chars</span>');
define('ENTRY_FAX_NUMBER', '传真:');
define('ENTRY_NEWSLETTER', 'Newsletter:');
define('ENTRY_NEWSLETTER_YES', '订阅');
define('ENTRY_NEWSLETTER_NO', '取消订阅');

// images
define('IMAGE_ANI_SEND_EMAIL', '发送邮件');
define('IMAGE_BACK', '后退');
define('IMAGE_BACKUP', '备份');
define('IMAGE_CANCEL', '取消');
define('IMAGE_CONFIRM', '确定');
define('IMAGE_COPY', '复制');
define('IMAGE_COPY_TO', '复制到');
define('IMAGE_DETAILS', '详细');
define('IMAGE_DELETE', '删除');
define('IMAGE_EDIT', '编辑');
define('IMAGE_EMAIL', '邮件');
define('IMAGE_EXPORT', '导出');
define('IMAGE_ICON_STATUS_GREEN', '激活');
define('IMAGE_ICON_STATUS_GREEN_LIGHT', 'Set Active');
define('IMAGE_ICON_STATUS_RED', 'Inactive');
define('IMAGE_ICON_STATUS_RED_LIGHT', 'Set Inactive');
define('IMAGE_ICON_INFO', '详细');
define('IMAGE_INSERT', '插入');
define('IMAGE_LOCK', '锁定');
define('IMAGE_MODULE_INSTALL', '安装模块');
define('IMAGE_MODULE_REMOVE', '移除模块');
define('IMAGE_MOVE', '移动');
define('IMAGE_NEW_BANNER', '新广告');
define('IMAGE_NEW_CATEGORY', '新目录');
define('IMAGE_NEW_COUNTRY', '新国家');
define('IMAGE_NEW_CURRENCY', '新货币');
define('IMAGE_NEW_FILE', '新文件');
define('IMAGE_NEW_FOLDER', '新文件夹');
define('IMAGE_NEW_LANGUAGE', '新语言');
define('IMAGE_NEW_NEWSLETTER', '新订阅');
define('IMAGE_NEW_PRODUCT', '新产品');
define('IMAGE_NEW_TAX_CLASS', '新税别');
define('IMAGE_NEW_TAX_RATE', '新税率');
define('IMAGE_NEW_TAX_ZONE', '新税区');
define('IMAGE_NEW_ZONE', '新地区');
define('IMAGE_ORDERS', '订单');
define('IMAGE_ORDERS_INVOICE', '发票');
define('IMAGE_ORDERS_PACKINGSLIP', '装箱单');
define('IMAGE_PREVIEW', '预览');
define('IMAGE_RESTORE', '恢复');
define('IMAGE_RESET', '重置');
define('IMAGE_SAVE', '保存');
define('IMAGE_SEARCH', '搜索');
define('IMAGE_SELECT', '选择');
define('IMAGE_SEND', '发送');
define('IMAGE_SEND_EMAIL', '发送邮件');
define('IMAGE_UNLOCK', '解锁');
define('IMAGE_UPDATE', '更新');
define('IMAGE_UPDATE_CURRENCIES', '更新汇率');
define('IMAGE_UPLOAD', '上传');

define('ICON_CROSS', '失败');
define('ICON_CURRENT_FOLDER', '当前目录');
define('ICON_DELETE', '删除');
define('ICON_ERROR', '错误');
define('ICON_FILE', '文件');
define('ICON_FILE_DOWNLOAD', '下载');
define('ICON_FOLDER', '文件夹');
define('ICON_LOCKED', '锁定');
define('ICON_PREVIOUS_LEVEL', '上一级');
define('ICON_PREVIEW', '下一级');
define('ICON_STATISTICS', '统计');
define('ICON_SUCCESS', '成功');
define('ICON_TICK', '是');
define('ICON_UNLOCKED', '解锁');
define('ICON_WARNING', '警告');

// constants for use in tep_prev_next_display function
define('TEXT_RESULT_PAGE', '第 %s 共 %d');
define('TEXT_DISPLAY_NUMBER_OF_BANNERS', '显示 <strong>%d</strong> 到 <strong>%d</strong> (共 <strong>%d</strong> 公告)');
define('TEXT_DISPLAY_NUMBER_OF_COUNTRIES', '显示 <strong>%d</strong> 到 <strong>%d</strong> (共 <strong>%d</strong> 国家)');
define('TEXT_DISPLAY_NUMBER_OF_CUSTOMERS', '显示 <strong>%d</strong> 到 <strong>%d</strong> (共 <strong>%d</strong> 客户)');
define('TEXT_DISPLAY_NUMBER_OF_CURRENCIES', '显示 <strong>%d</strong> 到 <strong>%d</strong> (共 <strong>%d</strong> 货币)');
define('TEXT_DISPLAY_NUMBER_OF_ENTRIES', '显示 <strong>%d</strong> 到 <strong>%d</strong> (共 <strong>%d</strong> 记录)');
define('TEXT_DISPLAY_NUMBER_OF_LANGUAGES', '显示 <strong>%d</strong> 到 <strong>%d</strong> (共 <strong>%d</strong> 语言)');
define('TEXT_DISPLAY_NUMBER_OF_MANUFACTURERS', '显示 <strong>%d</strong> 到 <strong>%d</strong> (共 <strong>%d</strong>品牌)');
define('TEXT_DISPLAY_NUMBER_OF_NEWSLETTERS', '显示 <strong>%d</strong> 到 <strong>%d</strong> (共 <strong>%d</strong> newsletters)');
define('TEXT_DISPLAY_NUMBER_OF_ORDERS', '显示 <strong>%d</strong> 到 <strong>%d</strong> (共 <strong>%d</strong> 订单)');
define('TEXT_DISPLAY_NUMBER_OF_ORDERS_STATUS', '显示 <strong>%d</strong> 到 <strong>%d</strong> (共 <strong>%d</strong> 订单状态)');
define('TEXT_DISPLAY_NUMBER_OF_PRODUCTS', '显示 <strong>%d</strong> 到 <strong>%d</strong> (共 <strong>%d</strong> 商品)');
define('TEXT_DISPLAY_NUMBER_OF_PRODUCTS_EXPECTED', '显示 <strong>%d</strong> 到 <strong>%d</strong> (共 <strong>%d</strong> 即将上架)');
define('TEXT_DISPLAY_NUMBER_OF_REVIEWS', '显示 <strong>%d</strong> 到 <strong>%d</strong> (共 <strong>%d</strong> 商品评论)');
define('TEXT_DISPLAY_NUMBER_OF_SPECIALS', '显示 <strong>%d</strong> 到 <strong>%d</strong> (共 <strong>%d</strong> 特价商品)');
define('TEXT_DISPLAY_NUMBER_OF_TAX_CLASSES', '显示 <strong>%d</strong> 到 <strong>%d</strong> (共 <strong>%d</strong> 税别)');
define('TEXT_DISPLAY_NUMBER_OF_TAX_ZONES', '显示 <strong>%d</strong> 到 <strong>%d</strong> (共 <strong>%d</strong> 税区)');
define('TEXT_DISPLAY_NUMBER_OF_TAX_RATES', '显示 <strong>%d</strong> 到 <strong>%d</strong> (共 <strong>%d</strong> 税率)');
define('TEXT_DISPLAY_NUMBER_OF_ZONES', '显示 <strong>%d</strong> 到 <strong>%d</strong> (共 <strong>%d</strong> 地区)');

define('PREVNEXT_BUTTON_PREV', '&lt;&lt;');
define('PREVNEXT_BUTTON_NEXT', '&gt;&gt;');

define('TEXT_DEFAULT', '默认');
define('TEXT_SET_DEFAULT', '设置为默认');
define('TEXT_FIELD_REQUIRED', '&nbsp;<span class="fieldRequired">* 必填</span>');

define('TEXT_CACHE_CATEGORIES', 'Categories Box');
define('TEXT_CACHE_MANUFACTURERS', 'Manufacturers Box');
define('TEXT_CACHE_ALSO_PURCHASED', 'Also Purchased Module');

define('TEXT_NONE', '--无--');
define('TEXT_TOP', '顶端');

define('ERROR_DESTINATION_DOES_NOT_EXIST', '错误: 目标不存在.');
define('ERROR_DESTINATION_NOT_WRITEABLE', '错误: 目标不可写.');
define('ERROR_FILE_NOT_SAVED', '错误: 文件上传但保存失败.');
define('ERROR_FILETYPE_NOT_ALLOWED', '错误: 不允许的文件类型.');
define('SUCCESS_FILE_SAVED_SUCCESSFULLY', '成功: 文件成功上传.');
define('WARNING_NO_FILE_UPLOADED', '警告:没有新文件上传.');
?>
