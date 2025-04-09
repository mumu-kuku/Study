#1. 使用表employees创建视图employee_vu，其中包括姓名（LAST_NAME），员工号（EMPLOYEE_ID），部门号(DEPARTMENT_ID)
USE atguigudb;

CREATE OR REPLACE VIEW employee_vu
AS
SELECT last_name 'LAST_NAME', employee_id 'EMPLOYEE_ID', department_id 'DEPARTMENT_ID'
FROM employees;
#2. 显示视图的结构
DESC employee_vu;

SHOW COLUMNS FROM employee_vu;

SHOW CREATE VIEW employee_vu;
#3. 查询视图中的全部内容
SELECT *
FROM employee_vu;
#4. 将视图中的数据限定在部门号是80的范围内
CREATE OR REPLACE VIEW employee_vu
AS
SELECT last_name 'LAST_NAME', employee_id 'EMPLOYEE_ID', department_id 'DEPARTMENT_ID'
FROM employees
WHERE DEPARTMENT_ID = 80;