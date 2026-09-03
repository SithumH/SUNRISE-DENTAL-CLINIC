package com.sunrise.service;

import com.sunrise.dao.AppointmentDAO;
import com.sunrise.model.Appointment;
import com.sunrise.model.Patient;
import java.sql.SQLException;
import java.util.List;

public class AppointmentService {

    private final AppointmentDAO dao = new AppointmentDAO();

    public void bookAppointment(Appointment apt, Patient patient) throws SQLException {
        if (apt.getAppointmentNumber() == null || apt.getAppointmentNumber().isBlank())
            throw new IllegalArgumentException("Appointment number is required.");
        if (patient.getPatientName() == null || patient.getPatientName().isBlank())
            throw new IllegalArgumentException("Patient name is required.");
        if (patient.getContactNumber() == null || !patient.getContactNumber().matches("\\d{10}"))
            throw new IllegalArgumentException("Valid 10-digit contact number is required.");
        dao.saveAppointment(apt, patient);
    }

    public Appointment searchByNumber(String number) throws SQLException {
        return dao.findByNumber(number);
    }

    public List<Appointment> getAllAppointments() throws SQLException {
        return dao.getAllAppointments();
    }

    public List<Appointment> getByDate(String date) throws SQLException {
        return dao.getByDate(date);
    }

    public List<Appointment> getByDentist(String dentistName) throws SQLException {
        return dao.getByDentist(dentistName);
    }
}
