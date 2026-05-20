<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${sessionScope.userLang}" />
<fmt:setBundle basename="messages" />
<!DOCTYPE html>
<html lang="${sessionScope.userLang}" dir="${sessionScope.userLang == 'ar' ? 'rtl' : 'ltr'}">
<head><title><c:out value="${product.name}" /> - PharmStock</title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"></head>
<body>
<%@ include file="layout/header.jsp" %>
<div class="container">
    <a href="${pageContext.request.contextPath}/products" class="btn btn-secondary btn-sm mb-1"><fmt:message key="btn.back_to_products" /></a>
    <div class="card" style="margin-top: var(--spacing-md);">
        <h1><c:out value="${product.name}" /></h1>
        <c:if test="${not empty product.genericName}"><p style="font-size: 1.1rem; color: var(--text-muted);"><c:out value="${product.genericName}" /></p></c:if>

        <div class="form-grid" style="margin-top: var(--spacing-lg);">
            <div>
                <p><strong><fmt:message key="label.category" />:</strong> <c:out value="${product.categoryName}" /></p>
                <c:if test="${not empty product.form}"><p><strong><fmt:message key="label.form" />:</strong> <fmt:message key="form.${product.form}" /></p></c:if>
                <c:if test="${not empty product.dosage}"><p><strong><fmt:message key="label.dosage" />:</strong> <c:out value="${product.dosage}" /></p></c:if>
                <c:if test="${not empty product.barcode}"><p><strong><fmt:message key="label.barcode" />:</strong> <c:out value="${product.barcode}" /></p></c:if>
                <p><strong><fmt:message key="label.unit" />:</strong> <c:if test="${not empty product.unit}"><fmt:message key="unit.${product.unit}" /></c:if></p>
            </div>
            <div>
                <p><strong><fmt:message key="label.current_stock" />:</strong>
                    <c:choose>
                        <c:when test="${product.currentStock <= 0}"><span class="badge badge-danger"><fmt:message key="products.out_of_stock" /></span></c:when>
                        <c:when test="${product.lowStock}"><span class="badge badge-warning"><c:out value="${product.currentStock}" /> <fmt:message key="product.low_label" /></span></c:when>
                        <c:otherwise><span class="badge badge-success"><c:out value="${product.currentStock}" /></span></c:otherwise>
                    </c:choose>
                </p>
                <p><strong><fmt:message key="label.min_stock_level" />:</strong> <c:out value="${product.minStockLevel}" /></p>
                <c:if test="${not empty product.shelfLocation}"><p><strong><fmt:message key="label.shelf_location" />:</strong> <c:out value="${product.shelfLocation}" /></p></c:if>
                <p><strong><fmt:message key="label.requires_prescription" />:</strong> <fmt:message key="${product.requiresPrescription ? 'label.yes' : 'label.no'}" /></p>
            </div>
        </div>

        <c:if test="${not empty product.description}">
            <div style="margin-top: var(--spacing-lg);">
                <h3><fmt:message key="product.description_title" /></h3>
                <p><c:out value="${product.description}" /></p>
            </div>
        </c:if>
    </div>
</div>
<%@ include file="layout/footer.jsp" %>
</body>
</html>
