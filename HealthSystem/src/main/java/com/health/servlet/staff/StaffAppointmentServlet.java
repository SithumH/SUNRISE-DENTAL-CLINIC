package com.health.servlet.staff;

import com.health.dao.AppointmentDAO;
import com.health.model.Appointment;
import com.health.model.Staff;
import com.health.model.Treatment;
import com.health.dao.TreatmentDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/staff/appointment")
public class StaffAppointmentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        Staff s = (Staff) req.getSession().getAttribute("staff");
        if (s == null) { res.sendRedirect(req.getContextPath() + "/staff/login.jsp"); return; }

        Appointment a = new Appointment();
        a.setPatientName(req.getParameter("patientName"));
        a.setDate(req.getParameter("date"));
        a.setTime(req.getParameter("time"));
        Treatment treatment = null;
        try {
            treatment = new TreatmentDAO().getById(Integer.parseInt(req.getParameter("treatmentId")));
        } catch (Exception ignored) {
            // Validation below handles a missing or invalid treatment selection.
        }

        if (isBlank(a.getPatientName()) || !isValidDate(a.getDate()) || isBlank(a.getTime()) || treatment == null) {
            res.sendRedirect(req.getContextPath() + "/staff/appointment?action=new&msg=error");
            return;
        }
        a.setTreatmentId(treatment.getId());
        a.setTreatmentName(treatment.getName());
        a.setTreatmentFee(treatment.getPrice());

        try {
            if (new AppointmentDAO().register(a)) {
                res.sendRedirect(req.getContextPath() + "/staff/appointment?msg=success");
            } else {
                res.sendRedirect(req.getContextPath() + "/staff/appointment?action=new&msg=error");
            }
        } catch (Exception e) {
            res.sendRedirect(req.getContextPath() + "/staff/appointment?action=new&msg=error");
        }
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        Staff s = (Staff) req.getSession().getAttribute("staff");
        if (s == null) { res.sendRedirect(req.getContextPath() + "/staff/login.jsp"); return; }

        String action = req.getParameter("action");
        try {
            if ("new".equals(action)) {
                req.setAttribute("treatments", new TreatmentDAO().getAll());
                req.getRequestDispatcher("/staff/registerAppointment.jsp").forward(req, res);
                return;
            }
            req.setAttribute("appointments", new AppointmentDAO().getAll());
            req.getRequestDispatcher("/staff/appointments.jsp").forward(req, res);
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
