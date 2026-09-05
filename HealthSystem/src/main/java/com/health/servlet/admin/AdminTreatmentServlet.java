package com.health.servlet.admin;

import com.health.dao.TreatmentDAO;
import com.health.model.Treatment;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/treatments")
public class AdminTreatmentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        if (req.getSession().getAttribute("admin") == null) {
            res.sendRedirect(req.getContextPath() + "/admin/login.jsp");
            return;
        }
        try {
            if ("delete".equals(req.getParameter("action"))) {
                new TreatmentDAO().delete(Integer.parseInt(req.getParameter("id")));
                res.sendRedirect(req.getContextPath() + "/admin/treatments?msg=deleted");
                return;
            }
            req.setAttribute("treatments", new TreatmentDAO().getAll());
            req.getRequestDispatcher("/admin/treatments.jsp").forward(req, res);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        if (req.getSession().getAttribute("admin") == null) {
            res.sendRedirect(req.getContextPath() + "/admin/login.jsp");
            return;
        }
        try {
            Treatment treatment = new Treatment();
            treatment.setName(req.getParameter("name"));
            treatment.setDescription(req.getParameter("description"));
            treatment.setPrice(Double.parseDouble(req.getParameter("price")));
            if (treatment.getName() == null || treatment.getName().trim().isEmpty() || treatment.getPrice() < 0) {
                res.sendRedirect(req.getContextPath() + "/admin/treatments?msg=error");
                return;
            }
            new TreatmentDAO().add(treatment);
            res.sendRedirect(req.getContextPath() + "/admin/treatments?msg=added");
        } catch (Exception e) {
            res.sendRedirect(req.getContextPath() + "/admin/treatments?msg=error");
        }
    }
}
