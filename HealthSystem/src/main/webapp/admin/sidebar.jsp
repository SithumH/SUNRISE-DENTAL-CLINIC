<button class="hamburger" id="hamburger"><span></span><span></span><span></span></button>
<div class="sidebar-overlay" id="sidebarOverlay"></div>
<div class="sidebar">
    <div class="sidebar-brand">
        <div class="brand-icon">🏥</div>
        <h3>Dental Clinic</h3>
        <p>Admin Panel</p>
    </div>
    <div class="sidebar-user">
        <div class="avatar">A</div>
        <div class="user-info">
            <p>Administrator</p>
            <span>Super Admin</span>
        </div>
    </div>
    <nav class="sidebar-nav">
        <div class="nav-section-title">Main</div>
        <a href="${pageContext.request.contextPath}/admin/dashboard.jsp"><span class="nav-icon">🏠</span><span>Dashboard</span></a>
        <div class="nav-section-title">Manage</div>
        <a href="${pageContext.request.contextPath}/admin/treatments"><span class="nav-icon">🦷</span><span>Treatments</span></a>
        <a href="${pageContext.request.contextPath}/admin/staff"><span class="nav-icon">👨‍💼</span><span>Staff</span></a>
        <a href="${pageContext.request.contextPath}/admin/patients"><span class="nav-icon">👤</span><span>Patients</span></a>
        <a href="${pageContext.request.contextPath}/admin/appointments"><span class="nav-icon">📅</span><span>Appointments</span></a>
        <a href="${pageContext.request.contextPath}/admin/reports"><span class="nav-icon">📊</span><span>Reports</span></a>
    </nav>
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/admin/logout"><span class="nav-icon">🚪</span><span>Logout</span></a>
    </div>
</div>
