<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${sessionScope.userLang}" /><fmt:setBundle basename="messages" />
<!DOCTYPE html><html lang="${sessionScope.userLang}" dir="${sessionScope.userLang == 'ar' ? 'rtl' : 'ltr'}">
<head><title><fmt:message key="title.stock_exits" /> - PharmStock</title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"></head>
<body>
<%@ include file="../layout/header.jsp" %>
<div class="container">
    <div class="page-header"><h1><fmt:message key="stock_exits.title" /></h1><a href="${pageContext.request.contextPath}/admin/stock-exits/create" class="btn btn-primary"><fmt:message key="btn.new_exit" /></a></div>
    <c:if test="${param.msg == 'recorded'}"><div class="alert alert-success"><fmt:message key="stock_exits.recorded" /></div></c:if>
    <div class="table-responsive"><table>
        <thead><tr><th><fmt:message key="label.product" /></th><th><fmt:message key="label.quantity_short" /></th><th><fmt:message key="label.type" /></th><th><fmt:message key="label.date" /></th><th><fmt:message key="label.by" /></th><th><fmt:message key="label.notes" /></th></tr></thead>
        <tbody>
            <c:forEach var="x" items="${exits}">
                <tr><td>${x.productName}</td>
                    <td><span class="badge badge-danger">-${x.quantity}</span></td>
                    <td><span class="badge badge-secondary"><fmt:message key="exitType.${x.exitType}" /></span></td>
                    <td>${x.exitDate}</td><td>${x.userName}</td><td>${x.notes}</td></tr>
            </c:forEach>
            <c:if test="${empty exits}"><tr><td colspan="6" class="text-center"><fmt:message key="stock_exits.none" /></td></tr></c:if>
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
