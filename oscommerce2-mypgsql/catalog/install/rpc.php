<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2008 osCommerce

  Released under the GNU General Public License
*/

  header('Cache-Control: no-cache, must-revalidate');
  header('Expires: Mon, 26 Jul 1997 05:00:00 GMT');

  require('includes/application.php');

  $dir_fs_www_root = dirname(__FILE__);

  if (isset($HTTP_GET_VARS['action']) && !empty($HTTP_GET_VARS['action'])) {
    switch ($HTTP_GET_VARS['action']) {
      case 'dbCheck':
        $db = array('DB_SERVER' => trim(rawurldecode($HTTP_GET_VARS['server'])),
                    'DB_SERVER_USERNAME' => trim(rawurldecode($HTTP_GET_VARS['username'])),
                    'DB_SERVER_PASSWORD' => trim(rawurldecode($HTTP_GET_VARS['password'])),
                    'DB_DATABASE' => trim(rawurldecode($HTTP_GET_VARS['name'])),
                    'DB_TYPE' => trim(rawurldecode($HTTP_GET_VARS['dbType'])),
                    'DB_PORT' => trim(rawurldecode($HTTP_GET_VARS['dbPort']))
                   );

        $db_error = false;
        osc_db_connect($db['DB_SERVER'], $db['DB_SERVER_USERNAME'], $db['DB_SERVER_PASSWORD'], $db['DB_DATABASE'], $db['DB_TYPE'], $db['DB_PORT']);

        if($db['DB_TYPE'] == "mysql") {
          if($db_error == false) {
            if (!@osc_db_select_db($db['DB_DATABASE'])) {
              $db_error = mysql_error();
            }
          }
        } else if($db['DB_TYPE'] == "pgsql") {
          if($db_error == false) {
            $db_error = "Failed to connect to your PostgreSQL database server.";
          } else {
            $db_error = false;
          }
        }

        if ($db_error != false) {
          echo '[[0|' . $db_error . ']]';
        } else {
          echo '[[1]]';
        }

        exit;
        break;

      case 'dbImport':
        $db = array('DB_SERVER' => trim(rawurldecode($HTTP_GET_VARS['server'])),
                    'DB_SERVER_USERNAME' => trim(rawurldecode($HTTP_GET_VARS['username'])),
                    'DB_SERVER_PASSWORD' => trim(rawurldecode($HTTP_GET_VARS['password'])),
                    'DB_DATABASE' => trim(rawurldecode($HTTP_GET_VARS['name'])),
                    'DB_TYPE' => trim(rawurldecode($HTTP_GET_VARS['dbType'])),
                    'DB_PORT' => trim(rawurldecode($HTTP_GET_VARS['dbPort']))
                   );

        osc_db_connect($db['DB_SERVER'], $db['DB_SERVER_USERNAME'], $db['DB_SERVER_PASSWORD'], $db['DB_DATABASE'], $db['DB_TYPE'], $db['DB_PORT']);

        $db_error = false;
        if($db['DB_TYPE'] == "mysql") {
          $sql_file = $dir_fs_www_root . '/oscommerce-mysql.sql';
        } else if($db['DB_TYPE'] == "pgsql") {
          $sql_file = $dir_fs_www_root . '/oscommerce-pgsql.sql';
        }

        osc_set_time_limit(0);
        osc_db_install($db['DB_DATABASE'], $sql_file, $db['DB_TYPE']);

        if ($db_error != false) {
          echo '[[0|' . $db_error . ']]';
        } else {
          echo '[[1]]';
        }

        exit;
        break;
    }
  }

  echo '[[-100|noActionError]]';
?>
