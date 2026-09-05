<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.health.model.Patient" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    Patient patient = (Patient) session.getAttribute("patient");
    if (patient == null) { response.sendRedirect(request.getContextPath() + "/patient/login.jsp"); return; }
    String initial = patient.getName().substring(0,1).toUpperCase();
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Appointments</title>
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
            <span>Patient</span>
        </div>
    </div>
    <nav class="sidebar-nav">
        <div class="nav-section-title">Menu</div>
        <a href="dashboard.jsp"><span class="nav-icon">🏠</span><span>Dashboard</span></a>
        <a href="${pageContext.request.contextPath}/patient/appointment?action=new"><span class="nav-icon">📅</span><span>New Appointment</span></a>
        <a href="${pageContext.request.contextPath}/patient/appointment" class="active"><span class="nav-icon">🔍</span><span>My Appointments</span></a>
    </nav>
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/patient/logout"><span>🚪</span><span>Logout</span></a>
    </div>
</div>
<div class="main-content">
    <div class="topbar">
        <h4>My Appointments</h4>
        <div class="topbar-right">
            <a href="${pageContext.request.contextPath}/patient/appointment?action=new" class="btn btn-primary" style="padding:8px 16px; font-size:13px;">+ New Appointment</a>
        </div>
    </div>
    <div class="page-content">
        <div class="card">
            <div class="card-title">🔍 Appointment History</div>
            <% if ("success".equals(request.getParameter("msg"))) { %><div class="msg-success">Appointment registered successfully!</div><% } %>
            <table>
                <tr><th>#</th><th>Treatment</th><th>Date</th><th>Time</th><th>Status</th><th>Bill (Rs.)</th></tr>
                <c:forEach var="a" items="${appointments}">
                    <tr>
                        <td>${a.id}</td>
                        <td>${a.treatmentName}</td>
                        <td>${a.date}</td>
                        <td>${a.time}</td>
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
