DROP TABLE IF EXISTS customer;
CREATE TABLE customer (
  Account varchar(45) NOT NULL,
  Cname varchar(45) DEFAULT NULL,
  Province varchar(45) DEFAULT NULL,
  Cbalance float8 DEFAULT NULL,
  CrLimit float8 DEFAULT NULL,
  PRIMARY KEY (Account)
); 
INSERT INTO customer VALUES ('A1','Smith','ONT',2515,2000),('A2','Jones','BC',2014,2500),('A3','Doc','ONT',150,1000);


DROP TABLE IF EXISTS transaction;
CREATE TABLE transaction (
  Tno varchar(45) NOT NULL,
  Vno varchar(45) DEFAULT NULL,
  Account varchar(45) DEFAULT NULL,
  T_Date date DEFAULT NULL,
  Amount float8 DEFAULT NULL,
  PRIMARY KEY (Tno)
);


INSERT INTO transaction VALUES ('T1','V2','A1','2014-07-15',1325),('T2','V2','A3','2013-12-16',1900),('T3','V3','A1','2014-09-01',2500),('T4','V4','A2','2013-03-20',1613),('T5','V4','A3','2014-07-31',3312);


DROP TABLE IF EXISTS vendor;
CREATE TABLE vendor (
  Vno varchar(45) NOT NULL,
  Vname varchar(45) DEFAULT NULL,
  City varchar(45) DEFAULT NULL,
  Vbalance float8 DEFAULT NULL,
  PRIMARY KEY (Vno)
);

INSERT INTO vendor VALUES ('V1','Sears','Toronto',200),('V2','WalMart','Waterloo',671.05),('V3','Esso','Windsor',0),('V4','Esso','Waterloo',225);

