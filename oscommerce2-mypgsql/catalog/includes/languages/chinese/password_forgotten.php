<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2003 osCommerce

  Released under the GNU General Public License
*/
define('NAVBAR_TITLE_1', '登录');
define('NAVBAR_TITLE_2', '忘记密码');
define('HEADING_TITLE', '我忘记密码了！');
/*
define('ENTRY_EMAIL_ADDRESS', '电子邮件：');
*/
define('TEXT_MAIN', '您如果忘了密码，请输入您的电子邮件地址，我们会把您的新密码用电子邮件寄给您。');


define('TEXT_NO_EMAIL_ADDRESS_FOUND', '错误：这个电子邮件地址没有在我们这里注册，请再试一次。');
define('EMAIL_PASSWORD_REMINDER_SUBJECT', STORE_NAME . ' - 新密码');
define('EMAIL_PASSWORD_REMINDER_BODY', '您从' . $REMOTE_ADDR . '要求补发新密码。' . "\n\n" . '您在\'' . STORE_NAME . '\' 的新密码是：' . "\n\n" . '   %s' . "\n\n");
define('SUCCESS_PASSWORD_SENT', '新的密码已经寄到您的电子邮件地址');
?>