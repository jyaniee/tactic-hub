<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>TacticHub - 나만의 팀을 구성하세요!</title>
  <link rel="icon" type="image/png" href="images/TacticHub-Icon.png">
  <!-- Bootstrap 및 공통 스타일 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="css/main.css">
  <script src="assets/js/color-modes.js"></script>
  <script src="js/main.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <script>
    document.addEventListener("DOMContentLoaded", () => {
      const rankButtons = document.querySelectorAll(".rank-icon button");

      rankButtons.forEach((button) => {
        button.addEventListener("click", () => {
          // 모든 버튼의 active 상태 제거
          rankButtons.forEach((btn) => btn.classList.remove("active"));
          // 클릭한 버튼에 active 상태 추가
          button.classList.add("active");
        });
      });
    });
  </script>
  <style>
  </style>
</head>
<body style="background-image: url('images/irelia.jpg');">
<!-- 헤더 -->
<%@ include file="header.jsp" %>
<%
  if (!isLoggedIn) {
    // 로그인이 안 되어 있으면 로그인 페이지로 리다이렉트
    response.sendRedirect("login.jsp");
    return;
  }
%>
<!-- 메인 컨텐츠 -->
<div class="content-container">
  <h1 class="mb-4 text-start" style="font-size: 28px">사용자 설정 게임 팀 매칭<span class="badge bg-success" style="font-size: 16px; margin-left: 10px; ">회원 전용</span></h1>
  <p class="text-start">로그인한 회원만 이용할 수 있는 고급 팀 구성 서비스입니다.
    <br>API를 통해 더욱 간편하게 사용자 정보를 입력하고, 랭크 선택 없이 자동으로 최적의 팀 구성을 경험해보세요!
  </p>

  <!-- 플레이어 입력 -->
  <div class="mb-3">
    <label for="player" class="form-label fw-bold">플레이어</label>
    <input type="text" id="player" name="player" class="form-control" placeholder="플레이어 이름#KR1" style="border: none;">
  </div>


  <!-- 확인 및 초기화 버튼 -->
  <div class="d-flex gap-3 justify-content-start mb-3">
    <button class="btn fw-bold" id="submit" style="">API로 불러오기</button>
    <button class="btn fw-bold" id="reset" style="">초기화</button>
  </div>

  <!-- 플레이어 리스트 -->
  <div class="row" style="">
    <div class="col-md-6 player_list">
      <input type="text" class="form-control mb-2 rdonly" placeholder="플레이어 1" readonly>
      <input type="text" class="form-control mb-2 rdonly" placeholder="플레이어 2" readonly>
      <input type="text" class="form-control mb-2 rdonly" placeholder="플레이어 3" readonly>
      <input type="text" class="form-control mb-2 rdonly" placeholder="플레이어 4" readonly>
      <input type="text" class="form-control mb-2 rdonly" placeholder="플레이어 5" readonly>
    </div>
    <div class="col-md-6 player_list">
      <input type="text" class="form-control mb-2 rdonly" placeholder="플레이어 6" readonly>
      <input type="text" class="form-control mb-2 rdonly" placeholder="플레이어 7" readonly>
      <input type="text" class="form-control mb-2 rdonly" placeholder="플레이어 8" readonly>
      <input type="text" class="form-control mb-2 rdonly" placeholder="플레이어 9" readonly>
      <input type="text" class="form-control mb-2 rdonly" placeholder="플레이어 10" readonly>
    </div>
  </div>

  <!-- 팀 구성 버튼 -->
  <div class="d-flex gap-3 justify-content-center mt-3 mb-5">
    <a><button class="btn fw-bold" id="calc" style="border-color: #adb5bd">팀 구성하기</button></a>
  </div>

</div>

<!-- 푸터 -->
<div class="container">
  <footer class="d-flex flex-wrap justify-content-between align-items-center py-3 mt-4 border-top">
    <div class="col-md-4 d-flex align-items-center" style="width: 50%">
      <a href="/" class="mb-3 me-2 mb-md-0 text-body-secondary text-decoration-none lh-1">
        <img src="images/TacticHub-Logo.png" width="100" height="20">
      </a>
      <span class="mb-3 mb-md-0 text-body-secondary">© 2024 Dongyang Mirae Univ, Computer Software Engineering, Team 5</span>
    </div>

    <ul class="nav col-md-4 justify-content-end list-unstyled d-flex">
      <li class="ms-3"><a class="text-body-secondary" href="https://github.com/sim00507/tactic-hub" target="_blank"><img src="images/github-mark-white.png" width="25" height="25"></a></li>
      <li class="ms-3"><a class="text-body-secondary" href="#"><svg class="bi" width="24" height="24"><use xlink:href="#instagram"></use></svg></a></li>
      <li class="ms-3"><a class="text-body-secondary" href="#"><svg class="bi" width="24" height="24"><use xlink:href="#facebook"></use></svg></a></li>
    </ul>
  </footer>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>