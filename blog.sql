-- MySQL dump 10.13  Distrib 5.7.16, for Linux (x86_64)
--
-- Host: localhost    Database: blog
-- ------------------------------------------------------
-- Server version	5.7.16-0ubuntu2-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `article`
--

DROP TABLE IF EXISTS `article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `context` text,
  `type_id` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_article_title` (`title`),
  KEY `ix_article_addtime` (`addtime`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article`
--

LOCK TABLES `article` WRITE;
/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` VALUES (10,'lisi的flask框架','<p>lisi的flask框架，啦啦啦啦<br/></p>',5,4,1,'2018-04-28 22:18:54'),(11,'李四的博爱可','<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;lalallalall啦啦啦啦&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</p>',5,4,1,'2018-04-28 23:14:48'),(12,'lisi 的第二个博客','<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;django写的框架&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</p>',6,4,2,'2018-04-29 10:00:18'),(13,'王五的博客','<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;这里写你的初始化内容&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 王五<span style=\"font-size: 20px; color: rgb(255, 0, 0);\">的测试</span>用博<span style=\"color: rgb(255, 0, 0);\">客</span></p>',6,5,1,'2018-04-29 20:15:14'),(14,'鼠标右键设置','<p>&nbsp; &nbsp;</p><p>删除鼠标右键选项可以利用注册表或者Windows优化大师。</p><p>一、在注册表中删除不常用的右键菜单</p><p>1、开始 - 运行（输入regedit）- 确定或者回车；</p><p>2、打开“注册表编辑器”窗口， 找到：HKEY_CLASSES_ROOT并点HKEY_CLASSES_ROOT前面的小三角展开；</p><p>3、在HKEY_CLASSES_ROOT展开项中找到：*，并点 * 前面的小三角展开，再在 * 的展开项中找到shellex，在shellex展开项中找到：Context MenuHandlers，在Context MenuHandlers展开项中找到要删除的无用项，然后右键点击该项删除，即可清除右键菜单中的对应选项；</p><p>4、在HKEY_CLASSES_ROOT展开项中找到：Folder\\shell，在Folder\\shell展开项中找到shell，在shell展开项中找到要删除的无用项，然后右键点击该项删除，即可清除右键菜单中的对应选项；</p><p>5、在HKEY_CLASSES_ROOT展开项中找到：Folder\\shellex\\ContextMenuHandlers，在ContextMenuHandlers展开项中找到要删除的无用项，然后右键点击该项删除，即可清除右键菜单中的对应选项；</p><p>6、在HKEY_CLASSES_ROOT展开项中找到：Directory\\shell，并在shell展开项中找到要删除的无用项，然后右键点击该项删除，即可清除右键菜单中的对应选项；</p><p>7、在HKEY_CLASSES_ROOT展开项中找到：Directory\\shellex\\ContextMenuHandlers，并在ContextMenuHandlers展开项中找到要删除的无用项，然后右键点击该项删除，即可清除右键菜单中的对应选项；</p><p>8、清除任何显卡生成的桌面右键菜单在HKEY_CLASSES_ROOT展开项中找到：Directory\\Background \\shellex\\ContextMenuHandlers，删除igfxcui键（显卡），保留个New，重新启动计算机或者注销即可删除桌面右键菜单中的显卡菜单选项。</p><p>二、利用Windows优化大师</p><p>1、启动windows优化大师，点击系统优化---系统个性设置--右键菜单下更多设置；</p><p>2、点击不同选项卡，可清理不同类别菜单项，选定后点击删除即可</p><p><br/></p>',3,5,1,'2018-04-29 22:38:24'),(15,'table标签的使用啊啊啊dagaf','<p>&nbsp; &nbsp; &nbsp; &nbsp;</p><p>agg表格(修改)</p><p>&lt;table border=‘数字’&gt; table代表一个表格&nbsp; border代表边框的粗细</p><p><span style=\"white-space:pre\"></span>&lt;tr&gt;用来分区分有多少行，一对tr代表一行</p><p><span style=\"white-space:pre\"></span>&lt;th&gt;一对代表表格的一个标题行(表头，有居中加粗的效果)&lt;/th&gt;能设置两排表头吗?</p><p><span style=\"white-space:pre\"></span>&lt;td&gt;一对td代表一行里的一个普通单元格&lt;/td&gt;</p><p><span style=\"white-space:pre\"></span>&lt;/tr&gt;</p><p><span style=\"white-space:pre\"></span>在给表格设置属性时（如字体，背景色等），要考虑优先级的问题，</p><p>&lt;/table&gt;&nbsp;</p><p>cellpadding 定义单元格内容与边框的距离</p><p>cellspacing 定义单元格与单元格之间的距离 cellspacing=“0”时，单元格之间无边距</p><p>align设置单元格中内容的水平对齐方式设置有：left | center |right</p><p>valign 设置单元格中内容的垂直对齐方式 top | middle | botton&nbsp;</p><p>colspan 设置单元格水平合并&nbsp; &nbsp;放在td内 colspan=‘数字’ 需把要合并的单元格内容删除，否则会多处一部分</p><p>rowspan 设置单元格垂直合并&nbsp; 放在td内 rowspan=‘数字’ 需把要合并的单元格内容删除，否则会多处一部分</p><p><br/></p>',6,1,1,'2018-04-30 10:27:41'),(16,'table标签的使用(改','<p>&nbsp; &nbsp; &nbsp; &nbsp;</p><p>表格(改)</p><p>&lt;table borde<span style=\"color: rgb(255, 0, 0);\">r=‘数字’&gt; table代表一个表格&nbsp; border代表边框的粗细</span></p><p><span style=\"white-space:pre\"></span>&lt;tr&gt;用来分区分有多少行，一对tr代表一行</p><p><span style=\"white-space:pre\"></span>&lt;th&gt;一对代表表格的一个标题行(表头，有居中加粗的效果)&lt;/th&gt;能设置两排表头吗?</p><p><span style=\"white-space:pre\"></span>&lt;td&gt;一对td代表一行里的一个普通单元格&lt;/td&gt;</p><p><span style=\"white-space:pre\"></span>&lt;/tr&gt;</p><p><span style=\"white-space:pre\"></span>在给表格设置属性时（如字体，背景色等），要考虑优先级的问题，</p><p>&lt;/table&gt;&nbsp;</p><p>cellpadding 定义单元格内容与边框的距离</p><p>cellspacing 定义单元格与单元格之间的距离 cellspacing=“0”时，单元格之间无边距</p><p>align设置单元格中内容的水平对齐方式设置有：left | center |right</p><p>valign 设置单元格中内容的垂直对齐方式 top | middle | botton&nbsp;</p><p>colspan 设置单元格水平合并&nbsp; &nbsp;放在td内 colspan=‘数字’ 需把要合并的单元格内容删除，否则会多处一部分</p><p>rowspan 设置单元格垂直合并&nbsp; 放在td内 rowspan=‘数字’ 需把要合并的单元格内容删除，否则会多处一部分</p><p><br/></p>',4,1,1,'2018-04-30 11:12:07');
/*!40000 ALTER TABLE `article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ats`
--

DROP TABLE IF EXISTS `ats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(11) DEFAULT NULL,
  `tags_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ats`
--

LOCK TABLES `ats` WRITE;
/*!40000 ALTER TABLE `ats` DISABLE KEYS */;
INSERT INTO `ats` VALUES (11,10,11),(12,10,12),(13,10,13),(14,11,12),(15,12,14),(16,13,15),(17,13,16),(18,14,17),(19,15,18),(20,16,19),(21,15,19),(22,15,18),(23,15,19),(24,15,20);
/*!40000 ALTER TABLE `ats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `con` text,
  `to_id` int(11) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_comment_addtime` (`addtime`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (3,14,5,'@lisi\r\n挺想你的',4,'2018-04-29 23:07:09'),(4,15,1,'                                    zhagn',1,'2018-05-02 19:09:16'),(5,15,4,'@zhangsannioahaofjoajfa\r\n',1,'2018-05-02 19:10:44'),(6,15,4,'                                    ldjglksjglksflsa',1,'2018-05-02 19:10:56');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `tagname` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_tags_tagname` (`tagname`),
  KEY `ix_tags_uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (11,4,'python'),(12,4,'flask'),(13,4,'html'),(14,4,'django框架'),(15,5,'pyhthon'),(16,5,'mysql'),(17,5,'windows'),(18,1,'html'),(19,1,'python'),(20,1,'fladkk');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `types`
--

DROP TABLE IF EXISTS `types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tname` varchar(50) DEFAULT NULL,
  `pid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_types_tname` (`tname`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `types`
--

LOCK TABLES `types` WRITE;
/*!40000 ALTER TABLE `types` DISABLE KEYS */;
INSERT INTO `types` VALUES (1,'agjalgjaf',0),(2,'后端',0),(3,'html',1),(4,'django',1),(5,'flask框架',1),(6,'python',2),(7,'js',1);
/*!40000 ALTER TABLE `types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `pwd` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `face` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `ix_user_addtime` (`addtime`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'zhangsan','e10adc3949ba59abbe56e057f20f883e','akgjlajf@qq.com','118','user.jpg',1,'2018-04-28 21:14:27'),(4,'lisi','e10adc3949ba59abbe56e057f20f883e','lisi@qq.com','112','user.jpg',1,'2018-04-28 22:17:26'),(5,'wangwu','e10adc3949ba59abbe56e057f20f883e','wangwu@qq.com','112','user.jpg',1,'2018-04-29 20:13:12');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-05-02 19:34:07
