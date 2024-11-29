<!DOCTYPE html>
<html>
<head>
    <title>회원가입</title>
</head>
<body>
    <h1>회원가입</h1>
    <form action="users" method="post">
        <label for="id">아이디 (Email):</label>
        <input type="email" id="id" name="id" required><br>

        <label for="password">비밀번호:</label>
        <input type="password" id="password" name="password" required><br>

        <label for="lolNicknameTag">롤 닉네임#태그:</label>
        <input type="text" id="lolNicknameTag" name="lolNicknameTag" required><br>

        <label for="siteNickname">사이트 별명:</label>
        <input type="text" id="siteNickname" name="siteNickname" required><br>

        <button type="submit">회원가입</button>
    </form>
    <c:if test="${not empty error}">
        <p style="color:red;">${error}</p>
    </c:if>
</body>
</html>
