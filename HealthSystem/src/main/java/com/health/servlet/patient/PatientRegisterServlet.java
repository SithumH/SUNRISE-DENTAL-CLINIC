package com.health.servlet.patient;

import com.health.dao.PatientDAO;
import com.health.model.Patient;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/patient/register")
public class PatientRegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        Patient p = new Patient();
        p.setName(req.getParameter("name"));
        p.setEmail(req.getParameter("email"));
        p.setPhone(req.getParameter("phone"));
        p.setPassword(req.getParameter("password"));

        if (p.getEmail() != null) p.setEmail(p.getEmail().trim());

        if (isBlank(p.getName()) || isBlank(p.getEmail()) || isBlank(p.getPhone())
            || isBlank(p.getPassword()) || p.getPassword().length() < 5) {
            res.sendRedirect(req.getContextPath() + "/patient/register.jsp?msg=error");
            return;
        }

        try {
            boolean success = new PatientDAO().register(p);
            if (success) res.sendRedirect(req.getContextPath() + "/patient/login.jsp?msg=registered");
            else res.sendRedirect(req.getContextPath() + "/patient/register.jsp?msg=error");
        } catch (Exception e) {
            res.sendRedirect(req.getContextPath() + "/patient/register.jsp?msg=error");
        }
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}
