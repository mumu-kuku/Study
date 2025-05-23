#1. 创建数据库test01_office,指明字符集为utf8。并在此数据库下执行下述操作
CREATE DATABASE IF NOT EXISTS test01_office CHARACTER SET utf8mb4;

SHOW DATABASES;

USE test01_office;
#2. 创建表dept01
/*
字段 类型
id INT(7)
NAME VARCHAR(25)
*/
CREATE TABLE dept01 (
  id INT(7),
  NAME VARCHAR(25)
);

SHOW TABLES;
#3. 将表departments中的数据插入新表dept02中
CREATE TABLE IF NOT EXISTS dept02
AS
SELECT * FROM atguigudb.departments;

DESC dept02;
#4. 创建表emp01
/*
字段 类型
id INT(7)
first_name VARCHAR (25)
last_name VARCHAR(25)
dept_id INT(7)
*/
CREATE TABLE emp01 (
  id INT(7),
  first_name VARCHAR(25),
  last_name VARCHAR(25),
  dept_id INT(7)
);
DESC emp01;
#5. 将列last_name的长度增加到50
ALTER TABLE emp01
MODIFY COLUMN last_name VARCHAR(50);
#6. 根据表employees创建emp02
CREATE TABLE IF NOT EXISTS emp02
AS
SELECT *
FROM atguigudb.employees;
DESC emp02;
#7. 删除表emp01
DROP TABLE IF EXISTS emp01;
SHOW TABLES;
#8. 将表emp02重命名为emp01
RENAME TABLE emp02 TO emp01;

ALTER TABLE emp02 RENAME TO emp01;
#9.在表dept02和emp01中添加新列test_column，并检查所作的操作
ALTER TABLE dept02
ADD COLUMN test_column VARCHAR(15);
ALTER TABLE emp01
ADD COLUMN test_column varchar(15);
DESC dept02;
DESC emp01;
#10.直接删除表emp01中的列 department_id
ALTER TABLE emp01
DROP COLUMN department_id;