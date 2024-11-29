<!DOCTYPE html>
<html>
<head>
    <title>관리자 로그인</title>
</head>
<body>
    <h1>관리자 로그인</h1>
    <form action="admin/login" method="post">
        <label for="id">아이디 (Email):</label>
        <input type="email" id="id" name="id" required><br>

        <label for="password">비밀번호:</label>
        <input type="password" id="password" name="password" required><br>

        <button type="submit">로그인</button>
    </form>
    <c:if test="${not empty error}">
        <p style="color:red;">${error}</p>
    </c:if>
</body>
</html>
