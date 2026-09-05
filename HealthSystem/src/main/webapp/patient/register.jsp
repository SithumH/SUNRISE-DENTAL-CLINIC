<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Patient Register</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="login-page">
    <div class="login-card" style="max-width:480px;">
        <div class="login-header">
            <div class="icon">📋</div>
            <h2>Patient Register</h2>
            <p>Create your patient account</p>
        </div>
        <% if ("error".equals(request.getParameter("msg"))) { %>
            <div class="msg-error">Registration failed. Try again.</div>
        <% } %>
        <form id="regForm" action="${pageContext.request.contextPath}/patient/register" method="post" onsubmit="return validateRegister('regForm')">
            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="name" placeholder="Enter your full name" required>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" placeholder="Email address" required>
                </div>
                <div class="form-group">
                    <label>Phone</label>
                    <input type="text" name="phone" placeholder="Phone number" required>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" placeholder="Password" required>
                </div>
                <div class="form-group">
                    <label>Confirm Password</label>
                    <input type="password" name="confirmPassword" placeholder="Confirm" required>
                </div>
            </div>
            <button type="submit" class="btn btn-primary" style="width:100%; margin-bottom:15px;">Register</button>
            <p style="text-align:center; font-size:13px; color:#888;">
                Already have an account? <a href="login.jsp" style="color:#1a73e8;">Login here</a>
            </p>
        </form>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
