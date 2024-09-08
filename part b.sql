 -- 1.	Data Analysis Tasks
-- A. Customer Analysis:
-- a. Identify the top 5 customers who have spent the most on vehicle repairs and parts.
SELECT 
    Customer.Name, SUM(Invoice.Total) AS TotalSpending
FROM
    Invoice
        JOIN
    Customer ON Invoice.CustomerID = Customer.CustomerID
GROUP BY Customer.Name
ORDER BY TotalSpending DESC
LIMIT 5;

-- b. Determine the average spending of customers on repairs and parts.
SELECT 
    AVG(Invoice.Total) AS AverageSpending
FROM 
    Invoice;
    
-- c. Analyze the frequency of customer visits and identify any patterns.
SELECT 
    Customer.Name, 
    COUNT(Invoice.InvoiceID) AS VisitFrequency
FROM 
    Invoice
JOIN 
    Customer ON Invoice.CustomerID = Customer.CustomerID
GROUP BY 
    Customer.Name
ORDER BY 
    VisitFrequency DESC;

-- B. Vehicle Analysis
-- a. Calculate the average mileage of vehicles serviced.
SELECT 
    AVG(Vehicle.Mileage) AS AverageMileage
FROM 
    Vehicle;

-- b. Identify the most common vehicle makes and models brought in for service.
SELECT 
    Vehicle.Make, 
    Vehicle.Model, 
    COUNT(*) AS Frequency
FROM 
    Vehicle
GROUP BY 
    Vehicle.Make, Vehicle.Model
ORDER BY 
    Frequency DESC
LIMIT 5;

-- c. Analyze the distribution of vehicle ages and identify any trends in service requirements based on vehicle age.
SELECT 
    (YEAR(CURDATE()) - Vehicle.Year) AS VehicleAge, 
    COUNT(*) AS Frequency
FROM 
    Vehicle
GROUP BY 
    VehicleAge
ORDER BY 
    VehicleAge;

-- C. Job Performance Analysis
-- a. Determine the most common types of jobs performed and their frequency.
SELECT 
    Job.Description, 
    COUNT(*) AS Frequency
FROM 
    Job
GROUP BY 
    Job.Description
ORDER BY 
    Frequency DESC;

-- b. Calculate the total revenue generated from each type of job.
SELECT 
    Job.Description, 
    SUM(Job.Amount) AS TotalRevenue
FROM 
    Job
GROUP BY 
    Job.Description
ORDER BY 
    TotalRevenue DESC;

-- c. Identify the jobs with the highest and lowest average costs.
SELECT 
    Job.Description, 
    AVG(Job.Amount) AS AverageCost
FROM 
    Job
GROUP BY 
    Job.Description
ORDER BY 
    AverageCost DESC;

-- D. Parts Usage Analysis
-- a. List the top 5 most frequently used parts and their total usage.
SELECT 
    Parts.PartName, 
    COUNT(*) AS UsageFrequency
FROM 
    Parts
GROUP BY 
    Parts.PartName
ORDER BY 
    UsageFrequency DESC
LIMIT 5;

-- b. Calculate the average cost of parts used in repairs.
SELECT 
    AVG(Parts.Amount) AS AveragePartCost
FROM 
    Parts;

-- c. Determine the total revenue generated from parts sales.
SELECT 
    SUM(Parts.Amount) AS TotalPartsRevenue
FROM 
    Parts;

-- E. Financial Analysis
-- a. Calculate the total revenue generated from labor and parts for each month.
SELECT 
    YEAR(Invoice.InvoiceDate) AS Year, 
    MONTH(Invoice.InvoiceDate) AS Month, 
    SUM(Invoice.TotalLabour + Invoice.TotalParts) AS TotalRevenue
FROM 
    Invoice
GROUP BY 
    Year, Month
ORDER BY 
    Year, Month;

-- b. Determine the overall profitability of the repair shop.
SELECT 
    SUM(Invoice.Total) - SUM(Parts.Amount) AS Profit
FROM 
    Invoice, Parts
WHERE 
    Invoice.InvoiceID = Parts.InvoiceID;

-- c. Analyze the impact of sales tax on the total revenue.
SELECT 
    SUM(Invoice.Total) AS TotalRevenue, 
    SUM(Invoice.SalesTax) AS TotalSalesTax,
    SUM(Invoice.SalesTax) / SUM(Invoice.Total) AS Percent_tax
FROM 
    Invoice;

