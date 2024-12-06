<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.tactichub.dao.UserDAO" %>
<%@ page import="com.example.tactichub.dto.UserDTO" %>
<%@ page import="java.util.List" %>
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
    </style>
    <script>
        document.addEventListener("DOMContentLoaded", () => {
            // 모든 데이터 행 선택
            const clickableRows = document.querySelectorAll(".clickable-row");

            clickableRows.forEach((row) => {
                row.addEventListener("click", () => {
                    // 클릭된 행 다음에 있는 드롭다운 행 선택
                    const dropdownRow = row.nextElementSibling;

                    // 드롭다운 행 표시/숨기기 토글
                    if (dropdownRow.style.display === "none") {
                        dropdownRow.style.display = "table-row";
                    } else {
                        dropdownRow.style.display = "none";
                    }
                });
            });
        });

        document.addEventListener("DOMContentLoaded", () => {
            // 모든 데이터 행 선택
            const clickableRows = document.querySelectorAll(".clickable-row");

            clickableRows.forEach((row) => {
                row.addEventListener("click", () => {
                    // 클릭된 행 다음에 있는 드롭다운 행 선택
                    const dropdownRow = row.nextElementSibling;

                    // 드롭다운 행 활성화/비활성화
                    dropdownRow.classList.toggle("active");
                });
            });
        });

    </script>

</head>
<body class="m-0 vh-100 d-flex">
<div class="sidebar vh-100 d-flex flex-column justify-between">
    <div>
        <h4 class="fw-bold mb-4 mt-2">관리자 페이지</h4>
        <a href="#" class="menu-item active" data-target="dashboard"><img src="images/dashboard.png" class="me-2 pb-1"
                                                                          alt="dashboard" width="20px">대시보드</a>
        <a href="#" class="menu-item" data-target="user-management"><img src="images/group-fill.png" class="me-2 pb-1"
                                                                         alt="user-management" width="20px">회원 관리</a>
        <a href="#" class="menu-item" data-target="history"><img src="images/bookmark.png" class="me-2 pb-1"
                                                                 alt="history" width="20px">히스토리 조회</a>
        <a href="#" class="menu-item" data-target="api-status"><img src="images/webhook.png" class="me-2 pb-1" alt="api-status" width="20px">API 연동 현황</a>
        <a href="#" class="menu-item" data-target="site-settings"><img src="images/settings.png" class="me-2 pb-1" alt="settings" width="20px">사이트 설정</a>
        <a href="logout.jsp"><img src="images/logout.png" class="me-2 pb-1" alt="logout" width="20px">로그아웃</a>
    </div>
    <div class="mt-auto text-center mb-3">
        <a href="index.jsp" class="logo"><img src="images/TacticHub-Logo.png" alt="Footer Logo" style="width: 80px;"></a>
        <p style="font-size: 12px; color: #818aaa; margin-bottom: 5px;">백엔드 실습 | 5조 | 김호겸, 문정헌, 심재한</p>
    </div>
</div>

<div class="content">
    <!-- 대시보드 -->
    <div id="dashboard" class="content-section active">
        <h4 class="mb-4">대시보드</h4>
        <div class="row">
            <div class="col-md-4">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">총 회원 수</h5>
                        <p class="card-text fs-2">1,234</p>
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
                            <button class="btn btn-success btn-sm">정보 수정</button>
                            <button class="btn btn-danger btn-sm">회원 삭제</button>
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
    <!-- 히스토리 조회 -->
    <div id="history" class="content-section">
        <h4 class="mb-4">히스토리 조회</h4>
        <div class="card">
            <p>특정 회원의 히스토리를 검색하세요.</p>
            <form>
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="회원 닉네임">
                    <button class="btn btn-primary" type="submit">검색</button>
                </div>
            </form>
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

        menuItems.forEach(item => {
            item.addEventListener('click', (e) => {
                e.preventDefault();

                // 메뉴 활성화 처리
                menuItems.forEach(i => i.classList.remove('active'));
                item.classList.add('active');

                // 컨텐츠 표시 처리
                const targetId = item.getAttribute('data-target');
                contentSections.forEach(section => {
                    section.classList.remove('active');
                    if (section.id === targetId) {
                        section.classList.add('active');
                    }
                });
            });
        });
    });
</script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
