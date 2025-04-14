#1.创建函数test_if_case()，实现传入成绩，如果成绩>90,返回A，如果成绩>80,返回B，如果成绩>60,返回C，否则返回D
#要求：分别使用if结构和case结构实现
USE test16_var_cur;
CREATE FUNCTION test_if_case(score INT)
RETURNS CHAR(1)
BEGIN
  DECLARE score_level CHAR(1);
--   IF score > 90
--     THEN SET score_level = 'A';
--   ELSEIF score > 80
--     THEN SET score_level = 'B';
--   ELSEIF score > 60
--     THEN SET score_level = 'C';
--   ELSE
--     SET score_level = 'D';
--   END IF;
CASE
WHEN score>90 THEN SET score_level = 'A';
WHEN score>80 THEN SET score_level = 'B';
WHEN score>60 THEN SET score_level = 'C';
ELSE SET score_level = 'D';
END CASE;
  RETURN score_level;
END;

SELECT test_if_case(96);
#2. 创建存储过程test_if_pro()，传入工资值，如果工资值<3000,则删除工资为此值的员工，如果3000 <= 工资值 <= 5000,则修改此工资值的员工薪资涨1000，否则涨工资500
CREATE PROCEDURE test_if_pro(IN sal DOUBLE)
BEGIN
  IF sal < 3000
    THEN DELETE FROM employees WHERE salary = sal;
  ELSEIF sal <= 5000
    THEN UPDATE employees SET salary = salary + 1000 WHERE salary = sal;
  ELSE
    UPDATE employees SET salary = salary + 500 WHERE salary = sal;
  END IF;
END;

SELECT last_name, salary, employee_id
FROM employees;

CALL test_if_pro(11000);
CALL test_if_pro(3100);
CALL test_if_pro(2900);

#3. 创建存储过程insert_data(),传入参数为 IN 的 INT 类型变量 insert_count,实现向admin表中批量插入insert_count条记录
CREATE TABLE admin(
id INT PRIMARY KEY AUTO_INCREMENT,
user_name VARCHAR(25) NOT NULL,
user_pwd VARCHAR(35) NOT NULL
);
SELECT * FROM admin;

CREATE PROCEDURE insert_data(IN insert_count INT)
BEGIN
  DECLARE c INT DEFAULT 1;
  WHILE c <= insert_count DO
    INSERT INTO admin(user_name, user_pwd) VALUES(CONCAT('mumu', c), ROUND(RAND() * 100000));
    SET c = c + 1;
  END WHILE;
END;

CALL insert_data(10);