#1.查询和Zlotkey相同部门的员工姓名和工资
SELECT
  last_name,
  salary 
FROM
  employees 
WHERE
  department_id = ( SELECT department_id FROM employees WHERE last_name = "Zlotkey" ) 
  AND last_name <> "Zlotkey";

SELECT
  e.last_name,
  e.salary 
FROM
  employees e
  JOIN employees z ON e.department_id = z.department_id 
WHERE
  z.last_name = "Zlotkey" 
  AND e.last_name <> "Zlotkey";
#2.查询工资比公司平均工资高的员工的员工号，姓名和工资。
SELECT employee_id, last_name, salary
FROM employees
WHERE salary > (
                SELECT AVG(salary)
                FROM employees
               );

SELECT e.employee_id, e.last_name, e.salary
FROM employees e
JOIN (
      SELECT AVG(salary) av
      FROM employees
      ) s
ON e.salary > s.av;
#3.选择工资大于所有JOB_ID = 'SA_MAN'的员工的工资的员工的last_name, job_id, salary
SELECT last_name, job_id, salary
FROM employees
WHERE salary > ALL (
                      SELECT salary
                      FROM employees
                      WHERE job_id = "SA_MAN"
                    );
#4.查询和姓名中包含字母u的员工在相同部门的员工的员工号和姓名
SELECT
  employee_id,
  last_name 
FROM
  employees 
WHERE
  department_id IN ( SELECT department_id FROM employees WHERE last_name LIKE "%u%" );

#5.查询在部门的location_id为1700的部门工作的员工的员工号
SELECT
  employee_id 
FROM
  employees 
WHERE
  department_id IN ( SELECT department_id FROM departments WHERE location_id = 1700 );

#6.查询管理者是King的员工姓名和工资
SELECT
  last_name,
  salary 
FROM
  employees 
WHERE
  manager_id IN ( SELECT employee_id FROM employees WHERE last_name = "King" );
#7.查询工资最低的员工信息: last_name, salary
SELECT
  last_name,
  salary 
FROM
  employees 
WHERE
  salary = ( SELECT MIN( salary ) FROM employees );
  
SELECT
  last_name,
  salary 
FROM
  employees 
ORDER BY
  salary 
  LIMIT 1;
#8.查询平均工资最低的部门信息
SELECT
  department_name,
  department_id 
FROM
  departments 
WHERE
  department_id = (
  SELECT
    department_id 
  FROM
    employees 
  GROUP BY
    department_id 
  HAVING
    AVG( salary ) = ( SELECT MIN( dept_avgsal ) FROM ( SELECT AVG( salary ) dept_avgsal FROM employees GROUP BY department_id ) avg_sal ) 
  )
#9.查询平均工资最低的部门信息和该部门的平均工资（相关子查询）
SELECT d.*,dept_avg_sal.avg_sal
FROM departments d,(
SELECT department_id,AVG(salary) avg_sal
FROM employees
GROUP BY department_id
ORDER BY avg_sal
LIMIT 0,1) dept_avg_sal
WHERE d.department_id = dept_avg_sal.department_id