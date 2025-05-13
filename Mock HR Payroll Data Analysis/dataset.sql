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
(101, 'John', 'Doe', 'Sales', '2020-01-15', 60000.00),
(102, 'Jane', 'Smith', 'Engineering', '2019-03-22', 85000.00);

INSERT INTO payroll VALUES 
(1, 101, '2023-12-01', 80, 10, 2500.00, 1950.00),
(2, 102, '2023-12-01', 80, 5, 3200.00, 2400.00);

INSERT INTO taxes VALUES 
(1, 1, 300.00, 150.00, 100.00),
(2, 2, 500.00, 200.00, 150.00);

INSERT INTO benefits VALUES 
(1, 101, 200.00, 100.00),
(2, 102, 250.00, 150.00);
