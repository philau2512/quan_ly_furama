use furama_resort;

-- GET ALL CUSTOMER --
select * from customer c join customer_type ct on c.customer_type_id = ct.customer_type_id order by c.customer_id;

-- GET ALL EMPLOYEE --
select * from employee e
join position p on e.position_id = p.position_id
join education_degree ed on e.education_degree_id = ed.education_degree_id
join division d on e.division_id = d.division_id
join user u on e.username = u.username;

-- GET EMPLOYEE BY ID --
SELECT * FROM employee e 
JOIN position p ON e.position_id = p.position_id
JOIN education_degree ed ON e.education_degree_id = ed.education_degree_id 
JOIN division d ON e.division_id = d.division_id 
JOIN user u ON e.username = u.username where e.employee_id = ?;

-- DELETE EMPLOYEE BY ID --
	-- Xóa các bản ghi liên quan trong bảng contract_detail
DELETE FROM contract_detail WHERE contract_id IN (SELECT contract_id FROM contract WHERE employee_id = 5);
	-- Xóa các hợp đồng trong bảng contract
DELETE FROM contract WHERE employee_id = 5;
	-- Xóa bản ghi trong bảng employee
DELETE FROM employee WHERE employee_id = 5;
	-- Xoa user_role
DELETE FROM user_role WHERE username = ?;
	-- Xóa tài khoản người dùng trong bảng user
DELETE FROM user WHERE username = (SELECT username FROM employee WHERE employee_id = 5);

-- UPDATE EMPLOYEE -- 
SELECT * FROM furama_resort.employee;
update employee set employee_name = ?, employee_birthday = ?, employee_salary = ?, employee_phone = ?, employee_email = ?, employee_address = ?, position_id = ?, education_degree_id = ?, division_id = ? where employee_id = ?;

-- getAllServiceType --
select * from service_type;

-- getAllRentType -- 
select * from rent_type;

-- getAllService -- 
SELECT s.*, st.service_type_id, st.service_type_name, rt.rent_type_id, rt.rent_type_name, rt.rent_type_cost 
FROM service s 
JOIN service_type st ON s.service_type_id = st.service_type_id 
JOIN rent_type rt ON s.rent_type_id = rt.rent_type_id;

-- getAllContract --
SELECT c.*, e.employee_id, e.employee_name, cu.customer_id, cu.customer_name, s.service_name, st.*
FROM contract c 
JOIN employee e ON c.employee_id = e.employee_id
JOIN customer cu ON c.customer_id = cu.customer_id 
JOIN service s ON c.service_id = s.service_id
JOIN service_type st ON s.service_type_id = st.service_type_id;

-- lay danh sach khach hang dang dung dich vu --
SELECT cu.*, c.*, s.*, st.*
FROM customer cu
JOIN contract c ON cu.customer_id = c.customer_id 
JOIN service s ON c.service_id = s.service_id 
JOIN service_type st ON s.service_type_id = st.service_type_id;

-- getAttachServicesByContractId --
SELECT a.* FROM contract_detail cd 
JOIN attach_service a ON cd.attach_service_id = a.attach_service_id 
WHERE cd.contract_id = 1;

-- GetServiceById -- 
SELECT s.*, st.service_type_name, rt.rent_type_name, rt.rent_type_cost 
FROM service s 
JOIN service_type st ON s.service_type_id = st.service_type_id 
JOIN rent_type rt ON s.rent_type_id = rt.rent_type_id 
WHERE s.service_id = 1;

