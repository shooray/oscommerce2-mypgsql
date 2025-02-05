# $Id$
#
# osCommerce, Open Source E-Commerce Solutions
# http://www.oscommerce.com
#
# Copyright (c) 2008 osCommerce
#
# Released under the GNU General Public License
#
# NOTE: * Please make any modifications to this file by hand!
#       * DO NOT use a mysqldump created file for new changes!
#       * Please take note of the table structure, and use this
#         structure as a standard for future modifications!
#       * Any tables you add here should be added in admin/backup.php
#         and in catalog/install/includes/functions/database.php
#       * To see the 'diff'erence between MySQL databases, use
#         the mysqldiff perl script located in the extras
#         directory of the 'catalog' module.
#       * Comments should be like these, full line comments.
#         (don't use inline comments)

DROP TABLE IF EXISTS action_recorder;
CREATE TABLE action_recorder (
  id bigserial,
  module varchar(255) NOT NULL,
  user_id bigint,
  user_name character varying(255),
  identifier character varying(255) NOT NULL,
  success char(1),
  date_added timestamp without time zone NOT NULL,
  CONSTRAINT action_recorder_pkey PRIMARY KEY (id)
);
CREATE INDEX idx_action_recorder_module ON action_recorder (module);
CREATE INDEX idx_action_recorder_user_id ON action_recorder (user_id);
CREATE INDEX idx_action_recorder_identifier ON action_recorder (identifier);
CREATE INDEX idx_action_recorder_date_added ON action_recorder (date_added);

DROP TABLE IF EXISTS address_book;
CREATE TABLE address_book (
   address_book_id bigserial,
   customers_id bigint,
   entry_gender char(1),
   entry_company character varying(255),
   entry_firstname character varying(255) NOT NULL,
   entry_lastname character varying(255) NOT NULL,
   entry_street_address character varying(255) NOT NULL,
   entry_suburb character varying(255),
   entry_postcode character varying(255) NOT NULL,
   entry_city character varying(255) NOT NULL,
   entry_state character varying(255),
   entry_country_id bigint DEFAULT '0' NOT NULL,
   entry_zone_id bigint DEFAULT '0' NOT NULL,
   CONSTRAINT address_book_pkey PRIMARY KEY (address_book_id)
);
CREATE INDEX idx_address_book_customers_id ON address_book (customers_id);

DROP TABLE IF EXISTS address_format;
CREATE TABLE address_format (
  address_format_id bigserial,
  address_format character varying(128) NOT NULL,
  address_summary character varying(48) NOT NULL,
  CONSTRAINT address_format_pkey PRIMARY KEY (address_format_id)
);

DROP TABLE IF EXISTS administrators;
CREATE TABLE administrators (
  id bigserial,
  user_name character varying(255) NOT NULL,
  user_password character varying(60) NOT NULL,
  CONSTRAINT administrators_pkey PRIMARY KEY (id)
);

DROP TABLE IF EXISTS banners;
CREATE TABLE banners (
  banners_id bigserial,
  banners_title character varying(64) NOT NULL,
  banners_url character varying(255) NOT NULL,
  banners_image character varying(64) NOT NULL,
  banners_group character varying(10) NOT NULL,
  banners_html_text text,
  expires_impressions int DEFAULT '0',
  expires_date timestamp DEFAULT NULL,
  date_scheduled timestamp DEFAULT NULL,
  date_added timestamp NOT NULL,
  date_status_change timestamp DEFAULT NULL,
  status int DEFAULT '1' NOT NULL,
  CONSTRAINT banners_pkey PRIMARY KEY (banners_id)
);
CREATE INDEX idx_banners_group ON banners (banners_group);

DROP TABLE IF EXISTS banners_history;
CREATE TABLE banners_history (
  banners_history_id bigserial,
  banners_id bigint NOT NULL,
  banners_shown int NOT NULL DEFAULT '0',
  banners_clicked int NOT NULL DEFAULT '0',
  banners_history_date timestamp NOT NULL,
  CONSTRAINT banners_history_pkey PRIMARY KEY (banners_history_id)
);
CREATE INDEX idx_banners_history_banners_id ON banners_history (banners_id);

DROP TABLE IF EXISTS categories;
CREATE TABLE categories (
   categories_id bigserial,
   categories_image character varying(64),
   parent_id bigint DEFAULT '0' NOT NULL,
   sort_order int,
   date_added timestamp,
   last_modified timestamp,
   CONSTRAINT categories_pkey PRIMARY KEY (categories_id)
);
CREATE INDEX idx_categories_parent_id ON categories (parent_id);

DROP TABLE IF EXISTS categories_description;
CREATE TABLE categories_description (
   categories_id bigint DEFAULT '0' NOT NULL,
   language_id bigint DEFAULT '1' NOT NULL,
   categories_name character varying(32) NOT NULL,
   CONSTRAINT categories_description_pkey PRIMARY KEY (categories_id, language_id)
);
CREATE INDEX idx_categories_name ON categories_description (categories_name);

DROP TABLE IF EXISTS configuration;
CREATE TABLE configuration (
  configuration_id bigserial,
  configuration_title character varying(255) NOT NULL,
  configuration_key character varying(255) NOT NULL,
  configuration_value text NOT NULL,
  configuration_description character varying(255) NOT NULL,
  configuration_group_id bigint NOT NULL,
  sort_order int NULL,
  last_modified timestamp NULL,
  date_added timestamp NOT NULL,
  use_function character varying(255) NULL,
  set_function character varying(255) NULL,
  CONSTRAINT configuration_pkey PRIMARY KEY (configuration_id)
);

DROP TABLE IF EXISTS configuration_group;
CREATE TABLE configuration_group (
  configuration_group_id bigserial,
  configuration_group_title character varying(64) NOT NULL,
  configuration_group_description character varying(255) NOT NULL,
  sort_order int NULL,
  visible int DEFAULT '1' NULL,
  CONSTRAINT configuration_group_pkey PRIMARY KEY (configuration_group_id)
);

DROP TABLE IF EXISTS counter;
CREATE TABLE counter (
  startdate char(8),
  counter int
);

DROP TABLE IF EXISTS counter_history;
CREATE TABLE counter_history (
  month char(8),
  counter int
);

DROP TABLE IF EXISTS countries;
CREATE TABLE countries (
  countries_id bigserial,
  countries_name character varying(255) NOT NULL,
  countries_iso_code_2 char(2) NOT NULL,
  countries_iso_code_3 char(3) NOT NULL,
  address_format_id bigint NOT NULL,
  CONSTRAINT countries_pkey PRIMARY KEY (countries_id)
);
CREATE INDEX idx_countries_name ON countries (countries_name);

DROP TABLE IF EXISTS currencies;
CREATE TABLE currencies (
  currencies_id bigserial,
  title character varying(32) NOT NULL,
  code char(3) NOT NULL,
  symbol_left character varying(12),
  symbol_right character varying(12),
  decimal_point char(1),
  thousands_point char(1),
  decimal_places char(1),
  value numeric(13,8),
  last_updated timestamp NULL,
  CONSTRAINT currencies_pkey PRIMARY KEY (currencies_id)
);
CREATE INDEX idx_currencies_code ON currencies (code);

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
   customers_id bigserial,
   customers_gender char(1),
   customers_firstname character varying(255) NOT NULL,
   customers_lastname character varying(255) NOT NULL,
   customers_dob timestamp DEFAULT now() NOT NULL,
   customers_email_address character varying(255) NOT NULL,
   customers_default_address_id bigint,
   customers_telephone character varying(255) NOT NULL,
   customers_fax character varying(255),
   customers_password character varying(60) NOT NULL,
   customers_newsletter char(1),
   CONSTRAINT customers_pkey PRIMARY KEY (customers_id)
);
CREATE INDEX idx_customers_email_address ON customers (customers_email_address);

DROP TABLE IF EXISTS customers_basket;
CREATE TABLE customers_basket (
  customers_basket_id bigserial,
  customers_id bigint NOT NULL,
  products_id text NOT NULL,
  customers_basket_quantity int NOT NULL,
  final_price decimal(15,4),
  customers_basket_date_added char(8),
  CONSTRAINT customers_basket_pkey PRIMARY KEY (customers_basket_id)
);
CREATE INDEX idx_customers_basket_customers_id ON customers_basket (customers_id);

DROP TABLE IF EXISTS customers_basket_attributes;
CREATE TABLE customers_basket_attributes (
  customers_basket_attributes_id bigserial,
  customers_id bigint NOT NULL,
  products_id text NOT NULL,
  products_options_id bigint NOT NULL,
  products_options_value_id bigint NOT NULL,
  CONSTRAINT customers_basket_attributes_pkey PRIMARY KEY (customers_basket_attributes_id)
);
CREATE INDEX idx_customers_basket_att_customers_id ON customers_basket_attributes (customers_id);

DROP TABLE IF EXISTS customers_info;
CREATE TABLE customers_info (
  customers_info_id bigint NOT NULL,
  customers_info_date_of_last_logon timestamp,
  customers_info_number_of_logons int,
  customers_info_date_account_created timestamp,
  customers_info_date_account_last_modified timestamp,
  global_product_notifications int DEFAULT '0',
  CONSTRAINT customers_info_pkey PRIMARY KEY (customers_info_id)
);

DROP TABLE IF EXISTS languages;
CREATE TABLE languages (
  languages_id bigserial,
  name character varying(32)  NOT NULL,
  code char(2) NOT NULL,
  image character varying(64),
  directory character varying(32),
  sort_order int,
  CONSTRAINT languages_pkey PRIMARY KEY (languages_id)
);
CREATE INDEX idx_languages_name ON languages (name);

DROP TABLE IF EXISTS manufacturers;
CREATE TABLE manufacturers (
  manufacturers_id bigserial,
  manufacturers_name character varying(32) NOT NULL,
  manufacturers_image character varying(64),
  date_added timestamp NULL,
  last_modified timestamp NULL,
  CONSTRAINT manufacturers_pkey PRIMARY KEY (manufacturers_id)
);
CREATE INDEX idex_manufacturers_name ON manufacturers (manufacturers_name);

DROP TABLE IF EXISTS manufacturers_info;
CREATE TABLE manufacturers_info (
  manufacturers_id bigint NOT NULL,
  languages_id bigint NOT NULL,
  manufacturers_url character varying(255) NOT NULL,
  url_clicked int NOT NULL default '0',
  date_last_click timestamp NULL,
  CONSTRAINT manufacturers_info_pkey PRIMARY KEY (manufacturers_id, languages_id)
);

DROP TABLE IF EXISTS newsletters;
CREATE TABLE newsletters (
  newsletters_id bigserial,
  title character varying(255) NOT NULL,
  content text NOT NULL,
  module character varying(255) NOT NULL,
  date_added timestamp NOT NULL,
  date_sent timestamp,
  status int,
  locked int DEFAULT '0',
  CONSTRAINT newsletters_pkey PRIMARY KEY (newsletters_id)
);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  orders_id bigserial,
  customers_id bigint NOT NULL,
  customers_name character varying(255) NOT NULL,
  customers_company character varying(255),
  customers_street_address character varying(255) NOT NULL,
  customers_suburb character varying(255),
  customers_city character varying(255) NOT NULL,
  customers_postcode character varying(255) NOT NULL,
  customers_state character varying(255),
  customers_country character varying(255) NOT NULL,
  customers_telephone character varying(255) NOT NULL,
  customers_email_address character varying(255) NOT NULL,
  customers_address_format_id bigint NOT NULL,
  delivery_name character varying(255) NOT NULL,
  delivery_company character varying(255),
  delivery_street_address character varying(255) NOT NULL,
  delivery_suburb character varying(255),
  delivery_city character varying(255) NOT NULL,
  delivery_postcode character varying(255) NOT NULL,
  delivery_state character varying(255),
  delivery_country character varying(255) NOT NULL,
  delivery_address_format_id bigint NOT NULL,
  billing_name character varying(255) NOT NULL,
  billing_company character varying(255),
  billing_street_address character varying(255) NOT NULL,
  billing_suburb character varying(255),
  billing_city character varying(255) NOT NULL,
  billing_postcode character varying(255) NOT NULL,
  billing_state character varying(255),
  billing_country character varying(255) NOT NULL,
  billing_address_format_id bigint NOT NULL,
  payment_method character varying(255) NOT NULL,
  cc_type character varying(20),
  cc_owner character varying(255),
  cc_number character varying(32),
  cc_expires character varying(4),
  last_modified timestamp,
  date_purchased timestamp,
  orders_status int NOT NULL,
  orders_date_finished timestamp,
  currency char(3),
  currency_value numeric(14,6),
  CONSTRAINT orders_pkey PRIMARY KEY (orders_id)
);
CREATE INDEX idx_orders_customers_id ON orders (customers_id);

DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
  orders_products_id bigserial,
  orders_id bigint NOT NULL,
  products_id bigint NOT NULL,
  products_model character varying(12),
  products_name character varying(64) NOT NULL,
  products_price decimal(15,4) NOT NULL,
  final_price decimal(15,4) NOT NULL,
  products_tax decimal(7,4) NOT NULL,
  products_quantity int NOT NULL,
  CONSTRAINT orders_products_pkey PRIMARY KEY (orders_products_id)
);
CREATE INDEX idx_orders_products_orders_id ON orders_products (orders_id);
CREATE INDEX idx_orders_products_products_id ON orders_products (products_id);

DROP TABLE IF EXISTS orders_status;
CREATE TABLE orders_status (
   orders_status_id bigint DEFAULT '0' NOT NULL,
   language_id bigint DEFAULT '1' NOT NULL,
   orders_status_name character varying(32) NOT NULL,
   public_flag int DEFAULT '1',
   downloads_flag int DEFAULT '0',
   CONSTRAINT orders_status_pkey PRIMARY KEY (orders_status_id, language_id)
);
CREATE INDEX idx_orders_status_name ON orders_status (orders_status_name);

DROP TABLE IF EXISTS orders_status_history;
CREATE TABLE orders_status_history (
   orders_status_history_id bigserial,
   orders_id bigint NOT NULL,
   orders_status_id bigint NOT NULL,
   date_added timestamp NOT NULL,
   customer_notified int DEFAULT '0',
   comments text,
   CONSTRAINT orders_status_history_pkey PRIMARY KEY (orders_status_history_id)
);
CREATE INDEX idx_orders_status_history_orders_id ON orders_status_history (orders_id);

DROP TABLE IF EXISTS orders_products_attributes;
CREATE TABLE orders_products_attributes (
  orders_products_attributes_id bigserial,
  orders_id bigint NOT NULL,
  orders_products_id bigint NOT NULL,
  products_options character varying(32) NOT NULL,
  products_options_values character varying(32) NOT NULL,
  options_values_price decimal(15,4) NOT NULL,
  price_prefix char(1) NOT NULL,
  CONSTRAINT orders_products_attributes_pkey PRIMARY KEY (orders_products_attributes_id)
);
CREATE INDEX idx_orders_products_att_orders_id ON orders_products_attributes (orders_id);

DROP TABLE IF EXISTS orders_products_download;
CREATE TABLE orders_products_download (
  orders_products_download_id bigserial,
  orders_id bigint NOT NULL default '0',
  orders_products_id bigint NOT NULL default '0',
  orders_products_filename character varying(255) NOT NULL default '',
  download_maxdays int NOT NULL default '0',
  download_count int NOT NULL default '0',
  CONSTRAINT orders_products_download_pkey PRIMARY KEY (orders_products_download_id)
);
CREATE INDEX idx_orders_products_download_orders_id ON orders_products_download (orders_id);

DROP TABLE IF EXISTS orders_total;
CREATE TABLE orders_total (
  orders_total_id bigserial,
  orders_id bigint NOT NULL,
  title character varying(255) NOT NULL,
  text character varying(255) NOT NULL,
  value numeric(15,4) NOT NULL,
  class character varying(32) NOT NULL,
  sort_order int NOT NULL,
  CONSTRAINT orders_total_pkey PRIMARY KEY (orders_total_id)
);
CREATE INDEX idx_orders_total_orders_id ON orders_total (orders_id);

DROP TABLE IF EXISTS products;
CREATE TABLE products (
  products_id bigserial,
  products_quantity int NOT NULL,
  products_model character varying(12),
  products_image character varying(64),
  products_price numeric(15,4) NOT NULL,
  products_date_added timestamp NOT NULL,
  products_last_modified timestamp,
  products_date_available timestamp,
  products_weight numeric(5,2) NOT NULL,
  products_status smallint NOT NULL,
  products_tax_class_id bigint NOT NULL,
  manufacturers_id bigint NULL,
  products_ordered int NOT NULL default '0',
  CONSTRAINT products_pkey PRIMARY KEY (products_id)
);
CREATE INDEX idx_products_model ON products (products_model);
CREATE INDEX idx_products_date_added ON products (products_date_added);

DROP TABLE IF EXISTS products_attributes;
CREATE TABLE products_attributes (
  products_attributes_id bigserial,
  products_id bigint NOT NULL,
  options_id bigint NOT NULL,
  options_values_id bigint NOT NULL,
  options_values_price numeric(15,4) NOT NULL,
  price_prefix char(1) NOT NULL,
  CONSTRAINT products_attributes_pkey PRIMARY KEY (products_attributes_id)
);
CREATE INDEX idx_products_attributes_products_id ON products_attributes (products_id);

DROP TABLE IF EXISTS products_attributes_download;
CREATE TABLE products_attributes_download (
  products_attributes_id bigint NOT NULL,
  products_attributes_filename character varying(255) NOT NULL default '',
  products_attributes_maxdays int default '0',
  products_attributes_maxcount int default '0',
  CONSTRAINT products_attributes_download_pkey PRIMARY KEY (products_attributes_id)
);

DROP TABLE IF EXISTS products_description;
CREATE TABLE products_description (
  products_id bigserial,
  language_id bigint NOT NULL default '1',
  products_name character varying(64) NOT NULL default '',
  products_description text,
  products_url character varying(255) default NULL,
  products_viewed int default '0',
  CONSTRAINT products_description_pkey PRIMARY KEY (products_id,language_id)
);
CREATE INDEX idx_products_name ON products_description (products_name);

DROP TABLE IF EXISTS products_images;
CREATE TABLE products_images (
  id bigserial,
  products_id bigint NOT NULL,
  image character varying(64),
  htmlcontent text,
  sort_order int NOT NULL,
  CONSTRAINT products_images_pkey PRIMARY KEY (id)
);
CREATE INDEX idx_products_images_prodid ON products_images (products_id);

DROP TABLE IF EXISTS products_notifications;
CREATE TABLE products_notifications (
  products_id bigint NOT NULL,
  customers_id bigint NOT NULL,
  date_added timestamp NOT NULL,
  CONSTRAINT products_notifications_pkey PRIMARY KEY (products_id, customers_id)
);

DROP TABLE IF EXISTS products_options;
CREATE TABLE products_options (
  products_options_id bigint NOT NULL default '0',
  language_id bigint NOT NULL default '1',
  products_options_name character varying(32) NOT NULL default '',
  CONSTRAINT products_options_pkey PRIMARY KEY (products_options_id,language_id)
);

DROP TABLE IF EXISTS products_options_values;
CREATE TABLE products_options_values (
  products_options_values_id bigint NOT NULL default '0',
  language_id bigint NOT NULL default '1',
  products_options_values_name character varying(64) NOT NULL default '',
  CONSTRAINT products_options_values_pkey PRIMARY KEY (products_options_values_id,language_id)
);

DROP TABLE IF EXISTS products_options_values_to_products_options;
CREATE TABLE products_options_values_to_products_options (
  products_options_values_to_products_options_id bigserial,
  products_options_id bigint NOT NULL,
  products_options_values_id bigint NOT NULL,
  CONSTRAINT products_options_values_to_products_options_pkey PRIMARY KEY (products_options_values_to_products_options_id)
);

DROP TABLE IF EXISTS products_to_categories;
CREATE TABLE products_to_categories (
  products_id bigint NOT NULL,
  categories_id bigint NOT NULL,
  CONSTRAINT products_to_categories_pkey PRIMARY KEY (products_id,categories_id)
);

DROP TABLE IF EXISTS reviews;
CREATE TABLE reviews (
  reviews_id bigserial,
  products_id bigint NOT NULL,
  customers_id bigint,
  customers_name character varying(255) NOT NULL,
  reviews_rating int,
  date_added timestamp,
  last_modified timestamp,
  reviews_status smallint NOT NULL default '0',
  reviews_read int NOT NULL default '0',
  CONSTRAINT reviews_pkey PRIMARY KEY (reviews_id)
);
CREATE INDEX idx_reviews_products_id ON reviews (products_id);
CREATE INDEX idx_reviews_customers_id ON reviews (customers_id);

DROP TABLE IF EXISTS reviews_description;
CREATE TABLE reviews_description (
  reviews_id bigint NOT NULL,
  languages_id bigint NOT NULL,
  reviews_text text NOT NULL,
  CONSTRAINT reviews_description_pkey PRIMARY KEY (reviews_id, languages_id)
);

DROP TABLE IF EXISTS sec_directory_whitelist;
CREATE TABLE sec_directory_whitelist (
  id bigserial,
  directory character varying(255) NOT NULL,
  CONSTRAINT sec_directory_whitelist_pkey PRIMARY KEY (id)
);

DROP TABLE IF EXISTS sessions;
CREATE TABLE sessions (
  sesskey character varying(32) NOT NULL,
  expiry bigint NOT NULL,
  value text NOT NULL,
  CONSTRAINT sessions_pkey PRIMARY KEY (sesskey)
);

DROP TABLE IF EXISTS specials;
CREATE TABLE specials (
  specials_id bigserial,
  products_id bigint NOT NULL,
  specials_new_products_price decimal(15,4) NOT NULL,
  specials_date_added timestamp,
  specials_last_modified timestamp,
  expires_date timestamp,
  date_status_change timestamp,
  status int NOT NULL DEFAULT '1',
  CONSTRAINT specials_pkey PRIMARY KEY (specials_id)
);
CREATE INDEX idx_specials_products_id ON specials (products_id);

DROP TABLE IF EXISTS tax_class;
CREATE TABLE tax_class (
  tax_class_id bigserial,
  tax_class_title character varying(32) NOT NULL,
  tax_class_description character varying(255) NOT NULL,
  last_modified timestamp NULL,
  date_added timestamp NOT NULL,
  CONSTRAINT tax_class_pkey PRIMARY KEY (tax_class_id)
);

DROP TABLE IF EXISTS tax_rates;
CREATE TABLE tax_rates (
  tax_rates_id bigserial,
  tax_zone_id bigint NOT NULL,
  tax_class_id bigint NOT NULL,
  tax_priority int DEFAULT 1,
  tax_rate numeric(7,4) NOT NULL,
  tax_description character varying(255) NOT NULL,
  last_modified timestamp NULL,
  date_added timestamp NOT NULL,
  CONSTRAINT tax_rates_pkey PRIMARY KEY (tax_rates_id)
);

DROP TABLE IF EXISTS geo_zones;
CREATE TABLE geo_zones (
  geo_zone_id bigserial,
  geo_zone_name character varying(32) NOT NULL,
  geo_zone_description character varying(255) NOT NULL,
  last_modified timestamp NULL,
  date_added timestamp NOT NULL,
  CONSTRAINT geo_zones_pkey PRIMARY KEY (geo_zone_id)
);

DROP TABLE IF EXISTS whos_online;
CREATE TABLE whos_online (
  customer_id bigint,
  full_name character varying(255) NOT NULL,
  session_id character varying(128) NOT NULL,
  ip_address character varying(15) NOT NULL,
  time_entry character varying(14) NOT NULL,
  time_last_click character varying(14) NOT NULL,
  last_page_url text NOT NULL
);

DROP TABLE IF EXISTS zones;
CREATE TABLE zones (
  zone_id bigserial,
  zone_country_id bigint NOT NULL,
  zone_code character varying(32) NOT NULL,
  zone_name character varying(255) NOT NULL,
  CONSTRAINT zones_pkey PRIMARY KEY (zone_id)
);
CREATE INDEX idx_zones_country_id ON zones (zone_country_id);

DROP TABLE IF EXISTS zones_to_geo_zones;
CREATE TABLE zones_to_geo_zones (
   association_id bigserial,
   zone_country_id bigint NOT NULL,
   zone_id bigint NULL,
   geo_zone_id bigint NULL,
   last_modified timestamp NULL,
   date_added timestamp NOT NULL,
   CONSTRAINT zones_to_geo_zones_pkey PRIMARY KEY (association_id)
);
CREATE INDEX idx_zones_to_geo_zones_country_id ON zones_to_geo_zones (zone_country_id);


# data

# 1 - Default, 2 - USA, 3 - Spain, 4 - Singapore, 5 - Germany
INSERT INTO address_format (address_format,address_summary) VALUES ('$firstname $lastname$cr$streets$cr$city, $postcode$cr$statecomma$country','$city / $country');
INSERT INTO address_format (address_format,address_summary) VALUES ('$firstname $lastname$cr$streets$cr$city, $state    $postcode$cr$country','$city, $state / $country');
INSERT INTO address_format (address_format,address_summary) VALUES ('$firstname $lastname$cr$streets$cr$city$cr$postcode - $statecomma$country','$state / $country');
INSERT INTO address_format (address_format,address_summary) VALUES ('$firstname $lastname$cr$streets$cr$city ($postcode)$cr$country', '$postcode / $country');
INSERT INTO address_format (address_format,address_summary) VALUES ('$firstname $lastname$cr$streets$cr$postcode $city$cr$country','$city / $country');

INSERT INTO banners (banners_title,banners_url,banners_image,banners_group,banners_html_text,expires_impressions,expires_date,date_scheduled,date_added,date_status_change,status) VALUES ('osCommerce', 'http://www.oscommerce.com', 'banners/oscommerce.gif', '468x50', '', 0, null, null, now(), null, 1);

INSERT INTO categories (categories_image,parent_id,sort_order,date_added,last_modified) VALUES ('category_hardware.gif', '0', '1', now(), null);
INSERT INTO categories (categories_image,parent_id,sort_order,date_added,last_modified) VALUES ('category_software.gif', '0', '2', now(), null);
INSERT INTO categories (categories_image,parent_id,sort_order,date_added,last_modified) VALUES ('category_dvd_movies.gif', '0', '3', now(), null);
INSERT INTO categories (categories_image,parent_id,sort_order,date_added,last_modified) VALUES ('subcategory_graphic_cards.gif', '1', '0', now(), null);
INSERT INTO categories (categories_image,parent_id,sort_order,date_added,last_modified) VALUES ('subcategory_printers.gif', '1', '0', now(), null);
INSERT INTO categories (categories_image,parent_id,sort_order,date_added,last_modified) VALUES ('subcategory_monitors.gif', '1', '0', now(), null);
INSERT INTO categories (categories_image,parent_id,sort_order,date_added,last_modified) VALUES ('subcategory_speakers.gif', '1', '0', now(), null);
INSERT INTO categories (categories_image,parent_id,sort_order,date_added,last_modified) VALUES ('subcategory_keyboards.gif', '1', '0', now(), null);
INSERT INTO categories (categories_image,parent_id,sort_order,date_added,last_modified) VALUES ('subcategory_mice.gif', '1', '0', now(), null);
INSERT INTO categories (categories_image,parent_id,sort_order,date_added,last_modified) VALUES ('subcategory_action.gif', '3', '0', now(), null);
INSERT INTO categories (categories_image,parent_id,sort_order,date_added,last_modified) VALUES ('subcategory_science_fiction.gif', '3', '0', now(), null);
INSERT INTO categories (categories_image,parent_id,sort_order,date_added,last_modified) VALUES ('subcategory_comedy.gif', '3', '0', now(), null);
INSERT INTO categories (categories_image,parent_id,sort_order,date_added,last_modified) VALUES ('subcategory_cartoons.gif', '3', '0', now(), null);
INSERT INTO categories (categories_image,parent_id,sort_order,date_added,last_modified) VALUES ('subcategory_thriller.gif', '3', '0', now(), null);
INSERT INTO categories (categories_image,parent_id,sort_order,date_added,last_modified) VALUES ('subcategory_drama.gif', '3', '0', now(), null);
INSERT INTO categories (categories_image,parent_id,sort_order,date_added,last_modified) VALUES ('subcategory_memory.gif', '1', '0', now(), null);
INSERT INTO categories (categories_image,parent_id,sort_order,date_added,last_modified) VALUES ('subcategory_cdrom_drives.gif', '1', '0', now(), null);
INSERT INTO categories (categories_image,parent_id,sort_order,date_added,last_modified) VALUES ('subcategory_simulation.gif', '2', '0', now(), null);
INSERT INTO categories (categories_image,parent_id,sort_order,date_added,last_modified) VALUES ('subcategory_action_games.gif', '2', '0', now(), null);
INSERT INTO categories (categories_image,parent_id,sort_order,date_added,last_modified) VALUES ('subcategory_strategy.gif', '2', '0', now(), null);
INSERT INTO categories (categories_image,parent_id,sort_order,date_added,last_modified) VALUES ('category_gadgets.png', '0', '4', now(), null);

INSERT INTO categories_description VALUES ( '1', '1', 'Hardware');
INSERT INTO categories_description VALUES ( '2', '1', 'Software');
INSERT INTO categories_description VALUES ( '3', '1', 'DVD Movies');
INSERT INTO categories_description VALUES ( '4', '1', 'Graphics Cards');
INSERT INTO categories_description VALUES ( '5', '1', 'Printers');
INSERT INTO categories_description VALUES ( '6', '1', 'Monitors');
INSERT INTO categories_description VALUES ( '7', '1', 'Speakers');
INSERT INTO categories_description VALUES ( '8', '1', 'Keyboards');
INSERT INTO categories_description VALUES ( '9', '1', 'Mice');
INSERT INTO categories_description VALUES ( '10', '1', 'Action');
INSERT INTO categories_description VALUES ( '11', '1', 'Science Fiction');
INSERT INTO categories_description VALUES ( '12', '1', 'Comedy');
INSERT INTO categories_description VALUES ( '13', '1', 'Cartoons');
INSERT INTO categories_description VALUES ( '14', '1', 'Thriller');
INSERT INTO categories_description VALUES ( '15', '1', 'Drama');
INSERT INTO categories_description VALUES ( '16', '1', 'Memory');
INSERT INTO categories_description VALUES ( '17', '1', 'CDROM Drives');
INSERT INTO categories_description VALUES ( '18', '1', 'Simulation');
INSERT INTO categories_description VALUES ( '19', '1', 'Action');
INSERT INTO categories_description VALUES ( '20', '1', 'Strategy');
INSERT INTO categories_description VALUES ( '21', '1', 'Gadgets');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Store Name', 'STORE_NAME', 'osCommerce', 'The name of my store', '1', '1', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Store Owner', 'STORE_OWNER', 'Harald Ponce de Leon', 'The name of my store owner', '1', '2', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('E-Mail Address', 'STORE_OWNER_EMAIL_ADDRESS', 'root@localhost', 'The e-mail address of my store owner', '1', '3', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('E-Mail From', 'EMAIL_FROM', 'osCommerce <root@localhost>', 'The e-mail address used in (sent) e-mails', '1', '4', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Country', 'STORE_COUNTRY', '223', 'The country my store is located in <br /><br /><strong>Note: Please remember to update the store zone.</strong>', '1', '6', 'tep_get_country_name', 'tep_cfg_pull_down_country_list(', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Zone', 'STORE_ZONE', '18', 'The zone my store is located in', '1', '7', 'tep_cfg_get_zone_name', 'tep_cfg_pull_down_zone_list(', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Expected Sort Order', 'EXPECTED_PRODUCTS_SORT', 'desc', 'This is the sort order used in the expected products box.', '1', '8', 'tep_cfg_select_option(array(\'asc\', \'desc\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Expected Sort Field', 'EXPECTED_PRODUCTS_FIELD', 'date_expected', 'The column to sort by in the expected products box.', '1', '9', 'tep_cfg_select_option(array(\'products_name\', \'date_expected\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Switch To Default Language Currency', 'USE_DEFAULT_LANGUAGE_CURRENCY', 'false', 'Automatically switch to the language\'s currency when it is changed', '1', '10', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Send Extra Order Emails To', 'SEND_EXTRA_ORDER_EMAILS_TO', '', 'Send extra order emails to the following email addresses, in this format: Name 1 &lt;email@address1&gt;, Name 2 &lt;email@address2&gt;', '1', '11', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Use Search-Engine Safe URLs', 'SEARCH_ENGINE_FRIENDLY_URLS', 'false', 'Use search-engine safe urls for all site links', '1', '12', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Display Cart After Adding Product', 'DISPLAY_CART', 'true', 'Display the shopping cart after adding a product (or return back to their origin)', '1', '14', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Allow Guest To Tell A Friend', 'ALLOW_GUEST_TO_TELL_A_FRIEND', 'false', 'Allow guests to tell a friend about a product', '1', '15', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Default Search Operator', 'ADVANCED_SEARCH_DEFAULT_OPERATOR', 'and', 'Default search operators', '1', '17', 'tep_cfg_select_option(array(\'and\', \'or\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Store Address and Phone', 'STORE_NAME_ADDRESS', 'Store Name\nAddress\nCountry\nPhone', 'This is the Store Name, Address and Phone used on printable documents and displayed online', '1', '18', 'tep_cfg_textarea(', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Show Category Counts', 'SHOW_COUNTS', 'true', 'Count recursively how many products are in each category', '1', '19', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Tax Decimal Places', 'TAX_DECIMAL_PLACES', '0', 'Pad the tax value this amount of decimal places', '1', '20', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Display Prices with Tax', 'DISPLAY_PRICE_WITH_TAX', 'false', 'Display prices with tax included (true) or add the tax at the end (false)', '1', '21', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('First Name', 'ENTRY_FIRST_NAME_MIN_LENGTH', '2', 'Minimum length of first name', '2', '1', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Last Name', 'ENTRY_LAST_NAME_MIN_LENGTH', '2', 'Minimum length of last name', '2', '2', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Date of Birth', 'ENTRY_DOB_MIN_LENGTH', '10', 'Minimum length of date of birth', '2', '3', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('E-Mail Address', 'ENTRY_EMAIL_ADDRESS_MIN_LENGTH', '6', 'Minimum length of e-mail address', '2', '4', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Street Address', 'ENTRY_STREET_ADDRESS_MIN_LENGTH', '5', 'Minimum length of street address', '2', '5', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Company', 'ENTRY_COMPANY_MIN_LENGTH', '2', 'Minimum length of company name', '2', '6', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Post Code', 'ENTRY_POSTCODE_MIN_LENGTH', '4', 'Minimum length of post code', '2', '7', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('City', 'ENTRY_CITY_MIN_LENGTH', '3', 'Minimum length of city', '2', '8', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('State', 'ENTRY_STATE_MIN_LENGTH', '2', 'Minimum length of state', '2', '9', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Telephone Number', 'ENTRY_TELEPHONE_MIN_LENGTH', '3', 'Minimum length of telephone number', '2', '10', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Password', 'ENTRY_PASSWORD_MIN_LENGTH', '5', 'Minimum length of password', '2', '11', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Credit Card Owner Name', 'CC_OWNER_MIN_LENGTH', '3', 'Minimum length of credit card owner name', '2', '12', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Credit Card Number', 'CC_NUMBER_MIN_LENGTH', '10', 'Minimum length of credit card number', '2', '13', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Review Text', 'REVIEW_TEXT_MIN_LENGTH', '50', 'Minimum length of review text', '2', '14', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Best Sellers', 'MIN_DISPLAY_BESTSELLERS', '1', 'Minimum number of best sellers to display', '2', '15', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Also Purchased', 'MIN_DISPLAY_ALSO_PURCHASED', '1', 'Minimum number of products to display in the \'This Customer Also Purchased\' box', '2', '16', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Address Book Entries', 'MAX_ADDRESS_BOOK_ENTRIES', '5', 'Maximum address book entries a customer is allowed to have', '3', '1', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Search Results', 'MAX_DISPLAY_SEARCH_RESULTS', '20', 'Amount of products to list', '3', '2', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Page Links', 'MAX_DISPLAY_PAGE_LINKS', '5', 'Number of \'number\' links use for page-sets', '3', '3', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Special Products', 'MAX_DISPLAY_SPECIAL_PRODUCTS', '9', 'Maximum number of products on special to display', '3', '4', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('New Products Module', 'MAX_DISPLAY_NEW_PRODUCTS', '9', 'Maximum number of new products to display in a category', '3', '5', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Products Expected', 'MAX_DISPLAY_UPCOMING_PRODUCTS', '10', 'Maximum number of products expected to display', '3', '6', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Manufacturers List', 'MAX_DISPLAY_MANUFACTURERS_IN_A_LIST', '0', 'Used in manufacturers box; when the number of manufacturers exceeds this number, a drop-down list will be displayed instead of the default list', '3', '7', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Manufacturers Select Size', 'MAX_MANUFACTURERS_LIST', '1', 'Used in manufacturers box; when this value is \'1\' the classic drop-down list will be used for the manufacturers box. Otherwise, a list-box with the specified number of rows will be displayed.', '3', '7', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Length of Manufacturers Name', 'MAX_DISPLAY_MANUFACTURER_NAME_LEN', '15', 'Used in manufacturers box; maximum length of manufacturers name to display', '3', '8', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('New Reviews', 'MAX_DISPLAY_NEW_REVIEWS', '6', 'Maximum number of new reviews to display', '3', '9', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Selection of Random Reviews', 'MAX_RANDOM_SELECT_REVIEWS', '10', 'How many records to select from to choose one random product review', '3', '10', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Selection of Random New Products', 'MAX_RANDOM_SELECT_NEW', '10', 'How many records to select from to choose one random new product to display', '3', '11', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Selection of Products on Special', 'MAX_RANDOM_SELECT_SPECIALS', '10', 'How many records to select from to choose one random product special to display', '3', '12', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Categories To List Per Row', 'MAX_DISPLAY_CATEGORIES_PER_ROW', '3', 'How many categories to list per row', '3', '13', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('New Products Listing', 'MAX_DISPLAY_PRODUCTS_NEW', '10', 'Maximum number of new products to display in new products page', '3', '14', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Best Sellers', 'MAX_DISPLAY_BESTSELLERS', '10', 'Maximum number of best sellers to display', '3', '15', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Also Purchased', 'MAX_DISPLAY_ALSO_PURCHASED', '6', 'Maximum number of products to display in the \'This Customer Also Purchased\' box', '3', '16', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Customer Order History Box', 'MAX_DISPLAY_PRODUCTS_IN_ORDER_HISTORY_BOX', '6', 'Maximum number of products to display in the customer order history box', '3', '17', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Order History', 'MAX_DISPLAY_ORDER_HISTORY', '10', 'Maximum number of orders to display in the order history page', '3', '18', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Product Quantities In Shopping Cart', 'MAX_QTY_IN_CART', '99', 'Maximum number of product quantities that can be added to the shopping cart (0 for no limit)', '3', '19', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Small Image Width', 'SMALL_IMAGE_WIDTH', '100', 'The pixel width of small images', '4', '1', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Small Image Height', 'SMALL_IMAGE_HEIGHT', '80', 'The pixel height of small images', '4', '2', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Heading Image Width', 'HEADING_IMAGE_WIDTH', '57', 'The pixel width of heading images', '4', '3', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Heading Image Height', 'HEADING_IMAGE_HEIGHT', '40', 'The pixel height of heading images', '4', '4', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Subcategory Image Width', 'SUBCATEGORY_IMAGE_WIDTH', '100', 'The pixel width of subcategory images', '4', '5', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Subcategory Image Height', 'SUBCATEGORY_IMAGE_HEIGHT', '57', 'The pixel height of subcategory images', '4', '6', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Calculate Image Size', 'CONFIG_CALCULATE_IMAGE_SIZE', 'true', 'Calculate the size of images?', '4', '7', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Image Required', 'IMAGE_REQUIRED', 'true', 'Enable to display broken images. Good for development.', '4', '8', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Gender', 'ACCOUNT_GENDER', 'true', 'Display gender in the customers account', '5', '1', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Date of Birth', 'ACCOUNT_DOB', 'true', 'Display date of birth in the customers account', '5', '2', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Company', 'ACCOUNT_COMPANY', 'true', 'Display company in the customers account', '5', '3', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Suburb', 'ACCOUNT_SUBURB', 'true', 'Display suburb in the customers account', '5', '4', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('State', 'ACCOUNT_STATE', 'true', 'Display state in the customers account', '5', '5', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Installed Modules', 'MODULE_PAYMENT_INSTALLED', 'cod.php;paypal_express.php', 'List of payment module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: cod.php;paypal_express.php)', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Installed Modules', 'MODULE_ORDER_TOTAL_INSTALLED', 'ot_subtotal.php;ot_tax.php;ot_shipping.php;ot_total.php', 'List of order_total module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: ot_subtotal.php;ot_tax.php;ot_shipping.php;ot_total.php)', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Installed Modules', 'MODULE_SHIPPING_INSTALLED', 'flat.php', 'List of shipping module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: ups.php;flat.php;item.php)', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Installed Modules', 'MODULE_ACTION_RECORDER_INSTALLED', 'ar_admin_login.php;ar_contact_us.php;ar_tell_a_friend.php', 'List of action recorder module filenames separated by a semi-colon. This is automatically updated. No need to edit.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Installed Modules', 'MODULE_SOCIAL_BOOKMARKS_INSTALLED', 'sb_email.php;sb_facebook.php;sb_twitter.php;sb_google_buzz.php;sb_digg.php', 'List of social bookmark module filenames separated by a semi-colon. This is automatically updated. No need to edit.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Enable Cash On Delivery Module', 'MODULE_PAYMENT_COD_STATUS', 'True', 'Do you want to accept Cash On Delevery payments?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Payment Zone', 'MODULE_PAYMENT_COD_ZONE', '0', 'If a zone is selected, only enable this payment method for that zone.', '6', '2', 'tep_get_zone_class_title', 'tep_cfg_pull_down_zone_classes(', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Sort order of display.', 'MODULE_PAYMENT_COD_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, use_function, date_added) VALUES ('Set Order Status', 'MODULE_PAYMENT_COD_ORDER_STATUS_ID', '0', 'Set the status of orders made with this payment module to this value', '6', '0', 'tep_cfg_pull_down_order_statuses(', 'tep_get_order_status_name', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Enable Flat Shipping', 'MODULE_SHIPPING_FLAT_STATUS', 'True', 'Do you want to offer flat rate shipping?', '6', '0', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Shipping Cost', 'MODULE_SHIPPING_FLAT_COST', '5.00', 'The shipping cost for all orders using this shipping method.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Tax Class', 'MODULE_SHIPPING_FLAT_TAX_CLASS', '0', 'Use the following tax class on the shipping fee.', '6', '0', 'tep_get_tax_class_title', 'tep_cfg_pull_down_tax_classes(', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Shipping Zone', 'MODULE_SHIPPING_FLAT_ZONE', '0', 'If a zone is selected, only enable this shipping method for that zone.', '6', '0', 'tep_get_zone_class_title', 'tep_cfg_pull_down_zone_classes(', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Sort Order', 'MODULE_SHIPPING_FLAT_SORT_ORDER', '0', 'Sort order of display.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Default Currency', 'DEFAULT_CURRENCY', 'USD', 'Default Currency', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Default Language', 'DEFAULT_LANGUAGE', 'en', 'Default Language', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Default Order Status For New Orders', 'DEFAULT_ORDERS_STATUS_ID', '1', 'When a new order is created, this order status will be assigned to it.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Display Shipping', 'MODULE_ORDER_TOTAL_SHIPPING_STATUS', 'true', 'Do you want to display the order shipping cost?', '6', '1','tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Sort Order', 'MODULE_ORDER_TOTAL_SHIPPING_SORT_ORDER', '2', 'Sort order of display.', '6', '2', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Allow Free Shipping', 'MODULE_ORDER_TOTAL_SHIPPING_FREE_SHIPPING', 'false', 'Do you want to allow free shipping?', '6', '3', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, date_added) VALUES ('Free Shipping For Orders Over', 'MODULE_ORDER_TOTAL_SHIPPING_FREE_SHIPPING_OVER', '50', 'Provide free shipping for orders over the set amount.', '6', '4', 'currencies->format', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Provide Free Shipping For Orders Made', 'MODULE_ORDER_TOTAL_SHIPPING_DESTINATION', 'national', 'Provide free shipping for orders sent to the set destination.', '6', '5', 'tep_cfg_select_option(array(\'national\', \'international\', \'both\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Display Sub-Total', 'MODULE_ORDER_TOTAL_SUBTOTAL_STATUS', 'true', 'Do you want to display the order sub-total cost?', '6', '1','tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Sort Order', 'MODULE_ORDER_TOTAL_SUBTOTAL_SORT_ORDER', '1', 'Sort order of display.', '6', '2', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Display Tax', 'MODULE_ORDER_TOTAL_TAX_STATUS', 'true', 'Do you want to display the order tax value?', '6', '1','tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Sort Order', 'MODULE_ORDER_TOTAL_TAX_SORT_ORDER', '3', 'Sort order of display.', '6', '2', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Display Total', 'MODULE_ORDER_TOTAL_TOTAL_STATUS', 'true', 'Do you want to display the total order value?', '6', '1','tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Sort Order', 'MODULE_ORDER_TOTAL_TOTAL_SORT_ORDER', '4', 'Sort order of display.', '6', '2', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Minimum Minutes Per E-Mail', 'MODULE_ACTION_RECORDER_CONTACT_US_EMAIL_MINUTES', '15', 'Minimum number of minutes to allow 1 e-mail to be sent (eg, 15 for 1 e-mail every 15 minutes)', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Minimum Minutes Per E-Mail', 'MODULE_ACTION_RECORDER_TELL_A_FRIEND_EMAIL_MINUTES', '15', 'Minimum number of minutes to allow 1 e-mail to be sent (eg, 15 for 1 e-mail every 15 minutes)', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Allowed Minutes', 'MODULE_ACTION_RECORDER_ADMIN_LOGIN_MINUTES', '5', 'Number of minutes to allow login attempts to occur.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Allowed Attempts', 'MODULE_ACTION_RECORDER_ADMIN_LOGIN_ATTEMPTS', '3', 'Number of login attempts to allow within the specified period.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable E-Mail Module', 'MODULE_SOCIAL_BOOKMARKS_EMAIL_STATUS', 'True', 'Do you want to allow products to be shared through e-mail?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_SOCIAL_BOOKMARKS_EMAIL_SORT_ORDER', '10', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Facebook Module', 'MODULE_SOCIAL_BOOKMARKS_FACEBOOK_STATUS', 'True', 'Do you want to allow products to be shared through Facebook?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_SOCIAL_BOOKMARKS_FACEBOOK_SORT_ORDER', '20', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Twitter Module', 'MODULE_SOCIAL_BOOKMARKS_TWITTER_STATUS', 'True', 'Do you want to allow products to be shared through Twitter?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_SOCIAL_BOOKMARKS_TWITTER_SORT_ORDER', '30', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Google Buzz Module', 'MODULE_SOCIAL_BOOKMARKS_GOOGLE_BUZZ_STATUS', 'True', 'Do you want to allow products to be shared through Google Buzz?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_SOCIAL_BOOKMARKS_GOOGLE_BUZZ_SORT_ORDER', '40', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Digg Module', 'MODULE_SOCIAL_BOOKMARKS_DIGG_STATUS', 'True', 'Do you want to allow products to be shared through Digg?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_SOCIAL_BOOKMARKS_DIGG_SORT_ORDER', '50', 'Sort order of display. Lowest is displayed first.', '6', '0', now());


INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Country of Origin', 'SHIPPING_ORIGIN_COUNTRY', '223', 'Select the country of origin to be used in shipping quotes.', '7', '1', 'tep_get_country_name', 'tep_cfg_pull_down_country_list(', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Postal Code', 'SHIPPING_ORIGIN_ZIP', 'NONE', 'Enter the Postal Code (ZIP) of the Store to be used in shipping quotes.', '7', '2', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Enter the Maximum Package Weight you will ship', 'SHIPPING_MAX_WEIGHT', '50', 'Carriers have a max weight limit for a single package. This is a common one for all.', '7', '3', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Package Tare weight.', 'SHIPPING_BOX_WEIGHT', '3', 'What is the weight of typical packaging of small to medium packages?', '7', '4', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Larger packages - percentage increase.', 'SHIPPING_BOX_PADDING', '10', 'For 10% enter 10', '7', '5', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Image', 'PRODUCT_LIST_IMAGE', '1', 'Do you want to display the Product Image?', '8', '1', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Manufaturer Name','PRODUCT_LIST_MANUFACTURER', '0', 'Do you want to display the Product Manufacturer Name?', '8', '2', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Model', 'PRODUCT_LIST_MODEL', '0', 'Do you want to display the Product Model?', '8', '3', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Name', 'PRODUCT_LIST_NAME', '2', 'Do you want to display the Product Name?', '8', '4', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Price', 'PRODUCT_LIST_PRICE', '3', 'Do you want to display the Product Price', '8', '5', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Quantity', 'PRODUCT_LIST_QUANTITY', '0', 'Do you want to display the Product Quantity?', '8', '6', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Weight', 'PRODUCT_LIST_WEIGHT', '0', 'Do you want to display the Product Weight?', '8', '7', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Buy Now column', 'PRODUCT_LIST_BUY_NOW', '4', 'Do you want to display the Buy Now column?', '8', '8', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Category/Manufacturer Filter (0=disable; 1=enable)', 'PRODUCT_LIST_FILTER', '1', 'Do you want to display the Category/Manufacturer Filter?', '8', '9', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Location of Prev/Next Navigation Bar (1-top, 2-bottom, 3-both)', 'PREV_NEXT_BAR_LOCATION', '2', 'Sets the location of the Prev/Next Navigation Bar (1-top, 2-bottom, 3-both)', '8', '10', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Check stock level', 'STOCK_CHECK', 'true', 'Check to see if sufficent stock is available', '9', '1', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Subtract stock', 'STOCK_LIMITED', 'true', 'Subtract product in stock by product orders', '9', '2', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Allow Checkout', 'STOCK_ALLOW_CHECKOUT', 'true', 'Allow customer to checkout even if there is insufficient stock', '9', '3', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Mark product out of stock', 'STOCK_MARK_PRODUCT_OUT_OF_STOCK', '***', 'Display something on screen so customer can see which product has insufficient stock', '9', '4', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Stock Re-order level', 'STOCK_REORDER_LEVEL', '5', 'Define when stock needs to be re-ordered', '9', '5', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Store Page Parse Time', 'STORE_PAGE_PARSE_TIME', 'false', 'Store the time it takes to parse a page', '10', '1', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Log Destination', 'STORE_PAGE_PARSE_TIME_LOG', '/var/log/www/tep/page_parse_time.log', 'Directory and filename of the page parse time log', '10', '2', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Log Date Format', 'STORE_PARSE_DATE_TIME_FORMAT', '%d/%m/%Y %H:%M:%S', 'The date format', '10', '3', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Display The Page Parse Time', 'DISPLAY_PAGE_PARSE_TIME', 'true', 'Display the page parse time (store page parse time must be enabled)', '10', '4', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Store Database Queries', 'STORE_DB_TRANSACTIONS', 'false', 'Store the database queries in the page parse time log', '10', '5', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Use Cache', 'USE_CACHE', 'false', 'Use caching features', '11', '1', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Cache Directory', 'DIR_FS_CACHE', '/tmp/', 'The directory where the cached files are saved', '11', '2', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('E-Mail Transport Method', 'EMAIL_TRANSPORT', 'sendmail', 'Defines if this server uses a local connection to sendmail or uses an SMTP connection via TCP/IP. Servers running on Windows and MacOS should change this setting to SMTP.', '12', '1', 'tep_cfg_select_option(array(\'sendmail\', \'smtp\'),', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('E-Mail Linefeeds', 'EMAIL_LINEFEED', 'LF', 'Defines the character sequence used to separate mail headers.', '12', '2', 'tep_cfg_select_option(array(\'LF\', \'CRLF\'),', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Use MIME HTML When Sending Emails', 'EMAIL_USE_HTML', 'false', 'Send e-mails in HTML format', '12', '3', 'tep_cfg_select_option(array(\'true\', \'false\'),', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Verify E-Mail Addresses Through DNS', 'ENTRY_EMAIL_ADDRESS_CHECK', 'false', 'Verify e-mail address through a DNS server', '12', '4', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Send E-Mails', 'SEND_EMAILS', 'true', 'Send out e-mails', '12', '5', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Enable download', 'DOWNLOAD_ENABLED', 'false', 'Enable the products download functions.', '13', '1', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Download by redirect', 'DOWNLOAD_BY_REDIRECT', 'false', 'Use browser redirection for download. Disable on non-Unix systems.', '13', '2', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Expiry delay (days)' ,'DOWNLOAD_MAX_DAYS', '7', 'Set number of days before the download link expires. 0 means no limit.', '13', '3', '', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Maximum number of downloads' ,'DOWNLOAD_MAX_COUNT', '5', 'Set the maximum number of downloads. 0 means no download authorized.', '13', '4', '', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Enable GZip Compression', 'GZIP_COMPRESSION', 'false', 'Enable HTTP GZip compression.', '14', '1', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Compression Level', 'GZIP_LEVEL', '5', 'Use this compression level 0-9 (0 = minimum, 9 = maximum).', '14', '2', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Session Directory', 'SESSION_WRITE_DIRECTORY', '/tmp', 'If sessions are file based, store them in this directory.', '15', '1', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Force Cookie Use', 'SESSION_FORCE_COOKIE_USE', 'False', 'Force the use of sessions when cookies are only enabled.', '15', '2', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Check SSL Session ID', 'SESSION_CHECK_SSL_SESSION_ID', 'False', 'Validate the SSL_SESSION_ID on every secure HTTPS page request.', '15', '3', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Check User Agent', 'SESSION_CHECK_USER_AGENT', 'False', 'Validate the clients browser user agent on every page request.', '15', '4', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Check IP Address', 'SESSION_CHECK_IP_ADDRESS', 'False', 'Validate the clients IP address on every page request.', '15', '5', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Prevent Spider Sessions', 'SESSION_BLOCK_SPIDERS', 'True', 'Prevent known spiders from starting a session.', '15', '6', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Recreate Session', 'SESSION_RECREATE', 'True', 'Recreate the session to generate a new session ID when the customer logs on or creates an account (PHP >=4.1 needed).', '15', '7', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Last Update Check Time', 'LAST_UPDATE_CHECK_TIME', '', 'Last time a check for new versions of osCommerce was run', '6', '0', now());
  
INSERT INTO configuration_group (configuration_group_title,configuration_group_description,sort_order,visible) VALUES ('My Store', 'General information about my store', '1', '1');
INSERT INTO configuration_group (configuration_group_title,configuration_group_description,sort_order,visible) VALUES ('Minimum Values', 'The minimum values for functions / data', '2', '1');
INSERT INTO configuration_group (configuration_group_title,configuration_group_description,sort_order,visible) VALUES ('Maximum Values', 'The maximum values for functions / data', '3', '1');
INSERT INTO configuration_group (configuration_group_title,configuration_group_description,sort_order,visible) VALUES ('Images', 'Image parameters', '4', '1');
INSERT INTO configuration_group (configuration_group_title,configuration_group_description,sort_order,visible) VALUES ('Customer Details', 'Customer account configuration', '5', '1');
INSERT INTO configuration_group (configuration_group_title,configuration_group_description,sort_order,visible) VALUES ('Module Options', 'Hidden from configuration', '6', '0');
INSERT INTO configuration_group (configuration_group_title,configuration_group_description,sort_order,visible) VALUES ('Shipping/Packaging', 'Shipping options available at my store', '7', '1');
INSERT INTO configuration_group (configuration_group_title,configuration_group_description,sort_order,visible) VALUES ('Product Listing', 'Product Listing    configuration options', '8', '1');
INSERT INTO configuration_group (configuration_group_title,configuration_group_description,sort_order,visible) VALUES ('Stock', 'Stock configuration options', '9', '1');
INSERT INTO configuration_group (configuration_group_title,configuration_group_description,sort_order,visible) VALUES ('Logging', 'Logging configuration options', '10', '1');
INSERT INTO configuration_group (configuration_group_title,configuration_group_description,sort_order,visible) VALUES ('Cache', 'Caching configuration options', '11', '1');
INSERT INTO configuration_group (configuration_group_title,configuration_group_description,sort_order,visible) VALUES ('E-Mail Options', 'General setting for E-Mail transport and HTML E-Mails', '12', '1');
INSERT INTO configuration_group (configuration_group_title,configuration_group_description,sort_order,visible) VALUES ('Download', 'Downloadable products options', '13', '1');
INSERT INTO configuration_group (configuration_group_title,configuration_group_description,sort_order,visible) VALUES ('GZip Compression', 'GZip compression options', '14', '1');
INSERT INTO configuration_group (configuration_group_title,configuration_group_description,sort_order,visible) VALUES ('Sessions', 'Session options', '15', '1');

INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Afghanistan','AF','AFG','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Albania','AL','ALB','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Algeria','DZ','DZA','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('American Samoa','AS','ASM','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Andorra','AD','AND','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Angola','AO','AGO','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Anguilla','AI','AIA','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Antarctica','AQ','ATA','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Antigua and Barbuda','AG','ATG','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Argentina','AR','ARG','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Armenia','AM','ARM','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Aruba','AW','ABW','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Australia','AU','AUS','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Austria','AT','AUT','5');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Azerbaijan','AZ','AZE','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Bahamas','BS','BHS','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Bahrain','BH','BHR','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Bangladesh','BD','BGD','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Barbados','BB','BRB','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Belarus','BY','BLR','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Belgium','BE','BEL','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Belize','BZ','BLZ','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Benin','BJ','BEN','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Bermuda','BM','BMU','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Bhutan','BT','BTN','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Bolivia','BO','BOL','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Bosnia and Herzegowina','BA','BIH','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Botswana','BW','BWA','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Bouvet Island','BV','BVT','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Brazil','BR','BRA','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('British Indian Ocean Territory','IO','IOT','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Brunei Darussalam','BN','BRN','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Bulgaria','BG','BGR','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Burkina Faso','BF','BFA','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Burundi','BI','BDI','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Cambodia','KH','KHM','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Cameroon','CM','CMR','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Canada','CA','CAN','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Cape Verde','CV','CPV','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Cayman Islands','KY','CYM','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Central African Republic','CF','CAF','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Chad','TD','TCD','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Chile','CL','CHL','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('China','CN','CHN','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Christmas Island','CX','CXR','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Cocos (Keeling) Islands','CC','CCK','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Colombia','CO','COL','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Comoros','KM','COM','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Congo','CG','COG','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Cook Islands','CK','COK','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Costa Rica','CR','CRI','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Cote D\'Ivoire','CI','CIV','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Croatia','HR','HRV','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Cuba','CU','CUB','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Cyprus','CY','CYP','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Czech Republic','CZ','CZE','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Denmark','DK','DNK','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Djibouti','DJ','DJI','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Dominica','DM','DMA','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Dominican Republic','DO','DOM','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('East Timor','TP','TMP','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Ecuador','EC','ECU','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Egypt','EG','EGY','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('El Salvador','SV','SLV','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Equatorial Guinea','GQ','GNQ','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Eritrea','ER','ERI','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Estonia','EE','EST','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Ethiopia','ET','ETH','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Falkland Islands (Malvinas)','FK','FLK','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Faroe Islands','FO','FRO','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Fiji','FJ','FJI','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Finland','FI','FIN','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('France','FR','FRA','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('France, Metropolitan','FX','FXX','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('French Guiana','GF','GUF','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('French Polynesia','PF','PYF','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('French Southern Territories','TF','ATF','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Gabon','GA','GAB','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Gambia','GM','GMB','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Georgia','GE','GEO','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Germany','DE','DEU','5');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Ghana','GH','GHA','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Gibraltar','GI','GIB','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Greece','GR','GRC','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Greenland','GL','GRL','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Grenada','GD','GRD','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Guadeloupe','GP','GLP','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Guam','GU','GUM','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Guatemala','GT','GTM','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Guinea','GN','GIN','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Guinea-bissau','GW','GNB','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Guyana','GY','GUY','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Haiti','HT','HTI','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Heard and Mc Donald Islands','HM','HMD','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Honduras','HN','HND','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Hong Kong','HK','HKG','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Hungary','HU','HUN','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Iceland','IS','ISL','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('India','IN','IND','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Indonesia','ID','IDN','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Iran (Islamic Republic of)','IR','IRN','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Iraq','IQ','IRQ','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Ireland','IE','IRL','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Israel','IL','ISR','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Italy','IT','ITA','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Jamaica','JM','JAM','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Japan','JP','JPN','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Jordan','JO','JOR','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Kazakhstan','KZ','KAZ','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Kenya','KE','KEN','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Kiribati','KI','KIR','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Korea, Democratic People\'s Republic of','KP','PRK','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Korea, Republic of','KR','KOR','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Kuwait','KW','KWT','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Kyrgyzstan','KG','KGZ','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Lao People\'s Democratic Republic','LA','LAO','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Latvia','LV','LVA','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Lebanon','LB','LBN','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Lesotho','LS','LSO','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Liberia','LR','LBR','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Libyan Arab Jamahiriya','LY','LBY','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Liechtenstein','LI','LIE','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Lithuania','LT','LTU','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Luxembourg','LU','LUX','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Macau','MO','MAC','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Macedonia, The Former Yugoslav Republic of','MK','MKD','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Madagascar','MG','MDG','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Malawi','MW','MWI','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Malaysia','MY','MYS','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Maldives','MV','MDV','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Mali','ML','MLI','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Malta','MT','MLT','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Marshall Islands','MH','MHL','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Martinique','MQ','MTQ','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Mauritania','MR','MRT','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Mauritius','MU','MUS','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Mayotte','YT','MYT','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Mexico','MX','MEX','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Micronesia, Federated States of','FM','FSM','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Moldova, Republic of','MD','MDA','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Monaco','MC','MCO','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Mongolia','MN','MNG','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Montserrat','MS','MSR','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Morocco','MA','MAR','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Mozambique','MZ','MOZ','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Myanmar','MM','MMR','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Namibia','NA','NAM','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Nauru','NR','NRU','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Nepal','NP','NPL','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Netherlands','NL','NLD','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Netherlands Antilles','AN','ANT','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('New Caledonia','NC','NCL','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('New Zealand','NZ','NZL','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Nicaragua','NI','NIC','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Niger','NE','NER','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Nigeria','NG','NGA','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Niue','NU','NIU','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Norfolk Island','NF','NFK','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Northern Mariana Islands','MP','MNP','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Norway','NO','NOR','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Oman','OM','OMN','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Pakistan','PK','PAK','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Palau','PW','PLW','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Panama','PA','PAN','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Papua New Guinea','PG','PNG','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Paraguay','PY','PRY','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Peru','PE','PER','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Philippines','PH','PHL','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Pitcairn','PN','PCN','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Poland','PL','POL','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Portugal','PT','PRT','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Puerto Rico','PR','PRI','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Qatar','QA','QAT','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Reunion','RE','REU','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Romania','RO','ROM','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Russian Federation','RU','RUS','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Rwanda','RW','RWA','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Saint Kitts and Nevis','KN','KNA','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Saint Lucia','LC','LCA','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Saint Vincent and the Grenadines','VC','VCT','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Samoa','WS','WSM','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('San Marino','SM','SMR','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Sao Tome and Principe','ST','STP','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Saudi Arabia','SA','SAU','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Senegal','SN','SEN','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Seychelles','SC','SYC','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Sierra Leone','SL','SLE','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Singapore','SG','SGP', '4');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Slovakia (Slovak Republic)','SK','SVK','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Slovenia','SI','SVN','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Solomon Islands','SB','SLB','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Somalia','SO','SOM','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('South Africa','ZA','ZAF','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('South Georgia and the South Sandwich Islands','GS','SGS','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Spain','ES','ESP','3');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Sri Lanka','LK','LKA','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('St. Helena','SH','SHN','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('St. Pierre and Miquelon','PM','SPM','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Sudan','SD','SDN','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Suriname','SR','SUR','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Svalbard and Jan Mayen Islands','SJ','SJM','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Swaziland','SZ','SWZ','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Sweden','SE','SWE','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Switzerland','CH','CHE','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Syrian Arab Republic','SY','SYR','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Taiwan','TW','TWN','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Tajikistan','TJ','TJK','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Tanzania, United Republic of','TZ','TZA','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Thailand','TH','THA','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Togo','TG','TGO','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Tokelau','TK','TKL','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Tonga','TO','TON','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Trinidad and Tobago','TT','TTO','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Tunisia','TN','TUN','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Turkey','TR','TUR','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Turkmenistan','TM','TKM','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Turks and Caicos Islands','TC','TCA','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Tuvalu','TV','TUV','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Uganda','UG','UGA','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Ukraine','UA','UKR','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('United Arab Emirates','AE','ARE','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('United Kingdom','GB','GBR','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('United States','US','USA', '2');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('United States Minor Outlying Islands','UM','UMI','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Uruguay','UY','URY','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Uzbekistan','UZ','UZB','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Vanuatu','VU','VUT','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Vatican City State (Holy See)','VA','VAT','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Venezuela','VE','VEN','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Viet Nam','VN','VNM','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Virgin Islands (British)','VG','VGB','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Virgin Islands (U.S.)','VI','VIR','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Wallis and Futuna Islands','WF','WLF','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Western Sahara','EH','ESH','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Yemen','YE','YEM','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Yugoslavia','YU','YUG','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Zaire','ZR','ZAR','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Zambia','ZM','ZMB','1');
INSERT INTO countries (countries_name,countries_iso_code_2,countries_iso_code_3,address_format_id) VALUES ('Zimbabwe','ZW','ZWE','1');

INSERT INTO currencies(title,code,symbol_left,symbol_right,decimal_point,thousands_point,decimal_places,"value",last_updated) VALUES ('U.S. Dollar','USD','$','','.',',','2','1.0000', now());
INSERT INTO currencies(title,code,symbol_left,symbol_right,decimal_point,thousands_point,decimal_places,"value",last_updated) VALUES ('Euro','EUR','€','','.',',','2','1.0000', now());
#INSERT INTO currencies VALUES ('U.S. Dollar','USD','$','','.',',','2','1.0000', now());
#INSERT INTO currencies VALUES ('Euro','EUR','','鈧?','.',',','2','1.0000', now());

INSERT INTO languages (name,code,image,directory,sort_order) VALUES ('English','en','icon.gif','english',1);

INSERT INTO manufacturers (manufacturers_name,manufacturers_image,date_added,last_modified) VALUES ('Matrox','manufacturer_matrox.gif', now(), null);
INSERT INTO manufacturers (manufacturers_name,manufacturers_image,date_added,last_modified) VALUES ('Microsoft','manufacturer_microsoft.gif', now(), null);
INSERT INTO manufacturers (manufacturers_name,manufacturers_image,date_added,last_modified) VALUES ('Warner','manufacturer_warner.gif', now(), null);
INSERT INTO manufacturers (manufacturers_name,manufacturers_image,date_added,last_modified) VALUES ('Fox','manufacturer_fox.gif', now(), null);
INSERT INTO manufacturers (manufacturers_name,manufacturers_image,date_added,last_modified) VALUES ('Logitech','manufacturer_logitech.gif', now(), null);
INSERT INTO manufacturers (manufacturers_name,manufacturers_image,date_added,last_modified) VALUES ('Canon','manufacturer_canon.gif', now(), null);
INSERT INTO manufacturers (manufacturers_name,manufacturers_image,date_added,last_modified) VALUES ('Sierra','manufacturer_sierra.gif', now(), null);
INSERT INTO manufacturers (manufacturers_name,manufacturers_image,date_added,last_modified) VALUES ('GT Interactive','manufacturer_gt_interactive.gif', now(), null);
INSERT INTO manufacturers (manufacturers_name,manufacturers_image,date_added,last_modified) VALUES ('Hewlett Packard','manufacturer_hewlett_packard.gif', now(), null);
INSERT INTO manufacturers (manufacturers_name,manufacturers_image,date_added,last_modified) VALUES ('Samsung','manufacturer_samsung.png', now(), null);

INSERT INTO manufacturers_info VALUES (1, 1, 'http://www.matrox.com', 0, null);
INSERT INTO manufacturers_info VALUES (2, 1, 'http://www.microsoft.com', 0, null);
INSERT INTO manufacturers_info VALUES (3, 1, 'http://www.warner.com', 0, null);
INSERT INTO manufacturers_info VALUES (4, 1, 'http://www.fox.com', 0, null);
INSERT INTO manufacturers_info VALUES (5, 1, 'http://www.logitech.com', 0, null);
INSERT INTO manufacturers_info VALUES (6, 1, 'http://www.canon.com', 0, null);
INSERT INTO manufacturers_info VALUES (7, 1, 'http://www.sierra.com', 0, null);
INSERT INTO manufacturers_info VALUES (8, 1, 'http://www.infogrames.com', 0, null);
INSERT INTO manufacturers_info VALUES (9, 1, 'http://www.hewlettpackard.com', 0, null);
INSERT INTO manufacturers_info VALUES (10, 1, 'http://www.samsung.com', 0, null);

INSERT INTO orders_status VALUES ( '1', '1', 'Pending', '1', '0');
INSERT INTO orders_status VALUES ( '2', '1', 'Processing', '1', '1');
INSERT INTO orders_status VALUES ( '3', '1', 'Delivered', '1', '1');

INSERT INTO products (products_quantity,products_model,products_image,products_price,products_date_added,products_last_modified,products_date_available,products_weight,products_status,products_tax_class_id,manufacturers_id,products_ordered) VALUES (32,'MG200MMS','matrox/mg200mms.gif',299.99, now(),null,null,23.00,1,1,1,0);
INSERT INTO products (products_quantity,products_model,products_image,products_price,products_date_added,products_last_modified,products_date_available,products_weight,products_status,products_tax_class_id,manufacturers_id,products_ordered) VALUES (32,'MG400-32MB','matrox/mg400-32mb.gif',499.99, now(),null,null,23.00,1,1,1,0);
INSERT INTO products (products_quantity,products_model,products_image,products_price,products_date_added,products_last_modified,products_date_available,products_weight,products_status,products_tax_class_id,manufacturers_id,products_ordered) VALUES (2,'MSIMPRO','microsoft/msimpro.gif',49.99, now(),null,null,7.00,1,1,3,0);
INSERT INTO products (products_quantity,products_model,products_image,products_price,products_date_added,products_last_modified,products_date_available,products_weight,products_status,products_tax_class_id,manufacturers_id,products_ordered) VALUES (13,'DVD-RPMK','dvd/replacement_killers.gif',42.00, now(),null,null,23.00,1,1,2,0);
INSERT INTO products (products_quantity,products_model,products_image,products_price,products_date_added,products_last_modified,products_date_available,products_weight,products_status,products_tax_class_id,manufacturers_id,products_ordered) VALUES (17,'DVD-BLDRNDC','dvd/blade_runner.gif',35.99, now(),null,null,7.00,1,1,3,0);
INSERT INTO products (products_quantity,products_model,products_image,products_price,products_date_added,products_last_modified,products_date_available,products_weight,products_status,products_tax_class_id,manufacturers_id,products_ordered) VALUES (10,'DVD-MATR','dvd/the_matrix.gif',39.99, now(),null,null,7.00,1,1,3,0);
INSERT INTO products (products_quantity,products_model,products_image,products_price,products_date_added,products_last_modified,products_date_available,products_weight,products_status,products_tax_class_id,manufacturers_id,products_ordered) VALUES (10,'DVD-YGEM','dvd/youve_got_mail.gif',34.99, now(),null,null,7.00,1,1,3,0);
INSERT INTO products (products_quantity,products_model,products_image,products_price,products_date_added,products_last_modified,products_date_available,products_weight,products_status,products_tax_class_id,manufacturers_id,products_ordered) VALUES (10,'DVD-ABUG','dvd/a_bugs_life.gif',35.99, now(),null,null,7.00,1,1,3,0);
INSERT INTO products (products_quantity,products_model,products_image,products_price,products_date_added,products_last_modified,products_date_available,products_weight,products_status,products_tax_class_id,manufacturers_id,products_ordered) VALUES (10,'DVD-UNSG','dvd/under_siege.gif',29.99, now(),null,null,7.00,1,1,3,0);
INSERT INTO products (products_quantity,products_model,products_image,products_price,products_date_added,products_last_modified,products_date_available,products_weight,products_status,products_tax_class_id,manufacturers_id,products_ordered) VALUES (10,'DVD-UNSG2','dvd/under_siege2.gif',29.99, now(),null,null,7.00,1,1,3,0);
INSERT INTO products (products_quantity,products_model,products_image,products_price,products_date_added,products_last_modified,products_date_available,products_weight,products_status,products_tax_class_id,manufacturers_id,products_ordered) VALUES (10,'DVD-FDBL','dvd/fire_down_below.gif',29.99, now(),null,null,7.00,1,1,3,0);
INSERT INTO products (products_quantity,products_model,products_image,products_price,products_date_added,products_last_modified,products_date_available,products_weight,products_status,products_tax_class_id,manufacturers_id,products_ordered) VALUES (10,'DVD-DHWV','dvd/die_hard_3.gif',39.99, now(),null,null,7.00,1,1,4,0);
INSERT INTO products (products_quantity,products_model,products_image,products_price,products_date_added,products_last_modified,products_date_available,products_weight,products_status,products_tax_class_id,manufacturers_id,products_ordered) VALUES (10,'DVD-LTWP','dvd/lethal_weapon.gif',34.99, now(),null,null,7.00,1,1,3,0);
INSERT INTO products (products_quantity,products_model,products_image,products_price,products_date_added,products_last_modified,products_date_available,products_weight,products_status,products_tax_class_id,manufacturers_id,products_ordered) VALUES (10,'DVD-REDC','dvd/red_corner.gif',32.00, now(),null,null,7.00,1,1,3,0);
INSERT INTO products (products_quantity,products_model,products_image,products_price,products_date_added,products_last_modified,products_date_available,products_weight,products_status,products_tax_class_id,manufacturers_id,products_ordered) VALUES (10,'DVD-FRAN','dvd/frantic.gif',35.00, now(),null,null,7.00,1,1,3,0);
INSERT INTO products (products_quantity,products_model,products_image,products_price,products_date_added,products_last_modified,products_date_available,products_weight,products_status,products_tax_class_id,manufacturers_id,products_ordered) VALUES (10,'DVD-CUFI','dvd/courage_under_fire.gif',38.99, now(),null,null,7.00,1,1,4,0);
INSERT INTO products (products_quantity,products_model,products_image,products_price,products_date_added,products_last_modified,products_date_available,products_weight,products_status,products_tax_class_id,manufacturers_id,products_ordered) VALUES (10,'DVD-SPEED','dvd/speed.gif',39.99, now(),null,null,7.00,1,1,4,0);
INSERT INTO products (products_quantity,products_model,products_image,products_price,products_date_added,products_last_modified,products_date_available,products_weight,products_status,products_tax_class_id,manufacturers_id,products_ordered) VALUES (10,'DVD-SPEED2','dvd/speed_2.gif',42.00, now(),null,null,7.00,1,1,4,0);
INSERT INTO products (products_quantity,products_model,products_image,products_price,products_date_added,products_last_modified,products_date_available,products_weight,products_status,products_tax_class_id,manufacturers_id,products_ordered) VALUES (10,'DVD-TSAB','dvd/theres_something_about_mary.gif',49.99, now(),null,null,7.00,1,1,4,0);
INSERT INTO products (products_quantity,products_model,products_image,products_price,products_date_added,products_last_modified,products_date_available,products_weight,products_status,products_tax_class_id,manufacturers_id,products_ordered) VALUES (10,'DVD-BELOVED','dvd/beloved.gif',54.99, now(),null,null,7.00,1,1,3,0);
INSERT INTO products (products_quantity,products_model,products_image,products_price,products_date_added,products_last_modified,products_date_available,products_weight,products_status,products_tax_class_id,manufacturers_id,products_ordered) VALUES (16,'PC-SWAT3','sierra/swat_3.gif',79.99, now(),null,null,7.00,1,1,7,0);
INSERT INTO products (products_quantity,products_model,products_image,products_price,products_date_added,products_last_modified,products_date_available,products_weight,products_status,products_tax_class_id,manufacturers_id,products_ordered) VALUES (13,'PC-UNTM','gt_interactive/unreal_tournament.gif',89.99, now(),null,null,7.00,1,1,8,0);
INSERT INTO products (products_quantity,products_model,products_image,products_price,products_date_added,products_last_modified,products_date_available,products_weight,products_status,products_tax_class_id,manufacturers_id,products_ordered) VALUES (16,'PC-TWOF','gt_interactive/wheel_of_time.gif',99.99, now(),null,null,10.00,1,1,8,0);
INSERT INTO products (products_quantity,products_model,products_image,products_price,products_date_added,products_last_modified,products_date_available,products_weight,products_status,products_tax_class_id,manufacturers_id,products_ordered) VALUES (17,'PC-DISC','gt_interactive/disciples.gif',90.00, now(),null,null,8.00,1,1,8,0);
INSERT INTO products (products_quantity,products_model,products_image,products_price,products_date_added,products_last_modified,products_date_available,products_weight,products_status,products_tax_class_id,manufacturers_id,products_ordered) VALUES (16,'MSINTKB','microsoft/intkeyboardps2.gif',69.99, now(),null,null,8.00,1,1,2,0);
INSERT INTO products (products_quantity,products_model,products_image,products_price,products_date_added,products_last_modified,products_date_available,products_weight,products_status,products_tax_class_id,manufacturers_id,products_ordered) VALUES (10,'MSIMEXP','microsoft/imexplorer.gif',64.95, now(),null,null,8.00,1,1,2,0);
INSERT INTO products (products_quantity,products_model,products_image,products_price,products_date_added,products_last_modified,products_date_available,products_weight,products_status,products_tax_class_id,manufacturers_id,products_ordered) VALUES (8,'HPLJ1100XI','hewlett_packard/lj1100xi.gif',499.99, now(),null,null,45.00,1,1,9,0);
INSERT INTO products (products_quantity,products_model,products_image,products_price,products_date_added,products_last_modified,products_date_available,products_weight,products_status,products_tax_class_id,manufacturers_id,products_ordered) VALUES (100,'GT-P1000','samsung/galaxy_tab.gif',749.99, now(),null,null,1,1,1,10,0);

INSERT INTO products_description VALUES (default,1,'Matrox G200 MMS','Reinforcing its position as a multi-monitor trailblazer, Matrox Graphics Inc. has once again developed the most flexible and highly advanced solution in the industry. Introducing the new Matrox G200 Multi-Monitor Series; the first graphics card ever to support up to four DVI digital flat panel displays on a single 8&quot; PCI board.<br /><br />With continuing demand for digital flat panels in the financial workplace, the Matrox G200 MMS is the ultimate in flexible solutions. The Matrox G200 MMS also supports the new digital video interface (DVI) created by the Digital Display Working Group (DDWG) designed to ease the adoption of digital flat panels. Other configurations include composite video capture ability and onboard TV tuner, making the Matrox G200 MMS the complete solution for business needs.<br /><br />Based on the award-winning MGA-G200 graphics chip, the Matrox G200 Multi-Monitor Series provides superior 2D/3D graphics acceleration to meet the demanding needs of business applications such as real-time stock quotes (Versus), live video feeds (Reuters &amp; Bloombergs), multiple windows applications, word processing, spreadsheets and CAD.','www.matrox.com/mga/products/g200_mms/home.cfm',0);
INSERT INTO products_description VALUES (default,1,'Matrox G400 32MB','<strong>Dramatically Different High Performance Graphics</strong><br /><br />Introducing the Millennium G400 Series - a dramatically different, high performance graphics experience. Armed with the industry\'s fastest graphics chip, the Millennium G400 Series takes explosive acceleration two steps further by adding unprecedented image quality, along with the most versatile display options for all your 3D, 2D and DVD applications. As the most powerful and innovative tools in your PC\'s arsenal, the Millennium G400 Series will not only change the way you see graphics, but will revolutionize the way you use your computer.<br /><br /><strong>Key features:</strong><ul><li>New Matrox G400 256-bit DualBus graphics chip</li><li>Explosive 3D, 2D and DVD performance</li><li>DualHead Display</li><li>Superior DVD and TV output</li><li>3D Environment-Mapped Bump Mapping</li><li>Vibrant Color Quality rendering </li><li>UltraSharp DAC of up to 360 MHz</li><li>3D Rendering Array Processor</li><li>Support for 16 or 32 MB of memory</li></ul>','www.matrox.com/mga/products/mill_g400/home.htm',0);
INSERT INTO products_description VALUES (default,1,'Microsoft IntelliMouse Pro','Every element of IntelliMouse Pro - from its unique arched shape to the texture of the rubber grip around its base - is the product of extensive customer and ergonomic research. Microsoft\'s popular wheel control, which now allows zooming and universal scrolling functions, gives IntelliMouse Pro outstanding comfort and efficiency.','www.microsoft.com/hardware/mouse/intellimouse.asp',0);
INSERT INTO products_description VALUES (default,1,'The Replacement Killers','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br />Languages: English, Deutsch.<br />Subtitles: English, Deutsch, Spanish.<br />Audio: Dolby Surround 5.1.<br />Picture Format: 16:9 Wide-Screen.<br />Length: (approx) 80 minutes.<br />Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.replacement-killers.com',0);
INSERT INTO products_description VALUES (default,1,'Blade Runner - Director\'s Cut','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br />Languages: English, Deutsch.<br />Subtitles: English, Deutsch, Spanish.<br />Audio: Dolby Surround 5.1.<br />Picture Format: 16:9 Wide-Screen.<br />Length: (approx) 112 minutes.<br />Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.bladerunner.com',0);
INSERT INTO products_description VALUES (default,1,'The Matrix','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch.\r<br />\nAudio: Dolby Surround.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 131 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Making Of.','www.thematrix.com',0);
INSERT INTO products_description VALUES (default,1,'You\'ve Got Mail','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch, Spanish.\r<br />\nSubtitles: English, Deutsch, Spanish, French, Nordic, Polish.\r<br />\nAudio: Dolby Digital 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 115 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.youvegotmail.com',0);
INSERT INTO products_description VALUES (default,1,'A Bug\'s Life','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Digital 5.1 / Dobly Surround Stereo.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 91 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.abugslife.com',0);
INSERT INTO products_description VALUES (default,1,'Under Siege','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 98 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (default,1,'Under Siege 2 - Dark Territory','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 98 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (default,1,'Fire Down Below','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 100 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (default,1,'Die Hard With A Vengeance','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 122 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (default,1,'Lethal Weapon','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 100 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (default,1,'Red Corner','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 117 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (default,1,'Frantic','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 115 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (default,1,'Courage Under Fire','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 112 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (default,1,'Speed','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 112 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (default,1,'Speed 2: Cruise Control','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 120 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (default,1,'There\'s Something About Mary','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 114 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (default,1,'Beloved','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 164 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (default,1,'SWAT 3: Close Quarters Battle','<strong>Windows 95/98</strong><br /><br />211 in progress with shots fired. Officer down. Armed suspects with hostages. Respond Code 3! Los Angles, 2005, In the next seven days, representatives from every nation around the world will converge on Las Angles to witness the signing of the United Nations Nuclear Abolishment Treaty. The protection of these dignitaries falls on the shoulders of one organization, LAPD SWAT. As part of this elite tactical organization, you and your team have the weapons and all the training necessary to protect, to serve, and \"When needed\" to use deadly force to keep the peace. It takes more than weapons to make it through each mission. Your arsenal includes C2 charges, flashbangs, tactical grenades. opti-Wand mini-video cameras, and other devices critical to meeting your objectives and keeping your men free of injury. Uncompromised Duty, Honor and Valor!','www.swat3.com',0);
INSERT INTO products_description VALUES (default,1,'Unreal Tournament','From the creators of the best-selling Unreal, comes Unreal Tournament. A new kind of single player experience. A ruthless multiplayer revolution.<br /><br />This stand-alone game showcases completely new team-based gameplay, groundbreaking multi-faceted single player action or dynamic multi-player mayhem. It\'s a fight to the finish for the title of Unreal Grand Master in the gladiatorial arena. A single player experience like no other! Guide your team of \'bots\' (virtual teamates) against the hardest criminals in the galaxy for the ultimate title - the Unreal Grand Master.','www.unrealtournament.net',0);
INSERT INTO products_description VALUES (default,1,'The Wheel Of Time','The world in which The Wheel of Time takes place is lifted directly out of Jordan\'s pages; it\'s huge and consists of many different environments. How you navigate the world will depend largely on which game - single player or multipayer - you\'re playing. The single player experience, with a few exceptions, will see Elayna traversing the world mainly by foot (with a couple notable exceptions). In the multiplayer experience, your character will have more access to travel via Ter\'angreal, Portal Stones, and the Ways. However you move around, though, you\'ll quickly discover that means of locomotion can easily become the least of the your worries...<br /><br />During your travels, you quickly discover that four locations are crucial to your success in the game. Not surprisingly, these locations are the homes of The Wheel of Time\'s main characters. Some of these places are ripped directly from the pages of Jordan\'s books, made flesh with Legend\'s unparalleled pixel-pushing ways. Other places are specific to the game, conceived and executed with the intent of expanding this game world even further. Either way, they provide a backdrop for some of the most intense first person action and strategy you\'ll have this year.','www.wheeloftime.com',0);
INSERT INTO products_description VALUES (default,1,'Disciples: Sacred Lands','A new age is dawning...<br /><br />Enter the realm of the Sacred Lands, where the dawn of a New Age has set in motion the most momentous of wars. As the prophecies long foretold, four races now clash with swords and sorcery in a desperate bid to control the destiny of their gods. Take on the quest as a champion of the Empire, the Mountain Clans, the Legions of the Damned, or the Undead Hordes and test your faith in battles of brute force, spellbinding magic and acts of guile. Slay demons, vanquish giants and combat merciless forces of the dead and undead. But to ensure the salvation of your god, the hero within must evolve.<br /><br />The day of reckoning has come... and only the chosen will survive.','',0);
INSERT INTO products_description VALUES (default,1,'Microsoft Internet Keyboard PS/2','The Internet Keyboard has 10 Hot Keys on a comfortable standard keyboard design that also includes a detachable palm rest. The Hot Keys allow you to browse the web, or check e-mail directly from your keyboard. The IntelliType Pro software also allows you to customize your hot keys - make the Internet Keyboard work the way you want it to!','',0);
INSERT INTO products_description VALUES (default,1,'Microsoft IntelliMouse Explorer','Microsoft introduces its most advanced mouse, the IntelliMouse Explorer! IntelliMouse Explorer features a sleek design, an industrial-silver finish, a glowing red underside and taillight, creating a style and look unlike any other mouse. IntelliMouse Explorer combines the accuracy and reliability of Microsoft IntelliEye optical tracking technology, the convenience of two new customizable function buttons, the efficiency of the scrolling wheel and the comfort of expert ergonomic design. All these great features make this the best mouse for the PC!','www.microsoft.com/hardware/mouse/explorer.asp',0);
INSERT INTO products_description VALUES (default,1,'Hewlett Packard LaserJet 1100Xi','HP has always set the pace in laser printing technology. The new generation HP LaserJet 1100 series sets another impressive pace, delivering a stunning 8 pages per minute print speed. The 600 dpi print resolution with HP\'s Resolution Enhancement technology (REt) makes every document more professional.<br /><br />Enhanced print speed and laser quality results are just the beginning. With 2MB standard memory, HP LaserJet 1100xi users will be able to print increasingly complex pages. Memory can be increased to 18MB to tackle even more complex documents with ease. The HP LaserJet 1100xi supports key operating systems including Windows 3.1, 3.11, 95, 98, NT 4.0, OS/2 and DOS. Network compatibility available via the optional HP JetDirect External Print Servers.<br /><br />HP LaserJet 1100xi also features The Document Builder for the Web Era from Trellix Corp. (featuring software to create Web documents).','www.pandi.hp.com/pandi-db/prodinfo.main?product=laserjet1100',0);
INSERT INTO products_description VALUES (default,1,'Samsung Galaxy Tab','<p>Powered by a Cortex A8 1.0GHz application processor, the Samsung GALAXY Tab is designed to deliver high performance whenever and wherever you are. At the same time, HD video contents are supported by a wide range of multimedia formats (DivX, XviD, MPEG4, H.263, H.264 and more), which maximizes the joy of entertainment.</p><p>With 3G HSPA connectivity, 802.11n Wi-Fi, and Bluetooth 3.0, the Samsung GALAXY Tab enhances users\' mobile communication on a whole new level. Video conferencing and push email on the large 7-inch display make communication more smooth and efficient. For voice telephony, the Samsung GALAXY Tab turns out to be a perfect speakerphone on the desk, or a mobile phone on the move via Bluetooth headset.</p>','http://galaxytab.samsungmobile.com',0);

INSERT INTO products_attributes VALUES (default,1,4,1,0.00,'+');
INSERT INTO products_attributes VALUES (default,1,4,2,50.00,'+');
INSERT INTO products_attributes VALUES (default,1,4,3,70.00,'+');
INSERT INTO products_attributes VALUES (default,1,3,5,0.00,'+');
INSERT INTO products_attributes VALUES (default,1,3,6,100.00,'+');
INSERT INTO products_attributes VALUES (default,2,4,3,10.00,'-');
INSERT INTO products_attributes VALUES (default,2,4,4,0.00,'+');
INSERT INTO products_attributes VALUES (default,2,3,6,0.00,'+');
INSERT INTO products_attributes VALUES (default,2,3,7,120.00,'+');
INSERT INTO products_attributes VALUES (default,26,3,8,0.00,'+');
INSERT INTO products_attributes VALUES (default,26,3,9,6.00,'+');
INSERT INTO products_attributes VALUES (default,22,5,10,0.00,'+');
INSERT INTO products_attributes VALUES (default,22,5,13,0.00,'+');

INSERT INTO products_attributes_download VALUES (12, 'unreal.zip', 7, 3);

INSERT INTO products_images VALUES (default,28,'samsung/galaxy_tab_1.jpg',null,1);
INSERT INTO products_images VALUES (default,28,'samsung/galaxy_tab_2.jpg',null,2);
INSERT INTO products_images VALUES (default,28,'samsung/galaxy_tab_3.jpg',null,3);
INSERT INTO products_images VALUES (default,28,'samsung/galaxy_tab_4.jpg','<object type="application/x-shockwave-flash" width="640" height="385" data="http://www.youtube.com/v/tAbsmHMAhrQ?fs=1&amp;autoplay=1"><param name="movie" value="http://www.youtube.com/v/tAbsmHMAhrQ?fs=1&amp;autoplay=1" /><param name="allowFullScreen" value="true" /><param name="allowscriptaccess" value="always" /><param name="wmode" value="transparent" /></object>',4);

INSERT INTO products_options VALUES (1,1,'Color');
INSERT INTO products_options VALUES (2,1,'Size');
INSERT INTO products_options VALUES (3,1,'Model');
INSERT INTO products_options VALUES (4,1,'Memory');
INSERT INTO products_options VALUES (5,1,'Version');

INSERT INTO products_options_values VALUES (1,1,'4 mb');
INSERT INTO products_options_values VALUES (2,1,'8 mb');
INSERT INTO products_options_values VALUES (3,1,'16 mb');
INSERT INTO products_options_values VALUES (4,1,'32 mb');
INSERT INTO products_options_values VALUES (5,1,'Value');
INSERT INTO products_options_values VALUES (6,1,'Premium');
INSERT INTO products_options_values VALUES (7,1,'Deluxe');
INSERT INTO products_options_values VALUES (8,1,'PS/2');
INSERT INTO products_options_values VALUES (9,1,'USB');
INSERT INTO products_options_values VALUES (10,1,'Download: Windows - English');
INSERT INTO products_options_values VALUES (13,1,'Box: Windows - English');

INSERT INTO products_options_values_to_products_options VALUES (default,4,1);
INSERT INTO products_options_values_to_products_options VALUES (default,4,2);
INSERT INTO products_options_values_to_products_options VALUES (default,4,3);
INSERT INTO products_options_values_to_products_options VALUES (default,4,4);
INSERT INTO products_options_values_to_products_options VALUES (default,3,5);
INSERT INTO products_options_values_to_products_options VALUES (default,3,6);
INSERT INTO products_options_values_to_products_options VALUES (default,3,7);
INSERT INTO products_options_values_to_products_options VALUES (default,3,8);
INSERT INTO products_options_values_to_products_options VALUES (default,3,9);
INSERT INTO products_options_values_to_products_options VALUES (default,5,10);
INSERT INTO products_options_values_to_products_options VALUES (default,5,13);

INSERT INTO products_to_categories VALUES (1,4);
INSERT INTO products_to_categories VALUES (2,4);
INSERT INTO products_to_categories VALUES (3,9);
INSERT INTO products_to_categories VALUES (4,10);
INSERT INTO products_to_categories VALUES (5,11);
INSERT INTO products_to_categories VALUES (6,10);
INSERT INTO products_to_categories VALUES (7,12);
INSERT INTO products_to_categories VALUES (8,13);
INSERT INTO products_to_categories VALUES (9,10);
INSERT INTO products_to_categories VALUES (10,10);
INSERT INTO products_to_categories VALUES (11,10);
INSERT INTO products_to_categories VALUES (12,10);
INSERT INTO products_to_categories VALUES (13,10);
INSERT INTO products_to_categories VALUES (14,15);
INSERT INTO products_to_categories VALUES (15,14);
INSERT INTO products_to_categories VALUES (16,15);
INSERT INTO products_to_categories VALUES (17,10);
INSERT INTO products_to_categories VALUES (18,10);
INSERT INTO products_to_categories VALUES (19,12);
INSERT INTO products_to_categories VALUES (20,15);
INSERT INTO products_to_categories VALUES (21,18);
INSERT INTO products_to_categories VALUES (22,19);
INSERT INTO products_to_categories VALUES (23,20);
INSERT INTO products_to_categories VALUES (24,20);
INSERT INTO products_to_categories VALUES (25,8);
INSERT INTO products_to_categories VALUES (26,9);
INSERT INTO products_to_categories VALUES (27,5);
INSERT INTO products_to_categories VALUES (28,21);

INSERT INTO reviews VALUES (default,19,0,'John Doe',5,now(),null,1,0);

INSERT INTO reviews_description VALUES (1,1, 'This has to be one of the funniest movies released for 1999!');

INSERT INTO sec_directory_whitelist(directory) VALUES ('admin/backups');
INSERT INTO sec_directory_whitelist(directory) VALUES ('admin/images/graphs');
INSERT INTO sec_directory_whitelist(directory) VALUES ('images');
INSERT INTO sec_directory_whitelist(directory) VALUES ('images/banners');
INSERT INTO sec_directory_whitelist(directory) VALUES ('images/dvd');
INSERT INTO sec_directory_whitelist(directory) VALUES ('images/gt_interactive');
INSERT INTO sec_directory_whitelist(directory) VALUES ('images/hewlett_packard');
INSERT INTO sec_directory_whitelist(directory) VALUES ('images/matrox');
INSERT INTO sec_directory_whitelist(directory) VALUES ('images/microsoft');
INSERT INTO sec_directory_whitelist(directory) VALUES ('images/sierra');
INSERT INTO sec_directory_whitelist(directory) VALUES ('includes/work');
INSERT INTO sec_directory_whitelist(directory) VALUES ('pub');

INSERT INTO specials VALUES (default,3, 39.99, now(), null, null, null, '1');
INSERT INTO specials VALUES (default,5, 30.00, now(), null, null, null, '1');
INSERT INTO specials VALUES (default,6, 30.00, now(), null, null, null, '1');
INSERT INTO specials VALUES (default,16, 29.99, now(), null, null, null, '1');

INSERT INTO tax_class VALUES (default, 'Taxable Goods', 'The following types of products are included non-food, services, etc', now(), now());

# USA/Florida
INSERT INTO tax_rates VALUES (default, 1, 1, 1, 7.0, 'FL TAX 7.0%', now(), now());
INSERT INTO geo_zones (geo_zone_name,geo_zone_description,date_added) VALUES ('Florida','Florida local sales tax zone',now());
INSERT INTO zones_to_geo_zones (association_id,zone_country_id,zone_id,geo_zone_id,date_added) VALUES (1,223,18,1,now());

# USA
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'AL','Alabama');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'AK','Alaska');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'AS','American Samoa');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'AZ','Arizona');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'AR','Arkansas');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'AF','Armed Forces Africa');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'AA','Armed Forces Americas');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'AC','Armed Forces Canada');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'AE','Armed Forces Europe');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'AM','Armed Forces Middle East');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'AP','Armed Forces Pacific');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'CA','California');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'CO','Colorado');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'CT','Connecticut');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'DE','Delaware');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'DC','District of Columbia');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'FM','Federated States Of Micronesia');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'FL','Florida');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'GA','Georgia');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'GU','Guam');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'HI','Hawaii');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'ID','Idaho');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'IL','Illinois');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'IN','Indiana');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'IA','Iowa');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'KS','Kansas');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'KY','Kentucky');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'LA','Louisiana');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'ME','Maine');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'MH','Marshall Islands');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'MD','Maryland');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'MA','Massachusetts');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'MI','Michigan');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'MN','Minnesota');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'MS','Mississippi');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'MO','Missouri');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'MT','Montana');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'NE','Nebraska');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'NV','Nevada');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'NH','New Hampshire');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'NJ','New Jersey');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'NM','New Mexico');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'NY','New York');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'NC','North Carolina');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'ND','North Dakota');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'MP','Northern Mariana Islands');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'OH','Ohio');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'OK','Oklahoma');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'OR','Oregon');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'PW','Palau');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'PA','Pennsylvania');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'PR','Puerto Rico');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'RI','Rhode Island');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'SC','South Carolina');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'SD','South Dakota');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'TN','Tennessee');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'TX','Texas');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'UT','Utah');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'VT','Vermont');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'VI','Virgin Islands');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'VA','Virginia');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'WA','Washington');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'WV','West Virginia');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'WI','Wisconsin');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (223,'WY','Wyoming');

# Canada
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (38,'AB','Alberta');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (38,'BC','British Columbia');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (38,'MB','Manitoba');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (38,'NF','Newfoundland');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (38,'NB','New Brunswick');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (38,'NS','Nova Scotia');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (38,'NT','Northwest Territories');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (38,'NU','Nunavut');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (38,'ON','Ontario');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (38,'PE','Prince Edward Island');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (38,'QC','Quebec');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (38,'SK','Saskatchewan');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (38,'YT','Yukon Territory');

# Germany
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (81,'NDS','Niedersachsen');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (81,'BAW','Baden-W眉rttemberg');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (81,'BAY','Bayern');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (81,'BER','Berlin');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (81,'BRG','Brandenburg');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (81,'BRE','Bremen');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (81,'HAM','Hamburg');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (81,'HES','Hessen');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (81,'MEC','Mecklenburg-Vorpommern');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (81,'NRW','Nordrhein-Westfalen');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (81,'RHE','Rheinland-Pfalz');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (81,'SAR','Saarland');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (81,'SAS','Sachsen');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (81,'SAC','Sachsen-Anhalt');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (81,'SCN','Schleswig-Holstein');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (81,'THE','Th眉ringen');

# Austria
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (14,'WI','Wien');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (14,'NO','Nieder枚sterreich');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (14,'OO','Ober枚sterreich');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (14,'SB','Salzburg');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (14,'KN','K盲rnten');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (14,'ST','Steiermark');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (14,'TI','Tirol');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (14,'BL','Burgenland');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (14,'VB','Voralberg');

# Swizterland
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (204,'AG','Aargau');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (204,'AI','Appenzell Innerrhoden');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (204,'AR','Appenzell Ausserrhoden');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (204,'BE','Bern');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (204,'BL','Basel-Landschaft');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (204,'BS','Basel-Stadt');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (204,'FR','Freiburg');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (204,'GE','Genf');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (204,'GL','Glarus');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (204,'JU','Graub眉nden');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (204,'JU','Jura');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (204,'LU','Luzern');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (204,'NE','Neuenburg');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (204,'NW','Nidwalden');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (204,'OW','Obwalden');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (204,'SG','St. Gallen');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (204,'SH','Schaffhausen');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (204,'SO','Solothurn');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (204,'SZ','Schwyz');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (204,'TG','Thurgau');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (204,'TI','Tessin');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (204,'UR','Uri');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (204,'VD','Waadt');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (204,'VS','Wallis');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (204,'ZG','Zug');
INSERT INTO zones(zone_country_id,zone_code,zone_name) VALUES (204,'ZH','Z眉rich');

# Spain
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'A Coru帽a','A Coru帽a');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Alava','Alava');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Albacete','Albacete');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Alicante','Alicante');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Almeria','Almeria');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Asturias','Asturias');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Avila','Avila');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Badajoz','Badajoz');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Baleares','Baleares');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Barcelona','Barcelona');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Burgos','Burgos');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Caceres','Caceres');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Cadiz','Cadiz');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Cantabria','Cantabria');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Castellon','Castellon');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Ceuta','Ceuta');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Ciudad Real','Ciudad Real');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Cordoba','Cordoba');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Cuenca','Cuenca');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Girona','Girona');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Granada','Granada');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Guadalajara','Guadalajara');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Guipuzcoa','Guipuzcoa');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Huelva','Huelva');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Huesca','Huesca');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Jaen','Jaen');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'La Rioja','La Rioja');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Las Palmas','Las Palmas');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Leon','Leon');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Lleida','Lleida');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Lugo','Lugo');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Madrid','Madrid');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Malaga','Malaga');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Melilla','Melilla');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Murcia','Murcia');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Navarra','Navarra');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Ourense','Ourense');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Palencia','Palencia');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Pontevedra','Pontevedra');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Salamanca','Salamanca');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Santa Cruz de Tenerife','Santa Cruz de Tenerife');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Segovia','Segovia');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Sevilla','Sevilla');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Soria','Soria');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Tarragona','Tarragona');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Teruel','Teruel');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Toledo','Toledo');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Valencia','Valencia');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Valladolid','Valladolid');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Vizcaya','Vizcaya');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Zamora','Zamora');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Zaragoza','Zaragoza');

# PayPal Express
INSERT INTO orders_status (orders_status_id, language_id, orders_status_name, public_flag, downloads_flag) values ('4', '1', 'PayPal [Transactions]', 0, 0);
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable PayPal Express Checkout', 'MODULE_PAYMENT_PAYPAL_EXPRESS_STATUS', 'True', 'Do you want to accept PayPal Express Checkout payments?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Seller Account', 'MODULE_PAYMENT_PAYPAL_EXPRESS_SELLER_ACCOUNT', '', 'The email address of the seller account if no API credentials has been setup.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('API Username', 'MODULE_PAYMENT_PAYPAL_EXPRESS_API_USERNAME', '', 'The username to use for the PayPal API service', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('API Password', 'MODULE_PAYMENT_PAYPAL_EXPRESS_API_PASSWORD', '', 'The password to use for the PayPal API service', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('API Signature', 'MODULE_PAYMENT_PAYPAL_EXPRESS_API_SIGNATURE', '', 'The signature to use for the PayPal API service', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Transaction Server', 'MODULE_PAYMENT_PAYPAL_EXPRESS_TRANSACTION_SERVER', 'Live', 'Use the live or testing (sandbox) gateway server to process transactions?', '6', '0', 'tep_cfg_select_option(array(\'Live\', \'Sandbox\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Transaction Method', 'MODULE_PAYMENT_PAYPAL_EXPRESS_TRANSACTION_METHOD', 'Sale', 'The processing method to use for each transaction.', '6', '0', 'tep_cfg_select_option(array(\'Authorization\', \'Sale\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('PayPal Account Optional', 'MODULE_PAYMENT_PAYPAL_EXPRESS_ACCOUNT_OPTIONAL', 'False', 'This must also be enabled in your PayPal account, in Profile > Website Payment Preferences.', '6', '0', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('PayPal Instant Update', 'MODULE_PAYMENT_PAYPAL_EXPRESS_INSTANT_UPDATE', 'True', 'Support PayPal shipping and tax calculations on the PayPal.com site during Express Checkout.', '6', '0', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('PayPal Checkout Image', 'MODULE_PAYMENT_PAYPAL_EXPRESS_CHECKOUT_IMAGE', 'Static', 'Use static or dynamic Express Checkout image buttons. Dynamic images are used with PayPal campaigns.', '6', '0', 'tep_cfg_select_option(array(\'Static\', \'Dynamic\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Debug E-Mail Address', 'MODULE_PAYMENT_PAYPAL_EXPRESS_DEBUG_EMAIL', '', 'All parameters of an invalid transaction will be sent to this email address.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) values ('Payment Zone', 'MODULE_PAYMENT_PAYPAL_EXPRESS_ZONE', '0', 'If a zone is selected, only enable this payment method for that zone.', '6', '2', 'tep_get_zone_class_title', 'tep_cfg_pull_down_zone_classes(', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort order of display.', 'MODULE_PAYMENT_PAYPAL_EXPRESS_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, use_function, date_added) values ('Set Order Status', 'MODULE_PAYMENT_PAYPAL_EXPRESS_ORDER_STATUS_ID', '0', 'Set the status of orders made with this payment module to this value', '6', '0', 'tep_cfg_pull_down_order_statuses(', 'tep_get_order_status_name', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, use_function, date_added) values ('PayPal Transactions Order Status Level', 'MODULE_PAYMENT_PAYPAL_EXPRESS_TRANSACTIONS_ORDER_STATUS_ID', '4', 'Include PayPal transaction information in this order status level', '6', '0', 'tep_cfg_pull_down_order_statuses(', 'tep_get_order_status_name', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('cURL Program Location', 'MODULE_PAYMENT_PAYPAL_EXPRESS_CURL', '/usr/bin/curl', 'The location to the cURL program application.', '6', '0' , now());

# Header Tags
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Installed Modules', 'MODULE_HEADER_TAGS_INSTALLED', 'ht_manufacturer_title.php;ht_category_title.php;ht_product_title.php', 'List of header tag module filenames separated by a semi-colon. This is automatically updated. No need to edit.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Category Title Module', 'MODULE_HEADER_TAGS_CATEGORY_TITLE_STATUS', 'True', 'Do you want to allow category titles to be added to the page title?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_HEADER_TAGS_CATEGORY_TITLE_SORT_ORDER', '200', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Manufacturer Title Module', 'MODULE_HEADER_TAGS_MANUFACTURER_TITLE_STATUS', 'True', 'Do you want to allow manufacturer titles to be added to the page title?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_HEADER_TAGS_MANUFACTURER_TITLE_SORT_ORDER', '100', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Product Title Module', 'MODULE_HEADER_TAGS_PRODUCT_TITLE_STATUS', 'True', 'Do you want to allow product titles to be added to the page title?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_HEADER_TAGS_PRODUCT_TITLE_SORT_ORDER', '300', 'Sort order of display. Lowest is displayed first.', '6', '0', now());

# Administration Tool Dasboard
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Installed Modules', 'MODULE_ADMIN_DASHBOARD_INSTALLED', 'd_total_revenue.php;d_total_customers.php;d_orders.php;d_customers.php;d_admin_logins.php;d_security_checks.php;d_latest_news.php;d_latest_addons.php;d_version_check.php;d_reviews.php', 'List of Administration Tool Dashboard module filenames separated by a semi-colon. This is automatically updated. No need to edit.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Administrator Logins Module', 'MODULE_ADMIN_DASHBOARD_ADMIN_LOGINS_STATUS', 'True', 'Do you want to show the latest administrator logins on the dashboard?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_ADMIN_DASHBOARD_ADMIN_LOGINS_SORT_ORDER', '500', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Customers Module', 'MODULE_ADMIN_DASHBOARD_CUSTOMERS_STATUS', 'True', 'Do you want to show the newest customers on the dashboard?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_ADMIN_DASHBOARD_CUSTOMERS_SORT_ORDER', '400', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Latest Add-Ons Module', 'MODULE_ADMIN_DASHBOARD_LATEST_ADDONS_STATUS', 'True', 'Do you want to show the latest osCommerce Add-Ons on the dashboard?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_ADMIN_DASHBOARD_LATEST_ADDONS_SORT_ORDER', '800', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Latest News Module', 'MODULE_ADMIN_DASHBOARD_LATEST_NEWS_STATUS', 'True', 'Do you want to show the latest osCommerce News on the dashboard?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_ADMIN_DASHBOARD_LATEST_NEWS_SORT_ORDER', '700', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Orders Module', 'MODULE_ADMIN_DASHBOARD_ORDERS_STATUS', 'True', 'Do you want to show the latest orders on the dashboard?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_ADMIN_DASHBOARD_ORDERS_SORT_ORDER', '300', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Security Checks Module', 'MODULE_ADMIN_DASHBOARD_SECURITY_CHECKS_STATUS', 'True', 'Do you want to run the security checks for this installation?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_ADMIN_DASHBOARD_SECURITY_CHECKS_SORT_ORDER', '600', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Total Customers Module', 'MODULE_ADMIN_DASHBOARD_TOTAL_CUSTOMERS_STATUS', 'True', 'Do you want to show the total customers chart on the dashboard?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_ADMIN_DASHBOARD_TOTAL_CUSTOMERS_SORT_ORDER', '200', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Total Revenue Module', 'MODULE_ADMIN_DASHBOARD_TOTAL_REVENUE_STATUS', 'True', 'Do you want to show the total revenue chart on the dashboard?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_ADMIN_DASHBOARD_TOTAL_REVENUE_SORT_ORDER', '100', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Version Check Module', 'MODULE_ADMIN_DASHBOARD_VERSION_CHECK_STATUS', 'True', 'Do you want to show the version check results on the dashboard?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_ADMIN_DASHBOARD_VERSION_CHECK_SORT_ORDER', '900', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Latest Reviews Module', 'MODULE_ADMIN_DASHBOARD_REVIEWS_STATUS', 'True', 'Do you want to show the latest reviews on the dashboard?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_ADMIN_DASHBOARD_REVIEWS_SORT_ORDER', '1000', 'Sort order of display. Lowest is displayed first.', '6', '0', now());

# Boxes
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Installed Modules', 'MODULE_BOXES_INSTALLED', 'bm_categories.php;bm_manufacturers.php;bm_search.php;bm_whats_new.php;bm_information.php;bm_shopping_cart.php;bm_manufacturer_info.php;bm_order_history.php;bm_best_sellers.php;bm_product_notifications.php;bm_product_social_bookmarks.php;bm_specials.php;bm_reviews.php;bm_languages.php;bm_currencies.php', 'List of box module filenames separated by a semi-colon. This is automatically updated. No need to edit.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Best Sellers Module', 'MODULE_BOXES_BEST_SELLERS_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_BEST_SELLERS_CONTENT_PLACEMENT', 'Right Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_BEST_SELLERS_SORT_ORDER', '5030', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Categories Module', 'MODULE_BOXES_CATEGORIES_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_CATEGORIES_CONTENT_PLACEMENT', 'Left Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_CATEGORIES_SORT_ORDER', '1000', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Currencies Module', 'MODULE_BOXES_CURRENCIES_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_CURRENCIES_CONTENT_PLACEMENT', 'Right Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_CURRENCIES_SORT_ORDER', '5090', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Information Module', 'MODULE_BOXES_INFORMATION_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_INFORMATION_CONTENT_PLACEMENT', 'Left Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_INFORMATION_SORT_ORDER', '1050', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Languages Module', 'MODULE_BOXES_LANGUAGES_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_LANGUAGES_CONTENT_PLACEMENT', 'Right Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_LANGUAGES_SORT_ORDER', '5080', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Manufacturer Info Module', 'MODULE_BOXES_MANUFACTURER_INFO_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_MANUFACTURER_INFO_CONTENT_PLACEMENT', 'Right Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_MANUFACTURER_INFO_SORT_ORDER', '5010', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Manufacturers Module', 'MODULE_BOXES_MANUFACTURERS_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_MANUFACTURERS_CONTENT_PLACEMENT', 'Left Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_MANUFACTURERS_SORT_ORDER', '1020', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Order History Module', 'MODULE_BOXES_ORDER_HISTORY_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_ORDER_HISTORY_CONTENT_PLACEMENT', 'Right Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_ORDER_HISTORY_SORT_ORDER', '5020', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Product Notifications Module', 'MODULE_BOXES_PRODUCT_NOTIFICATIONS_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_PRODUCT_NOTIFICATIONS_CONTENT_PLACEMENT', 'Right Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_PRODUCT_NOTIFICATIONS_SORT_ORDER', '5040', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Product Social Bookmarks Module', 'MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_CONTENT_PLACEMENT', 'Right Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_SORT_ORDER', '5050', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Reviews Module', 'MODULE_BOXES_REVIEWS_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_REVIEWS_CONTENT_PLACEMENT', 'Right Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_REVIEWS_SORT_ORDER', '5070', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Search Module', 'MODULE_BOXES_SEARCH_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_SEARCH_CONTENT_PLACEMENT', 'Left Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_SEARCH_SORT_ORDER', '1030', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Shopping Cart Module', 'MODULE_BOXES_SHOPPING_CART_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_SHOPPING_CART_CONTENT_PLACEMENT', 'Right Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_SHOPPING_CART_SORT_ORDER', '5000', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Specials Module', 'MODULE_BOXES_SPECIALS_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_SPECIALS_CONTENT_PLACEMENT', 'Right Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_SPECIALS_SORT_ORDER', '5060', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable What\'s New Module', 'MODULE_BOXES_WHATS_NEW_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_WHATS_NEW_CONTENT_PLACEMENT', 'Left Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_WHATS_NEW_SORT_ORDER', '1040', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Installed Template Block Groups', 'TEMPLATE_BLOCK_GROUPS', 'boxes;header_tags', 'This is automatically updated. No need to edit.', '6', '0', now());

# Template Block Groups
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Installed Template Block Groups', 'TEMPLATE_BLOCK_GROUPS', 'boxes;header_tags', 'This is automatically updated. No need to edit.', '6', '0', now());