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
<body>
<!-- 헤더 -->
<%@ include file="header.jsp" %>

<!-- 메인 컨텐츠 -->
<div class="content-container">
  <h1 class="mb-4 text-start" style="font-size: 28px">사용자 설정 게임 팀 매칭</h1>
  <p class="text-start">플레이어의 이름과 랭크를 선택해주세요. <img src="images/TacticHub-Logo.png" alt="logo" width="80" height="16" class="mb-1"> 가 각 팀의 평균 실력을 균등하게 맞춰줍니다. <br>5v5 커스텀 게임을 위한 최적의 팀을 간편하게 만들어보세요!</p>

  <!-- 플레이어 입력 -->
  <div class="mb-3">
    <label for="player" class="form-label fw-bold">플레이어</label>
    <input type="text" id="player" name="player" class="form-control" placeholder="플레이어 이름#KR1" style="border: none;">
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
    <button class="btn fw-bold" id="submit" style="">확인</button>
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
  <div class="d-flex gap-3 justify-content-center mt-3">
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
