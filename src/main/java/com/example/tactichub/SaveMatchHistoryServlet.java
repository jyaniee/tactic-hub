package com.example.tactichub;

import com.example.tactichub.dao.MatchHistoryDAO;
import com.example.tactichub.dto.MatchHistoryDTO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/saveMatchHistory")
public class SaveMatchHistoryServlet extends HttpServlet {
    private final MatchHistoryDAO matchHistoryDAO = new MatchHistoryDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("email");
        String team1Data = request.getParameter("team1"); // "player1 (rank), player2 (rank)"
        String team2Data = request.getParameter("team2");

        response.setContentType("text/plain; charset=UTF-8"); // 또는 "application/json; charset=UTF-8" 사용 가능

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<MatchHistoryDTO> matchHistories = new ArrayList<>();
        processTeamData(team1Data, 1, userId, matchHistories); // 팀 1 저장
        processTeamData(team2Data, 2, userId, matchHistories); // 팀 2 저장

        boolean isSaved = matchHistoryDAO.saveMatchHistory(matchHistories);
        if (isSaved) {
            response.setStatus(HttpServletResponse.SC_OK); // 성공 상태 코드 반환
            response.getWriter().write("Success");

        } else {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 실패 상태 코드 반환
            response.getWriter().write("Error");
        }
    }

    private void processTeamData(String teamData, int teamNumber, String userId, List<MatchHistoryDTO> matchHistories) {
        String[] players = teamData.split(", ");
        for (String player : players) {
            String[] details = player.split(" \\("); // 이름과 랭크 구분
            String playerName = details[0];
            String rank = details[1].replace(")", ""); // 괄호 제거
            matchHistories.add(new MatchHistoryDTO(0, userId, teamNumber, playerName, rank, null));
        }
    }
}
