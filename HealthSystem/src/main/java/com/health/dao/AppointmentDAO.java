package com.health.dao;

import com.health.model.Appointment;
import com.health.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AppointmentDAO {

    public boolean register(Appointment a) throws SQLException {
        String sql = "INSERT INTO appointments (patient_id, patient_name, treatment_id, treatment_name, treatment_fee, date, time, status, bill_amount) VALUES (?, ?, ?, ?, ?, ?, ?, 'Pending', 0)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            if (a.getPatientId() > 0) {
                ps.setInt(1, a.getPatientId());
            } else {
                ps.setNull(1, Types.INTEGER);
            }
            ps.setString(2, a.getPatientName());
            ps.setInt(3, a.getTreatmentId());
            ps.setString(4, a.getTreatmentName());
            ps.setDouble(5, a.getTreatmentFee());
            ps.setString(6, a.getDate());
            ps.setString(7, a.getTime());
            return ps.executeUpdate() > 0;
        }
    }

    public List<Appointment> searchByPatientId(int patientId) throws SQLException {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT * FROM appointments WHERE patient_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, patientId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }
        return list;
    }

    public List<Appointment> getAll() throws SQLException {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT * FROM appointments";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement()) {
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }
        return list;
    }

    public boolean updateBill(int id, double amount) throws SQLException {
        String sql = "UPDATE appointments SET bill_amount=?, status='Billed' WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDouble(1, amount);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM appointments WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    public Appointment getById(int id) throws SQLException {
        String sql = "SELECT * FROM appointments WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        }
        return null;
    }

    private Appointment mapRow(ResultSet rs) throws SQLException {
        Appointment a = new Appointment();
        a.setId(rs.getInt("id"));
        a.setPatientId(rs.getInt("patient_id"));
        a.setPatientName(rs.getString("patient_name"));
        a.setTreatmentId(rs.getInt("treatment_id"));
        a.setTreatmentName(rs.getString("treatment_name"));
        a.setTreatmentFee(rs.getDouble("treatment_fee"));
        a.setDate(rs.getString("date"));
        a.setTime(rs.getString("time"));
        a.setStatus(rs.getString("status"));
        a.setBillAmount(rs.getDouble("bill_amount"));
        return a;
    }
}
