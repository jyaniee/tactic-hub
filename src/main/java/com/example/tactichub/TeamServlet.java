package com.example.tactichub;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.*;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

@WebServlet("/TeamServlet")
public class TeamServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // JSON 데이터를 읽기
        BufferedReader reader = req.getReader();
        String jsonData = reader.readLine();
        
        // JSON 데이터를 Java 객체로 변환
        Gson gson = new Gson();
        List<Map<String, String>> playerData = gson.fromJson(jsonData, new TypeToken<List<Map<String, String>>>() {}.getType());

        // 총 점수 계산
        int totalScore = playerData.stream().mapToInt(player ->
                Integer.parseInt(player.get("rankValue")) + Integer.parseInt(player.get("tierValue"))
        ).sum();

        // 가능한 조합 생성
        List<List<Map<String, String>>> combinations = getCombinations(playerData, 5);

        // 목표 점수 계산 (총 점수의 절반)
        int targetScore = totalScore / 2;

        // 가장 가까운 조합 찾기
        List<Map<String, String>> closestCombination = findClosestCombination(combinations, targetScore);

        // 나머지 플레이어를 다른 팀으로 할당
        List<Map<String, String>> otherTeam = new ArrayList<>(playerData);
        otherTeam.removeAll(closestCombination);

        // 결과 JSON 생성
        Map<String, Object> result = new HashMap<>();
        result.put("team1", closestCombination);
        result.put("team2", otherTeam);

        resp.setContentType("application/json");
        resp.getWriter().write(gson.toJson(result));
    }

    // 가능한 조합 생성
    private List<List<Map<String, String>>> getCombinations(List<Map<String, String>> players, int size) {
        List<List<Map<String, String>>> combinations = new ArrayList<>();
        combinationHelper(players, new ArrayList<>(), combinations, size, 0);
        return combinations;
    }

    private void combinationHelper(List<Map<String, String>> players, List<Map<String, String>> current,
                                   List<List<Map<String, String>>> combinations, int size, int index) {
        if (current.size() == size) {
            combinations.add(new ArrayList<>(current));
            return;
        }

        for (int i = index; i < players.size(); i++) {
            current.add(players.get(i));
            combinationHelper(players, current, combinations, size, i + 1);
            current.remove(current.size() - 1);
        }
    }

    // 가장 가까운 조합 찾기
    private List<Map<String, String>> findClosestCombination(List<List<Map<String, String>>> combinations, int target) {
        int minDifference = Integer.MAX_VALUE;
        List<Map<String, String>> closest = null;

        for (List<Map<String, String>> combination : combinations) {
            int score = combination.stream().mapToInt(player ->
                    Integer.parseInt(player.get("rankValue")) + Integer.parseInt(player.get("tierValue"))
            ).sum();

            int difference = Math.abs(target - score);
            if (difference < minDifference) {
                minDifference = difference;
                closest = combination;
            }
        }
        return closest;
    }
}
