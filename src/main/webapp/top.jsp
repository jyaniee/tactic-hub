<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String currentUri = request.getRequestURI(); //현재 페이지 URL 확인
%>
<div class="header-container w-100 bg-transparent"
     style="background-color: rgba(0, 0, 0, 0.8); backdrop-filter: blur(5px); position: fixed; top: 0; z-index: 1000;">
    <div class="container">
        <header class="d-flex flex-wrap align-items-center justify-content-center justify-content-md-between py-1 pt-3">
            <div class="col-md-3 mb-2 mb-md-0">
                <a href="index.jsp" class="d-inline-flex link-body-emphasis text-decoration-none">
                    <img src="images/TacticHub-Logo.png" alt="logo" width="120" height="24">
                </a>
            </div>
            <ul class="nav col-12 col-md-auto mb-2 justify-content-center mb-md-0">
                <li><a href="index.jsp" class="nav-link px-2 link-light <%= currentUri.contains("index.jsp") ? "active" : "" %> me-2">홈</a></li>
                <li><a href="main.jsp" class="nav-link px-2 link-light <%= currentUri.contains("main.jsp") || currentUri.contains("result.jsp") ? "active" : "" %> me-2">팀 매칭</a></li>
                <li><a href="mypage.jsp" class="nav-link px-2 link-light <%= currentUri.contains("mypage.jsp") ? "active" : "" %> me-2">마이페이지</a></li>
            </ul>
            <!-- 현재 uri 기준으로 동적으로 underline 생성 -->
            <div class="col-md-3 text-end">
                <a href="login.jsp" type="button" class="navbtn btn me-2 btn-outline-light text-white">로그인</a>
                <a href="signup.jsp" type="button" class="navbtn btn text-white btn-outline-light">회원가입</a>
            </div>
        </header>
    </div>
</div>
