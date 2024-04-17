//3
describe employees;

//4
SELECT *FROM employees;
select * from departments;

//5
select employee_id, first_name, job_id, hire_date from employees;

//6
select employee_id as cod, first_name as nume, job_id as "cod job" ,hire_date as "data angajarii" from employees;

//7
select distinct job_id from employees;

//8
select first_name||' '||last_name||' '||job_id as "Angajat si titlu" from employees;

//9
select employee_id||' '||first_name||' '||last_name||' ' ||email||' '||phone_number||' '||hire_date||' '||job_id||' '||salary||' '||commission_pct||' '||manager_id||' '||department_id as "Informatii complete" from employees;

//10
select first_name, salary from employees where salary>2850;

//11
select first_name, department_id from employees where employee_id = 104;

//12
select first_name, salary from employees where salary not between 1500 and 2850;


//13
select first_name, job_id, hire_date 
from employees 
where hire_date between '20-Feb_1987' and '1-May-1989' 
order by hire_date;

//14
select first_name, department_id from employees
where department_id in (10, 30, 50)
order by first_name;

//15
select first_name as "Angajat", salary as "Salariu lunar" from employees
where salary>1500 and department_id in (10, 30, 50);

//16
select sysdate from dual;
select to_char(sysdate, 'DD.MM.YYYY') from dual;

//17
select first_name, hire_date from employees
where hire_date like ('%87');

select first_name, hire_date from employees
where to_char(hire_date, 'yyyy')='1987';

select first_name, hire_date from employees
where extract(year from hire_date)=1987;

//18
select first_name, hire_date from employees
where extract(day from hire_date)=extract(day from sysdate);

select first_name, hire_date from employees
where to_char(hire_date, 'dd')=to_char(sysdate, 'dd');

//19
select first_name, job_id from employees
where manager_id is NULL;

//20
select first_name, commission_pct from employees
where commission_pct is not null
order by salary, commission_pct;

//21
select first_name, salary, commission_pct from employees
order by salary, commission_pct;
//valorile null sunt plasate la inceput

//22
select first_name from employees
where first_name like('__a%');

select first_name from employees
where instr(first_name, 'a')=3;

//23
select first_name from employees
where first_name like ('%l%l%') and( department_id=30 or manager_id=102);
//or first_name like('L%l%)

select first_name from employees
where length(first_name)-length(replace(lower(first_name), 'l'))=2;

//24
select first_name||' '||last_name, job_id, salary from employees
where job_id like('%CLERK%') or job_id like('%REP%') and salary not in(1000, 2000, 3000);

//25 
select d.department_name , e.manager_id  from departments d, employees e
where e.manager_id is null;