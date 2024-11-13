<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>TacticHub</title>
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
  <link rel="stylesheet" href="css/main.css">


  <style>

  </style>
</head>
<body class="bg">
<div class="nav">
  <a href="./">HOME</a>
  <a href="./riotApi.jsp">ABOUT</a>
  <a href="./contact.html">CONTACT</a>
</div>
<div class="main-wrap">
  <div class="container">
    <div class="title">
      <h1>사용자 설정 게임 팀 매칭</h1>
      <p>플레이어의 이름과 랭크를 선택해주세요. <span style="font-weight: bold">TacticHub</span>가 각 팀의 평균 실력을 균등하게 맞춰줍니다.<br>
        5v5 커스텀 게임을 위한 최적의 팀을 간편하게 만들어보세요!</p>
    </div>

    <div class="input_container">
      <label for="player">플레이어</label>
      <input type="text" id="player" name="player" placeholder="닉네임을 입력하세요.">
    </div>
    <div class="rank_container">
      <label>랭크</label>
      <div class="rank_icon">
        <button class="button"  data-rank="Iron" data-value="0"><img src="images/tiers/iron.png" alt="iron" class="rank-icon"></button>
        <button class="button"  data-rank="Bronze" data-value="4"><img src="images/tiers/bronze.png" alt="Bronze" class="rank-icon"></button>
        <button class="button"  data-rank="Silver" data-value="8"><img src="images/tiers/silver.png" alt="Silver" class="rank-icon"></button>
        <button class="button"  data-rank="Gold" data-value="12"><img src="images/tiers/gold.png" alt="Gold" class="rank-icon"></button>
        <button class="button"  data-rank="Platinum" data-value="16"><img src="images/tiers/platinum.png" alt="Platinum" class="rank-icon"></button>
        <button class="button"  data-rank="Emerald" data-value="20"><img src="images/tiers/emerald.png" alt="Emerald" class="rank-icon"></button>
        <button class="button"  data-rank="Diamond" data-value="24"><img src="images/tiers/diamond.png" alt="Diamond" class="rank-icon" id="dia"></button>
        <div class="tier_radio">
          <label>
            <input type="radio" data-tier="I" name="tier" data-value="4">
            <span class="custom-radio"></span>
            <a>I</a>
          </label>
          <label>
            <input type="radio" data-tier="II" name="tier" data-value="3">
            <span class="custom-radio"></span>
            <a>II</a>
          </label>
          <label>
            <input type="radio" data-tier="III" name="tier" data-value="2">
            <span class="custom-radio"></span>
            <a>III</a>
          </label>
          <label>
            <input type="radio" data-tier="IV" name="tier" data-value="1">
            <span class="custom-radio"></span>
            <a>IV</a>
          </label>
        </div>
      </div>
    </div>
    <br>
    <button class="submit" type="button">
      확인
    </button>
    <!-- 플레이어 이름 초기화 버튼 -->
    <button class="reset" type="button">
      초기화
    </button>
    <div class="rst_container">
      <div class="wrap">
        <div class="player_list">
          <input type="text" placeholder="플레이어1">
          <input type="text" placeholder="플레이어2">
          <input type="text" placeholder="플레이어3">
          <input type="text" placeholder="플레이어4">
          <input type="text" placeholder="플레이어5">
        </div>
      </div>
      <div class="wrap">
        <div class="player_list">
          <input type="text" placeholder="플레이어6">
          <input type="text" placeholder="플레이어7">
          <input type="text" placeholder="플레이어8">
          <input type="text" placeholder="플레이어9">
          <input type="text" placeholder="플레이어10">
        </div>
      </div>
    </div>

    <button class="calc" type="button" onClick="">
      팀 구성하기
    </button>
  </div>
</div>

<div class="about">
  <hr style="color:white" width="300px">
  <div class="logic">
      <span>
        <div class="intro"><a>로직에 관해...
          <br>사용자가 랭크에 기반하여 10명의 플레이어 데이터를 입력하고,
          <br>그 데이터를 팀으로 균등하게 나누어주는 기능을 제공합니다.<br></a>
          <div class="point">
            <a>
              <br>1. 먼저, 사용자가 입력한 데이터를 불러온 후, 데이터가 유효한지 검증합니다.
              <br>2. 데이터가 유효하지 않다면 사용자에게 알림을 표시하고, 메인 페이지로 리디렉션합니다.
              <br>3. 그런 다음, 10명의 데이터가 5명씩 나뉘어 2개의 집합이 될 수 있는 모든 경우의 수를 구합니다.
              <br>4. 그렇게 구해진 경우의 수마다 각 팀의 합을 구한 뒤, 두 팀의 스코어 차이가 가장 적은 경우의 수를 선택합니다.
              <br>5. 그렇게 구해진 <em>최적의 경우의 수</em>로 플레이어를 분배합니다.<br><br>
            </a>
          </div>
        </span>
  </div>
</div>

<div class="footer">
  <div class="textbox">
    <a>lol.ps is hosted by PS Analytics
      , Inc. lol.ps isn’t endorsed by Riot Games and doesn’t r
      eflect the views or opinions of Riot Games or anyone officially in
      volved in producing or managing League of Legends. League of Legends and Ri
      ot Games are trademarks or registered trademarks of Riot Games, Inc. League of Legends © Riot Games, Inc.</a>
  </div>

</div>


<script src="./main.js"></script>

</body>
</html>
