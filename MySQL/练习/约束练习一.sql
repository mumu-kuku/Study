CREATE DATABASE test04_emp;
use test04_emp;
CREATE TABLE emp2(
id INT,
emp_name VARCHAR(15)
);
CREATE TABLE dept2(
id INT,
dept_name VARCHAR(15)
);
#1.向表emp2的id列中添加PRIMARY KEY约束
ALTER TABLE emp2
ADD PRIMARY KEY(id);
#2. 向表dept2的id列中添加PRIMARY KEY约束
ALTER TABLE dept2
MODIFY COLUMN id INT PRIMARY KEY;
#3. 向表emp2中添加列dept_id，并在其中定义FOREIGN KEY约束，与之相关联的列是dept2表中的id列。
ALTER TABLE emp2
ADD COLUMN dept_id INT; 
ALTER TABLE emp2
ADD CONSTRAINT fk_emp2_dept2 FOREIGN KEY(dept_id) REFERENCES dept2(id);
DESC emp2;