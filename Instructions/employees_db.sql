-- Create Employees table and test it.

CREATE TABLE employees (
	emp_no int,
	birth_date date,
	first_name char(30),
	last_name char(30),
	gender char(30),
	hire_date date,
	PRIMARY KEY (emp_no)
);

SELECT *
FROM employees

-- Create departments table and test it.

CREATE TABLE departments (
	dept_no char(30),
	dept_name char(30),
	PRIMARY KEY (dept_no)
);

SELECT *
FROM departments

-- Create department employees table and test it.

CREATE TABLE dept_emp (
	emp_no int,
	dept_no char(30),
	from_date date,
	to_date date,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

SELECT *
FROM dept_emp

-- Create department managers table and test it.

CREATE TABLE dept_manager (
	dept_no char(30),
	emp_no int,
	from_date date,
	to_date date,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

SELECT *
FROM dept_manager

-- Create employees' salaries table and test it.

CREATE TABLE salaries (
	emp_no int,
	salaries int,
	from_date date,
	to_date date,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

SELECT *
FROM salaries

-- Create employees' titles table and test it.

CREATE TABLE titles (
	emp_no int,
	title char(30),
	from_date date,
	to_date date,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

SELECT *
FROM titles

-- 1. List the following details of each employee: 
--    employee number, last name, first name, gender, and salary.

SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salaries
FROM employees AS e
LEFT JOIN salaries AS s ON e.emp_no = s.emp_no;

-- 2. List employees who were hired in 1986.--

SELECT *
FROM employees
WHERE date_part('year',hire_date) =1986; 
			
-- 3. List the manager of each department with the following information: 
--    department number, department name, the manager's employee number, 
--    last name, first name, and start and end employment dates.

SELECT d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name, dm.from_date, dm.to_date
FROM departments AS d
INNER JOIN dept_manager AS dm ON
dm.dept_no = d.dept_no
JOIN employees AS e ON
e.emp_no = dm.emp_no;

-- 4. List the department of each employee with the following information: 
--    employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
INNER JOIN dept_emp AS de ON
e.emp_no = de.emp_no
INNER JOIN departments AS d ON
d.dept_no = de.dept_no;

--5. List all employees whose first name is "Hercules" and last names begin with "B."

SELECT *
FROM public.employees
WHERE first_name = 'Hercules' AND last_name like ('B%');

--6. List all employees in the Sales department, including their employee number, 
--   last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
INNER JOIN dept_emp AS de ON
e.emp_no = de.emp_no
INNER JOIN departments AS d ON
d.dept_no = de.dept_no
WHERE d.dept_name = 'Sales';
		
-- 7. List all employees in the Sales and Development departments, 
--    including their employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
INNER JOIN dept_emp AS de ON
e.emp_no = de.emp_no
INNER JOIN departments AS d ON
d.dept_no = de.dept_no
WHERE d.dept_name = 'Development'
OR d.dept_name = 'Sales';
		
-- 8. In descending order, list the frequency count of employee last names, 
--    i.e., how many employees share each last name.

SELECT last_name, COUNT(*) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;

