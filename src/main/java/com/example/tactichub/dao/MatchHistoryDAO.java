package com.example.tactichub.dao;

import com.example.tactichub.DatabaseConnection;
import com.example.tactichub.dto.MatchHistoryDTO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MatchHistoryDAO {

    // 여러 플레이어 저장 메서드
    public boolean saveMatchHistory(List<MatchHistoryDTO> matchHistories) {
        String sql = "INSERT INTO match_history_v2 (user_id, team, player_name, player_rank) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            for (MatchHistoryDTO matchHistory : matchHistories) {
                pstmt.setString(1, matchHistory.getUserId());
                pstmt.setInt(2, matchHistory.getTeam());
                pstmt.setString(3, matchHistory.getPlayerName());
                pstmt.setString(4, matchHistory.getPlayerRank());
                pstmt.addBatch();
            }
            pstmt.executeBatch();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 매치 히스토리 조회 메서드
    public List<MatchHistoryDTO> getMatchHistoryByUser(String userId) {
        String sql = "SELECT * FROM match_history_v2 WHERE user_id = ? ORDER BY created_at DESC";
        List<MatchHistoryDTO> matchHistoryList = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                matchHistoryList.add(new MatchHistoryDTO(
                        rs.getInt("id"),
                        rs.getString("user_id"),
                        rs.getInt("team"),
                        rs.getString("player_name"),
                        rs.getString("player_rank"),
                        rs.getString("created_at")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return matchHistoryList;
    }

}
