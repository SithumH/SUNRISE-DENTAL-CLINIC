package com.sunrise.controller;

import com.google.gson.Gson;
import com.sunrise.model.Appointment;
import com.sunrise.service.AppointmentService;
import jakarta.servlet.*;

import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * REST Web Service – GET /api/appointments/{appointmentNumber}
 * Demonstrates distributed application / web service requirement.
 */

public class AppointmentApiServlet extends HttpServlet {

    private final AppointmentService service = new AppointmentService();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        String pathInfo = req.getPathInfo(); // e.g. /APT001
        if (pathInfo == null || pathInfo.equals("/")) {
            resp.setStatus(400);
            resp.getWriter().write(gson.toJson(Map.of("error", "Appointment number required. Use /api/appointments/{number}")));
            return;
        }

        String number = pathInfo.substring(1);
        try {
            Appointment apt = service.searchByNumber(number);
            if (apt == null) {
                resp.setStatus(404);
                resp.getWriter().write(gson.toJson(Map.of("error", "Appointment not found: " + number)));
                return;
            }
            Map<String, Object> result = new HashMap<>();
            result.put("appointmentNumber", apt.getAppointmentNumber());
            result.put("patientName", apt.getPatientName());
            result.put("address", apt.getAddress());
            result.put("contactNumber", apt.getContactNumber());
            result.put("dentist", apt.getDentistName());
            result.put("treatment", apt.getTreatmentName());
            result.put("treatmentFee", apt.getTreatmentFee());
            result.put("date", apt.getAppointmentDate());
            result.put("time", apt.getAppointmentTime());
            resp.getWriter().write(gson.toJson(result));
        } catch (Exception e) {
            resp.setStatus(500);
            resp.getWriter().write(gson.toJson(Map.of("error", e.getMessage())));
        }
    }
}
