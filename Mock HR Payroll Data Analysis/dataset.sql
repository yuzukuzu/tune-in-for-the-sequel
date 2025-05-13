DROP DATABASE IF EXISTS `Mock_HR_Payroll_Data`;
CREATE DATABASE `Mock_HR_Payroll_Data`;
USE `Mock_HR_Payroll_Data`;



-- Employees table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    hire_date DATE,
    base_salary DECIMAL(10, 2)
);

-- Payroll transactions
CREATE TABLE payroll (
    payroll_id INT PRIMARY KEY,
    employee_id INT REFERENCES employees(employee_id),
    pay_period DATE,
    hours_worked DECIMAL(5, 2),
    overtime_hours DECIMAL(5, 2),
    gross_pay DECIMAL(10, 2),
    net_pay DECIMAL(10, 2)
);

-- Tax withholdings
CREATE TABLE taxes (
    tax_id INT PRIMARY KEY,
    payroll_id INT REFERENCES payroll(payroll_id),
    federal_tax DECIMAL(10, 2),
    state_tax DECIMAL(10, 2),
    social_security DECIMAL(10, 2)
);

-- Benefits costs
CREATE TABLE benefits (
    benefit_id INT PRIMARY KEY,
    employee_id INT REFERENCES employees(employee_id),
    health_insurance DECIMAL(10, 2),
    retirement_match DECIMAL(10, 2)
);

-- Insert sample data
INSERT INTO employees VALUES 
(101, 'John', 'Smith', 'Sales', '2020-01-15', 60000.00),
(102, 'Janet', 'Nguyen', 'Engineering', '2019-03-22', 85000.00),
(103, 'Ethan', 'Moon', 'Sales', '2021-05-10', 55000.00),
(104, 'Emily', 'Davis', 'Engineering', '2022-02-18', 90000.00),
(105, 'David', 'Wilson', 'HR', '2020-11-30', 65000.00),
(106, 'Christy', 'Taylor', 'Finance', '2023-01-15', 70000.00),
(107, 'James', 'Anderson', 'Sales', '2018-07-22', 62000.00),
(108, 'Lisa', 'Thomas', 'Engineering', '2021-09-05', 95000.00),
(109, 'Robert', 'Jackson', 'Finance', '2019-04-12', 75000.00),
(110, 'Cindy', 'Lee', 'HR', '2022-08-20', 60000.00);

INSERT INTO payroll VALUES 
(1, 101, '2023-12-01', 80, 10, 2500.00, 1950.00),
(2, 102, '2023-12-01', 80, 5, 3200.00, 2400.00),
(3, 103, '2023-12-01', 80, 15, 2300.00, 1750.00),
(4, 104, '2023-12-01', 80, 2, 3500.00, 2600.00),
(5, 105, '2023-12-01', 80, 0, 2500.00, 1900.00),
(6, 106, '2023-12-01', 80, 5, 2700.00, 2050.00),
(7, 107, '2023-12-01', 80, 20, 2400.00, 1800.00),
(8, 108, '2023-12-01', 80, 0, 3800.00, 2850.00),
(9, 109, '2023-12-01', 80, 8, 2900.00, 2200.00),
(10, 110, '2023-12-01', 80, 3, 2300.00, 1750.00);

INSERT INTO taxes VALUES 
(1, 1, 300.00, 150.00, 100.00),
(2, 2, 500.00, 200.00, 150.00),
(3, 3, 280.00, 140.00, 130.00),
(4, 4, 520.00, 210.00, 170.00),
(5, 5, 300.00, 150.00, 150.00),
(6, 6, 350.00, 180.00, 120.00),
(7, 7, 290.00, 145.00, 165.00),
(8, 8, 600.00, 240.00, 110.00),
(9, 9, 370.00, 190.00, 140.00),
(10, 10, 280.00, 140.00, 130.00);

INSERT INTO benefits VALUES 
(1, 101, 200.00, 100.00),
(2, 102, 250.00, 150.00),
(3, 103, 180.00, 80.00),
(4, 104, 300.00, 200.00),
(5, 105, 220.00, 120.00),
(6, 106, 250.00, 150.00),
(7, 107, 190.00, 90.00),
(8, 108, 310.00, 210.00),
(9, 109, 260.00, 160.00),
(10, 110, 230.00, 130.00);
