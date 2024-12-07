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
        // 폼 데이터 가져오기
        String userId = req.getParameter("userId"); // 숨겨진 필드로 userId 전달 필요
        String newPassword = req.getParameter("password");
        String newLolNickname = req.getParameter("lolNickname");
        String newSiteNickname = req.getParameter("siteNickname");

        // 업데이트 처리
        UserDTO updatedUser = new UserDTO(userId, newPassword, newLolNickname, newSiteNickname);
        boolean isUpdated = userDAO.updateUser(updatedUser);

        // 결과 처리
        if (isUpdated) {
            req.setAttribute("success", "회원 정보가 성공적으로 수정되었습니다.");
        } else {
            req.setAttribute("error", "회원 정보 수정에 실패했습니다.");
        }

        // 업데이트 후 admin.jsp로 포워딩
        req.setAttribute("currentSection", "user-management");
        RequestDispatcher dispatcher = req.getRequestDispatcher("admin.jsp");
        dispatcher.forward(req, resp);
    }
}
