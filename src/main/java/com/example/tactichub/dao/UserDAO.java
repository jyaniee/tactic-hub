package com.example.tactichub.dao;

import com.example.tactichub.DatabaseConnection;
import com.example.tactichub.dto.UserDTO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // 회원 삽입 메서드
    public boolean insertUser(UserDTO user) {
        String sql = "INSERT INTO users (id, password, lol_nickname_tag, site_nickname) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
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
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 모든 회원 조회 메서드
    public List<UserDTO> getAllUsers() {
        String sql = "SELECT * FROM users";
        List<UserDTO> userList = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
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
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userList;
    }

    // 이메일 및 비밀번호로 회원 조회 (로그인)
    public UserDTO getUserByEmailAndPassword(String email, String password) {
        String sql = "SELECT * FROM users WHERE id = ? AND password = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return new UserDTO(
                        rs.getString("id"),
                        rs.getString("password"),
                        rs.getString("lol_nickname_tag"),
                        rs.getString("site_nickname")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // 로그인 실패 시 null 반환
    }
}
