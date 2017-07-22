ALTER TABLE `address_book` ADD `entry_telephone` VARCHAR(32) NULL DEFAULT NULL AFTER `entry_lastname`;

ALTER TABLE `orders` ADD `delivery_telephone` VARCHAR(32) NULL DEFAULT NULL AFTER `delivery_country`;

UPDATE `address_format` SET `address_format` = '$firstname $lastname$cr$streets$cr$city $state $postcode$cr$country$cr$telephone' WHERE `address_format`.`address_format_id` = 1;
UPDATE `address_format` SET `address_format` = '$firstname $lastname$cr$streets$cr$city $state $postcode$cr$country$cr$telephone' WHERE `address_format`.`address_format_id` = 2;
UPDATE `address_format` SET `address_format` = '$firstname $lastname$cr$streets$cr$city $state $postcode$cr$country$cr$telephone' WHERE `address_format`.`address_format_id` = 3;
UPDATE `address_format` SET `address_format` = '$firstname $lastname$cr$streets$cr$city $state $postcode$cr$country$cr$telephone' WHERE `address_format`.`address_format_id` = 4;
UPDATE `address_format` SET `address_format` = '$firstname $lastname$cr$streets$cr$city $state $postcode$cr$country$cr$telephone' WHERE `address_format`.`address_format_id` = 5;
UPDATE `address_format` SET `address_format` = '$firstname $lastname$cr$streets$cr$city $state $postcode$cr$country$cr$telephone' WHERE `address_format`.`address_format_id` = 6;
UPDATE `address_format` SET `address_format` = '$firstname $lastname$cr$streets$cr$city $state $postcode$cr$country$cr$telephone' WHERE `address_format`.`address_format_id` = 7;

