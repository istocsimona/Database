--1
select first_name, to_char(hire_date, 'MON'), to_char(hire_date, 'YYYY')
from employees
where department_id=(select department_id from employees where last_name like ('Gates') )
and trim(last_name)!='Gates'
and lower(last_name) like('%a%')

select e.first_name, to_char(e.hire_date, 'MON'), to_char(e.hire_date, 'YYYY')
from employees e, employees g
where e.department_id=g.department_id
and g.last_name like ('Gates')
and lower(e.last_name) like('%a%')
and trim(e.last_name)!='Gates'


--2
select employee_id as "Id", first_name||' '||last_name as "Name", ex1.department_id,  department_name
from employees ex1 join departments on ex1.department_id=departments.department_id
where ex1.department_id in (select department_id from employees ex2 where lower(last_name) like ('%t%') and ex1.employee_id!=ex2.employee_id  )


select distinct e.employee_id, e.first_name||' '||e.last_name
from employees e, employees c
where e.department_id=c.department_id
and e.employee_id!=c.employee_id
and lower(c.last_name) like ('%t%') 
order by e.first_name||' '||e.last_name


--3 
select employees.first_name||' '||employees.last_name as "Nume",
    employees.salary as "Salariu",
    (select job_title from jobs where employees.job_id=jobs.job_id) as "Job",
    (select city from locations where locations.location_id=
        (select departments.location_id from departments where departments.department_id=employees.employee_id)) as "Oras"
    from employees
    where employees.manager_id in (select employees.employee_id from employees where employees.last_name like ('King'))
    and employees.employee_id not in (select employees.employee_id from employees where employees.last_name like ('King'))


select distinct e.last_name, e.salary, j.job_title, l.city, c.country_name
from employees e, jobs j, locations l, countries c, departments d, employees k
where e.manager_id=k.employee_id 
and e.job_id=j.job_id 
and d.location_id=l.location_id 
and l.country_id=c.country_id 
and d.department_id=e.department_id
and k.last_name like ('King')



--4   
select e.first_name||' '||e.last_name, d.department_id, d.department_name, to_char(e.salary, '$99,999.00'), j.job_title
from departments d, employees e, jobs j
where d.department_id=e.department_id
and e.job_id=j.job_id
and lower(d.department_name) like ('%ti%')
order by d.department_name, e.first_name

select e.first_name||' '||e.last_name, e.department_id, to_char(e.salary, '$99,999.00'),
    (select d.department_name from departments d where d.department_id=e.department_id),
    (select j.job_title from jobs j where j.job_id=e.job_id)
from employees e
where e.department_id in (select department_id from departments d where lower(d.department_name) like ('%ti%'))

--5
select e.first_name||' '||e.last_name, e.department_id, d.department_name, l.city, j.job_title
from employees e, departments d, locations l, jobs j
where e.department_id=d.department_id
and e.job_id=j.job_id
and d.location_id=l.location_id
and l.city like ('Oxford')

?
select d.department_name,
    (select e.first_name||' '||e.last_name from employees e where e.department_id=d.department_id),
    (select l.city from locations l where d.location_id=l.location_id),
    (select j.job_title from jobs j where j.job_id=(select e.job_id from employees e where e.department_id=d.department_id))
from departments d


--6
select distinct e.employee_id, e.first_name||' '||e.last_name, e.salary
from employees e, employees c
where e.department_id=c.department_id
and e.employee_id!=c.employee_id
and lower(c.last_name) like ('%t%') 
and e.salary>(select avg(salary) from employees where e.job_id=job_id)


select  employee_id, first_name||' '||last_name, salary
from employees e1 
where department_id in (select department_id from employees e2 where lower(last_name) like ('%t%') and e1.employee_id!=e2.employee_id)
and e1.salary>(select avg(salary) from employees e3 where e3.job_id=e1.job_id)

--7
select e.first_name||' '||e.last_name, d.department_name
from departments d right outer join employees e
on e.department_id=d.department_id

select first_name||' '||last_name,
    (select department_name from departments where departments.department_id=employees.department_id)
from employees


--8
select  d.department_name as "Departament", e.first_name||' '||e.last_name as "Nume"
from departments d left outer join employees e
on d.department_id=e.department_id


select department_name, 
    (select  listagg(first_name||' '||last_name, ',  ') within group (order by employees.employee_id)
    from employees
    where employees.department_id=departments.department_id) as "Nume"
from departments



--9?

--10
select department_id
from departments
where lower(department_name) like ('%re%') 
UNION 
select department_id
from employees
where  job_id like 'SA_REP'


select  distinct d.department_id
from departments d, employees e
where lower(department_name) like ('%re%')
or e.job_id like ('SA_REP')
and e.department_id=d.department_id


--12
select department_name, department_id 
from departments
where not exists (select employee_id from employees where employees.department_id=departments.department_id)

//minus
select department_name, department_id
from departments
MINUS
select d.department_name, e.department_id 
from departments d join employees e
on d.department_id=e.department_id

//not in
select department_name, department_id
from departments
where department_id not in(select department_id from employees where department_id is not null)

--13
select department_id
from departments
where lower(department_name) like '%re%'
INTERSECT
select department_id
from employees
where job_id like 'HR_REP'

--14
select distinct e1.employee_id as "Id angajat", e1.job_id as "Job id", e1.first_name||' '||e1.last_name as "Nume"
from employees e1
where e1.salary>3000
or salary=(select (min(e2.salary)+max(e2.salary))/2 
    from employees e2 
    where e2.job_id=e1.job_id)

select employee_id, job_id, first_name||' '||last_name
from employees
where salary>3000
UNION
select e1.employee_id, e1.job_id, e1.first_name||' '||e1.last_name
from employees e1
where e1.salary=(select (min(e2.salary)+max(e2.salary))/2 
    from employees e2 
    where e2.job_id=e1.job_id)
    
--15
select last_name, hire_date
from employees
where hire_date>(select hire_date from employees where lower(last_name) like ('gates'))

--16

select last_name, salary
from employees
where department_id in (select department_id 
                        from employees
                        where lower(last_name) like 'gates')
and lower(last_name) != 'gates'
                        
select last_name, salary
from employees
where department_id in (select department_id from employees where lower(last_name) like 'gates')
and employee_id !=(select employee_id from employees where lower(last_name) like 'gates')

--17
select first_name||' '||last_name as "Nume",
    salary as "Salariu"
from employees
where manager_id=(select employee_id from employees where manager_id is null)

select first_name||' '||last_name as "Nume",
    salary as "Salariu"
from employees
where manager_id=(select employee_id from employees where lower(first_name) like 'steven' and lower(last_name) like 'king')

--18 ?
select e.first_name||' '||e.last_name as "Nume",
    e.department_id as "ID departament",
    e.salary as "Salariu"
from employees e
where exists (select * from employees c
            where c.commission_pct is not null
            and c.department_id=e.department_id
            and c.salary=e.salary
            and c.employee_id!=e.employee_id)

--19
select  employee_id, first_name||' '||last_name, salary
from employees e1 
where department_id in (select department_id from employees e2 where lower(last_name) like ('%t%') and e1.employee_id!=e2.employee_id)
and e1.salary>(select avg(salary) from employees e3 where e3.job_id=e1.job_id)

--20
select first_name||' '||last_name as "Nume", employee_id as "ID angajat", salary as "Salariu"
from employees
where salary>all(select max_salary 
                from jobs 
                where lower(job_title) like '%clerk%')



--21
select e.first_name||' '||e.last_name as "Nume",
    d.department_name as "Nume departament",
    e.salary as "Salary"
from employees e, departments d, employees m
where e.commission_pct is Null
and e.department_id=d.department_id
and e.manager_id=m.employee_id
and m.commission_pct is not null
    
select e.first_name||' '||e.last_name ,
    e.salary ,
    (select department_name from departments where e.department_id=departments.department_id)
from employees e
where e.commission_pct is null
and (select m.commission_pct from employees m where e.manager_id=m.employee_id) is not null


--22
select e.first_name||' '||e.last_name, 
    d.department_name,
    e.salary,
    j.job_title
from employees e, departments d, jobs j, employees oxf_e, departments oxf_d, locations l
where e.department_id=d.department_id
and e.job_id=j.job_id
and e.salary in oxf_e.salary
and e.commission_pct in oxf_e.commission_pct
and e.employee_id!=oxf_e.employee_id
and oxf_e.department_id=oxf_d.department_id
and oxf_d.location_id=l.location_id
and l.city like  'Oxford'

select distinct emp.first_name||' '||emp.last_name, 
    emp.salary,
    (select d.department_name from departments d where d.department_id=emp.department_id),
    (select j.job_title from jobs j where j.job_id=emp.job_id)
from employees emp
where exists (select * from employees e, departments, locations
    where e.department_id=departments.department_id
    and departments.location_id=locations.location_id
    and locations.city like 'Oxford'
    and emp.employee_id!=e.employee_id
    and emp.salary=e.salary
    and emp.commission_pct=e.commission_pct)
    
--23
select first_name||' '||last_name as "Nume", department_id as "ID departament", job_id as "ID job"
from employees
where department_id=(select department_id 
                    from departments
                    where location_id=(select location_id 
                                        from locations 
                                        where lower(city) like 'toronto')
                    )


select e.first_name||' '||e.last_name as "Nume", e.department_id as "ID departament", e.job_id as "ID job"
from employees e, departments d, locations l
where e.department_id=d.department_id
and d.location_id=l.location_id
and lower(city) like 'toronto'