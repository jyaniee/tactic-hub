package com.example.tactichub.dto;

public class AdminDTO {
    private String id; // Primary key, id 형식
    private String password;
    private String siteNickname;
    public AdminDTO(String id, String password, String siteNickname) {
        this.id = id;
        this.password = password;
        this.siteNickname = siteNickname;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getSiteNickname() {
        return siteNickname;
    }

    public void setSiteNickname(String siteNickname) {
        this.siteNickname = siteNickname;
    }
}
