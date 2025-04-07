#1.where子句可否使用组函数进行过滤?
no
SELECT *
FROM employees;
#2.查询公司员工工资的最大值，最小值，平均值，总和
SELECT MAX(salary) "max", MIN(salary) "min", AVG(salary) "avg", SUM(salary) "sum"
FROM employees;
#3.查询各job_id的员工工资的最大值，最小值，平均值，总和
SELECT job_id, MAX(salary) "max", MIN(salary) "min", AVG(salary) "avg", SUM(salary) "sum"
FROM employees
GROUP BY job_id;
#4.选择具有各个job_id的员工人数
SELECT job_id, COUNT(*)
FROM employees
GROUP BY job_id;
# 5.查询员工最高工资和最低工资的差距（DIFFERENCE）
SELECT MAX(salary) - MIN(salary) "DIFFERENCE"
FROM employees;
# 6.查询各个管理者手下员工的最低工资，其中最低工资不能低于6000，没有管理者的员工不计算在内
SELECT manager_id, MIN(salary) "min salary"
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id
HAVING MIN(salary) >= 6000;
# 7.查询所有部门的名字，location_id，员工数量和平均工资，并按平均工资降序
SELECT d.department_name, d.department_id, d.location_id, count(e.employee_id), AVG(e.salary) "avg salary"
FROM departments d
LEFT JOIN employees e
ON d.department_id = e.department_id
GROUP BY d.department_id
ORDER BY AVG(e.salary) ASC;
# 8.查询每个工种、每个部门的部门名、工种名和最低工资
SELECT e.job_id, d.department_name, MIN(e.salary)
FROM departments d
LEFT JOIN employees e
ON d.department_id = e.department_id
GROUP BY e.job_id, d.department_id
UNION ALL
SELECT e.job_id, d.department_name, MIN(e.salary) "min salary"
FROM departments d
RIGHT JOIN employees e
ON d.department_id = e.department_id
WHERE d.department_id IS NULL
GROUP BY e.job_id, d.department_id;