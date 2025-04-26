USE atguigudb;
#11.查询平均工资高于公司平均工资的部门有哪些?
SELECT department_id
FROM employees
GROUP BY department_id
HAVING AVG(salary) > (
  SELECT AVG(salary)
  FROM employees
);
#12.查询出公司中所有 manager 的详细信息
SELECT *
FROM employees
WHERE employee_id = ANY (
  SELECT DISTINCT manager_id
  FROM employees
  WHERE manager_id IS NOT NULL 
);
#13.各个部门中 最高工资中最低的那个部门的 最低工资是多少?
SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MAX(salary) <= ALL (
  SELECT MAX(salary)
  FROM employees
  GROUP BY department_id
);
#14.查询平均工资最高的部门的 manager 的详细信息: last_name, department_id, email, salary
SELECT last_name, department_id, email, salary
FROM employees
WHERE employee_id = (
  SELECT manager_id
  FROM departments
  WHERE department_id = (
    SELECT department_id
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
    LIMIT 0, 1
  )
);
#15. 查询部门的部门号，其中不包括job_id是"ST_CLERK"的部门号
SELECT DISTINCT department_id
FROM employees
WHERE job_id != "ST_CLERK";
#16. 选择所有没有管理者的员工的last_name
SELECT last_name
FROM employees
WHERE manager_id IS NULL;
#17．查询员工号、姓名、雇用时间、工资，其中员工的管理者为 'De Haan'
SELECT employee_id, last_name, hire_date, salary
FROM employees
WHERE manager_id = (
  SELECT employee_id
  FROM employees
  WHERE last_name = 'De Haan'
);
#18.查询各部门中工资比本部门平均工资高的员工的员工号, 姓名和工资（相关子查询）
SELECT employee_id, last_name, salary
FROM employees emp
WHERE salary > (
  SELECT AVG(salary)
  FROM employees dpt
  WHERE dpt.department_id = emp.department_id
);

SELECT employee_id,last_name,salary
FROM employees e1,
(SELECT department_id,AVG(salary) avg_sal
FROM employees e2 GROUP BY department_id
) dept_avg_sal
WHERE e1.`department_id` = dept_avg_sal.department_id
AND e1.`salary` > dept_avg_sal.avg_sal;
#19.查询每个部门下的部门人数大于 5 的部门名称（相关子查询）
SELECT department_name
FROM departments d
WHERE 5 < (
  SELECT COUNT(*)
  FROM employees e
  WHERE e.department_id = d.department_id
);
#20.查询每个国家下的部门个数大于 2 的国家编号（相关子查询）
SELECT country_id
FROM locations l
WHERE 2 < (
  SELECT COUNT(*)
  FROM departments d
  WHERE l.location_id = d.location_id
);