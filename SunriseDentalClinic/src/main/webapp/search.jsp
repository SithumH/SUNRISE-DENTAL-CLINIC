<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.sunrise.model.Appointment, com.sunrise.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) { response.sendRedirect(request.getContextPath() + "/login"); return; }
    Appointment apt = (Appointment) request.getAttribute("appointment");
    String initial = user.getUsername().substring(0,1).toUpperCase();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search – Sunrise Dental Clinic</title>
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
            <a href="search" class="nav-item active"><span class="nav-icon">🔍</span><span>Search</span></a>
            <a href="bill" class="nav-item"><span class="nav-icon">💰</span><span>Billing</span></a>
            <div class="nav-section-label">Reports</div>
            <a href="reports?type=daily" class="nav-item"><span class="nav-icon">📅</span><span>Daily Report</span></a>
            <a href="reports?type=revenue" class="nav-item"><span class="nav-icon">📊</span><span>Revenue</span></a>
            <a href="reports?type=treatment" class="nav-item"><span class="nav-icon">🦷</span><span>Treatments</span></a>
            <a href="reports?type=patient" class="nav-item"><span class="nav-icon">👤</span><span>Patient History</span></a>
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
            <div class="topbar-title">Search Appointment</div>
            <div class="topbar-right">
                <a href="dashboard.jsp" class="btn btn-outline btn-sm">← Dashboard</a>
            </div>
        </div>

        <div class="page-content">
            <div class="card">
                <div class="card-title">🔍 Find Appointment</div>
                <form action="search" method="post" style="display:flex; gap:12px; align-items:flex-end;">
                    <div class="form-group" style="flex:1; margin:0;">
                        <label for="appointmentNumber">Appointment Number</label>
                        <input type="text" id="appointmentNumber" name="appointmentNumber" placeholder="e.g. APT001">
                    </div>
                    <button type="submit" class="btn btn-primary">Search</button>
                </form>
            </div>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger">⚠ <%= request.getAttribute("error") %></div>
            <% } %>

            <% if (apt != null) { %>
            <div class="card">
                <div class="card-title">📄 Appointment Details</div>
                <div class="info-row"><span class="info-label">Appointment No</span><span><span class="badge badge-primary"><%= apt.getAppointmentNumber() %></span></span></div>
                <div class="info-row"><span class="info-label">Patient Name</span><span><%= apt.getPatientName() %></span></div>
                <div class="info-row"><span class="info-label">Address</span><span><%= apt.getAddress() %></span></div>
                <div class="info-row"><span class="info-label">Contact</span><span><%= apt.getContactNumber() %></span></div>
                <div class="info-row"><span class="info-label">Dentist</span><span><%= apt.getDentistName() %></span></div>
                <div class="info-row"><span class="info-label">Treatment</span><span><%= apt.getTreatmentName() %></span></div>
                <div class="info-row"><span class="info-label">Date</span><span><%= apt.getAppointmentDate() %></span></div>
                <div class="info-row"><span class="info-label">Time</span><span><%= apt.getAppointmentTime() %></span></div>
                <br>
                <a href="bill?appointmentNumber=<%= apt.getAppointmentNumber() %>" class="btn btn-success">💰 Generate Bill</a>
            </div>
            <% } %>
        </div>
    </div>
</div>
</body>
</html>
