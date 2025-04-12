package com.example.khu_nghi_duong_furama.repository;

import com.example.khu_nghi_duong_furama.model.Division;
import com.example.khu_nghi_duong_furama.model.EducationDegree;
import com.example.khu_nghi_duong_furama.model.Employee;
import com.example.khu_nghi_duong_furama.model.Position;

import java.util.List;

public interface IEmployeeRepository {
    List<Employee> getAllEmployee();

    Employee getEmployeeById(int employeeId);

    boolean addEmployee(Employee employee);

    boolean updateEmployee(Employee employee);

    boolean deleteEmployee(int employeeId);

    List<Position> getAllPosition();

    List<EducationDegree> getAllEducationDegree();

    List<Division> getAllDivision();
}
