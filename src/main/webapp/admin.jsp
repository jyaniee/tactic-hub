<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 페이지 - Tactic Hub</title>
    <link rel="icon" type="image/png" href="images/TacticHub-Icon.png">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Apple SD Gothic Neo', 'Noto Sans KR', sans-serif;
            background-color: #f8f9fa;
            overflow: hidden; /* 스크롤 제거 */
        }
        .sidebar {
            height: 100vh;
            width: 250px;
            background-color: #343a40;
            position: fixed;
            top: 0;
            left: 0;
            padding: 15px;
            z-index: 1000;
        }
        .sidebar a {
            color: white;
            text-decoration: none;
            font-size: 1.1rem;
            margin-bottom: 10px;
            display: block;
        }
        .sidebar a:hover,
        .sidebar a.active {
            background-color: #495057;
            border-radius: 5px;
            padding-left: 10px;
        }
        .content-container {
            margin-left: 250px;
            height: 100vh;
            overflow: hidden;
            position: relative;
        }
        .section {
            height: 100%;
            display: none;
            padding: 20px;
        }
        .section.active {
            display: block;
        }
        .card {
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
<div class="d-flex">
    <!-- 사이드바 -->
    <nav class="sidebar d-flex flex-column">
        <h4 class="text-white text-center mb-4">관리자 페이지</h4>
        <a href="#dashboard" class="menu-link active" data-section="dashboard">대시보드</a>
        <a href="#user-management" class="menu-link" data-section="user-management">회원 관리</a>
        <a href="#history" class="menu-link" data-section="history">히스토리 조회</a>
        <a href="#api-status" class="menu-link" data-section="api-status">API 연동 현황</a>
        <a href="#site-settings" class="menu-link" data-section="site-settings">사이트 설정</a>
    </nav>

    <!-- 메인 컨텐츠 -->
    <div class="content-container">
        <!-- 대시보드 -->
        <section id="dashboard" class="section active">
            <h1 class="mb-4">대시보드</h1>
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
        </section>

        <!-- 회원 관리 -->
        <section id="user-management" class="section">
            <h1 class="mb-4">회원 관리</h1>
            <table class="table table-striped">
                <thead class="table-dark">
                <tr>
                    <th>#</th>
                    <th>닉네임</th>
                    <th>이메일</th>
                    <th>가입일</th>
                    <th>액션</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>1</td>
                    <td>홍길동</td>
                    <td>hong@example.com</td>
                    <td>2024-11-01</td>
                    <td><button class="btn btn-danger btn-sm">삭제</button></td>
                </tr>
                </tbody>
            </table>
        </section>

        <!-- 히스토리 조회 -->
        <section id="history" class="section">
            <h1 class="mb-4">히스토리 조회</h1>
            <p>특정 회원의 히스토리를 검색하세요.</p>
            <form>
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="회원 닉네임">
                    <button class="btn btn-primary" type="submit">검색</button>
                </div>
            </form>
        </section>

        <!-- API 연동 현황 -->
        <section id="api-status" class="section">
            <h1 class="mb-4">API 연동 현황</h1>
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
            <a>Riot API 닉네임#태그 입력</a>
            <form method="post">
                닉네임: <input type="text" name="gameName" required><br>
                태그: <input type="text" name="tagLine" required><br>
                <button type="submit">제출</button>
            </form>
            <%@ include file="riotApiRs.jsp"%>
        </section>

        <!-- 사이트 설정 -->
        <section id="site-settings" class="section">
            <h1 class="mb-4">사이트 설정</h1>
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
        </section>
    </div>
</div>

<!-- JavaScript -->
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const links = document.querySelectorAll(".menu-link");
        const sections = document.querySelectorAll(".section");

        links.forEach(link => {
            link.addEventListener("click", (e) => {
                e.preventDefault();

                // 모든 링크에서 활성화 제거
                links.forEach(link => link.classList.remove("active"));
                // 클릭된 링크 활성화
                link.classList.add("active");

                // 모든 섹션 숨기기
                sections.forEach(section => section.classList.remove("active"));
                // 클릭된 섹션 표시
                const targetSection = document.getElementById(link.dataset.section);
                targetSection.classList.add("active");
            });
        });
    });
</script>
</body>
</html>
