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

        // 성공 여부에 따라 메시지 설정
        if (isDeleted) {
            req.setAttribute("success", "회원이 성공적으로 삭제되었습니다.");
        } else {
            req.setAttribute("error", "회원 삭제에 실패했습니다.");
        }

        // 회원 관리 페이지에 그대로 머무르도록 forward 호출
        req.setAttribute("currentSection", "user-management");
        RequestDispatcher dispatcher = req.getRequestDispatcher("admin.jsp");
        dispatcher.forward(req, resp);
    }
}
