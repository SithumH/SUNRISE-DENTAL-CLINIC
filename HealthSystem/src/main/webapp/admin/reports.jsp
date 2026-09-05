<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.health.model.Appointment,java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% if (session.getAttribute("admin") == null) { response.sendRedirect(request.getContextPath() + "/admin/login.jsp"); return; } %>
<!DOCTYPE html>
<html>
<head>
    <title>Dental Clinic Reports</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="sidebar.jsp" %>
<div class="main-content">
    <div class="topbar"><h4>Clinic Reports</h4><div class="topbar-right"><span class="badge">Admin</span></div></div>
    <div class="page-content">
        <div class="card">
            <div class="card-title">📊 Appointment and Billing Report</div>
            <table>
                <tr><th>#</th><th>Patient</th><th>Treatment</th><th>Date</th><th>Status</th><th>Bill (Rs.)</th></tr>
                <c:forEach var="a" items="${appointments}">
                    <tr>
                        <td>${a.id}</td><td>${a.patientName}</td><td>${a.treatmentName}</td>
                        <td>${a.date}</td><td>${a.status}</td><td>Rs. ${a.billAmount}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
