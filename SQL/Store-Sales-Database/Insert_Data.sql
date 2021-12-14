--INSERT STATEMENTS FOR SSSALES TABLE EXAMPLES
-- Note that these examples use SS prefixed before table names to avoid conflicts with
-- other tables with the same name
-- 96 rows have been added to the SSSales table (originally only 96 rows)
-- Only use DELETE if recreating rows without dropping tables

delete from SSSales;
delete from SSStore;
delete from SSTimeDim;
delete from SSDivision;
delete from SSCustomer;
delete from SSItem;

alter session set nls_date_format = 'yyyy-mm-dd hh24:mi:ss';

INSERT INTO SSTimeDim
(TimeNo, TimeDay, TimeMonth, TimeQuarter, TimeYear, TimeDayofWeek, TimeFiscalYear)
values(SSTimeNoSeq.NextVal,1,2,1,2014,2,2014);
INSERT INTO SSTimeDim
(TimeNo, TimeDay, TimeMonth, TimeQuarter, TimeYear, TimeDayofWeek, TimeFiscalYear)
values(SSTimeNoSeq.NextVal,1,5,2,2014,4,2014);
INSERT INTO SSTimeDim 
(TimeNo, TimeDay, TimeMonth, TimeQuarter, TimeYear, TimeDayofWeek, TimeFiscalYear)
values(SSTimeNoSeq.NextVal,3,7,3,2014,3,2014);
INSERT INTO SSTimeDim 
(TimeNo, TimeDay, TimeMonth, TimeQuarter, TimeYear, TimeDayofWeek, TimeFiscalYear)
values(SSTimeNoSeq.NextVal,4,10,4,2014,2,2014);
INSERT INTO SSTimeDim 
(TimeNo, TimeDay, TimeMonth, TimeQuarter, TimeYear, TimeDayofWeek, TimeFiscalYear)
values(SSTimeNoSeq.NextVal,1,2,1,2015,2,2015);
INSERT INTO SSTimeDim 
(TimeNo, TimeDay, TimeMonth, TimeQuarter, TimeYear, TimeDayofWeek, TimeFiscalYear)
values(SSTimeNoSeq.NextVal,1,5,2,2015,4,2015);
INSERT INTO SSTimeDim 
(TimeNo, TimeDay, TimeMonth, TimeQuarter, TimeYear, TimeDayofWeek, TimeFiscalYear)
values(SSTimeNoSeq.NextVal,3,7,3,2015,3,2015);
INSERT INTO SSTimeDim 
(TimeNo, TimeDay, TimeMonth, TimeQuarter, TimeYear, TimeDayofWeek, TimeFiscalYear)
values(SSTimeNoSeq.NextVal,4,10,4,2015,2,2015);
INSERT INTO SSTimeDim 
(TimeNo, TimeDay, TimeMonth, TimeQuarter, TimeYear, TimeDayofWeek, TimeFiscalYear)
values(SSTimeNoSeq.NextVal,1,2,1,2016,2,2016);
INSERT INTO SSTimeDim 
(TimeNo, TimeDay, TimeMonth, TimeQuarter, TimeYear, TimeDayofWeek, TimeFiscalYear)
values(SSTimeNoSeq.NextVal,1,5,2,2016,4,2016);
INSERT INTO SSTimeDim 
(TimeNo, TimeDay, TimeMonth, TimeQuarter, TimeYear, TimeDayofWeek, TimeFiscalYear)
values(SSTimeNoSeq.NextVal,3,7,3,2016,3,2016);
INSERT INTO SSTimeDim 
(TimeNo, TimeDay, TimeMonth, TimeQuarter, TimeYear, TimeDayofWeek, TimeFiscalYear)
values(SSTimeNoSeq.NextVal,4,10,4,2016,2,2016);
INSERT INTO SSTimeDim 
(TimeNo, TimeDay, TimeMonth, TimeQuarter, TimeYear, TimeDayofWeek, TimeFiscalYear)
values(SSTimeNoSeq.NextVal,1,2,1,2017,2,2017);
INSERT INTO SSTimeDim 
(TimeNo, TimeDay, TimeMonth, TimeQuarter, TimeYear, TimeDayofWeek, TimeFiscalYear)
values(SSTimeNoSeq.NextVal,1,5,2,2017,4,2017);
INSERT INTO SSTimeDim 
(TimeNo, TimeDay, TimeMonth, TimeQuarter, TimeYear, TimeDayofWeek, TimeFiscalYear)
values(SSTimeNoSeq.NextVal,3,7,3,2017,3,2017);
INSERT INTO SSTimeDim 
(TimeNo, TimeDay, TimeMonth, TimeQuarter, TimeYear, TimeDayofWeek, TimeFiscalYear)
values(SSTimeNoSeq.NextVal,4,10,4,2017,2,2017);

SELECT COUNT(*) FROM SSTimeDim;
-- should show 16 rows

insert into SSItem 
(ItemId, ItemName, ItemBrand, ItemCategory, ItemUnitPrice)
values ('I0036566','17 inch Color Monitor','ColorMeg, Inc.','Electronics', 169.00);

insert into SSItem 
(ItemId, ItemName, ItemBrand, ItemCategory, ItemUnitPrice)
values ('I0036577','19 inch Color Monitor','ColorMeg, Inc.','Electronics', 319.00);

insert into SSItem 
(ItemId, ItemName, ItemBrand, ItemCategory, ItemUnitPrice)
values ('I1114590','R3000 Color Laser Printer','Connex','Printing', 699.00);

insert into SSItem 
(ItemId, ItemName, ItemBrand, ItemCategory, ItemUnitPrice)
values ('I1412138','10 Foot Printer Cable','Ethlite','Computer Accessories', 12.00);

insert into SSItem 
(ItemId, ItemName, ItemBrand, ItemCategory, ItemUnitPrice)
values ('I1445671','8-Outlet Surge Protector','Intersafe','Computer Accessories', 14.99);

insert into SSItem 
(ItemId, ItemName, ItemBrand, ItemCategory, ItemUnitPrice)
values ('I1556678','CVP Ink Jet Color Printer','Connex','Printing', 99.00);

insert into SSItem 
(ItemId, ItemName, ItemBrand, ItemCategory, ItemUnitPrice)
values ('I3455443','Color Ink Jet Cartridge','Connex','Printing', 38.00);

insert into SSItem 
(ItemId, ItemName, ItemBrand, ItemCategory, ItemUnitPrice)
values ('I4200744','36-Bit Color Scanner','UV Components','Scanning', 199.99);

insert into SSItem 
(ItemId, ItemName, ItemBrand, ItemCategory, ItemUnitPrice)
values ('I6677900','Black Ink Jet Cartridge','Connex','Printing', 25.69);

insert into SSItem 
(ItemId, ItemName, ItemBrand, ItemCategory, ItemUnitPrice)
values ('I9995676','Battery Back-up System','Cybercx','Computer Accessories', 89.00);

SELECT COUNT(*) FROM SSItem;  
-- should be 10

insert into SSDivision 
(DivId, DivManager, DivName)
values ('D0104030','James Johnson', 'Printing Division');

insert into SSDivision 
(DivId, DivManager, DivName)
values ('D0225030','Maria Guzzman','Computer Division');

insert into SSDivision 
(DivId, DivManager, DivName)
values ('D3134030','Tomas Chen','Accessories Division');


insert into SSStore 
(StoreId, DivId, StoreManager, StoreStreet, StoreCity, StoreState, StoreZip, StoreNation)
values ('S0954327','D0104030', 'Jim Smith', '436 Hill St.','Littleton','CO','80129-5543','USA');

insert into SSStore 
(StoreId, DivId, StoreManager, StoreStreet, StoreCity, StoreState, StoreZip, StoreNation)
values ('S1010398','D0104030', 'Mary Glussman','1832 E. Ravenna','Denver','CO','80111-0033','USA');

insert into SSStore 
(StoreId, DivId, StoreManager, StoreStreet, StoreCity, StoreState, StoreZip, StoreNation)
values ('S2388597','D0225030', 'Beth Woo','5496 Rafter Rd','Seattle','WA','98103-1121','USA');

insert into SSStore 
(StoreId, DivId, StoreManager, StoreStreet, StoreCity, StoreState, StoreZip, StoreNation)
values ('S8543321','D3134030', 'Joe Thompson','989 122nd St.','Renton','WA','98666-1289','USA');

insert into SSStore 
(StoreId, DivId, StoreManager, StoreStreet, StoreCity, StoreState, StoreZip, StoreNation)
values ('S9403348','D0225030', 'Mary Boren','1242 Crest Ave.','Englewood','CO','80113-5431','USA');

insert into SSStore 
(StoreId, DivId, StoreManager, StoreStreet, StoreCity, StoreState, StoreZip, StoreNation)
values ('S9432910','D0104030', 'Larry Smith','12825 S. Crest Lane','Vancouver','BC','98104-2211','Canada');

SELECT COUNT(*) FROM SSStore;  
-- should be 6

insert into SSCustomer 
(CustId, CustName, CustPhone, CustStreet, CustCity, CustState, CustZip, CustNation)
values ('C0954327','Sheri Gordon', '(303)123-1234','336 Hill St.','Littleton','CO','80129-5543','USA');

insert into SSCustomer 
(CustId, CustName, CustPhone, CustStreet, CustCity, CustState, CustZip, CustNation)
values ('C1010398','Jim Glussman','(303)321-9876','1432 E. Ravenna','Denver','CO','80111-0033','USA');

insert into SSCustomer 
(CustId, CustName, CustPhone, CustStreet, CustCity, CustState, CustZip, CustNation)
values ('C2388597','Beth Taylor','(206)124-9876','2396 Rafter Rd','Seattle','WA','98103-1121','USA');

insert into SSCustomer 
(CustId, CustName, CustPhone, CustStreet, CustCity, CustState, CustZip, CustNation)
values ('C3340959','Betty Wise','(206)421-1276','4334 153rd NW','Seattle','WA','98178-3311','USA');

insert into SSCustomer 
(CustId, CustName, CustPhone, CustStreet, CustCity, CustState, CustZip, CustNation)
values ('C8543321','Ron Thompson','(206)891-7664','789 122nd St.','Renton','WA','98666-1289','USA');

insert into SSCustomer 
(CustId, CustName, CustPhone, CustStreet, CustCity, CustState, CustZip, CustNation)
values ('C8574932','Wally Jones','(206)391-8564','411 Webber Ave.','Seattle','WA','98105-1093','USA');

insert into SSCustomer 
(CustId, CustName, CustPhone, CustStreet, CustCity, CustState, CustZip, CustNation)
values ('C8654390','Candy Kendall','(206)561-2264','456 Pine St.','Seattle','WA','98105-3345','USA');

insert into SSCustomer 
(CustId, CustName, CustPhone, CustStreet, CustCity, CustState, CustZip, CustNation)
values ('C9128574','Jerry Wyatt','(303)821-1234','16212 123rd Ct.','Denver','CO','80222-0022','USA');

insert into SSCustomer 
(CustId, CustName, CustPhone, CustStreet, CustCity, CustState, CustZip, CustNation)
values ('C9403348','Mike Boren','(303)821-5688','642 Crest Ave.','Englewood','CO','80113-5431','USA');

insert into SSCustomer 
(CustId, CustName, CustPhone, CustStreet, CustCity, CustState, CustZip, CustNation)
values ('C9432910','Larry Styles','(406)921-7688','9825 S. Crest Lane','Vancouver','BC','98104-2211','Canada');

insert into SSCustomer 
(CustId, CustName, CustPhone, CustStreet, CustCity, CustState, CustZip, CustNation)
values ('C9543029','Sharon Johnson','(406)921-4468','1223 Meyer Way','Surrey','BC','98222-1123','Canada');

SELECT COUNT(*) FROM SSCustomer;  
-- should be 11

insert into SSSales
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,100, 5215, 4187, 'C0954327','S0954327','I0036566',1);

insert into SSSales
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,140, 6215, 4887, 'C1010398','S0954327','I0036566',2);

insert into SSSales
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,120, 5915, 4687, 'C0954327','S0954327','I0036566',3);

insert into SSSales
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,110, 5745, 4577, 'C9128574','S0954327','I0036566',4);

insert into SSSales
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,105, 5115, 4287, 'C1010398','S1010398','I0036566',1);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,160, 6915, 4587, 'C0954327','S1010398','I0036566',2);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal, 90, 4915, 4847,'C2388597','S1010398','I0036566',3);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,110, 5448, 4188, 'C8574932','S1010398','I0036566',4);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,105, 5115, 4287, 'C0954327','S9432910','I0036566',1);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,113, 6115, 4787, 'C0954327','S9432910','I0036566',2);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,144, 5954, 4655, 'C0954327','S9432910','I0036566',3);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,159, 6245, 5287, 'C3340959','S9432910','I0036566',4);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,100, 5215, 4187, 'C0954327','S0954327','I0036577',1);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,140, 6215, 4887, 'C8574932','S0954327','I0036577',2);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,120, 5915, 4687, 'C0954327','S0954327','I0036577',3);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,110, 5745, 4577, 'C8654390','S0954327','I0036577',4);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,105, 5115, 4287, 'C0954327','S1010398','I0036577',1);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,160, 6915, 4587, 'C0954327','S1010398','I0036577',2);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,90, 4915, 4847, 'C0954327','S1010398','I0036577',3);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,110, 5448, 4188, 'C8654390','S1010398','I0036577',4);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,105, 5115, 4287, 'C9128574','S9432910','I0036577',1);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,113, 6115, 4787, 'C0954327','S9432910','I0036577',2);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,144, 5954, 4655, 'C9403348','S9432910','I0036577',3);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,159, 6245, 5287, 'C9432910','S9432910','I0036577',4);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,100, 5215, 4187, 'C0954327','S0954327','I0036566',5);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,140, 6215, 4887, 'C1010398','S0954327','I0036566',6);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,120, 5915, 4687, 'C0954327','S0954327','I0036566',7);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,110, 5745, 4577, 'C9128574','S0954327','I0036566',8);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,105, 5115, 4287, 'C1010398','S1010398','I0036566',5);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,160, 6915, 4587, 'C0954327','S1010398','I0036566',6);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,  90, 4915, 4847,'C2388597','S1010398','I0036566',7);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,110, 5448, 4188, 'C8574932','S1010398','I0036566',8);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,105, 5215, 4287, 'C0954327','S9432910','I0036566',5);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,113, 6215, 4487, 'C0954327','S9432910','I0036566',6);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,144, 5854, 4455, 'C0954327','S9432910','I0036566',7);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,159, 6245, 5287, 'C3340959','S9432910','I0036566',8);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,100, 5215, 4187, 'C0954327','S0954327','I0036577',5);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,140, 6215, 4887, 'C8574932','S0954327','I0036577',6);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,120, 5915, 4687, 'C0954327','S0954327','I0036577',7);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,110, 5895, 4377, 'C8654390','S0954327','I0036577',8);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,105, 5215, 4387, 'C0954327','S1010398','I0036577',5);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,160, 6915, 4687, 'C0954327','S1010398','I0036577',6);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,90, 5915, 4947, 'C0954327','S1010398','I0036577',7);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,110, 5548, 4288, 'C8654390','S1010398','I0036577',8);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,105, 5115, 4287, 'C9128574','S9432910','I0036577',5);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,113, 6315, 4987, 'C0954327','S9432910','I0036577',6);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,144, 5954, 4655, 'C9403348','S9432910','I0036577',7);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,159, 6145, 5387, 'C9432910','S9432910','I0036577',8);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,100, 5515, 4067, 'C0954327','S0954327','I0036566',9);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,140, 6015, 4677, 'C1010398','S0954327','I0036566',10);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,120, 5915, 4687, 'C0954327','S0954327','I0036566',11);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,110, 5745, 4577, 'C9128574','S0954327','I0036566',12);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,105, 5115, 4287, 'C0954327','S9432910','I0036566',9);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,113, 6115, 4787, 'C0954327','S9432910','I0036566',10);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,144, 5954, 4655, 'C0954327','S9432910','I0036566',11);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,159, 6245, 5287, 'C3340959','S9432910','I0036566',12);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,100, 5215, 4187, 'C0954327','S0954327','I0036577',9);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,140, 6215, 4887, 'C8574932','S0954327','I0036577',10);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,120, 5915, 4687, 'C0954327','S0954327','I0036577',11);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,110, 5845, 4407, 'C8654390','S0954327','I0036577',12);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,105, 5195, 4437, 'C0954327','S1010398','I0036577',9);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,160, 6210, 4447, 'C0954327','S1010398','I0036577',10);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,90, 4815, 4547, 'C0954327','S1010398','I0036577',11);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,110, 5308, 4338, 'C8654390','S1010398','I0036577',12);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,105, 5205, 4487, 'C9128574','S9432910','I0036577',9);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,113, 6305, 4847, 'C0954327','S9432910','I0036577',10);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,144, 5844, 4775, 'C9403348','S9432910','I0036577',11);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,159, 6775, 5837, 'C9432910','S9432910','I0036577',12);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,100, 5405, 4497, 'C0954327','S0954327','I0036566',13);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,140, 6305, 5127, 'C1010398','S0954327','I0036566',14);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,120, 5845, 4997, 'C0954327','S0954327','I0036566',15);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,110, 5885, 4447, 'C9128574','S0954327','I0036566',16);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,105, 5115, 4287, 'C1010398','S1010398','I0036566',13);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,160, 6445, 4667, 'C0954327','S1010398','I0036566',14);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal, 90, 4605, 4297,'C2388597','S1010398','I0036566',15);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,110, 5508, 4498, 'C8574932','S1010398','I0036566',16);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,105, 5935, 4877, 'C0954327','S9432910','I0036566',13);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,113, 6105, 4987, 'C0954327','S9432910','I0036566',14);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,144, 5774, 4995, 'C0954327','S9432910','I0036566',15);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,159, 6115, 5117, 'C3340959','S9432910','I0036566',16);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,100, 5335, 4667, 'C0954327','S0954327','I0036577',13);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,140, 6505, 4997, 'C8574932','S0954327','I0036577',14);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,120, 5005, 4557, 'C0954327','S0954327','I0036577',15);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,110, 5795, 4447, 'C8654390','S0954327','I0036577',16);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,105, 5055, 4257, 'C0954327','S1010398','I0036577',13);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,160, 6005, 4998, 'C0954327','S1010398','I0036577',14);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,90, 5555, 4847, 'C0954327','S1010398','I0036577',15);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,110, 5748, 4388, 'C8654390','S1010398','I0036577',16);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,105, 5155, 4237, 'C9128574','S9432910','I0036577',13);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,113, 6315, 4987, 'C0954327','S9432910','I0036577',14);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,144, 5954, 4655, 'C9403348','S9432910','I0036577',15);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,159, 6145, 5387, 'C9432910','S9432910','I0036577',16);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,105, 5455, 4087, 'C1010398','S1010398','I0036566',13);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,160, 6875, 4996, 'C0954327','S1010398','I0036566',14);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal, 90, 4805, 4207,'C2388597','S1010398','I0036566',15);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,110, 5448, 4188, 'C8574932','S1010398','I0036566',16);

-- Extra rows to provide more values for ItemId in SSSales

insert into SSSales
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,100, 5215, 4187, 'C0954327','S0954327','I1114590',1);

insert into SSSales
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,140, 6215, 4887, 'C1010398','S0954327','I1114590',2);

insert into SSSales
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,120, 5915, 4687, 'C0954327','S0954327','I1114590',3);

insert into SSSales
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,110, 5745, 4577, 'C9128574','S0954327','I1114590',4);

insert into SSSales
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,105, 5115, 4287, 'C1010398','S1010398','I1114590',1);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,160, 6915, 4587, 'C0954327','S1010398','I1114590',2);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal, 90, 4915, 4847,'C2388597','S1010398','I1114590',3);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,110, 5448, 4188, 'C8574932','S1010398','I1114590',4);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,105, 5115, 4287, 'C0954327','S9432910','I1412138',1);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,113, 6115, 4787, 'C0954327','S9432910','I1412138',2);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,144, 5954, 4655, 'C0954327','S9432910','I1412138',3);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,159, 6245, 5287, 'C3340959','S9432910','I1412138',4);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,100, 5215, 4187, 'C0954327','S0954327','I1412138',1);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,140, 6215, 4887, 'C8574932','S0954327','I1412138',2);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,120, 5915, 4687, 'C0954327','S0954327','I1412138',3);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,110, 5745, 4577, 'C8654390','S0954327','I1412138',4);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,105, 5115, 4287, 'C0954327','S1010398','I1445671',1);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,160, 6915, 4587, 'C0954327','S1010398','I1445671',2);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,90, 4915, 4847, 'C0954327','S1010398','I1445671',3);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,110, 5448, 4188, 'C8654390','S1010398','I1445671',4);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,105, 5115, 4287, 'C9128574','S9432910','I1445671',1);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,113, 6115, 4787, 'C0954327','S9432910','I1445671',2);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,144, 5954, 4655, 'C9403348','S9432910','I1445671',3);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,159, 6245, 5287, 'C9432910','S9432910','I1445671',4);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,100, 5215, 4187, 'C0954327','S0954327','I1445671',5);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,140, 6215, 4887, 'C1010398','S0954327','I1445671',6);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,120, 5915, 4687, 'C0954327','S0954327','I1445671',7);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,110, 5745, 4577, 'C9128574','S0954327','I1556678',8);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,105, 5115, 4287, 'C1010398','S1010398','I1556678',5);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,160, 6915, 4587, 'C0954327','S1010398','I1556678',6);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,  90, 4915, 4847,'C2388597','S1010398','I1556678',7);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,110, 5448, 4188, 'C8574932','S1010398','I1556678',8);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,105, 5215, 4287, 'C0954327','S9432910','I1556678',5);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,113, 6215, 4487, 'C0954327','S9432910','I1556678',6);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,144, 5854, 4455, 'C0954327','S9432910','I1556678',7);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,159, 6245, 5287, 'C3340959','S9432910','I1556678',8);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,100, 5215, 4187, 'C0954327','S0954327','I3455443',5);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,140, 6215, 4887, 'C8574932','S0954327','I3455443',6);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,120, 5915, 4687, 'C0954327','S0954327','I3455443',7);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,110, 5895, 4377, 'C8654390','S0954327','I3455443',8);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,105, 5215, 4387, 'C0954327','S1010398','I3455443',5);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,160, 6915, 4687, 'C0954327','S1010398','I3455443',6);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,90, 5915, 4947, 'C0954327','S1010398','I3455443',7);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,110, 5548, 4288, 'C8654390','S1010398','I3455443',8);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,105, 5115, 4287, 'C9128574','S9432910','I4200744',5);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,113, 6315, 4987, 'C0954327','S9432910','I4200744',6);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,144, 5954, 4655, 'C9403348','S9432910','I4200744',7);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,159, 6145, 5387, 'C9432910','S9432910','I4200744',8);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,100, 5515, 4067, 'C0954327','S0954327','I4200744',9);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,140, 6015, 4677, 'C1010398','S0954327','I4200744',10);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,120, 5915, 4687, 'C0954327','S0954327','I4200744',11);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,110, 5745, 4577, 'C9128574','S0954327','I4200744',12);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,105, 5115, 4287, 'C0954327','S9432910','I4200744',9);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,113, 6115, 4787, 'C0954327','S9432910','I4200744',10);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,144, 5954, 4655, 'C0954327','S9432910','I4200744',11);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,159, 6245, 5287, 'C3340959','S9432910','I6677900',12);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,100, 5215, 4187, 'C0954327','S0954327','I6677900',9);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,140, 6215, 4887, 'C8574932','S0954327','I6677900',10);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,120, 5915, 4687, 'C0954327','S0954327','I6677900',11);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,110, 5845, 4407, 'C8654390','S0954327','I6677900',12);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,105, 5195, 4437, 'C0954327','S1010398','I6677900',9);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,160, 6210, 4447, 'C0954327','S1010398','I6677900',10);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,90, 4815, 4547, 'C0954327','S1010398','I6677900',11);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,110, 5308, 4338, 'C8654390','S1010398','I6677900',12);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,105, 5205, 4487, 'C9128574','S9432910','I6677900',9);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,113, 6305, 4847, 'C0954327','S9432910','I6677900',10);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,144, 5844, 4775, 'C9403348','S9432910','I6677900',11);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,159, 6775, 5837, 'C9432910','S9432910','I6677900',12);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,100, 5405, 4497, 'C0954327','S0954327','I6677900',13);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,140, 6305, 5127, 'C1010398','S0954327','I6677900',14);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,120, 5845, 4997, 'C0954327','S0954327','I6677900',15);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,110, 5885, 4447, 'C9128574','S0954327','I6677900',16);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,105, 5115, 4287, 'C1010398','S1010398','I6677900',13);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,160, 6445, 4667, 'C0954327','S1010398','I9995676',14);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal, 90, 4605, 4297,'C2388597','S1010398','I9995676',15);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,110, 5508, 4498, 'C8574932','S1010398','I9995676',16);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,105, 5935, 4877, 'C0954327','S9432910','I9995676',13);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,113, 6105, 4987, 'C0954327','S9432910','I9995676',14);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,144, 5774, 4995, 'C0954327','S9432910','I9995676',15);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,159, 6115, 5117, 'C3340959','S9432910','I9995676',16);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,100, 5335, 4667, 'C0954327','S0954327','I9995676',13);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,140, 6505, 4997, 'C8574932','S0954327','I9995676',14);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,120, 5005, 4557, 'C0954327','S0954327','I9995676',15);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,110, 5795, 4447, 'C8654390','S0954327','I9995676',16);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,105, 5055, 4257, 'C0954327','S1010398','I9995676',13);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,160, 6005, 4998, 'C0954327','S1010398','I9995676',14);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,90, 5555, 4847, 'C0954327','S1010398','I9995676',15);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,110, 5748, 4388, 'C8654390','S1010398','I9995676',16);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,105, 5155, 4237, 'C9128574','S9432910','I9995676',13);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,113, 6315, 4987, 'C0954327','S9432910','I9995676',14);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,144, 5954, 4655, 'C9403348','S9432910','I9995676',15);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,159, 6145, 5387, 'C9432910','S9432910','I1114590',16);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,105, 5455, 4087, 'C1010398','S1010398','I1114590',13);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,160, 6875, 4996, 'C0954327','S1010398','I1114590',14);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal, 90, 4805, 4207,'C2388597','S1010398','I1114590',15);

insert into SSSales 
(SalesNo, SalesUnits, SalesDollar, SalesCost, CustId, StoreId, ItemId, TimeNo)
values (SSSalesNoSeq.NextVal,110, 5448, 4188, 'C8574932','S1010398','I1114590',16);

SELECT COUNT(*) FROM SSSales;  
-- should be 192

commit;