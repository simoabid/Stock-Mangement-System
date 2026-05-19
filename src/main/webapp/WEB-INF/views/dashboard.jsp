<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${sessionScope.userLang}" />
<fmt:setBundle basename="messages" />
<!DOCTYPE html>
<html lang="${sessionScope.userLang}">
<head>
    <title>Dashboard - PharmStock</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <%@ include file="layout/header.jsp" %>
    <div class="container">
        <div class="page-header">
            <h1>Dashboard</h1>
            <c:if test="${sessionScope.user.role == 'ADMIN' || sessionScope.user.role == 'PHARMACIST'}">
                <div class="flex gap-sm">
                    <a href="${pageContext.request.contextPath}/admin/stock-entries/create" class="btn btn-primary btn-sm">+ New Entry</a>
                    <a href="${pageContext.request.contextPath}/admin/stock-exits/create" class="btn btn-success btn-sm">+ New Exit</a>
                </div>
            </c:if>
        </div>

        <!-- Stats Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-value">${totalProducts}</div>
                <div class="stat-label">Total Products</div>
            </div>
            <div class="stat-card warning">
                <div class="stat-value">${lowStockCount}</div>
                <div class="stat-label">Low Stock Alerts</div>
            </div>
            <div class="stat-card danger">
                <div class="stat-value">${expiredCount}</div>
                <div class="stat-label">Expired Batches</div>
            </div>
            <div class="stat-card info">
                <div class="stat-value">${expiringSoonCount}</div>
                <div class="stat-label">Expiring Soon (90 days)</div>
            </div>
        </div>

        <!-- Low Stock Alerts -->
        <c:if test="${not empty lowStockProducts}">
            <div class="section">
                <div class="section-title">&#9888;&#65039; Low Stock Products</div>
                <div class="table-responsive">
                    <table>
                        <thead><tr><th>Product</th><th>Category</th><th>Current Stock</th><th>Min Level</th><th>Unit</th></tr></thead>
                        <tbody>
                            <c:forEach var="p" items="${lowStockProducts}">
                                <tr>
                                    <td><a href="${pageContext.request.contextPath}/products?id=${p.id}" style="color: var(--primary); font-weight: 600;">${p.name}</a></td>
                                    <td>${p.categoryName}</td>
                                    <td><span class="badge badge-danger">${p.currentStock}</span></td>
                                    <td>${p.minStockLevel}</td>
                                    <td>${p.unit}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:if>

        <!-- Recent Activity -->
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: var(--spacing-lg);">
            <div class="section">
                <div class="section-title">&#128230; Recent Stock Entries</div>
                <div class="table-responsive">
                    <table>
                        <thead><tr><th>Product</th><th>Qty</th><th>Date</th><th>By</th></tr></thead>
                        <tbody>
                            <c:forEach var="e" items="${recentEntries}">
                                <tr>
                                    <td>${e.productName}</td>
                                    <td><span class="badge badge-success">+${e.quantity}</span></td>
                                    <td>${e.entryDate}</td>
                                    <td>${e.userName}</td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty recentEntries}"><tr><td colspan="4" class="text-center" style="color: var(--text-muted);">No entries yet</td></tr></c:if>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="section">
                <div class="section-title">&#128230; Recent Stock Exits</div>
                <div class="table-responsive">
                    <table>
                        <thead><tr><th>Product</th><th>Qty</th><th>Type</th><th>Date</th></tr></thead>
                        <tbody>
                            <c:forEach var="x" items="${recentExits}">
                                <tr>
                                    <td>${x.productName}</td>
                                    <td><span class="badge badge-danger">-${x.quantity}</span></td>
                                    <td><span class="badge badge-secondary">${x.exitType}</span></td>
                                    <td>${x.exitDate}</td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty recentExits}"><tr><td colspan="4" class="text-center" style="color: var(--text-muted);">No exits yet</td></tr></c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="layout/footer.jsp" %>
</body>
</html>
