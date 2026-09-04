package com.sunrise.controller;

import com.sunrise.dao.UserDAO;
import com.sunrise.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class UserServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        User current = (User) req.getSession().getAttribute("user");
        if (current == null || !"ADMIN".equals(current.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/dashboard.jsp");
            return;
        }
        try {
            List<User> users = userDAO.getAllUsers();
            req.setAttribute("users", users);
        } catch (Exception e) {
            req.setAttribute("error", "Failed to load users.");
        }
        req.getRequestDispatcher("/users.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        User current = (User) req.getSession().getAttribute("user");
        if (current == null || !"ADMIN".equals(current.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/dashboard.jsp");
            return;
        }
        String action = req.getParameter("action");
        try {
            if ("add".equals(action)) {
                String username = req.getParameter("username");
                String password = req.getParameter("password");
                String role = req.getParameter("role");
                userDAO.addUser(username, password, role);
                req.setAttribute("success", "User added successfully.");
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                if (id == current.getId()) {
                    req.setAttribute("error", "Cannot delete your own account.");
                } else {
                    userDAO.deleteUser(id);
                    req.setAttribute("success", "User deleted.");
                }
            }
        } catch (Exception e) {
            req.setAttribute("error", "Operation failed: " + e.getMessage());
        }
        doGet(req, resp);
    }
}
