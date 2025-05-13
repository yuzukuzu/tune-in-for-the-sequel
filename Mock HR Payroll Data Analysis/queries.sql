-- Overtime (OT) Cost Analysis by Department
SELECT 
    e.department,
    COUNT(DISTINCT e.employee_id) AS employee_count,
    SUM(p.overtime_hours) AS total_overtime_hours,
    ROUND(SUM(p.overtime_hours * (e.base_salary/2080) * 1.5), 2) AS total_OT_cost,
    ROUND(AVG(p.overtime_hours), 1) AS avg_OT_hours_per_employee
FROM employees e
JOIN payroll p ON e.employee_id = p.employee_id
GROUP BY e.department
ORDER BY total_OT_cost DESC;


-- Tax Withholdings Analysis
SELECT 
    e.department,
    ROUND(SUM(t.federal_tax + t.state_tax), 2) AS total_tax_withholdings,
    ROUND(SUM(p.gross_pay), 2) AS total_gross_pay,
    ROUND(SUM(t.federal_tax + t.state_tax) / SUM(p.gross_pay) * 100, 2) AS effective_tax_rate
FROM employees e
JOIN payroll p ON e.employee_id = p.employee_id
JOIN taxes t ON p.payroll_id = t.payroll_id
GROUP BY e.department
ORDER BY effective_tax_rate DESC;


-- Department-Level Labor Expenses
SELECT 
    e.department,
    ROUND(SUM(p.gross_pay), 2) AS total_salary_cost,
    ROUND(SUM(b.health_insurance + b.retirement_match), 2) AS total_benefits_cost,
    ROUND(SUM(p.gross_pay + b.health_insurance + b.retirement_match), 2) AS total_labor_cost,
    ROUND(SUM(p.gross_pay + b.health_insurance + b.retirement_match) / COUNT(DISTINCT e.employee_id), 2) AS cost_per_employee
FROM employees e
JOIN payroll p ON e.employee_id = p.employee_id
JOIN benefits b ON e.employee_id = b.employee_id
GROUP BY e.department
ORDER BY total_labor_cost DESC;


-- Tax Audit Flags (Potential Discrepancies)
SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    e.department,
    p.gross_pay,
    (t.federal_tax + t.state_tax) AS total_taxes,
    ROUND((t.federal_tax + t.state_tax) / p.gross_pay * 100, 2) AS tax_rate,
    CASE 
        WHEN (t.federal_tax + t.state_tax) / p.gross_pay * 100 < 18 THEN 'LOW TAX RATE - AUDIT REQUIRED'
        WHEN (t.federal_tax + t.state_tax) / p.gross_pay * 100 > 25 THEN 'HIGH TAX RATE - VERIFY'
        ELSE 'NORMAL'
    END AS audit_status
FROM employees e
JOIN payroll p ON e.employee_id = p.employee_id
JOIN taxes t ON p.payroll_id = t.payroll_id
WHERE (t.federal_tax + t.state_tax) / p.gross_pay * 100 < 18 
   OR (t.federal_tax + t.state_tax) / p.gross_pay * 100 > 25
ORDER BY tax_rate;


-- Average Benefits Cost by Department
SELECT 
    e.department,
    ROUND(AVG(b.health_insurance), 2) AS avg_health_insurance,
    ROUND(AVG(b.retirement_match), 2) AS avg_retirement_match,
    ROUND(AVG(b.health_insurance + b.retirement_match), 2) AS avg_total_benefits,
    ROUND(AVG(b.health_insurance + b.retirement_match) / AVG(e.base_salary) * 100, 2) AS benefits_as_percent_of_salary
FROM employees e
JOIN benefits b ON e.employee_id = b.employee_id
GROUP BY e.department
ORDER BY avg_total_benefits DESC;


-- Comprehensive Payroll Summary Report
SELECT 
    e.department,
    COUNT(DISTINCT e.employee_id) AS headcount,
    ROUND(SUM(p.gross_pay), 2) AS total_gross_pay,
    ROUND(SUM(p.overtime_hours * (e.base_salary/2080) * 1.5), 2) AS total_OT_cost,
    ROUND(SUM(t.federal_tax + t.state_tax + t.social_security), 2) AS total_taxes,
    ROUND(SUM(b.health_insurance + b.retirement_match), 2) AS total_benefits,
    ROUND(SUM(p.gross_pay + b.health_insurance + b.retirement_match), 2) AS total_compensation_cost
FROM employees e
JOIN payroll p ON e.employee_id = p.employee_id
JOIN taxes t ON p.payroll_id = t.payroll_id
JOIN benefits b ON e.employee_id = b.employee_id
GROUP BY e.department
ORDER BY total_compensation_cost DESC;


-- Employee-Level Payroll Details (for Drill-Down Analysis)
SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    e.department,
    e.base_salary,
    p.hours_worked,
    p.overtime_hours,
    p.gross_pay,
    p.net_pay,
    t.federal_tax,
    t.state_tax,
    t.social_security,
    b.health_insurance,
    b.retirement_match,
    ROUND((t.federal_tax + t.state_tax) / p.gross_pay * 100, 2) AS tax_rate,
    ROUND((b.health_insurance + b.retirement_match) / e.base_salary * 1200, 2) AS benefits_as_percent_of_salary
FROM employees e
JOIN payroll p ON e.employee_id = p.employee_id
JOIN taxes t ON p.payroll_id = t.payroll_id
JOIN benefits b ON e.employee_id = b.employee_id
ORDER BY e.department, e.last_name;
