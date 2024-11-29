package com.example.tactichub.controller;

import com.example.tactichub.dao.AdminDAO;
import com.example.tactichub.dto.AdminDTO;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/admin/login")
public class AdminController extends HttpServlet {
    private final AdminDAO adminDAO = new AdminDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        String password = req.getParameter("password");

        AdminDTO admin = adminDAO.getAdminById(id);

        if (admin != null && admin.getPassword().equals(password)) {
            // 세션에 관리자 정보 저장
            HttpSession session = req.getSession();
            session.setAttribute("admin", admin);
            //테스트용 jsp 주소
            resp.sendRedirect("testdashboard.jsp");
        } else {
            req.setAttribute("error", "로그인 정보가 잘못되었습니다.");
            //테스트용 jsp 주소
            RequestDispatcher dispatcher = req.getRequestDispatcher("testadminLogin.jsp");
            dispatcher.forward(req, resp);
        }
    }
}
