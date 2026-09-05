<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.health.model.Staff,com.health.model.Appointment" %>
<%
    Staff staff = (Staff) session.getAttribute("staff");
    if (staff == null) { response.sendRedirect(request.getContextPath() + "/staff/login.jsp"); return; }
    String initial = staff.getName().substring(0,1).toUpperCase();
    Appointment appt = (Appointment) request.getAttribute("appointment");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Calculate Bill</title>
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
        <a href="${pageContext.request.contextPath}/staff/bill" class="active"><span class="nav-icon">🧮</span><span>Calculate Bill</span></a>
        <div class="nav-section-title">Other</div>
        <a href="reports.jsp"><span class="nav-icon">📊</span><span>View Reports</span></a>
        <a href="help.jsp"><span class="nav-icon">❓</span><span>Help Section</span></a>
    </nav>
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/staff/logout"><span>🚪</span><span>Logout</span></a>
    </div>
</div>
<div class="main-content">
    <div class="topbar">
        <h4>Calculate Bill</h4>
        <div class="topbar-right"><span class="badge"><%= staff.getRole() %></span></div>
    </div>
    <div class="page-content">
        <div class="card" style="max-width:550px;">
            <div class="card-title">🧮 Bill Calculator</div>
            <% if ("invalid".equals(request.getParameter("msg"))) { %>
                <div class="msg-error">Please enter a valid appointment ID and amount.</div>
            <% } else if ("notfound".equals(request.getParameter("msg"))) { %>
                <div class="msg-error">Appointment not found.</div>
            <% } else if ("error".equals(request.getParameter("msg"))) { %>
                <div class="msg-error">Could not save the bill. Please try again.</div>
            <% } else if (request.getAttribute("error") != null) { %>
                <div class="msg-error"><%= request.getAttribute("error") %></div>
            <% } %>
            <% if (appt != null) { %>
            <div style="background:#f8f9fa; border-radius:8px; padding:15px; margin-bottom:20px;">
                <p style="font-size:13px; color:#555;"><strong>Patient:</strong> <%= appt.getPatientName() %> &nbsp;|&nbsp; <strong>Treatment:</strong> <%= appt.getTreatmentName() %> &nbsp;|&nbsp; <strong>Date:</strong> <%= appt.getDate() %></p>
            </div>
            <% } %>
            <form action="${pageContext.request.contextPath}/staff/bill" method="post" onsubmit="return validateBill()">
                <% if (appt != null) { %>
                    <input type="hidden" name="appointmentId" value="<%= appt.getId() %>">
                <% } else { %>
                    <div class="form-group">
                        <label>Appointment ID</label>
                        <input type="number" name="appointmentId" placeholder="Enter appointment ID" required>
                    </div>
                <% } %>
                <div class="form-group">
                    <label>Consultation Fee (Rs.)</label>
                    <input type="number" id="consultation" step="0.01" value="0" oninput="calcTotal()">
                </div>
                <div class="form-group">
                    <label>Medicine Fee (Rs.)</label>
                    <input type="number" id="medicine" step="0.01" value="0" oninput="calcTotal()">
                </div>
                <div class="form-group">
                    <label>Other Charges (Rs.)</label>
                    <input type="number" id="other" step="0.01" value="0" oninput="calcTotal()">
                </div>
                <div class="form-group">
                    <label><strong>Total Amount (Rs.)</strong></label>
                    <input type="number" id="amount" name="amount" step="0.01" required readonly style="background:#f0f4f8; font-weight:700; font-size:16px;">
                </div>
                <button type="submit" class="btn btn-success">Generate Bill</button>
            </form>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
<script>
function calcTotal() {
    var c = parseFloat(document.getElementById('consultation').value) || 0;
    var m = parseFloat(document.getElementById('medicine').value) || 0;
    var o = parseFloat(document.getElementById('other').value) || 0;
    document.getElementById('amount').value = (c + m + o).toFixed(2);
}
</script>
</body>
</html>
