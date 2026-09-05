package com.health.servlet.admin;

import com.health.dao.StaffDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/staff")
public class AdminStaffServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        if (req.getSession().getAttribute("admin") == null) { res.sendRedirect(req.getContextPath() + "/admin/login.jsp"); return; }

        String action = req.getParameter("action");
        try {
            if ("delete".equals(action)) {
                new StaffDAO().delete(Integer.parseInt(req.getParameter("id")));
                res.sendRedirect(req.getContextPath() + "/admin/staff.jsp?msg=deleted");
                return;
            }
            req.setAttribute("staffList", new StaffDAO().getAll());
            req.getRequestDispatcher("/admin/staff.jsp").forward(req, res);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
