package com.health.servlet.admin;

import com.health.dao.PatientDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/patients")
public class AdminPatientServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        if (req.getSession().getAttribute("admin") == null) { res.sendRedirect(req.getContextPath() + "/admin/login.jsp"); return; }

        String action = req.getParameter("action");
        try {
            if ("delete".equals(action)) {
                new PatientDAO().delete(Integer.parseInt(req.getParameter("id")));
                res.sendRedirect(req.getContextPath() + "/admin/patients.jsp?msg=deleted");
                return;
            }
            req.setAttribute("patientList", new PatientDAO().getAll());
            req.getRequestDispatcher("/admin/patients.jsp").forward(req, res);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
