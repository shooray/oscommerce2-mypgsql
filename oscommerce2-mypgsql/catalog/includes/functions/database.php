<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2007 osCommerce

  Released under the GNU General Public License
*/

  function tep_db_connect($server = DB_SERVER, $username = DB_SERVER_USERNAME, $password = DB_SERVER_PASSWORD, $database = DB_DATABASE, $dbType = DB_TYPE, $dbPort = DB_PORT, $link = 'db_link') {
    global $$link;

    if (USE_PCONNECT == 'true') {
      if($dbType == 'mysql') {
        $$link = mysql_pconnect($server.":".$dbPort, $username, $password);
        if ($$link) mysql_select_db($database);
      } else if ($dbType == 'pgsql') {
        $$link = pg_pconnect("host=".$server." port=".$dbPort." dbname=".$database." user=".$username." password=".$password);
      }
    } else {
      if($dbType == 'mysql') {
        $$link = mysql_connect($server.":".$dbPort, $username, $password);
        if ($$link) mysql_select_db($database);
      } else if ($dbType == 'pgsql') {
        $$link = pg_connect("host=".$server." port=".$dbPort." dbname=".$database." user=".$username." password=".$password);
      }
    }

    return $$link;
  }

  function tep_db_close($link = 'db_link') {
    global $$link;

    if(DB_TYPE == 'mysql') {
      return mysql_close($$link);
    } else if(DB_TYPE == 'pgsql') {
      return pg_close($$link);
    }
  }

  function tep_db_error($query, $errno, $error) { 
    die('<font color="#000000"><strong>' . $errno . ' - ' . $error . '<br /><br />' . $query . '<br /><br /><small><font color="#ff0000">[TEP STOP]</font></small><br /><br /></strong></font>');
  }

  function tep_db_query($query, $link = 'db_link') {
    global $$link;

    if (defined('STORE_DB_TRANSACTIONS') && (STORE_DB_TRANSACTIONS == 'true')) {
      error_log('QUERY ' . $query . "\n", 3, STORE_PAGE_PARSE_TIME_LOG);
    }

    //echo "<pre>".$query."</pre>";
    if(DB_TYPE == 'mysql') {
      $result = mysql_query($query, $$link) or tep_db_error($query, mysql_errno(), mysql_error());
    } else if(DB_TYPE == 'pgsql') {
      $result = pg_query($$link, $query) or tep_db_error($query, 'error no', pg_last_error());
    }

    if (defined('STORE_DB_TRANSACTIONS') && (STORE_DB_TRANSACTIONS == 'true')) {
       $result_error = mysql_error();
       error_log('RESULT ' . $result . ' ' . $result_error . "\n", 3, STORE_PAGE_PARSE_TIME_LOG);
    }

    return $result;
  }

  function tep_db_perform($table, $data, $action = 'insert', $parameters = '', $link = 'db_link') {
    reset($data);
    if ($action == 'insert') {
      $query = 'insert into ' . $table . ' (';
      while (list($columns, ) = each($data)) {
        $query .= $columns . ', ';
      }
      $query = substr($query, 0, -2) . ') values (';
      reset($data);
      while (list(, $value) = each($data)) {
        switch ((string)$value) {
          case 'now()':
            $query .= 'now(), ';
            break;
          case 'null':
            $query .= 'null, ';
            break;
          default:
            $query .= '\'' . tep_db_input($value) . '\', ';
            break;
        }
      }
      $query = substr($query, 0, -2) . ')';
    } elseif ($action == 'update') {
      $query = 'update ' . $table . ' set ';
      while (list($columns, $value) = each($data)) {
        switch ((string)$value) {
          case 'now()':
            $query .= $columns . ' = now(), ';
            break;
          case 'null':
            $query .= $columns .= ' = null, ';
            break;
          default:
            $query .= $columns . ' = \'' . tep_db_input($value) . '\', ';
            break;
        }
      }
      $query = substr($query, 0, -2) . ' where ' . $parameters;
    }

    return tep_db_query($query, $link);
  }

  function tep_db_fetch_array($db_query) {
    if(DB_TYPE == 'mysql') {
      return mysql_fetch_array($db_query, MYSQL_ASSOC);
    } else if(DB_TYPE == 'pgsql') {
      return pg_fetch_array($db_query, NULL, PGSQL_ASSOC);
    }
  }

  function tep_db_num_rows($db_query) {
    if(DB_TYPE == "mysql") {
      return mysql_num_rows($db_query);
    } else if(DB_TYPE == "pgsql") {
      return pg_num_rows($db_query);
    }
  }

  function tep_db_data_seek($db_query, $row_number) {
    if(DB_TYPE == 'mysql') {
      return mysql_data_seek($db_query, $row_number);
    } else if(DB_TYPE == 'pgsql') {
      return pg_result_seek($db_query, $row_number);
    }
  }

  function tep_db_insert_id($link = 'db_link') {
    global $$link;

    if (DB_TYPE == 'mysql') {
      return mysql_insert_id($$link);
    } elseif (DB_TYPE == 'pgsql') {
      $insert_id_query = pg_query("select lastval();");
      $insert_id_row = pg_fetch_row($insert_id_query);
      return $insert_id_row[0];
    }
  }

  function tep_db_free_result($db_query) {
    if (DB_TYPE == 'mysql') {
      return mysql_free_result($db_query);
    } elseif (DB_TYPE == 'pgsql') {
      return pg_free_result($db_query);
    }
  }

  //no use
  function tep_db_fetch_fields($db_query) {
    return mysql_fetch_field($db_query);
  }

  function tep_db_output($string) {
    return htmlspecialchars($string);
  }

  function tep_db_input($string, $link = 'db_link') {
    global $$link;

    if(DB_TYPE == 'mysql') {
      if (function_exists('mysql_real_escape_string')) {
        return mysql_real_escape_string($string, $$link);
      } elseif (function_exists('mysql_escape_string')) {
        return mysql_escape_string($string);
      }
    } else if(DB_TYPE == 'pgsql') {
      if(function_exists('pg_escape_string ')) {
        return pg_escape_string($string);
      }
    }

    return addslashes($string);
  }

  function tep_db_prepare_input($string) {
    if (is_string($string)) {
      return trim(tep_sanitize_string(stripslashes($string)));
    } elseif (is_array($string)) {
      reset($string);
      while (list($key, $value) = each($string)) {
        $string[$key] = tep_db_prepare_input($value);
      }
      return $string;
    } else {
      return $string;
    }
  }
?>