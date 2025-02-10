
-- Create Partition Function
CREATE PARTITION FUNCTION pf_SalesFact (INT)
AS RANGE RIGHT FOR VALUES (2021, 2022, 2023);

-- Create Partition Scheme
CREATE PARTITION SCHEME ps_SalesFact
AS PARTITION pf_SalesFact ALL TO ([PRIMARY]);

-- Create SalesFact Partitioned Table
CREATE TABLE SalesFact_Partitioned (
    SaleID INT IDENTITY(1,1),
    DateKey INT NOT NULL,
    CustomerKey INT,
    ProductKey INT,
    SupplierKey INT,
    ShipperKey INT,
    QuantitySold INT,
    TotalAmount FLOAT,
    DiscountAmount FLOAT,
    NetAmount FLOAT,
    turnover DECIMAL(18,2),
    CONSTRAINT PK_SalesFact PRIMARY KEY (SaleID, DateKey)
) 
ON ps_SalesFact(DateKey);

-- Create InventoryFact Partitioned Table
CREATE TABLE InventoryFact_Partitioned (
    InventoryID INT IDENTITY(1,1),
    DateKey INT NOT NULL,
    ProductKey INT,
    SupplierKey INT,
    StockReceived INT,
    StockSold INT,
    StockOnHand INT,
    CONSTRAINT PK_InventoryFact PRIMARY KEY (InventoryID, DateKey)
) 
ON ps_SalesFact(DateKey);

-- Insert Data into SalesFact_Partitioned
INSERT INTO SalesFact_Partitioned (DateKey, CustomerKey, ProductKey, SupplierKey, ShipperKey, QuantitySold, TotalAmount, DiscountAmount, NetAmount, turnover)
SELECT DateKey, CustomerKey, ProductKey, SupplierKey, ShipperKey, QuantitySold, TotalAmount, DiscountAmount, NetAmount, turnover
FROM SalesFact;

INSERT INTO InventoryFact_Partitioned (DateKey, ProductKey, SupplierKey, StockReceived, StockSold, StockOnHand)
SELECT DateKey, ProductKey, SupplierKey, StockReceived, StockSold, StockOnHand
FROM InventoryFact;


-- check
/*
SELECT *
FROM InventoryFact_Partitioned
WHERE YEAR(CONVERT(DATE, CAST(DateKey AS VARCHAR(8)))) = 2021;
*/