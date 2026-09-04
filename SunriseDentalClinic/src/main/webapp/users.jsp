<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.sunrise.model.User, java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) { response.sendRedirect(request.getContextPath() + "/login"); return; }
    if (!"ADMIN".equals(user.getRole())) { response.sendRedirect(request.getContextPath() + "/dashboard.jsp"); return; }
    List<User> users = (List<User>) request.getAttribute("users");
    String initial = user.getUsername().substring(0,1).toUpperCase();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Management – Sunrise Dental Clinic</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="layout">
    <aside class="sidebar">
        <div class="sidebar-brand">
            <span class="brand-icon">🦷</span>
            <h2>SUNRISE DENTAL</h2>
            <p>Clinic Management</p>
        </div>
        <nav class="sidebar-nav">
            <div class="nav-section-label">Main</div>
            <a href="dashboard.jsp" class="nav-item"><span class="nav-icon">🏠</span><span>Dashboard</span></a>
            <a href="appointment" class="nav-item"><span class="nav-icon">📋</span><span>New Appointment</span></a>
            <a href="search" class="nav-item"><span class="nav-icon">🔍</span><span>Search</span></a>
            <a href="bill" class="nav-item"><span class="nav-icon">💰</span><span>Billing</span></a>
            <div class="nav-section-label">Admin</div>
            <a href="users" class="nav-item active"><span class="nav-icon">👥</span><span>User Management</span></a>
            <div class="nav-section-label">Other</div>
            <a href="help.jsp" class="nav-item"><span class="nav-icon">❓</span><span>Help</span></a>
        </nav>
        <div class="sidebar-footer">
            <div class="sidebar-user">
                <div class="avatar"><%= initial %></div>
                <div class="user-details">
                    <div class="user-name"><%= user.getUsername() %></div>
                    <div class="user-role"><%= user.getRole() %></div>
                </div>
                <a href="logout" class="logout-btn" title="Logout">⏻</a>
            </div>
        </div>
    </aside>

    <div class="main-content">
        <div class="topbar">
            <div class="topbar-title">User Management</div>
        </div>
        <div class="page-content">

            <% if (request.getAttribute("success") != null) { %>
                <div class="alert alert-success">✔ <%= request.getAttribute("success") %></div>
            <% } %>
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger">⚠ <%= request.getAttribute("error") %></div>
            <% } %>

            <!-- Add User Form -->
            <div class="card">
                <div class="card-title">Add New User</div>
                <form method="post" action="users">
                    <input type="hidden" name="action" value="add">
                    <div class="form-grid-2">
                        <div class="form-group">
                            <label>Username</label>
                            <input type="text" name="username" required placeholder="Enter username">
                        </div>
                        <div class="form-group">
                            <label>Password</label>
                            <input type="password" name="password" required placeholder="Enter password">
                        </div>
                        <div class="form-group">
                            <label>Role</label>
                            <select name="role" required>
                                <option value="ADMIN">ADMIN</option>
                                <option value="RECEPTIONIST">RECEPTIONIST</option>
                            </select>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary">Add User</button>
                </form>
            </div>

            <!-- Users Table -->
            <div class="card">
                <div class="card-title">All Users</div>
                <table class="result-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Username</th>
                            <th>Role</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <% if (users != null) { for (User u : users) { %>
                        <tr>
                            <td><%= u.getId() %></td>
                            <td><%= u.getUsername() %></td>
                            <td><span class="badge badge-primary"><%= u.getRole() %></span></td>
                            <td>
                                <% if (u.getId() != user.getId()) { %>
                                <form method="post" action="users" style="display:inline"
                                      onsubmit="return confirm('Delete user <%= u.getUsername() %>?')">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="<%= u.getId() %>">
                                    <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                </form>
                                <% } else { %>
                                <span class="badge badge-success">You</span>
                                <% } %>
                            </td>
                        </tr>
                    <% } } %>
                    </tbody>
                </table>
            </div>

        </div>
    </div>
</div>
</body>
</html>
