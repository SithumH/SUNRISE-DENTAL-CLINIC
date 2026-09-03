package com.sunrise.controller;

import com.sunrise.dao.AppointmentDAO;
import com.sunrise.dao.DBConnection;
import com.sunrise.model.Appointment;
import jakarta.servlet.*;

import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;


public class ReportServlet extends HttpServlet {

    private final AppointmentDAO dao = new AppointmentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String type = req.getParameter("type");
        if (type == null) type = "daily";

        try {
            switch (type) {
                case "daily":
                    String date = req.getParameter("date");
                    if (date == null || date.isBlank()) date = java.time.LocalDate.now().toString();
                    req.setAttribute("appointments", dao.getByDate(date));
                    req.setAttribute("reportDate", date);
                    break;
                case "dentist":
                    String dentist = req.getParameter("dentist");
                    if (dentist != null && !dentist.isBlank())
                        req.setAttribute("appointments", dao.getByDentist(dentist));
                    req.setAttribute("dentists", getDentistNames());
                    break;
                case "revenue":
                    req.setAttribute("revenueData", getMonthlyRevenue());
                    break;
                case "treatment":
                    req.setAttribute("treatmentRevenue", getTreatmentRevenue());
                    break;
                case "patient":
                    String contact = req.getParameter("contact");
                    if (contact != null && !contact.isBlank())
                        req.setAttribute("appointments", dao.getByContact(contact));
                    req.setAttribute("contact", contact);
                    break;
                default:
                    req.setAttribute("appointments", dao.getAllAppointments());
            }
        } catch (Exception e) {
            req.setAttribute("error", "Report error: " + e.getMessage());
        }

        req.setAttribute("reportType", type);
        req.getRequestDispatcher("/reports.jsp").forward(req, resp);
    }

    private List<String> getDentistNames() throws SQLException {
        List<String> list = new ArrayList<>();
        String sql = "SELECT dentist_name FROM dentists ORDER BY dentist_name";
        try (Statement st = DBConnection.getInstance().getConnection().createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(rs.getString("dentist_name"));
        }
        return list;
    }

    private List<Map<String, Object>> getMonthlyRevenue() throws SQLException {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT DATE_FORMAT(a.appointment_date, '%Y-%m') AS month, " +
                     "SUM(b.total_amount) AS revenue, COUNT(b.bill_id) AS count " +
                     "FROM bills b JOIN appointments a ON b.appointment_id = a.appointment_id " +
                     "GROUP BY month ORDER BY month DESC LIMIT 12";
        try (Statement st = DBConnection.getInstance().getConnection().createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Map<String, Object> row = new LinkedHashMap<>();
                row.put("month", rs.getString("month"));
                row.put("revenue", rs.getDouble("revenue"));
                row.put("count", rs.getInt("count"));
                list.add(row);
            }
        }
        return list;
    }

    private List<Map<String, Object>> getTreatmentRevenue() throws SQLException {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT t.treatment_name, COUNT(b.bill_id) AS count, SUM(b.treatment_fee) AS revenue " +
                     "FROM bills b JOIN appointments a ON b.appointment_id = a.appointment_id " +
                     "JOIN treatments t ON a.treatment_id = t.treatment_id " +
                     "GROUP BY t.treatment_name ORDER BY revenue DESC";
        try (Statement st = DBConnection.getInstance().getConnection().createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Map<String, Object> row = new LinkedHashMap<>();
                row.put("treatment", rs.getString("treatment_name"));
                row.put("count", rs.getInt("count"));
                row.put("revenue", rs.getDouble("revenue"));
                list.add(row);
            }
        }
        return list;
    }
}
