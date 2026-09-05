<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.health.model.Staff,com.health.model.Appointment" %>
<%
    Staff staff = (Staff) session.getAttribute("staff");
    if (staff == null) { response.sendRedirect(request.getContextPath() + "/staff/login.jsp"); return; }
    String initial = staff.getName().substring(0,1).toUpperCase();
    Appointment a = (Appointment) request.getAttribute("appointment");
    Double amount = (Double) request.getAttribute("amount");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Print Bill</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="sidebar no-print">
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
        <div class="nav-section-title">Billing</div>
        <a href="${pageContext.request.contextPath}/staff/bill" class="active"><span class="nav-icon">🧮</span><span>Calculate Bill</span></a>
    </nav>
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/staff/logout"><span>🚪</span><span>Logout</span></a>
    </div>
</div>

<div class="main-content">
    <div class="topbar no-print">
        <h4>Print Bill</h4>
        <div class="topbar-right">
            <button onclick="printBill()" class="btn btn-print">🖨️ Print</button>
            <a href="dashboard.jsp" class="btn btn-outline" style="margin-left:10px;">Back</a>
        </div>
    </div>
    <div class="page-content">
        <div class="card" style="max-width:600px; margin:0 auto;">
            <div style="text-align:center; margin-bottom:25px;">
                <div style="font-size:48px;">🏥</div>
                <h2 style="color:#1a1a2e; margin-top:10px;">Dental Clinic</h2>
                <p style="color:#888; font-size:13px;">Official Bill Receipt</p>
                <hr style="margin:15px 0; border-color:#f0f4f8;">
            </div>
            <% if (a != null) { %>
            <table style="margin-bottom:20px;">
                <tr><td style="color:#888; font-size:13px; padding:8px 0; border:none;">Bill No</td><td style="font-weight:600; border:none;">#<%= a.getId() %></td></tr>
                <tr><td style="color:#888; font-size:13px; padding:8px 0; border:none;">Patient</td><td style="font-weight:600; border:none;"><%= a.getPatientName() %></td></tr>
                <tr><td style="color:#888; font-size:13px; padding:8px 0; border:none;">Treatment</td><td style="font-weight:600; border:none;"><%= a.getTreatmentName() %></td></tr>
                <tr><td style="color:#888; font-size:13px; padding:8px 0; border:none;">Date</td><td style="font-weight:600; border:none;"><%= a.getDate() %></td></tr>
                <tr><td style="color:#888; font-size:13px; padding:8px 0; border:none;">Time</td><td style="font-weight:600; border:none;"><%= a.getTime() %></td></tr>
                <tr><td colspan="2"><hr style="border-color:#f0f4f8; margin:5px 0;"></td></tr>
                <tr><td style="color:#1a1a2e; font-weight:700; font-size:15px; padding:8px 0; border:none;">Total Amount</td><td style="font-weight:700; font-size:18px; color:#e94560; border:none;">Rs. <%= String.format("%.2f", amount) %></td></tr>
            </table>
            <% } %>
            <hr style="border-color:#f0f4f8; margin:15px 0;">
            <p style="text-align:center; color:#aaa; font-size:12px;">Thank you for choosing Dental Clinic</p>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
