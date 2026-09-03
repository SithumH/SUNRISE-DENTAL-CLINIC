<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.sunrise.model.Appointment, com.sunrise.model.User, java.util.*" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) { response.sendRedirect(request.getContextPath() + "/login"); return; }
    String reportType = (String) request.getAttribute("reportType");
    if (reportType == null) reportType = "daily";
    List<Appointment> appointments = (List<Appointment>) request.getAttribute("appointments");
    List<Map<String, Object>> revenueData = (List<Map<String, Object>>) request.getAttribute("revenueData");
    List<Map<String, Object>> treatmentRevenue = (List<Map<String, Object>>) request.getAttribute("treatmentRevenue");
    List<String> dentists = (List<String>) request.getAttribute("dentists");
    String contact = (String) request.getAttribute("contact");
    String initial = user.getUsername().substring(0,1).toUpperCase();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reports – Sunrise Dental Clinic</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="layout">
    <aside class="sidebar">
        <div class="sidebar-brand">
            <span class="brand-icon">🦷</span>
            <h2>SUNRISE DENTAL</h2>
            <p>Clinic Management</p>
        </div>
        <nav class="sidebar-nav">
            <div class="nav-section-label">Main</div>
            <a href="dashboard.jsp" class="nav-item"><span class="nav-icon">🏠</span><span>Dashboard</span></a>
            <a href="appointment" class="nav-item"><span class="nav-icon">📋</span><span>New Appointment</span></a>
            <a href="search" class="nav-item"><span class="nav-icon">🔍</span><span>Search</span></a>
            <a href="bill" class="nav-item"><span class="nav-icon">💰</span><span>Billing</span></a>
            <div class="nav-section-label">Reports</div>
            <a href="reports?type=daily"     class="nav-item <%= "daily".equals(reportType) ? "active" : "" %>"><span class="nav-icon">📅</span><span>Daily Report</span></a>
            <a href="reports?type=revenue"   class="nav-item <%= "revenue".equals(reportType) ? "active" : "" %>"><span class="nav-icon">📊</span><span>Revenue</span></a>
            <a href="reports?type=treatment" class="nav-item <%= "treatment".equals(reportType) ? "active" : "" %>"><span class="nav-icon">🦷</span><span>Treatments</span></a>
            <a href="reports?type=patient"   class="nav-item <%= "patient".equals(reportType) ? "active" : "" %>"><span class="nav-icon">👤</span><span>Patient History</span></a>
            <div class="nav-section-label">Other</div>
            <a href="help.jsp" class="nav-item"><span class="nav-icon">❓</span><span>Help</span></a>
        </nav>
        <div class="sidebar-footer">
            <div class="sidebar-user">
                <div class="avatar"><%= initial %></div>
                <div class="user-details">
                    <div class="user-name"><%= user.getUsername() %></div>
                    <div class="user-role"><%= user.getRole() %></div>
                </div>
                <a href="logout" class="logout-btn" title="Logout">⏻</a>
            </div>
        </div>
    </aside>

    <div class="main-content">
        <div class="topbar">
            <div class="topbar-title">Reports</div>
            <div class="topbar-right">
                <a href="dashboard.jsp" class="btn btn-outline btn-sm">← Dashboard</a>
            </div>
        </div>

        <div class="page-content">

            <!-- Tab Bar -->
            <div class="tab-bar">
                <a href="reports?type=daily"     class="tab-btn <%= "daily".equals(reportType)     ? "active" : "" %>">📅 Daily</a>
                <a href="reports?type=dentist"   class="tab-btn <%= "dentist".equals(reportType)   ? "active" : "" %>">👨‍⚕️ By Dentist</a>
                <a href="reports?type=revenue"   class="tab-btn <%= "revenue".equals(reportType)   ? "active" : "" %>">📊 Monthly Revenue</a>
                <a href="reports?type=treatment" class="tab-btn <%= "treatment".equals(reportType) ? "active" : "" %>">🦷 Treatment Revenue</a>
                <a href="reports?type=patient"   class="tab-btn <%= "patient".equals(reportType)   ? "active" : "" %>">👤 Patient History</a>
                <a href="reports?type=all"       class="tab-btn <%= "all".equals(reportType)       ? "active" : "" %>">📋 All</a>
            </div>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger">⚠ <%= request.getAttribute("error") %></div>
            <% } %>

            <!-- Daily filter -->
            <% if ("daily".equals(reportType)) { %>
            <div class="card">
                <div class="card-title">📅 Daily Appointments</div>
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
                <div class="card-title">👨‍⚕️ Appointments by Dentist</div>
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
                <div class="card-title">👤 Patient Appointment History</div>
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
                <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:16px;">
                    <div class="card-title" style="margin:0; border:none; padding:0;">Results (<%= appointments.size() %> records)</div>
                    <button onclick="window.print()" class="btn btn-warning btn-sm">🖨 Print</button>
                </div>
                <table class="result-table">
                    <thead>
                        <tr><th>Apt No</th><th>Patient</th><th>Dentist</th><th>Treatment</th><th>Date</th><th>Time</th></tr>
                    </thead>
                    <tbody>
                    <% for (Appointment a : appointments) { %>
                    <tr>
                        <td><span class="badge badge-primary"><%= a.getAppointmentNumber() %></span></td>
                        <td><%= a.getPatientName() %></td>
                        <td><%= a.getDentistName() %></td>
                        <td><%= a.getTreatmentName() %></td>
                        <td><%= a.getAppointmentDate() %></td>
                        <td><%= a.getAppointmentTime() %></td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
            <% } else if (appointments != null) { %>
                <div class="alert alert-info">ℹ No appointments found.</div>
            <% } %>

            <!-- Treatment Revenue table -->
            <% if (treatmentRevenue != null && !treatmentRevenue.isEmpty()) { %>
            <div class="card">
                <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:16px;">
                    <div class="card-title" style="margin:0; border:none; padding:0;">Treatment Revenue</div>
                    <button onclick="window.print()" class="btn btn-warning btn-sm">🖨 Print</button>
                </div>
                <table class="result-table">
                    <thead><tr><th>Treatment</th><th>Bills Count</th><th>Total Revenue</th></tr></thead>
                    <tbody>
                    <% for (Map<String, Object> row : treatmentRevenue) { %>
                    <tr>
                        <td><%= row.get("treatment") %></td>
                        <td><span class="badge badge-success"><%= row.get("count") %></span></td>
                        <td><strong>Rs. <%= String.format("%,.2f", row.get("revenue")) %></strong></td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
            <% } else if ("treatment".equals(reportType) && treatmentRevenue != null) { %>
                <div class="alert alert-info">ℹ No treatment revenue data found.</div>
            <% } %>

            <!-- Monthly Revenue table -->
            <% if (revenueData != null && !revenueData.isEmpty()) { %>
            <div class="card">
                <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:16px;">
                    <div class="card-title" style="margin:0; border:none; padding:0;">Monthly Revenue</div>
                    <button onclick="window.print()" class="btn btn-warning btn-sm">🖨 Print</button>
                </div>
                <table class="result-table">
                    <thead><tr><th>Month</th><th>Bills Count</th><th>Total Revenue</th></tr></thead>
                    <tbody>
                    <% for (Map<String, Object> row : revenueData) { %>
                    <tr>
                        <td><%= row.get("month") %></td>
                        <td><span class="badge badge-success"><%= row.get("count") %></span></td>
                        <td><strong>Rs. <%= String.format("%,.2f", row.get("revenue")) %></strong></td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
            <% } %>

        </div>
    </div>
</div>
</body>
</html>
