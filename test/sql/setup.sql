SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `datatypes`;
CREATE TABLE `datatypes`  (
  `pk` int(10) UNSIGNED NOT NULL AUTO_INCREMENT
  ,`bitField` bit(1) NOT NULL DEFAULT b'0'
  ,`dateField` date NOT NULL
  ,`datetimeField` datetime NOT NULL
  ,`textField` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL 
  ,`tinyintField` tinyint(1) UNSIGNED NOT NULL
  ,`varcharField` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL
  ,PRIMARY KEY (`pk`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;
SET FOREIGN_KEY_CHECKS = 1;