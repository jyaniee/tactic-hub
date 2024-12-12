package com.example.tactichub.dao;

import com.example.tactichub.DatabaseConnection;
import com.example.tactichub.dto.MatchHistoryDTO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MatchHistoryDAO {

    // 매치 히스토리 저장 메서드
    public boolean saveMatchHistory(MatchHistoryDTO matchHistory) {
        String sql = "INSERT INTO match_history (user_id, team1, team2) VALUES (?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, matchHistory.getUserId());
            pstmt.setString(2, matchHistory.getTeam1());
            pstmt.setString(3, matchHistory.getTeam2());
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 매치 히스토리 조회 메서드
    public List<MatchHistoryDTO> getMatchHistoryByUser(String userId) {
        String sql = "SELECT * FROM match_history WHERE user_id = ? ORDER BY created_at DESC";
        List<MatchHistoryDTO> matchHistoryList = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                matchHistoryList.add(new MatchHistoryDTO(
                        rs.getInt("id"),
                        rs.getString("user_id"),
                        rs.getString("team1"),
                        rs.getString("team2"),
                        rs.getString("created_at")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return matchHistoryList;
    }
}
