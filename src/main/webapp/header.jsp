<%--
  Created by IntelliJ IDEA.
  User: Jyanie
  Date: 24. 11. 29.
  Time: 오전 11:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // 세션에서 로그인 정보를 가져오기
    String username = (String) session.getAttribute("username");
    boolean isLoggedIn = (username != null);


    String currentPage = request.getRequestURI(); // 현재 요청된 URI
%>
<link rel="stylesheet" href="css/header.css">
<div class="header-container w-100 bg-transparent" style="background-color: rgba(0, 0, 0, 0.8); backdrop-filter: blur(5px)">
    <div class="container">
        <header class="d-flex flex-wrap align-items-center justify-content-center justify-content-md-between py-1 pt-3">
            <div class="col-md-3 mb-2 mb-md-0">
                <a href="index.jsp" class="d-inline-flex link-body-emphasis text-decoration-none">
                    <img src="images/TacticHub-Logo.png" alt="logo" width="120" height="24">
                </a>
            </div>

            <ul class="nav col-12 col-md-auto mb-2 justify-content-center mb-md-0">
                <li>
                    <a href="index.jsp" class="nav-link px-2 text-white <%= currentPage.endsWith("index.jsp") ? "active" : "" %> me-2">
                        홈
                    </a>
                </li>
                <li>
                    <a href="main.jsp" class="nav-link px-2 text-white <%= currentPage.endsWith("main.jsp") ? "active" : "" %> me-2">
                        팀 매칭
                    </a>
                </li>
                <li>
                    <a href="mypage.jsp" class="nav-link px-2 text-white <%= currentPage.endsWith("mypage.jsp") ? "active" : "" %> me-2">
                        마이페이지
                    </a>
                </li>
            </ul>

            <div class="col-md-3 text-end">
                <%
                    if (isLoggedIn) {
                %>
                <!-- 로그인 상태 -->
                <a href="mypage.jsp" class="me-2 text-white" style="text-decoration: none;">환영합니다. <span class="fw-bold"><%= username %></span>님</a>
                <a href="logout.jsp" class="navbtn btn text-white btn-outline-light">로그아웃</a>
                <%
                } else {
                %>
                <!-- 비로그인 상태 -->
                <a href="login.jsp" class="navbtn btn me-2 btn-outline-light text-white">로그인</a>
                <a href="signup.jsp" class="navbtn btn text-white btn-outline-light">회원가입</a>
                <%
                    }
                %>
            </div>
        </header>
    </div>
</div>
