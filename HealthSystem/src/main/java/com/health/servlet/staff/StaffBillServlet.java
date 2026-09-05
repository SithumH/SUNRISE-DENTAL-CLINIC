package com.health.servlet.staff;

import com.health.dao.AppointmentDAO;
import com.health.model.Staff;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/staff/bill")
public class StaffBillServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        Staff s = (Staff) req.getSession().getAttribute("staff");
        if (s == null) { res.sendRedirect(req.getContextPath() + "/staff/login.jsp"); return; }

        String idParam = req.getParameter("id");
        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                req.setAttribute("appointment", new AppointmentDAO().getById(Integer.parseInt(idParam)));
            } catch (NumberFormatException | java.sql.SQLException e) {
                req.setAttribute("error", "Invalid appointment ID.");
            }
        }
        req.getRequestDispatcher("/staff/calculateBill.jsp").forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        Staff s = (Staff) req.getSession().getAttribute("staff");
        if (s == null) { res.sendRedirect(req.getContextPath() + "/staff/login.jsp"); return; }

        int appointmentId;
        double amount;
        try {
            appointmentId = Integer.parseInt(req.getParameter("appointmentId"));
            amount = Double.parseDouble(req.getParameter("amount"));
            if (amount <= 0) throw new NumberFormatException();
        } catch (NumberFormatException e) {
            res.sendRedirect(req.getContextPath() + "/staff/bill?msg=invalid");
            return;
        }

        try {
            AppointmentDAO dao = new AppointmentDAO();
            if (dao.getById(appointmentId) == null || !dao.updateBill(appointmentId, amount)) {
                res.sendRedirect(req.getContextPath() + "/staff/bill?msg=notfound");
                return;
            }
            req.setAttribute("appointment", dao.getById(appointmentId));
            req.setAttribute("amount", amount);
            req.getRequestDispatcher("/staff/printBill.jsp").forward(req, res);
        } catch (Exception e) {
            res.sendRedirect(req.getContextPath() + "/staff/bill?msg=error");
        }
    }
}
