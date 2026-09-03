package com.sunrise.controller;

import com.sunrise.model.Appointment;
import com.sunrise.service.AppointmentService;
import jakarta.servlet.*;

import jakarta.servlet.http.*;
import java.io.IOException;


public class SearchAppointmentServlet extends HttpServlet {

    private final AppointmentService service = new AppointmentService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/search.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String number = req.getParameter("appointmentNumber");
        try {
            Appointment apt = service.searchByNumber(number);
            if (apt != null) {
                req.setAttribute("appointment", apt);
            } else {
                req.setAttribute("error", "No appointment found for: " + number);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Search failed: " + e.getMessage());
        }
        req.getRequestDispatcher("/search.jsp").forward(req, resp);
    }
}
