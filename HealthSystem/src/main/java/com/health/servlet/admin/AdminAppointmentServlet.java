package com.health.servlet.admin;

import com.health.dao.AppointmentDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/appointments")
public class AdminAppointmentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        if (req.getSession().getAttribute("admin") == null) { res.sendRedirect(req.getContextPath() + "/admin/login.jsp"); return; }

        String action = req.getParameter("action");
        try {
            if ("delete".equals(action)) {
                new AppointmentDAO().delete(Integer.parseInt(req.getParameter("id")));
                res.sendRedirect(req.getContextPath() + "/admin/appointments.jsp?msg=deleted");
                return;
            }
            req.setAttribute("appointments", new AppointmentDAO().getAll());
            req.getRequestDispatcher("/admin/appointments.jsp").forward(req, res);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
