<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login – Sunrise Dental Clinic</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="js/validation.js" defer></script>
</head>
<body>
<div class="login-wrapper">

    <!-- Left Panel -->
    <div class="login-left">
        <div class="brand-logo">🦷</div>
        <h1>Sunrise Dental Clinic</h1>
        <p>Modern clinic management system for seamless patient care and operations.</p>

        <div class="login-features">
            <div class="login-feature-item">
                <div class="fi-icon">📋</div>
                <span>Appointment Scheduling</span>
            </div>
            <div class="login-feature-item">
                <div class="fi-icon">💰</div>
                <span>Automated Billing</span>
            </div>
            <div class="login-feature-item">
                <div class="fi-icon">📊</div>
                <span>Revenue Reports</span>
            </div>
            <div class="login-feature-item">
                <div class="fi-icon">🔒</div>
                <span>Secure & Role-Based Access</span>
            </div>
        </div>
    </div>

    <!-- Right Panel -->
    <div class="login-right">
        <div class="login-box">
            <div class="login-heading">Welcome back</div>
            <div class="login-sub">Sign in to your staff account</div>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger">⚠ <%= request.getAttribute("error") %></div>
            <% } %>
            <div id="clientError" class="alert alert-danger" style="display:none;"></div>

            <form action="login" method="post" onsubmit="return validateLoginForm()">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" placeholder="Enter your username" autocomplete="username">
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Enter your password" autocomplete="current-password">
                </div>
                <button type="submit" class="btn btn-primary btn-full">Sign In →</button>
            </form>
        </div>
    </div>

</div>
</body>
</html>
