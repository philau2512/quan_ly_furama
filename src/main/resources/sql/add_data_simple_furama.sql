use furama_resort;

-- Thêm dữ liệu vào bảng customer_type (Loại khách hàng: Diamond, Platinium, Gold, Silver, Member)
INSERT INTO customer_type (customer_type_name) VALUES 
('Diamond'),
('Platinium'),
('Gold'),
('Silver'),
('Member');

-- Thêm dữ liệu vào bảng customer (Khách hàng)
-- Mã khách hàng KH-XXXX sẽ được định dạng trong JSP/Servlet (KH- + customer_id)
INSERT INTO customer (customer_type_id, customer_name, customer_birthday, customer_gender, customer_id_card, customer_phone, customer_email, customer_address) VALUES 
(1, 'Nguyen Van An', '1990-05-15', 1, '123456789', '0901234567', 'an.nguyen@gmail.com', 'Da Nang'),
(2, 'Tran Thi Bich', '1985-08-22', 0, '987654321', '0912345678', 'bich.tran@gmail.com', 'Ha Noi'),
(3, 'Le Van Cuong', '1995-03-10', 1, '456789123', '(84)+901234567', 'cuong.le@gmail.com', 'Ho Chi Minh'),
(4, 'Pham Thi Dung', '1992-11-30', 0, '321654987123', '0908765432', 'dung.pham@gmail.com', 'Hue'),
(5, 'Hoang Van Nam', '1988-07-25', 1, '789123456', '(84)+912345678', 'nam.hoang@gmail.com', 'Quang Nam');

-- Thêm dữ liệu vào bảng position (Chức vụ: Lễ tân, phục vụ, chuyên viên, giám sát, quản lý, giám đốc)
INSERT INTO position (position_name) VALUES 
('Lễ tân'),
('Phục vụ'),
('Chuyên viên'),
('Giám sát'),
('Quản lý'),
('Giám đốc');

-- Thêm dữ liệu vào bảng education_degree (Trình độ: Trung cấp, Cao đẳng, Đại học, Sau đại học)
INSERT INTO education_degree (education_degree_name) VALUES 
('Trung cấp'),
('Cao đẳng'),
('Đại học'),
('Sau đại học');

-- Thêm dữ liệu vào bảng division (Bộ phận: Sale – Marketing, Hành Chính, Phục vụ, Quản lý)
INSERT INTO division (division_name) VALUES 
('Sale – Marketing'),
('Hành Chính'),
('Phục vụ'),
('Quản lý');

-- Thêm dữ liệu vào bảng user (Người dùng)
INSERT INTO user (username, password) VALUES 
('admin', 'admin123'),
('nhanvien0', 'nhanvien0'),
('nhanvien1', 'pass123'),
('nhanvien2', 'pass456'),
('nhanvien3', 'pass789'),
('nhanvien4', 'pass101');

-- Thêm dữ liệu vào bảng role (Vai trò: Admin, Employee, Customer)
INSERT INTO role (role_name) VALUES 
('Admin'),
('Employee'),
('Customer');

-- Thêm dữ liệu vào bảng user_role (Phân vai trò cho người dùng)
INSERT INTO user_role (role_id, username) VALUES 
(1, 'admin'),
(2, 'nhanvien1'),
(2, 'nhanvien2'),
(3, 'nhanvien3'),
(3, 'nhanvien4');

-- Thêm dữ liệu vào bảng employee (Nhân viên)
-- Số điện thoại: 090xxxxxxx hoặc 091xxxxxxx, số CMND: 9 hoặc 12 chữ số, lương: số dương
INSERT INTO employee (employee_name, employee_birthday, employee_id_card, employee_salary, employee_phone, employee_email, employee_address, position_id, education_degree_id, division_id, username) VALUES 
('Nguyen Thi Hoa', '1985-02-14', '123123123', 10000000, '0901111111', 'hoa.nguyen@furama.com', 'Da Nang', 1, 3, 1, 'nhanvien0'),
('Tran Van Bao', '1990-06-20', '456456456', 8000000, '0912222222', 'bao.tran@furama.com', 'Quang Nam', 2, 2, 2, 'nhanvien1'),
('Le Thi Cam', '1992-09-10', '789789789', 12000000, '(84)+903333333', 'cam.le@furama.com', 'Hue', 3, 4, 3, 'nhanvien2'),
('Pham Van Duc', '1988-04-05', '101010101123', 15000000, '0904444444', 'duc.pham@furama.com', 'Da Nang', 4, 4, 4, 'nhanvien3'),
('Hoang Thi E', '1995-12-25', '202020202', 7000000, '0915555555', 'e.hoang@furama.com', 'Ho Chi Minh', 5, 1, 3, 'nhanvien4');

-- Thêm dữ liệu vào bảng rent_type (Loại thuê: năm, tháng, ngày, giờ)
INSERT INTO rent_type (rent_type_name, rent_type_cost) VALUES 
('Year', 500000000),
('Month', 40000000),
('Day', 2000000),
('Hour', 500000);

-- Thêm dữ liệu vào bảng service_type (Loại dịch vụ: Villa, House, Room)
INSERT INTO service_type (service_type_name) VALUES 
('Villa'),
('House'),
('Room');

-- Thêm dữ liệu vào bảng service (Dịch vụ)
-- Mã dịch vụ DV-XXXX sẽ được định dạng trong JSP/Servlet (DV- + service_id)
INSERT INTO service (service_name, service_area, service_cost, service_max_people, rent_type_id, service_type_id, standard_room, description_other_convenience, pool_area, number_of_floors, free_service_included) VALUES 
('Villa A1', 150, 10000000, 6, 3, 1, 'VIP', 'Free WiFi, Breakfast', 50, 2, NULL),
('Villa B2', 200, 15000000, 8, 3, 1, 'Luxury', 'Free WiFi, Spa', 70, 3, NULL),
('House C1', 100, 5000000, 4, 3, 2, 'Standard', 'Free WiFi', NULL, 1, NULL),
('Room D1', 30, 1500000, 2, 4, 3, 'Normal', 'Free WiFi', NULL, NULL, "Nhay mua"),
('Room E2', 40, 2000000, 3, 4, 3, 'Normal', 'Free WiFi', NULL, NULL, "Tam bien");

-- Thêm dữ liệu vào bảng attach_service (Dịch vụ đi kèm: massage, karaoke, thức ăn, nước uống, thuê xe)
INSERT INTO attach_service (attach_service_name, attach_service_cost, attach_service_unit, attach_service_status) VALUES 
('Massage', 500000, 1, 'Available'),
('Karaoke', 300000, 1, 'Available'),
('Thức ăn', 200000, 1, 'Available'),
('Nước uống', 100000, 1, 'Available'),
('Thuê xe', 1000000, 1, 'Available');

-- Thêm dữ liệu vào bảng contract (Hợp đồng)
-- Tiền đặt cọc, tổng tiền: số dương, ngày hợp lệ
INSERT INTO contract (contract_start_date, contract_end_date, contract_deposit, contract_total_money, employee_id, customer_id, service_id) VALUES 
('2025-04-01 08:00:00', '2025-04-03 12:00:00', 2000000, 10000000, 1, 1, 1),
('2025-04-02 09:00:00', '2025-04-05 12:00:00', 3000000, 15000000, 2, 2, 2),
('2025-04-03 10:00:00', '2025-04-04 12:00:00', 1000000, 5000000, 3, 3, 3),
('2025-04-04 11:00:00', '2025-04-05 12:00:00', 500000, 1500000, 4, 4, 4),
('2025-04-05 12:00:00', '2025-04-06 12:00:00', 500000, 2000000, 5, 5, 5);

-- Thêm dữ liệu vào bảng contract_detail (Chi tiết hợp đồng)
-- Số lượng: số nguyên dương
INSERT INTO contract_detail (contract_id, attach_service_id, quantity) VALUES 
(1, 1, 2),  -- Hợp đồng 1: 2 lần Massage
(1, 2, 1),  -- Hợp đồng 1: 1 lần Karaoke
(2, 3, 3),  -- Hợp đồng 2: 3 lần Thức ăn
(3, 4, 2),  -- Hợp đồng 3: 2 lần Nước uống
(4, 5, 1);  -- Hợp đồng 4: 1 lần Thuê xe