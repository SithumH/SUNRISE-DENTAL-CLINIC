<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.health.model.Staff" %>
<%
    Staff staff = (Staff) session.getAttribute("staff");
    if (staff == null) { response.sendRedirect(request.getContextPath() + "/staff/login.jsp"); return; }
    String initial = staff.getName().substring(0,1).toUpperCase();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Help Section</title>
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
        <div class="nav-section-title">Appointments</div>
        <a href="${pageContext.request.contextPath}/staff/appointment?action=new"><span class="nav-icon">📅</span><span>New Appointment</span></a>
        <a href="${pageContext.request.contextPath}/staff/appointment"><span class="nav-icon">🔍</span><span>Search Appointments</span></a>
        <div class="nav-section-title">Billing</div>
        <a href="${pageContext.request.contextPath}/staff/bill"><span class="nav-icon">🧮</span><span>Calculate Bill</span></a>
        <div class="nav-section-title">Other</div>
        <a href="reports.jsp"><span class="nav-icon">📊</span><span>View Reports</span></a>
        <a href="help.jsp" class="active"><span class="nav-icon">❓</span><span>Help Section</span></a>
    </nav>
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/staff/logout"><span>🚪</span><span>Logout</span></a>
    </div>
</div>
<div class="main-content">
    <div class="topbar">
        <h4>Help Section</h4>
        <div class="topbar-right"><span class="badge"><%= staff.getRole() %></span></div>
    </div>
    <div class="page-content">
        <div class="card">
            <div class="card-title">❓ Help & Guide</div>
            <div style="display:grid; grid-template-columns: repeat(auto-fit, minmax(260px,1fr)); gap:15px;">
                <div style="background:#f8f9fa; border-radius:10px; padding:20px; border-left:4px solid #1a73e8;">
                    <h4 style="color:#1a73e8; margin-bottom:8px;">📅 Register Appointment</h4>
                    <p style="font-size:13px; color:#666; line-height:1.6;">Go to New Appointment from the sidebar. Fill in patient name, select a dental treatment, date and time, then click Register.</p>
                </div>
                <div style="background:#f8f9fa; border-radius:10px; padding:20px; border-left:4px solid #43a047;">
                    <h4 style="color:#43a047; margin-bottom:8px;">🔍 Search Appointments</h4>
                    <p style="font-size:13px; color:#666; line-height:1.6;">Go to Search Appointments to view all appointments. Click Bill next to any appointment to generate a bill.</p>
                </div>
                <div style="background:#f8f9fa; border-radius:10px; padding:20px; border-left:4px solid #e94560;">
                    <h4 style="color:#e94560; margin-bottom:8px;">🧮 Calculate Bill</h4>
                    <p style="font-size:13px; color:#666; line-height:1.6;">Enter consultation fee, medicine fee, and other charges. Total is calculated automatically. Click Generate Bill to save.</p>
                </div>
                <div style="background:#f8f9fa; border-radius:10px; padding:20px; border-left:4px solid #ff9800;">
                    <h4 style="color:#ff9800; margin-bottom:8px;">📊 View Reports</h4>
                    <p style="font-size:13px; color:#666; line-height:1.6;">Reports page shows summary of all appointments including total count, billed, pending, and total revenue.</p>
                </div>
                <div style="background:#f8f9fa; border-radius:10px; padding:20px; border-left:4px solid #6d4c41;">
                    <h4 style="color:#6d4c41; margin-bottom:8px;">🖨️ Print Bill</h4>
                    <p style="font-size:13px; color:#666; line-height:1.6;">After generating a bill, click Print Bill button to print the receipt. Navigation will be hidden during printing.</p>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
