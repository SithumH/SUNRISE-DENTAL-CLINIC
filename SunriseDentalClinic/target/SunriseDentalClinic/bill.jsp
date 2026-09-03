<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.sunrise.model.Appointment, com.sunrise.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) { response.sendRedirect(request.getContextPath() + "/login"); return; }
    Appointment apt = (Appointment) request.getAttribute("appointment");
    Double treatFee = (Double) request.getAttribute("treatmentFee");
    Double consFee  = (Double) request.getAttribute("consultationFee");
    Double total    = (Double) request.getAttribute("totalAmount");
    String initial  = user.getUsername().substring(0,1).toUpperCase();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Billing – Sunrise Dental Clinic</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="layout">
    <aside class="sidebar">
        <div class="sidebar-brand">
            <span class="brand-icon">🦷</span>
            <h2>SUNRISE DENTAL</h2>
            <p>Clinic Management</p>
        </div>
        <nav class="sidebar-nav">
            <div class="nav-section-label">Main</div>
            <a href="dashboard.jsp" class="nav-item"><span class="nav-icon">🏠</span><span>Dashboard</span></a>
            <a href="appointment" class="nav-item"><span class="nav-icon">📋</span><span>New Appointment</span></a>
            <a href="search" class="nav-item"><span class="nav-icon">🔍</span><span>Search</span></a>
            <a href="bill" class="nav-item active"><span class="nav-icon">💰</span><span>Billing</span></a>
            <div class="nav-section-label">Reports</div>
            <a href="reports?type=daily" class="nav-item"><span class="nav-icon">📅</span><span>Daily Report</span></a>
            <a href="reports?type=revenue" class="nav-item"><span class="nav-icon">📊</span><span>Revenue</span></a>
            <a href="reports?type=treatment" class="nav-item"><span class="nav-icon">🦷</span><span>Treatments</span></a>
            <a href="reports?type=patient" class="nav-item"><span class="nav-icon">👤</span><span>Patient History</span></a>
            <div class="nav-section-label">Other</div>
            <a href="help.jsp" class="nav-item"><span class="nav-icon">❓</span><span>Help</span></a>
        </nav>
        <div class="sidebar-footer">
            <div class="sidebar-user">
                <div class="avatar"><%= initial %></div>
                <div class="user-details">
                    <div class="user-name"><%= user.getUsername() %></div>
                    <div class="user-role"><%= user.getRole() %></div>
                </div>
                <a href="logout" class="logout-btn" title="Logout">⏻</a>
            </div>
        </div>
    </aside>

    <div class="main-content">
        <div class="topbar">
            <div class="topbar-title">Patient Billing</div>
            <div class="topbar-right">
                <a href="dashboard.jsp" class="btn btn-outline btn-sm">← Dashboard</a>
            </div>
        </div>

        <div class="page-content">
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger">⚠ <%= request.getAttribute("error") %></div>
            <% } %>
            <% if (request.getAttribute("saved") != null) { %>
                <div class="alert alert-success">✓ Bill saved successfully.</div>
            <% } %>

            <% if (apt == null) { %>
            <div class="card">
                <div class="card-title">💰 Find Appointment to Bill</div>
                <form action="bill" method="get" style="display:flex; gap:12px; align-items:flex-end;">
                    <div class="form-group" style="flex:1; margin:0;">
                        <label for="appointmentNumber">Appointment Number</label>
                        <input type="text" id="appointmentNumber" name="appointmentNumber" placeholder="e.g. APT001">
                    </div>
                    <button type="submit" class="btn btn-primary">Calculate</button>
                </form>
            </div>
            <% } %>

            <% if (apt != null) { %>
            <div class="card" id="billPrint">
                <div class="card-title">🦷 Sunrise Dental Clinic — Invoice</div>

                <div class="info-row"><span class="info-label">Appointment No</span><span><span class="badge badge-primary"><%= apt.getAppointmentNumber() %></span></span></div>
                <div class="info-row"><span class="info-label">Patient Name</span><span><%= apt.getPatientName() %></span></div>
                <div class="info-row"><span class="info-label">Dentist</span><span><%= apt.getDentistName() %></span></div>
                <div class="info-row"><span class="info-label">Date</span><span><%= apt.getAppointmentDate() %></span></div>

                <br>
                <div class="bill-detail">
                    <span>Treatment: <strong><%= apt.getTreatmentName() %></strong></span>
                    <span>Rs. <%= String.format("%,.2f", treatFee) %></span>
                </div>
                <div class="bill-detail">
                    <span>Consultation Fee</span>
                    <span>Rs. <%= String.format("%,.2f", consFee) %></span>
                </div>
                <div class="bill-total">
                    <span>TOTAL AMOUNT</span>
                    <span>Rs. <%= String.format("%,.2f", total) %></span>
                </div>
                <br>
                <div style="display:flex; gap:10px; flex-wrap:wrap;">
                    <form action="bill" method="post" style="display:inline;">
                        <input type="hidden" name="appointmentNumber" value="<%= apt.getAppointmentNumber() %>">
                        <button type="submit" class="btn btn-success">💾 Save Bill</button>
                    </form>
                    <button onclick="window.print()" class="btn btn-warning">🖨 Print Bill</button>
                    <a href="bill" class="btn btn-outline">New Bill</a>
                </div>
            </div>
            <% } %>
        </div>
    </div>
</div>
</body>
</html>
