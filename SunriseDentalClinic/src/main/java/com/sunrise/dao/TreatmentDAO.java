package com.sunrise.dao;

import com.sunrise.model.Treatment;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TreatmentDAO {

    public List<Treatment> getAllTreatments() throws SQLException {
        List<Treatment> list = new ArrayList<>();
        String sql = "SELECT * FROM treatments ORDER BY treatment_name";
        Connection conn = DBConnection.getInstance().getConnection();
        try (Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(new Treatment(rs.getInt("treatment_id"),
                        rs.getString("treatment_name"),
                        rs.getDouble("treatment_fee")));
            }
        }
        return list;
    }

    public Treatment getById(int id) throws SQLException {
        String sql = "SELECT * FROM treatments WHERE treatment_id = ?";
        Connection conn = DBConnection.getInstance().getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Treatment(rs.getInt("treatment_id"),
                        rs.getString("treatment_name"),
                        rs.getDouble("treatment_fee"));
            }
        }
        return null;
    }
}
