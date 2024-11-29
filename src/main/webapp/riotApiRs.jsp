<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.BufferedReader, java.io.InputStreamReader, java.net.HttpURLConnection, java.net.URL" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page import="org.json.JSONArray" %>

<h3>Riot API 요청 결과</h3>
<%
    request.setCharacterEncoding("UTF-8");
    // 사용자 입력 값 가져오기
    String gameName = request.getParameter("gameName");
    String tagLine = request.getParameter("tagLine");

    if (gameName != null && tagLine != null) {
        try {
            // Riot API 키 설정
            String apiKey = (String) application.getAttribute("apiKey");
            if (apiKey == null || apiKey.isEmpty()) {
                apiKey = "RGAPI-efdd7a01-a4b8-4f75-af75-a3f303bc1e82"; // 기본값 설정
                out.println("<p style='color: red;'>API Key가 설정되지 않았습니다. 기본 API Key를 사용합니다.</p>");
            }

            // 랭크 정보 가져오는 법: ACCOUNT-V1 -> SUMMONER-V4 -> LEAGUE-V4 순으로 3번 요청해야함. 2024-11-13 기준
            // 1. ACCOUNT-V1에선 닉네임과 태그로 puuid를 가져오고,
            // 2. SUMMONER-V4에서 puuid로 summonerId를 가져오고,
            // 3. LEAGUE-V4에서 summonerId로 랭크 정보를 가져올 수 있음.
            // 1단계: Account-V1 API를 사용해 PUUID 가져옴
            String encodedGameName = URLEncoder.encode(gameName, StandardCharsets.UTF_8);
            String encodedTagLine = URLEncoder.encode(tagLine, StandardCharsets.UTF_8);

            // 디버깅용 출력
            out.println("original: " + gameName + "#" + tagLine + "<br>");
            out.println("encoded: " + encodedGameName + "#" + encodedTagLine + "<br>");

            String accountApiUrl = "https://asia.api.riotgames.com/riot/account/v1/accounts/by-riot-id/"
                    + encodedGameName + "/" + encodedTagLine + "?api_key=" + apiKey;

            // URL과 헤더 설정
            URL accountUrl = new URL(accountApiUrl);
            HttpURLConnection accountConn = (HttpURLConnection) accountUrl.openConnection();
            accountConn.setRequestMethod("GET");
            accountConn.setRequestProperty("User-Agent", "Mozilla/5.0");

            int accountResponseCode = accountConn.getResponseCode();
            if (accountResponseCode == HttpURLConnection.HTTP_OK) {
                BufferedReader accountIn = new BufferedReader(new InputStreamReader(accountConn.getInputStream()));
                StringBuilder accountResponse = new StringBuilder();
                String accountInputLine;
                while ((accountInputLine = accountIn.readLine()) != null) {
                    accountResponse.append(accountInputLine);
                }
                accountIn.close();

                JSONObject accountJson = new JSONObject(accountResponse.toString());
                String puuid = accountJson.getString("puuid");

                // 디버깅용 출력
                out.println("puuid: " + puuid + "<br>");

                // 2단계: Summoner-V4 API를 사용해 Summoner ID 가져옴
                String summonerApiUrl = "https://kr.api.riotgames.com/lol/summoner/v4/summoners/by-puuid/"
                        + puuid + "?api_key=" + apiKey;

                URL summonerUrl = new URL(summonerApiUrl);
                HttpURLConnection summonerConn = (HttpURLConnection) summonerUrl.openConnection();
                summonerConn.setRequestMethod("GET");
                summonerConn.setRequestProperty("User-Agent", "Mozilla/5.0");

                int summonerResponseCode = summonerConn.getResponseCode();
                if (summonerResponseCode == HttpURLConnection.HTTP_OK) {
                    BufferedReader summonerIn = new BufferedReader(new InputStreamReader(summonerConn.getInputStream()));
                    StringBuilder summonerResponse = new StringBuilder();
                    String summonerInputLine;
                    while ((summonerInputLine = summonerIn.readLine()) != null) {
                        summonerResponse.append(summonerInputLine);
                    }
                    summonerIn.close();

                    JSONObject summonerJson = new JSONObject(summonerResponse.toString());
                    String summonerId = summonerJson.getString("id");

                    // 디버깅용 출력
                    out.println("summonerId: " + summonerId + "<br>");
                    out.println("여기까지 디버깅용 출력임 <br>");

                    // 3단계: League-V4 API를 사용해 랭크 정보 가져옴
                    String leagueApiUrl = "https://kr.api.riotgames.com/lol/league/v4/entries/by-summoner/"
                            + summonerId + "?api_key=" + apiKey;

                    URL leagueUrl = new URL(leagueApiUrl);
                    HttpURLConnection leagueConn = (HttpURLConnection) leagueUrl.openConnection();
                    leagueConn.setRequestMethod("GET");
                    leagueConn.setRequestProperty("User-Agent", "Mozilla/5.0");

                    int leagueResponseCode = leagueConn.getResponseCode();
                    if (leagueResponseCode == HttpURLConnection.HTTP_OK) {
                        BufferedReader leagueIn = new BufferedReader(new InputStreamReader(leagueConn.getInputStream()));
                        StringBuilder leagueResponse = new StringBuilder();
                        String leagueInputLine;
                        while ((leagueInputLine = leagueIn.readLine()) != null) {
                            leagueResponse.append(leagueInputLine);
                        }
                        leagueIn.close();

                        // JSON 응답에서 랭크 정보 파싱
                        JSONArray leagueEntries = new JSONArray(leagueResponse.toString());
                        JSONObject selectedEntry = null;

                        // 우선 솔로 랭크 정보를 찾음
                        for (int i = 0; i < leagueEntries.length(); i++) {
                            JSONObject entry = leagueEntries.getJSONObject(i);
                            if ("RANKED_SOLO_5x5".equals(entry.getString("queueType"))) {
                                selectedEntry = entry;
                                break;
                            }
                        }

                        // 솔로 랭크 정보가 없을 경우 자유 랭크 정보를 찾음
                        if (selectedEntry == null) {
                            for (int i = 0; i < leagueEntries.length(); i++) {
                                JSONObject entry = leagueEntries.getJSONObject(i);
                                if ("RANKED_FLEX_SR".equals(entry.getString("queueType"))) {
                                    selectedEntry = entry;
                                    break;
                                }
                            }
                        }

                        // 선택된 랭크 정보를 출력
                        if (selectedEntry != null) {
                            String tier = selectedEntry.getString("tier");
                            String rank = selectedEntry.getString("rank");
                            int leaguePoints = selectedEntry.getInt("leaguePoints");
                            int wins = selectedEntry.getInt("wins");
                            int losses = selectedEntry.getInt("losses");
                            String queueType = selectedEntry.getString("queueType");
                            if (queueType.equals("RANKED_SOLO_5x5")){
                                out.println("<h3>개인/2인 랭크 게임</h3>");
                            }else {
                                out.println("<h3>자유 랭크 게임</h3>");
                            }
                            out.println("티어: " + tier + " " + rank + " ");
                            out.println(leaguePoints + "LP <br>");
                            out.println(wins + "승" + losses + "패 <br>");
                        } else {
                            out.println("<h3>랭크 정보:</h3>");
                            out.println("해당 서머너의 랭크 정보가 없습니다.");
                        }
                    } else {
                        out.println("LEAGUE-V4 API 요청에 실패했습니다. 응답 코드: " + leagueResponseCode);
                    }
                } else {
                    out.println("SUMMONER-V4 API 요청에 실패했습니다. 응답 코드: " + summonerResponseCode);
                }
            } else {
                out.println("ACCOUNT-V1 API 요청에 실패했습니다. 응답 코드: " + accountResponseCode);
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("오류가 발생했습니다: " + e.getMessage() + "<br>");
        }
    }
%>