package com.example.tactichub;

import com.example.tactichub.dao.MatchHistoryDAO;
import com.example.tactichub.dto.MatchHistoryDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/searchUserHistory")
public class SearchUserHistoryServlet extends HttpServlet {
    private final MatchHistoryDAO matchHistoryDAO = new MatchHistoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String userId = request.getParameter("searchUserId");
        if (userId == null || userId.isEmpty()) {
            response.sendRedirect("admin.jsp"); // 검색어가 없으면 다시 관리자 페이지로 이동
            return;
        }

        List<MatchHistoryDTO> matchHistoryList = matchHistoryDAO.getMatchHistoryByUser(userId);

        // Debugging 출력
        System.out.println("SearchUserHistoryServlet: Setting currentSection to 'history'");
        System.out.println("UserID: " + userId);

        request.setAttribute("currentSection", "history");
        request.setAttribute("matchHistoryList", matchHistoryList);
        request.setAttribute("searchUserId", userId);
        request.getRequestDispatcher("admin.jsp").forward(request, response);
    }
}
