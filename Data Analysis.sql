CREATE TABLE titles (
	title_id VARCHAR(50),
	title VARCHAR(50), 
   PRIMARY KEY (title_id)
     )

COPY titles(title_id, title)
FROM 'C:\Projects\KUDABC\HW\7\Data\titles.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM public.titles

-----------

CREATE TABLE departments (
	dept_no VARCHAR(50),
	dept_name VARCHAR(50), 
   PRIMARY KEY (dept_no)
     )

COPY departments(dept_no, dept_name)
FROM 'C:\Projects\KUDABC\HW\7\Data\departments.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM public.departments

-----------

CREATE TABLE employees (
	emp_no VARCHAR(50),
	emp_title_id VARCHAR(50),
	birth_date DATE,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	sex VARCHAR(50),
	hire_date DATE,
   PRIMARY KEY (emp_no)
     )

COPY employees(emp_no, emp_title_id, birth_date, first_name, last_name, sex, hire_date)
FROM 'C:\Projects\KUDABC\HW\7\Data\employees.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM public.employees

-----------

DROP table dept_emp;
CREATE TABLE dept_emp (
	emp_no VARCHAR(50),
	dept_no VARCHAR(50)

     )

COPY dept_emp(emp_no, dept_no)
FROM 'C:\Projects\KUDABC\HW\7\Data\dept_emp.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM public.dept_emp

-----------

CREATE TABLE salaries (
	emp_no VARCHAR(50),
	salary INTEGER,
   PRIMARY KEY (emp_no)
     )

COPY salaries(emp_no, salary)
FROM 'C:\Projects\KUDABC\HW\7\Data\salaries.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM public.salaries

-----------

CREATE TABLE dept_manager (
	dept_no VARCHAR(50),
	emp_no VARCHAR(50)
	)

COPY dept_manager(dept_no, emp_no)
FROM 'C:\Projects\KUDABC\HW\7\Data\dept_manager.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM public.dept_manager

-----------


-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.

SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no;


-- 2. List first name, last name, and hire date for employees who were hired in 1986.

SELECT e.first_name, e.last_name, e.hire_date
FROM employees e
WHERE e.hire_date >= '1/1/1986' AND e.hire_date <= '12/31/1986';


-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.

SELECT d.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name
FROM departments d
JOIN dept_manager dm 
ON d.dept_no = dm.dept_no
JOIN employees e 
ON e.emp_no = dm.emp_no;


-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp de
ON e.emp_no = de.emp_no
JOIN departments d
ON de.dept_no = d.dept_no;


-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

SELECT e.first_name, e.last_name, e.sex
FROM employees e
WHERE e.first_name = 'Hercules' 
AND e.last_name LIKE 'B%';


-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp de
ON de.emp_no = e.emp_no
JOIN departments d 
ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Sales';


-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp de
ON de.emp_no = e.emp_no
JOIN departments d 
ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development';


-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT e.last_name,
count(e.last_name)
FROM employees e
GROUP BY e.last_name
ORDER BY count(e.last_name) DESC