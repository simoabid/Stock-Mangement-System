<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${sessionScope.userLang}" />
<fmt:setBundle basename="messages" />
<!DOCTYPE html>
<html lang="${sessionScope.userLang}" dir="${sessionScope.userLang == 'ar' ? 'rtl' : 'ltr'}">
<head><title><fmt:message key="title.products" /></title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"></head>
<body>
<%@ include file="layout/header.jsp" %>
<div class="container">
    <div class="page-header">
        <h1><fmt:message key="products.title" /></h1>
        <c:if test="${sessionScope.user.role == 'ADMIN'}">
            <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-secondary btn-sm"><fmt:message key="products.manage" /></a>
        </c:if>
    </div>

    <form class="search-bar" method="get" action="${pageContext.request.contextPath}/products">
        <input type="text" name="q" class="form-control" placeholder="<fmt:message key='products.search_placeholder' />" value="${searchQuery}">
        <select name="category" class="form-control" style="max-width: 200px;">
            <option value=""><fmt:message key="products.all_categories" /></option>
            <c:forEach var="cat" items="${categories}">
                <option value="${cat.id}" ${selectedCategory == cat.id ? 'selected' : ''}>${cat.name}</option>
            </c:forEach>
        </select>
        <button type="submit" class="btn btn-primary"><fmt:message key="btn.search" /></button>
    </form>

    <div class="product-grid">
        <c:forEach var="p" items="${products}">
            <a href="${pageContext.request.contextPath}/products?id=${p.id}" class="product-card">
                <div class="product-info">
                    <div class="product-name"><c:out value="${p.name}" /></div>
                    <div class="product-meta">
                        <c:if test="${not empty p.genericName}"><c:out value="${p.genericName}" /> &bull; </c:if>
                        <c:if test="${not empty p.dosage}"><c:out value="${p.dosage}" /> &bull; </c:if>
                        <c:out value="${p.categoryName}" />
                    </div>
                    <c:if test="${not empty p.form}"><div class="product-meta"><fmt:message key="form.${p.form}" /> &bull; <fmt:message key="unit.${p.unit}" /></div></c:if>
                    <div class="product-stock">
                        <c:choose>
                            <c:when test="${p.currentStock <= 0}"><span class="badge badge-danger"><fmt:message key="products.out_of_stock" /></span></c:when>
                            <c:when test="${p.lowStock}"><span class="badge badge-warning"><fmt:message key="products.low"><fmt:param value="${p.currentStock}" /></fmt:message></span></c:when>
                            <c:otherwise><span class="badge badge-success"><fmt:message key="products.in_stock"><fmt:param value="${p.currentStock}" /></fmt:message></span></c:otherwise>
                        </c:choose>
                        <c:if test="${p.requiresPrescription}"><span class="badge badge-info">Rx</span></c:if>
                    </div>
                </div>
            </a>
        </c:forEach>
    </div>

    <c:if test="${empty products}"><p class="text-center" style="margin-top: var(--spacing-xl);"><fmt:message key="products.not_found" /></p></c:if>

    <c:if test="${totalPages > 1}">
        <div class="pagination">
            <c:if test="${currentPage > 1}"><a href="?q=${searchQuery}&category=${selectedCategory}&page=${currentPage-1}" class="btn btn-secondary btn-sm">&laquo; <fmt:message key="btn.previous" /></a></c:if>
            <span><fmt:message key="products.page_info"><fmt:param value="${currentPage}" /><fmt:param value="${totalPages}" /></fmt:message></span>
            <c:if test="${currentPage < totalPages}"><a href="?q=${searchQuery}&category=${selectedCategory}&page=${currentPage+1}" class="btn btn-secondary btn-sm"><fmt:message key="btn.next" /> &raquo;</a></c:if>
        </div>
    </c:if>
</div>
<%@ include file="layout/footer.jsp" %>
</body>
</html>
