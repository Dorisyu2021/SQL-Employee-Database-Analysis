--create order titles,employee,departments,dept_manager,dept_emp,salaries
--do not drop table if exists, it will wipe off imported data

create table titles(
	title_id varchar primary key,
	title varchar
);
select * from titles;

create table employees(
	emp_no int primary key,
	emp_title_id varchar,
	birth_date date,
	first_name varchar,
	last_name varchar,
	sex varchar,
	hire_date date,
	foreign key (emp_title_id)references titles(title_id)
);
select * from employees;

create table departments(
	dept_no varchar primary key,
	dept_name varchar
);
select * from departments;

create table dept_manager(
	dept_no varchar,
	emp_no int,
	foreign key(dept_no)references departments(dept_no),
	foreign key(emp_no)references employees(emp_no),
	primary key(dept_no,emp_no)
);
select * from dept_manager;

create table dept_emp(
	emp_no int,
	dept_no varchar,
	foreign key(dept_no)references departments(dept_no),
	foreign key(emp_no)references employees(emp_no),
	primary key(emp_no,dept_no)
);
select * from dept_emp;

create table salaries(
	emp_no int primary key,
	salary int,
	foreign key(emp_no)references employees(emp_no)
);
select * from salaries;

--List the following details of each employee: employee number, last name, first name, sex, and salary.

select * from employees;
select employees.emp_no,first_name,last_name,sex,salary
from employees
inner join salaries
on employees.emp_no=salaries.emp_no


--List first name, last name, and hire date for employees who were hired in 1986.

select * from employees;
select first_name, last_name,hire_date from employees 
where hire_date between '1986-01-01' and '1986-12-31';


--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
select * from dept_manager;
select * from departments;
select * from employees;

select departments.dept_no,dept_name,employees.emp_no,first_name,last_name
from dept_manager
inner join departments
on dept_manager.dept_no=departments.dept_no
inner join employees
on dept_manager.emp_no=employees.emp_no

--List the department of each employee with the following information: employee number, last name, first name, and department name.
select * from employees;
select employees.emp_no,first_name,last_name,departments.dept_name
from employees
inner join dept_manager
on employees.emp_no=dept_manager.emp_no
inner join departments
on departments.dept_no=dept_manager.dept_no


--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
select * from employees;
select first_name, last_name,sex from employees 
where first_name='Hercules'and last_name like 'B%';

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
select * from departments;
select * from dept_emp;

select employees.emp_no,first_name,last_name,dept_name 
from employees
inner join dept_emp
on employees.emp_no=dept_emp.emp_no
inner join departments
on dept_emp.dept_no=departments.dept_no
where departments.dept_no in ('d007');

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
select employees.emp_no,first_name,last_name,dept_name
from employees
inner join dept_emp
on employees.emp_no=dept_emp.emp_no
inner join departments
on departments.dept_no=dept_emp.dept_no
where departments.dept_name in ('Sales','Development');


--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
select last_name,count(last_name) as "Last_name_count"
from employees
group by last_name
order by "Last_name_count" desc;


