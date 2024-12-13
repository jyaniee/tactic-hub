<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="com.example.tactichub.dao.MatchHistoryDAO" %>
<%@ page import="com.example.tactichub.dto.MatchHistoryDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
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

    // 사용자 ID 확인
    String userId = (String) session.getAttribute("email"); // 세션에서 사용자 이메일 가져오기

    // 매치 히스토리 가져오기
    MatchHistoryDAO matchHistoryDAO = new MatchHistoryDAO();
    List<MatchHistoryDTO> matchHistoryList = matchHistoryDAO.getMatchHistoryByUser(userId);

    // 팀별로 데이터 분리
    Map<String, List<MatchHistoryDTO>> matchGroups = new LinkedHashMap<>();
    for (MatchHistoryDTO match : matchHistoryList) {
        String key = match.getCreatedAt(); // 저장된 시간 기준으로 그룹화
        matchGroups.putIfAbsent(key, new ArrayList<>());
        matchGroups.get(key).add(match);
    }
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
<div class="sidebar vh-100 d-flex flex-column justify-between">
    <div>
        <h4 class="fw-bold mb-4 mt-2">마이페이지</h4>
        <a href="#" class="menu-item active" data-target="content-1"><img src="images/person.png" class="me-2 pb-1" alt="my-info" width="20px">내 정보</a>
        <a href="#" class="menu-item" data-target="content-2"><img src="images/bookmark.png" class="me-2 pb-1" alt="history" width="20px">매치 히스토리</a>
        <a href="logout.jsp" class=""><img src="images/logout.png" class="me-2 pb-1" alt="logout" width="20px">로그아웃</a>
        <%
            String username = (String) session.getAttribute("username");
            boolean isAdmin = username.equals("admin");
            if(isAdmin){
        %>
        <a href="admin.jsp" class="admin"><img src="images/admin.png" class="me-2 pb-1" alt="my-info" width="20px">관리자 페이지</a>
        <%
            }
        %>
    </div>
    <!-- Footer -->
    <div class="mt-auto text-center mb-3">
        <a href="index.jsp" class="logo"><img src="images/TacticHub-Logo.png" alt="Footer Logo" style="width: 80px;"></a>
        <p style="font-size: 12px; color: #818aaa; margin-bottom: 5px;">백엔드 실습 | 5조 | 김호겸, 문정헌, 심재한</p>
    </div>
</div>


<!-- Content -->
<div class="content">
    <!-- 내정보 -->
    <div id="content-1" class="content-section">
        <h3 class="fw-bold">내 정보</h3>
        <div class="card">
            <p class="card-title fw-bold" style="font-size: 18px">계정 정보</p>
            <p class="fw-bold" style="font-size: 14px;">표시되는 랭크 정보는 솔로 랭크를 우선으로 조회됩니다.</p>
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

        <div class="card mt-4">
            <p class="card-title fw-bold">추가 정보</p>
            <p>추가 예정</p>
        </div>
    </div>

   <!-- 매치 히스토리 -->
       <div id="content-2" class="content-section match-history" style="display: none;">
           <h3 class="fw-bold">매치 히스토리</h3>
           <div class="card">
               <p class="card-title fw-bold">저장된 팀 구성 기록</p>
               <div class="table-responsive">
                   <table class="table table-striped">
                       <thead>
                           <tr>
                               <th>#</th>
                               <th>팀 1</th>
                               <th>팀 2</th>
                               <th>저장 시각</th>
                           </tr>
                       </thead>
                       <tbody>
                       <%
                           int count = 1;
                           for (Map.Entry<String, List<MatchHistoryDTO>> entry : matchGroups.entrySet()) {
                               String createdAt = entry.getKey();
                               List<MatchHistoryDTO> matches = entry.getValue();

                               // 팀 1과 팀 2 분리
                               List<String> team1Players = new ArrayList<>();
                               List<String> team2Players = new ArrayList<>();

                               for (MatchHistoryDTO match : matches) {
                                   if (match.getTeam() == 1) {
                                       team1Players.add(match.getPlayerName() + " (" + match.getPlayerRank() + ")");
                                   } else if (match.getTeam() == 2) {
                                       team2Players.add(match.getPlayerName() + " (" + match.getPlayerRank() + ")");
                                   }
                               }
                       %>
                       <tr>
                           <td><%= count++ %></td>
                           <td>
                               <% for (String player : team1Players) { %>
                               <div><%= player %></div>
                               <% } %>
                           </td>
                           <td>
                               <% for (String player : team2Players) { %>
                               <div><%= player %></div>
                               <% } %>
                           </td>
                           <td><%= createdAt %></td>
                       </tr>
                       <%
                           }
                           if (matchGroups.isEmpty()) {
                       %>
                       <tr>
                           <td colspan="4" class="text-center">저장된 기록이 없습니다.</td>
                       </tr>
                       <%
                           }
                       %>
                       </tbody>
                   </table>
               </div>
           </div>
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
