#1. 创建数据库dbtest11
CREATE DATABASE IF NOT EXISTS dbtest11 CHARACTER SET 'utf8';
#2. 运行以下脚本创建表my_employees
USE dbtest11;
CREATE TABLE my_employees(
id INT(10),
first_name VARCHAR(10),
last_name VARCHAR(10),
userid VARCHAR(10),
salary DOUBLE(10,2)
);
CREATE TABLE users(
id INT,
userid VARCHAR(10),
department_id INT
);
#3. 显示表my_employees的结构
DESC my_employees;

SELECT *
FROM my_employees;
#4. 向my_employees表中插入下列数据
ID FIRST_NAME LAST_NAME USERID SALARY
1 patel Ralph Rpatel 895
2 Dancs Betty Bdancs 860
3 Biri Ben Bbiri 1100
4 Newman Chad Cnewman 750
5 Ropeburn Audrey Aropebur 1550

INSERT INTO my_employees
VALUES (1, 'patel', 'Ralph', 'Rpatel', 895);

# 方法一
INSERT INTO my_employees (id, first_name, last_name, userid, salary)
VALUES (2, 'Dancs', 'Betty', 'Bdancs', 860),
(3, 'Biri', 'Ben', 'Bbiri', 1100),
(4, 'Newman', 'Chad', 'Cnewman', 750),
(5, 'Ropeburn', 'Audrey', 'Aropebur', 1550);

# 方法二
INSERT INTO my_employees (id, first_name, last_name, userid, salary)
SELECT 2, 'Dancs', 'Betty', 'Bdancs', 860 UNION ALL
SELECT 3, 'Biri', 'Ben', 'Bbiri', 1100 UNION ALL
SELECT 4, 'Newman', 'Chad', 'Cnewman', 750 UNION ALL
SELECT 5, 'Ropeburn', 'Audrey', 'Aropebur', 1550;
#5. 向users表中插入数据
1 Rpatel 10
2 Bdancs 10
3 Bbiri 20
4 Cnewman 30
5 Aropebur 40

INSERT INTO users VALUES
(1,'Rpatel',10),
(2,'Bdancs',10),
(3,'Bbiri',20),
(4,'Cnewman',30),
(5,'Aropebur',40);
#6. 将3号员工的last_name修改为“drelxer”
UPDATE my_employees
SET last_name = "drelxer"
WHERE id = 3;

SELECT *
FROM my_employees;

DESC my_employees;
#7. 将所有工资少于900的员工的工资修改为1000
UPDATE my_employees
SET salary = 1000
WHERE salary < 900;
#8. 将userid为Bbiri的user表和my_employees表的记录全部删除
DELETE u,e
FROM `users` u
JOIN my_employees e
ON u.userid = e.userid
WHERE u.userid = "Bbiri";

SELECT *
FROM my_employees;
SELECT *
FROM users;
#9. 删除my_employees、users表所有数据
DELETE FROM my_employees;
DELETE FROM users;
#10. 检查所作的修正
SELECT *
FROM my_employees;

SELECT *
FROM users;
#11. 清空表my_employees
TRUNCATE TABLE my_employees;