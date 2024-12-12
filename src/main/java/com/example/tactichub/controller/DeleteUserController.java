package com.example.tactichub.controller;

import com.example.tactichub.dao.UserDAO;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/deleteUser")
public class DeleteUserController extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = req.getParameter("userId");
        boolean isDeleted = userDAO.deleteUserById(userId);

        req.setAttribute("success", isDeleted ? "회원이 성공적으로 삭제되었습니다." : "회원 삭제에 실패했습니다.");

        // 현재 섹션을 유지
        req.setAttribute("currentSection", "user-management");

        RequestDispatcher dispatcher = req.getRequestDispatcher("admin.jsp");
        dispatcher.forward(req, resp);
    }
}
