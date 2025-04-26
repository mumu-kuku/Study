#1.查询和Zlotkey相同部门的员工姓名和工资
SELECT last_name, salary
FROM employees
WHERE department_id = (
  SELECT department_id
  FROM employees
  WHERE last_name = 'Zlotkey')
AND last_name != 'Zlotkey';

SELECT emp.last_name, emp.salary
FROM employees emp
JOIN employees dep
ON emp.department_id = dep.department_id
WHERE dep.last_name = 'Zlotkey'
AND emp.last_name != 'Zlotkey';
#2.查询工资比公司平均工资高的员工的员工号，姓名和工资。
SELECT employee_id, last_name, salary
FROM employees
WHERE salary > (
  SELECT AVG(salary)
  FROM employees
);

SELECT employee_id, last_name, salary
FROM employees
JOIN (
  SELECT AVG(salary) avg_salary
  FROM employees
) avg_table
ON salary > avg_salary;
#3.选择工资大于所有JOB_ID = 'SA_MAN'的员工的工资的员工的last_name, job_id, salary
SELECT last_name, job_id, salary
FROM employees
WHERE salary > ALL (
  SELECT salary
  FROM employees
  WHERE job_id = 'SA_MAN'
);

SELECT last_name, job_id, salary
FROM employees
WHERE salary > (
  SELECT MAX(salary)
  FROM employees
  WHERE job_id = 'SA_MAN'
);
#4.查询和姓名中包含字母u的员工在相同部门的员工的员工号和姓名
SELECT department_id, last_name
FROM employees
WHERE department_id IN (
  SELECT department_id
  FROM employees
  WHERE last_name LIKE '%u%'
);

SELECT department_id, last_name
FROM employees e1
WHERE EXISTS (
  SELECT 1
  FROM employees e2
  WHERE e1.department_id = e2.department_id
  AND e2.last_name LIKE '%u%'
);
#5.查询在部门的location_id为1700的部门工作的员工的员工号
SELECT employee_id
FROM employees
WHERE department_id IN (
  SELECT department_id
  FROM departments
  WHERE location_id = 1700
);

SELECT employee_id
FROM employees e
WHERE EXISTS (
  SELECT 1
  FROM departments d
  WHERE d.location_id = 1700
  AND e.department_id = d.department_id
);

SELECT employee_id
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
WHERE d.location_id = 1700;
#6.查询管理者是King的员工姓名和工资
SELECT last_name, salary
FROM employees
WHERE manager_id IN (
  SELECT employee_id
  FROM employees
  WHERE last_name = 'King'
);

SELECT last_name, salary
FROM employees e1
WHERE EXISTS (
  SELECT 1
  FROM employees e2
  WHERE e2.last_name = 'King'
  AND e1.manager_id = e2.employee_id
);

SELECT emp.last_name, emp.salary
FROM employees emp
JOIN employees mgr
ON emp.manager_id = mgr.employee_id
AND mgr.last_name = 'King';
#7.查询工资最低的员工信息: last_name, salary
SELECT last_name, salary
FROM employees
WHERE salary = (
  SELECT MIN(salary)
  FROM employees
);

SELECT last_name, salary
FROM employees
ORDER BY salary
LIMIT 1;
#8.查询平均工资最低的部门信息
SELECT *
FROM departments
WHERE department_id = (
    SELECT department_id
    FROM employees
    GROUP BY department_id
    HAVING AVG(salary) = (
     SELECT MIN(avg_salary)
     FROM (
      SELECT AVG(salary) avg_salary
      FROM employees
      GROUP BY department_id
     ) avg_table
  )
);

SELECT *
FROM departments
WHERE department_id = (
    SELECT department_id
    FROM employees
    GROUP BY department_id
    HAVING AVG(salary) = (
      SELECT AVG(salary) avg_salary
      FROM employees
      GROUP BY department_id
      ORDER BY avg_salary
      LIMIT 1
    )
);

SELECT *
FROM departments
WHERE department_id = (
    SELECT department_id
    FROM employees
    GROUP BY department_id
    HAVING AVG(salary) <= ALL (
      SELECT AVG(salary)
      FROM employees
      GROUP BY department_id
    )
);

SELECT d.*
FROM departments d,(
  SELECT department_id,AVG(salary) avg_sal
  FROM employees
  GROUP BY department_id
  ORDER BY avg_sal
  LIMIT 0,1) dept_avg_sal
WHERE d.department_id = dept_avg_sal.department_id
#9.查询平均工资最低的部门信息和该部门的平均工资（相关子查询）
SELECT d.*, (SELECT AVG(salary) FROM employees WHERE department_id = d.department_id)
FROM departments d
WHERE department_id = (
    SELECT department_id
    FROM employees
    GROUP BY department_id
    HAVING AVG(salary) = (
     SELECT MIN(dep_avgsal)
     FROM (
      SELECT AVG(salary) dep_avgsal
      FROM employees
      GROUP BY department_id
     ) avg_table
  )
);

SELECT d.*, (SELECT AVG(salary) FROM employees WHERE department_id = d.department_id) avg_salary
FROM departments d
WHERE department_id = (
    SELECT department_id
    FROM employees
    GROUP BY department_id
    HAVING AVG(salary) <= ALL (
      SELECT AVG(salary)
      FROM employees
      GROUP BY department_id
    )
);

SELECT d.*, (SELECT AVG(salary) FROM employees WHERE department_id = d.department_id) avg_salary
FROM departments d
WHERE department_id = (
    SELECT department_id
    FROM employees
    GROUP BY department_id
    HAVING AVG(salary) = (
      SELECT AVG(salary) avg_salary
      FROM employees
      GROUP BY department_id
      ORDER BY avg_salary
      LIMIT 1
    )
);

SELECT d.*, dept_avg_sal.avg_sal
FROM departments d,(
  SELECT department_id,AVG(salary) avg_sal
  FROM employees
  GROUP BY department_id
  ORDER BY avg_sal
  LIMIT 0,1) dept_avg_sal
WHERE d.department_id = dept_avg_sal.department_id

#10.查询平均工资最高的 job 信息
-- 方法一：子查询 LIMIT 获取平均工资最高的 job_id
SELECT *
FROM jobs
WHERE job_id = (
	SELECT job_id
	FROM employees
	GROUP BY job_id
	ORDER BY AVG(salary) DESC
	LIMIT 0, 1
);
-- 方法二：第一层获取平均工资，第二层获取最高平均工资的 job_id,第三层获取 job 信息
SELECT *
FROM jobs
WHERE job_id = (
		SELECT job_id
		FROM employees
		GROUP BY job_id
		HAVING AVG(salary) >= ALL (
			SELECT AVG(salary)
			FROM employees
			GROUP BY job_id
		)
);

-- 方法三：子查询获取平均工资最高的平均工资，作为内连接的第二个表，通过连接条件获取信息
SELECT j.*
FROM jobs j, (
	SELECT job_id
	FROM employees e
	GROUP BY job_id
	ORDER BY AVG(salary) DESC
	LIMIT 0, 1
) emp_max_job
WHERE j.job_id = emp_max_job.job_id;

-- 方法四：第一层获取平均工资，第二层获取最高的平均工资，第三层获取平均工资最高的job_id,第四层获取 job 信息
SELECT *
FROM jobs
WHERE job_id = (
    SELECT job_id
    FROM employees
    GROUP BY job_id
    HAVING AVG(salary) = (
     SELECT MAX(avg_salary)
     FROM (
      SELECT AVG(salary) avg_salary
      FROM employees
      GROUP BY job_id
     ) max_table
	)
);
