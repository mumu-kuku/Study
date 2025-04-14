#0.准备工作
SET GLOBAL log_bin_trust_function_creators = 1;

CREATE DATABASE test16_var_cur;
use test16_var_cur;
CREATE TABLE employees
AS
SELECT * FROM atguigudb.`employees`;
CREATE TABLE departments
AS
SELECT * FROM atguigudb.`departments`;

DESC employees;
DESC departments;
#无参有返回
#1. 创建函数get_count(),返回公司的员工个数
CREATE FUNCTION get_count()
RETURNS INT
BEGIN
  DECLARE emp_count INT DEFAULT 0;
  SELECT COUNT(*) INTO emp_count FROM employees;
  RETURN emp_count;
END;

SELECT get_count();
#有参有返回
#2. 创建函数ename_salary(),根据员工姓名，返回它的工资
CREATE FUNCTION ename_salary(u_name VARCHAR(25))
RETURNS DOUBLE
BEGIN
  DECLARE tmp_sal DOUBLE;
  
  SELECT salary INTO tmp_sal FROM employees WHERE last_name = u_name;
  RETURN tmp_sal;
END;

SELECT ename_salary('Abel');
#3. 创建函数dept_sal() ,根据部门名，返回该部门的平均工资
CREATE FUNCTION dept_sal(dpt_name VARCHAR(30))
RETURNS DOUBLE
BEGIN
  DECLARE avg_sal DOUBLE;
  
  SELECT AVG(salary) INTO avg_sal 
  FROM employees e
  JOIN departments d
  ON e.department_id = d.department_id
  WHERE d.department_name = dpt_name;
  RETURN avg_sal;
END;
#4. 创建函数add_float()，实现传入两个float，返回二者之和
CREATE FUNCTION add_float(a float, b float)
RETURNS FLOAT
BEGIN
  DECLARE sum FLOAT;
  SET sum = a + b;
  RETURN sum;
END;

SELECT add_float(5.5, 4.5);