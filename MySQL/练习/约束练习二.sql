# 1、创建数据库test01_library
CREATE DATABASE IF NOT EXISTS test01_library CHARACTER SET 'utf8mb4';
USE test01_library;
# 2、创建表 books，表结构如下：
CREATE TABLE books (
  id INT,
  `name` VARCHAR(50),
  `authors` VARCHAR(100),
  price FLOAT,
  pubdate YEAR,
  note VARCHAR(100),
  num INT
);

# 3、使用ALTER语句给books按如下要求增加相应的约束
ALTER TABLE books
ADD PRIMARY KEY(id);

ALTER TABLE books
MODIFY COLUMN id INT AUTO_INCREMENT;

ALTER TABLE books MODIFY name VARCHAR(50) NOT NULL;
ALTER TABLE books MODIFY `authors` VARCHAR(100) NOT NULL;
ALTER TABLE books MODIFY price FLOAT NOT NULL;
ALTER TABLE books MODIFY pubdate DATE NOT NULL;
ALTER TABLE books MODIFY num INT NOT NULL;