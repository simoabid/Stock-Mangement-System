package com.pharmacy.filter;

import com.pharmacy.model.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class AuthenticationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String path = req.getServletPath();

        // Ensure UTF-8 everywhere
        request.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        User user = isLoggedIn ? (User) session.getAttribute("user") : null;

        // Public URLs (no login required)
        boolean isPublicResource = path.startsWith("/assets/") || path.startsWith("/uploads/") ||
                path.equals("/login") || path.equals("/register") || path.equals("/index.jsp");

        if (isLoggedIn) {
            // Admin-only routes protection
            if (path.startsWith("/admin")) {
                if (user.getRole() == User.Role.TECHNICIAN) {
                    // Technicians cannot access admin routes
                    res.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
                    return;
                }
            }
            // Logged in users shouldn't see login/register
            if (path.equals("/login") || path.equals("/register")) {
                res.sendRedirect(req.getContextPath() + "/dashboard");
                return;
            }
        } else {
            // Not logged in
            if (!isPublicResource && !path.equals("/")) {
                res.sendRedirect(req.getContextPath() + "/login?redirect=" + path);
                return;
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
