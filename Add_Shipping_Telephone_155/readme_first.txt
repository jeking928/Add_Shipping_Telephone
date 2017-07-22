********************************************************************************
*                                                                              *
* Copyright 2010 JT of GTI_Custom                                              *
* Licensed under the GNU V2.0 Public License                                   *
* Version 1.2                                                                  *
* October 18, 2010                                                             *
* Changed to use the OVERRIDE SYSTEM and UPDATE DOCS                           *
* Make any changes you want to                                                 *
*                                                                              *
* This modification adds the telephone number to the Shipping Address          *
* of the Customer's Order.                                                     *
* You can add an address during checkout or from their account page.           *
*                                                                              *
* This mod was tested on a New 1.39a install and a 1.39a with                  *
* Super_Orders 2.0 installed.                                                  *
* The phone number will show up in the shipping Address section on             *
* the order confirmation screen, the paper Invoice and Admin Orders Screen.    *
*                                                                              *
* This modification touches 10 store core files and 3 admin core files.        *
* All files are listed below with their changes/additions                      *
* If you have OTHER mods installed that affect any of these files,             *
* you will want to manually enter them yourself, otherwise just merge the      *
* folders and overwrite the files.                                             *
* REMEMBER TO BACKUP YOUR FILES/DATABASE FIRST                                 *
*                                                                              *
* The SQL file modifys 6 fields and adds 2 fields.                             *
* It adds a telephone field to the address_book and the orders tables.         *
* 1) entry_telephone                                                           *
* 2) delivery_telephone                                                        *
*                                                                              *
* The modifed fields are all in the address_format table                       *
* It adds $cr$telephone to the end of the fornat strings                       *
*                                                                              *
********************************************************************************

*****************************************************
* DATABASE CHANGES - See ADD_TELEPHONE_SQL.sql file *
*****************************************************

Copy and paste the ADD_TELEPHONE_SQL.sql file in the Admin Tools Install SQL Patch screen
and press send.

These are the tables that are modified.
table address_book
add field entry_telphone VAR32 NULL (Check your coalition type)

table address_format
fields 1 thru 6

table orders
add field delivery_telephone VAR32 NULL

**************************************************************************
* STORE MODS  - These 10 Core files are the ones that have been changed. *
**************************************************************************

*************************************************************************************
* 1) includes/templates/template_default/YOUR_TEMPLATE/tpl_modules_checkout_new_address *
*************************************************************************************
Add at line 37
<label class="inputLabel" for="telephone"><?php echo ENTRY_TELEPHONE; ?></label>
<?php echo zen_draw_input_field('telephone', '', zen_set_field_length(TABLE_CUSTOMERS, 'customers_telephone', '40') . ' id="telephone"') . (zen_not_null(ENTRY_TELEPHONE_TEXT) ? '<span class="alert">' . ENTRY_TELEPHONE_TEXT . '</span>': ''); ?>
<br class="clearBoth" />

*****************************************************************************************
* 2 )includes/templates/template_default/YOUR_TEMPLATE/tpl_modules_address_book_details.php *
*****************************************************************************************`
Add line 42
<label class="inputLabel" for="telephone"><?php echo ENTRY_TELEPHONE; ?></label>
<?php echo zen_draw_input_field('telephone', $entry->fields['entry_telephone'], zen_set_field_length(TABLE_CUSTOMERS, 'customers_telephone', '40') . ' id="telephone"') . (zen_not_null(ENTRY_TELEPHONE_TEXT) ? '<span class="alert">' . ENTRY_TELEPHONE_TEXT . '</span>': ''); ?>
<br class="clearBoth" />

*************************************
* 3) includes/languages/YOUR_TEMPLATE/english.php *
*************************************
Add at line 205
define('ENTRY_TELEPHONE', 'Telephone #:');
define('ENTRY_TELEPHONE_ERROR', 'Is your telephone number correct? Our system requires a minimum of ' . ENTRY_TELEPHONE_MIN_LENGTH . ' digits. Please try again. (If no number, enter 0000000000');
define('ENTRY_TELEPHONE_TEXT', '*');

*****************************************************************
* 4) includes/modules/pages/address_book_process/header_php.php *
*****************************************************************
Add line 60
$telephone = zen_db_prepare_input(zen_sanitize_string($_POST['telephone']));
Add line 97
if (strlen($telephone) < ENTRY_TELEPHONE_MIN_LENGTH) {
    $error = true;
    $messageStack->add('addressbook', ENTRY_TELEPHONE_ERROR);
Add line 175
array('fieldName'=>'entry_telephone', 'value'=>$telephone, 'type'=>'string'),
Add to end of line 256 what is in the [ ]'s but DO NOT INCLUDE [ ]
  $entry_query = "SELECT entry_gender, entry_company, entry_firstname, entry_lastname, [entry_telephone,]

*********************************
* 5) includes/classes/order.php *
*********************************
Add to end of line 48
delivery_telephone,
Add line 147
'telephone' => $order->fields['delivery_telephone'],
Add inside line 258 what is in the [ ]'s but DO NOT INCLUDE [ ]
$shipping_address_query = "select ab.entry_firstname, ab.entry_lastname, [ab.entry_telephone,] ab.entry_company,
Add line 410
'telephone' => $shipping_address->fields['entry_telephone'],
Add line 603
'delivery_telephone' => $this->delivery['telephone'],

*************************************************
* 6) includes/functions/functions_customers.php *
*************************************************
Add line 54
$telephone = zen_output_string_protected($address['telephone']);
Add to end of line 120 what is in the [ ]'s but DO NOT INCLUDE [ ]
$address_query = "select entry_firstname as firstname, entry_lastname as lastname, [entry_telephone as telephone,]

************************************************
* 7) includes/modules/checkout_new_address.php *
************************************************
Add at line 36
$telephone = zen_db_prepare_input($_POST['telephone']);

Add at line 67
if (strlen($telephone) < ENTRY_TELEPHONE_MIN_LENGTH) {
      $error = true;
      $messageStack->add('checkout_telephone', ENTRY_TELEPHONE_ERROR);
    }
Add at line 141
array('fieldName'=>'entry_telephone','value'=>$telephone, 'type'=>'string'),

*************************************************
* 8) includes/modules/YOUR_TEMPLATE/checkout_address_book.php *
*************************************************
Add to end of line 16 what is in the [ ]'s but DO NOT INCLUDE [ ]
$addresses_query = "select address_book_id, entry_firstname as firstname, entry_lastname as lastname, [entry_telephone as telephone,]

******************************************
* 9) includes/modules/YOUR_TEMPLATE/create_account.php *
******************************************
Add to end of line 277
'entry_telephone' => $telephone,

**********************************************************
* 10) includes/modules/pages/address_book/header_php.php *
**********************************************************
Add to end of line 22 what is in the [ ]'s but DO NOT INCLUDE [ ]
$addresses_query = "SELECT address_book_id, entry_firstname as firstname, entry_lastname as lastname, [entry_telephone as telephone,]
Add line 38
'telephone'=>$addresses->fields['telephone'],

*****************************************************************************
*****************************************************************************

***********************
* ADMIN MODIFICATIONS *
***********************

**************************
* 1) admin/customers/php *
**************************
Add to the end of line 24
entry_telephone as telephone,
Add line 271
'entry_telephone' => $entry_telephone,

***************************************
* 2) admin/includes/classes/order.php *
***************************************
Add to end of line 28 what is in the [ ]'s but DO NOT INCLUDE [ ]
customers_email_address, customers_address_format_id, delivery_name, [delivery_telephone,]
Add line 102
'telephone' => $order->fields['delivery_telephone'],
Add line 113
'telephone' => $order->fields['customers_telephone'],

*******************************************************
* 3) admin/includes/functions/functions_customers.php *
*******************************************************
Add line 54
$telephone = zen_output_string_protected($address['telephone']);
Add to end of line 120 what is in the [ ]'s but DO NOT INCLUDE [ ]
$address_query = "select entry_firstname as firstname, entry_lastname as lastname, [entry_telephone as telephone,]

