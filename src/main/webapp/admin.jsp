<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.tactichub.dao.UserDAO" %>
<%@ page import="com.example.tactichub.dto.UserDTO" %>
<%@ page import="com.example.tactichub.dao.MatchHistoryDAO" %>
<%@ page import="com.example.tactichub.dto.MatchHistoryDTO" %>
<%@ page import="java.util.*" %>
<%
    // UserDAO를 사용하여 모든 회원 정보를 가져옴
    UserDAO userDAO = new UserDAO();
    List<UserDTO> users = null;

    try {
        users = userDAO.getAllUsers();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>회원 정보를 불러오는 중 오류가 발생했습니다.</p>");
    }
%>
<%
    // 검색용 변수 선언
    String searchUserId = request.getParameter("searchUserId");
    List<MatchHistoryDTO> matchHistoryList = null;

    if (searchUserId != null && !searchUserId.isEmpty()) {
        MatchHistoryDAO matchHistoryDAO = new MatchHistoryDAO();
        try {
            matchHistoryList = matchHistoryDAO.getMatchHistoryByUser(searchUserId);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 페이지 - Tactic Hub</title>
    <link rel="icon" type="image/png" href="images/TacticHub-Icon.png">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/admin.css">
    <style>
        .content-section {
            display: none;
        }
        .content-section.active {
            display: block;
        }
        .dropdown-content {
            display: none; /* 기본적으로 숨김 */
            background-color: #f9f9f9;
            border: 1px solid #ccc;
            padding: 10px;
            border-radius: 5px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            position: absolute;
            z-index: 1;
            width: 300px; /* 드롭다운 너비 */
        }

    </style>
    <script>
        document.addEventListener("DOMContentLoaded", () => {
            const refreshButton = document.querySelector(".refresh-button");

            refreshButton.addEventListener("click", () => {
                // AJAX 요청을 통해 회원 데이터를 가져옴
                fetch("<%= request.getContextPath() %>/fetchUsers", {
                    method: "GET"
                })
                    .then(response => response.text())
                    .then(data => {
                        // 서버로부터 받은 HTML을 테이블의 tbody에 삽입
                        const userTableBody = document.querySelector(".custom-table tbody");
                        userTableBody.innerHTML = data;

                        // 새로 추가된 버튼 및 행에 이벤트 리스너 다시 연결
                        attachEventListeners();
                    })
                    .catch(error => {
                        console.error("회원 데이터를 불러오는 중 오류 발생:", error);
                    });
            });

            function attachEventListeners() {
                // 행 클릭 이벤트
                const clickableRows = document.querySelectorAll(".clickable-row");

                clickableRows.forEach((row) => {
                    row.addEventListener("click", () => {
                        const dropdownRow = row.nextElementSibling;
                        dropdownRow.style.display = dropdownRow.style.display === "none" ? "table-row" : "none";
                    });
                });

                // 정보 수정 버튼 이벤트
                const updateButtons = document.querySelectorAll(".update");

                updateButtons.forEach((button) => {
                    button.addEventListener("click", () => {
                        const dropdownContent = button.nextElementSibling;
                        dropdownContent.style.display = dropdownContent.style.display === "none" || dropdownContent.style.display === "" ? "block" : "none";
                    });
                });

                // 취소 버튼 이벤트
                const cancelButtons = document.querySelectorAll(".cancel-button");

                cancelButtons.forEach((button) => {
                    button.addEventListener("click", (event) => {
                        const dropdownContent = event.target.closest(".dropdown-content");
                        dropdownContent.style.display = "none";
                    });
                });
            }

            // 초기 로드 시 이벤트 리스너 연결
            attachEventListeners();
        });



        document.addEventListener("DOMContentLoaded", () => {
            const menuItems = document.querySelectorAll('.menu-item');
            const contentSections = document.querySelectorAll('.content-section');

            // JSP에서 currentSection 값 가져오기
            const currentSection = "<%= request.getAttribute("currentSection") != null ? request.getAttribute("currentSection") : "dashboard" %>";
            console.log("Current Section from JSP: ", currentSection);

            // 현재 섹션 활성화
            menuItems.forEach(item => {
                const targetId = item.getAttribute('data-target');
                if (targetId === currentSection) {
                    item.classList.add('active');
                } else {
                    item.classList.remove('active');
                }
            });

            contentSections.forEach(section => {
                if (section.id === currentSection) {
                    section.classList.add('active');
                } else {
                    section.classList.remove('active');
                }
            });
        });


    </script>
    <%
        String currentSection = (String) request.getAttribute("currentSection");
        if (currentSection == null) {
            System.out.println("Current Section is null in JSP");
        } else {
            System.out.println("Current Section in JSP: " + currentSection);
        }
    %>
    <%
        // DAO를 통해 총 회원 수를 가져옴
        int totalUsers = 0;
        try {
            totalUsers = userDAO.getTotalUserCount();
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</head>
<body class="m-0 vh-100 d-flex">
<div class="sidebar vh-100 d-flex flex-column justify-between">
    <div>
        <h4 class="fw-bold mb-4 mt-2">관리자 페이지</h4>
        <a href="#" class="menu-item <%= "dashboard".equals(request.getAttribute("currentSection")) ? "active" : "" %>" data-target="dashboard">
            <img src="images/dashboard.png" class="me-2 pb-1" alt="dashboard" width="20px">대시보드
        </a>
        <a href="#" class="menu-item <%= "user-management".equals(request.getAttribute("currentSection")) ? "active" : "" %>" data-target="user-management">
            <img src="images/group-fill.png" class="me-2 pb-1" alt="user-management" width="20px">회원 관리
        </a>
        <a href="#" class="menu-item <%= "history".equals(request.getAttribute("currentSection")) ? "active" : "" %>" data-target="history">
            <img src="images/bookmark.png" class="me-2 pb-1" alt="history" width="20px">히스토리 조회
        </a>
        <a href="#" class="menu-item <%= "api-status".equals(request.getAttribute("currentSection")) ? "active" : "" %>" data-target="api-status">
            <img src="images/webhook.png" class="me-2 pb-1" alt="api-status" width="20px">API 연동 현황
        </a>
        <a href="#" class="menu-item <%= "site-settings".equals(request.getAttribute("currentSection")) ? "active" : "" %>" data-target="site-settings">
            <img src="images/settings.png" class="me-2 pb-1" alt="settings" width="20px">사이트 설정
        </a>
        <a href="logout.jsp"><img src="images/logout.png" class="me-2 pb-1" alt="logout" width="20px">로그아웃</a>
    </div>
    <div class="mt-auto text-center mb-3">
        <a href="index.jsp" class="logo"><img src="images/TacticHub-Logo.png" alt="Footer Logo" style="width: 80px;"></a>
        <p style="font-size: 12px; color: #818aaa; margin-bottom: 5px;">백엔드 실습 | 5조 | 김호겸, 문정헌, 심재한</p>
    </div>
</div>

<div class="content">
    <!-- 대시보드 -->
    <div id="dashboard" class="content-section">
        <h4 class="mb-4">대시보드</h4>
        <div class="row">
            <div class="col-md-4">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">총 회원 수</h5>
                        <p class="card-text fs-2"><%= totalUsers %></p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">오늘 팀 구성 요청</h5>
                        <p class="card-text fs-2">56</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">API 호출 성공률</h5>
                        <p class="card-text fs-2">98%</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- 회원 관리 -->
    <div id="user-management" class="content-section">
        <h4 class="mb-4">회원 관리</h4>
        <div>
            <div class="table-responsive custom-table-responsive">
                <a class="text-end refresh-button"><img src="images/refresh.png" alt="refresh" width="50px"></a>
                <table class="table custom-table">
                    <thead>
                    <tr>
                        <th scope="col">아이디</th>
                        <th scope="col">패스워드</th>
                        <th scope="col">LOL 닉네임</th>
                        <th scope="col">사이트 닉네임</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        if (users == null || users.isEmpty()) {
                    %>
                    <tr>
                        <td colspan="5" class="text-center">회원 정보가 없습니다.</td>
                    </tr>
                    <%
                    } else {
                        for (UserDTO user : users) {
                    %>
                    <tr class="clickable-row" style="cursor: pointer;">
                        <td><%= user.getId() %></td>
                        <td><%= user.getPassword() %></td>
                        <td><%= user.getLolNicknameTag() %></td>
                        <td><%= user.getSiteNickname() %></td>
                    </tr>
                    <tr class="dropdown-row" style="display: none;">
                        <td colspan="5" class="text-end">
                            <div style="display: flex; justify-content: flex-end; gap: 10px;">
                                <!-- "정보 수정" 버튼 -->
                                <button class="btn btn-success btn-sm update">정보 수정</button>

                                <!-- 드롭다운 영역 -->
                                <div class="dropdown-content" style="display: none; margin-top: 10px;">
                                    <form action="<%= request.getContextPath() %>/updateUser" method="post">
                                        <input type="hidden" name="userId" value="<%= user.getId() %>"> <!-- 사용자 ID -->
                                        <div class="input-group mb-1">
                                            <input type="text" class="form-control" name="password" placeholder="패스워드 수정" value="<%= user.getPassword() %>">
                                        </div>
                                        <div class="input-group mb-1">
                                            <input type="text" class="form-control" name="lolNickname" placeholder="LOL 닉네임 수정" value="<%= user.getLolNicknameTag() %>">
                                        </div>
                                        <div class="input-group mb-1">
                                            <input type="text" class="form-control" name="siteNickname" placeholder="사이트 닉네임 수정" value="<%= user.getSiteNickname() %>">
                                        </div>
                                        <button type="submit" class="btn btn-success btn-sm save-button">저장</button>
                                        <button type="button" class="btn btn-secondary btn-sm cancel-button">취소</button>
                                    </form>

                                </div>

                                <!-- "회원 삭제" 버튼 -->
                                <form action="<%= request.getContextPath() %>/deleteUser" method="post">
                                    <input type="hidden" name="userId" value="<%= user.getId() %>">
                                    <button type="submit" class="btn btn-danger btn-sm delete">회원 삭제</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                    <tr class="spacer"><td colspan="100"></td></tr>
                    <%
                            }
                        }
                    %>
                    </tbody>

                </table>
            </div>

        </div>


    </div>

<div class="content">
    <!-- 히스토리 조회 -->

    <div id="history" class="content-section active">
        <h4 class="mb-4">히스토리 조회</h4>
        <div class="card mb-4">
            <form action="searchUserHistory" method="get">
                <div class="input-group mb-3">
                    <input type="text" name="searchUserId" class="form-control" placeholder="회원 ID를 입력하세요" value="<%= searchUserId != null ? searchUserId : "" %>">
                    <button class="btn btn-primary" type="submit">검색</button>
                </div>
            </form>

        </div>

        <% if (searchUserId != null && !searchUserId.isEmpty()) { %>
        <div class="card">
            <h5 class="card-header">검색 결과: <%= searchUserId %></h5>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>팀1</th>
                        <th>팀2</th>
                        <th>저장 시각</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        if (matchHistoryList != null && !matchHistoryList.isEmpty()) {
                            Map<String, Map<Integer, List<MatchHistoryDTO>>> groupedMatchHistories = new LinkedHashMap<>();

                            // 데이터를 createdAt 기준으로 팀별로 그룹화
                            for (MatchHistoryDTO history : matchHistoryList) {
                                String createdAt = history.getCreatedAt();
                                groupedMatchHistories.putIfAbsent(createdAt, new HashMap<>());
                                groupedMatchHistories.get(createdAt).putIfAbsent(history.getTeam(), new ArrayList<>());
                                groupedMatchHistories.get(createdAt).get(history.getTeam()).add(history);
                            }

                            int count = 1;
                            for (Map.Entry<String, Map<Integer, List<MatchHistoryDTO>>> entry : groupedMatchHistories.entrySet()) {
                                String createdAt = entry.getKey();
                                Map<Integer, List<MatchHistoryDTO>> teams = entry.getValue();

                                // 팀별 플레이어 정보
                                List<MatchHistoryDTO> team1 = teams.getOrDefault(1, new ArrayList<>());
                                List<MatchHistoryDTO> team2 = teams.getOrDefault(2, new ArrayList<>());

                    %>
                    <tr>
                        <td><%= count++ %></td>
                        <td>
                            <% for (MatchHistoryDTO player : team1) { %>
                            <div><%= player.getPlayerName() %> (<%= player.getPlayerRank() %>)</div>
                            <% } %>
                        </td>
                        <td>
                            <% for (MatchHistoryDTO player : team2) { %>
                            <div><%= player.getPlayerName() %> (<%= player.getPlayerRank() %>)</div>
                            <% } %>
                        </td>
                        <td><%= createdAt %></td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="4" class="text-center">검색 결과가 없습니다.</td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
        <% } %>

    </div>
</div>

    <!-- API 연동 현황 -->
    <div id="api-status" class="content-section">
        <h4 class="mb-4">API 연동 현황</h4>
        <div class="card">
            <table class="table table-striped">
                <thead class="table-dark">
                <tr>
                    <th>API 이름</th>
                    <th>상태</th>
                    <th>마지막 호출</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>라이엇 API</td>
                    <td><span class="badge bg-success">정상</span></td>
                    <td>2024-11-28 14:23</td>
                </tr>
                </tbody>
            </table>
            <h2>Riot API 테스트</h2>
            <p>현재 설정된 API Key: <strong>RGAPI-efdd7a01-a4b8-4f75-af75-a3f303bc1e82</strong></p>
            <h3>API Key 설정</h3>
            <form method="post">
                <label for="newApiKey" class="form-label">새 API Key 입력:</label>
                <input type="text" id="newApiKey" name="apiKey" class="form-control" required>
                <button type="submit" class="btn btn-primary mt-2">API Key 갱신</button>
            </form>
            <hr>
            <form method="post">
                닉네임: <input type="text" name="gameName" required><br>
                태그: <input type="text" name="tagLine" required><br>
                <button type="submit">제출</button>
            </form>
        </div>

    </div>
    <!-- 사이트 설정 -->
    <div id="site-settings" class="content-section">
        <h4 class="mb-4">사이트 설정</h4>
        <div class="card">
            <form>
                <div class="mb-3">
                    <label for="site-name" class="form-label">사이트 이름</label>
                    <input type="text" id="site-name" class="form-control" value="Tactic Hub">
                </div>
                <div class="mb-3">
                    <label for="maintenance-mode" class="form-label">유지보수 모드</label>
                    <select id="maintenance-mode" class="form-select">
                        <option value="off" selected>비활성화</option>
                        <option value="on">활성화</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">저장</button>
            </form>
        </div>

    </div>
</div>

<!-- JavaScript -->
<script>
    document.addEventListener("DOMContentLoaded", () => {
        const menuItems = document.querySelectorAll('.menu-item');
        const contentSections = document.querySelectorAll('.content-section');

        // 서버에서 전달된 현재 섹션 가져오기
        const currentSection = "<%= request.getAttribute("currentSection") != null ? request.getAttribute("currentSection") : "dashboard" %>";

        // 현재 섹션 활성화
        menuItems.forEach(item => {
            item.addEventListener('click', () => {
                const targetId = item.getAttribute('data-target');

                // 모든 메뉴와 섹션에서 active 제거
                menuItems.forEach(menu => menu.classList.remove('active'));
                contentSections.forEach(section => section.classList.remove('active'));

                // 클릭된 메뉴와 타겟 섹션에 active 추가
                item.classList.add('active');
                document.getElementById(targetId).classList.add('active');
            });
        });


        contentSections.forEach(section => {
            if (section.id === currentSection) {
                section.classList.add('active');
            } else {
                section.classList.remove('active');
            }
        });
    });

</script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>