<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${sessionScope.userLang}" />
<fmt:setBundle basename="messages" />
<!DOCTYPE html>
<html lang="${sessionScope.userLang}">
<head><title>${product.name} - PharmStock</title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"></head>
<body>
<%@ include file="layout/header.jsp" %>
<div class="container">
    <a href="${pageContext.request.contextPath}/products" class="btn btn-secondary btn-sm mb-1">&larr; Back to Products</a>
    <div class="card" style="margin-top: var(--spacing-md);">
        <h1>${product.name}</h1>
        <c:if test="${not empty product.genericName}"><p style="font-size: 1.1rem; color: var(--text-muted);">${product.genericName}</p></c:if>

        <div class="form-grid" style="margin-top: var(--spacing-lg);">
            <div>
                <p><strong>Category:</strong> ${product.categoryName}</p>
                <c:if test="${not empty product.form}"><p><strong>Form:</strong> ${product.form}</p></c:if>
                <c:if test="${not empty product.dosage}"><p><strong>Dosage:</strong> ${product.dosage}</p></c:if>
                <c:if test="${not empty product.barcode}"><p><strong>Barcode:</strong> ${product.barcode}</p></c:if>
                <p><strong>Unit:</strong> ${product.unit}</p>
            </div>
            <div>
                <p><strong>Current Stock:</strong>
                    <c:choose>
                        <c:when test="${product.currentStock <= 0}"><span class="badge badge-danger">Out of Stock</span></c:when>
                        <c:when test="${product.lowStock}"><span class="badge badge-warning">${product.currentStock} (Low)</span></c:when>
                        <c:otherwise><span class="badge badge-success">${product.currentStock}</span></c:otherwise>
                    </c:choose>
                </p>
                <p><strong>Min Stock Level:</strong> ${product.minStockLevel}</p>
                <c:if test="${not empty product.shelfLocation}"><p><strong>Shelf Location:</strong> ${product.shelfLocation}</p></c:if>
                <p><strong>Requires Prescription:</strong> ${product.requiresPrescription ? 'Yes' : 'No'}</p>
            </div>
        </div>

        <c:if test="${not empty product.description}">
            <div style="margin-top: var(--spacing-lg);">
                <h3>Description</h3>
                <p>${product.description}</p>
            </div>
        </c:if>
    </div>
</div>
<%@ include file="layout/footer.jsp" %>
</body>
</html>
