# 1、创建数据库 test02_market 
CREATE DATABASE IF NOT EXISTS test02_market CHARACTER SET utf8mb4;
SHOW CREATE DATABASE test02_market;
# 2、创建数据表 customers
USE test02_market;
CREATE TABLE customers (
  c_num INT(8),
  c_name VARCHAR(50),
  c_contact VARCHAR(50),
  c_city VARCHAR(50),
  c_birth DATE
 );
 DESC customers;
# 3、将 c_contact 字段移动到 c_birth 字段后面
ALTER TABLE customers
MODIFY COLUMN c_contact VARCHAR(50) AFTER c_birth;
# 4、将 c_name 字段数据类型改为 varchar(70)
ALTER TABLE customers
MODIFY COLUMN c_name VARCHAR(70);
# 5、将c_contact字段改名为c_phone
ALTER TABLE customers
CHANGE COLUMN c_contact c_phone VARCHAR(50);
# 6、增加c_gender字段到c_name后面，数据类型为char(1)
ALTER TABLE customers
ADD COLUMN c_gender CHAR(1) AFTER c_name;
# 7、将表名改为customers_info
RENAME TABLE customers TO customers_info;
SHOW TABLES;
# 8、删除字段c_city
ALTER TABLE customers_info
DROP COLUMN c_city;