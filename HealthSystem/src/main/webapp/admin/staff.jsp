<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% if (session.getAttribute("admin") == null) { response.sendRedirect(request.getContextPath() + "/admin/login.jsp"); return; } %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Staff</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="sidebar.jsp" %>
<div class="main-content">
    <div class="topbar">
        <h4>Manage Staff</h4>
        <div class="topbar-right"><span class="badge">Admin</span></div>
    </div>
    <div class="page-content">
        <div class="card">
            <div class="card-title">👨💼 Staff List</div>
            <% if ("deleted".equals(request.getParameter("msg"))) { %><div class="msg-success">Staff member deleted.</div><% } %>
            <table>
                <tr><th>#</th><th>Name</th><th>Email</th><th>Phone</th><th>Role</th><th>Action</th></tr>
                <c:forEach var="s" items="${staffList}">
                    <tr>
                        <td>${s.id}</td>
                        <td>${s.name}</td>
                        <td>${s.email}</td>
                        <td>${s.phone}</td>
                        <td><span class="badge-status badge-billed">${s.role}</span></td>
                        <td><a href="${pageContext.request.contextPath}/admin/staff?action=delete&id=${s.id}" class="btn btn-danger" style="padding:5px 12px; font-size:12px;" onclick="return confirm('Delete this staff member?')">Delete</a></td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
