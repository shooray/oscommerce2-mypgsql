<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2002 osCommerce

  Released under the GNU General Public License
*/

define('HEADING_TITLE', '分类 / 商品');
define('HEADING_TITLE_SEARCH', '搜索:');
define('HEADING_TITLE_GOTO', '转到:');

define('TABLE_HEADING_ID', '编号ID');
define('TABLE_HEADING_CATEGORIES_PRODUCTS', '分类 / 商品');
define('TABLE_HEADING_ACTION', '操作');
define('TABLE_HEADING_STATUS', '状态');

define('TEXT_NEW_PRODUCT', '新加产品在 &quot;%s&quot;');
define('TEXT_CATEGORIES', '分类:');
define('TEXT_SUBCATEGORIES', '子分类:');
define('TEXT_PRODUCTS', '商品:');
define('TEXT_PRODUCTS_PRICE_INFO', '价格:');
define('TEXT_PRODUCTS_TAX_CLASS', '税别:');
define('TEXT_PRODUCTS_AVERAGE_RATING', '评价等级:');
define('TEXT_PRODUCTS_QUANTITY_INFO', '数量:');
define('TEXT_DATE_ADDED', '添加日期:');
define('TEXT_DATE_AVAILABLE', '有效期:');
define('TEXT_LAST_MODIFIED', '最后修改:');
define('TEXT_IMAGE_NONEXISTENT', '图片不存在');
define('TEXT_NO_CHILD_CATEGORIES_OR_PRODUCTS', '在当前位置添加新分类或添加新商品.');
define('TEXT_PRODUCT_MORE_INFORMATION', '更多详细请访问 <a href="http://%s" target="blank"><u>网页</u></a>.');
define('TEXT_PRODUCT_DATE_ADDED', '该商品于 %s 添加.');
define('TEXT_PRODUCT_DATE_AVAILABLE', '该商品将于 %s 到货.');

define('TEXT_EDIT_INTRO', '请做必要的修改');
define('TEXT_EDIT_CATEGORIES_ID', '分类ID:');
define('TEXT_EDIT_CATEGORIES_NAME', '分类名:');
define('TEXT_EDIT_CATEGORIES_IMAGE', '分类图片:');
define('TEXT_EDIT_SORT_ORDER', '排序:');

define('TEXT_INFO_COPY_TO_INTRO', '请选择该商品要复制到的目标分类');
define('TEXT_INFO_CURRENT_CATEGORIES', '当前分类:');

define('TEXT_INFO_HEADING_NEW_CATEGORY', '新分类');
define('TEXT_INFO_HEADING_EDIT_CATEGORY', '编辑分类');
define('TEXT_INFO_HEADING_DELETE_CATEGORY', '删除分类');
define('TEXT_INFO_HEADING_MOVE_CATEGORY', '移动分类');
define('TEXT_INFO_HEADING_DELETE_PRODUCT', '删除商品');
define('TEXT_INFO_HEADING_MOVE_PRODUCT', '移动商品');
define('TEXT_INFO_HEADING_COPY_TO', '复制到');

define('TEXT_DELETE_CATEGORY_INTRO', '您确认要删除该分类?');
define('TEXT_DELETE_PRODUCT_INTRO', '您确认要永久删除该商品?');

define('TEXT_DELETE_WARNING_CHILDS', '<strong>警告:</strong> 当前有 %s 个子分类连接到该分类!');
define('TEXT_DELETE_WARNING_PRODUCTS', '<strong>警告:</strong> 当前有 %s 商品连接到该分类!');

define('TEXT_MOVE_PRODUCTS_INTRO', '选择 <strong>%s</strong> 要移动到的分类');
define('TEXT_MOVE_CATEGORIES_INTRO', '选择 <strong>%s</strong> 要移动到的分类');
define('TEXT_MOVE', '移动 <strong>%s</strong> 到:');

define('TEXT_NEW_CATEGORY_INTRO', '填写新分类信息');
define('TEXT_CATEGORIES_NAME', '分类名成:');
define('TEXT_CATEGORIES_IMAGE', '分类图片:');
define('TEXT_SORT_ORDER', '排序:');

define('TEXT_PRODUCTS_STATUS', '商品状态:');
define('TEXT_PRODUCTS_DATE_AVAILABLE', '有效期:');
define('TEXT_PRODUCT_AVAILABLE', '有库存');
define('TEXT_PRODUCT_NOT_AVAILABLE', '缺货');
define('TEXT_PRODUCTS_MANUFACTURER', '品牌:');
define('TEXT_PRODUCTS_NAME', '商品名称:');
define('TEXT_PRODUCTS_DESCRIPTION', '商品介绍:');
define('TEXT_PRODUCTS_QUANTITY', '商品数量:');
define('TEXT_PRODUCTS_MODEL', '商品型号:');
define('TEXT_PRODUCTS_IMAGE', '商品图片:');
define('TEXT_PRODUCTS_MAIN_IMAGE', '主图片');
define('TEXT_PRODUCTS_LARGE_IMAGE', '大图');
define('TEXT_PRODUCTS_LARGE_IMAGE_HTML_CONTENT', 'HTML 内容 (for popup)');
define('TEXT_PRODUCTS_ADD_LARGE_IMAGE', '添加大图');
define('TEXT_PRODUCTS_LARGE_IMAGE_DELETE_TITLE', '删除大图?');
define('TEXT_PRODUCTS_LARGE_IMAGE_CONFIRM_DELETE', '请确认要删除大图.');
define('TEXT_PRODUCTS_URL', '产品网址:');
define('TEXT_PRODUCTS_URL_WITHOUT_HTTP', '<small>(without http://)</small>');
define('TEXT_PRODUCTS_PRICE_NET', '价格 (不含税):');
define('TEXT_PRODUCTS_PRICE_GROSS', '价格 (含税):');
define('TEXT_PRODUCTS_WEIGHT', '商品重量:');

define('EMPTY_CATEGORY', '空分类');

define('TEXT_HOW_TO_COPY', '复制方式:');
define('TEXT_COPY_AS_LINK', '连接商品');
define('TEXT_COPY_AS_DUPLICATE', '独立商品');

define('ERROR_CANNOT_LINK_TO_SAME_CATEGORY', '错误: 不能连接到相同分类.');
define('ERROR_CATALOG_IMAGE_DIRECTORY_NOT_WRITEABLE', '错误: 分类图片目录不可写: ' . DIR_FS_CATALOG_IMAGES);
define('ERROR_CATALOG_IMAGE_DIRECTORY_DOES_NOT_EXIST', '错误: 分类图片目录不可写: ' . DIR_FS_CATALOG_IMAGES);
define('ERROR_CANNOT_MOVE_CATEGORY_TO_PARENT', '错误: 目录不能移动到子目录.');
?>
