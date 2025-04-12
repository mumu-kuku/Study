#0.准备工作
CREATE DATABASE test15_pro_func;
USE test15_pro_func;
#1. 创建存储过程insert_user(),实现传入用户名和密码，插入到admin表中
CREATE TABLE admin(
id INT PRIMARY KEY AUTO_INCREMENT,
user_name VARCHAR(15) NOT NULL,
pwd VARCHAR(25) NOT NULL
);

CREATE PROCEDURE insert_user(IN NAME VARCHAR(15), IN pwd VARCHAR(25))
BEGIN 
  INSERT INTO admin(user_name, pwd) VALUES(NAME, pwd);
END 


SET @user_name = 'mumu';
SET @pwd = 'abc123456';
CALL insert_user(@user_name, @pwd);

SELECT * FROM admin;
#2. 创建存储过程get_phone(),实现传入女神编号，返回女神姓名和女神电话
CREATE TABLE beauty(
id INT PRIMARY KEY AUTO_INCREMENT,
NAME VARCHAR(15) NOT NULL,
phone VARCHAR(15) UNIQUE,
birth DATE
);
INSERT INTO beauty(NAME,phone,birth)
VALUES
('朱茵','13201233453','1982-02-12'),
('孙燕姿','13501233653','1980-12-09'),
('田馥甄','13651238755','1983-08-21'),
('邓紫棋','17843283452','1991-11-12'),
('刘若英','18635575464','1989-05-18'),
('杨超越','13761238755','1994-05-11');
SELECT * FROM beauty;

CREATE PROCEDURE get_phone(IN i_id INT, OUT o_name VARCHAR(15), OUT o_phone VARCHAR(15))
BEGIN
  SELECT NAME, phone INTO o_name, o_phone
  FROM beauty
  WHERE id = i_id;
END;

SET @name = '';
SET @phone = '';
SET @id = 3;
CALL get_phone(@id, @name, @phone);
SELECT @id, @name, @phone;
#3. 创建存储过程date_diff()，实现传入两个女神生日，返回日期间隔大小
CREATE PROCEDURE date_diff(IN birth1 DATE, IN birth2 DATE, OUT itv INT)
BEGIN
  SELECT ABS(DATEDIFF(birth1, birth2)) INTO itv;
END;

SET @birth1 = '1991-08-15';
SET @birth2 = '1991-10-15';
SET @itv = 0;
CALL date_diff(@birth1, @birth2, @itv);
SELECT @itv;
#4. 创建存储过程format_date(),实现传入一个日期，格式化成xx年xx月xx日并返回
CREATE PROCEDURE format_date(IN i_date DATE, OUT o_date VARCHAR(10))
BEGIN
  SELECT DATE_FORMAT(i_date, '%y年%m月%d日') INTO o_date;
END;

SET @i_date = '2025-12-12';
CALL format_date(@i_date, @o_date);
SELECT @o_date;
#5. 创建存储过程beauty_limit()，根据传入的起始索引和条目数，查询女神表的记录
CREATE PROCEDURE beauty_limit(IN i INT, IN count INT)
BEGIN
  SELECT * FROM beauty LIMIT i, count;
END;

CALL beauty_limit(1, 3);
#创建带inout模式参数的存储过程
#6. 传入a和b两个值，最终a和b都翻倍并返回
CREATE PROCEDURE add_double(INOUT a INT, INOUT b INT)
BEGIN
  SET a = a * 2;
  SET b = b * 2;
END;

SET @a = 1;
SET @b = 10;
call add_double(@a, @b);
SELECT @a, @b;
#7. 删除题目5的存储过程
DROP PROCEDURE beauty_limit;
#8. 查看题目6中存储过程的信息
SHOW CREATE PROCEDURE add_double;