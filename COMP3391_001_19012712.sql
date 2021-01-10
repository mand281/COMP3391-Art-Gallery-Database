/* -------------------------------------------
COMP3391 PRACTICAL DATABASE APPLICATIONS
Student no: 19012712
Submission: 8th January 2021
Assignment 1


/* -------------------------------------------	
  DROP DATABASE
 ------------------------------------------- */	

DROP DATABASE IF EXISTS COMP3391_19012712;

/* -------------------------------------------	
 CREATE DATABASE
 ------------------------------------------- */	
CREATE DATABASE IF NOT EXISTS COMP3391_19012712;

USE COMP3391_19012712;

/* -------------------------------------------	
 DROP TABLES
 ------------------------------------------- */	

DROP TABLE IF EXISTS artist;
DROP TABLE IF EXISTS artwork;
DROP TABLE IF EXISTS artwork_exhibition;
DROP TABLE IF EXISTS art_genre;
DROP TABLE IF EXISTS art_medium;
DROP TABLE IF EXISTS collector;
DROP TABLE IF EXISTS collector_contact;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS exhibition_staff;
DROP TABLE IF EXISTS exhibition;
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS staff_role;

/* -------------------------------------------	
CREATE TABLES
 ------------------------------------------- */	

CREATE TABLE IF NOT EXISTS artist
(
Artist_ID CHAR(6) NOT NULL,
Artist_First_Name VARCHAR(20) NOT NULL,
Artist_Last_Name VARCHAR(25) NOT NULL,
Artist_Birth_Date DATE,
Artist_Death_Date DATE,
Artist_Living BOOLEAN,
Artist_Email VARCHAR(30),
Artist_Phone INT,
Artist_Website VARCHAR(50),
CONSTRAINT PK_ar_Artist PRIMARY KEY(Artist_ID)
);


CREATE TABLE IF NOT EXISTS artwork
(
Artwork_ID CHAR(6) NOT NULL,
Artwork_Artist_ID CHAR(6) NOT NULL,
Artwork_Medium_ID CHAR(6) NOT NULL,
Artwork_Genre_ID CHAR(6) NOT NULL,
Artwork_Created DATE,
Artwork_Title VARCHAR(50),
Artwork_Price_GBP DECIMAL(10,2),
Artwork_Sold BOOLEAN,
CONSTRAINT PK_aw_ID PRIMARY KEY(Artwork_ID),
CONSTRAINT FK_aw_Artist  FOREIGN KEY(Artwork_Artist_ID) REFERENCES artist(Artist_ID),
CONSTRAINT FK_aw_Medium  FOREIGN KEY(Artwork_Medium_ID) REFERENCES art_medium(Art_Medium_ID),
CONSTRAINT FK_aw_Genre  FOREIGN KEY(Artwork_Genre_ID) REFERENCES art_genre(Art_Genre_ID)
);


CREATE TABLE IF NOT EXISTS artwork_exhibition
(
Exhibition_ID CHAR(6) NOT NULL,
Artwork_ID CHAR(6) NOT NULL,
CONSTRAINT FK_ae_Exhibition  FOREIGN KEY(Exhibition_ID) REFERENCES exhibition(Exhibition_ID ),
CONSTRAINT FK_ae_Artwork FOREIGN KEY(Artwork_ID) REFERENCES artwork(Artwork_ID)
);


CREATE TABLE IF NOT EXISTS art_genre
(
Art_Genre_ID CHAR(6) NOT NULL,
Art_Genre_Desc VARCHAR(35),
CONSTRAINT PK_ag_Art_Genre PRIMARY KEY(Art_Genre_ID)
);


CREATE TABLE IF NOT EXISTS art_medium
(
Art_Medium_ID CHAR(6) NOT NULL,
Art_Medium_Desc VARCHAR(35),
CONSTRAINT PK_am_Art_Medium PRIMARY KEY(Art_Medium_ID)
);


CREATE TABLE IF NOT EXISTS collector
(
Collector_ID CHAR(6) NOT NULL,
Collector_Name VARCHAR(30) NOT NULL,
Collector_Addr1 VARCHAR(30) NOT NULL,
Collector_Addr2 VARCHAR(30) NOT NULL,	
Collector_Addr3 VARCHAR(30) NOT NULL,
Collector_Postcode CHAR(8) NOT NULL,
Collector_Phone INT,
Collector_Email VARCHAR(30),
CONSTRAINT PK_co_Collector PRIMARY KEY(Collector_ID)
);


CREATE TABLE IF NOT EXISTS collector_contact 
(
Collector_Contact_ID  CHAR(6) NOT NULL,
Collector_ID CHAR(6),
Customer_ID CHAR(6),
Mailing_list BOOLEAN NOT NULL,
CONSTRAINT PK_cc_collector_contact PRIMARY KEY(Collector_Contact_ID),
CONSTRAINT FK_cc_collector  FOREIGN KEY(Collector_ID) REFERENCES collector(Collector_ID),
CONSTRAINT FK_cc_customer FOREIGN KEY(Customer_ID) REFERENCES customer(Customer_ID)
);


CREATE TABLE IF NOT EXISTS customer
(
Customer_ID CHAR(6) NOT NULL,
Customer_Title VARCHAR(10),
Customer_First_Name VARCHAR(30),
Customer_Last_Name VARCHAR(30) NOT NULL,
Customer_Addr1 VARCHAR(30) NOT NULL,
Customer_Addr2 VARCHAR(30) NOT NULL,	
Customer_Addr3 VARCHAR(30) NOT NULL,
Customer_Postcode CHAR(8) NOT NULL,
Customer_Phone INT,
Customer_Email VARCHAR(30),
CONSTRAINT PK_cu_Customer PRIMARY KEY(Customer_ID),
CONSTRAINT CHK_cu_Customer_Title CHECK(Customer_Title IN ('Mr','Mrs','Miss','Mx','Dr','Sir')
);

CREATE TABLE IF NOT EXISTS exhibition_staff
(
Exhibition_ID CHAR(6) NOT NULL,
Staff_ID CHAR(6) NOT NULL,
CONSTRAINT FK_es_Exhibition_Staff FOREIGN KEY(Exhibition_ID) REFERENCES Exhibition(Exhibition_ID),
CONSTRAINT FK_es_Staff FOREIGN KEY(Staff_ID) REFERENCES staff(Staff_ID)
);

	
CREATE TABLE IF NOT EXISTS exhibition 
(
Exhibition_ID CHAR(6) NOT NULL,
Exhibition_Desc	VARCHAR(30) NOT NULL,
Exhibition_Date_Start DATE NOT NULL,	
Exhibition_Date_End DATE NOT NULL,
CONSTRAINT PK_ex_ExhibitionID PRIMARY KEY(Exhibition_ID),
CONSTRAINT CHK_Exhibition_Dates CHECK(Exhibition_Date_Start<Exhibition_Date_End)
);

	
CREATE TABLE IF NOT EXISTS sales
(
Sales_ID CHAR(6) NOT NULL,
Sales_Customer_ID CHAR(6) NOT NULL,
Sales_Artwork_ID CHAR(6) NOT NULL,
Sales_Exhibition_ID CHAR(6) NOT NULL,
Sales_Amount_GBP DECIMAL (10,2) NOT NULL,
Sales_Date DATE NOT NULL,
CONSTRAINT PK_sa_ID PRIMARY KEY(Sales_ID),
CONSTRAINT FK_sa_Customer FOREIGN KEY(Sales_Customer_ID) REFERENCES customer(Customer_ID),
CONSTRAINT FK_sa_Artwork FOREIGN KEY(Sales_Artwork_ID) REFERENCES artwork(Artwork_ID),
CONSTRAINT FK_sa_Exhibition FOREIGN KEY(Sales_Exhibition_ID) REFERENCES Exhibition(Exhibition_ID)
);

	
CREATE TABLE IF NOT EXISTS staff
(
Staff_ID CHAR(6) NOT NULL,
Staff_Role_ID CHAR(6) NOT NULL,
Staff_First_Name VARCHAR(20) NOT NULL,
Staff_Last_Name VARCHAR(30) NOT NULL,
Staff_Addr1 VARCHAR(30) NOT NULL,
Staff_Addr2 VARCHAR(30) NOT NULL,	
Staff_Addr3 VARCHAR(30) NOT NULL,
Staff_Postcode CHAR(8) NOT NULL,
Staff_Phone INT,
Staff_Email VARCHAR(30),
CONSTRAINT PK_st_StaffID PRIMARY KEY(Staff_ID),
CONSTRAINT FK_st_Staff_Role_ID FOREIGN KEY(Staff_Role_ID) REFERENCES staff_role(Staff_Role_ID)
);


CREATE TABLE IF NOT EXISTS staff_role
(
Staff_Role_ID CHAR(6) NOT NULL,
Staff_Role_Desc VARCHAR(20) NOT NULL,
CONSTRAINT PK_sr_Staff_Role PRIMARY KEY(Staff_Role_ID)
);


/* -------------------------------------------	
 CREATE INDEXES
 ------------------------------------------- */	
	
CREATE INDEX IND_Artwork ON artwork(Artwork_Title,Artwork_Price_GBP);
CREATE INDEX IND_Artist ON artist(Artist_First_Name,Artist_Last_Name);
CREATE INDEX IND_art_genre ON art_genre(Art_Genre_Desc);
CREATE INDEX IND_art_medium ON art_medium(Art_Medium_Desc);
CREATE INDEX IND_collector ON collector(Collector_ID,Collector_Name);
CREATE INDEX IND_customer ON customer(Customer_ID,Customer_First_Name,Customer_Last_Name);
CREATE INDEX IND_exhibition ON exhibition (Exhibition_ID,Exhibition_Date_Start,Exhibition_Date_End);
CREATE INDEX IND_sales ON sales(Sales_ID,Sales_Amount_GBP, Sales_Date);
CREATE INDEX IND_Staff ON staff(Staff_ID,Staff_First_Name,Staff_Last_Name);

/* -------------------------------------------	
 CREATE TEST RECORDS 
------------------------------------------- */	
		
/* -------------------------------------------	
 INSERT VALUES INTO TABLE artist
------------------------------------------- */	

INSERT INTO artist (Artist_ID, Artist_First_Name , Artist_Last_Name , Artist_Birth_Date, Artist_Death_Date, Artist_Living, Artist_Email, Artist_Phone,  Artist_Website) values 
('AR1000', 'Thomasin', 'Finding', '1925-10-13 02:12:02', null, false, 'tfinding0@google.es', '348 462 7349', 'xing.com') ,
 ('AR1001', 'Roanna', 'Assiratti', '1920-12-25 09:52:16', null, false, 'rassiratti1@icio.us', '207 145 3522', 'is.gd') ,
 ('AR1002', 'Lizette', 'Dorre', '1923-09-25 13:13:20', null, false, 'ldorre2@oaic.gov.au', '286 633 0892', 'dell.com') ,
 ('AR1003', 'Natale', 'Shopcott', '1940-03-16 10:21:14', null, false, 'nshopcott3@ted.com', '471 682 6061', 'buzzfeed.com') ,
 ('AR1004', 'Derrek', 'Castelluzzi', '1930-05-31 02:23:32', '1990-07-31 19:28:08', true, 'dcastelluzzi4@i2i.jp', '923 626 6205', 'abc.net.au') ,
 ('AR1005', 'Stoddard', 'Potell', '1922-03-05 17:52:34', null, false, 'spotell5@blogger.com', '281 558 3837', 'reddit.com') ,
 ('AR1006', 'Berthe', 'Sidery', '1940-07-11 21:39:26', null, true, 'bsidery6@tuttocitta.it', '445 235 9418', 'flickr.com') ,
 ('AR1007', 'Wilfred', 'Gowdie', '1932-11-20 08:24:24', null, true, 'wgowdie7@de.vu', '445 126 8615', 'jiathis.com') ,
 ('AR1008', 'Jeanette', 'Cranke', '1933-09-16 00:40:21', null, false, 'jcranke8@wikia.com', '356 112 4956', 'pagesperso-orange.fr') ,
 ('AR1009', 'Trixi', 'Daniau', '1933-06-14 10:24:47', null, true, 'tdaniau9@opensource.org', '793 702 1074', 'netvibes.com') ,
 ('AR1010', 'Irita', 'Lettson', '1923-08-18 10:08:12', null, true, 'ilettsona@oaic.gov.au', '440 923 0599', 'about.me') ,
 ('AR1011', 'Brinn', 'Ede', '1926-07-23 05:03:45', '1999-06-05 10:38:01', false, 'bedeb@nhs.uk', '949 630 6828', 'uiuc.edu') ,
 ('AR1012', 'Ferd', 'Mauditt', '1930-08-28 04:55:59', '2008-07-24 09:38:17', false, 'fmaudittc@over-blog.com', '100 131 2523', 'tamu.edu') ,
 ('AR1013', 'Julina', 'Roncelli', '1938-05-05 14:53:02', '1973-04-16 06:22:39', false, 'jroncellid@wisc.edu', '271 291 2749', 'shutterfly.com') ,
 ('AR1014', 'Shanna', 'Pember', '1937-02-09 23:01:19', '1980-04-08 01:10:54', false, 'spembere@people.com.cn', '380 599 6095', 'apple.com') ,
 ('AR1015', 'Alvinia', 'Uttermare', '1937-09-09 04:19:41', null, true, 'auttermaref@gravatar.com', '739 477 6282', 'arizona.edu') ,
 ('AR1016', 'Gloriana', 'Pimblett', '1939-01-14 21:38:49', null, true, 'gpimblettg@elpais.com', '829 676 2271', 'usgs.gov') ,
 ('AR1017', 'Art', 'Roiz', '1937-05-15 14:50:25', null, true, 'aroizh@imdb.com', '504 206 9512', 'kickstarter.com') ,
 ('AR1018', 'Junie', 'Doughill', '1928-01-05 19:50:33', null, true, 'jdoughilli@acquirethisname.com', '836 121 4625', 'cbslocal.com') ,
 ('AR1019', 'Rurik', 'Matussov', '1931-04-26 05:34:44', '1973-09-22 00:04:30', false, 'rmatussovj@squidoo.com', '789 821 6908', 'naver.com') ,
 ('AR1020', 'Sylvester', 'Aberhart', '1937-01-21 22:15:08', null, true, 'saberhartk@wp.com', '339 434 3410', 'eepurl.com') ,
 ('AR1021', 'Albie', 'Izsak', '1938-06-30 17:39:09', null, true, 'aizsakl@xinhuanet.com', '527 736 6827', '1und1.de') ,
 ('AR1022', 'Beauregard', 'Barnfield', '1931-01-07 04:48:14', null, true, 'bbarnfieldm@webeden.co.uk', '962 825 8250', 'addthis.com') ,
 ('AR1023', 'Ruprecht', 'Berks', '1930-11-25 00:32:46', null, true, 'rberksn@epa.gov', '953 234 7299', 'slideshare.net') ,
 ('AR1024', 'Hedwiga', 'Carrel', '1923-02-23 08:30:19', '2003-10-04 09:32:46', false, 'hcarrelo@biglobe.ne.jp', '420 541 1974', 'stanford.edu') ;

		
/* -------------------------------------------	
 INSERT VALUES INTO TABLE artwork
------------------------------------------- */	

INSERT INTO artwork (Artwork_ID, Artwork_Artist_ID, Artwork_Medium_ID, Artwork_Genre_ID, Artwork_Created, Artwork_Title, Artwork_Price_GBP, Artwork_Sold) values 
('AW1000', 'AR1022', 'AM1006', 'AG1006', '1986-04-03 03:29:19', 'Going Home', 429.13, false) ,
 ('AW1001', 'AR1020', 'AM1012', 'AG1000', '1975-10-12 16:27:09', 'There Was No Harmony There', 129.58, false) ,
 ('AW1002', 'AR1006', 'AM1020', 'AG1025', '1981-04-29 03:19:53', 'It Takes Effort', 890.73, false) ,
 ('AW1003', 'AR1002', 'AM1011', 'AG1003', '2001-10-10 14:46:59', 'You Act Like A Fool To Me', 994.92, true) ,
 ('AW1004', 'AR1009', 'AM1007', 'AG1009', '2003-11-14 21:39:30', 'The Rules Of A Perfect Friendship', 732.51, false) ,
 ('AW1005', 'AR1019', 'AM1001', 'AG1018', '1967-01-08 16:45:00', 'Was It Just A Storm?', 425.65, false) ,
 ('AW1006', 'AR1016', 'AM1014', 'AG1012', '1971-08-18 17:30:47', 'Infinity''s Edge', 474.8, false) ,
 ('AW1007', 'AR1010', 'AM1023', 'AG1008', '2000-07-22 11:48:36', 'Road To Success', 372.48, false) ,
 ('AW1008', 'AR1011', 'AM1001', 'AG1014', '1998-12-04 02:18:17', 'A Moment Suspended In Time', 400.3, false) ,
 ('AW1009', 'AR1023', 'AM1008', 'AG1019', '1977-07-05 18:31:03', 'Fantastic Voyage', 961.01, true) ,
 ('AW1010', 'AR1000', 'AM1017', 'AG1019', '1987-08-28 20:31:03', 'No Wisdom Here', 724.46, false) ,
 ('AW1011', 'AR1022', 'AM1008', 'AG1011', '2013-03-01 12:29:11', 'Darkness Within My Soul', 357.19, false) ,
 ('AW1012', 'AR1001', 'AM1015', 'AG1023', '1974-03-12 15:03:20', 'Should I Follow You?', 550.39, true) ,
 ('AW1013', 'AR1014', 'AM1004', 'AG1011', '1968-01-06 11:24:42', 'Lies Of The Beautiful People', 742.74, false) ,
 ('AW1014', 'AR1009', 'AM1012', 'AG1008', '1992-09-11 15:30:05', 'If You Don''t Wanna Cry Like I Do', 586.21, false) ,
 ('AW1015', 'AR1018', 'AM1013', 'AG1000', '1978-09-28 06:38:22', 'Come Find Me', 513.09, true) ,
 ('AW1016', 'AR1017', 'AM1000', 'AG1018', '2015-12-09 21:40:01', 'Celestial Tide', 143.73, true) ,
 ('AW1017', 'AR1025', 'AM1023', 'AG1005', '1987-10-05 03:15:56', 'Sing Me A Summer Song', 512.44, false) ,
 ('AW1018', 'AR1024', 'AM1001', 'AG1012', '1948-09-25 09:09:52', 'I''m Here Without You', 273.13, false) ,
 ('AW1019', 'AR1007', 'AM1019', 'AG1006', '2018-11-04 11:18:46', 'A Day To Be Remembered', 776.65, false) ,
 ('AW1020', 'AR1007', 'AM1024', 'AG1010', '2018-05-01 15:14:48', 'Dancing In The [Rain', 541.94, true) ,
 ('AW1021', 'AR1023', 'AM1007', 'AG1010', '1940-01-13 12:00:20', 'If You Don''t Wanna Cry Like I Do', 744.27, true) ,
 ('AW1022', 'AR1012', 'AM1005', 'AG1009', '1973-02-21 19:35:37', 'Open Your Eyes', 740.19, false) ,
 ('AW1023', 'AR1006', 'AM1012', 'AG1008', '2018-09-19 13:14:33', 'A Chill In The Air', 382.72, false) ,
 ('AW1024', 'AR1000', 'AM1004', 'AG1010', '1948-10-24 05:24:22', 'If A Fresh Start', 314.46, true) ;

  
		
/* -------------------------------------------	
 INSERT VALUES INTO TABLE artwork_exhibition
------------------------------------------- */

 INSERT INTO artwork_exhibition (Exhibition_ID, Artwork_ID) values ('EX1006', 'AW1012') ,
 ('EX1024', 'AW1017') ,
 ('EX1003', 'AW1001') ,
 ('EX1025', 'AW1025') ,
 ('EX1010', 'AW1001') ,
 ('EX1006', 'AW1001') ,
 ('EX1020', 'AW1008') ,
 ('EX1017', 'AW1004') ,
 ('EX1020', 'AW1008') ,
 ('EX1001', 'AW1006') ,
 ('EX1010', 'AW1015') ,
 ('EX1012', 'AW1017') ,
 ('EX1015', 'AW1013') ,
 ('EX1001', 'AW1020') ,
 ('EX1022', 'AW1023') ,
 ('EX1020', 'AW1010') ,
 ('EX1011', 'AW1015') ,
 ('EX1018', 'AW1007') ,
 ('EX1003', 'AW1019') ,
 ('EX1009', 'AW1003') ,
 ('EX1010', 'AW1008') ,
 ('EX1017', 'AW1007') ,
 ('EX1007', 'AW1015') ,
 ('EX1021', 'AW1023') ,
 ('EX1023', 'AW1000') ;


		
/* -------------------------------------------	
 INSERT VALUES INTO TABLE art_genre
------------------------------------------- */

 INSERT INTO art_genre (Art_Genre_ID, Art_Genre_Desc ) values 
('AG1000', 'Street art'),
('AG1001', 'Romantic'),
('AG1002', 'Folk Art'),
('AG1003', 'Romanesque'),
('AG1004', 'Hyperrealism'),
('AG1005', 'Dadaism'),
('AG1006', 'Folk art'),
('AG1007', 'Cubism'),
('AG1008', 'Art Nouveau'),
('AG1010', 'Expressionism'),
('AG1011', 'Pop Art'),
('AG1012', 'Gothic art'),
('AG1013', 'Impressionism'),
('AG1014', 'Expressionism'),
('AG1015', 'Renaissance'),
('AG1016', 'Landscape'),
('AG1017', 'Art Deco'),
('AG1018', 'Contemporary Art'),
('AG1019', 'Still Life'),
('AG1020', 'Portraiture'),
('AG1022', 'Kitsch movement'),
('AG1024', 'Surrealism') ;

		
/* -------------------------------------------	
 INSERT VALUES INTO TABLE art_medium
------------------------------------------- */

 INSERT INTO art_medium (Art_Medium_ID, Art_Medium_Desc) values 
('AM1000', 'Chalk'),
('AM1001', 'Pencil') ,
('AM1002', 'Charcoal'),
('AM1003', 'Acrylic paint') ,
('AM1004', 'Watercolour') ,
('AM1005', 'Gouache') ,
('AM1006', 'Oil Paint') ,
('AM1007', 'Collage') ,
('AM1008', 'Conte') ,
('AM1009', 'Graphite Pencil') ,
('AM1010', 'Oil Pastel') ,
('AM1011', 'Chalk Pastel') ,
('AM1012', 'Coloured Pencil') ,
('AM1013', 'Mixed Media') ,
('AM1014', 'Tempura') ,
('AM1015', 'Digital Art') ,
('AM1016', 'Photography') ,
('AM1017', 'Sculpture') ,
('AM1018', 'Pottery') ,
('AM1019', 'Silk Screen Print') ,
('AM1020', 'Lino Print') ,
('AM1021', 'Pen and Ink') ;


		
/* -------------------------------------------	
 INSERT VALUES INTO TABLE collector
------------------------------------------- */

INSERT INTO collector (Collector_ID, Collector_Name, Collector_Addr1, Collector_Addr2, Collector_Addr3, Collector_Postcode , Collector_Phone , Collector_Email) values 
('CO1000', 'Skinder', '319 Dixon Park', 'Xiyuan', 'Devon', 'ST3 3LR', '138 502 5100', 'ocattach0@pbs.org') ,
  ('CO1001', 'Shufflebeat', '16215 Harper Crossing', 'Sinisian', 'North Ayrshire', 'E3 2PX', '968 485 7024', 'lwinchcomb1@a8.net') ,
  ('CO1002', 'Lajo', '23 Springs Alley', 'Su-ngai Kolok', 'West Berkshire', 'ST3 3LR', '236 161 1234', 'iipplett2@bbb.org') ,
  ('CO1003', 'Realbridge', '48 Melrose Park', 'Calubcub Dos', 'Leicestershire', 'GU14 0BP', '190 605 0727', 'fhumber3@tmall.com') ,
  ('CO1004', 'Yakidoo', '3 Oak Trail', 'Huari', 'Shetland Islands', 'FK1 5AB', '705 158 6477', 'lgilbertson4@amazon.co.jp') ,
  ('CO1005', 'Vinte', '849 Pearson Road', 'Lashkar Gāh', 'Durham', 'WR12 0QJ', '473 162 4336', 'bdefond5@smugmug.com') ,
  ('CO1006', 'Jabberbean', '71 Artisan Point', 'Wupu', 'Northamptonshire', 'CH64 2UG', '625 636 8001', 'thalford6@rediff.com') ,
  ('CO1007', 'Roombo', '049 Monterey Terrace', 'Ábidos', 'Hampshire', 'GL54 2GW', '524 310 5583', 'dlegrand7@hexun.com') ,
  ('CO1008', 'Tazzy', '8 Lerdahl Drive', 'Kittilä', 'Cornwall', 'GU14 0BP', '680 919 3323', 'rmanifield8@domainmarket.com') ,
  ('CO1009', 'Youfeed', '8 Sutteridge Trail', 'Kuala Lumpur', 'Warwickshire', 'GL8 8HH', '332 877 9427', 'csheardown9@sogou.com') ,
  ('CO1010', 'Devpulse', '1511 Roth Court', 'Taochuan', 'City of Edinburgh', 'WR22 2DU', '688 857 1332', 'nstenninga@oaic.gov.au') ,
  ('CO1011', 'Gabspot', '83816 Bay Terrace', 'Mithi', 'Cambridgeshire', 'GU14 0BP', '516 786 5036', 'bgethenb@mtv.com') ,
  ('CO1012', 'Katz', '3814 Caliangt Pass', 'Tuusniemi', 'Flintshire', 'B25 9TE', '710 376 5306', 'liacovoloc@nsw.gov.au') ,
  ('CO1013', 'Brainlounge', '81247 Sutteridge Pass', 'Baiju', 'Gloucestershire', 'GL54 2GW', '493 933 7243', 'kbened@newsvine.com') ,
  ('CO1014', 'Trilia', '820 Knutson Road', 'Livadiya', 'Breconshire', 'KW14 8DG', '914 335 7672', 'cmardlee@google.co.jp') ,
  ('CO1015', 'DabZ', '085 Bunker Hill Plaza', 'Nîmes', 'City of Edinburgh', 'KA8 0DE', '902 766 1875', 'lpidgeonf@gizmodo.com') ,
  ('CO1016', 'Talane', '00664 Daystar Park', 'Ziyuan', 'North Ayrshire', 'B66 3PB', '440 742 6453', 'nclaptong@ihg.com') ,
  ('CO1017', 'Linkbridge', '5 Barby Hill', 'Marumori', 'Lincolnshire', 'GL54 2GW', '429 526 8741', 'cmccombh@independent.co.uk') ,
  ('CO1018', 'Zooveo', '48 Mandrake Lane', 'Nīkêh', 'Somerset', 'CH64 2UG', '727 426 2045', 'clockneri@state.tx.us') ,
  ('CO1019', 'Skipfire', '91428 Scoville Park', 'Ödeshög', 'City of Edinburgh', 'G82 2QH', '496 943 1665', 'gtortisj@hao123.com') ,
  ('CO1020', 'Kare', '20545 Moulton Court', 'Kukichūō', 'East Sussex', 'GU14 0BP', '180 320 1389', 'hbaldacchik@tinyurl.com') ,
  ('CO1021', 'Mudo', '91 Summit Circle', 'Getafe', 'Moray', 'GL54 2GW', '742 113 1434', 'cstichell@nifty.com') ,
  ('CO1022', 'Youtags', '47 Rigney Hill', 'Buckland', 'Northumberland', 'B43 5QD', '281 920 0046', 'llevertonm@hc360.com') ,
  ('CO1023', 'Topdrive', '1123 American Hill', 'Filótion', 'South Ayrshire', 'IP24 3BU', '989 313 1003', 'kdopplern@va.gov') ,
  ('CO1024', 'Leenti', '227 Blackbird Center', 'Sancha', 'Shetland Islands', 'E3 2PX', '893 498 4076', 'afloydo@gizmodo.com') ;


		
/* -------------------------------------------	
 INSERT VALUES INTO TABLE collector_contact
------------------------------------------- */

 INSERT INTO  collector_contact (Collector_Contact_ID, Collector_ID, Customer_ID, Mailing_List) values 
 ('CC1000', null, 'CU1007', true) ,
 ('CC1001', 'CO1009', null, false) ,
  ('CC1002', 'CO1014', null, false) ,
  ('CC1003', null, 'CU1025', true) ,
  ('CC1004', 'CO1019', null, true) ,
  ('CC1005', null, 'CU1014', true) ,
  ('CC1006', 'CO1018', null, true) ,
  ('CC1007', null, 'CU1011', false) ,
  ('CC1008', 'CO1021',null, false) ,
  ('CC1009', 'CO1024', null, true) ,
  ('CC1010', null, 'CU1006', true) ,
  ('CC1011', 'CO1017',null, true) ,
  ('CC1012', null, 'CU1023', false) ,
  ('CC1013', 'CO1004', null, false) ,
  ('CC1014', 'CO1005', null, false) ,
  ('CC1015', 'CO1007', null, false) ,
  ('CC1016', null, 'CU1010', true) ,
  ('CC1017', null, 'CU1005', false) ,
  ('CC1018', null, 'CU1004', true) ,
  ('CC1019', 'CO1003', null, false) ,
  ('CC1020', null, 'CU1013', true) ,
  ('CC1021', 'CO1024', 'CU1018', true) ,
  ('CC1022', 'CO1006', null, false) ,
  ('CC1023', 'CO1000',null, false) ,
  ('CC1024', null, 'CU1015', true) ;


		
/* -------------------------------------------	
 INSERT VALUES INTO TABLE customer
------------------------------------------- */

INSERT INTO customer (Customer_ID , Customer_Title , Customer_First_Name , Customer_Last_Name, Customer_Addr1, Customer_Addr2, Customer_Addr3, Customer_Postcode , Customer_Phone,  Customer_Email) values 
('CU1000', 'Ms', 'Garey', 'Ranscombe', '1 Melby Pass', 'København', 'Northamptonshire', 'IP24 3BU', '717 117 9832', 'granscombe0@google.com.hk') ,
  ('CU1001', 'Honorable', 'Cordey', 'Langan', '984 Cherokee Road', 'Datarsitu', 'North Lanarkshire', 'RH6 8NR', '236 190 9174', 'clangan1@reuters.com') ,
  ('CU1002', 'Dr', 'Ursala', 'Vedishchev', '66833 Daystar Circle', 'Bourg-en-Bresse', 'Gloucestershire', 'B25 9TE', '879 449 9521', 'uvedishchev2@wufoo.com') ,
  ('CU1003', 'Mr', 'Allsun', 'Ashborne', '204 Warbler Road', 'Luuka Town', 'West Sussex', 'GL54 2GW', '443 105 7371', 'aashborne3@hao123.com') ,
  ('CU1004', 'Honorable', 'Jonas', 'Larwood', '31 Leroy Alley', 'Pasiripis', 'East Lothian', 'RH6 8NR', '421 637 6257', 'jlarwood4@discuz.net') ,
  ('CU1005', 'Mr', 'Adriaens', 'McWard', '5 Nancy Pass', 'Huolongping', 'Cleveland', 'GL54 2GW', '646 630 9176', 'amcward5@census.gov') ,
  ('CU1006', 'Honorable', 'Bobbie', 'Mundell', '34 Grayhawk Terrace', 'Ilebo', 'Clackmannanshire', 'TA24 5PL', '849 562 2647', 'bmundell6@blog.com') ,
  ('CU1007', 'Honorable', 'Skipton', 'Danko', '8 Kipling Court', 'Guantun', 'Orkney Islands', 'FK1 5AB', '709 574 9836', 'sdanko7@oracle.com') ,
  ('CU1008', 'Ms', 'Erika', 'Amorine', '547 Johnson Street', 'Kose', 'Scottish Borders', 'KA8 0DE', '619 403 0082', 'eamorine8@scientificamerican.com') ,
  ('CU1009', 'Dr', 'Ansell', 'Seleway', '55 Del Sol Trail', 'Al Jamīmah', 'Stirling', 'WR12 0QJ', '759 741 7192', 'aseleway9@cbc.ca') ,
  ('CU1010', 'Ms', 'Simeon', 'Lux', '438 Dottie Pass', 'Jinjing', 'Falkirk', 'WR22 2DU', '829 317 4918', 'sluxa@miitbeian.gov.cn') ,
  ('CU1011', 'Rev', 'Suzie', 'Kleeman', '97 Bowman Street', 'Viana', 'Moray', 'B25 9TE', '376 475 0590', 'skleemanb@feedburner.com') ,
  ('CU1012', 'Mr', 'Perri', 'Keward', '504 Oakridge Court', 'Tours', 'Lincolnshire', 'FK1 5AB', '172 819 7150', 'pkewardc@mit.edu') ,
  ('CU1013', 'Rev', 'Denice', 'Raisher', '0749 Dakota Alley', 'Muruni', 'Anglesey', 'TR18 2SJ', '553 824 9894', 'draisherd@chicagotribune.com') ,
  ('CU1014', 'Rev', 'Marie-ann', 'Millions', '92 Linden Drive', 'Göteborg', 'Cornwall', 'NG11 8SR', '875 651 4937', 'mmillionse@icq.com') ,
  ('CU1015', 'Mr', 'Katherina', 'Gwyer', '086 Grim Trail', 'Vingåker', 'Northumberland', 'GL54 2GW', '325 485 1726', 'kgwyerf@1und1.de') ,
  ('CU1016', 'Rev', 'Alyssa', 'Gravy', '0 Northwestern Alley', 'Belogorsk', 'City of Edinburgh', 'KY11 1HJ', '231 808 6193', 'agravyg@princeton.edu') ,
  ('CU1017', 'Ms', 'Shoshanna', 'Darlington', '65823 Sauthoff Lane', 'Bagakay', 'Breconshire', 'KA8 0DE', '471 989 1398', 'sdarlingtonh@unicef.org') ,
  ('CU1018', 'Mrs', 'Abby', 'Aylwin', '198 Springs Terrace', 'Alakak', 'Radnorshire', 'CO2 7GS', '713 964 5755', 'aaylwini@oracle.com') ,
  ('CU1019', 'Honorable', 'Theodor', 'Usherwood', '0 Columbus Drive', 'Berat', 'Denbighshire', 'BS11 0UN', '903 864 5644', 'tusherwoodj@amazon.co.jp') ,
  ('CU1020', 'Rev', 'Bertrand', 'Peiro', '97 Oxford Junction', 'New Panamao', 'Caernarvonshire', 'TA24 5PL', '936 446 9399', 'bpeirok@symantec.com') ,
  ('CU1021', 'Honorable', 'Adria', 'Yukhnev', '813 Charing Cross Crossing', 'Delson', 'Angus', 'BS11 0UN', '706 449 9490', 'ayukhnevl@alexa.com') ,
  ('CU1022', 'Ms', 'Fifi', 'Shade', '51324 Warner Junction', 'Nove-Misto', 'Lincolnshire', 'G82 2QH', '683 365 0748', 'fshadem@intel.com') ,
  ('CU1023', 'Mr', 'Van', 'Lauderdale', '4249 Myrtle Avenue', 'Nerekhta', 'Montgomeryshire', 'FY1 1EZ', '242 916 3598', 'vlauderdalen@sciencedirect.com') ,
  ('CU1024', 'Ms', 'Charissa', 'Gueste', '15902 Shopko Trail', 'Nakhon Ratchasima', 'Anglesey', 'FK1 5AB', '589 835 7279', 'cguesteo@tmall.com') ;

		
/* -------------------------------------------	
 INSERT VALUES INTO TABLE exhibition
------------------------------------------- */

INSERT INTO exhibition (Exhibition_ID, Exhibition_Desc , Exhibition_Date_Start, Exhibition_Date_End) values 
('EX1000', 'Etiam justo.', '2020-02-26 17:34:29', '2023-06-22 05:59:44') ,
('EX1001', 'Nulla suscipit ligula in lacus.', '2020-08-01 12:55:20', '2021-01-31 22:54:50') ,
 ('EX1002', 'Praesent blandit.', '2020-06-15 10:20:04', '2023-11-10 19:23:31') ,
  ('EX1003', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.', '2020-07-27 15:22:10', '2023-04-23 00:12:44') ,
  ('EX1004', 'Praesent id massa id nisl venenatis lacinia.', '2020-08-20 12:22:34', '2023-04-08 22:25:40') ,
  ('EX1005', 'In blandit ultrices enim.', '2020-09-17 02:36:50', '2021-05-23 22:20:07') ,
  ('EX1006', 'Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl.', '2020-10-04 06:01:00', '2022-12-04 22:32:03') ,
  ('EX1007', 'Curabitur at ipsum ac tellus semper interdum.', '2020-11-20 02:43:04', '2023-07-20 21:14:08') ,
  ('EX1008', 'Aliquam quis turpis eget elit sodales scelerisque.', '2020-10-11 07:36:03', '2023-10-24 21:33:12') ,
  ('EX1009', 'In hac habitasse platea dictumst.', '2020-05-18 16:12:43', '2023-03-25 17:17:42') ,
  ('EX1010', 'Integer ac leo.', '2020-08-21 10:58:20', '2021-11-14 04:21:30') ,
  ('EX1011', 'Nulla tempus.', '2020-11-08 02:48:38', '2023-03-05 10:54:51') ,
  ('EX1012', 'Nullam varius.', '2020-04-14 19:37:57', '2023-02-09 20:10:27') ,
  ('EX1013', 'Praesent id massa id nisl venenatis lacinia.', '2020-01-25 15:04:24', '2021-10-21 11:25:19') ,
  ('EX1014', 'Quisque porta volutpat erat.', '2020-11-01 18:23:28', '2022-09-03 14:00:35') ,
  ('EX1015', 'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.', '2020-04-29 10:04:33', '2023-03-23 22:05:11') ,
  ('EX1016', 'In hac habitasse platea dictumst.', '2020-10-29 19:29:05', '2022-10-30 02:42:54') ,
  ('EX1017', 'Vivamus tortor.', '2020-11-17 17:09:24', '2023-03-28 12:47:08') ,
  ('EX1018', 'Maecenas tincidunt lacus at velit.', '2020-12-02 04:30:29', '2022-09-24 14:12:03') ,
  ('EX1019', 'Suspendisse potenti.', '2020-10-08 12:30:49', '2022-04-15 08:41:09') ,
  ('EX1020', 'Mauris ullamcorper purus sit amet nulla.', '2020-07-11 13:09:03', '2021-08-27 22:59:46') ,
  ('EX1021', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', '2020-07-08 22:14:03', '2023-11-08 02:35:53') ,
  ('EX1022', 'Morbi quis tortor id nulla ultrices aliquet.', '2020-12-23 06:58:21', '2023-10-28 18:39:38') ,
  ('EX1023', 'Suspendisse accumsan tortor quis turpis.', '2020-09-18 15:08:51', '2023-10-02 14:37:13') ,
  ('EX1024', 'In congue.', '2020-07-20 18:14:44', '2022-11-24 13:27:10') ;

		
/* -------------------------------------------	
 INSERT VALUES INTO TABLE exhibition_staff
------------------------------------------- */

INSERT INTO exhibition_staff (Exhibition_ID, Staff_ID) values
 ('EX1003', 'ES1013') ,
  ('EX1021', 'ES1025') ,
  ('EX1000', 'ES1006') ,
  ('EX1020', 'ES1017') ,
  ('EX1003', 'ES1007') ,
  ('EX1004', 'ES1024') ,
  ('EX1015', 'ES1012') ,
  ('EX1019', 'ES1025') ,
  ('EX1004', 'ES1020') ,
  ('EX1011', 'ES1008') ,
  ('EX1010', 'ES1017') ,
  ('EX1017', 'ES1018') ,
  ('EX1020', 'ES1006') ,
  ('EX1010', 'ES1017') ,
  ('EX1002', 'ES1008') ,
  ('EX1005', 'ES1005') ,
  ('EX1007', 'ES1007') ,
  ('EX1010', 'ES1008') ,
  ('EX1016', 'ES1020') ,
  ('EX1025', 'ES1012') ,
  ('EX1006', 'ES1023') ,
  ('EX1011', 'ES1013') ,
  ('EX1009', 'ES1013') ,
  ('EX1020', 'ES1021') ,
  ('EX1022', 'ES1006') ;

		
/* -------------------------------------------	
 INSERT VALUES INTO TABLE sales
------------------------------------------- */

INSERT INTO sales (Sales_ID , Sales_Customer_ID , Sales_Artwork_ID , Sales_Exhibition_ID , Sales_Amount_GBP, Sales_Date) values 
('SA1000', 'CU1024', 'AW1018', 'EX1009', 4532, '2020-10-21 03:02:06') ,
 ('SA1001', 'CU1015', 'AW1007', 'EX1025', 5830, '2013-11-28 07:14:12') ,
 ('SA1002', 'CU1004', 'AW1014', 'EX1020', 2375, '2011-04-21 13:58:35') ,
 ('SA1003', 'CU1011', 'AW1008', 'EX1011', 1639, '2016-05-03 18:02:50') ,
 ('SA1004', 'CU1009', 'AW1017', 'EX1001', 7001, '2015-03-05 02:37:25') ,
 ('SA1005', 'CU1015', 'AW1010', 'EX1024', 4098, '2018-07-26 22:48:21') ,
 ('SA1006', 'CU1009', 'AW1023', 'EX1023', 2351, '2018-06-13 22:33:55') ,
 ('SA1007', 'CU1012', 'AW1014', 'EX1016', 3037, '2016-07-16 07:02:07') ,
 ('SA1008', 'CU1018', 'AW1009', 'EX1024', 5663, '2012-02-19 23:30:27') ,
 ('SA1009', 'CU1002', 'AW1000', 'EX1016', 2455, '2011-01-19 09:31:44') ,
 ('SA1010', 'CU1013', 'AW1015', 'EX1000', 5635, '2013-09-19 14:44:17') ,
 ('SA1011', 'CU1022', 'AW1018', 'EX1001', 4432, '2019-03-04 16:46:41') ,
 ('SA1012', 'CU1000', 'AW1017', 'EX1016', 1363, '2020-01-15 11:27:27') ,
 ('SA1013', 'CU1019', 'AW1008', 'EX1025', 9335, '2015-05-06 07:36:48') ,
 ('SA1014', 'CU1011', 'AW1025', 'EX1003', 4278, '2015-06-01 14:23:25') ,
 ('SA1015', 'CU1002', 'AW1008', 'EX1023', 3943, '2016-09-26 04:47:12') ,
 ('SA1016', 'CU1020', 'AW1013', 'EX1017', 6554, '2012-01-14 05:16:56') ,
 ('SA1017', 'CU1007', 'AW1003', 'EX1004', 3233, '2019-02-26 04:55:22') ,
 ('SA1018', 'CU1017', 'AW1006', 'EX1003', 384, '2011-02-20 17:05:17') ,
 ('SA1019', 'CU1007', 'AW1019', 'EX1012', 9693, '2020-08-02 15:11:28') ,
 ('SA1020', 'CU1003', 'AW1022', 'EX1010', 3237, '2013-11-09 08:28:29') ,
 ('SA1021', 'CU1019', 'AW1013', 'EX1024', 800, '2011-03-22 11:59:00') ,
 ('SA1022', 'CU1023', 'AW1017', 'EX1009', 1708, '2019-12-05 18:30:39') ,
 ('SA1023', 'CU1014', 'AW1023', 'EX1004', 8152, '2012-02-04 12:35:08') ,
 ('SA1024', 'CU1010', 'AW1013', 'EX1020', 2397, '2015-10-14 03:37:46') ;

		
/* -------------------------------------------	
 INSERT VALUES INTO TABLE staff
------------------------------------------- */

 INSERT INTO staff (Staff_ID , Staff_Role_ID , Staff_First_Name , Staff_Last_Name , Staff_Addr1 , Staff_Addr2 , Staff_Addr3, Staff_Postcode , Staff_Phone,  Staff_Email) 
values ('ST1000', 'SR1000', 'Humphrey', 'Kliement', '670 Roxbury Court', 'Jasionów', 'Fife', 'TR18 2SJ', '442 998 7072', 'hkliement0@house.gov') ,
  ('ST1001', 'SR1002', 'Sinclair', 'Greenard', '6094 Graedel Road', 'Taiping', 'Monmouthshire', 'GL54 2GW', '564 813 5177', 'sgreenard1@moonfruit.com') ,
  ('ST1002', 'SR1002', 'Nil', 'Carnoghan', '561 Susan Court', 'Nerchinsk', 'Glasgow City', 'WR12 0QJ', '893 631 8252', 'ncarnoghan2@naver.com') ,
  ('ST1003', 'SR1001', 'Laurie', 'Gaynor', '8353 Corben Circle', 'Barmash', 'North Ayrshire', 'NG11 8SR', '241 415 4027', 'lgaynor3@myspace.com') ,
  ('ST1004', 'SR1003', 'Freedman', 'Lukasik', '4 Transport Trail', 'Spånga', 'Merionethshire', 'KW14 8DG', '616 327 4878', 'flukasik4@shinystat.com') ,
  ('ST1005', 'SR1004', 'Merilyn', 'Mitro', '779 Blackbird Avenue', 'Reims', 'Aberdeenshire', 'FY1 1EZ', '757 676 9032', 'mmitro5@alexa.com') ,
  ('ST1006', 'SR1005', 'Boy', 'Venturoli', '35491 Darwin Court', 'Cruzeiro', 'Lincolnshire', 'WR12 0QJ', '835 248 0300', 'bventuroli6@forbes.com') ,
  ('ST1007', 'SR1006', 'Rollo', 'Giacomini', '54235 Valley Edge Pass', 'Mangga Dua', 'Merionethshire', 'CO2 7GS', '844 609 5898', 'rgiacomini7@example.com') ,
  ('ST1008', 'SR1007', 'Leland', 'Milnes', '93605 Pennsylvania Road', 'San Jose', 'Clackmannanshire', 'WR22 2DU', '650 203 6997', 'lmilnes8@umn.edu') ,
  ('ST1009', 'SR1009', 'Fania', 'Popplestone', '7 Commercial Pass', 'Yiyang', 'Hampshire', 'TR18 2SJ', '622 478 6712', 'fpopplestone9@businessweek.com') ,
  ('ST1010', 'SR1008', 'Kelli', 'Swinbourne', '7 High Crossing Plaza', 'Miaofengshan', 'South Lanarkshire', 'E3 2PX', '969 500 4532', 'kswinbournea@cdbaby.com') ,
  ('ST1011', 'SR1009', 'Lizabeth', 'Franzel', '13956 Ridgeway Road', 'Bungo-Takada-shi', 'East Ayrshire', 'IP24 3BU', '211 430 1545', 'lfranzelb@1688.com') ,
  ('ST1012', 'SR1009', 'Susanetta', 'Dorgon', '02725 Springview Trail', 'Piggs Peak', 'Northumberland', 'CH64 2UG', '349 267 7363', 'sdorgonc@washingtonpost.com') ,
  ('ST1013', 'SR1006', 'Nolana', 'Girodin', '8 Morning Way', 'Xinxiang', 'Cheshire', 'GU14 0BP', '921 814 5581', 'ngirodind@shinystat.com') ,
  ('ST1014', 'SR1007', 'Elana', 'Ridout', '13097 Florence Trail', 'Atar', 'East Dunbartonshire', 'BS11 0UN', '925 182 2358', 'eridoute@hubpages.com') ,
  ('ST1015', 'SR1004', 'Nata', 'Belcher', '6756 Karstens Terrace', 'Guihing Proper', 'Dundee City', 'ST3 3LR', '244 672 1979', 'nbelcherf@economist.com') ,
  ('ST1016', 'SR1008', 'Zeke', 'Stamper', '3 Arizona Way', 'Haifa', 'Monmouthshire', 'DE45 1FW', '423 898 3708', 'zstamperg@digg.com') ,
  ('ST1017', 'SR1002', 'Lindy', 'Tappor', '4 Moulton Way', 'Zavetnoye', 'Surrey', 'IP24 3BU', '710 429 6583', 'ltapporh@forbes.com') ,
  ('ST1018', 'SR1003', 'Bettye', 'Brisland', '7 Carioca Road', 'Yacheng', 'West Berkshire', 'SP1 3BB', '850 607 5093', 'bbrislandi@prweb.com') ,
  ('ST1019', 'SR1003', 'Ferdinande', 'Dougary', '44419 Longview Plaza', 'Villa Urquiza', 'Cambridgeshire', 'GL8 8HH', '673 677 3463', 'fdougaryj@topsy.com') ,
  ('ST1020', 'SR1004', 'Cammie', 'Henriet', '67 Bunting Way', 'Borlänge', 'West Midlands', 'DE45 1FW', '282 139 2169', 'chenrietk@irs.gov') ,
  ('ST1021', 'SR1011', 'Raymund', 'Roches', '34429 Mandrake Drive', 'Jorowaru Daya', 'Orkney Islands', 'FY1 1EZ', '173 931 3374', 'rrochesl@altervista.org') ,
  ('ST1022', 'SR1000', 'Bride', 'Simpole', '0365 Surrey Place', 'Kota Bharu', 'Worcestershire', 'WR11 9DR', '269 168 1536', 'bsimpolem@wikispaces.com') ,
  ('ST1023', 'SR1001', 'Amil', 'Privost', '4 Dottie Drive', 'Uva', 'Northamptonshire', 'B25 9TE', '316 893 2167', 'aprivostn@skyrock.com'), 
('ST1024', 'SR1009', 'Isidore', 'Hordell', '0 Bayside Lane', 'Clermont-Ferrand', 'Caernarvonshire', 'B98 2HP', '918 796 6431', 'ihordello@github.com') ;


		
/* -------------------------------------------	
 INSERT VALUES INTO TABLE staff_role
------------------------------------------- */

 INSERT INTO staff_role (Staff_role_ID, Staff_Role_Desc) values ('SR1000', 'Gallery Manager') ,
 ('SR1001', 'Deputy Manager') ,
  ('SR1002', 'Senior Sales Assistant') ,
  ('SR1003', 'Curator') ,
  ('SR1004', 'Human Resources') ,
  ('SR1005', 'Art Dealer') ,
  ('SR1006', 'Art Consultant') ,
  ('SR1007', 'Historian') ,
  ('SR1008', 'Sales Assistant') ,
 ('SR1009', 'Archivist') ;

	
		
/* -------------------------------------------	
CREATE VIEWS FROM  comp3391_19012712 
------------------------------------------- */

DROP VIEW IF EXISTS artist_VIEW; 

CREATE VIEW artist_VIEW AS 
SELECT * 
FROM 
artist; 


DROP VIEW IF EXISTS artwork_VIEW; 

CREATE VIEW artwork_VIEW AS 
SELECT * 
FROM 
artwork; 

	
DROP VIEW IF EXISTS artwork_exhibition_VIEW; 

CREATE VIEW artwork_exhibition_VIEW AS 
SELECT * 
FROM 
artwork_exhibition; 

	
DROP VIEW IF EXISTS art_genre_VIEW; 

CREATE VIEW art_genre_VIEW AS 
SELECT * 
FROM 
art_genre; 

	
DROP VIEW IF EXISTS art_medium_VIEW; 

CREATE VIEW art_medium_VIEW AS 
SELECT * 
FROM 
art_medium; 

DROP VIEW IF EXISTS collector_VIEW; 

	
CREATE VIEW collector_VIEW AS 
SELECT * 
FROM 
collector; 

	
DROP VIEW IF EXISTS collector_contact_VIEW; 

CREATE VIEW collector_contact_VIEW AS 
SELECT * 
FROM 
collector_contact; 

	
DROP VIEW IF EXISTS customer_VIEW; 

CREATE VIEW customer_VIEW AS 
SELECT * 
FROM 
customer;

	
DROP VIEW IF EXISTS exhibition_VIEW; 

CREATE VIEW exhibition_VIEW AS 
SELECT * 
FROM 
exhibition; 


DROP VIEW IF EXISTS exhibition_staff_VIEW; 

CREATE VIEW exhibition_staff_VIEW AS 
SELECT * 
FROM 
exhibition_staff; 


DROP VIEW IF EXISTS sales_VIEW; 

CREATE VIEW sales_VIEW AS 
SELECT * 
FROM 
sales; 

	
DROP VIEW IF EXISTS staff_VIEW; 

CREATE VIEW staff_VIEW AS 
SELECT * 
FROM 
staff; 

	
DROP VIEW IF EXISTS staff_role_VIEW; 

CREATE VIEW staff_role_VIEW AS 
SELECT * 
FROM 
staff_role; 


/* -------------------------------------------------------------------- 
	Create a view which calculates the total value of all sold artwork
--------------------------------------------------------------------  */

DROP VIEW IF EXISTS total_value_sold_artwork_VIEW; 

CREATE VIEW total_value_sold_artwork_VIEW AS 

SELECT SUM(Artwork_Price_GBP) AS Sold Artwork Total 

FROM artwork aw
INNER JOIN sales s ON aw.Artwork_ID = s.Sales_Artwork_ID
WHERE aw.Artwork_Sold = true; 

 
/* ------------------------------------------- 
	Create a view which shows staff at each exhibition
 ------------------------------------------- */

DROP VIEW IF EXISTS exhibition_staff_VIEW;  

CREATE VIEW exhibition_staff_VIEW AS  
SELECT distinct ex.Exhibition_Desc as Exhibition, ex.Exhibition_Date_Start as Start_Date,CONCAT_WS(' ',s.Staff_First_Name, s.Staff_Last_Name)as Staff_Name ,s.Staff_Phone as extension_no, sr.Staff_Role_Desc as Job
FROM staff s  
INNER JOIN staff_role sr on s.Staff_Role_ID = sr.Staff_Role_ID
INNER JOIN exhibition_staff es on es.Staff_ID = s.Staff_ID 
inner JOIN exhibition ex on es.Exhibition_ID = ex.Exhibition_ID
ORDER BY ex.Exhibition_Date_Start ASC;

 
/* -------------------------------------------
	View showing Customer names and addresses
 ------------------------------------------- */

DROP VIEW IF EXISTS customer_details_VIEW; 

CREATE VIEW customer_details_VIEW AS 
SELECT CONCAT_WS(', ', c.Customer_First_Name, c.Customer_Last_Name) AS Customer, CONCAT_WS(', ', c.Customer_Addr1, c.Customer_Addr2, c.Customer_Addr3,c.Customer_Postcode) AS Address 
FROM customer c; 

	
/* ------------------------------------------- 
	View showing each exhibiton and staff allocated
 ------------------------------------------- */	
DROP VIEW IF EXISTS exhibition_staff_VIEW; 
	
CREATE VIEW exhibition_staff_VIEW AS 
SELECT distinct es.Exhibition_ID Exhibition_ID, CONCAT_WS(' ',st.Staff_First_Name, st.Staff_Last_Name) Staff_Name 
FROM staff st
INNER JOIN exhibition_staff es ON st.Staff_ID = es.Staff_ID 
ORDER BY es.Exhibition_ID ASC;


/* ------------------------------------------- 
	Select exhibition with staff name and role allocated to each
 ------------------------------------------- */	
DROP VIEW IF EXISTS exhibition_staff_VIEW; 

CREATE VIEW exhibition_staff_VIEW AS 
SELECT distinct es.Exhibition_ID, CONCAT_WS(' ',st.Staff_First_Name, st.Staff_Last_Name) Staff_Name, sr.Staff_Role_Desc AS Role
from staff st
inner join exhibition_staff es ON st.Staff_ID = es.Staff_ID
inner join staff_role sr on st.Staff_Role_ID = sr.Staff_Role_ID
order by es.Exhibition_ID ASC;
 

/* ------------------------------------------- 
	Create a view which shows only those artwork  which have a medium of Oil Paint 
------------------------------------------- */	
DROP VIEW IF EXISTS Oil_Painting_VIEW; 
	
CREATE VIEW IF NOT EXISTS Oil_Painting_VIEW AS 
SELECT   aw.Artwork_ID, aw.Artwork_Title Title , am.Art_Medium_Desc
FROM artwork aw
Inner join art_medium am ON am.Art_Medium_ID = aw.Artwork_Medium_ID
WHERE am.Art_Medium_Desc  = 'Oil Paint'; 


/* -------------------------------------------
	Create a view which shows all artwork sold with price and date sold
 ------------------------------------------- */	
DROP VIEW IF EXISTS Sold_Art_VIEW; 
	
CREATE VIEW IF NOT EXISTS Sold_Art_VIEW AS 
SELECT ar.Artist_Last_Name, aw.Artwork_Title,aw.Artwork_Price_GBP as Sales_Price , DATE_FORMAT(s.Sales_Date, "%d %m %Y") as Date_Sold 
FROM artwork aw 
INNER JOIN artist ar ON ar.Artist_ID = aw.Artwork_Artist_ID 
INNER JOIN sales s ON s.Sales_Artwork_ID = aw.Artwork_ID 
WHERE aw.Artwork_Sold = true;

 
/* ------------------------------------------- 
	Create a view of unsold artwork and prices
------------------------------------------- */	
DROP VIEW IF EXISTS Unsold_Art_VIEW; 
	
CREATE VIEW IF NOT EXISTS Unsold_Art_VIEW AS
SELECT  DISTINCT aw.Artwork_ID, aw.Artwork_Title Title , am.Art_Medium_Desc, CONCAT_WS('£ ',aw.Artwork_Price_GBP) Price
FROM artwork aw
Inner join art_medium am ON am.Art_Medium_ID = aw.Artwork_Medium_ID
INNER JOIN sales s on s.Sales_Artwork_ID = aw.Artwork_ID
WHERE aw.Artwork_Sold = false;
 
 
 /* ------------------------------------------- 
	Create a view of unsold artwork with artists and prices
 ------------------------------------------- */	
DROP VIEW IF EXISTS Unsold_Art_VIEW; 
	
CREATE VIEW Unsold_Art_VIEW AS
SELECT  DISTINCT aw.Artwork_ID, aw.Artwork_Title Title , ar.Artist_Last_Name, am.Art_Medium_Desc, CONCAT_WS('£ ',aw.Artwork_Price_GBP) Price
FROM artwork aw
INNER JOIN artist ar ON aw.Artwork_Artist_ID = ar.Artist_ID
Inner join art_medium am ON am.Art_Medium_ID = aw.Artwork_Medium_ID
INNER JOIN sales s on s.Sales_Artwork_ID = aw.Artwork_ID
WHERE aw.Artwork_Sold = false
ORDER by ar.Artist_Last_Name asc;
 
  
/* ------------------------------------------- 
	CREATE a view to show all exhibitions started in the last three momnths
------------------------------------------- */	
DROP VIEW IF EXISTS events_in_prev_3_months_VIEW; 
	
CREATE VIEW events_prev_3_months_VIEW AS 
SELECT ex.Exhibition_Desc Exhibition,DATE_FORMAT(ex.Exhibition_Date_Start, '%d-%m-%Y') Exhibition_Start
FROM exhibition ex
WHERE ex.Exhibition_Date_Start > DATE_FORMAT(DATE_ADD(ex.Exhibition_Date_Start,  INTERVAL -3 month) , '%d-%m-%Y');

	
/* ------------------------------------------- 
	Create a view to show all purchases by collectors
------------------------------------------- */	
DROP VIEW IF EXISTS collector_purchases_VIEW;   
	
CREATE VIEW collector_purchases_VIEW AS  
SELECT co.Collector_Name, aw.Artwork_Title, aw.Artwork_Price_GBP
FROM collector co
INNER JOIN collector_contact cc ON cc.Collector_ID = co.Collector_ID
INNER JOIN sales s ON s.Sales_Customer_ID = cc.Collector_Contact_ID
INNER JOIN  artwork aw ON s.Sales_Artwork_ID = aw.Artwork_ID
ORDER by co.Collector_Name ASC;

 
 /* -------------------------------------------
	Create a view to show the total sales in the last 2 years
----------------------------------------------- */	
DROP VIEW IF EXISTS Total_sales_VIEW;   
	
CREATE VIEW Total_sales_VIEW AS  
select SUM(s.Sales_Amount_GBP)
FROM sales s
where s.Sales_Date > DATE_ADD(CURRENT_DATE(),  INTERVAL -2 year);

	
/* ------------------------------------------- 
	CREATE PROCEDURES
 ------------------------------------------- */	
	
/* ------------------------------------------- 
	Show all artwork details where the medium has been defined by a user
------------------------------------------- */	
DROP PROCEDURE IF EXISTS artwork_by_medium_proc;   
	
DELIMITER //     
CREATE PROCEDURE artwork_by_medium_proc(User_medium CHAR(30))     
BEGIN  
SELECT aw.Artwork_ID, aw.Artwork_Title, am.Art_Medium_Desc as Medium, aw.Artwork_Price_GBP as Price, aw.Artwork_Sold as Sold
FROM artwork aw
INNER JOIN art_medium am on am.Art_Medium_ID = aw.Artwork_Medium_ID
WHERE am.Art_Medium_Desc = User_medium ;    
END //    
DELIMITER ; 

/* ------------------------------------------- 
	Show all sold art with price and date
------------------------------------------- */	
DROP PROCEDURE IF EXISTS  artwork_sold_proc;
	
DELIMITER // 
CREATE PROCEDURE artwork_sold_proc() 
BEGIN 
SELECT ar.Artist_Last_Name AS Artist, aw.Artwork_Title AS Title ,aw.Artwork_Price_GBP AS Price, DATE_FORMAT(s.Sales_Date, "%d %m %Y") AS Date_Sold
FROM artwork aw 
INNER JOIN artist ar ON ar.Artist_ID = aw.Artwork_Artist_ID 
INNER JOIN sales s ON s.Sales_Artwork_ID = aw.Artwork_ID 
WHERE aw.Artwork_Sold = true;
END //
DELIMITER ; 
	
/* ------------------------------------------- */
/* Show all records in the customer table */
/* ------------------------------------------- */
DROP PROCEDURE IF EXISTS customer_proc;
	
DELIMITER //
CREATE PROCEDURE customer_proc()
BEGIN 
SELECT * 
FROM customer;
END //
DELIMITER ;

/* ------------------------------------------- */
/* Show all records in the collector table */
/* ------------------------------------------- */
DROP PROCEDURE IF EXISTS collector_proc;
	
DELIMITER //
CREATE PROCEDURE collector_proc()
BEGIN 
SELECT * 
FROM collector;
END //
DELIMITER ;


/* ------------------------------------------- */
/* Show the name, address, postcode and email address of all collectors */
/* ------------------------------------------- */
DROP PROCEDURE IF EXISTS collector_details_proc; 
	
DELIMITER //  
CREATE PROCEDURE collector_details_proc()  
BEGIN  
SELECT co.Collector_Name AS Collector, CONCAT_WS(' ',co.Collector_Addr1, co.Collector_Addr2, co.Collector_Addr3, co.Collector_Postcode) AS Address, co.Collector_Email AS Email
From collector co;
END // 
DELIMITER ; 

/* ------------------------------------------- */
/* Show the name, address, postcode and email address of all customers */
/* ------------------------------------------- */
DROP PROCEDURE IF EXISTS customer_details_proc;  
	
DELIMITER //  
CREATE PROCEDURE customer_details_proc()  
BEGIN  
SELECT CONCAT_WS(' ',cu.Customer_First_Name, cu.Customer_Last_Name) AS Customer, CONCAT_WS(' ',cu.Customer_Addr1, cu.Customer_Addr2, cu.Customer_Addr3, cu.Customer_Postcode) AS Address, cu.Customer_Email AS Email
From customer cu;
END // 
DELIMITER ; 

/* ------------------------------------------- */
/* Show all events where the dates are between two user inputted dates */
/* ------------------------------------------- */
DROP PROCEDURE IF EXISTS events_proc;     
	
DELIMITER //      
CREATE PROCEDURE events_proc(FirstDate DATE, SecondDate DATE)      
BEGIN      
SELECT *   
FROM exhibition  
WHERE Exhibition_Date_Start BETWEEN FirstDate AND SecondDate ;     
END //     
DELIMITER ; 


/* ------------------------------------------- */
/* Show the total value of sales between two user inputted dates */
/* ------------------------------------------- */
DROP PROCEDURE IF EXISTS sales_total_proc;  
	
DELIMITER //        
 CREATE PROCEDURE sales_total_proc (FirstDate DATE, SecondDate DATE)        
 BEGIN        
 SELECT SUM(s.Sales_Amount_GBP) Total_Sales 
 FROM sales s
 WHERE s.Sales_Date > FirstDate AND s.Sales_Date < SecondDate;    
 END //       
 DELIMITER ; 
 

/* ------------------------------------------- */
/* Show  name, extension number and job of all staff */
/* ------------------------------------------- */
DROP PROCEDURE IF EXISTS staff_details_proc;  
	
DELIMITER //  
CREATE PROCEDURE staff_details_proc()  
BEGIN  
SELECT distinct CONCAT_WS(' ',s.Staff_First_Name, s.Staff_Last_Name)as Staff_Name ,s.Staff_Phone as extension_no, sr.Staff_Role_Desc as Job
FROM staff s  
INNER JOIN staff_role sr  
WHERE sr.Staff_Role_ID = s.Staff_Role_ID;
END // 
DELIMITER ; 


/* ------------------------------------------- */
/* Show all events and staff deployed to each event */
/* ------------------------------------------- */
DROP PROCEDURE IF EXISTS staff_event_proc;  
	
DELIMITER //  
CREATE PROCEDURE staff_event_proc()  
BEGIN  
SELECT distinct ex.Exhibition_Desc as Exhibition, ex.Exhibition_Date_Start as Start_Date,CONCAT_WS(' ',s.Staff_First_Name, s.Staff_Last_Name)as Staff_Name ,s.Staff_Phone as extension_no, sr.Staff_Role_Desc as Job
FROM staff s  
INNER JOIN staff_role sr on s.Staff_Role_ID = sr.Staff_Role_ID
INNER JOIN exhibition_staff es on es.Staff_ID = s.Staff_ID 
inner JOIN exhibition ex on es.Exhibition_ID = ex.Exhibition_ID
ORDER BY ex.Exhibition_Date_Start ASC;
END // 
DELIMITER ; 
	
/* ------------------------------------------- */	
// CREATE USERS & GRANT PRIVILEGES
/* ------------------------------------------- */
 
DROP USER IF EXISTS 'John Brown'@'localhost';  
CREATE USER 'John Brown'@'localhost' IDENTIFIED BY 'moonbird';    
GRANT SELECT, UPDATE, INSERT, DELETE, DROP ON comp3391_19012712.* TO  'John Brown'@'localhost';   

  
DROP USER IF EXISTS 'Fred Simpson '@'localhost';  
CREATE USER 'Fred Simpson '@'localhost' IDENTIFIED BY 'duckgrub ';   
GRANT ALL PRIVILEGES ON comp3391_19012712.* TO 'Fred Simpson '@'localhost';   

DROP USER IF EXISTS 'Dennis Frost '@'localhost'; 
CREATE USER 'Dennis Frost '@'localhost' IDENTIFIED BY 'fishcrib';
GRANT UPDATE, INSERT, DELETE ON comp3391_19012712.exhibition TO 'Dennis Frost '@'localhost';   


DROP USER IF EXISTS 'Davina Kelly'@'localhost';  
CREATE USER 'Davina Kelly'@'localhost' IDENTIFIED BY 'hashkite';  
GRANT SELECT ON comp3391_19012712.sales TO 'Davina Kelly'@'localhost';   


DROP USER IF EXISTS 'Billy Russell'@'localhost';  
CREATE USER 'Billy Russell'@'localhost' IDENTIFIED BY 'snowlimp';    
GRANT SELECT, UPDATE, INSERT, DELETE, DROP ON comp3391_19012712.staff TO 'Billy Russell'@'localhost';  
GRANT SELECT, UPDATE, INSERT, DELETE, DROP ON comp3391_19012712.staff_role TO 'Billy Russell'@'localhost';
GRANT 'Personnel' to 'Billy Russell'; 
  

DROP USER IF EXISTS 'Jesse Hugh'@'localhost';  
CREATE USER 'Jesse Hugh'@'localhost' IDENTIFIED BY 'bookzip';    
GRANT SELECT, UPDATE, INSERT, DELETE, DROP ON comp3391_19012712.artwork TO 'Jesse Hugh'@'localhost';   
GRANT SELECT, UPDATE, INSERT, DELETE, DROP ON comp3391_19012712.artist TO 'Jesse Hugh'@'localhost';   

/* ------------------------------------------- */	
//SAVE ALL CHANGES
/* ------------------------------------------- */	

FLUSH PRIVILEGES; 

/* ------------------------------------------- */	
//CREATE ROLES & GRANT PRIVILEGES
/* ------------------------------------------- */	

DROP ROLE  'Supervisor';  
CREATE ROLE 'Supervisor';  
GRANT ALL PRIVILEGES ON comp3391_19012712.* TO 'Supervisor';  


DROP ROLE  'Administrator';  
CREATE ROLE 'Administrator';   
GRANT CREATE, SELECT, UPDATE, DELETE, INSERT    
ON comp3391_19012712.* TO 'Administrator';  


DROP ROLE  'Personnel';  
CREATE ROLE 'Personnel';   
GRANT CREATE, SELECT, UPDATE, DELETE, INSERT ON comp3391_19012712.staff TO 'Personnel';
GRANT CREATE, SELECT, UPDATE, DELETE, INSERT ON comp3391_19012712.staff_role TO 'Personnel';
GRANT CREATE, SELECT, UPDATE, DELETE, INSERT ON comp3391_19012712.exhibition_staff TO 'Personnel';


DROP ROLE 'Curator';  
CREATE ROLE 'Curator';
GRANT CREATE, SELECT, UPDATE, DELETE, INSERT ON comp3391_19012712.artist TO 'Curator';  
GRANT CREATE, SELECT, UPDATE, DELETE, INSERT ON comp3391_19012712.artwork TO 'Curator'; 


DROP ROLE 'Events organiser';  
CREATE ROLE 'Events organiser';  
GRANT ALL PRIVILEGES ON comp3391_19012712.artwork_exhibition TO 'Events organiser'; 
GRANT ALL PRIVILEGES ON comp3391_19012712.exhibition_staff TO 'Events organiser';
GRANT ALL PRIVILEGES ON comp3391_19012712.exhibition TO 'Events organiser';


DROP ROLE  'Sales';  
CREATE ROLE 'Sales';  
GRANT SELECT, UPDATE, INSERT ON comp3391_19012712.artwork TO 'Sales';  
GRANT SELECT, UPDATE, INSERT ON comp3391_19012712.collector TO 'Sales';  
GRANT SELECT, UPDATE, INSERT ON comp3391_19012712.collector_contact TO 'Sales';  
GRANT SELECT, UPDATE, INSERT ON comp3391_19012712.customer TO 'Sales';  
GRANT SELECT, UPDATE, INSERT ON comp3391_19012712.sales TO 'Sales';  

DROP ROLE 'Information Services';  
CREATE ROLE 'Information Services';  
GRANT SELECT ON comp3391_19012712.artwork TO 'Information Services';  
GRANT SELECT ON comp3391_19012712.artist TO 'Information Services';  
GRANT SELECT ON comp3391_19012712.exhibition TO 'Information Services';  
GRANT SELECT ON comp3391_19012712.artwork_exhibition TO 'Information Services';  

/* ------------------------------------------- */	
//SHOW GRANTS
/* ------------------------------------------- */	

SHOW GRANTS FOR 'Supervisor'; 
SHOW GRANTS FOR 'Administrator'; 
SHOW GRANTS FOR 'Personnel'; 
SHOW GRANTS FOR 'Curator'; 
SHOW GRANTS FOR 'Events organiser'; 
SHOW GRANTS FOR 'Sales'; 
SHOW GRANTS FOR 'Information Services'; 

/* ------------------------------------------- */	
//SAVE ALL CHANGES
/* ------------------------------------------- */	

FLUSH PRIVILEGES; 
	
 

 

 

 

 

 

 