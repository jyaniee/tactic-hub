package com.example.tactichub;

import com.example.tactichub.dao.MatchHistoryDAO;
import com.example.tactichub.dto.MatchHistoryDTO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/saveMatchHistory")
public class SaveMatchHistoryServlet extends HttpServlet {
    private final MatchHistoryDAO matchHistoryDAO = new MatchHistoryDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("email");
        String team1 = request.getParameter("team1");
        String team2 = request.getParameter("team2");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        MatchHistoryDTO matchHistory = new MatchHistoryDTO(0, userId, team1, team2, null);
        boolean isSaved = matchHistoryDAO.saveMatchHistory(matchHistory);

        if (isSaved) {
            response.sendRedirect("mypage.jsp?success=true");
        } else {
            response.sendRedirect("result.jsp?error=true");
        }
    }
}
