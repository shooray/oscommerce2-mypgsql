<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2009 osCommerce

  Released under the GNU General Public License
*/

define('HEADING_TITLE', '管理员设置');

define('TABLE_HEADING_ADMINISTRATORS', '管理员');
define('TABLE_HEADING_HTPASSWD', '服务器目录保护');
define('TABLE_HEADING_ACTION', '操作');

define('TEXT_INFO_INSERT_INTRO', '创建新的管理员');
define('TEXT_INFO_EDIT_INTRO', '请做必要的修改');
define('TEXT_INFO_DELETE_INTRO', 'Are you sure you want to delete this administrator?');
define('TEXT_INFO_HEADING_NEW_ADMINISTRATOR', '新管理员');
define('TEXT_INFO_USERNAME', '用户名:');
define('TEXT_INFO_NEW_PASSWORD', '新密码:');
define('TEXT_INFO_PASSWORD', '密码:');
define('TEXT_INFO_PROTECT_WITH_HTPASSWD', '启用服务器目录保护');

define('ERROR_ADMINISTRATOR_EXISTS', '错误: 管理员已经存在.');

define('HTPASSWD_INFO', '<strong>Additional Protection With htaccess/htpasswd</strong><p>This osCommerce Online Merchant Administration Tool installation is not additionally secured through htaccess/htpasswd means.</p><p>Enabling the htaccess/htpasswd security layer will automatically store administrator username and passwords in a htpasswd file when updating administrator password records.</p><p><strong>Please note</strong>, if this additional security layer is enabled and you can no longer access the Administration Tool, please make the following changes and consult your hosting provider to enable htaccess/htpasswd protection:</p><p><u><strong>1. Edit this file:</strong></u><br /><br />' . DIR_FS_ADMIN . '.htaccess</p><p>Remove the following lines if they exist:</p><p><i>%s</i></p><p><u><strong>2. Delete this file:</strong></u><br /><br />' . DIR_FS_ADMIN . '.htpasswd_oscommerce</p>');
define('HTPASSWD_SECURED', '<strong>Additional Protection With htaccess/htpasswd</strong><p>This osCommerce Online Merchant Administration Tool installation is additionally secured through htaccess/htpasswd means.</p>');
define('HTPASSWD_PERMISSIONS', '<strong>Additional Protection With htaccess/htpasswd</strong><p>This osCommerce Online Merchant Administration Tool installation is not additionally secured through htaccess/htpasswd means.</p><p>The following files need to be writable by the web server to enable the htaccess/htpasswd security layer:</p><ul><li>' . DIR_FS_ADMIN . '.htaccess</li><li>' . DIR_FS_ADMIN . '.htpasswd_oscommerce</li></ul><p>Reload this page to confirm if the correct file permissions have been set.</p>');
?>
