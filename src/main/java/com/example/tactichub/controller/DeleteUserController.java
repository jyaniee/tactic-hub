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
            // 성공 메시지 설정
            req.setAttribute("message", "회원 삭제가 완료되었습니다.");
        } else {
            // 실패 메시지 설정
            req.setAttribute("error", "회원 삭제에 실패했습니다.");
        }

        // 현재 페이지로 요청을 포워딩
        RequestDispatcher dispatcher = req.getRequestDispatcher("admin.jsp");
        dispatcher.forward(req, resp);
    }
}
