package com.example.tactichub.controller;

import com.example.tactichub.dao.UserDAO;
import com.example.tactichub.dto.UserDTO;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/users")
public class UserController extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 전체 사용자 목록 가져오기
        List<UserDTO> userList = userDAO.getAllUsers();

        // 사용자 리스트를 요청 속성에 추가
        req.setAttribute("users", userList);

        // JSP로 포워딩
        //테스트용 jsp 주소
        RequestDispatcher dispatcher = req.getRequestDispatcher("testusers.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 회원가입 처리
        String id = req.getParameter("id");
        String password = req.getParameter("password");
        String lolNicknameTag = req.getParameter("lolNicknameTag");
        String siteNickname = req.getParameter("siteNickname");

        UserDTO user = new UserDTO(id, password, lolNicknameTag, siteNickname);

        boolean isInserted = userDAO.insertUser(user);

        if (isInserted) {
            resp.sendRedirect("users"); // 사용자 목록 페이지로 리다이렉트
        } else {
            req.setAttribute("error", "회원가입에 실패했습니다.");
            //테스트용 jsp 주소
            RequestDispatcher dispatcher = req.getRequestDispatcher("testregister.jsp");
            dispatcher.forward(req, resp);
        }
    }
}
