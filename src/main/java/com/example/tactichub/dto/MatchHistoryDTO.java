package com.example.tactichub.dto;

public class MatchHistoryDTO {
    private int id;           // 매치 ID (Primary Key)
    private String userId;    // 사용자 ID
    private String team1;     // 팀 1 플레이어 정보
    private String team2;     // 팀 2 플레이어 정보
    private String createdAt; // 생성 일자 (String 형식으로 저장)

    // 생성자
    public MatchHistoryDTO(int id, String userId, String team1, String team2, String createdAt) {
        this.id = id;
        this.userId = userId;
        this.team1 = team1;
        this.team2 = team2;
        this.createdAt = createdAt;
    }

    // Getter 및 Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getTeam1() {
        return team1;
    }

    public void setTeam1(String team1) {
        this.team1 = team1;
    }

    public String getTeam2() {
        return team2;
    }

    public void setTeam2(String team2) {
        this.team2 = team2;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }



}
