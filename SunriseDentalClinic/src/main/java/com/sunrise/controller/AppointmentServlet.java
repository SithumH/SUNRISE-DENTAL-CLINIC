package com.sunrise.controller;

import com.sunrise.dao.TreatmentDAO;
import com.sunrise.model.Appointment;
import com.sunrise.model.Patient;
import com.sunrise.service.AppointmentService;
import jakarta.servlet.*;

import jakarta.servlet.http.*;
import java.io.IOException;


public class AppointmentServlet extends HttpServlet {

    private final AppointmentService service = new AppointmentService();
    private final TreatmentDAO treatmentDAO = new TreatmentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            req.setAttribute("treatments", treatmentDAO.getAllTreatments());
            req.setAttribute("dentists", java.util.Arrays.asList("Dr. Perera", "Dr. Silva", "Dr. Fernando"));
        } catch (Exception e) {
            req.setAttribute("error", "Could not load form data.");
        }
        req.getRequestDispatcher("/appointment.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            Patient patient = new Patient();
            patient.setPatientName(req.getParameter("patientName"));
            patient.setAddress(req.getParameter("address"));
            patient.setContactNumber(req.getParameter("contactNumber"));

            Appointment apt = new Appointment();
            apt.setAppointmentNumber(req.getParameter("appointmentNumber"));
            apt.setDentistName(req.getParameter("dentistName"));
            apt.setTreatmentId(Integer.parseInt(req.getParameter("treatmentId")));
            apt.setAppointmentDate(req.getParameter("appointmentDate"));
            apt.setAppointmentTime(req.getParameter("appointmentTime"));

            service.bookAppointment(apt, patient);
            req.setAttribute("success", "Appointment " + apt.getAppointmentNumber() + " saved successfully.");
        } catch (IllegalArgumentException e) {
            req.setAttribute("error", e.getMessage());
        } catch (Exception e) {
            req.setAttribute("error", "Failed to save appointment: " + e.getMessage());
        }
        doGet(req, resp);
    }
}
