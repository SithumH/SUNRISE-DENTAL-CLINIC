<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.sunrise.model.Appointment, java.util.*" %>
<%
    if (session.getAttribute("user") == null) { response.sendRedirect(request.getContextPath() + "/login.jsp"); return; }
    String reportType = (String) request.getAttribute("reportType");
    if (reportType == null) reportType = "daily";
    List<Appointment> appointments = (List<Appointment>) request.getAttribute("appointments");
    List<Map<String, Object>> revenueData = (List<Map<String, Object>>) request.getAttribute("revenueData");
    List<Map<String, Object>> treatmentRevenue = (List<Map<String, Object>>) request.getAttribute("treatmentRevenue");
    List<String> dentists = (List<String>) request.getAttribute("dentists");
    String contact = (String) request.getAttribute("contact");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reports – Sunrise Dental Clinic</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="header">
    <h1>🦷 SUNRISE DENTAL CLINIC</h1>
    <div class="user-info"><a href="dashboard.jsp">← Dashboard</a> <a href="logout">Logout</a></div>
</div>

<div class="container">
    <div class="page-title">Reports</div>

    <!-- Report type tabs -->
    <div style="display:flex; gap:8px; margin-bottom:20px; flex-wrap:wrap;">
        <a href="reports?type=daily"     class="btn <%= "daily".equals(reportType)     ? "btn-primary" : "btn-warning" %>">Daily Appointments</a>
        <a href="reports?type=dentist"   class="btn <%= "dentist".equals(reportType)   ? "btn-primary" : "btn-warning" %>">By Dentist</a>
        <a href="reports?type=revenue"   class="btn <%= "revenue".equals(reportType)   ? "btn-primary" : "btn-warning" %>">Monthly Revenue</a>
        <a href="reports?type=treatment" class="btn <%= "treatment".equals(reportType) ? "btn-primary" : "btn-warning" %>">Treatment Revenue</a>
        <a href="reports?type=patient"   class="btn <%= "patient".equals(reportType)   ? "btn-primary" : "btn-warning" %>">Patient History</a>
        <a href="reports?type=all"       class="btn <%= "all".equals(reportType)       ? "btn-primary" : "btn-warning" %>">All Appointments</a>
    </div>

    <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
    <% } %>

    <!-- Daily filter -->
    <% if ("daily".equals(reportType)) { %>
    <div class="card">
        <form action="reports" method="get" style="display:flex; gap:12px; align-items:flex-end;">
            <input type="hidden" name="type" value="daily">
            <div class="form-group" style="margin:0; flex:1;">
                <label>Select Date</label>
                <input type="date" name="date" value="<%= request.getAttribute("reportDate") %>">
            </div>
            <button type="submit" class="btn btn-primary">View</button>
        </form>
    </div>
    <% } %>

    <!-- Dentist filter -->
    <% if ("dentist".equals(reportType)) { %>
    <div class="card">
        <form action="reports" method="get" style="display:flex; gap:12px; align-items:flex-end;">
            <input type="hidden" name="type" value="dentist">
            <div class="form-group" style="margin:0; flex:1;">
                <label>Select Dentist</label>
                <select name="dentist">
                    <option value="">-- All Dentists --</option>
                    <% if (dentists != null) for (String d : dentists) { %>
                        <option value="<%= d %>"><%= d %></option>
                    <% } %>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">View</button>
        </form>
    </div>
    <% } %>

    <!-- Patient History filter -->
    <% if ("patient".equals(reportType)) { %>
    <div class="card">
        <form action="reports" method="get" style="display:flex; gap:12px; align-items:flex-end;">
            <input type="hidden" name="type" value="patient">
            <div class="form-group" style="margin:0; flex:1;">
                <label>Patient Contact Number</label>
                <input type="text" name="contact" value="<%= contact != null ? contact : "" %>" placeholder="Enter 10-digit contact number">
            </div>
            <button type="submit" class="btn btn-primary">Search</button>
        </form>
    </div>
    <% } %>

    <!-- Appointments table -->
    <% if (appointments != null && !appointments.isEmpty()) { %>
    <div class="card">
        <button onclick="window.print()" class="btn btn-warning" style="margin-bottom:12px;">🖨 Print</button>
        <table class="result-table">
            <tr>
                <th>Apt No</th><th>Patient</th><th>Dentist</th>
                <th>Treatment</th><th>Date</th><th>Time</th>
            </tr>
            <% for (Appointment a : appointments) { %>
            <tr>
                <td><%= a.getAppointmentNumber() %></td>
                <td><%= a.getPatientName() %></td>
                <td><%= a.getDentistName() %></td>
                <td><%= a.getTreatmentName() %></td>
                <td><%= a.getAppointmentDate() %></td>
                <td><%= a.getAppointmentTime() %></td>
            </tr>
            <% } %>
        </table>
    </div>
    <% } else if (appointments != null) { %>
        <div class="alert alert-danger">No appointments found.</div>
    <% } %>

    <!-- Treatment Revenue table -->
    <% if (treatmentRevenue != null && !treatmentRevenue.isEmpty()) { %>
    <div class="card">
        <button onclick="window.print()" class="btn btn-warning" style="margin-bottom:12px;">🖨 Print</button>
        <table class="result-table">
            <tr><th>Treatment</th><th>Bills Count</th><th>Total Revenue</th></tr>
            <% for (Map<String, Object> row : treatmentRevenue) { %>
            <tr>
                <td><%= row.get("treatment") %></td>
                <td><%= row.get("count") %></td>
                <td>Rs. <%= String.format("%,.2f", row.get("revenue")) %></td>
            </tr>
            <% } %>
        </table>
    </div>
    <% } else if ("treatment".equals(reportType) && treatmentRevenue != null) { %>
        <div class="alert alert-danger">No treatment revenue data found.</div>
    <% } %>

    <!-- Revenue table -->
    <% if (revenueData != null && !revenueData.isEmpty()) { %>
    <div class="card">
        <button onclick="window.print()" class="btn btn-warning" style="margin-bottom:12px;">🖨 Print</button>
        <table class="result-table">
            <tr><th>Month</th><th>Bills Count</th><th>Total Revenue</th></tr>
            <% for (Map<String, Object> row : revenueData) { %>
            <tr>
                <td><%= row.get("month") %></td>
                <td><%= row.get("count") %></td>
                <td>Rs. <%= String.format("%,.2f", row.get("revenue")) %></td>
            </tr>
            <% } %>
        </table>
    </div>
    <% } %>
</div>
</body>
</html>
