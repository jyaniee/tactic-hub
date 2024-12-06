<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.json.JSONObject" %>
<%
    // 세션에서 데이터 읽기
    session = request.getSession();
    JSONObject rankInfo = (JSONObject) session.getAttribute("rankInfo");
    String lolNicknameTag = (String) session.getAttribute("lolNicknameTag");

    // 데이터 초기화
    String tier = rankInfo != null ? rankInfo.optString("tier", "N/A") : "N/A";
    String rank = rankInfo != null ? rankInfo.optString("rank", "N/A") : "N/A";
    int lp = rankInfo != null ? rankInfo.optInt("leaguePoints", 0) : 0;
    int wins = rankInfo != null ? rankInfo.optInt("wins", 0) : 0;
    int losses = rankInfo != null ? rankInfo.optInt("losses", 0) : 0;
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TacticHub - 마이페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/mypage.css">
    <style>
    </style>
</head>
<body class="m-0 vh-100 d-flex">
<!-- Sidebar -->
<div class="sidebar vh-100">
    <img src="images/TacticHub-Logo.png" width="120px" class="mb-3 p-1">
    <a href="#" class="menu-item" data-target="content-1">홈</a>
    <a href="#" class="menu-item active" data-target="content-2">내 정보</a>
    <a href="#" class="menu-item" data-target="content-3">매치 히스토리</a>
    <a href="logout.jsp" class="">로그아웃</a>
</div>

<!-- Content -->
<div class="content">
    <div id="content-1" class="content-section" style="display: none;">
        <h3>홈</h3>
        <p>여기는 홈 페이지입니다.</p>
    </div>
    <!-- 내정보 -->
    <div id="content-2" class="content-section">
        <h3 class="fw-bold">내 정보</h3>
        <div class="card">
            <p class="card-title fw-bold">계정 정보</p>
            <div class="row">
                <!-- Account Info -->
                <div class="col-md-6 mb-3">
                    <div class="card border-0 inner-card">
                        <div class="d-flex align-items-center justify-content-between">
                            <div class="d-flex align-items-center">

                                <!-- 라이엇 로고 -->
                                <div class="d-flex align-items-center justify-content-center gap-2 rounded-4 bg-danger p-2 me-3">
                                    <svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg" class="flex-shrink-0" preserveAspectRatio="none">
                                        <path fill-rule="evenodd" clip-rule="evenodd" d="M1.33333 5.4624L8.80996 2L14.6667 3.46701V11.1435L12.2436 11.441L11.2769 5.95821L10.8106 6.16562L11.2822 11.5591L8.83115 11.8603L7.94701 6.8469L7.48601 7.05204L7.91673 11.9724L5.49366 12.2699L4.68975 7.71288L4.22421 7.92029L4.61406 12.3781L3.19624 12.5522L1.33333 5.4624ZM9.10925 13.4507L8.98586 12.7528H8.98889L14.6669 12.0549V14.3773L9.10925 13.4507Z" fill="white"></path>
                                    </svg>
                                </div>

                                <div>
                                    <p class="mb-0" style="font-size: 14px">라이엇 게임즈</p>
                                    <strong><%= lolNicknameTag %></strong>
                                </div>
                            </div>
                            <a href="mypage"><button class="btn btn-outline-light btn-sm">새로고침</button></a>
                        </div>
                    </div>
                </div>
                <!-- Rank Info -->
                <!-- Rank Info -->
                <div class="col-md-6">
                    <div class="card inner-card">
                        <div>
                            <p class="mb-3 fw-bold">내 전적</p>
                            <%
                                // 승률 계산: wins + losses가 0일 경우 대비
                                String winRate = "N/A"; // 기본값
                                if (wins + losses > 0) {
                                    winRate = String.valueOf(wins * 100 / (wins + losses)) + "%";
                                }

                                String tierImage = null;
                                if (tier != null && !tier.equals("N/A")) {
                                    tierImage = "images/tiers/" + tier.toLowerCase() + ".png";
                                }
                                System.out.println(tierImage);
                            %>
                            <!-- 수정된 레이아웃 -->
                            <div class="d-flex align-items-center">
                                <!-- 이미지 -->
                                <div class="me-3">
                                    <img src="<%= tierImage %>" alt="<%= tier %>" style="width: 50px; height: 50px;">
                                </div>
                                <!-- 텍스트 -->
                                <div>
                                    <!-- 첫 번째 줄 -->
                                    <p class="mb-1">
                                        <span class="fw-bold me-2"><%= tier %> <%= rank %></span>
                                        <%= lp %> LP
                                    </p>
                                    <!-- 두 번째 줄 -->
                                    <p class="mb-0">
                                        <span class="fw-bold me-2">승률 <%= winRate %></span>
                                        (<%= wins %>승 <%= losses %>패)
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <!-- 매치 히스토리 -->
    <div id="content-3" class="content-section" style="display: none;">
        <h3>매치 히스토리</h3>
        <p>여기는 매치 히스토리 페이지 입니다.</p>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // 메뉴 클릭 이벤트
    const menuItems = document.querySelectorAll('.menu-item');
    const contentSections = document.querySelectorAll('.content-section');

    menuItems.forEach(item => {
        item.addEventListener('click', (e) => {
            e.preventDefault();

            // 메뉴 활성화 처리
            menuItems.forEach(i => i.classList.remove('active'));
            item.classList.add('active');

            // 컨텐츠 표시 처리
            const targetId = item.getAttribute('data-target');
            contentSections.forEach(section => {
                section.style.display = section.id === targetId ? 'block' : 'none';
            });
        });
    });
</script>
</body>
</html>
