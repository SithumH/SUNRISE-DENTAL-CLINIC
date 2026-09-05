<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% if (session.getAttribute("admin") == null) { response.sendRedirect(request.getContextPath() + "/admin/login.jsp"); return; } %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Patients</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="sidebar.jsp" %>
<div class="main-content">
    <div class="topbar">
        <h4>Manage Patients</h4>
        <div class="topbar-right"><span class="badge">Admin</span></div>
    </div>
    <div class="page-content">
        <div class="card">
            <div class="card-title">👤 Patient List</div>
            <% if ("deleted".equals(request.getParameter("msg"))) { %><div class="msg-success">Patient deleted.</div><% } %>
            <table>
                <tr><th>#</th><th>Name</th><th>Email</th><th>Phone</th><th>Action</th></tr>
                <c:forEach var="p" items="${patientList}">
                    <tr>
                        <td>${p.id}</td>
                        <td>${p.name}</td>
                        <td>${p.email}</td>
                        <td>${p.phone}</td>
                        <td><a href="${pageContext.request.contextPath}/admin/patients?action=delete&id=${p.id}" class="btn btn-danger" style="padding:5px 12px; font-size:12px;" onclick="return confirm('Delete this patient?')">Delete</a></td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
