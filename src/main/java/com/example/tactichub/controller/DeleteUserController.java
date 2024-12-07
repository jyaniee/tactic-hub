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
        // 요청에서 회원 ID를 가져옴
        String userId = req.getParameter("userId");

        // DAO를 사용하여 회원 삭제
        boolean isDeleted = userDAO.deleteUserById(userId);

        if (isDeleted) {
            resp.sendRedirect("admin.jsp?message=User deleted successfully");
            System.out.println("User deleted successfully");
        } else {
            System.err.println("User could not be deleted");
            req.setAttribute("error", "Failed to delete user.");
            RequestDispatcher dispatcher = req.getRequestDispatcher("admin.jsp");
            dispatcher.forward(req, resp);
        }
    }
}