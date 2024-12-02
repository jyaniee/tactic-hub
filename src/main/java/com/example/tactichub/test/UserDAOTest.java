package com.example.tactichub.test;

import com.example.tactichub.dao.UserDAO;
import com.example.tactichub.dto.UserDTO;

import java.util.List;

public class UserDAOTest {
    public static void main(String[] args) {
        UserDAO userDAO = new UserDAO();

        // 1. 새로운 사용자 추가
        UserDTO newUser = new UserDTO("user1@example.com", "securepassword", "Player#1234", "GameLover");
        boolean isInserted = userDAO.insertUser(newUser);
        System.out.println("User Inserted: " + isInserted);

        // 2. 모든 사용자 조회
        List<UserDTO> users = userDAO.getAllUsers();
        System.out.println("All Users:");
        for (UserDTO user : users) {
            System.out.println(user);
        }
    }
}
