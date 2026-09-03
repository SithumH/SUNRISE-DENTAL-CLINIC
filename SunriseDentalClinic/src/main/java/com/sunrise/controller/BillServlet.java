package com.sunrise.controller;

import com.sunrise.model.Appointment;
import com.sunrise.service.AppointmentService;
import com.sunrise.service.BillingService;
import jakarta.servlet.*;

import jakarta.servlet.http.*;
import java.io.IOException;


public class BillServlet extends HttpServlet {

    private final AppointmentService appointmentService = new AppointmentService();
    private final BillingService billingService = new BillingService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String number = req.getParameter("appointmentNumber");
        if (number != null && !number.isBlank()) {
            try {
                Appointment apt = appointmentService.searchByNumber(number);
                if (apt != null) {
                    double[] fees = billingService.calculateBill(apt.getAppointmentId(), apt.getTreatmentFee());
                    req.setAttribute("appointment", apt);
                    req.setAttribute("treatmentFee", fees[0]);
                    req.setAttribute("consultationFee", fees[1]);
                    req.setAttribute("totalAmount", fees[2]);
                } else {
                    req.setAttribute("error", "Appointment not found.");
                }
            } catch (Exception e) {
                req.setAttribute("error", "Error: " + e.getMessage());
            }
        }
        req.getRequestDispatcher("/bill.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String number = req.getParameter("appointmentNumber");
        try {
            Appointment apt = appointmentService.searchByNumber(number);
            if (apt != null) {
                billingService.saveBill(apt.getAppointmentId(), apt.getTreatmentFee());
                req.setAttribute("saved", true);
                double[] fees = billingService.calculateBill(apt.getAppointmentId(), apt.getTreatmentFee());
                req.setAttribute("appointment", apt);
                req.setAttribute("treatmentFee", fees[0]);
                req.setAttribute("consultationFee", fees[1]);
                req.setAttribute("totalAmount", fees[2]);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Billing error: " + e.getMessage());
        }
        req.getRequestDispatcher("/bill.jsp").forward(req, resp);
    }
}
