package com.pharmacy.controller.admin;

import com.pharmacy.dao.UserDAO;
import com.pharmacy.dao.UserDAOImpl;
import com.pharmacy.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Optional;

@WebServlet(urlPatterns = { "/admin/users", "/admin/users/toggle" })
public class AdminUserServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pageParam = req.getParameter("page");
        int page = 1;
        int pageSize = 15;
        try { page = Math.max(1, Integer.parseInt(pageParam)); } catch (Exception ignored) {}

        List<User> users = userDAO.findAll(page, pageSize);
        int total = userDAO.countAll();
        int totalPages = (int) Math.ceil((double) total / pageSize);

        req.setAttribute("users", users);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/admin/users/toggle".equals(path)) {
            int id = Integer.parseInt(req.getParameter("id"));
            Optional<User> userOpt = userDAO.findById(id);
            if (userOpt.isPresent()) {
                User user = userOpt.get();
                user.setActive(!user.isActive());
                userDAO.update(user);
            }
            resp.sendRedirect(req.getContextPath() + "/admin/users");
        }
    }
}
