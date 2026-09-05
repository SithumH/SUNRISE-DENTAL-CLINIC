<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="login-page">
    <div class="login-card">
        <div class="login-header">
            <div class="icon">🔐</div>
            <h2>Admin Login</h2>
            <p>System Administrator Access</p>
        </div>
        <% if ("invalid".equals(request.getParameter("msg"))) { %>
            <div class="msg-error">Invalid credentials.</div>
        <% } %>
        <form action="${pageContext.request.contextPath}/admin/login" method="post">
            <div class="form-group">
                <label>Email Address</label>
                <input type="email" name="email" placeholder="admin@health.com" required>
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" placeholder="Enter password" required>
            </div>
            <button type="submit" class="btn btn-primary" style="width:100%; margin-bottom:15px;">Login as Admin</button>
            <p style="text-align:center; font-size:13px; color:#888;">
                <a href="${pageContext.request.contextPath}/index.html" style="color:#888;">← Back to Home</a>
            </p>
        </form>
    </div>
</div>
</body>
</html>
