package com.example.tactichub.dao;

import com.example.tactichub.dto.AdminDTO;
import java.sql.*;
import io.github.cdimascio.dotenv.Dotenv;

public class AdminDAO {
    /*
    private static final Dotenv dotenv = Dotenv.configure().load();
    private final String url = dotenv.get("DB_URL");
    private final String username = dotenv.get("DB_USERNAME");
    private final String password = dotenv.get("DB_PASSWORD");
     */
    private final String url = "jdbc:mysql://tactichub-db.cx0wakkc4xro.ap-northeast-2.rds.amazonaws.com:3306/tactic?serverTimezone=UTC&useSSL=false&characterEncoding=utf-8";
    private final String username = "admin";
    private final String password = "tactichub2024!";

    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("JDBC URL: " + url);
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
                        rs.getString("password"),
                        rs.getString("site_nickname")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    public AdminDTO getAdminByIdAndPassword(String id, String password) {
        String sql = "SELECT * FROM admin WHERE id = ? AND password = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, id);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return new AdminDTO(
                        rs.getString("id"),
                        rs.getString("password"),
                        rs.getString("site_nickname")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // 로그인 실패 시 null 반환
    }
}
