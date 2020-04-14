-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "titles" (
    "emp_no" INT   NOT NULL,
    "title" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

-- Data Analysis
-- List the following details of each employee: 
-- employee number, last name, first name, gender, and salary

select * from employees
select * from salaries

select e.emp_no, e.last_name, e.first_name, e.gender, s.salary
from employees e
join salaries s 
on e.emp_no = s.emp_no;

-- List employees who were hired in 1986.
select emp_no, first_name, last_name, hire_date
from employees
where hire_date between '1986-01-01' and '1987-01-01'

-- List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, 
-- last name, first name, and start and end employment dates.
select * from dept_manager
select * from departments
select d.dept_no, d.dept_name, dm.emp_no, dm.from_date, dm.to_date, e.last_name, e.first_name
from departments d
join dept_manager dm on d.dept_no = dm.dept_no
join employees e on dm.emp_no = e.emp_no

-- List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.

select dm.emp_no, e.last_name, e.first_name, d.dept_name
from dept_manager dm
join employees e on dm.emp_no = e.emp_no
join departments d on dm.dept_no = d.dept_no

-- List all employees whose first name is "Hercules" and last names begin with "B."
select first_name, last_name
from employees
where first_name = 'Hercules' and last_name like 'B%'

-- List all employees in the Sales department, including their 
-- employee number, last name, first name, and department name.

select dm.emp_no, e.last_name, e.first_name, d.dept_name
from dept_manager dm
join employees e on dm.emp_no = e.emp_no
join departments d on dm.dept_no = d.dept_no
where d.dept_name = 'Sales'

-- List all employees in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name.
select dm.emp_no, e.last_name, e.first_name, d.dept_name
from dept_manager dm
join employees e on dm.emp_no = e.emp_no
join departments d on dm.dept_no = d.dept_no
where d.dept_name = 'Sales' or d.dept_name = 'Development'

-- In descending order, list the frequency count of employee last names, 
-- i.e., how many employees share each last name.
select last_name, count(last_name) as "frequency"
from employees
group by last_name
order by 
count(last_name) desc  










