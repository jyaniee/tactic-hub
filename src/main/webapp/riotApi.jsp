<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>Riot API 요청 예제 - 입력 페이지</title>
</head>
<body>
<h1>Riot API 닉네임#태그 입력</h1>
<form method="post" action="riotApiRs.jsp">
  닉네임: <input type="text" name="gameName" required><br>
  태그: <input type="text" name="tagLine" required><br>
  <button type="submit">제출</button>
</form>
</body>
</html>
