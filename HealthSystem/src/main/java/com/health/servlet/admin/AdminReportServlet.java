package com.health.servlet.admin;

import com.health.dao.AppointmentDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/reports")
public class AdminReportServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        if (req.getSession().getAttribute("admin") == null) {
            res.sendRedirect(req.getContextPath() + "/admin/login.jsp");
            return;
        }
        try {
            req.setAttribute("appointments", new AppointmentDAO().getAll());
            req.getRequestDispatcher("/admin/reports.jsp").forward(req, res);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
