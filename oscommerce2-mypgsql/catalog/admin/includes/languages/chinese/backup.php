<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2002 osCommerce

  Released under the GNU General Public License
*/

define('HEADING_TITLE', '数据库备份管理器');

define('TABLE_HEADING_TITLE', '备份文件名');
define('TABLE_HEADING_FILE_DATE', '日期');
define('TABLE_HEADING_FILE_SIZE', '大小');
define('TABLE_HEADING_ACTION', '操作');

define('TEXT_INFO_HEADING_NEW_BACKUP', '创建新备份');
define('TEXT_INFO_HEADING_RESTORE_LOCAL', '从本地回复');
define('TEXT_INFO_NEW_BACKUP', '不要中断备份进程 这将需要一些时间.');
define('TEXT_INFO_UNPACK', '<br /><br />(after unpacking the file from the archive)');
define('TEXT_INFO_RESTORE', '不要中断恢复进程.<br /><br />备份文件越大所需的时间！越长<br /><br />如果服务器允许尽量使用Mysql远程命令实现回复.<br /><br />如:<br /><br /><strong>mysql -h' . DB_SERVER . ' -u' . DB_SERVER_USERNAME . ' -p ' . DB_DATABASE . ' < %s </strong> %s');
define('TEXT_INFO_RESTORE_LOCAL', '不要中断恢复进程.<br /><br />备份文件越大所需的时间越长！');
define('TEXT_INFO_RESTORE_LOCAL_RAW_FILE', '错误的SQL文件格式.');
define('TEXT_INFO_DATE', '日期:');
define('TEXT_INFO_SIZE', '尺寸:');
define('TEXT_INFO_COMPRESSION', '压缩:');
define('TEXT_INFO_USE_GZIP', '使用 GZIP');
define('TEXT_INFO_USE_ZIP', '使用 ZIP');
define('TEXT_INFO_USE_NO_COMPRESSION', '不压缩 (纯 SQL)');
define('TEXT_INFO_DOWNLOAD_ONLY', '仅下载 (不在服务器端存储)');
define('TEXT_INFO_BEST_THROUGH_HTTPS', '最好通过SSL连接下载');
define('TEXT_DELETE_INTRO', '您确认要删除该备份吗?');
define('TEXT_NO_EXTENSION', '无');
define('TEXT_BACKUP_DIRECTORY', '备份目录:');
define('TEXT_LAST_RESTORATION', '最后恢复:');
define('TEXT_FORGET', '(<u>忘记</u>)');

define('ERROR_BACKUP_DIRECTORY_DOES_NOT_EXIST', '错误: 备份目录不存在. 请再配置文件configure.php中设置.');
define('ERROR_BACKUP_DIRECTORY_NOT_WRITEABLE', '错误: 备份目录不可写.请设置适当的权限');
define('ERROR_DOWNLOAD_LINK_NOT_ACCEPTABLE', '错误: 下载连接不被接受.');

define('SUCCESS_LAST_RESTORE_CLEARED', '成功: 最后恢复日期被重置.');
define('SUCCESS_DATABASE_SAVED', '成功: 数据库已保存.');
define('SUCCESS_DATABASE_RESTORED', '成功: 数据库已恢复.');
define('SUCCESS_BACKUP_DELETED', '成功: 备份已删除.');
?>
