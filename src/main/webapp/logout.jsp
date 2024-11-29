<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    session.invalidate(); //세션을 완전히 종료

    response.sendRedirect("index.jsp");
%>
