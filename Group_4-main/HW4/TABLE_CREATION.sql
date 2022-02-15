CREATE TABLE `User` (
  `uid` int AUTO_INCREMENT,
  `username` varchar(64),
  `email` varchar(255),
  `first_name` varchar(64),
  `last_name` varchar(64),
  `is_manager` bool,
  UNIQUE (`username`),
  UNIQUE (`email`),
  UNIQUE (`first_name`,`last_name`),
  PRIMARY KEY (`uid`)
);

CREATE TABLE `Employee` (
  `eid` int AUTO_INCREMENT,
  `uid` int,
  UNIQUE (`uid`),
  PRIMARY KEY (`eid`),
  FOREIGN KEY (`uid`) REFERENCES `User`(`uid`)
);

CREATE TABLE `Team` (
  `tid` int AUTO_INCREMENT,
  `team_name` varchar(128),
  UNIQUE (`team_name`),
  PRIMARY KEY (`tid`)
);

CREATE TABLE `Role` (
  `rid` int AUTO_INCREMENT,
  `role_name` varchar(128),
  UNIQUE (`role_name`),
  PRIMARY KEY (`rid`)
);

CREATE TABLE `Team_Member` (
  `tmid` int AUTO_INCREMENT,
  `eid` int,
  `tid` int,
  `rid` int,
  PRIMARY KEY (`tmid`),
  FOREIGN KEY (`rid`) REFERENCES `Role`(`rid`),
  FOREIGN KEY (`eid`) REFERENCES `Employee`(`eid`),
  FOREIGN KEY (`tid`) REFERENCES `Team`(`tid`)
);

CREATE TABLE `Third_Party` (
  `tpid` int AUTO_INCREMENT,
  `company_name` varchar(255),
  `address` varchar(255),
  `description` text,
  `client` bool,
  `partner` bool, 
  UNIQUE (`company_name`),
  PRIMARY KEY (`tpid`),
  CHECK (`client` OR `partner`)
);

CREATE TABLE `Project` (
  `pid` int AUTO_INCREMENT,
  `project_name` varchar(128),
  `description` text,
  `start_date` date,
  `end_date` date,
  `is_external` bool,
  PRIMARY KEY (`pid`)
);

CREATE TABLE `helps_or_requests` (
  `hrid` int AUTO_INCREMENT,
  `tpid` int,
  `pid` int,
  `description` text,
  UNIQUE(`tpid`,`pid`),
  PRIMARY KEY (`hrid`),
  FOREIGN KEY (`pid`) REFERENCES `Project`(`pid`),
  FOREIGN KEY (`tpid`) REFERENCES `Third_Party`(`tpid`)
);

CREATE TABLE `Task` (
  `task_id` int AUTO_INCREMENT,
  `task_name` varchar(255),
  `project_id` int,
  `description` text,
  `start_date` date,
  `end_date` date,
  PRIMARY KEY (`task_id`),
  FOREIGN KEY (`project_id`) REFERENCES `Project`(`pid`)
);

CREATE TABLE `Manager` (
  `mid` int AUTO_INCREMENT,
  `uid` int,
  `pid` int,
  UNIQUE (`mid`,`pid`),
  UNIQUE (`uid`),
  PRIMARY KEY (`mid`),
  FOREIGN KEY (`pid`) REFERENCES `Project`(`pid`),
  FOREIGN KEY (`uid`) REFERENCES `User`(`uid`)
);

CREATE TABLE `assigned` (
  `aid` int AUTO_INCREMENT,
  `eid` int,
  `rid` int,
  `task_id` int,
  UNIQUE(`eid`,`task_id`),
  PRIMARY KEY (`aid`),
  FOREIGN KEY (`task_id`) REFERENCES `Task`(`task_id`),
  FOREIGN KEY (`rid`) REFERENCES `Role`(`rid`),
  FOREIGN KEY (`eid`) REFERENCES `Employee`(`eid`)
);
