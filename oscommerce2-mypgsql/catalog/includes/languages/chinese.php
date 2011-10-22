<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2007 osCommerce

  Released under the GNU General Public License
*/

// look in your $PATH_LOCALE/locale directory for available locales
// or type locale -a on the server.
// Examples:
// on RedHat try 'en_US'
// on FreeBSD try 'en_US.ISO_8859-1'
// on Windows try 'en', or 'English'
@setlocale(LC_TIME, 'en_US.ISO_8859-1');

define('DATE_FORMAT_SHORT', '%m/%d%/%Y');  // this is used for strftime()
//define('DATE_FORMAT_LONG', '%Y年%m月%d日'); // this is used for strftime()
define('DATE_FORMAT_LONG', '%Y-%m-%d'); // this is used for strftime()
define('DATE_FORMAT', 'm/d/Y'); // this is used for date()
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

// if USE_DEFAULT_LANGUAGE_CURRENCY is true, use the following currency, instead of the applications default currency (used when changing language)
define('LANGUAGE_CURRENCY', 'CNY');

// Global entries for the <html> tag
define('HTML_PARAMS', 'dir="ltr" lang="zh-CN"');

// charset for web pages and emails
define('CHARSET', 'utf-8');

// page title
define('TITLE', STORE_NAME);

// header text in includes/header.php
define('HEADER_TITLE_CREATE_ACCOUNT', '开设帐号');
define('HEADER_TITLE_MY_ACCOUNT', '我的帐号');
define('HEADER_TITLE_CART_CONTENTS', '购物车');
define('HEADER_TITLE_CHECKOUT', '结帐');
define('HEADER_TITLE_CONTACT_US', '联络我们');
define('HEADER_TITLE_TOP', '首页');
define('HEADER_TITLE_CATALOG', '商品目录');
define('HEADER_TITLE_LOGOFF', '退出');
define('HEADER_TITLE_LOGIN', '登录');

// footer text in includes/footer.php
define('FOOTER_TEXT_REQUESTS_SINCE', '次浏览，自从');

// text for gender
define('MALE', '男');
define('FEMALE', '女');
define('MALE_ADDRESS', '先生');
define('FEMALE_ADDRESS', '小姐');

// text for date of birth example
define('DOB_FORMAT_STRING', 'mm/dd/yyyy');

// checkout procedure text
define('CHECKOUT_BAR_DELIVERY', '送货资料');
define('CHECKOUT_BAR_PAYMENT', '付款资料');
define('CHECKOUT_BAR_CONFIRMATION', '确认');
define('CHECKOUT_BAR_FINISHED', '完成！');

// pull down default text
define('PULL_DOWN_DEFAULT', '请选择');
define('TYPE_BELOW', '写在下方');

// javascript messages
define('JS_ERROR', '您的表格在处理中发现错误.\n\n请作以下修改:\n\n');

define('JS_REVIEW_TEXT', '* 你的评论最少要 ' . REVIEW_TEXT_MIN_LENGTH . ' 个字。\n');
define('JS_REVIEW_RATING', '* 你必须给这个商品打分。\n');

define('JS_ERROR_NO_PAYMENT_MODULE_SELECTED', '* 请选一种付款方式。\n');
define('JS_ERROR_SUBMITTED', '这个表格已送出，请按 Ok 后等待处理。');

define('ERROR_NO_PAYMENT_MODULE_SELECTED', '请选一种付款方式。');

define('CATEGORY_COMPANY', '公司资料');
define('CATEGORY_PERSONAL', '个人资料');
define('CATEGORY_ADDRESS', '你的地址');
define('CATEGORY_CONTACT', '联络方式');
define('CATEGORY_OPTIONS', '选项');
define('CATEGORY_PASSWORD', '你的密码');
define('ENTRY_COMPANY', '公司名称：');
define('ENTRY_COMPANY_ERROR', '');
define('ENTRY_COMPANY_TEXT', '');
define('ENTRY_GENDER', '性别：');
define('ENTRY_GENDER_ERROR', '请选择您的性别。');
define('ENTRY_GENDER_TEXT', '*');
define('ENTRY_FIRST_NAME', '名：');
define('ENTRY_FIRST_NAME_ERROR', '您的名字不能少于 ' . ENTRY_FIRST_NAME_MIN_LENGTH . '  个字');
define('ENTRY_FIRST_NAME_TEXT', '*');
define('ENTRY_LAST_NAME', '姓：');
define('ENTRY_LAST_NAME_ERROR', '您的姓不能少于 ' . ENTRY_LAST_NAME_MIN_LENGTH . '个字');
define('ENTRY_LAST_NAME_TEXT', '*');
define('ENTRY_DATE_OF_BIRTH', '生日：');
define('ENTRY_DATE_OF_BIRTH_ERROR', '您的出生日期必须是以下格式：月/日/年 (例如：05/21/1970)');
define('ENTRY_DATE_OF_BIRTH_TEXT', '*(例：05/21/1970)');
define('ENTRY_EMAIL_ADDRESS', '电子邮件：');
define('ENTRY_EMAIL_ADDRESS_ERROR', '您的电子邮件地址不能少于 ' . ENTRY_EMAIL_ADDRESS_MIN_LENGTH . ' 个字');
define('ENTRY_EMAIL_ADDRESS_CHECK_ERROR', '您的电子邮件地址不对 - 请坐必要修改。');
define('ENTRY_EMAIL_ADDRESS_ERROR_EXISTS', '这个电子邮件地址已经注册过 - 请用该地址登录或用别的地址重新注册。');
define('ENTRY_EMAIL_ADDRESS_TEXT', '*');
define('ENTRY_STREET_ADDRESS', '街道门牌号码：');
define('ENTRY_STREET_ADDRESS_ERROR', '街道门牌号码不能少于 ' . ENTRY_STREET_ADDRESS_MIN_LENGTH . ' 个字');
define('ENTRY_STREET_ADDRESS_TEXT', '*');
define('ENTRY_SUBURB', '县（区）：');
define('ENTRY_SUBURB_ERROR', '');
define('ENTRY_SUBURB_TEXT', '');
define('ENTRY_POST_CODE', '邮政编码：');
define('ENTRY_POST_CODE_ERROR', '邮政编码不能少于 ' . ENTRY_POSTCODE_MIN_LENGTH . ' 个字');
define('ENTRY_POST_CODE_TEXT', '*');
define('ENTRY_CITY', '市（县）：');
define('ENTRY_CITY_ERROR', '市（县）名称不能少于 ' . ENTRY_CITY_MIN_LENGTH . ' 个字');
define('ENTRY_CITY_TEXT', '*');
define('ENTRY_STATE', '省份：');
define('ENTRY_STATE_ERROR', '省份不能少于 ' . ENTRY_STATE_MIN_LENGTH . ' 个字');
define('ENTRY_STATE_ERROR_SELECT', '请从下拉菜单中选择一个省份。');
define('ENTRY_STATE_TEXT', '*');
define('ENTRY_COUNTRY', '国家：');
define('ENTRY_COUNTRY_ERROR', '您必须从下拉菜单中选择一个国家。');
define('ENTRY_COUNTRY_TEXT', '*');
define('ENTRY_TELEPHONE_NUMBER', '电话：');
define('ENTRY_TELEPHONE_NUMBER_ERROR', '您的电话号码不能少于 ' . ENTRY_TELEPHONE_MIN_LENGTH . ' 位数');
define('ENTRY_TELEPHONE_NUMBER_TEXT', '*');
define('ENTRY_FAX_NUMBER', '传真：');
define('ENTRY_FAX_NUMBER_ERROR', '');
define('ENTRY_FAX_NUMBER_TEXT', '');
define('ENTRY_NEWSLETTER', '电子新闻：');
define('ENTRY_NEWSLETTER_TEXT', '');
define('ENTRY_NEWSLETTER_YES', '-订阅-');
define('ENTRY_NEWSLETTER_NO', '-不订阅-');
define('ENTRY_NEWSLETTER_ERROR', '');
define('ENTRY_PASSWORD', '密码：');
define('ENTRY_PASSWORD_ERROR', '密码不能少于 ' . ENTRY_PASSWORD_MIN_LENGTH . ' 个字');
define('ENTRY_PASSWORD_TEXT', '*');
define('ENTRY_PASSWORD_ERROR_NOT_MATCHING', '密码确认栏的内容必须与密码栏相同。');
define('ENTRY_PASSWORD_CONFIRMATION', '密码确认：');
define('ENTRY_PASSWORD_CONFIRMATION_TEXT', '*');
define('ENTRY_PASSWORD_CURRENT', '当前密码：');
define('ENTRY_PASSWORD_CURRENT_TEXT', '*');
define('ENTRY_PASSWORD_NEW', '新密码：');
define('ENTRY_PASSWORD_NEW_TEXT', '*');
define('ENTRY_PASSWORD_NEW_ERROR', '新密码不能少于 ' . ENTRY_PASSWORD_MIN_LENGTH . ' 个字');
define('ENTRY_PASSWORD_NEW_ERROR_NOT_MATCHING', '密码确认栏的内容必须与新密码相同。');
define('PASSWORD_HIDDEN', '--隐藏--');

define('FORM_REQUIRED_INFORMATION', '* 必须提供的资料');

// constants for use in tep_prev_next_display function
define('TEXT_RESULT_PAGE', '页数：');
define('TEXT_DISPLAY_NUMBER_OF_PRODUCTS', '显示 <b>%d</b> 到 <b>%d</b> (共 <b>%d</b> 个商品)');
define('TEXT_DISPLAY_NUMBER_OF_ORDERS', '显示 <b>%d</b> 到 <b>%d</b> (共 <b>%d</b> 笔订单)');
define('TEXT_DISPLAY_NUMBER_OF_REVIEWS', '显示 <b>%d</b> 到 <b>%d</b>( 共 <b>%d</b> 个评论)');
define('TEXT_DISPLAY_NUMBER_OF_PRODUCTS_NEW', '显示 <b>%d</b> 到 <b>%d</b> (共 <b>%d</b> 个新商品)');
define('TEXT_DISPLAY_NUMBER_OF_SPECIALS', '显示 <b>%d</b> 到 <b>%d</b> (共 <b>%d</b> 个特价商品)');

define('PREVNEXT_TITLE_FIRST_PAGE', '第一页');
define('PREVNEXT_TITLE_PREVIOUS_PAGE', '前一页');
define('PREVNEXT_TITLE_NEXT_PAGE', '下一页');
define('PREVNEXT_TITLE_LAST_PAGE', '最后一页');
define('PREVNEXT_TITLE_PAGE_NO', '第 %d 页');
define('PREVNEXT_TITLE_PREV_SET_OF_NO_PAGE', '前 %d 页');
define('PREVNEXT_TITLE_NEXT_SET_OF_NO_PAGE', '后 %d 页');
define('PREVNEXT_BUTTON_FIRST', '<<最前面');
define('PREVNEXT_BUTTON_PREV', '[<<&nbsp;往前]');
define('PREVNEXT_BUTTON_NEXT', '[往后&nbsp;>>]');
define('PREVNEXT_BUTTON_LAST', '最后面>>');

define('IMAGE_BUTTON_ADD_ADDRESS', '新地址');
define('IMAGE_BUTTON_ADDRESS_BOOK', '通讯录');
define('IMAGE_BUTTON_BACK', '返回');
define('IMAGE_BUTTON_BUY_NOW', '立即购买');
define('IMAGE_BUTTON_CHANGE_ADDRESS', '变更地址');
define('IMAGE_BUTTON_CHECKOUT', '结帐');
define('IMAGE_BUTTON_CONFIRM_ORDER', '确认订单');
define('IMAGE_BUTTON_CONTINUE', '继续');
define('IMAGE_BUTTON_CONTINUE_SHOPPING', '继续购物');
define('IMAGE_BUTTON_DELETE', '删除');
define('IMAGE_BUTTON_EDIT_ACCOUNT', '修改帐号');
define('IMAGE_BUTTON_HISTORY', '订单记录');
define('IMAGE_BUTTON_LOGIN', '登录');
define('IMAGE_BUTTON_IN_CART', '加入购物车');
define('IMAGE_BUTTON_NOTIFICATIONS', '通知');
define('IMAGE_BUTTON_QUICK_FIND', '快速搜寻');
define('IMAGE_BUTTON_REMOVE_NOTIFICATIONS', '不必通知我');
define('IMAGE_BUTTON_REVIEWS', '评论');
define('IMAGE_BUTTON_SEARCH', '搜寻');
define('IMAGE_BUTTON_SHIPPING_OPTIONS', '送货选项');
define('IMAGE_BUTTON_TELL_A_FRIEND', '告诉朋友');
define('IMAGE_BUTTON_UPDATE', '更新');
define('IMAGE_BUTTON_UPDATE_CART', '更新购物车');
define('IMAGE_BUTTON_WRITE_REVIEW', '发表评论');

define('SMALL_IMAGE_BUTTON_DELETE', '删除');
define('SMALL_IMAGE_BUTTON_EDIT', '修改');
define('SMALL_IMAGE_BUTTON_VIEW', '查看');


define('ICON_ARROW_RIGHT', '更多');
define('ICON_CART', '购物车内容');
define('ICON_ERROR', '错误');
define('ICON_SUCCESS', '成功');
define('ICON_WARNING', '警告');

define('TEXT_GREETING_PERSONAL', '<span class="greetUser">%s，</span>想看看有什么<a href="%s"><u>新到商品</u></a>吗？');
define('TEXT_GREETING_PERSONAL_RELOGON', '您如果不是%s, 请用自己的帐号<a href="%s"><u>登录</u></a>。');
define('TEXT_GREETING_GUEST', '如果您已经是会员，请直接<a href="%s"><u>登录</u></a>。 如果不是，您希望<a href="%s"><u>注册为会员</u></a>吗？');

define('TEXT_SORT_PRODUCTS', '商品排序：');
define('TEXT_DESCENDINGLY', '递减，');
define('TEXT_ASCENDINGLY', '递增，');
define('TEXT_BY', '按照：');

define('TEXT_REVIEW_BY', '评论人：%s');
define('TEXT_REVIEW_WORD_COUNT', '%s 个字');
define('TEXT_REVIEW_RATING', '评分：%s [%s]');
define('TEXT_REVIEW_DATE_ADDED', '评论日期: %s');
define('TEXT_NO_REVIEWS', '目前没有商品评论。');

define('TEXT_NO_NEW_PRODUCTS', '目前没有新进商品.');

define('TEXT_UNKNOWN_TAX_RATE', '不明税率');
define('TEXT_REQUIRED', '<span class="errorTEXT">必须填</span>');
define('ERROR_TEP_MAIL', '<font face="Verdana, Arial" size="2" color="#ff0000"><b><small>错误：</small> 无法由指定的SMTP服务器传送邮件，请检查 php.ini 中的设置并作必要修改。</b></font>');
define('WARNING_DOWNLOAD_DIRECTORY_NON_EXISTENT', '警告： 可下载商品的目录不存在： ' . DIR_FS_DOWNLOAD . '. 在这个目录未建立之前，无法下载商品。');
define('TEXT_CCVAL_ERROR_INVALID_DATE', '输入的信用卡有效日期无效。<br>请核对后再试。');
define('TEXT_CCVAL_ERROR_INVALID_NUMBER', '输入的信用卡号无效。<br>请核对后再试。');
define('TEXT_CCVAL_ERROR_UNKNOWN_CARD', '输入的信用卡号头四位数为： %s<br>如果卡号无误，我们不接受此种信用卡。<br>如果有误，请再试一遍。');
define('FOOTER_TEXT_BODY', '版权所有 &copy; ' . date('Y') . ' <a href="' . tep_href_link(FILENAME_DEFAULT) . '">' . STORE_NAME . '</a><br />Powered by <a href="http://www.oscommerce.com" target="_blank">www.osCommerce.com.cn</a>');
?>