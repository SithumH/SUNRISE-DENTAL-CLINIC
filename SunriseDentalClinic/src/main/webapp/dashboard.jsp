<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.sunrise.model.User, com.sunrise.dao.DBConnection, java.sql.*" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) { response.sendRedirect(request.getContextPath() + "/login"); return; }

    // Quick stats
    int totalPatients = 0, todayApts = 0, totalBills = 0;
    double monthRevenue = 0;
    try {
        Connection conn = DBConnection.getInstance().getConnection();
        ResultSet rs;

        rs = conn.createStatement().executeQuery("SELECT COUNT(*) FROM patients");
        if (rs.next()) totalPatients = rs.getInt(1);

        rs = conn.createStatement().executeQuery("SELECT COUNT(*) FROM appointments WHERE appointment_date = CURDATE()");
        if (rs.next()) todayApts = rs.getInt(1);

        rs = conn.createStatement().executeQuery("SELECT COUNT(*) FROM bills");
        if (rs.next()) totalBills = rs.getInt(1);

        rs = conn.createStatement().executeQuery(
            "SELECT COALESCE(SUM(total_amount),0) FROM bills b JOIN appointments a ON b.appointment_id=a.appointment_id WHERE DATE_FORMAT(a.appointment_date,'%Y-%m')=DATE_FORMAT(CURDATE(),'%Y-%m')");
        if (rs.next()) monthRevenue = rs.getDouble(1);
    } catch (Exception ignored) {}

    String initial = user.getUsername().substring(0,1).toUpperCase();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard – Sunrise Dental Clinic</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="layout">

    <!-- ── Sidebar ── -->
    <aside class="sidebar">
        <div class="sidebar-brand">
            <span class="brand-icon">🦷</span>
            <h2>SUNRISE DENTAL</h2>
            <p>Clinic Management</p>
        </div>

        <nav class="sidebar-nav">
            <div class="nav-section-label">Main</div>
            <a href="dashboard.jsp" class="nav-item active">
                <span class="nav-icon">🏠</span><span>Dashboard</span>
            </a>
            <a href="appointment" class="nav-item">
                <span class="nav-icon">📋</span><span>New Appointment</span>
            </a>
            <a href="search" class="nav-item">
                <span class="nav-icon">🔍</span><span>Search</span>
            </a>
            <a href="bill" class="nav-item">
                <span class="nav-icon">💰</span><span>Billing</span>
            </a>

            <div class="nav-section-label">Reports</div>
            <a href="reports?type=daily" class="nav-item">
                <span class="nav-icon">📅</span><span>Daily Report</span>
            </a>
            <a href="reports?type=revenue" class="nav-item">
                <span class="nav-icon">📊</span><span>Revenue</span>
            </a>
            <a href="reports?type=treatment" class="nav-item">
                <span class="nav-icon">🦷</span><span>Treatments</span>
            </a>
            <a href="reports?type=patient" class="nav-item">
                <span class="nav-icon">👤</span><span>Patient History</span>
            </a>

            <% if ("ADMIN".equals(user.getRole())) { %>
            <div class="nav-section-label">Admin</div>
            <a href="users" class="nav-item">
                <span class="nav-icon">👥</span><span>User Management</span>
            </a>
            <% } %>

            <div class="nav-section-label">Other</div>
            <a href="help.jsp" class="nav-item">
                <span class="nav-icon">❓</span><span>Help</span>
            </a>
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

    <!-- ── Main Content ── -->
    <div class="main-content">

        <!-- Top Bar -->
        <div class="topbar">
            <div class="topbar-title">Dashboard</div>
            <div class="topbar-right">
                <span class="topbar-badge">📅 <%= new java.text.SimpleDateFormat("dd MMM yyyy").format(new java.util.Date()) %></span>
                <span class="topbar-badge">👤 <%= user.getUsername() %></span>
            </div>
        </div>

        <!-- Page Content -->
        <div class="page-content">

            <!-- Stat Cards -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon blue">👥</div>
                    <div class="stat-info">
                        <div class="stat-value"><%= totalPatients %></div>
                        <div class="stat-label">Total Patients</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon cyan">📅</div>
                    <div class="stat-info">
                        <div class="stat-value"><%= todayApts %></div>
                        <div class="stat-label">Today's Appointments</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon green">🧾</div>
                    <div class="stat-info">
                        <div class="stat-value"><%= totalBills %></div>
                        <div class="stat-label">Total Bills</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon amber">💰</div>
                    <div class="stat-info">
                        <div class="stat-value">Rs.<%= String.format("%,.0f", monthRevenue) %></div>
                        <div class="stat-label">This Month Revenue</div>
                    </div>
                </div>
            </div>

            <!-- Quick Access -->
            <div class="section-header">
                <div class="section-title">Quick Access</div>
            </div>
            <div class="menu-grid">
                <a href="appointment" class="menu-card">
                    <div class="mc-icon indigo">📋</div>
                    <div class="mc-text">
                        <div class="mc-title">New Appointment</div>
                        <div class="mc-desc">Register a patient appointment</div>
                    </div>
                </a>
                <a href="search" class="menu-card">
                    <div class="mc-icon cyan">🔍</div>
                    <div class="mc-text">
                        <div class="mc-title">Search Appointment</div>
                        <div class="mc-desc">Find by appointment number</div>
                    </div>
                </a>
                <a href="bill" class="menu-card">
                    <div class="mc-icon green">💰</div>
                    <div class="mc-text">
                        <div class="mc-title">Billing</div>
                        <div class="mc-desc">Generate & save patient bills</div>
                    </div>
                </a>
                <a href="reports?type=daily" class="menu-card">
                    <div class="mc-icon amber">📊</div>
                    <div class="mc-text">
                        <div class="mc-title">Reports</div>
                        <div class="mc-desc">Daily, revenue & treatment reports</div>
                    </div>
                </a>
                <a href="help.jsp" class="menu-card">
                    <div class="mc-icon slate">❓</div>
                    <div class="mc-text">
                        <div class="mc-title">Help</div>
                        <div class="mc-desc">User guide & documentation</div>
                    </div>
                </a>
                <a href="logout" class="menu-card">
                    <div class="mc-icon rose">🚪</div>
                    <div class="mc-text">
                        <div class="mc-title">Logout</div>
                        <div class="mc-desc">Sign out of the system</div>
                    </div>
                </a>
            </div>

        </div>
    </div>
</div>
</body>
</html>
