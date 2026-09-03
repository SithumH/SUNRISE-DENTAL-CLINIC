<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.sunrise.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) { response.sendRedirect(request.getContextPath() + "/login.jsp"); return; }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard – Sunrise Dental Clinic</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="header">
    <h1>🦷 SUNRISE DENTAL CLINIC</h1>
    <div class="user-info">
        Welcome, <%= user.getUsername() %> (<%= user.getRole() %>)
        <a href="logout">Logout</a>
    </div>
</div>

<div class="container">
    <div class="page-title">Dashboard</div>
    <div class="dashboard-grid">
        <a href="appointment" class="dash-card">
            <div class="icon">📋</div>
            <span>New Appointment</span>
        </a>
        <a href="search" class="dash-card">
            <div class="icon">🔍</div>
            <span>Search</span>
        </a>
        <a href="bill" class="dash-card">
            <div class="icon">💰</div>
            <span>Billing</span>
        </a>
        <a href="reports.jsp" class="dash-card">
            <div class="icon">📊</div>
            <span>Reports</span>
        </a>
        <a href="help.jsp" class="dash-card">
            <div class="icon">❓</div>
            <span>Help</span>
        </a>
        <a href="logout" class="dash-card">
            <div class="icon">🚪</div>
            <span>Logout</span>
        </a>
    </div>
</div>
</body>
</html>
