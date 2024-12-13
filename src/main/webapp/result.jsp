<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>TacticHub - 5v5 최적 팀 구성 결과</title>
  <link rel="icon" type="image/png" href="images/TacticHub-Icon.png">
  <!-- Bootstrap 및 공통 스타일 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="css/result.css">
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="assets/js/color-modes.js"></script>
  <script src="js/result.js"></script>
  <script>
    $(document).ready(function () {
      $("#saveButton").on("click", function (e) {
        e.preventDefault(); // 기본 동작 막기

        // AJAX 요청
        $.ajax({
          url: "saveMatchHistory",
          type: "POST",
          data: {
            team1: $("#hidden-team1").val(),
            team2: $("#hidden-team2").val(),
          },
          success: function () {
            $(".alert-container").html(`
            <div class="alert alert-success text-center mt-4" role="alert">
              팀 매칭 기록이 성공적으로 저장되었습니다!
            </div>
          `);
          },
          error: function () {
            $(".alert-container").html(`
            <div class="alert alert-danger text-center mt-4" role="alert">
              팀 매칭 기록 저장 중 오류가 발생했습니다. 다시 시도해주세요.
            </div>
          `);
          },
        });
      });
    });
  </script>
  <style>
  </style>
</head>
<body>
<!-- 헤더 
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
        <li><a href="." class="nav-link px-2 link-light me-2">홈</a></li>
        <li><a href="main.jsp" class="nav-link px-2 link-light active me-2">팀 매칭</a></li>
        <li><a href="#" class="nav-link px-2 link-light me-2">마이페이지</a></li>
      </ul>
      <div class="col-md-3 text-end">
        <a href="login.jsp" type="button" class="navbtn btn me-2 btn-outline-light text-white">로그인</a>
        <a href="signup.jsp" type="button" class="navbtn btn text-white btn-outline-light">회원가입</a>
      </div>
    </header>
  </div>
</div>
-->
<%@ include file="header.jsp"%>
<div class="content-container position-relative">
  <!-- 로딩 애니메이션 -->
  <div class="loading-animation" id="loading-animation">
    <div class="circular-loader"></div>
  </div>
  <!-- 블러 처리 없이 유지될 부분 -->
  <h1 class="mb-4 text-start" style="font-size: 28px">
    <img src="images/check_circle.png" alt="complete" width="50" height="50" style="filter: drop-shadow(1px 1px 1px rgba(0, 0, 0, 0.8));">
    게임을 위한 최적의 팀이 구성되었습니다!
  </h1>
  <p class="text-start">
    편성된 팀을 확인하세요! <br>
    각 팀의 평균 실력이 균등하도록
    <img src="images/TacticHub-Logo.png" alt="logo" width="80" height="16" class="mb-1">
    가 최적의 팀을 구성했습니다.
  </p>

  <hr>

  <!-- 플레이어 리스트 (블러 처리될 부분) -->
  <div class="row mt-4">
    <div class="col-md-6 player_list">
      <div class="team-header d-flex justify-content-center align-items-center mb-3">
        <img src="images/groups.png" alt="Team 1" width="35" height="35" class="me-2">
        <h3 class="text-white mb-0">팀 1</h3>
      </div>
      <div class="blur-container" id="team1-players">
        <input type="text" class="form-control mb-2 rdonly" readonly>
        <input type="text" class="form-control mb-2 rdonly" readonly>
        <input type="text" class="form-control mb-2 rdonly" readonly>
        <input type="text" class="form-control mb-2 rdonly" readonly>
        <input type="text" class="form-control mb-2 rdonly" readonly>
      </div>
    </div>
    <div class="col-md-6 player_list">
      <div class="team-header d-flex justify-content-center align-items-center mb-3">
        <img src="images/groups.png" alt="Team 2" width="35" height="35" class="me-2">
        <h3 class="text-white mb-0">팀 2</h3>
      </div>
      <div class="blur-container" id="team2-players">
        <input type="text" class="form-control mb-2 rdonly" readonly>
        <input type="text" class="form-control mb-2 rdonly" readonly>
        <input type="text" class="form-control mb-2 rdonly" readonly>
        <input type="text" class="form-control mb-2 rdonly" readonly>
        <input type="text" class="form-control mb-2 rdonly" readonly>
      </div>
    </div>
  </div>

  <div class="alert-container"></div>

  <%
    // Referer 헤더를 가져옴
    String referer = request.getHeader("Referer");

    // Referer가 null이거나 허용되지 않은 값일 경우 기본값으로 main.jsp를 설정
    String backPage = "main.jsp";
    if (referer != null && (referer.contains("main.jsp") || referer.contains("memberVersion.jsp"))) {
      backPage = referer; // Referer를 사용
    }
  %>

  <!-- 숨겨진 필드 -->
  <form id="saveMatchForm">
    <input type="hidden" id="hidden-team1" name="team1">
    <input type="hidden" id="hidden-team2" name="team2">
  </form>

  <!-- 저장하기 버튼과 다시 구성하기 버튼 -->
  <div class="d-flex gap-3 justify-content-center mt-5">
    <a href="<%= backPage %>"><button class="btn fw-bold" id="calc" style="border-color: #adb5bd;">다시 구성하기</button></a>
    <button type="button" id="saveButton" class="btn fw-bold" style="border-color: #adb5bd;">결과 저장하기</button>
  </div>

</div>

<%@ include file="footer.jsp"%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
