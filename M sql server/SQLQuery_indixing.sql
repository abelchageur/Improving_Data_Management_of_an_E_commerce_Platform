CREATE INDEX IDX_InventoryFact_Product ON InventoryFact(ProductKey);
CREATE INDEX IDX_InventoryFact_Supplier ON InventoryFact(SupplierKey);
CREATE INDEX IDX_InventoryFact_Date ON InventoryFact(DateKey);

CREATE INDEX IDX_SalesFact_Date ON SalesFact(DateKey);
CREATE INDEX IDX_SalesFact_Customer ON SalesFact(CustomerKey);
CREATE INDEX IDX_SalesFact_Supplier ON SalesFact(SupplierKey);
CREATE INDEX IDX_SalesFact_Shipper ON SalesFact(Shipperkey);
CREATE INDEX IDX_SalesFact_Product ON SalesFact(ProductKey);

CREATE INDEX IDX_SalesFact_Search1 ON SalesFact(CustomerKey, DateKey);
CREATE INDEX IDX_SalesFact_Search2 ON SalesFact(ProductKey, DateKey);
CREATE INDEX IDX_InventoryFact_Search ON InventoryFact(ProductKey, DateKey);