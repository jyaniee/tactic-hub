package com.example.tactichub;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.json.JSONObject;

import java.io.IOException;

@WebServlet("/mypage")
public class MyPageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();

            String email = (String) session.getAttribute("email");
            System.out.println("Session email: " + email);

            if(email == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            String lolNicknameTag = null;

            try (Connection conn = DatabaseConnection.getConnection()){
                String sql = "select lol_nickname_tag from users where id = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, email);

                ResultSet rs = ps.executeQuery();
                if(rs.next()) {
                    lolNicknameTag = rs.getString("lol_nickname_tag");
                    System.out.println("Found lol_nickname_tag: " + lolNicknameTag);
                }else {
                    System.out.println("No result found for email: " + email);
                }
            }catch (Exception e) {
                e.printStackTrace();
                response.getWriter().println("데이터베이스 오류: "+e.getMessage());
                return;
            }

            if (lolNicknameTag != null) {
                session.setAttribute("lolNicknameTag", lolNicknameTag);
                String[] split = lolNicknameTag.split("#");
                String gameName = split[0];
                String tagLine = split[1];

                // Riot API 호출
                JSONObject rankInfo = RiotApiService.getLeagueInfo(gameName, tagLine);
                session.setAttribute("rankInfo", rankInfo); // 세션에 저장
            }
            request.getRequestDispatcher("mypage.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("<p>오류 발생: " + e.getMessage() + "</p>");
        }
    }
}
