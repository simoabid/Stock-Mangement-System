package com.pharmacy.controller.admin;

import com.pharmacy.dao.*;
import com.pharmacy.model.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;

@WebServlet(urlPatterns = { "/admin/stock-entries", "/admin/stock-entries/create" })
public class AdminStockEntryServlet extends HttpServlet {

    private final StockEntryDAO stockEntryDAO = new StockEntryDAOImpl();
    private final ProductDAO productDAO = new ProductDAOImpl();
    private final SupplierDAO supplierDAO = new SupplierDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/admin/stock-entries/create".equals(path)) {
            req.setAttribute("products", productDAO.findAll());
            req.setAttribute("suppliers", supplierDAO.findAllActive());
            req.getRequestDispatcher("/WEB-INF/views/admin/stock_entry_form.jsp").forward(req, resp);
        } else {
            String pageParam = req.getParameter("page");
            int page = 1;
            int pageSize = 15;
            try { page = Math.max(1, Integer.parseInt(pageParam)); } catch (Exception ignored) {}

            List<StockEntry> entries = stockEntryDAO.findAll(page, pageSize);
            int total = stockEntryDAO.countAll();
            int totalPages = (int) Math.ceil((double) total / pageSize);

            req.setAttribute("entries", entries);
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);
            req.getRequestDispatcher("/WEB-INF/views/admin/stock_entries.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");

        StockEntry entry = new StockEntry();
        entry.setProductId(Integer.parseInt(req.getParameter("productId")));
        try { entry.setSupplierId(Integer.parseInt(req.getParameter("supplierId"))); } catch (Exception ignored) {}
        entry.setQuantity(Integer.parseInt(req.getParameter("quantity")));

        String purchasePrice = req.getParameter("purchasePrice");
        if (purchasePrice != null && !purchasePrice.isEmpty()) {
            entry.setPurchasePrice(new BigDecimal(purchasePrice));
        }
        String sellingPrice = req.getParameter("sellingPrice");
        if (sellingPrice != null && !sellingPrice.isEmpty()) {
            entry.setSellingPrice(new BigDecimal(sellingPrice));
        }

        entry.setBatchNumber(req.getParameter("batchNumber"));

        String expiryDate = req.getParameter("expiryDate");
        if (expiryDate != null && !expiryDate.isEmpty()) {
            entry.setExpiryDate(Date.valueOf(expiryDate));
        }

        String entryDate = req.getParameter("entryDate");
        entry.setEntryDate(entryDate != null && !entryDate.isEmpty() ? Date.valueOf(entryDate) : new Date(System.currentTimeMillis()));

        entry.setUserId(user.getId());
        entry.setNotes(req.getParameter("notes"));

        // Create entry & update stock
        stockEntryDAO.create(entry);
        productDAO.updateStock(entry.getProductId(), entry.getQuantity());

        resp.sendRedirect(req.getContextPath() + "/admin/stock-entries?msg=added");
    }
}
