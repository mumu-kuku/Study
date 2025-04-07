#1.所有有门派的人员信息
（ A、B两表共有）
DESC t_dept;
DESC t_emp;
SELECT *
FROM t_emp;
SELECT e.`name`, e.`age`, d.`id`, d.deptName
FROM t_emp e
JOIN t_dept d
ON e.deptId = d.id;
#2.列出所有用户，并显示其机构信息
（A的全集）
SELECT e.`name`, e.`age`, d.`id`, d.deptName
FROM t_emp e
LEFT JOIN t_dept d
ON e.deptId = d.id;
#3.列出所有门派
（B的全集）
SELECT e.`name`, e.`age`, d.`id`, d.deptName
FROM t_emp e
RIGHT JOIN t_dept d
ON e.deptId = d.id;
#4.所有不入门派的人员
（A的独有）
SELECT e.`name`, e.`age`, d.`id`, d.deptName
FROM t_emp e
LEFT JOIN t_dept d
ON e.deptId = d.id
WHERE d.id IS NULL;
#5.所有没人入的门派
（B的独有）
SELECT e.`name`, e.`age`, d.`id`, d.deptName
FROM t_emp e
RIGHT JOIN t_dept d
ON e.deptId = d.id
WHERE e.deptId Is NULL;
#6.列出所有人员和机构的对照关系
(AB全有)
SELECT e.`name`, e.`age`, d.`id`, d.deptName
FROM t_emp e
LEFT JOIN t_dept d
ON e.deptId = d.id
UNION ALL
SELECT e.`name`, e.`age`, d.`id`, d.deptName
FROM t_dept d
LEFT JOIN t_emp e
ON d.id = e.deptId
WHERE e.deptId IS NULL;
#MySQL Full Join的实现 因为MySQL不支持FULL JOIN,下面是替代方法
#left join + union(可去除重复数据)+ right join
#7.列出所有没入派的人员和没人入的门派
（A的独有+B的独有）
SELECT e.`name`, e.`age`, d.`id`, d.`deptName`
FROM t_emp e
LEFT JOIN t_dept d
ON e.deptId = d.id
WHERE d.id IS NULL
UNION ALL
SELECT e.`name`, e.`age`, d.`id`, d.`deptName`
FROM t_dept d
LEFT JOIN t_emp e
ON d.id = e.deptId
WHERE e.deptId IS NULL;