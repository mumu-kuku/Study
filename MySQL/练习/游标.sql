#创建存储过程update_salary()，参数1为 IN 的INT型变量dept_id，表示部门id；参数2为 IN的INT型变量change_sal_count，表示要调整薪资的员工个数。查询指定id部门的员工信息，按照salary升序排列，根据hire_date的情况，调整前change_sal_count个员工的薪资，详情如下。
USE test16_var_cur;

CREATE PROCEDURE update_salary(IN dept_id INT, IN change_sal_count INT)
BEGIN
  DECLARE int_count INT DEFAULT 0;
  DECLARE salary_rate DOUBLE DEFAULT 0.0;
  DECLARE emp_id INT;
  DECLARE emp_hire_date DATE;
  
  DECLARE emp_cursor CURSOR FOR SELECT employee_id, hire_date FROM employees
  WHERE dept_id = department_id ORDER BY salary;
  
  OPEN emp_cursor;
  
  WHILE int_count >= change_sal_count DO
    FETCH emp_cursor INTO emp_id, emp_hire_date;
    IF(YEAR(emp_hire_date) < 1995)
      THEN SET salary_rate = 1.2;
    ELSEIF(YEAR(emp_hire_date) <= 1998)
      THEN SET salary_rate = 1.15;
    ELSEIF(YEAR(emp_hire_date) <= 2001)
      THEN SET salary_rate = 1.10;
    ELSE 
      SET salary_rate = 1.05;
    END IF;
    
    UPDATE employees SET salary = salary * salary_rate
    WHERE employee_id = emp_id;
    
    SET int_count = int_count + 1;
END WHILE;
  CLOSE emp_cursor;
  
END;

CALL update_salary(50,2);