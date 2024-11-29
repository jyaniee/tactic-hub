<!DOCTYPE html>
<html>
<head>
    <title>사용자 목록</title>
</head>
<body>
    <h1>사용자 목록</h1>
    <table border="1">
        <tr>
            <th>아이디 (Email)</th>
            <th>롤 닉네임#태그</th>
            <th>사이트 별명</th>
        </tr>
        <c:forEach var="user" items="${users}">
            <tr>
                <td>${user.id}</td>
                <td>${user.lolNicknameTag}</td>
                <td>${user.siteNickname}</td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
