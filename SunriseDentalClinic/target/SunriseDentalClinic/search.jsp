<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.sunrise.model.Appointment" %>
<%
    if (session.getAttribute("user") == null) { response.sendRedirect(request.getContextPath() + "/login.jsp"); return; }
    Appointment apt = (Appointment) request.getAttribute("appointment");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Search – Sunrise Dental Clinic</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="header">
    <h1>🦷 SUNRISE DENTAL CLINIC</h1>
    <div class="user-info"><a href="dashboard.jsp">← Dashboard</a> <a href="logout">Logout</a></div>
</div>

<div class="container">
    <div class="page-title">Search Appointment</div>

    <div class="card">
        <form action="search" method="post">
            <div style="display:flex; gap:12px; align-items:flex-end;">
                <div class="form-group" style="flex:1; margin:0;">
                    <label for="appointmentNumber">Appointment Number</label>
                    <input type="text" id="appointmentNumber" name="appointmentNumber" placeholder="e.g. APT001">
                </div>
                <button type="submit" class="btn btn-primary">SEARCH</button>
            </div>
        </form>
    </div>

    <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
    <% } %>

    <% if (apt != null) { %>
    <div class="card">
        <div class="info-row"><span class="info-label">Appointment No</span><span><%= apt.getAppointmentNumber() %></span></div>
        <div class="info-row"><span class="info-label">Patient Name</span><span><%= apt.getPatientName() %></span></div>
        <div class="info-row"><span class="info-label">Address</span><span><%= apt.getAddress() %></span></div>
        <div class="info-row"><span class="info-label">Contact</span><span><%= apt.getContactNumber() %></span></div>
        <div class="info-row"><span class="info-label">Dentist</span><span><%= apt.getDentistName() %></span></div>
        <div class="info-row"><span class="info-label">Treatment</span><span><%= apt.getTreatmentName() %></span></div>
        <div class="info-row"><span class="info-label">Date</span><span><%= apt.getAppointmentDate() %></span></div>
        <div class="info-row"><span class="info-label">Time</span><span><%= apt.getAppointmentTime() %></span></div>
        <br>
        <a href="bill?appointmentNumber=<%= apt.getAppointmentNumber() %>" class="btn btn-success">Generate Bill</a>
    </div>
    <% } %>
</div>
</body>
</html>
