package com.health.servlet.patient;

import com.health.dao.AppointmentDAO;
import com.health.model.Appointment;
import com.health.model.Patient;
import com.health.model.Treatment;
import com.health.dao.TreatmentDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/patient/appointment")
public class PatientAppointmentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        Patient p = (Patient) req.getSession().getAttribute("patient");
        if (p == null) { res.sendRedirect(req.getContextPath() + "/patient/login.jsp"); return; }

        Appointment a = new Appointment();
        a.setPatientId(p.getId());
        a.setPatientName(p.getName());
        a.setDate(req.getParameter("date"));
        a.setTime(req.getParameter("time"));
        Treatment treatment = null;
        try {
            treatment = new TreatmentDAO().getById(Integer.parseInt(req.getParameter("treatmentId")));
        } catch (Exception ignored) {
            // Validation below handles a missing or invalid treatment selection.
        }

        if (!isValidDate(a.getDate()) || isBlank(a.getTime()) || treatment == null) {
            res.sendRedirect(req.getContextPath() + "/patient/appointment?action=new&msg=error");
            return;
        }
        a.setTreatmentId(treatment.getId());
        a.setTreatmentName(treatment.getName());
        a.setTreatmentFee(treatment.getPrice());

        try {
            if (new AppointmentDAO().register(a)) {
                res.sendRedirect(req.getContextPath() + "/patient/appointment?msg=success");
            } else {
                res.sendRedirect(req.getContextPath() + "/patient/appointment?action=new&msg=error");
            }
        } catch (Exception e) {
            res.sendRedirect(req.getContextPath() + "/patient/appointment?action=new&msg=error");
        }
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        Patient p = (Patient) req.getSession().getAttribute("patient");
        if (p == null) { res.sendRedirect(req.getContextPath() + "/patient/login.jsp"); return; }

        String action = req.getParameter("action");
        try {
            if ("new".equals(action)) {
                req.setAttribute("treatments", new TreatmentDAO().getAll());
                req.getRequestDispatcher("/patient/registerAppointment.jsp").forward(req, res);
                return;
            }
            req.setAttribute("appointments", new AppointmentDAO().searchByPatientId(p.getId()));
            req.getRequestDispatcher("/patient/appointments.jsp").forward(req, res);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    private boolean isValidDate(String value) {
        try {
            return value != null && !value.trim().isEmpty()
                    && !java.sql.Date.valueOf(value).before(new java.sql.Date(System.currentTimeMillis()));
        } catch (IllegalArgumentException e) {
            return false;
        }
    }
}
