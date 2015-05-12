CREATE TABLE `hiera` (
  `_id` int(11) NOT NULL AUTO_INCREMENT,
  `var` varchar(45) NOT NULL,
  `val` text NOT NULL,
  `environment` varchar(45) NOT NULL,
  `hostgroup` varchar(45) NOT NULL DEFAULT 'common',
  `hostname` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`_id`)
) ENGINE=InnoDB AUTO_INCREMENT=573 DEFAULT CHARSET=utf8
