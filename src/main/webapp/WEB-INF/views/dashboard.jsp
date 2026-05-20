<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${sessionScope.userLang}" />
<fmt:setBundle basename="messages" />
<!DOCTYPE html>
<html lang="${sessionScope.userLang}" dir="${sessionScope.userLang == 'ar' ? 'rtl' : 'ltr'}">
<head>
    <title><fmt:message key="title.dashboard" /></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <%@ include file="layout/header.jsp" %>
    <div class="container">
        <div class="page-header">
            <h1><fmt:message key="dashboard.title" /></h1>
            <c:if test="${sessionScope.user.role == 'ADMIN' || sessionScope.user.role == 'PHARMACIST'}">
                <div class="flex gap-sm">
                    <a href="${pageContext.request.contextPath}/admin/stock-entries/create" class="btn btn-primary btn-sm"><fmt:message key="btn.new_entry" /></a>
                    <a href="${pageContext.request.contextPath}/admin/stock-exits/create" class="btn btn-success btn-sm"><fmt:message key="btn.new_exit" /></a>
                </div>
            </c:if>
        </div>

        <!-- Stats Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-value">${totalProducts}</div>
                <div class="stat-label"><fmt:message key="dashboard.total_products" /></div>
            </div>
            <div class="stat-card warning">
                <div class="stat-value">${lowStockCount}</div>
                <div class="stat-label"><fmt:message key="dashboard.low_stock_alerts" /></div>
            </div>
            <div class="stat-card danger">
                <div class="stat-value">${expiredCount}</div>
                <div class="stat-label"><fmt:message key="dashboard.expired_batches" /></div>
            </div>
            <div class="stat-card info">
                <div class="stat-value">${expiringSoonCount}</div>
                <div class="stat-label"><fmt:message key="dashboard.expiring_soon" /></div>
            </div>
        </div>

        <!-- Low Stock Alerts -->
        <c:if test="${not empty lowStockProducts}">
            <div class="section">
                <div class="section-title">&#9888;&#65039; <fmt:message key="dashboard.low_stock_products" /></div>
                <div class="table-responsive">
                    <table>
                        <thead><tr><th><fmt:message key="label.product" /></th><th><fmt:message key="label.category" /></th><th><fmt:message key="label.current_stock" /></th><th><fmt:message key="label.min_level" /></th><th><fmt:message key="label.unit" /></th></tr></thead>
                        <tbody>
                             <c:forEach var="p" items="${lowStockProducts}">
                                <tr>
                                    <td><a href="${pageContext.request.contextPath}/products?id=${p.id}" style="color: var(--primary); font-weight: 600;"><c:out value="${p.name}" /></a></td>
                                    <td><c:out value="${p.categoryName}" /></td>
                                    <td><span class="badge badge-danger"><c:out value="${p.currentStock}" /></span></td>
                                    <td><c:out value="${p.minStockLevel}" /></td>
                                    <td><c:if test="${not empty p.unit}"><fmt:message key="unit.${p.unit}" /></c:if></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:if>

        <!-- Expiry Warnings -->
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: var(--spacing-lg); margin-top: var(--spacing-lg); margin-bottom: var(--spacing-lg);">
            <div class="section">
                <div class="section-title" style="color: var(--danger);">&#9888;&#65039; <fmt:message key="dashboard.expired_batches" /></div>
                <div class="table-responsive">
                    <table>
                        <thead><tr><th><fmt:message key="label.product" /></th><th><fmt:message key="label.batch" /></th><th><fmt:message key="label.qty" /></th><th><fmt:message key="label.expiry_date" /></th></tr></thead>
                        <tbody>
                            <c:forEach var="ex" items="${expiredItems}">
                                <tr>
                                    <td><a href="${pageContext.request.contextPath}/products?id=${ex.productId}" style="color: var(--danger); font-weight: 600;"><c:out value="${ex.productName}" /></a></td>
                                    <td><span class="badge badge-danger"><c:out value="${ex.batchNumber}" /></span></td>
                                    <td><c:out value="${ex.quantity}" /></td>
                                    <td style="color: var(--danger); font-weight: 500;"><c:out value="${ex.expiryDate}" /></td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty expiredItems}"><tr><td colspan="4" class="text-center" style="color: var(--text-muted);"><fmt:message key="dashboard.no_expired" /></td></tr></c:if>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="section">
                <div class="section-title" style="color: var(--warning);">&#9200; <fmt:message key="dashboard.expiring_soon" /></div>
                <div class="table-responsive">
                    <table>
                        <thead><tr><th><fmt:message key="label.product" /></th><th><fmt:message key="label.batch" /></th><th><fmt:message key="label.qty" /></th><th><fmt:message key="label.expiry_date" /></th></tr></thead>
                        <tbody>
                            <c:forEach var="es" items="${expiringSoon}">
                                <tr>
                                    <td><a href="${pageContext.request.contextPath}/products?id=${es.productId}" style="color: var(--warning); font-weight: 600;"><c:out value="${es.productName}" /></a></td>
                                    <td><span class="badge badge-warning"><c:out value="${es.batchNumber}" /></span></td>
                                    <td><c:out value="${es.quantity}" /></td>
                                    <td style="color: var(--warning); font-weight: 500;"><c:out value="${es.expiryDate}" /></td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty expiringSoon}"><tr><td colspan="4" class="text-center" style="color: var(--text-muted);"><fmt:message key="dashboard.no_expiring" /></td></tr></c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Recent Activity -->
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: var(--spacing-lg);">
            <div class="section">
                <div class="section-title">&#128230; <fmt:message key="dashboard.recent_entries" /></div>
                <div class="table-responsive">
                    <table>
                        <thead><tr><th><fmt:message key="label.product" /></th><th><fmt:message key="label.qty" /></th><th><fmt:message key="label.date" /></th><th><fmt:message key="label.by" /></th></tr></thead>
                        <tbody>
                            <c:forEach var="e" items="${recentEntries}">
                                <tr>
                                    <td><c:out value="${e.productName}" /></td>
                                    <td><span class="badge badge-success">+<c:out value="${e.quantity}" /></span></td>
                                    <td><c:out value="${e.entryDate}" /></td>
                                    <td><c:out value="${e.userName}" /></td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty recentEntries}"><tr><td colspan="4" class="text-center" style="color: var(--text-muted);"><fmt:message key="dashboard.no_entries" /></td></tr></c:if>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="section">
                <div class="section-title">&#128230; <fmt:message key="dashboard.recent_exits" /></div>
                <div class="table-responsive">
                    <table>
                        <thead><tr><th><fmt:message key="label.product" /></th><th><fmt:message key="label.qty" /></th><th><fmt:message key="label.type" /></th><th><fmt:message key="label.date" /></th></tr></thead>
                        <tbody>
                            <c:forEach var="x" items="${recentExits}">
                                <tr>
                                    <td><c:out value="${x.productName}" /></td>
                                    <td><span class="badge badge-danger">-<c:out value="${x.quantity}" /></span></td>
                                    <td><span class="badge badge-secondary"><fmt:message key="exit_type.${x.exitType}" /></span></td>
                                    <td><c:out value="${x.exitDate}" /></td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty recentExits}"><tr><td colspan="4" class="text-center" style="color: var(--text-muted);"><fmt:message key="dashboard.no_exits" /></td></tr></c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="layout/footer.jsp" %>
</body>
</html>
