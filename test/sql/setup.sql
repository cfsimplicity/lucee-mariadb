SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `datatypes`;
CREATE TABLE `datatypes`  (
  `pk` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT
  ,`bitField` BIT(1) NULL
  ,`booleanField` BOOLEAN NULL
  ,`dateField` DATE NULL
  ,`datetimeField` DATETIME NULL
  ,`intField` INT(10) NULL
  ,`textField` TEXT CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL 
  ,`tinyintField` TINYINT(1) UNSIGNED NULL
  ,`varcharField` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL
  ,PRIMARY KEY (`pk`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;
SET FOREIGN_KEY_CHECKS = 1;