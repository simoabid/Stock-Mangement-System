<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${sessionScope.userLang}" /><fmt:setBundle basename="messages" />
<!DOCTYPE html><html lang="${sessionScope.userLang}" dir="${sessionScope.userLang == 'ar' ? 'rtl' : 'ltr'}">
<head><title><fmt:message key="title.new_stock_exit" /> - PharmStock</title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"></head>
<body>
<%@ include file="../layout/header.jsp" %>
<div class="container" style="max-width: 600px;">
    <a href="${pageContext.request.contextPath}/admin/stock-exits" class="btn btn-secondary btn-sm mb-1">&larr; <fmt:message key="btn.back" /></a>
    <div class="card">
        <h2><fmt:message key="stock_exits.new_title" /></h2>
        <c:if test="${not empty error}"><div class="alert alert-error"><c:out value="${error}" /></div></c:if>
        <form method="post" action="${pageContext.request.contextPath}/admin/stock-exits/create">
            <div class="form-group">
                <label class="form-label"><fmt:message key="label.product_req" /></label>
                <select name="productId" class="form-control" required>
                    <option value=""><fmt:message key="label.select_product" /></option>
                    <c:forEach var="p" items="${products}"><option value="${p.id}">${p.name} (${p.currentStock} <fmt:message key="label.available" />)</option></c:forEach>
                </select>
            </div>
            <div class="form-grid">
                <div class="form-group">
                    <label class="form-label"><fmt:message key="label.quantity_req" /></label>
                    <input type="number" name="quantity" class="form-control" required min="1">
                </div>
                <div class="form-group">
                    <label class="form-label"><fmt:message key="label.exit_date_req" /></label>
                    <input type="date" name="exitDate" class="form-control" required>
                </div>
            </div>
            <div class="form-group">
                <label class="form-label"><fmt:message key="label.exit_type_req" /></label>
                <select name="exitType" class="form-control" required>
                    <option value="SALE"><fmt:message key="exitType.SALE" /></option>
                    <option value="RETURN_TO_SUPPLIER"><fmt:message key="exitType.RETURN_TO_SUPPLIER" /></option>
                    <option value="EXPIRED_DISPOSAL"><fmt:message key="exitType.EXPIRED_DISPOSAL" /></option>
                    <option value="DAMAGED"><fmt:message key="exitType.DAMAGED" /></option>
                    <option value="INTERNAL_USE"><fmt:message key="exitType.INTERNAL_USE" /></option>
                </select>
            </div>
            <div class="form-group">
                <label class="form-label"><fmt:message key="label.notes" /></label>
                <textarea name="notes" class="form-control"></textarea>
            </div>
            <button type="submit" class="btn btn-primary"><fmt:message key="btn.record_exit" /></button>
        </form>
    </div>
</div>
<%@ include file="../layout/footer.jsp" %>
</body></html>
