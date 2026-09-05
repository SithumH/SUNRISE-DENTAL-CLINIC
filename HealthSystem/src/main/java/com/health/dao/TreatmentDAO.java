package com.health.dao;

import com.health.model.Treatment;
import com.health.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TreatmentDAO {
    public List<Treatment> getAll() throws SQLException {
        List<Treatment> treatments = new ArrayList<>();
        String sql = "SELECT * FROM treatments ORDER BY name";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) treatments.add(mapRow(rs));
        }
        return treatments;
    }

    public boolean add(Treatment treatment) throws SQLException {
        String sql = "INSERT INTO treatments (name, description, price) VALUES (?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, treatment.getName());
            ps.setString(2, treatment.getDescription());
            ps.setDouble(3, treatment.getPrice());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean delete(int id) throws SQLException {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("DELETE FROM treatments WHERE id=?")) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    public Treatment getById(int id) throws SQLException {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM treatments WHERE id=?")) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? mapRow(rs) : null;
            }
        }
    }

    private Treatment mapRow(ResultSet rs) throws SQLException {
        Treatment treatment = new Treatment();
        treatment.setId(rs.getInt("id"));
        treatment.setName(rs.getString("name"));
        treatment.setDescription(rs.getString("description"));
        treatment.setPrice(rs.getDouble("price"));
        return treatment;
    }
}
