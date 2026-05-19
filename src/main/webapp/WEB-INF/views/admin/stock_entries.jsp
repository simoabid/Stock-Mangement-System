<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${sessionScope.userLang}" /><fmt:setBundle basename="messages" />
<!DOCTYPE html><html lang="${sessionScope.userLang}">
<head><title>Stock Entries - PharmStock</title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"></head>
<body>
<%@ include file="../layout/header.jsp" %>
<div class="container">
    <div class="page-header"><h1>Stock Entries</h1><a href="${pageContext.request.contextPath}/admin/stock-entries/create" class="btn btn-primary">+ New Entry</a></div>
    <c:if test="${param.msg == 'added'}"><div class="alert alert-success">Stock entry recorded.</div></c:if>
    <div class="table-responsive"><table>
        <thead><tr><th>Product</th><th>Supplier</th><th>Qty</th><th>Purchase</th><th>Selling</th><th>Batch</th><th>Expiry</th><th>Date</th><th>By</th></tr></thead>
        <tbody>
            <c:forEach var="e" items="${entries}">
                <tr><td>${e.productName}</td><td>${e.supplierName}</td>
                    <td><span class="badge badge-success">+${e.quantity}</span></td>
                    <td>${e.purchasePrice}</td><td>${e.sellingPrice}</td>
                    <td><code>${e.batchNumber}</code></td><td>${e.expiryDate}</td><td>${e.entryDate}</td><td>${e.userName}</td></tr>
            </c:forEach>
            <c:if test="${empty entries}"><tr><td colspan="9" class="text-center">No entries yet</td></tr></c:if>
        </tbody>
    </table></div>
    <c:if test="${totalPages > 1}">
        <div class="pagination">
            <c:if test="${currentPage > 1}"><a href="?page=${currentPage-1}" class="btn btn-secondary btn-sm">&laquo;</a></c:if>
            <span>Page ${currentPage} / ${totalPages}</span>
            <c:if test="${currentPage < totalPages}"><a href="?page=${currentPage+1}" class="btn btn-secondary btn-sm">&raquo;</a></c:if>
        </div>
    </c:if>
</div>
<%@ include file="../layout/footer.jsp" %>
</body></html>
