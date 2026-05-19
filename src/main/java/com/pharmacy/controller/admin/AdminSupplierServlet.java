package com.pharmacy.controller.admin;

import com.pharmacy.dao.SupplierDAO;
import com.pharmacy.dao.SupplierDAOImpl;
import com.pharmacy.model.Supplier;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Optional;

@WebServlet(urlPatterns = { "/admin/suppliers", "/admin/suppliers/create", "/admin/suppliers/edit", "/admin/suppliers/delete" })
public class AdminSupplierServlet extends HttpServlet {

    private final SupplierDAO supplierDAO = new SupplierDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/admin/suppliers/create".equals(path)) {
            req.getRequestDispatcher("/WEB-INF/views/admin/supplier_form.jsp").forward(req, resp);
        } else if ("/admin/suppliers/edit".equals(path)) {
            int id = Integer.parseInt(req.getParameter("id"));
            Optional<Supplier> supplier = supplierDAO.findById(id);
            if (supplier.isPresent()) {
                req.setAttribute("supplier", supplier.get());
                req.getRequestDispatcher("/WEB-INF/views/admin/supplier_form.jsp").forward(req, resp);
            } else {
                resp.sendError(404);
            }
        } else {
            req.setAttribute("suppliers", supplierDAO.findAll());
            req.getRequestDispatcher("/WEB-INF/views/admin/suppliers.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/admin/suppliers/delete".equals(path)) {
            int id = Integer.parseInt(req.getParameter("id"));
            supplierDAO.delete(id);
            resp.sendRedirect(req.getContextPath() + "/admin/suppliers?msg=deleted");
            return;
        }

        String idParam = req.getParameter("id");
        boolean isEdit = idParam != null && !idParam.isEmpty();

        Supplier supplier = isEdit ? supplierDAO.findById(Integer.parseInt(idParam)).orElse(new Supplier()) : new Supplier();

        supplier.setName(req.getParameter("name"));
        supplier.setContactPerson(req.getParameter("contactPerson"));
        supplier.setPhone(req.getParameter("phone"));
        supplier.setEmail(req.getParameter("email"));
        supplier.setAddress(req.getParameter("address"));
        supplier.setActive(!"on".equals(req.getParameter("inactive")));

        if (isEdit) {
            supplierDAO.update(supplier);
        } else {
            supplierDAO.create(supplier);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/suppliers?msg=saved");
    }
}
