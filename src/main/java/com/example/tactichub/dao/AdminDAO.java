package com.example.tactichub.dao;

import com.example.tactichub.dto.AdminDTO;
import java.sql.*;

public class AdminDAO {
    private final String url = "jdbc:mysql://localhost:3306/tactic?serverTimezone=UTC&useSSL=false&characterEncoding=utf-8";
    private final String username = "root";
    private final String password = "dongyang";

    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return DriverManager.getConnection(url, username, password);
    }

    public boolean insertAdmin(AdminDTO admin) {
        String sql = "INSERT INTO admin (id, password) VALUES (?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, admin.getId());
            pstmt.setString(2, admin.getPassword());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public AdminDTO getAdminById(String id) {
        String sql = "SELECT * FROM admin WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return new AdminDTO(
                        rs.getString("id"),
                        rs.getString("password")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
