#0. 准备工作
USE test15_pro_func;
CREATE TABLE employees
AS
SELECT * FROM atguigudb.`employees`;
CREATE TABLE departments
AS
SELECT * FROM atguigudb.`departments`;

SET GLOBAL log_bin_trust_function_creators = 1;
#无参有返回
#1. 创建函数get_count(),返回公司的员工个数

CREATE FUNCTION get_count() RETURNS INT
BEGIN
  RETURN (SELECT count(*) FROM employees);
END;

SELECT get_count();
#有参有返回
#2. 创建函数ename_salary(),根据员工姓名，返回它的工资
CREATE FUNCTION ename_salary(ename VARCHAR(20)) RETURNS INT
BEGIN
  RETURN (SELECT salary FROM employees WHERE last_name = ename);
END;

SELECT * FROM departments;

SELECT ename_salary('Abel');
#3. 创建函数dept_sal() ,根据部门名，返回该部门的平均工资
CREATE FUNCTION dept_sal(dname VARCHAR(20)) RETURNS INT
BEGIN
  RETURN (
    SELECT AVG(salary)
    FROM employees e
    JOIN departments d
    ON e.department_id = d.department_id
    WHERE d.department_name = dname
  );
END;

DROP FUNCTION dept_sal;

SELECT dept_sal('Marketing');
#4. 创建函数add_float()，实现传入两个float，返回二者之和
CREATE FUNCTION add_float(float1 float, float2 float) RETURNS float
BEGIN
  RETURN (
    SELECT float1 + float2
  );
END;

SELECT add_float(1.1, 1.2);