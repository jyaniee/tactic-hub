package com.example.tactichub.controller;

import com.example.tactichub.dao.UserDAO;
import com.example.tactichub.dto.UserDTO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/fetchUsers")
public class FetchUsersController extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=UTF-8");

        try {
            // 모든 회원 데이터를 가져옴
            List<UserDTO> users = userDAO.getAllUsers();

            // HTML 형식으로 응답 생성
            StringBuilder responseHtml = new StringBuilder();

            for (UserDTO user : users) {
                responseHtml.append("<tr class='clickable-row' style='cursor: pointer;'>")
                        .append("<td>").append(user.getId()).append("</td>")
                        .append("<td>").append(user.getPassword()).append("</td>")
                        .append("<td>").append(user.getLolNicknameTag()).append("</td>")
                        .append("<td>").append(user.getSiteNickname()).append("</td>")
                        .append("</tr>")
                        .append("<tr class='dropdown-row' style='display: none;'>")
                        .append("<td colspan='5' class='text-end'>")
                        .append("<div style='display: flex; justify-content: flex-end; gap: 10px;'>")
                        .append("<button class='btn btn-success btn-sm update'>정보 수정</button>")
                        .append("<div class='dropdown-content' style='display: none; margin-top: 10px;'>")
                        .append("<form action='updateUser' method='post'>")
                        .append("<input type='hidden' name='userId' value='").append(user.getId()).append("'>")
                        .append("<div class='input-group mb-1'>")
                        .append("<input type='text' class='form-control' name='password' placeholder='패스워드 수정' value='").append(user.getPassword()).append("'>")
                        .append("</div>")
                        .append("<div class='input-group mb-1'>")
                        .append("<input type='text' class='form-control' name='lolNickname' placeholder='LOL 닉네임 수정' value='").append(user.getLolNicknameTag()).append("'>")
                        .append("</div>")
                        .append("<div class='input-group mb-1'>")
                        .append("<input type='text' class='form-control' name='siteNickname' placeholder='사이트 닉네임 수정' value='").append(user.getSiteNickname()).append("'>")
                        .append("</div>")
                        .append("<button type='submit' class='btn btn-success btn-sm save-button'>저장</button>")
                        .append("<button type='button' class='btn btn-secondary btn-sm cancel-button'>취소</button>")
                        .append("</form>")
                        .append("</div>")
                        .append("<form action='deleteUser' method='post'>")
                        .append("<input type='hidden' name='userId' value='").append(user.getId()).append("'>")
                        .append("<button type='submit' class='btn btn-danger btn-sm delete'>회원 삭제</button>")
                        .append("</form>")
                        .append("</div>")
                        .append("</td>")
                        .append("</tr>")
                        .append("<tr class='spacer'><td colspan='100'></td></tr>");
            }

            resp.getWriter().write(responseHtml.toString());
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("<tr><td colspan='5' class='text-center'>회원 정보를 불러오는 중 오류가 발생했습니다.</td></tr>");
        }
    }
}
