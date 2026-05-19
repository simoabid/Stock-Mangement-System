<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${sessionScope.userLang}" /><fmt:setBundle basename="messages" />
<!DOCTYPE html><html lang="${sessionScope.userLang}">
<head><title>Stock Exits - PharmStock</title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"></head>
<body>
<%@ include file="../layout/header.jsp" %>
<div class="container">
    <div class="page-header"><h1>Stock Exits</h1><a href="${pageContext.request.contextPath}/admin/stock-exits/create" class="btn btn-primary">+ New Exit</a></div>
    <c:if test="${param.msg == 'recorded'}"><div class="alert alert-success">Stock exit recorded.</div></c:if>
    <div class="table-responsive"><table>
        <thead><tr><th>Product</th><th>Qty</th><th>Type</th><th>Date</th><th>By</th><th>Notes</th></tr></thead>
        <tbody>
            <c:forEach var="x" items="${exits}">
                <tr><td>${x.productName}</td>
                    <td><span class="badge badge-danger">-${x.quantity}</span></td>
                    <td><span class="badge badge-secondary">${x.exitType}</span></td>
                    <td>${x.exitDate}</td><td>${x.userName}</td><td>${x.notes}</td></tr>
            </c:forEach>
            <c:if test="${empty exits}"><tr><td colspan="6" class="text-center">No exits yet</td></tr></c:if>
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
