package com.example.tactichub;

/* import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/TeamServlet")
public class TeamServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
       BufferedReader reader = req.getReader();
        String jsonData = reader.readLine();
         Gson gson = new Gson();

        List<Map<String, String>> playerData = gson.fromJson(jsonData, new TypeToken<List<Map<String, String>>>() {}.getType());

        // 팀 구성 로직 처리
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        Map<String, Object> responseData = new HashMap<>();
        responseData.put("status", "success");
        responseData.put("message", "팀 구성이 완료되었습니다!");

        resp.getWriter().write(gson.toJson(responseData));
    }
}
*/