package com.example.tactichub;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONObject;

import java.io.IOException;

@WebServlet("/riotApiService")
public class RiotApiServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            // 클라이언트에서 요청한 파라미터 받기
            String gameName = request.getParameter("gameName");
            String tagLine = request.getParameter("tagLine");

            if (gameName == null || tagLine == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\": \"gameName and tagLine are required\"}");
                return;
            }

            // Riot API 호출
            JSONObject leagueInfo = RiotApiService.getLeagueInfo(gameName, tagLine);

            if (leagueInfo == null) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"error\": \"Player not found or no rank data available\"}");
                return;
            }

            // 성공적으로 데이터를 가져온 경우 클라이언트에 반환
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write(leagueInfo.toString());

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"An error occurred while fetching data\"}");
        }
    }
}
