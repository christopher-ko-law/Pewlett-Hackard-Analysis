-- DELIVERABLE 1

-- A query is written and executed to create a Retirement Titles 
-- table for employees who are born between January 1, 1952 and 
-- December 31, 1955.
SELECT e.emp_no, 
	e.first_name, 
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no ASC;

-- A query is written and executed to create a Unique Titles 
-- table that contains the employee number, first and last name, 
-- and most recent title. 
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no ASC, to_date DESC;

-- A query is written and executed to create a 
-- Retiring Titles table that contains the number of titles 
-- filled by employees who are retiring
SELECT COUNT(emp_no), 
	title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

-- DELIVERABLE 2

-- A query is written and executed to create a Mentorship Eligibility 
-- table for current employees who were born between January 1, 1965 
-- and December 31, 1965.
SELECT DISTINCT ON (e.emp_no) e.emp_no, 
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
	ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
	ON (e.emp_no = t.emp_no)
WHERE (de.to_date = ('9999-01-01') 
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'))
ORDER BY e.emp_no ASC, t.to_date DESC;