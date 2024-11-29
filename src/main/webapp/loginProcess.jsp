<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    // 사용자가 입력한 데이터를 받음
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    // 간단한 검증 로직 (실제 프로젝트에서는 DB 연동 필요)
    if ("admin@root".equals(email) && "1234".equals(password)) {
        // 로그인 성공 시 세션에 사용자 정보 저장
        session.setAttribute("username", "관리자"); // 예제: 사용자 이름
        session.setAttribute("email", email);

        // 메인 페이지로 리다이렉트
        response.sendRedirect("index.jsp");
    } else {

        // 로그인 실패 시 다시 로그인 페이지로 이동
        out.println("<script>alert('아이디 또는 비밀번호가 틀렸습니다.'); location.href='login.jsp';</script>");
    }
%>
