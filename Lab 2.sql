//1
select concat(concat(first_name, ' '),last_name)||' castiga '||salary||' lunar dar doreste '||salary*3 as "Salariu ideal" from employees

//2 prenume=first name
select initcap(first_name)||' '||upper(last_name) as "Nume complet", length(last_name) "Lungime nume" from employees
where last_name like('J%') or last_name like('M%') or last_name like('__a%')
order by length(last_name) desc;

select initcap(first_name)||' '||upper(last_name) as "Nume complet", length(last_name) "Lungime nume" from employees
where substr(last_name, 1, 1)='J' or substr(last_name, 1, 1)='M' or substr(last_name, 3, 1)='a' 
order by length(last_name) desc;

//3 ??
select first_name, job_id, last_name, department_id from employees
where  lower(first_name)=lower('Steven');

select last_name, job_id, department_id, first_name from employees
where initcap(trim(both ' ' from first_name)) like 'Steven'

//4
select last_name as "Nume", job_id as "Cod", first_name as "Prenume", length(last_name) as "Lungime nume", instr(lower(last_name), 'a') as "Pozitia lui a" from employees
where substr(lower(last_name), -1)='e'

//5__este nevoie de rotunjire deoarece nu este calculat doar data curenta, ci si minutele si secundele
select first_name||' '||last_name, hire_date from employees
where mod(round(sysdate-hire_date), 7)=0

//6
select job_id, last_name, salary, to_char(salary+(15/100)*salary, '999999.99') as "Salariu nou", round((salary+(15/100)*salary)/100, 2) as "Numar sute" from employees
where mod(salary, 1000)!=0

//7 ??RPAD

select first_name as "Nume angajat", hire_date as "Data angajarii" from employees
where commission_pct is not null

//8
select to_char(sysdate+30, 'DD-MONTH-YYYY  HH24:MI:SS') from dual

//9
select (to_date('31.12', 'dd.mm'))-trunc(sysdate) from dual

//10a
select to_char(sysdate+(12/24), 'DD-MON-YYYY-HH24:MI:SS')  as "Data curenta "from dual

//10b
select to_char(sysdate+(5/24/60), 'DD-MON-YYYY-HH24:MI:SS') from dual

//11??
select first_name||' '||last_name, hire_date, 

//12
select first_name, round(sysdate-hire_date) as "Luni lucrate" from employees

select * from job_history


//16
select first_name||' '||last_name as "Nume",
    job_id as "ID job",
    salary as "Salariu",
    case job_id
    when  'IT_PROG' then salary+20/100*salary 
    when 'SA_REP' then salary+25/100*salary
    when 'SA_MAN' then salary+35/100*salary
    else salary
    end
    as "Marire"
from employees

//17
select e.first_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id=d.department_id

//18
select distinct j.job_id, j.job_title
from employees e left join jobs j 
on j.job_id=e.job_id
where e.department_id=30

//19
select e.first_name,d.department_name, l.city
from employees e, departments d, locations l
where e.commission_pct is not null

select e.first_name, d.department_name, l.city
from employees e left join departments d 
on e.department_id=d.department_id
left join locations l
on l.location_id=d.location_id
where e.commission_pct is not null

select e.first_name, e.last_name, d.department_name, l.city
from employees e, deparmtments d, locatins l
where e.department_id=d.departmemnt_id and d.locations_id=l.locatinos_id and e.commission_pct is not null


//20
select e.first_name, e.last_name, d.department_name
from employees e, departments d
where e.department_id=d.department_id
and lower(last_name) like ('%a%')

//21
select e.first_name, j.job_title, d.department_name
from employees e, jobs j, departments d, locations l
where e.job_id=j.job_id and e.department_id=d.department_id
and l.city like ('Oxford')

//22
select e.employee_id as "Ang#", e.first_name as "Angajat", m.first_name as "Manager", m.employee_id as "Mgr#"
from employees e, employees m
where e.manager_id=m.employee_id

//23
select e.employee_id as "Ang#", e.first_name as "Angajat", m.first_name as "Mrg#", m.employee_id as "Manager"
from employees e, employees m
where m.employee_id(+)=e.manager_id

select e.employee_id as "Ang#", e.first_name as "Angajat", m.first_name as "Manager", m.employee_id as "Mgr#"
from employees e left join employees m
on e.manager_id=m.employee_id
//24
select  e.first_name, e.department_id,  c.first_name 
from employees e, employees c
where e.department_id=c.department_id and e.employee_id!=c.employee_id
order by e.first_name

select  e.first_name, e.department_id,  
    (select listagg(c.first_name, ',') within group(order by c.first_name) from employees c where e.department_id=c.department_id and e.employee_id!=c.employee_id) as "DA"
from employees e;


//21 22 23 24 tema

//25
select e.first_name, e.job_id, j.job_title, d.department_name, e.salary
from employees e left join departments d
on e.department_id=d.department_id
left join jobs j
on j.job_id=e.job_id

//26
select first_name, hire_date from employees
where hire_date>(select hire_date from employees where last_name like ('Gates'))

//27
select e1.first_name as "Angajat", e1.hire_date as "Data_ang", e2.first_name as "Manager", e2.hire_date as "Data_mrg"
from employees e1, employees e2
where e1.manager_id=e2.employee_id and e1.hire_date<e2.hire_date
