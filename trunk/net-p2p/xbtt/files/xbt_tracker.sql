CREATE SCHEMA `xbt_tracker` DEFAULT CHARACTER SET utf8 ;

USE xbt_tracker;

CREATE TABLE IF NOT EXISTS `xbt_config` (
  `name` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
    
CREATE TABLE IF NOT EXISTS `xbt_deny_from_hosts` (
  `begin` int(10) unsigned NOT NULL,
  `end` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
        
CREATE TABLE IF NOT EXISTS `xbt_files` (
  `fid` int(11) NOT NULL AUTO_INCREMENT,
  `info_hash` binary(20) NOT NULL,
  `leechers` int(11) NOT NULL DEFAULT '0',
  `seeders` int(11) NOT NULL DEFAULT '0',
  `completed` int(11) NOT NULL DEFAULT '0',
  `flags` int(11) NOT NULL DEFAULT '0',
  `mtime` int(11) NOT NULL,
  `ctime` int(11) NOT NULL,
  PRIMARY KEY (`fid`),
  UNIQUE KEY `info_hash` (`info_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `xbt_files_users` (
  `fid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `active` tinyint(4) NOT NULL,
  `announced` int(11) NOT NULL,
  `completed` int(11) NOT NULL,
  `downloaded` bigint(20) unsigned NOT NULL,
  `left` bigint(20) unsigned NOT NULL,
  `uploaded` bigint(20) unsigned NOT NULL,
  `mtime` int(11) NOT NULL,
  UNIQUE KEY `fid` (`fid`,`uid`),
  KEY `uid` (`uid`),
  KEY `fk_xbt_files_users_fid` (`fid`),
  KEY `fk_xbt_files_users_uid` (`uid`),
  CONSTRAINT `fk_xbt_files_users_fid` FOREIGN KEY (`fid`) REFERENCES `xbt_files` (`fid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_xbt_files_users_uid` FOREIGN KEY (`uid`) REFERENCES `xbt_users` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `xbt_users` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `torrent_pass_version` int(11) NOT NULL DEFAULT '0',
  `downloaded` bigint(20) unsigned NOT NULL DEFAULT '0',
  `uploaded` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE USER 'xbtt'@'localhost' IDENTIFIED BY 'defaultpasswd';
GRANT SELECT,UPDATE,INSERT,DELETE ON xbt_tracker.* TO 'xbtt'@'localhost';
FLUSH PRIVILEGES;
                                                                    