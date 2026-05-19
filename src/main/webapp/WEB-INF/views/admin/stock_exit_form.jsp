<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${sessionScope.userLang}" /><fmt:setBundle basename="messages" />
<!DOCTYPE html><html lang="${sessionScope.userLang}">
<head><title>New Stock Exit - PharmStock</title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"></head>
<body>
<%@ include file="../layout/header.jsp" %>
<div class="container" style="max-width: 600px;">
    <a href="${pageContext.request.contextPath}/admin/stock-exits" class="btn btn-secondary btn-sm mb-1">&larr; Back</a>
    <div class="card">
        <h2>Record Stock Exit</h2>
        <c:if test="${not empty error}"><div class="alert alert-error">${error}</div></c:if>
        <form method="post" action="${pageContext.request.contextPath}/admin/stock-exits/create">
            <div class="form-group">
                <label class="form-label">Product *</label>
                <select name="productId" class="form-control" required>
                    <option value="">-- Select Product --</option>
                    <c:forEach var="p" items="${products}"><option value="${p.id}">${p.name} (${p.currentStock} available)</option></c:forEach>
                </select>
            </div>
            <div class="form-grid">
                <div class="form-group">
                    <label class="form-label">Quantity *</label>
                    <input type="number" name="quantity" class="form-control" required min="1">
                </div>
                <div class="form-group">
                    <label class="form-label">Exit Date *</label>
                    <input type="date" name="exitDate" class="form-control" required>
                </div>
            </div>
            <div class="form-group">
                <label class="form-label">Exit Type *</label>
                <select name="exitType" class="form-control" required>
                    <option value="SALE">Sale</option>
                    <option value="RETURN_TO_SUPPLIER">Return to Supplier</option>
                    <option value="EXPIRED_DISPOSAL">Expired / Disposal</option>
                    <option value="DAMAGED">Damaged</option>
                    <option value="INTERNAL_USE">Internal Use</option>
                </select>
            </div>
            <div class="form-group">
                <label class="form-label">Notes</label>
                <textarea name="notes" class="form-control"></textarea>
            </div>
            <button type="submit" class="btn btn-primary">Record Exit</button>
        </form>
    </div>
</div>
<%@ include file="../layout/footer.jsp" %>
</body></html>
