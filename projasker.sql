-- phpMyAdmin SQL Dump
-- version 4.0.10.7
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 17, 2015 at 05:13 PM
-- Server version: 5.5.45-cll-lve
-- PHP Version: 5.4.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `projasker`
--

-- --------------------------------------------------------

--
-- Table structure for table `cost`
--

CREATE TABLE IF NOT EXISTS `cost` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estimate` decimal(10,0) DEFAULT NULL COMMENT 'estimated cost',
  `cost` decimal(10,0) DEFAULT NULL COMMENT 'actual cost',
  `start` datetime DEFAULT NULL,
  `due` datetime DEFAULT NULL,
  `integration` datetime DEFAULT NULL,
  `deploy` datetime DEFAULT NULL,
  `task_id` int(11) NOT NULL,
  `project_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `details`
--

CREATE TABLE IF NOT EXISTS `details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `history_id` int(11) NOT NULL,
  `field` varchar(16) NOT NULL,
  `old` text NOT NULL,
  `new` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE IF NOT EXISTS `history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `keyword`
--

CREATE TABLE IF NOT EXISTS `keyword` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) NOT NULL,
  `word` varchar(8) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `link`
--

CREATE TABLE IF NOT EXISTS `link` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL COMMENT 'created task id',
  `child_id` int(11) DEFAULT NULL COMMENT 'child task id',
  `type_id` int(11) DEFAULT NULL COMMENT 'link type (child,orphan, external)',
  `source` varchar(255) DEFAULT NULL COMMENT 'external link to source',
  `attached` datetime DEFAULT NULL,
  `detached` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `project`
--

CREATE TABLE IF NOT EXISTS `project` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `product_id` int(11) DEFAULT NULL COMMENT 'Optional - different projects can have the same product',
  `version_id` int(11) DEFAULT NULL COMMENT 'Only latest released - from table:Version - full version (sub_id = 00). Version is updated with Project id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Project table - related tables: Task, Version, Product' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `status`
--

CREATE TABLE IF NOT EXISTS `status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL,
  `type` varchar(16) DEFAULT NULL,
  `subtype` varchar(16) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `status`
--

INSERT INTO `status` (`id`, `name`, `type`, `subtype`, `description`) VALUES
(1, 'Task', 'Task', 'Type', NULL),
(2, 'Not Started', 'Task', 'Status', NULL),
(3, 'Created', 'Task', 'Substatus', NULL),
(4, 'Not Blocked', 'Task', 'Blocking', NULL),
(5, 'Not Applicable', 'Task', 'Release', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tag`
--

CREATE TABLE IF NOT EXISTS `tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) NOT NULL,
  `tag` varchar(16) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `task`
--

CREATE TABLE IF NOT EXISTS `task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text,
  `creation` datetime NOT NULL,
  `completion` datetime DEFAULT NULL,
  `update` datetime NOT NULL,
  `priority` set('0','1','2','3','4','5','6','7','8','9') DEFAULT NULL,
  `rank` set('A','B','C','D','F') DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL COMMENT 'project',
  `type_id` int(11) NOT NULL DEFAULT '1' COMMENT 'type, default: task',
  `status_id` int(11) NOT NULL DEFAULT '2' COMMENT 'type, default: not started',
  `substatus_id` int(11) NOT NULL DEFAULT '3' COMMENT 'type, default: created',
  `blocking_id` int(11) NOT NULL DEFAULT '4' COMMENT 'type, default: not blocked',
  `release_id` int(11) NOT NULL DEFAULT '5' COMMENT 'type, default: not released',
  `version_id` int(11) DEFAULT NULL,
  `cost_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='related tables: project, type, version, cost' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `version`
--

CREATE TABLE IF NOT EXISTS `version` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` int(11) NOT NULL,
  `sub` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text,
  `notes` text,
  `release` datetime NOT NULL,
  `type_id` int(11) DEFAULT NULL,
  `project_id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
