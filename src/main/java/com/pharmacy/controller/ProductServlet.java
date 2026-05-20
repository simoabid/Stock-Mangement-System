package com.pharmacy.controller;

import com.pharmacy.dao.*;
import com.pharmacy.model.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAOImpl();
    private final CategoryDAO categoryDAO = new CategoryDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");

        if (idParam != null) {
            // Single product detail
            try {
                int id = Integer.parseInt(idParam);
                java.util.Optional<Product> productOpt = productDAO.findById(id);
                if (productOpt.isPresent()) {
                    req.setAttribute("product", productOpt.get());
                    req.getRequestDispatcher("/WEB-INF/views/product_detail.jsp").forward(req, resp);
                } else {
                    resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                }
            } catch (NumberFormatException e) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
            }
        } else {
            // Product list with search/filter
            String query = req.getParameter("q");
            String catParam = req.getParameter("category");
            String pageParam = req.getParameter("page");

            int categoryId = 0;
            int page = 1;
            int pageSize = 12;

            try { categoryId = Integer.parseInt(catParam); } catch (Exception ignored) {}
            try { page = Math.max(1, Integer.parseInt(pageParam)); } catch (Exception ignored) {}

            List<Product> products = productDAO.search(query, categoryId, page, pageSize);
            int totalCount = productDAO.countSearch(query, categoryId);
            int totalPages = (int) Math.ceil((double) totalCount / pageSize);

            List<Category> categories = categoryDAO.findAll();

            req.setAttribute("products", products);
            req.setAttribute("categories", categories);
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("searchQuery", query);
            req.setAttribute("selectedCategory", categoryId);

            req.getRequestDispatcher("/WEB-INF/views/products.jsp").forward(req, resp);
        }
    }
}
