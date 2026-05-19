package com.pharmacy.controller.admin;

import com.pharmacy.dao.CategoryDAO;
import com.pharmacy.dao.CategoryDAOImpl;
import com.pharmacy.model.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Optional;

@WebServlet(urlPatterns = { "/admin/categories", "/admin/categories/create", "/admin/categories/edit", "/admin/categories/delete" })
public class AdminCategoryServlet extends HttpServlet {

    private final CategoryDAO categoryDAO = new CategoryDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/admin/categories/create".equals(path) || "/admin/categories/edit".equals(path)) {
            if ("/admin/categories/edit".equals(path)) {
                int id = Integer.parseInt(req.getParameter("id"));
                Optional<Category> cat = categoryDAO.findById(id);
                cat.ifPresent(c -> req.setAttribute("category", c));
            }
            req.getRequestDispatcher("/WEB-INF/views/admin/category_form.jsp").forward(req, resp);
        } else {
            req.setAttribute("categories", categoryDAO.findAll());
            req.getRequestDispatcher("/WEB-INF/views/admin/categories.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/admin/categories/delete".equals(path)) {
            int id = Integer.parseInt(req.getParameter("id"));
            categoryDAO.delete(id);
            resp.sendRedirect(req.getContextPath() + "/admin/categories?msg=deleted");
            return;
        }

        String idParam = req.getParameter("id");
        boolean isEdit = idParam != null && !idParam.isEmpty();

        Category category = isEdit ? categoryDAO.findById(Integer.parseInt(idParam)).orElse(new Category()) : new Category();

        category.setName(req.getParameter("name"));
        category.setDescription(req.getParameter("description"));

        if (isEdit) {
            categoryDAO.update(category);
        } else {
            categoryDAO.create(category);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/categories?msg=saved");
    }
}
