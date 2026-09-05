<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% if (session.getAttribute("admin") == null) { response.sendRedirect(request.getContextPath() + "/admin/login.jsp"); return; } %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Appointments</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="sidebar.jsp" %>
<div class="main-content">
    <div class="topbar">
        <h4>Manage Appointments</h4>
        <div class="topbar-right"><span class="badge">Admin</span></div>
    </div>
    <div class="page-content">
        <div class="card">
            <div class="card-title">📅 All Appointments</div>
            <% if ("deleted".equals(request.getParameter("msg"))) { %><div class="msg-success">Appointment deleted.</div><% } %>
            <table>
                <tr><th>#</th><th>Patient</th><th>Treatment</th><th>Date</th><th>Time</th><th>Status</th><th>Bill</th><th>Action</th></tr>
                <c:forEach var="a" items="${appointments}">
                    <tr>
                        <td>${a.id}</td>
                        <td>${a.patientName}</td>
                        <td>${a.treatmentName}</td>
                        <td>${a.date}</td>
                        <td>${a.time}</td>
                        <td><span class="badge-status ${a.status == 'Billed' ? 'badge-billed' : 'badge-pending'}">${a.status}</span></td>
                        <td>Rs. ${a.billAmount}</td>
                        <td><a href="${pageContext.request.contextPath}/admin/appointments?action=delete&id=${a.id}" class="btn btn-danger" style="padding:5px 12px; font-size:12px;" onclick="return confirm('Delete this appointment?')">Delete</a></td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
