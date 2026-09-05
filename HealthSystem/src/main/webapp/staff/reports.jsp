<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.health.model.Staff,com.health.dao.AppointmentDAO,com.health.model.Appointment,java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    Staff staff = (Staff) session.getAttribute("staff");
    if (staff == null) { response.sendRedirect(request.getContextPath() + "/staff/login.jsp"); return; }
    String initial = staff.getName().substring(0,1).toUpperCase();
    List<Appointment> all = new AppointmentDAO().getAll();
    int total = all.size();
    long billed = 0;
    long pending = 0;
    double totalRevenue = 0;
    for (Appointment appointment : all) {
        if ("Billed".equals(appointment.getStatus())) billed++;
        if ("Pending".equals(appointment.getStatus())) pending++;
        totalRevenue += appointment.getBillAmount();
    }
    request.setAttribute("appointments", all);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Reports</title>
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
        <a href="dashboard.jsp"><span class="nav-icon">🏠</span><span>Dashboard</span></a>
        <div class="nav-section-title">Appointments</div>
        <a href="${pageContext.request.contextPath}/staff/appointment?action=new"><span class="nav-icon">📅</span><span>New Appointment</span></a>
        <a href="${pageContext.request.contextPath}/staff/appointment"><span class="nav-icon">🔍</span><span>Search Appointments</span></a>
        <div class="nav-section-title">Billing</div>
        <a href="${pageContext.request.contextPath}/staff/bill"><span class="nav-icon">🧮</span><span>Calculate Bill</span></a>
        <div class="nav-section-title">Other</div>
        <a href="reports.jsp" class="active"><span class="nav-icon">📊</span><span>View Reports</span></a>
        <a href="help.jsp"><span class="nav-icon">❓</span><span>Help Section</span></a>
    </nav>
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/staff/logout"><span>🚪</span><span>Logout</span></a>
    </div>
</div>
<div class="main-content">
    <div class="topbar">
        <h4>Reports</h4>
        <div class="topbar-right"><span class="badge"><%= staff.getRole() %></span></div>
    </div>
    <div class="page-content">
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon blue">📋</div>
                <div class="stat-info"><h3><%= total %></h3><p>Total Appointments</p></div>
            </div>
            <div class="stat-card">
                <div class="stat-icon green">✅</div>
                <div class="stat-info"><h3><%= billed %></h3><p>Billed</p></div>
            </div>
            <div class="stat-card">
                <div class="stat-icon orange">⏳</div>
                <div class="stat-info"><h3><%= pending %></h3><p>Pending</p></div>
            </div>
            <div class="stat-card">
                <div class="stat-icon red">💰</div>
                <div class="stat-info"><h3>Rs. <%= String.format("%.0f", totalRevenue) %></h3><p>Total Revenue</p></div>
            </div>
        </div>
        <div class="card">
            <div class="card-title">📊 Appointment Details</div>
            <table>
                <tr><th>#</th><th>Patient</th><th>Treatment</th><th>Date</th><th>Status</th><th>Bill (Rs.)</th></tr>
                <c:forEach var="a" items="${appointments}">
                    <tr>
                        <td>${a.id}</td>
                        <td>${a.patientName}</td>
                        <td>${a.treatmentName}</td>
                        <td>${a.date}</td>
                        <td><span class="badge-status ${a.status == 'Billed' ? 'badge-billed' : 'badge-pending'}">${a.status}</span></td>
                        <td>Rs. ${a.billAmount}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
