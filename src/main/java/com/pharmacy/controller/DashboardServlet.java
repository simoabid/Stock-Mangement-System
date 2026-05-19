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

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAOImpl();
    private final StockEntryDAO stockEntryDAO = new StockEntryDAOImpl();
    private final StockExitDAO stockExitDAO = new StockExitDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Stats
        int totalProducts = productDAO.countAll();
        List<Product> lowStock = productDAO.findLowStock();
        List<StockEntry> expiringSoon = stockEntryDAO.findExpiringSoon(90); // Within 3 months
        List<StockEntry> expired = stockEntryDAO.findExpired();
        List<StockEntry> recentEntries = stockEntryDAO.findRecent(5);
        List<StockExit> recentExits = stockExitDAO.findRecent(5);

        req.setAttribute("totalProducts", totalProducts);
        req.setAttribute("lowStockProducts", lowStock);
        req.setAttribute("lowStockCount", lowStock.size());
        req.setAttribute("expiringSoon", expiringSoon);
        req.setAttribute("expiringSoonCount", expiringSoon.size());
        req.setAttribute("expiredItems", expired);
        req.setAttribute("expiredCount", expired.size());
        req.setAttribute("recentEntries", recentEntries);
        req.setAttribute("recentExits", recentExits);

        req.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(req, resp);
    }
}
