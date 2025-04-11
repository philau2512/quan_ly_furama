package com.example.khu_nghi_duong_furama.model;

public class Employee {
    private int employeeId;
    private String employeeName;
    private String employeeBirthday;
    private String employeeIdCard;
    private double employeeSalary;
    private String employeePhone;
    private String employeeEmail;
    private String employeeAddress;

    private Position position;
    private EducationDegree educationDegree;
    private Division division;
    private String username;

    public Employee() {
    }

    public Employee(int employeeId, String employeeName, String employeeBirthday, String employeeIdCard, double employeeSalary, String employeePhone, String employeeEmail, String employeeAddress, Position position, EducationDegree educationDegree, Division division, String username) {
        this.employeeId = employeeId;
        this.employeeName = employeeName;
        this.employeeBirthday = employeeBirthday;
        this.employeeIdCard = employeeIdCard;
        this.employeeSalary = employeeSalary;
        this.employeePhone = employeePhone;
        this.employeeEmail = employeeEmail;
        this.employeeAddress = employeeAddress;
        this.position = position;
        this.educationDegree = educationDegree;
        this.division = division;
        this.username = username;
    }

    public int getEmployeeId() {
        return employeeId;
    }

    public String getEmployeeName() {
        return employeeName;
    }

    public String getEmployeeBirthday() {
        return employeeBirthday;
    }

    public String getEmployeeIdCard() {
        return employeeIdCard;
    }

    public double getEmployeeSalary() {
        return employeeSalary;
    }

    public String getEmployeePhone() {
        return employeePhone;
    }

    public String getEmployeeEmail() {
        return employeeEmail;
    }

    public String getEmployeeAddress() {
        return employeeAddress;
    }

    public Position getPosition() {
        return position;
    }

    public EducationDegree getEducationDegree() {
        return educationDegree;
    }

    public Division getDivision() {
        return division;
    }

    public String getUsername() {
        return username;
    }
}
