#1. 创建students数据表，如下
CREATE DATABASE test18_over;
USE test18_over;
CREATE TABLE students(
id INT PRIMARY KEY AUTO_INCREMENT,
student VARCHAR(15),
points TINYINT
);
#2. 向表中添加数据如下
INSERT INTO students(student,points)
VALUES
('张三',89),
('李四',77),
('王五',88),
('赵六',90),
('孙七',90),
('周八',88);
#3. 分别使用RANK()、DENSE_RANK() 和 ROW_NUMBER()函数对学生成绩降序排列情况进行显示
SELECT student, points, RANK() OVER(ORDER BY points DESC) AS '排序一',
DENSE_RANK() OVER(ORDER BY points DESC) AS '排序二',
ROW_NUMBER() OVER(ORDER BY points DESC) AS '排序三'
FROM students;

SELECT student, points, RANK() OVER w AS '排序一',
DENSE_RANK() OVER w AS '排序二',
ROW_NUMBER() OVER w AS '排序三'
FROM students WINDOW w AS (ORDER BY points DESC);