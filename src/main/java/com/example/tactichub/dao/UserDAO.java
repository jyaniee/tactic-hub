package com.example.tactichub.dao;

import com.example.tactichub.dto.UserDTO;
import io.github.cdimascio.dotenv.Dotenv;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
   // private static final Dotenv dotenv = Dotenv.configure().load();
   // private final String url = dotenv.get("DB_URL");
   // private final String username = dotenv.get("DB_USERNAME");
   // private final String password = dotenv.get("DB_PASSWORD");
    private final String url = "jdbc:mysql://tactichub-db.cx0wakkc4xro.ap-northeast-2.rds.amazonaws.com:3306/tactic?serverTimezone=UTC&useSSL=false&characterEncoding=utf-8";
    private final String username = "admin";
    private final String password = "tactichub2024!";

    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new SQLException("JDBC Driver not found");
        }
        try {
            return DriverManager.getConnection(url, username, password);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("Failed to connect to DB: " + e.getMessage());
        }
    }

    public boolean insertUser(UserDTO user) {
        String sql = "INSERT INTO users (id, password, lol_nickname_tag, site_nickname) VALUES (?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, user.getId());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getLolNicknameTag());
            pstmt.setString(4, user.getSiteNickname());
            int rowsAffected = pstmt.executeUpdate(); // 성공적으로 삽입된 행 수 반환
            return rowsAffected > 0; // 1 이상이면 삽입 성공, 아니면 실패
        } catch (SQLException e) {
            e.printStackTrace();

            return false;
        }
    }

    public List<UserDTO> getAllUsers() {
        String sql = "SELECT * FROM users";
        List<UserDTO> userList = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                userList.add(new UserDTO(
                        rs.getString("id"),
                        rs.getString("password"),
                        rs.getString("lol_nickname_tag"),
                        rs.getString("site_nickname")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userList;
    }
}
