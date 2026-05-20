package com.pharmacy.controller.admin;

import com.pharmacy.dao.*;
import com.pharmacy.model.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import java.util.Optional;

@WebServlet(urlPatterns = { "/admin/stock-exits", "/admin/stock-exits/create" })
public class AdminStockExitServlet extends HttpServlet {

    private final StockExitDAO stockExitDAO = new StockExitDAOImpl();
    private final ProductDAO productDAO = new ProductDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/admin/stock-exits/create".equals(path)) {
            req.setAttribute("products", productDAO.findAll());
            req.getRequestDispatcher("/WEB-INF/views/admin/stock_exit_form.jsp").forward(req, resp);
        } else {
            String pageParam = req.getParameter("page");
            int page = 1;
            int pageSize = 15;
            try { page = Math.max(1, Integer.parseInt(pageParam)); } catch (Exception ignored) {}

            List<StockExit> exits = stockExitDAO.findAll(page, pageSize);
            int total = stockExitDAO.countAll();
            int totalPages = (int) Math.ceil((double) total / pageSize);

            req.setAttribute("exits", exits);
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);
            req.getRequestDispatcher("/WEB-INF/views/admin/stock_exits.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");

        int productId = Integer.parseInt(req.getParameter("productId"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));

        // Check stock availability
        Optional<Product> productOpt = productDAO.findById(productId);
        if (productOpt.isPresent() && productOpt.get().getCurrentStock() < quantity) {
            req.setAttribute("error", "Insufficient stock! Available: " + productOpt.get().getCurrentStock());
            req.setAttribute("products", productDAO.findAll());
            req.getRequestDispatcher("/WEB-INF/views/admin/stock_exit_form.jsp").forward(req, resp);
            return;
        }

        StockExit exit = new StockExit();
        exit.setProductId(productId);
        exit.setQuantity(quantity);
        exit.setExitType(req.getParameter("exitType"));

        String exitDate = req.getParameter("exitDate");
        exit.setExitDate(exitDate != null && !exitDate.isEmpty() ? Date.valueOf(exitDate) : new Date(System.currentTimeMillis()));

        exit.setUserId(user.getId());
        exit.setNotes(req.getParameter("notes"));

        // Create exit & decrease stock transactionally
        try (java.sql.Connection conn = com.pharmacy.util.DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try {
                stockExitDAO.create(exit, conn);
                productDAO.updateStock(productId, -quantity, conn);
                conn.commit();
            } catch (Exception e) {
                conn.rollback();
                throw e;
            }
        } catch (Exception e) {
            req.setAttribute("error", "Failed to record stock exit: " + e.getMessage());
            req.setAttribute("products", productDAO.findAll());
            req.getRequestDispatcher("/WEB-INF/views/admin/stock_exit_form.jsp").forward(req, resp);
            return;
        }

        resp.sendRedirect(req.getContextPath() + "/admin/stock-exits?msg=recorded");
    }
}
