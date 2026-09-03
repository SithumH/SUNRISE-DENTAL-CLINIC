<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.sunrise.model.*,java.util.*" %>
<%
    if (session.getAttribute("user") == null) { response.sendRedirect(request.getContextPath() + "/login.jsp"); return; }
    List<Treatment> treatments = (List<Treatment>) request.getAttribute("treatments");
    List<String> dentists = (List<String>) request.getAttribute("dentists");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>New Appointment – Sunrise Dental Clinic</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="js/validation.js" defer></script>
</head>
<body>
<div class="header">
    <h1>🦷 SUNRISE DENTAL CLINIC</h1>
    <div class="user-info"><a href="dashboard.jsp">← Dashboard</a> <a href="logout">Logout</a></div>
</div>

<div class="container">
    <div class="page-title">Register New Appointment</div>

    <% if (request.getAttribute("success") != null) { %>
        <div class="alert alert-success"><%= request.getAttribute("success") %></div>
    <% } %>
    <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
    <% } %>
    <div id="clientError" class="alert alert-danger" style="display:none;"></div>

    <div class="card">
        <form action="appointment" method="post" onsubmit="return validateAppointmentForm()">
            <div class="form-group">
                <label for="appointmentNumber">Appointment Number</label>
                <input type="text" id="appointmentNumber" name="appointmentNumber" placeholder="e.g. APT002">
            </div>
            <div class="form-group">
                <label for="patientName">Patient Name</label>
                <input type="text" id="patientName" name="patientName" placeholder="Full name">
            </div>
            <div class="form-group">
                <label for="address">Address</label>
                <input type="text" id="address" name="address" placeholder="Patient address">
            </div>
            <div class="form-group">
                <label for="contactNumber">Contact Number</label>
                <input type="text" id="contactNumber" name="contactNumber" placeholder="10-digit number">
            </div>
            <div class="form-group">
                <label for="dentistName">Dentist Name</label>
                <select id="dentistName" name="dentistName">
                    <option value="">-- Select Dentist --</option>
                    <% if (dentists != null) for (String d : dentists) { %>
                        <option value="<%= d %>"><%= d %></option>
                    <% } %>
                </select>
            </div>
            <div class="form-group">
                <label for="treatmentId">Treatment Type</label>
                <select id="treatmentId" name="treatmentId">
                    <option value="">-- Select Treatment --</option>
                    <% if (treatments != null) for (Treatment t : treatments) { %>
                        <option value="<%= t.getTreatmentId() %>"><%= t.getTreatmentName() %> – Rs. <%= String.format("%,.0f", t.getTreatmentFee()) %></option>
                    <% } %>
                </select>
            </div>
            <div class="form-group">
                <label for="appointmentDate">Appointment Date</label>
                <input type="date" id="appointmentDate" name="appointmentDate">
            </div>
            <div class="form-group">
                <label for="appointmentTime">Appointment Time</label>
                <input type="time" id="appointmentTime" name="appointmentTime">
            </div>
            <button type="submit" class="btn btn-primary">SAVE APPOINTMENT</button>
        </form>
    </div>
</div>
</body>
</html>
