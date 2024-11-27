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
  <script src="assets/js/color-modes.js"></script>
  <script src="js/result.js"></script>
  <script>

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

<!-- 메인 컨텐츠 -->
<div class="content-container">
  <h1 class="mb-4 text-start" style="font-size: 28px"><img src="images/check_circle.png" alt="complete" width="50" height="50" style="filter: drop-shadow(1px 1px 1px rgba(0, 0, 0, 0.8));"> 게임을 위한 최적의 팀이 구성되었습니다!</h1>
  <p class="text-start">편성된 팀을 확인하세요! <br>
    각 팀의 평균 실력이 균등하도록 <img src="images/TacticHub-Logo.png" alt="logo" width="80" height="16" class="mb-1"> 가 최적의 팀을 구성했습니다.</p>

  <hr>
  <!-- 플레이어 리스트 -->
  <div class="row mt-4" style="">
    <div class="col-md-6 player_list">
      <div class="team-header d-flex justify-content-center align-items-center mb-3">
        <img src="images/groups.png" alt="Team 1" width="35" height="35" class="me-2">
        <h3 class="text-white mb-0">팀 1</h3>
      </div>
      <input type="text" class="form-control mb-2 rdonly" placeholder="플레이어 1" readonly>
      <input type="text" class="form-control mb-2 rdonly" placeholder="플레이어 2" readonly>
      <input type="text" class="form-control mb-2 rdonly" placeholder="플레이어 3" readonly>
      <input type="text" class="form-control mb-2 rdonly" placeholder="플레이어 4" readonly>
      <input type="text" class="form-control mb-2 rdonly" placeholder="플레이어 5" readonly>
    </div>
    <div class="col-md-6 player_list">
      <div class="team-header d-flex justify-content-center align-items-center mb-3">
        <img src="images/groups.png" alt="Team 2" width="35" height="35" class="me-2">
        <h3 class="text-white mb-0">팀 2</h3>
      </div>
      <input type="text" class="form-control mb-2 rdonly" placeholder="플레이어 6" readonly>
      <input type="text" class="form-control mb-2 rdonly" placeholder="플레이어 7" readonly>
      <input type="text" class="form-control mb-2 rdonly" placeholder="플레이어 8" readonly>
      <input type="text" class="form-control mb-2 rdonly" placeholder="플레이어 9" readonly>
      <input type="text" class="form-control mb-2 rdonly" placeholder="플레이어 10" readonly>
    </div>
  </div>

  <!-- 다시 구성하기 -->
  <div class="d-flex gap-3 justify-content-center mt-5">
    <a href="main.jsp"><button class="btn fw-bold" id="calc" style="border-color: #adb5bd">다시 구성하기</button></a>
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
