package com.example.khu_nghi_duong_furama.repository;

import com.example.khu_nghi_duong_furama.model.Division;
import com.example.khu_nghi_duong_furama.model.EducationDegree;
import com.example.khu_nghi_duong_furama.model.Employee;
import com.example.khu_nghi_duong_furama.model.Position;
import com.example.khu_nghi_duong_furama.service.IUserService;
import com.example.khu_nghi_duong_furama.service.UserService;
import com.example.khu_nghi_duong_furama.util.BaseRepository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EmployeeRepository implements IEmployeeRepository {
    private IUserService userService = new UserService();

    @Override
    public List<Employee> getAllEmployee() {
        List<Employee> employeeList = new ArrayList<>();

        String sql =
                "SELECT * FROM employee e " +
                        "JOIN position p ON e.position_id = p.position_id " +
                        "JOIN education_degree ed ON e.education_degree_id = ed.education_degree_id " +
                        "JOIN division d ON e.division_id = d.division_id " +
                        "JOIN user u ON e.username = u.username order by e.employee_id";

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
        Connection connection = BaseRepository.getConnectDB();
        String sql = "SELECT * FROM employee e " +
                "JOIN position p ON e.position_id = p.position_id " +
                "JOIN education_degree ed ON e.education_degree_id = ed.education_degree_id " +
                "JOIN division d ON e.division_id = d.division_id " +
                "JOIN user u ON e.username = u.username where e.employee_id = ?";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, employeeId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
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
                return employee;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public boolean addEmployee(Employee employee, String password, int roleId) {
        Connection connection = BaseRepository.getConnectDB();
        String addEmployeeSql = "INSERT INTO employee (employee_name, employee_birthday, employee_id_card, employee_salary, employee_phone, employee_email, employee_address, position_id, education_degree_id, division_id, username) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            connection.setAutoCommit(false);
            userService.addNewUser(employee.getUsername(), password, roleId);
            PreparedStatement preparedStatement = connection.prepareStatement(addEmployeeSql);
            preparedStatement.setString(1, employee.getEmployeeName());
            preparedStatement.setString(2, employee.getEmployeeBirthday());
            preparedStatement.setString(3, employee.getEmployeeIdCard());
            preparedStatement.setDouble(4, employee.getEmployeeSalary());
            preparedStatement.setString(5, employee.getEmployeePhone());
            preparedStatement.setString(6, employee.getEmployeeEmail());
            preparedStatement.setString(7, employee.getEmployeeAddress());
            preparedStatement.setInt(8, employee.getPosition().getPositionId());
            preparedStatement.setInt(9, employee.getEducationDegree().getEducationDegreeId());
            preparedStatement.setInt(10, employee.getDivision().getDivisionId());
            preparedStatement.setString(11, employee.getUsername());
            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected == 0) {
                connection.rollback();
                return false;
            }
            connection.commit();
            return true;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean updateEmployee(Employee employee) {
        Connection connection = BaseRepository.getConnectDB();
        String sql = "update employee set employee_name = ?, employee_birthday = ?, employee_salary = ?, employee_phone = ?, employee_email = ?, employee_address = ?, position_id = ?, education_degree_id = ?, division_id = ? where employee_id = ?";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, employee.getEmployeeName());
            preparedStatement.setString(2, employee.getEmployeeBirthday());
            preparedStatement.setDouble(3, employee.getEmployeeSalary());
            preparedStatement.setString(4, employee.getEmployeePhone());
            preparedStatement.setString(5, employee.getEmployeeEmail());
            preparedStatement.setString(6, employee.getEmployeeAddress());
            preparedStatement.setInt(7, employee.getPosition().getPositionId());
            preparedStatement.setInt(8, employee.getEducationDegree().getEducationDegreeId());
            preparedStatement.setInt(9, employee.getDivision().getDivisionId());
            preparedStatement.setInt(10, employee.getEmployeeId());
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected == 1;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean deleteEmployee(int employeeId) {
        Connection connection = BaseRepository.getConnectDB();
        String deleteContractDetails = "DELETE FROM contract_detail WHERE contract_id IN (SELECT contract_id FROM contract WHERE employee_id = ?)";
        String deleteContract = "DELETE FROM contract WHERE employee_id = ?";

        String selectUserSql = "SELECT username FROM employee WHERE employee_id = ?";

        String deleteEmployeeSql = "DELETE FROM employee WHERE employee_id = ?";
        String deleteUserSql = "DELETE FROM user WHERE username = ?";
        String deleteUserRoleSql = "DELETE FROM user_role WHERE username = ?";
        try {
            connection.setAutoCommit(false);
            String username = null;

            PreparedStatement selectUserStmt = connection.prepareStatement(selectUserSql);
            selectUserStmt.setInt(1, employeeId);
            ResultSet resultSet = selectUserStmt.executeQuery();
            if (resultSet.next()) {
                username = resultSet.getString("username");
            }

            if (username == null) {
                throw new SQLException("Không tìm thấy nhân viên với ID " + employeeId);
            }

            // -- Xóa các bản ghi liên quan trong bảng contract_detail
            PreparedStatement deleteContractDetailsStmt = connection.prepareStatement(deleteContractDetails);
            deleteContractDetailsStmt.setInt(1, employeeId);
            deleteContractDetailsStmt.executeUpdate();

            // -- Xóa các hợp đồng trong bảng contract
            PreparedStatement deleteContractSmt = connection.prepareStatement(deleteContract);
            deleteContractSmt.setInt(1, employeeId);
            deleteContractSmt.executeUpdate();

            // -- Xóa bản ghi trong bảng employee
            PreparedStatement deleteEmployeeStmt = connection.prepareStatement(deleteEmployeeSql);
            deleteEmployeeStmt.setInt(1, employeeId);
            deleteEmployeeStmt.executeUpdate();

            // -- Xóa các bản ghi trong bảng user_role
            PreparedStatement deleteUserRoleStmt = connection.prepareStatement(deleteUserRoleSql);
            deleteUserRoleStmt.setString(1, username);
            deleteUserRoleStmt.executeUpdate();

            // -- Cuối cùng, xóa bản ghi trong bảng user
            PreparedStatement deleteUserStmt = connection.prepareStatement(deleteUserSql);
            deleteUserStmt.setString(1, username);
            deleteUserStmt.executeUpdate();

            connection.commit();
            return true;
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                throw new RuntimeException("Lỗi khi rollback: " + ex.getMessage(), ex);
            }
            System.out.println("Lỗi khi xóa nhân viên trong Repo: " + e.getMessage());
            throw new RuntimeException(e);
        }
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
