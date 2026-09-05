package com.health.servlet.admin;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/login")
public class AdminLoginServlet extends HttpServlet {

    private static final String ADMIN_EMAIL = "admin@health.com";
    private static final String ADMIN_PASSWORD = "admin123";

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        if (ADMIN_EMAIL.equals(email) && ADMIN_PASSWORD.equals(password)) {
            req.getSession().setAttribute("admin", "Admin");
            res.sendRedirect(req.getContextPath() + "/admin/dashboard.jsp");
        } else {
            res.sendRedirect(req.getContextPath() + "/admin/login.jsp?msg=invalid");
        }
    }
}
