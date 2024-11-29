<%--
  Created by IntelliJ IDEA.
  User: Jyanie
  Date: 24. 11. 29.
  Time: 오전 11:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<body>
<%@ include file="header.jsp" %>
<%
    if (!isLoggedIn) {
        // 로그인이 안 되어 있으면 로그인 페이지로 리다이렉트
        response.sendRedirect("login.jsp");
        return;
    }
%>
<h1>마이페이지</h1>
<p>안녕하세요, <%= username %>님!</p>
</body>
</html>
