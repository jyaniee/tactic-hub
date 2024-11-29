package com.example.tactichub.dao;

import com.example.tactichub.dto.UserDTO;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
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

    public boolean insertUser(UserDTO user) {
        String sql = "INSERT INTO users (id, password, lol_nickname_tag, site_nickname) VALUES (?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, user.getId());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getLolNicknameTag());
            pstmt.setString(4, user.getSiteNickname());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
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
