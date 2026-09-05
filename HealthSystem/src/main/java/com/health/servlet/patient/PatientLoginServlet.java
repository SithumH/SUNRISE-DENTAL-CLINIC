package com.health.servlet.patient;

import com.health.dao.PatientDAO;
import com.health.model.Patient;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/patient/login")
public class PatientLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        if (email != null) email = email.trim();

        if (email == null || email.isEmpty() || password == null || password.trim().isEmpty()) {
            res.sendRedirect(req.getContextPath() + "/patient/login.jsp?msg=invalid");
            return;
        }

        try {
            Patient p = new PatientDAO().login(email, password);
            if (p != null) {
                req.getSession().setAttribute("patient", p);
                res.sendRedirect(req.getContextPath() + "/patient/dashboard.jsp");
            } else {
                res.sendRedirect(req.getContextPath() + "/patient/login.jsp?msg=invalid");
            }
        } catch (Exception e) {
            res.sendRedirect(req.getContextPath() + "/patient/login.jsp?msg=error");
        }
    }
}
