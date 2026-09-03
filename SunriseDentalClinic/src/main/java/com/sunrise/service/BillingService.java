package com.sunrise.service;

import com.sunrise.dao.DBConnection;
import java.sql.*;

public class BillingService {

    private static final double CONSULTATION_FEE = 2000.00;

    public double[] calculateBill(int appointmentId, double treatmentFee) {
        double total = treatmentFee + CONSULTATION_FEE;
        return new double[]{treatmentFee, CONSULTATION_FEE, total};
    }

    public void saveBill(int appointmentId, double treatmentFee) throws SQLException {
        double consultationFee = CONSULTATION_FEE;
        double total = treatmentFee + consultationFee;

        // Check if bill already exists
        String check = "SELECT bill_id FROM bills WHERE appointment_id = ?";
        Connection conn = DBConnection.getInstance().getConnection();
        try (PreparedStatement ps = conn.prepareStatement(check)) {
            ps.setInt(1, appointmentId);
            if (ps.executeQuery().next()) return; // already billed
        }

        String sql = "INSERT INTO bills (appointment_id, treatment_fee, consultation_fee, total_amount) VALUES (?,?,?,?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, appointmentId);
            ps.setDouble(2, treatmentFee);
            ps.setDouble(3, consultationFee);
            ps.setDouble(4, total);
            ps.executeUpdate();
        }
    }

    public double getConsultationFee() {
        return CONSULTATION_FEE;
    }
}
