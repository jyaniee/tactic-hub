package com.example.tactichub.controller;

import com.example.tactichub.dao.UserDAO;
import com.example.tactichub.dto.UserDTO;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/updateUser")
public class UpdateUserController extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = req.getParameter("userId");
        String newPassword = req.getParameter("password");
        String newLolNickname = req.getParameter("lolNickname");
        String newSiteNickname = req.getParameter("siteNickname");

        UserDTO updatedUser = new UserDTO(userId, newPassword, newLolNickname, newSiteNickname);
        boolean isUpdated = userDAO.updateUser(updatedUser);

        req.setAttribute("success", isUpdated ? "회원 정보가 성공적으로 수정되었습니다." : "회원 정보 수정에 실패했습니다.");

        // 현재 섹션을 유지
        req.setAttribute("currentSection", "user-management");

        RequestDispatcher dispatcher = req.getRequestDispatcher("admin.jsp");
        dispatcher.forward(req, resp);
    }
}
