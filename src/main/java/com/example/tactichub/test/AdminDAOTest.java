package com.example.tactichub.test;

import com.example.tactichub.dao.AdminDAO;
import com.example.tactichub.dto.AdminDTO;

public class AdminDAOTest {
    public static void main(String[] args) {
        AdminDAO adminDAO = new AdminDAO();
        AdminDTO admin = adminDAO.getAdminById("admin@tih.com");

        if (admin != null) {
            System.out.println("Admin Found: " + admin.getId());
        } else {
            System.out.println("Admin Not Found.");
        }
    }
}
