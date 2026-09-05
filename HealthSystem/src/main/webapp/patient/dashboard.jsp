<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.health.model.Patient" %>
<%
    Patient patient = (Patient) session.getAttribute("patient");
    if (patient == null) { response.sendRedirect(request.getContextPath() + "/patient/login.jsp"); return; }
    String initial = patient.getName().substring(0,1).toUpperCase();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Patient Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<button class="hamburger" id="hamburger"><span></span><span></span><span></span></button>
<div class="sidebar-overlay" id="sidebarOverlay"></div>
<div class="sidebar">
    <div class="sidebar-brand">
        <div class="brand-icon">🏥</div>
        <h3>Dental Clinic</h3>
        <p>User Portal</p>
    </div>
    <div class="sidebar-user">
        <div class="avatar"><%= initial %></div>
        <div class="user-info">
            <p><%= patient.getName() %></p>
            <span>User</span>
        </div>
    </div>
    <nav class="sidebar-nav">
        <div class="nav-section-title">Menu</div>
        <a href="dashboard.jsp" class="active"><span class="nav-icon">🏠</span><span>Dashboard</span></a>
        <a href="${pageContext.request.contextPath}/patient/appointment?action=new"><span class="nav-icon">📅</span><span>New Appointment</span></a>
        <a href="${pageContext.request.contextPath}/patient/appointment"><span class="nav-icon">🔍</span><span>My Appointments</span></a>
    </nav>
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/patient/logout"><span class="nav-icon">🚪</span><span>Logout</span></a>
    </div>
</div>
<div class="main-content">
    <div class="topbar">
        <h4>Dashboard</h4>
        <div class="topbar-right">
            <span class="badge">User</span>
            <span style="font-size:13px; color:#888;">Welcome, <%= patient.getName() %></span>
        </div>
    </div>
    <div class="page-content">
        <div class="dashboard-grid">
            <a href="${pageContext.request.contextPath}/patient/appointment?action=new" class="dashboard-card">
                <div class="icon">📅</div><p>New Appointment</p>
            </a>
            <a href="${pageContext.request.contextPath}/patient/appointment" class="dashboard-card">
                <div class="icon">🔍</div><p>My Appointments</p>
            </a>
            <a href="${pageContext.request.contextPath}/patient/logout" class="dashboard-card">
                <div class="icon">🚪</div><p>Logout</p>
            </a>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
