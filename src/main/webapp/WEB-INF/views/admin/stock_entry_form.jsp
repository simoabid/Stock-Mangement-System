<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${sessionScope.userLang}" /><fmt:setBundle basename="messages" />
<!DOCTYPE html><html lang="${sessionScope.userLang}">
<head><title>New Stock Entry - PharmStock</title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"></head>
<body>
<%@ include file="../layout/header.jsp" %>
<div class="container" style="max-width: 700px;">
    <a href="${pageContext.request.contextPath}/admin/stock-entries" class="btn btn-secondary btn-sm mb-1">&larr; Back</a>
    <div class="card">
        <h2>Record Stock Entry</h2>
        <form method="post" action="${pageContext.request.contextPath}/admin/stock-entries/create">
            <div class="form-grid">
                <div class="form-group">
                    <label class="form-label">Product *</label>
                    <select name="productId" class="form-control" required>
                        <option value="">-- Select Product --</option>
                        <c:forEach var="p" items="${products}"><option value="${p.id}">${p.name} (${p.currentStock} in stock)</option></c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label">Supplier</label>
                    <select name="supplierId" class="form-control">
                        <option value="">-- Select Supplier --</option>
                        <c:forEach var="s" items="${suppliers}"><option value="${s.id}">${s.name}</option></c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label">Quantity *</label>
                    <input type="number" name="quantity" class="form-control" required min="1">
                </div>
                <div class="form-group">
                    <label class="form-label">Entry Date *</label>
                    <input type="date" name="entryDate" class="form-control" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Purchase Price</label>
                    <input type="number" step="0.01" name="purchasePrice" class="form-control" min="0">
                </div>
                <div class="form-group">
                    <label class="form-label">Selling Price</label>
                    <input type="number" step="0.01" name="sellingPrice" class="form-control" min="0">
                </div>
                <div class="form-group">
                    <label class="form-label">Batch Number</label>
                    <input type="text" name="batchNumber" class="form-control">
                </div>
                <div class="form-group">
                    <label class="form-label">Expiry Date</label>
                    <input type="date" name="expiryDate" class="form-control">
                </div>
            </div>
            <div class="form-group">
                <label class="form-label">Notes</label>
                <textarea name="notes" class="form-control"></textarea>
            </div>
            <button type="submit" class="btn btn-primary">Record Entry</button>
        </form>
    </div>
</div>
<%@ include file="../layout/footer.jsp" %>
</body></html>
