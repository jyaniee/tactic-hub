package com.example.tactichub.dto;

public class MatchHistoryDTO {
    private int id;           // Primary Key
    private String userId;    // 사용자 ID
    private int team;         // 팀 번호 (1 또는 2)
    private String playerName; // 플레이어 이름
    private String playerRank; // 랭크 정보 (playerRank로 변경됨)
    private String createdAt; // 생성 일자

    // 생성자
    public MatchHistoryDTO(int id, String userId, int team, String playerName, String playerRank, String createdAt) {
        this.id = id;
        this.userId = userId;
        this.team = team;
        this.playerName = playerName;
        this.playerRank = playerRank;
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

    public int getTeam() {
        return team;
    }

    public void setTeam(int team) {
        this.team = team;
    }

    public String getPlayerName() {
        return playerName;
    }

    public void setPlayerName(String playerName) {
        this.playerName = playerName;
    }

    public String getPlayerRank() { // playerRank Getter 추가
        return playerRank;
    }

    public void setPlayerRank(String playerRank) { // playerRank Setter 추가
        this.playerRank = playerRank;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }
}
