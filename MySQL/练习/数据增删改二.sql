# 1. 使用现有数据库dbtest11
USE dbtest11;
# 2. 创建表格pet
CREATE TABLE pet (
  `name` VARCHAR(20),
  `owner` VARCHAR(20),
  species VARCHAR(20),
  sex CHAR(1),
  birth YEAR,
  death YEAR
);
# 3. 添加记录
INSERT INTO pet (`name`, `owner`, species, sex, birth, death)
VALUES ('Fluffy', 'harold', 'Cat', 'f', 2003, 2010),
('Claws', 'gwen', 'Cat', 'm', 2004, NULL),
('Buffy', NULL, 'Dog', 'f', 2009, NULL),
('Fang', 'benny', 'Dog', 'm', 2000, NULL),
('bowser', 'diane', 'Dog', 'm', 2003, 2009),
('Chirpy', NULL, 'Bird', 'f', 2008, NULL);
# 4. 添加字段:主人的生日owner_birth DATE类型。
ALTER TABLE pet
ADD COLUMN owner_birth DATE;
# 5. 将名称为Claws的猫的主人改为kevin
UPDATE pet
SET `owner` = 'kevin'
WHERE `name` = 'Claws'
AND species = 'Cat';
SELECT *
FROM pet;
# 6. 将没有死的狗的主人改为duck
UPDATE pet
SET `owner` = 'duck'
WHERE death IS NOT NULL
AND species = 'Dog';
# 7. 查询没有主人的宠物的名字；
SELECT `name`
FROM pet
WHERE `owner` IS NULL;
# 8. 查询已经死了的cat的姓名，主人，以及去世时间；
SELECT `name`, `owner`, death
FROM pet
WHERE death IS NOT NULL
AND species = 'Cat';
# 9. 删除已经死亡的狗
DELETE FROM pet
WHERE death IS NOT NULL
AND species = 'Dog';
# 10. 查询所有宠物信息
SELECT *
FROM pet;