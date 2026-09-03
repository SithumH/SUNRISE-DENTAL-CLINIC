<%@ page contentType="text/html;charset=UTF-8" %>
<%
    if (session.getAttribute("user") == null) { response.sendRedirect(request.getContextPath() + "/login.jsp"); return; }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Help – Sunrise Dental Clinic</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="header">
    <h1>🦷 SUNRISE DENTAL CLINIC</h1>
    <div class="user-info"><a href="dashboard.jsp">← Dashboard</a> <a href="logout">Logout</a></div>
</div>
<div class="container">
    <div class="page-title">Help & User Guide</div>
    <div class="card">
        <h3 style="margin-bottom:12px;">How to use the system</h3>
        <ul style="line-height:2; padding-left:20px;">
            <li><strong>New Appointment</strong> – Register a new patient appointment with dentist and treatment details.</li>
            <li><strong>Search</strong> – Find an appointment using the appointment number.</li>
            <li><strong>Billing</strong> – Calculate and print the bill for a completed appointment.</li>
            <li><strong>Reports</strong> – View daily, dentist-wise, and revenue reports.</li>
            <li><strong>Logout</strong> – Securely end your session.</li>
        </ul>
    </div>
    <div class="card">
        <h3 style="margin-bottom:12px;">Contact Support</h3>
        <p>For technical issues, contact the system administrator.</p>
    </div>
</div>
</body>
</html>
