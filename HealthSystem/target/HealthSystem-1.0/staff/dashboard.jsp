<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.health.model.Staff" %>
<%
    Staff staff = (Staff) session.getAttribute("staff");
    if (staff == null) { response.sendRedirect(request.getContextPath() + "/staff/login.jsp"); return; }
    String initial = staff.getName().substring(0,1).toUpperCase();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Staff Dashboard</title>
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
        <p>Staff Portal</p>
    </div>
    <div class="sidebar-user">
        <div class="avatar"><%= initial %></div>
        <div class="user-info">
            <p><%= staff.getName() %></p>
            <span><%= staff.getRole() %></span>
        </div>
    </div>
    <nav class="sidebar-nav">
        <div class="nav-section-title">Main</div>
        <a href="dashboard.jsp" class="active"><span class="nav-icon">🏠</span><span>Dashboard</span></a>
        <div class="nav-section-title">Appointments</div>
        <a href="${pageContext.request.contextPath}/staff/appointment?action=new"><span class="nav-icon">📅</span><span>New Appointment</span></a>
        <a href="${pageContext.request.contextPath}/staff/appointment"><span class="nav-icon">🔍</span><span>Search Appointments</span></a>
        <div class="nav-section-title">Billing</div>
        <a href="${pageContext.request.contextPath}/staff/bill"><span class="nav-icon">🧮</span><span>Calculate Bill</span></a>
        <div class="nav-section-title">Other</div>
        <a href="reports.jsp"><span class="nav-icon">📊</span><span>View Reports</span></a>
        <a href="help.jsp"><span class="nav-icon">❓</span><span>Help Section</span></a>
    </nav>
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/staff/logout"><span class="nav-icon">🚪</span><span>Logout</span></a>
    </div>
</div>
<div class="main-content">
    <div class="topbar">
        <h4>Dashboard</h4>
        <div class="topbar-right">
            <span class="badge"><%= staff.getRole() %></span>
            <span style="font-size:13px; color:#888;">Welcome, <%= staff.getName() %></span>
        </div>
    </div>
    <div class="page-content">
        <div class="dashboard-grid">
            <a href="${pageContext.request.contextPath}/staff/appointment?action=new" class="dashboard-card">
                <div class="icon">📅</div><p>New Appointment</p>
            </a>
            <a href="${pageContext.request.contextPath}/staff/appointment" class="dashboard-card">
                <div class="icon">🔍</div><p>Search Appointments</p>
            </a>
            <a href="${pageContext.request.contextPath}/staff/bill" class="dashboard-card">
                <div class="icon">🧮</div><p>Calculate Bill</p>
            </a>
            <a href="reports.jsp" class="dashboard-card">
                <div class="icon">📊</div><p>View Reports</p>
            </a>
            <a href="help.jsp" class="dashboard-card">
                <div class="icon">❓</div><p>Help Section</p>
            </a>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
