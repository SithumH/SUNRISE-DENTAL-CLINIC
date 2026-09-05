package com.health.dao;

import com.health.model.Staff;
import com.health.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StaffDAO {

    public boolean register(Staff s) throws SQLException {
        String sql = "INSERT INTO staff (name, email, phone, role, password) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, s.getName());
            ps.setString(2, s.getEmail());
            ps.setString(3, s.getPhone());
            ps.setString(4, s.getRole());
            ps.setString(5, s.getPassword());
            return ps.executeUpdate() > 0;
        }
    }

    public List<Staff> getAll() throws SQLException {
        List<Staff> list = new ArrayList<>();
        String sql = "SELECT * FROM staff ORDER BY name";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Staff s = new Staff();
                s.setId(rs.getInt("id"));
                s.setName(rs.getString("name"));
                s.setEmail(rs.getString("email"));
                s.setPhone(rs.getString("phone"));
                s.setRole(rs.getString("role"));
                list.add(s);
            }
        }
        return list;
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM staff WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    public Staff login(String email, String password) throws SQLException {
        String sql = "SELECT * FROM staff WHERE email=? AND password=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Staff s = new Staff();
                s.setId(rs.getInt("id"));
                s.setName(rs.getString("name"));
                s.setEmail(rs.getString("email"));
                s.setPhone(rs.getString("phone"));
                s.setRole(rs.getString("role"));
                return s;
            }
        }
        return null;
    }
}
