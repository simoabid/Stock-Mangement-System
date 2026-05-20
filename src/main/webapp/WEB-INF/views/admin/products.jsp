<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${sessionScope.userLang}" /><fmt:setBundle basename="messages" />
<!DOCTYPE html><html lang="${sessionScope.userLang}" dir="${sessionScope.userLang == 'ar' ? 'rtl' : 'ltr'}">
<head><title><fmt:message key="products.manage_title" /> - PharmStock</title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"></head>
<body>
<%@ include file="../layout/header.jsp" %>
<div class="container">
    <div class="page-header">
        <h1><fmt:message key="products.manage_title" /></h1>
        <a href="${pageContext.request.contextPath}/admin/products/create" class="btn btn-primary"><fmt:message key="products.add" /></a>
    </div>
    <c:if test="${param.msg == 'saved'}"><div class="alert alert-success"><fmt:message key="products.saved_ok" /></div></c:if>
    <c:if test="${param.msg == 'deleted'}"><div class="alert alert-success"><fmt:message key="products.deleted_ok" /></div></c:if>
    <script>
        var msgConfirmDeleteProduct = '<fmt:message key="msg.confirm_delete_product" />';
    </script>
    <div class="table-responsive">
        <table>
            <thead><tr><th><fmt:message key="label.name" /></th><th><fmt:message key="label.category" /></th><th><fmt:message key="label.barcode" /></th><th><fmt:message key="label.stock" /></th><th><fmt:message key="label.unit" /></th><th><fmt:message key="label.status" /></th><th><fmt:message key="label.actions" /></th></tr></thead>
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
                        <td><c:if test="${not empty p.unit}"><fmt:message key="unit.${p.unit}" /></c:if></td>
                        <td><span class="badge ${p.active ? 'badge-success' : 'badge-secondary'}"><fmt:message key="${p.active ? 'status.active' : 'status.inactive'}" /></span></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/products/edit?id=${p.id}" class="btn btn-secondary btn-sm"><fmt:message key="btn.edit" /></a>
                            <form method="post" action="${pageContext.request.contextPath}/admin/products/delete" style="display:inline;" onsubmit="return confirm(msgConfirmDeleteProduct)">
                                <input type="hidden" name="id" value="${p.id}">
                                <button type="submit" class="btn btn-danger btn-sm"><fmt:message key="btn.delete" /></button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <c:if test="${totalPages > 1}">
        <div class="pagination">
            <c:if test="${currentPage > 1}"><a href="?page=${currentPage-1}" class="btn btn-secondary btn-sm">&laquo; <fmt:message key="btn.previous" /></a></c:if>
            <span><fmt:message key="products.page_of"><fmt:param value="${currentPage}" /><fmt:param value="${totalPages}" /></fmt:message></span>
            <c:if test="${currentPage < totalPages}"><a href="?page=${currentPage+1}" class="btn btn-secondary btn-sm"><fmt:message key="btn.next" /> &raquo;</a></c:if>
        </div>
    </c:if>
</div>
<%@ include file="../layout/footer.jsp" %>
</body></html>
