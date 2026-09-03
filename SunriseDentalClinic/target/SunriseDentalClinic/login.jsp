<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login – Sunrise Dental Clinic</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="js/validation.js" defer></script>
</head>
<body>
<div class="login-wrapper">
    <div class="login-box">
        <h2>🦷 SUNRISE DENTAL CLINIC</h2>
        <p>Staff Login</p>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
        <% } %>
        <div id="clientError" class="alert alert-danger" style="display:none;"></div>

        <form action="login" method="post" onsubmit="return validateLoginForm()">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" placeholder="Enter username">
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter password">
            </div>
            <button type="submit" class="btn btn-primary btn-full">LOGIN</button>
        </form>
    </div>
</div>
</body>
</html>
