<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.health.dao.*,com.health.model.*,java.util.*" %>
<%
    if (session.getAttribute("admin") == null) { response.sendRedirect(request.getContextPath() + "/admin/login.jsp"); return; }
    int totalPatients = new PatientDAO().getAll().size();
    int totalStaff = new StaffDAO().getAll().size();
    int totalAppointments = new AppointmentDAO().getAll().size();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="sidebar.jsp" %>
<div class="main-content">
    <div class="topbar">
        <h4>Admin Dashboard</h4>
        <div class="topbar-right"><span class="badge">Admin</span></div>
    </div>
    <div class="page-content">
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon green">👨💼</div>
                <div class="stat-info"><h3><%= totalStaff %></h3><p>Total Staff</p></div>
            </div>
            <div class="stat-card">
                <div class="stat-icon orange">👤</div>
                <div class="stat-info"><h3><%= totalPatients %></h3><p>Total Patients</p></div>
            </div>
            <div class="stat-card">
                <div class="stat-icon red">📅</div>
                <div class="stat-info"><h3><%= totalAppointments %></h3><p>Total Appointments</p></div>
            </div>
        </div>
        <div class="dashboard-grid">
            <a href="${pageContext.request.contextPath}/admin/staff" class="dashboard-card">
                <div class="icon">👨💼</div><p>Manage Staff</p>
            </a>
               <a href="${pageContext.request.contextPath}/admin/treatments" class="dashboard-card">
                   <div class="icon">🦷</div><p>Manage Treatments</p>
               </a>
            <a href="${pageContext.request.contextPath}/admin/patients" class="dashboard-card">
                <div class="icon">👤</div><p>Manage Patients</p>
            </a>
            <a href="${pageContext.request.contextPath}/admin/appointments" class="dashboard-card">
                <div class="icon">📅</div><p>Manage Appointments</p>
            </a>
            <a href="${pageContext.request.contextPath}/admin/reports" class="dashboard-card">
                <div class="icon">📊</div><p>View Reports</p>
            </a>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
