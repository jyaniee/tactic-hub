package com.example.tactichub.dto;

public class UserDTO {
    private String id; // Primary key, email 형식
    private String password;
    private String lolNicknameTag;
    private String siteNickname;

    public UserDTO(String id, String password, String lolNicknameTag, String siteNickname) {
        this.id = id;
        this.password = password;
        this.lolNicknameTag = lolNicknameTag;
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

    public String getLolNicknameTag() {
        return lolNicknameTag;
    }

    public void setLolNicknameTag(String lolNicknameTag) {
        this.lolNicknameTag = lolNicknameTag;
    }

    public String getSiteNickname() {
        return siteNickname;
    }

    public void setSiteNickname(String siteNickname) {
        this.siteNickname = siteNickname;
    }

    @Override
    public String toString() {
        return "UserDTO {" +
                "id='" + id + '\'' +
                ", lolNicknameTag='" + lolNicknameTag + '\'' +
                ", siteNickname='" + siteNickname + '\'' +
                '}';
    }
}