-- Create logins (if they don't already exist)
CREATE LOGIN Analyst_User WITH PASSWORD = 'password';
CREATE LOGIN Admin_User WITH PASSWORD = 'password';

CREATE USER Analyst_User FOR LOGIN Analyst_User;
CREATE USER Admin_User FOR LOGIN Admin_User;

-- Create roles
CREATE ROLE Analyste;
CREATE ROLE Administrateur;

ALTER ROLE Analyste ADD MEMBER Analyst_User;
ALTER ROLE Administrateur ADD MEMBER Admin_User;

-- Grant read-only access to analysts
GRANT SELECT ON SalesFact TO Analyste;
GRANT SELECT ON InventoryFact TO Analyste;

-- Grant full control to administrators
GRANT SELECT, INSERT, UPDATE, DELETE ON SalesFact TO Administrateur;
GRANT SELECT, INSERT, UPDATE, DELETE ON InventoryFact TO Administrateur;

GRANT SELECT ON SCHEMA::dbo TO Analyste;  
GRANT CONTROL ON DATABASE::med_database TO Administrateur;  

ALTER TABLE CustomerDimension 
ALTER COLUMN CustomerEmail ADD MASKED WITH (FUNCTION = 'email()');

ALTER TABLE CustomerDimension 
ALTER COLUMN CustomerPhone ADD MASKED WITH (FUNCTION = 'partial(2,"XXX-XXX-",2)');  



