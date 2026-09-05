<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Staff Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="login-page">
    <div class="login-card">
        <div class="login-header">
            <div class="icon">👨💼</div>
            <h2>Staff Login</h2>
            <p>Sign in to your staff account</p>
        </div>
        <% if ("invalid".equals(request.getParameter("msg"))) { %>
            <div class="msg-error">Invalid email or password.</div>
        <% } %>
        <% if ("error".equals(request.getParameter("msg"))) { %>
            <div class="msg-error">Unable to connect to the system. Please try again.</div>
        <% } %>
        <% if ("registered".equals(request.getParameter("msg"))) { %>
            <div class="msg-success">Registration successful! Please login.</div>
        <% } %>
        <form action="${pageContext.request.contextPath}/staff/login" method="post">
            <div class="form-group">
                <label>Email Address</label>
                <input type="email" name="email" placeholder="Enter your email" required>
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" placeholder="Enter your password" required>
            </div>
            <button type="submit" class="btn btn-primary" style="width:100%; margin-bottom:15px;">Login</button>
            <p style="text-align:center; font-size:13px; color:#888;">
                New staff? <a href="register.jsp" style="color:#1a73e8;">Register here</a>
            </p>
            <p style="text-align:center; font-size:13px; color:#888; margin-top:8px;">
                <a href="${pageContext.request.contextPath}/index.html" style="color:#888;">← Back to Home</a>
            </p>
        </form>
    </div>
</div>
</body>
</html>
