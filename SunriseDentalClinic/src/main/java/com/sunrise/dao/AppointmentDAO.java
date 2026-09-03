package com.sunrise.dao;

import com.sunrise.model.Appointment;
import com.sunrise.model.Patient;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AppointmentDAO {

    private Connection getConn() throws SQLException {
        return DBConnection.getInstance().getConnection();
    }

    public void saveAppointment(Appointment apt, Patient patient) throws SQLException {
        Connection conn = getConn();

        int patientId = getOrCreatePatient(conn, patient);
        int dentistId = getOrCreateDentist(conn, apt.getDentistName());

        // Dentist double-booking check
        String doubleBookCheck = "SELECT appointment_id FROM appointments WHERE dentist_id = ? AND appointment_date = ? AND appointment_time = ?";
        try (PreparedStatement ps = conn.prepareStatement(doubleBookCheck)) {
            ps.setInt(1, dentistId);
            ps.setString(2, apt.getAppointmentDate());
            ps.setString(3, apt.getAppointmentTime());
            if (ps.executeQuery().next())
                throw new IllegalStateException(apt.getDentistName() + " already has an appointment on " + apt.getAppointmentDate() + " at " + apt.getAppointmentTime());
        }

        String sql = "INSERT INTO appointments (appointment_number, patient_id, dentist_id, treatment_id, appointment_date, appointment_time) VALUES (?,?,?,?,?,?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, apt.getAppointmentNumber());
            ps.setInt(2, patientId);
            ps.setInt(3, dentistId);
            ps.setInt(4, apt.getTreatmentId());
            ps.setString(5, apt.getAppointmentDate());
            ps.setString(6, apt.getAppointmentTime());
            ps.executeUpdate();
        }
    }

    public Appointment findByNumber(String appointmentNumber) throws SQLException {
        String sql = "SELECT a.*, p.patient_name, p.address, p.contact_number, " +
                     "d.dentist_name, t.treatment_name, t.treatment_fee " +
                     "FROM appointments a " +
                     "JOIN patients p ON a.patient_id = p.patient_id " +
                     "JOIN dentists d ON a.dentist_id = d.dentist_id " +
                     "JOIN treatments t ON a.treatment_id = t.treatment_id " +
                     "WHERE a.appointment_number = ?";
        try (PreparedStatement ps = getConn().prepareStatement(sql)) {
            ps.setString(1, appointmentNumber);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        }
        return null;
    }

    public List<Appointment> getAllAppointments() throws SQLException {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT a.*, p.patient_name, p.address, p.contact_number, " +
                     "d.dentist_name, t.treatment_name, t.treatment_fee " +
                     "FROM appointments a " +
                     "JOIN patients p ON a.patient_id = p.patient_id " +
                     "JOIN dentists d ON a.dentist_id = d.dentist_id " +
                     "JOIN treatments t ON a.treatment_id = t.treatment_id " +
                     "ORDER BY a.appointment_date DESC";
        try (Statement st = getConn().createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    public List<Appointment> getByDate(String date) throws SQLException {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT a.*, p.patient_name, p.address, p.contact_number, " +
                     "d.dentist_name, t.treatment_name, t.treatment_fee " +
                     "FROM appointments a " +
                     "JOIN patients p ON a.patient_id = p.patient_id " +
                     "JOIN dentists d ON a.dentist_id = d.dentist_id " +
                     "JOIN treatments t ON a.treatment_id = t.treatment_id " +
                     "WHERE a.appointment_date = ?";
        try (PreparedStatement ps = getConn().prepareStatement(sql)) {
            ps.setString(1, date);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    public List<Appointment> getByDentist(String dentistName) throws SQLException {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT a.*, p.patient_name, p.address, p.contact_number, " +
                     "d.dentist_name, t.treatment_name, t.treatment_fee " +
                     "FROM appointments a " +
                     "JOIN patients p ON a.patient_id = p.patient_id " +
                     "JOIN dentists d ON a.dentist_id = d.dentist_id " +
                     "JOIN treatments t ON a.treatment_id = t.treatment_id " +
                     "WHERE d.dentist_name = ?";
        try (PreparedStatement ps = getConn().prepareStatement(sql)) {
            ps.setString(1, dentistName);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    public List<Appointment> getByContact(String contactNumber) throws SQLException {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT a.*, p.patient_name, p.address, p.contact_number, " +
                     "d.dentist_name, t.treatment_name, t.treatment_fee " +
                     "FROM appointments a " +
                     "JOIN patients p ON a.patient_id = p.patient_id " +
                     "JOIN dentists d ON a.dentist_id = d.dentist_id " +
                     "JOIN treatments t ON a.treatment_id = t.treatment_id " +
                     "WHERE p.contact_number = ? ORDER BY a.appointment_date DESC";
        try (PreparedStatement ps = getConn().prepareStatement(sql)) {
            ps.setString(1, contactNumber);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    private Appointment mapRow(ResultSet rs) throws SQLException {
        Appointment a = new Appointment();
        a.setAppointmentId(rs.getInt("appointment_id"));
        a.setAppointmentNumber(rs.getString("appointment_number"));
        a.setPatientId(rs.getInt("patient_id"));
        a.setDentistId(rs.getInt("dentist_id"));
        a.setTreatmentId(rs.getInt("treatment_id"));
        a.setAppointmentDate(rs.getString("appointment_date"));
        a.setAppointmentTime(rs.getString("appointment_time"));
        a.setPatientName(rs.getString("patient_name"));
        a.setAddress(rs.getString("address"));
        a.setContactNumber(rs.getString("contact_number"));
        a.setDentistName(rs.getString("dentist_name"));
        a.setTreatmentName(rs.getString("treatment_name"));
        a.setTreatmentFee(rs.getDouble("treatment_fee"));
        return a;
    }

    private int getOrCreatePatient(Connection conn, Patient patient) throws SQLException {
        String check = "SELECT patient_id FROM patients WHERE contact_number = ? AND patient_name = ?";
        try (PreparedStatement ps = conn.prepareStatement(check)) {
            ps.setString(1, patient.getContactNumber());
            ps.setString(2, patient.getPatientName());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt("patient_id");
        }
        String insert = "INSERT INTO patients (patient_name, address, contact_number) VALUES (?,?,?)";
        try (PreparedStatement ps = conn.prepareStatement(insert, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, patient.getPatientName());
            ps.setString(2, patient.getAddress());
            ps.setString(3, patient.getContactNumber());
            ps.executeUpdate();
            ResultSet keys = ps.getGeneratedKeys();
            keys.next();
            return keys.getInt(1);
        }
    }

    private int getOrCreateDentist(Connection conn, String dentistName) throws SQLException {
        String check = "SELECT dentist_id FROM dentists WHERE dentist_name = ?";
        try (PreparedStatement ps = conn.prepareStatement(check)) {
            ps.setString(1, dentistName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt("dentist_id");
        }
        String insert = "INSERT INTO dentists (dentist_name) VALUES (?)";
        try (PreparedStatement ps = conn.prepareStatement(insert, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, dentistName);
            ps.executeUpdate();
            ResultSet keys = ps.getGeneratedKeys();
            keys.next();
            return keys.getInt(1);
        }
    }
}
