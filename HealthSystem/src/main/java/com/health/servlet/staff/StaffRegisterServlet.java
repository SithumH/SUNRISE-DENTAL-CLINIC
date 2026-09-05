package com.health.servlet.staff;

import com.health.dao.StaffDAO;
import com.health.model.Staff;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/staff/register")
public class StaffRegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        Staff s = new Staff();
        s.setName(req.getParameter("name"));
        s.setEmail(req.getParameter("email"));
        s.setPhone(req.getParameter("phone"));
        s.setRole(req.getParameter("role"));
        s.setPassword(req.getParameter("password"));

        if (isBlank(s.getName()) || isBlank(s.getEmail()) || isBlank(s.getPhone())
            || isBlank(s.getRole()) || isBlank(s.getPassword()) || !"Staff".equalsIgnoreCase(s.getRole())) {
            res.sendRedirect(req.getContextPath() + "/staff/register.jsp?msg=error");
            return;
        }

        try {
            boolean success = new StaffDAO().register(s);
            if (success) res.sendRedirect(req.getContextPath() + "/staff/login.jsp?msg=registered");
            else res.sendRedirect(req.getContextPath() + "/staff/register.jsp?msg=error");
        } catch (Exception e) {
            res.sendRedirect(req.getContextPath() + "/staff/register.jsp?msg=error");
        }
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}
