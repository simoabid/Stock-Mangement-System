<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${sessionScope.userLang}" /><fmt:setBundle basename="messages" />
<!DOCTYPE html><html lang="${sessionScope.userLang}" dir="${sessionScope.userLang == 'ar' ? 'rtl' : 'ltr'}">
<head><title><fmt:message key="title.new_stock_entry" /> - PharmStock</title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"></head>
<body>
<%@ include file="../layout/header.jsp" %>
<div class="container" style="max-width: 700px;">
    <a href="${pageContext.request.contextPath}/admin/stock-entries" class="btn btn-secondary btn-sm mb-1">&larr; <fmt:message key="btn.back" /></a>
    <div class="card">
        <h2><fmt:message key="stock_entries.new_title" /></h2>
        <form method="post" action="${pageContext.request.contextPath}/admin/stock-entries/create">
            <div class="form-grid">
                <div class="form-group">
                    <label class="form-label"><fmt:message key="label.product_req" /></label>
                    <select name="productId" class="form-control" required>
                        <option value=""><fmt:message key="label.select_product" /></option>
                        <c:forEach var="p" items="${products}"><option value="${p.id}">${p.name} (${p.currentStock} <fmt:message key="label.in_stock_short" />)</option></c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label"><fmt:message key="label.supplier" /></label>
                    <select name="supplierId" class="form-control">
                        <option value=""><fmt:message key="label.select_supplier" /></option>
                        <c:forEach var="s" items="${suppliers}"><option value="${s.id}">${s.name}</option></c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label"><fmt:message key="label.quantity_req" /></label>
                    <input type="number" name="quantity" class="form-control" required min="1">
                </div>
                <div class="form-group">
                    <label class="form-label"><fmt:message key="label.entry_date_req" /></label>
                    <input type="date" name="entryDate" class="form-control" required>
                </div>
                <div class="form-group">
                    <label class="form-label"><fmt:message key="label.purchase_price" /></label>
                    <input type="number" step="0.01" name="purchasePrice" class="form-control" min="0">
                </div>
                <div class="form-group">
                    <label class="form-label"><fmt:message key="label.selling_price" /></label>
                    <input type="number" step="0.01" name="sellingPrice" class="form-control" min="0">
                </div>
                <div class="form-group">
                    <label class="form-label"><fmt:message key="label.batch_number" /></label>
                    <input type="text" name="batchNumber" class="form-control">
                </div>
                <div class="form-group">
                    <label class="form-label"><fmt:message key="label.expiry_date" /></label>
                    <input type="date" name="expiryDate" class="form-control">
                </div>
            </div>
            <div class="form-group">
                <label class="form-label"><fmt:message key="label.notes" /></label>
                <textarea name="notes" class="form-control"></textarea>
            </div>
            <button type="submit" class="btn btn-primary"><fmt:message key="btn.record_entry" /></button>
        </form>
    </div>
</div>
<%@ include file="../layout/footer.jsp" %>
</body></html>
