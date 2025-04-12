select * from customer c join customer_type ct on c.customer_type_id = ct.customer_type_id order by c.customer_id;

SELECT c.*, ct.customer_type_name FROM customer c JOIN customer_type ct ON c.customer_type_id = ct.customer_type_id WHERE c.customer_id = 1;

-- get all employee --
select * from employee e
join position p on e.position_id = p.position_id
join education_degree ed on e.education_degree_id = ed.education_degree_id
join division d on e.division_id = d.division_id
join user u on e.username = u.username;