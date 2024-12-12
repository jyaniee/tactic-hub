<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.example.tactichub.dao.UserDAO" %>
<%@ page import="com.example.tactichub.dao.AdminDAO" %>
<%@ page import="com.example.tactichub.dto.UserDTO" %>
<%@ page import="com.example.tactichub.dto.AdminDTO" %>

<%
    // 사용자가 입력한 데이터를 받음
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    if ("admin@tih.com".equals(email)) {
        // 어드민 검증 로직
        AdminDAO adminDAO = new AdminDAO();
        AdminDTO admin = adminDAO.getAdminByIdAndPassword(email, password);

        if (admin != null) {
            // 어드민 로그인 성공 시 세션에 어드민 정보 저장
            session.setAttribute("email", admin.getId());
            session.setAttribute("role", "admin");
            session.setAttribute("username", admin.getSiteNickname());

            response.sendRedirect("index.jsp");
        } else {
            // 어드민 로그인 실패 시
            out.println("<script>alert('아이디 또는 비밀번호가 틀렸습니다.'); location.href='login.jsp';</script>");
        }
    } else {
        // 일반 사용자 검증 로직
        UserDAO userDAO = new UserDAO();
        UserDTO user = userDAO.getUserByEmailAndPassword(email, password);

        if (user != null) {
            // 일반 사용자 로그인 성공 시 세션에 사용자 정보 저장
            session.setAttribute("username", user.getSiteNickname());
            session.setAttribute("email", user.getId());
            session.setAttribute("role", "user");

            // 메인 페이지로 리다이렉트
            response.sendRedirect("index.jsp");
        } else {
            // 일반 사용자 로그인 실패 시
            out.println("<script>alert('아이디 또는 비밀번호가 틀렸습니다.'); location.href='login.jsp';</script>");
        }
    }
%>
