package com.example.khu_nghi_duong_furama.repository;

import com.example.khu_nghi_duong_furama.model.*;
import com.example.khu_nghi_duong_furama.util.BaseRepository;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ServiceRepository implements IServiceRepository {
    @Override
    public List<ServiceType> getAllServiceType() {
        List<ServiceType> serviceTypeList = new ArrayList<>();
        Connection connection = BaseRepository.getConnectDB();
        String sql = "select * from service_type";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("service_type_id");
                String name = resultSet.getString("service_type_name");
                serviceTypeList.add(new ServiceType(id, name));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return serviceTypeList;
    }

    @Override
    public List<RentType> getAllRentType() {
        List<RentType> rentTypeList = new ArrayList<>();
        Connection connection = BaseRepository.getConnectDB();
        String sql = "select * from rent_type";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("rent_type_id");
                String name = resultSet.getString("rent_type_name");
                double cost = resultSet.getDouble("rent_type_cost");
                rentTypeList.add(new RentType(id, name, cost));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return rentTypeList;
    }

    @Override
    public List<Service> getAllService() {
        List<Service> serviceList = new ArrayList<>();
        String sql = "SELECT s.*, st.service_type_id, st.service_type_name, rt.rent_type_id, rt.rent_type_name, rt.rent_type_cost " +
                "FROM service s " +
                "JOIN service_type st ON s.service_type_id = st.service_type_id " +
                "JOIN rent_type rt ON s.rent_type_id = rt.rent_type_id";
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Service service;
                int serviceTypeId = rs.getInt("service_type_id");

                if (serviceTypeId == 1) { // Villa
                    service = new Villa();
                    ((Villa) service).setStandardRoom(rs.getString("standard_room"));
                    ((Villa) service).setDescriptionOtherConvenience(rs.getString("description_other_convenience"));
                    ((Villa) service).setPoolArea(rs.getDouble("pool_area"));
                    ((Villa) service).setNumberOfFloors(rs.getInt("number_of_floors"));
                } else if (serviceTypeId == 2) { // House
                    service = new House();
                    ((House) service).setStandardRoom(rs.getString("standard_room"));
                    ((House) service).setDescriptionOtherConvenience(rs.getString("description_other_convenience"));
                    ((House) service).setNumberOfFloors(rs.getInt("number_of_floors"));
                } else {
                    service = new Room();
                    ((Room) service).setFreeServiceIncluded(rs.getString("free_service_included"));
                }

                service.setServiceId(rs.getInt("service_id"));
                service.setServiceName(rs.getString("service_name"));
                service.setServiceArea(rs.getDouble("service_area"));
                service.setServiceCost(rs.getDouble("service_cost"));
                service.setServiceMaxPeople(rs.getInt("service_max_people"));

                service.setServiceRentType(new RentType(rs.getInt("rent_type_id"), rs.getString("rent_type_name"), rs.getDouble("rent_type_cost")));
                service.setServiceType(new ServiceType(rs.getInt("service_type_id"), rs.getString("service_type_name")));
                serviceList.add(service);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi lấy danh sách dịch vụ : " + e.getMessage());
        }
        return serviceList;
    }

    @Override
    public boolean addService(Service service) {
        String sql = "INSERT INTO service (service_name, service_area, service_cost, service_max_people, rent_type_id, service_type_id, standard_room, description_other_convenience, pool_area, number_of_floors, free_service_included) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        Connection connection = BaseRepository.getConnectDB();
        try {
            connection.setAutoCommit(false);
            PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, service.getServiceName());
            stmt.setDouble(2, service.getServiceArea());
            stmt.setDouble(3, service.getServiceCost());
            stmt.setInt(4, service.getServiceMaxPeople());
            stmt.setInt(5, service.getServiceRentType().getRentTypeId());
            stmt.setInt(6, service.getServiceType().getServiceTypeId());

            if (service instanceof Villa) {
                Villa villa = (Villa) service;
                stmt.setString(7, villa.getStandardRoom());
                stmt.setString(8, villa.getDescriptionOtherConvenience());
                stmt.setDouble(9, villa.getPoolArea());
                stmt.setInt(10, villa.getNumberOfFloors());
                stmt.setNull(11, Types.VARCHAR);
            } else if (service instanceof House) {
                House house = (House) service;
                stmt.setString(7, house.getStandardRoom());
                stmt.setString(8, house.getDescriptionOtherConvenience());
                stmt.setNull(9, Types.DOUBLE); // pool_area không áp dụng cho House
                stmt.setInt(10, house.getNumberOfFloors());
                stmt.setNull(11, Types.VARCHAR);
            } else if (service instanceof Room) {
                Room room = (Room) service;
                stmt.setNull(7, Types.VARCHAR); // standard_room không áp dụng cho Room
                stmt.setNull(8, Types.VARCHAR); // description_other_convenience không áp dụng cho Room
                stmt.setNull(9, Types.DOUBLE); // pool_area không áp dụng cho Room
                stmt.setNull(10, Types.INTEGER); // number_of_floors không áp dụng cho Room
                stmt.setString(11, room.getFreeServiceIncluded());
            } else {
                throw new IllegalArgumentException("Loại dịch vụ không hợp lệ");
            }

            stmt.executeUpdate();
            ResultSet resultSet = stmt.getGeneratedKeys();
            if (resultSet.next()) {
                int generatedId = resultSet.getInt(1);
                service.setServiceId(generatedId);
                connection.commit();
                return true;
            } else {
                throw new SQLException("Không thể lấy ID của dịch vụ vừa tạo!");
            }

        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
            throw new RuntimeException(e);
        }
    }

    @Override
    public Service getServiceById(int id) {
        String sql = "SELECT s.*, st.service_type_name, rt.rent_type_name, rt.rent_type_cost " +
                "FROM service s " +
                "JOIN service_type st ON s.service_type_id = st.service_type_id " +
                "JOIN rent_type rt ON s.rent_type_id = rt.rent_type_id " +
                "WHERE s.service_id = ?";
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet resultSet = stmt.executeQuery();
            if (resultSet.next()) {
                System.out.println("Tìm thấy dịch vụ với ID: " + id);
                Service service;

                int serviceTypeId = resultSet.getInt("service_type_id");
                if (serviceTypeId == 1) { // Villa
                    service = new Villa();
                    ((Villa) service).setStandardRoom(resultSet.getString("standard_room"));
                    ((Villa) service).setDescriptionOtherConvenience(resultSet.getString("description_other_convenience"));
                    ((Villa) service).setPoolArea(resultSet.getDouble("pool_area"));
                    ((Villa) service).setNumberOfFloors(resultSet.getInt("number_of_floors"));
                } else if (serviceTypeId == 2) { // House
                    service = new House();
                    ((House) service).setStandardRoom(resultSet.getString("standard_room"));
                    ((House) service).setDescriptionOtherConvenience(resultSet.getString("description_other_convenience"));
                    ((House) service).setNumberOfFloors(resultSet.getInt("number_of_floors"));
                } else {
                    service = new Room();
                    ((Room) service).setFreeServiceIncluded(resultSet.getString("free_service_included"));
                }

                service.setServiceId(id);
                service.setServiceName(resultSet.getString("service_name"));
                service.setServiceArea(resultSet.getDouble("service_area"));
                service.setServiceCost(resultSet.getDouble("service_cost"));
                service.setServiceMaxPeople(resultSet.getInt("service_max_people"));

                RentType rentType = new RentType();
                rentType.setRentTypeId(resultSet.getInt("rent_type_id"));
                rentType.setRentTypeName(resultSet.getString("rent_type_name"));
                rentType.setRentTypeCost(resultSet.getDouble("rent_type_cost"));
                service.setServiceRentType(rentType);

                ServiceType serviceType = new ServiceType();
                serviceType.setServiceTypeId(serviceTypeId);
                serviceType.setServiceTypeName(resultSet.getString("service_type_name"));
                service.setServiceType(serviceType);

                return service;
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi lấy dịch vụ theo ID : " + e.getMessage());
        }
        return null;
    }

    @Override
    public boolean updateService(Service service) {
        String sql = "UPDATE service SET service_name = ?, service_area = ?, service_cost = ?, service_max_people = ?, " +
                "rent_type_id = ?, service_type_id = ?, standard_room = ?, description_other_convenience = ?, " +
                "pool_area = ?, number_of_floors = ?, free_service_included = ? WHERE service_id = ?";
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, service.getServiceName());
            stmt.setDouble(2, service.getServiceArea());
            stmt.setDouble(3, service.getServiceCost());
            stmt.setInt(4, service.getServiceMaxPeople());
            stmt.setInt(5, service.getServiceType().getServiceTypeId());
            stmt.setInt(6, service.getServiceRentType().getRentTypeId());

            if (service instanceof Villa) {
                Villa villa = (Villa) service;
                stmt.setString(7, villa.getStandardRoom());
                stmt.setString(8, villa.getDescriptionOtherConvenience());
                stmt.setDouble(9, villa.getPoolArea());
                stmt.setInt(10, villa.getNumberOfFloors());
                stmt.setNull(11, Types.VARCHAR);
            } else if (service instanceof House) {
                House house = (House) service;
                stmt.setString(7, house.getStandardRoom());
                stmt.setString(8, house.getDescriptionOtherConvenience());
                stmt.setNull(9, Types.DOUBLE); // pool_area không áp dụng cho House
                stmt.setInt(10, house.getNumberOfFloors());
                stmt.setNull(11, Types.VARCHAR);
            } else {
                Room room = (Room) service;
                stmt.setNull(7, Types.VARCHAR);
                stmt.setNull(8, Types.VARCHAR);
                stmt.setNull(9, Types.DOUBLE);
                stmt.setNull(10, Types.DOUBLE);
                stmt.setString(11, room.getFreeServiceIncluded());
            }

            stmt.setInt(12, service.getServiceId());
            int effectRows = stmt.executeUpdate();
            return effectRows > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi cập nhật dịch vụ : " + e.getMessage());
        }
    }

    @Override
    public boolean deleteService(int id) {
        String checkSql = "SELECT COUNT(*) FROM contract WHERE service_id = ?";
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement checkStmt = connection.prepareStatement(checkSql);
            checkStmt.setInt(1, id);
            ResultSet checkRs = checkStmt.executeQuery();
            if (checkRs.next() && checkRs.getInt(1) > 0) {
                throw new SQLException("Không thể xóa dịch vụ vì đang được sử dụng trong hợp đồng!");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        String sql = "DELETE FROM service WHERE service_id = ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, id);
            int effectRows = stmt.executeUpdate();
            return effectRows > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi xóa dịch vụ trong DB : " + e.getMessage());
        }
    }
}
