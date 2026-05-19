package com.pharmacy.controller.admin;

import com.pharmacy.dao.*;
import com.pharmacy.model.*;
import com.pharmacy.util.FileUploadUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Optional;

@WebServlet(urlPatterns = { "/admin/products", "/admin/products/create", "/admin/products/edit", "/admin/products/delete" })
@MultipartConfig(maxFileSize = 5 * 1024 * 1024)
public class AdminProductServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAOImpl();
    private final CategoryDAO categoryDAO = new CategoryDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/admin/products/create".equals(path)) {
            req.setAttribute("categories", categoryDAO.findAll());
            req.getRequestDispatcher("/WEB-INF/views/admin/product_form.jsp").forward(req, resp);
        } else if ("/admin/products/edit".equals(path)) {
            int id = Integer.parseInt(req.getParameter("id"));
            Optional<Product> product = productDAO.findById(id);
            if (product.isPresent()) {
                req.setAttribute("product", product.get());
                req.setAttribute("categories", categoryDAO.findAll());
                req.getRequestDispatcher("/WEB-INF/views/admin/product_form.jsp").forward(req, resp);
            } else {
                resp.sendError(404);
            }
        } else {
            // List
            String pageParam = req.getParameter("page");
            int page = 1;
            int pageSize = 15;
            try { page = Math.max(1, Integer.parseInt(pageParam)); } catch (Exception ignored) {}

            List<Product> products = productDAO.findAll(page, pageSize);
            int total = productDAO.countAll();
            int totalPages = (int) Math.ceil((double) total / pageSize);

            req.setAttribute("products", products);
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);
            req.getRequestDispatcher("/WEB-INF/views/admin/products.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/admin/products/delete".equals(path)) {
            int id = Integer.parseInt(req.getParameter("id"));
            productDAO.delete(id);
            resp.sendRedirect(req.getContextPath() + "/admin/products?msg=deleted");
            return;
        }

        // Create or Edit
        String idParam = req.getParameter("id");
        boolean isEdit = idParam != null && !idParam.isEmpty();

        Product product = isEdit ? productDAO.findById(Integer.parseInt(idParam)).orElse(new Product()) : new Product();

        product.setName(req.getParameter("name"));
        product.setGenericName(req.getParameter("genericName"));
        try { product.setCategoryId(Integer.parseInt(req.getParameter("categoryId"))); } catch (Exception ignored) {}
        product.setForm(req.getParameter("form"));
        product.setDosage(req.getParameter("dosage"));
        product.setBarcode(req.getParameter("barcode"));
        product.setUnit(req.getParameter("unit"));
        product.setShelfLocation(req.getParameter("shelfLocation"));
        product.setRequiresPrescription("on".equals(req.getParameter("requiresPrescription")));
        product.setDescription(req.getParameter("description"));
        try { product.setMinStockLevel(Integer.parseInt(req.getParameter("minStockLevel"))); } catch (Exception ignored) {}
        product.setActive(!"on".equals(req.getParameter("inactive")));

        // Handle image upload
        String imagePath = FileUploadUtil.saveImage(req.getPart("image"), getServletContext());
        if (imagePath != null) {
            product.setImagePath(imagePath);
        }

        if (isEdit) {
            productDAO.update(product);
        } else {
            product.setCurrentStock(0);
            productDAO.create(product);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/products?msg=saved");
    }
}
