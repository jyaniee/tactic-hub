package com.example.tactichub.controller;

import com.example.tactichub.dao.UserDAO;
import com.example.tactichub.dto.UserDTO;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterController extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 폼 데이터 가져오기
        String id = req.getParameter("email");
        String password = req.getParameter("password");
        String passwordConfirm = req.getParameter("password-confirm");
        String summoner = req.getParameter("summoner");

        // 비밀번호 확인 검증
        if (!password.equals(passwordConfirm)) {
            req.setAttribute("error", "비밀번호가 일치하지 않습니다.");
            RequestDispatcher dispatcher = req.getRequestDispatcher("signup.jsp");
            dispatcher.forward(req, resp);
            return;
        }

        // UserDTO 생성
        UserDTO user = new UserDTO(id, password, summoner, summoner); // siteNickname 임시로 summoner와 동일

        // DB에 저장
        boolean isRegistered = userDAO.insertUser(user);

        // 성공 여부에 따라 처리
        if (isRegistered) {
            resp.sendRedirect("signupSuccess.jsp"); // 성공 페이지로 이동
        } else {
            req.setAttribute("error", "회원가입에 실패했습니다. 다시 시도해주세요.");
            RequestDispatcher dispatcher = req.getRequestDispatcher("signup.jsp");
            dispatcher.forward(req, resp);
        }
    }
}
