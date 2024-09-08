-- 1. CREATE A DATABASE
CREATE DATABASE CarRepairShop;
USE CarRepairShop;

-- Find out the set import folder 
SHOW VARIABLES LIKE "secure_file_priv";

-- 2. Create Table and Import Data
CREATE TABLE Customer (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(255),
    Phone VARCHAR(20)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customer.csv'
INTO TABLE Customer
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(Name, Address, Phone);

-- 3. Create Vehicle Table and import data
CREATE TABLE Vehicle (
    VehicleID INT auto_increment PRIMARY KEY,
    Make VARCHAR(50),
    Model VARCHAR(50),
    Year INT,
    Color VARCHAR(20),
    VIN VARCHAR(50),
    RegNo VARCHAR(50),
    Mileage INT,
    OwnerName VARCHAR(100)
);

-- Import data into Vehicle table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/vehicle.csv'
INTO TABLE Vehicle
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(Make, Model, Year, Color, VIN, RegNo, Mileage, OwnerName);

-- 4. Create the Invoice table and import data
CREATE TABLE Invoice (
    InvoiceID INT PRIMARY KEY,
    InvoiceDate DATE,
    Subtotal DECIMAL(10, 2),
    SalesTaxRate DECIMAL(5, 2),
    SalesTax DECIMAL(10, 2),
    TotalLabour DECIMAL(10, 2),
    TotalParts DECIMAL(10, 2),
    Total DECIMAL(10, 2),
    CustomerID INT,
    VehicleID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (VehicleID) REFERENCES Vehicle(VehicleID)
);
-- Import data into invoice table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/invoice.csv'
INTO TABLE Invoice
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- 5. Create Job table and import data
CREATE TABLE Job (
    JobID INT PRIMARY KEY,
    VehicleID INT,
    Description VARCHAR(255),
    Hours DECIMAL(5, 2),
    Rate DECIMAL(10, 2),
    Amount DECIMAL(10, 2),
    InvoiceID INT,
    FOREIGN KEY (InvoiceID) REFERENCES Invoice(InvoiceID),
    FOREIGN KEY (VehicleID) REFERENCES Vehicle(VehicleID)
);

-- Import data into Job table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/job.csv'
INTO TABLE Job
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- 6. Create Part Table and import data
CREATE TABLE Parts (
    PartID INT PRIMARY KEY,
    JobID INT,
    PartNumber VARCHAR(50),
    PartName VARCHAR(255),
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    Amount DECIMAL(10, 2),
    InvoiceID INT,
    FOREIGN KEY (JobID) REFERENCES Job(JobID),
    FOREIGN KEY (InvoiceID) REFERENCES Invoice(InvoiceID)
);
-- Import data into Part table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/parts.csv'
INTO TABLE Parts
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Check that all the data were properly imported and cleaned. 
select * from vehicle;
select * from customer;
select * from invoice;
select * from job;
select * from parts;

-- Ensuring the tables are indexed for efficient querying
CREATE INDEX idx_customers_name ON customer (Name);
CREATE INDEX idx_vehicle_make_model_year ON vehicle (Make, Model, Year);
CREATE INDEX idx_job_description ON job (Description);
CREATE INDEX idx_parts_number ON parts (PartNumber);
CREATE INDEX idx_invoice_date ON invoice (InvoiceDate);


 -- DATA ANALYSIS TASKS
-- A. Customer Analysis:
-- a. Identify the top 5 customers who have spent the most on vehicle repairs and parts.
SELECT Customer.Name, SUM(Invoice.Total) AS TotalSpending
FROM Invoice
JOIN Customer 
ON Invoice.CustomerID = Customer.CustomerID
GROUP BY Customer.Name
ORDER BY TotalSpending DESC
LIMIT 5;

-- b. Determine the average spending of customers on repairs and parts.
SELECT 
    AVG(Invoice.TotalLabour) AS AvgRepairSpend,
    AVG(Invoice.TotalParts) AS AvgPartsSpend
FROM Invoice;
    
-- c. Analyze the frequency of customer visits and identify any patterns.
SELECT 
    Customer.Name, 
    COUNT(Invoice.InvoiceID) AS VisitFrequency,
    InvoiceDate,
    DATEDIFF(
        LEAD(InvoiceDate) OVER (ORDER BY InvoiceDate),
        InvoiceDate
    ) AS DaysBetweenVisits
FROM Invoice
JOIN Customer ON Invoice.CustomerID = Customer.CustomerID
GROUP BY Customer.Name, InvoiceDate
ORDER BY VisitFrequency DESC, InvoiceDate;

-- B. Vehicle Analysis
-- a. Calculate the average mileage of vehicles serviced.
SELECT AVG(Vehicle.Mileage) AS AverageMileage
FROM Vehicle;

-- b. Identify the most common vehicle makes and models brought in for service.
SELECT Vehicle.Make, Vehicle.Model, COUNT(*) AS Frequency
FROM Vehicle
GROUP BY Vehicle.Make, Vehicle.Model
ORDER BY Frequency DESC
LIMIT 5;

-- c. Analyze the distribution of vehicle ages and identify any trends in service requirements based on vehicle age.
SELECT Make, 
    (YEAR(CURDATE()) - Vehicle.Year) AS VehicleAge,
    SUM(Amount) AS AmountSpentOnParts,
    SUM(Quantity) AS QtyParts
FROM parts
JOIN invoice
ON parts.InvoiceID = invoice.InvoiceID
JOIN vehicle
ON invoice.VehicleID = vehicle.VehicleID
GROUP BY Make, VehicleAge
ORDER BY VehicleAge;

-- C. Job Performance Analysis
-- a. Determine the most common types of jobs performed and their frequency.
SELECT Job.Description, COUNT(JobID) AS Frequency, ROUND(AVG(Hours),1) AS AvgHoursSpent
FROM Job
GROUP BY Job.Description
ORDER BY Frequency DESC, AvgHoursSpent DESC;

-- b. Calculate the total revenue generated from each type of job.
SELECT Job.Description, SUM(Job.Amount) AS TotalRevenue
FROM Job
GROUP BY Job.Description
ORDER BY TotalRevenue DESC;

-- c. Identify the jobs with the highest and lowest average costs.
SELECT Job.Description, AVG(Job.Amount) AS AverageCost
FROM Job
GROUP BY Job.Description
ORDER BY AverageCost DESC;

-- D. Parts Usage Analysis
-- a. List the top 5 most frequently used parts and their total usage.
SELECT Parts.PartName, SUM(Quantity) AS UsageFrequency
FROM Parts
GROUP BY Parts.PartName
ORDER BY UsageFrequency DESC
LIMIT 5;

-- b. Calculate the average cost of parts used in repairs.
SELECT AVG(Parts.Amount) AS AveragePartCost
FROM Parts;

-- c. Determine the total revenue generated from parts sales.
SELECT SUM(Parts.Amount) AS TotalPartsRevenue
FROM Parts;

-- E. Financial Analysis
-- a. Calculate the total revenue generated from labor and parts for each month.
SELECT 
    YEAR(Invoice.InvoiceDate) AS Year, 
    MONTH(Invoice.InvoiceDate) AS Month, 
    SUM(Invoice.TotalLabour + Invoice.TotalParts) AS TotalRevenue
FROM Invoice
GROUP BY Year, Month
ORDER BY Year, Month;

-- b. Determine the overall profitability of the repair shop.
SELECT SUM(Invoice.Total) - SUM(Invoice.SalesTax) AS Profit
FROM Invoice;

-- c. Analyze the impact of sales tax on the total revenue.
SELECT 
    SUM(Total) AS TotalRevenue, 
    SUM(TotalParts) AS TotalParts,
    SUM(TotalLabour) AS TotalLabour,
    SUM(SalesTax) AS TotalSalesTax,
    SUM(SalesTax) / SUM(Total) AS Percent_tax
FROM Invoice;