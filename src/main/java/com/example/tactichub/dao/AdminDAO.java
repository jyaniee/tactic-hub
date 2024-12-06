package com.example.tactichub.dao;

import com.example.tactichub.DatabaseConnection;
import com.example.tactichub.dto.AdminDTO;

import java.sql.*;

public class AdminDAO {

    // 관리자 삽입 메서드
    public boolean insertAdmin(AdminDTO admin) {
        String sql = "INSERT INTO admin (id, password) VALUES (?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, admin.getId());
            pstmt.setString(2, admin.getPassword());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ID로 관리자 조회 메서드
    public AdminDTO getAdminById(String id) {
        String sql = "SELECT * FROM admin WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
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
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ID와 비밀번호로 관리자 조회 메서드 (로그인)
    public AdminDTO getAdminByIdAndPassword(String id, String password) {
        String sql = "SELECT * FROM admin WHERE id = ? AND password = ?";
        try (Connection conn = DatabaseConnection.getConnection();
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
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // 로그인 실패 시 null 반환
    }
}
