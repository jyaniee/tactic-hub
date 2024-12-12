package com.example.tactichub;

import jakarta.servlet.annotation.WebServlet;
import org.json.JSONArray;
import org.json.JSONObject;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

public class RiotApiService {
    private static final String API_KEY = "RGAPI-fb16e894-dae0-46cf-9fdb-9909c4e2d169";

    public static JSONObject getLeagueInfo(String gameName, String tagLine) throws Exception {
        // Step 1: PUUID 가져오기
        String encodedGameName = URLEncoder.encode(gameName, StandardCharsets.UTF_8);
        String encodedTagLine = URLEncoder.encode(tagLine, StandardCharsets.UTF_8);
        String accountApiUrl = "https://asia.api.riotgames.com/riot/account/v1/accounts/by-riot-id/"
                + encodedGameName + "/" + encodedTagLine + "?api_key=" + API_KEY;

        JSONObject accountJson = (JSONObject) sendApiRequest(accountApiUrl);
        String puuid = accountJson.getString("puuid");

        // Step 2: Summoner ID 가져오기
        String summonerApiUrl = "https://kr.api.riotgames.com/lol/summoner/v4/summoners/by-puuid/"
                + puuid + "?api_key=" + API_KEY;

        JSONObject summonerJson = (JSONObject) sendApiRequest(summonerApiUrl);
        String summonerId = summonerJson.getString("id");

        // Step 3: League 정보 가져오기
        String leagueApiUrl = "https://kr.api.riotgames.com/lol/league/v4/entries/by-summoner/"
                + summonerId + "?api_key=" + API_KEY;

        JSONArray leagueEntries = (JSONArray) sendApiRequest(leagueApiUrl);
        JSONObject selectedEntry = null;

        // 솔로 랭크 우선 조회
        for (int i = 0; i < leagueEntries.length(); i++) {
            JSONObject entry = leagueEntries.getJSONObject(i);
            if ("RANKED_SOLO_5x5".equals(entry.getString("queueType"))) {
                selectedEntry = entry;
                break;
            }
        }

        // 솔로 랭크가 없으면 자유 랭크 조회
        if (selectedEntry == null) {
            for (int i = 0; i < leagueEntries.length(); i++) {
                JSONObject entry = leagueEntries.getJSONObject(i);
                if ("RANKED_FLEX_SR".equals(entry.getString("queueType"))) {
                    selectedEntry = entry;
                    break;
                }
            }
        }

        return selectedEntry != null ? selectedEntry : new JSONObject().put("tier", "Unranked");
    }


    private static Object sendApiRequest(String urlStr) throws Exception {
        URL url = new URL(urlStr);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("User-Agent", "Mozilla/5.0");

        int responseCode = conn.getResponseCode();
        if (responseCode == HttpURLConnection.HTTP_OK) {
            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder response = new StringBuilder();
            String inputLine;
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            String responseString = response.toString();
            System.out.println("API 응답: " + responseString); // 디버깅용 출력

            // 응답이 JSON 배열인지 JSON 객체인지 확인
            if (responseString.startsWith("{")) {
                return new JSONObject(responseString);
            } else if (responseString.startsWith("[")) {
                return new JSONArray(responseString);
            } else {
                throw new Exception("JSON 형식이 아닌 응답: " + responseString);
            }
        } else {
            throw new Exception("API 요청 실패. 응답 코드: " + responseCode);
        }
    }


}
