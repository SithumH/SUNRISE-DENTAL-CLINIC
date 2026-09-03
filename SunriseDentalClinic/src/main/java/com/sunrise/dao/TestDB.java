package com.sunrise.dao;

import java.sql.*;

public class TestDB {
    public static void main(String[] args) throws Exception {
        System.out.println("Testing DB connection...");
        Connection conn = DBConnection.getInstance().getConnection();
        System.out.println("Connected: " + !conn.isClosed());

        // Test users table
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM users");
        System.out.println("Users in DB:");
        while (rs.next()) {
            System.out.println("  - " + rs.getString("username") + " / " + rs.getString("password"));
        }
        System.out.println("Done.");
    }
}
