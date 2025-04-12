package com.example.khu_nghi_duong_furama.repository;

import com.example.khu_nghi_duong_furama.model.Division;
import com.example.khu_nghi_duong_furama.model.EducationDegree;
import com.example.khu_nghi_duong_furama.model.Employee;
import com.example.khu_nghi_duong_furama.model.Position;
import com.example.khu_nghi_duong_furama.util.BaseRepository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EmployeeRepository implements IEmployeeRepository {
    @Override
    public List<Employee> getAllEmployee() {
        List<Employee> employeeList = new ArrayList<>();

        String sql =
                "SELECT * FROM employee e " +
                        "JOIN position p ON e.position_id = p.position_id " +
                        "JOIN education_degree ed ON e.education_degree_id = ed.education_degree_id " +
                        "JOIN division d ON e.division_id = d.division_id " +
                        "JOIN user u ON e.username = u.username";

        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int employeeId = resultSet.getInt("employee_id");
                String employeeName = resultSet.getString("employee_name");
                String employeeBirthday = resultSet.getString("employee_birthday");
                String employeeIdCard = resultSet.getString("employee_id_card");
                double employeeSalary = resultSet.getDouble("employee_salary");
                String employeePhone = resultSet.getString("employee_phone");
                String employeeEMail = resultSet.getString("employee_email");
                String employeeAddress = resultSet.getString("employee_address");

                Position position = new Position();
                position.setPositionId(resultSet.getInt("position_id"));
                position.setPositionName(resultSet.getString("position_name"));

                EducationDegree educationDegree = new EducationDegree();
                educationDegree.setEducationDegreeId(resultSet.getInt("education_degree_id"));
                educationDegree.setEducationDegreeName(resultSet.getString("education_degree_name"));

                Division division = new Division();
                division.setDivisionId(resultSet.getInt("division_id"));
                division.setDivisionName(resultSet.getString("division_name"));

                String username = resultSet.getString("username");

                Employee employee = new Employee(employeeId, employeeName, employeeBirthday, employeeIdCard, employeeSalary, employeePhone, employeeEMail, employeeAddress, position, educationDegree, division, username);
                employeeList.add(employee);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return employeeList;
    }

    @Override
    public Employee getEmployeeById(int employeeId) {
        return null;
    }

    @Override
    public boolean addEmployee(Employee employee) {
        return false;
    }

    @Override
    public boolean updateEmployee(Employee employee) {
        return false;
    }

    @Override
    public boolean deleteEmployee(int employeeId) {
        return false;
    }

    @Override
    public List<Position> getAllPosition() {
        List<Position> positionList = new ArrayList<>();
        String sql = "select * from position";
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("position_id");
                String name = resultSet.getString("position_name");
                positionList.add(new Position(id, name));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return positionList;
    }

    @Override
    public List<EducationDegree> getAllEducationDegree() {
        List<EducationDegree> educationDegreeList = new ArrayList<>();
        String sql = "select * from education_degree";
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("education_degree_id");
                String name = resultSet.getString("education_degree_name");
                educationDegreeList.add(new EducationDegree(id, name));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return educationDegreeList;
    }

    @Override
    public List<Division> getAllDivision() {
        List<Division> divisionList = new ArrayList<>();
        String sql = "select * from division";
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("division_id");
                String name = resultSet.getString("division_name");
                divisionList.add(new Division(id, name));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return divisionList;
    }
}
