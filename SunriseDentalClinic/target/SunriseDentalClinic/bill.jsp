<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.sunrise.model.Appointment" %>
<%
    if (session.getAttribute("user") == null) { response.sendRedirect(request.getContextPath() + "/login.jsp"); return; }
    Appointment apt = (Appointment) request.getAttribute("appointment");
    Double treatFee  = (Double) request.getAttribute("treatmentFee");
    Double consFee   = (Double) request.getAttribute("consultationFee");
    Double total     = (Double) request.getAttribute("totalAmount");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Billing – Sunrise Dental Clinic</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="header">
    <h1>🦷 SUNRISE DENTAL CLINIC</h1>
    <div class="user-info"><a href="dashboard.jsp">← Dashboard</a> <a href="logout">Logout</a></div>
</div>

<div class="container">
    <div class="page-title">Patient Billing</div>

    <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
    <% } %>
    <% if (request.getAttribute("saved") != null) { %>
        <div class="alert alert-success">Bill saved successfully.</div>
    <% } %>

    <!-- Search form -->
    <% if (apt == null) { %>
    <div class="card">
        <form action="bill" method="get">
            <div style="display:flex; gap:12px; align-items:flex-end;">
                <div class="form-group" style="flex:1; margin:0;">
                    <label for="appointmentNumber">Appointment Number</label>
                    <input type="text" id="appointmentNumber" name="appointmentNumber" placeholder="e.g. APT001">
                </div>
                <button type="submit" class="btn btn-primary">CALCULATE</button>
            </div>
        </form>
    </div>
    <% } %>

    <% if (apt != null) { %>
    <div class="card" id="billPrint">
        <h3 style="color:#1a6b8a; margin-bottom:16px;">🦷 Sunrise Dental Clinic – Bill</h3>
        <div class="info-row"><span class="info-label">Appointment No</span><span><%= apt.getAppointmentNumber() %></span></div>
        <div class="info-row"><span class="info-label">Patient Name</span><span><%= apt.getPatientName() %></span></div>
        <div class="info-row"><span class="info-label">Dentist</span><span><%= apt.getDentistName() %></span></div>
        <div class="info-row"><span class="info-label">Date</span><span><%= apt.getAppointmentDate() %></span></div>
        <br>
        <div class="bill-detail"><span>Treatment: <%= apt.getTreatmentName() %></span><span>Rs. <%= String.format("%,.2f", treatFee) %></span></div>
        <div class="bill-detail"><span>Consultation Fee</span><span>Rs. <%= String.format("%,.2f", consFee) %></span></div>
        <div class="bill-total"><span>TOTAL</span><span>Rs. <%= String.format("%,.2f", total) %></span></div>
        <br>
        <form action="bill" method="post" style="display:inline;">
            <input type="hidden" name="appointmentNumber" value="<%= apt.getAppointmentNumber() %>">
            <button type="submit" class="btn btn-success">SAVE BILL</button>
        </form>
        <button onclick="window.print()" class="btn btn-warning" style="margin-left:8px;">🖨 PRINT BILL</button>
    </div>
    <% } %>
</div>
</body>
</html>
