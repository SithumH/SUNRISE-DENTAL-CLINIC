<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.sunrise.model.*,com.sunrise.model.User,java.util.*" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) { response.sendRedirect(request.getContextPath() + "/login"); return; }
    List<Treatment> treatments = (List<Treatment>) request.getAttribute("treatments");
    List<String> dentists = (List<String>) request.getAttribute("dentists");
    String initial = user.getUsername().substring(0,1).toUpperCase();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>New Appointment – Sunrise Dental Clinic</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="js/validation.js" defer></script>
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
            <a href="appointment" class="nav-item active"><span class="nav-icon">📋</span><span>New Appointment</span></a>
            <a href="search" class="nav-item"><span class="nav-icon">🔍</span><span>Search</span></a>
            <a href="bill" class="nav-item"><span class="nav-icon">💰</span><span>Billing</span></a>
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
            <div class="topbar-title">New Appointment</div>
            <div class="topbar-right">
                <a href="dashboard.jsp" class="btn btn-outline btn-sm">← Dashboard</a>
            </div>
        </div>

        <div class="page-content">
            <% if (request.getAttribute("success") != null) { %>
                <div class="alert alert-success">✓ <%= request.getAttribute("success") %></div>
            <% } %>
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger">⚠ <%= request.getAttribute("error") %></div>
            <% } %>
            <div id="clientError" class="alert alert-danger" style="display:none;"></div>

            <div class="card">
                <div class="card-title">📋 Patient & Appointment Details</div>
                <form action="appointment" method="post" onsubmit="return validateAppointmentForm()">
                    <div class="form-grid-2">
                        <div class="form-group">
                            <label for="appointmentNumber">Appointment Number</label>
                            <input type="text" id="appointmentNumber" name="appointmentNumber" placeholder="e.g. APT002">
                        </div>
                        <div class="form-group">
                            <label for="patientName">Patient Name</label>
                            <input type="text" id="patientName" name="patientName" placeholder="Full name">
                        </div>
                        <div class="form-group">
                            <label for="contactNumber">Contact Number</label>
                            <input type="text" id="contactNumber" name="contactNumber" placeholder="10-digit number">
                        </div>
                        <div class="form-group">
                            <label for="address">Address</label>
                            <input type="text" id="address" name="address" placeholder="Patient address">
                        </div>
                        <div class="form-group">
                            <label for="dentistName">Dentist</label>
                            <select id="dentistName" name="dentistName">
                                <option value="">-- Select Dentist --</option>
                                <% if (dentists != null) for (String d : dentists) { %>
                                    <option value="<%= d %>"><%= d %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="treatmentId">Treatment</label>
                            <select id="treatmentId" name="treatmentId">
                                <option value="">-- Select Treatment --</option>
                                <% if (treatments != null) for (Treatment t : treatments) { %>
                                    <option value="<%= t.getTreatmentId() %>"><%= t.getTreatmentName() %> – Rs. <%= String.format("%,.0f", t.getTreatmentFee()) %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="appointmentDate">Date</label>
                            <input type="date" id="appointmentDate" name="appointmentDate">
                        </div>
                        <div class="form-group">
                            <label for="appointmentTime">Time</label>
                            <input type="time" id="appointmentTime" name="appointmentTime">
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary">Save Appointment</button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
