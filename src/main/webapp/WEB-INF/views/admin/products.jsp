<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${sessionScope.userLang}" /><fmt:setBundle basename="messages" />
<!DOCTYPE html><html lang="${sessionScope.userLang}">
<head><title>Manage Products - PharmStock</title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"></head>
<body>
<%@ include file="../layout/header.jsp" %>
<div class="container">
    <div class="page-header">
        <h1>Manage Products</h1>
        <a href="${pageContext.request.contextPath}/admin/products/create" class="btn btn-primary">+ Add Product</a>
    </div>
    <c:if test="${param.msg == 'saved'}"><div class="alert alert-success">Product saved successfully.</div></c:if>
    <c:if test="${param.msg == 'deleted'}"><div class="alert alert-success">Product deleted.</div></c:if>
    <div class="table-responsive">
        <table>
            <thead><tr><th>Name</th><th>Category</th><th>Barcode</th><th>Stock</th><th>Unit</th><th>Status</th><th>Actions</th></tr></thead>
            <tbody>
                <c:forEach var="p" items="${products}">
                    <tr>
                        <td><strong>${p.name}</strong><c:if test="${not empty p.genericName}"><br><small style="color:var(--text-muted)">${p.genericName}</small></c:if></td>
                        <td>${p.categoryName}</td>
                        <td><code>${p.barcode}</code></td>
                        <td>
                            <c:choose>
                                <c:when test="${p.lowStock}"><span class="badge badge-warning">${p.currentStock}</span></c:when>
                                <c:otherwise><span class="badge badge-success">${p.currentStock}</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>${p.unit}</td>
                        <td><span class="badge ${p.active ? 'badge-success' : 'badge-secondary'}">${p.active ? 'Active' : 'Inactive'}</span></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/products/edit?id=${p.id}" class="btn btn-secondary btn-sm">Edit</a>
                            <form method="post" action="${pageContext.request.contextPath}/admin/products/delete" style="display:inline;" onsubmit="return confirm('Delete this product?')">
                                <input type="hidden" name="id" value="${p.id}">
                                <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <c:if test="${totalPages > 1}">
        <div class="pagination">
            <c:if test="${currentPage > 1}"><a href="?page=${currentPage-1}" class="btn btn-secondary btn-sm">&laquo; Prev</a></c:if>
            <span>Page ${currentPage} / ${totalPages}</span>
            <c:if test="${currentPage < totalPages}"><a href="?page=${currentPage+1}" class="btn btn-secondary btn-sm">Next &raquo;</a></c:if>
        </div>
    </c:if>
</div>
<%@ include file="../layout/footer.jsp" %>
</body></html>
