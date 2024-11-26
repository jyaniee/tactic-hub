<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>TacticHub</title>
  <!-- Bootstrap 및 공통 스타일 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="css/main.css">
  <script src="assets/js/color-modes.js"></script>
  <script src="js/main.js"></script>
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
<body>
<!-- 헤더 -->
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
        <li><a href="." class="nav-link px-2 link-light active">홈</a></li>
        <li><a href="main.jsp" class="nav-link px-2 link-light">팀 매칭</a></li>
        <li><a href="#" class="nav-link px-2 link-light">메뉴뭐하지</a></li>
      </ul>
      <div class="col-md-3 text-end">
        <a href="login.jsp" type="button" class="navbtn btn me-2 btn-outline-light text-white">로그인</a>
        <a href="signup.jsp" type="button" class="navbtn btn text-white btn-outline-light">회원가입</a>
      </div>
    </header>
  </div>
</div>

<!-- 메인 컨텐츠 -->
<div class="content-container">
  <h1 class="mb-4 text-start">사용자 설정 게임 팀 매칭</h1>
  <p class="text-start">플레이어의 이름과 랭크를 선택해주세요. <img src="images/TacticHub-Logo.png" alt="logo" width="80" height="16"> 가 각 팀의 평균 실력을 균등하게 맞춰줍니다. <br>5v5 커스텀 게임을 위한 최적의 팀을 간편하게 만들어보세요!</p>

  <!-- 플레이어 입력 -->
  <div class="mb-3">
    <label for="player" class="form-label fw-bold">플레이어</label>
    <input type="text" id="player" name="player" class="form-control" placeholder="닉네임을 입력하세요.">
  </div>

  <!-- 랭크 선택 -->
  <div class="mb-3">
    <label class="form-label fw-bold">랭크</label>
    <div class="d-flex gap-2 rank-icon">
      <button class="btn btn-outline-secondary p-1" data-rank="iron"><img src="images/tiers/iron.png" alt="Iron"></button>
      <button class="btn btn-outline-secondary p-1" data-rank="bronze"><img src="images/tiers/bronze.png" alt="Bronze"></button>
      <button class="btn btn-outline-secondary p-1" data-rank="silver"><img src="images/tiers/silver.png" alt="Silver"></button>
      <button class="btn btn-outline-secondary p-1" data-rank="gold"><img src="images/tiers/gold.png" alt="Gold"></button>
      <button class="btn btn-outline-secondary p-1" data-rank="platinum"><img src="images/tiers/platinum.png" alt="Platinum"></button>
      <button class="btn btn-outline-secondary p-1" data-rank="emerald"><img src="images/tiers/emerald.png" alt="Emerald"></button>
      <button class="btn btn-outline-secondary p-1" data-rank="diamond"><img src="images/tiers/diamond.png" alt="Diamond"></button>
    </div>
  </div>

  <!-- 티어 선택 -->
  <div class="tier_radio d-flex justify-content-start gap-3 mb-3 ps-2">
    <input type="radio" id="tierI" name="tier" value="1" class="pe-4 ps-4"><label for="tierI">I</label>
    <input type="radio" id="tierII" name="tier" value="2" class="p-auto"><label for="tierII">II</label>
    <input type="radio" id="tierIII" name="tier" value="3" class="p-auto"><label for="tierIII">III</label>
    <input type="radio" id="tierIV" name="tier" value="4" class="p-auto"><label for="tierIV">IV</label>
  </div>

  <!-- 확인 및 초기화 버튼 -->
  <div class="d-flex gap-3 justify-content-start mb-3">
    <button class="btn fw-bold" id="submit" style=" border-color: rgba(50, 205, 50, 0.5);">확인</button>
    <button class="btn fw-bold" id="reset" style="border-color: rgba(255, 50, 50, 0.5);">초기화</button>
  </div>

  <!-- 플레이어 리스트 -->
  <div class="row" style="">
    <div class="col-md-6 player_list">
      <input type="text" class="form-control mb-2" placeholder="플레이어 1" readonly>
      <input type="text" class="form-control mb-2" placeholder="플레이어 2" readonly>
      <input type="text" class="form-control mb-2" placeholder="플레이어 3" readonly>
      <input type="text" class="form-control mb-2" placeholder="플레이어 4" readonly>
      <input type="text" class="form-control mb-2" placeholder="플레이어 5" readonly>
    </div>
    <div class="col-md-6 player_list">
      <input type="text" class="form-control mb-2" placeholder="플레이어 6" readonly>
      <input type="text" class="form-control mb-2" placeholder="플레이어 7" readonly>
      <input type="text" class="form-control mb-2" placeholder="플레이어 8" readonly>
      <input type="text" class="form-control mb-2" placeholder="플레이어 9" readonly>
      <input type="text" class="form-control mb-2" placeholder="플레이어 10" readonly>
    </div>
  </div>

  <!-- 팀 구성 버튼 -->
  <div class="d-flex gap-3 justify-content-center mt-3">
    <button class="btn fw-bold" id="calc" style="border-color: #adb5bd">팀 구성하기</button>
  </div>
</div>

<!-- 푸터 -->
<footer class="bg-dark text-white text-center py-3 mt-5">
  <p>© TacticHub 2024 - All rights reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
