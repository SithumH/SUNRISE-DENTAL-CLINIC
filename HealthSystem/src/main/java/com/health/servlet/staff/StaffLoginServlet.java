package com.health.servlet.staff;

import com.health.dao.StaffDAO;
import com.health.model.Staff;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/staff/login")
public class StaffLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            res.sendRedirect(req.getContextPath() + "/staff/login.jsp?msg=invalid");
            return;
        }

        try {
            Staff s = new StaffDAO().login(email, password);
            if (s != null) {
                req.getSession().setAttribute("staff", s);
                res.sendRedirect(req.getContextPath() + "/staff/dashboard.jsp");
            } else {
                res.sendRedirect(req.getContextPath() + "/staff/login.jsp?msg=invalid");
            }
        } catch (Exception e) {
            res.sendRedirect(req.getContextPath() + "/staff/login.jsp?msg=error");
        }
    }
}
