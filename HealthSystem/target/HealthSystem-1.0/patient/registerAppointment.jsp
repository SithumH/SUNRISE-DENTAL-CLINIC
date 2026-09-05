<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.health.model.Patient, java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    Patient patient = (Patient) session.getAttribute("patient");
    if (patient == null) { response.sendRedirect(request.getContextPath() + "/patient/login.jsp"); return; }
    String initial = patient.getName().substring(0,1).toUpperCase();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Register Appointment</title>
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
        <a href="${pageContext.request.contextPath}/patient/appointment?action=new" class="active"><span class="nav-icon">📅</span><span>New Appointment</span></a>
        <a href="${pageContext.request.contextPath}/patient/appointment"><span class="nav-icon">🔍</span><span>My Appointments</span></a>
    </nav>
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/patient/logout"><span>🚪</span><span>Logout</span></a>
    </div>
</div>
<div class="main-content">
    <div class="topbar">
        <h4>Register Appointment</h4>
        <div class="topbar-right"><span class="badge">Patient</span></div>
    </div>
    <div class="page-content">
        <div class="card" style="max-width:550px;">
            <div class="card-title">📅 New Appointment</div>
            <% if ("success".equals(request.getParameter("msg"))) { %>
                <div class="msg-success">Appointment registered successfully!</div>
            <% } %>
            <% if ("error".equals(request.getParameter("msg"))) { %>
                <div class="msg-error">Appointment could not be registered. Please check the details and try again.</div>
            <% } %>
            <form id="apptForm" action="${pageContext.request.contextPath}/patient/appointment" method="post" onsubmit="return validateAppointment('apptForm')">
                <div class="form-group">
                    <label>Select Treatment</label>
                    <select name="treatmentId" required>
                        <option value="">-- Select Treatment --</option>
                        <c:forEach var="t" items="${treatments}">
                            <option value="${t.id}">${t.name} - Rs. ${t.price}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>Date</label>
                        <input type="date" name="date" required>
                    </div>
                    <div class="form-group">
                        <label>Time</label>
                        <input type="time" name="time" required>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary">Register Appointment</button>
            </form>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
