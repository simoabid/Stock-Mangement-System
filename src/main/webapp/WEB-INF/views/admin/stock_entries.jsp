<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${sessionScope.userLang}" /><fmt:setBundle basename="messages" />
<!DOCTYPE html><html lang="${sessionScope.userLang}" dir="${sessionScope.userLang == 'ar' ? 'rtl' : 'ltr'}">
<head><title><fmt:message key="title.stock_entries" /> - PharmStock</title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"></head>
<body>
<%@ include file="../layout/header.jsp" %>
<div class="container">
    <div class="page-header"><h1><fmt:message key="stock_entries.title" /></h1><a href="${pageContext.request.contextPath}/admin/stock-entries/create" class="btn btn-primary"><fmt:message key="btn.new_entry" /></a></div>
    <c:if test="${param.msg == 'added'}"><div class="alert alert-success"><fmt:message key="stock_entries.added" /></div></c:if>
    <div class="table-responsive"><table>
        <thead><tr><th><fmt:message key="label.product" /></th><th><fmt:message key="label.supplier" /></th><th><fmt:message key="label.quantity_short" /></th><th><fmt:message key="label.purchase" /></th><th><fmt:message key="label.selling" /></th><th><fmt:message key="label.batch" /></th><th><fmt:message key="label.expiry" /></th><th><fmt:message key="label.date" /></th><th><fmt:message key="label.by" /></th></tr></thead>
        <tbody>
            <c:forEach var="e" items="${entries}">
                <tr><td>${e.productName}</td><td>${e.supplierName}</td>
                    <td><span class="badge badge-success">+${e.quantity}</span></td>
                    <td>${e.purchasePrice}</td><td>${e.sellingPrice}</td>
                    <td><code>${e.batchNumber}</code></td><td>${e.expiryDate}</td><td>${e.entryDate}</td><td>${e.userName}</td></tr>
            </c:forEach>
            <c:if test="${empty entries}"><tr><td colspan="9" class="text-center"><fmt:message key="stock_entries.none" /></td></tr></c:if>
        </tbody>
    </table></div>
    <c:if test="${totalPages > 1}">
        <div class="pagination">
            <c:if test="${currentPage > 1}"><a href="?page=${currentPage-1}" class="btn btn-secondary btn-sm">&laquo;</a></c:if>
            <span><fmt:message key="products.page_of"><fmt:param value="${currentPage}" /><fmt:param value="${totalPages}" /></fmt:message></span>
            <c:if test="${currentPage < totalPages}"><a href="?page=${currentPage+1}" class="btn btn-secondary btn-sm">&raquo;</a></c:if>
        </div>
    </c:if>
</div>
<%@ include file="../layout/footer.jsp" %>
</body></html>
