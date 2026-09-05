<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% if (session.getAttribute("admin") == null) { response.sendRedirect(request.getContextPath() + "/admin/login.jsp"); return; } %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Treatments</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="sidebar.jsp" %>
<div class="main-content">
    <div class="topbar"><h4>Manage Treatments</h4><div class="topbar-right"><span class="badge">Admin</span></div></div>
    <div class="page-content">
        <div class="card" style="max-width:700px;">
            <div class="card-title">➕ Add Dental Treatment</div>
            <% if ("added".equals(request.getParameter("msg"))) { %><div class="msg-success">Treatment added successfully.</div><% } %>
            <% if ("deleted".equals(request.getParameter("msg"))) { %><div class="msg-success">Treatment deleted.</div><% } %>
            <% if ("error".equals(request.getParameter("msg"))) { %><div class="msg-error">Please enter a valid treatment name and price.</div><% } %>
            <form action="${pageContext.request.contextPath}/admin/treatments" method="post">
                <div class="form-group"><label>Treatment Name</label><input type="text" name="name" placeholder="e.g. Teeth Cleaning" required></div>
                <div class="form-group"><label>Description</label><input type="text" name="description" placeholder="Short description"></div>
                <div class="form-group"><label>Price (Rs.)</label><input type="number" name="price" min="0" step="0.01" required></div>
                <button type="submit" class="btn btn-primary">Add Treatment</button>
            </form>
        </div>
        <div class="card">
            <div class="card-title">🦷 Treatment List</div>
            <table>
                <tr><th>#</th><th>Name</th><th>Description</th><th>Price</th><th>Action</th></tr>
                <c:forEach var="t" items="${treatments}">
                    <tr><td>${t.id}</td><td>${t.name}</td><td>${t.description}</td><td>Rs. ${t.price}</td>
                        <td><a href="${pageContext.request.contextPath}/admin/treatments?action=delete&id=${t.id}" class="btn btn-danger" style="padding:5px 12px;font-size:12px;" onclick="return confirm('Delete this treatment?')">Delete</a></td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
