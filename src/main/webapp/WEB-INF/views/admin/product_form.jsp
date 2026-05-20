<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${sessionScope.userLang}" /><fmt:setBundle basename="messages" />
<!DOCTYPE html><html lang="${sessionScope.userLang}" dir="${sessionScope.userLang == 'ar' ? 'rtl' : 'ltr'}">
<head><title><fmt:message key="${empty product ? 'label.add' : 'label.edit'}" /> <fmt:message key="label.product" /> - PharmStock</title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"></head>
<body>
<%@ include file="../layout/header.jsp" %>
<div class="container" style="max-width: 800px;">
    <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-secondary btn-sm mb-1">&larr; <fmt:message key="btn.back" /></a>
    <div class="card">
        <h2>
            <c:choose>
                <c:when test="${empty product}"><fmt:message key="products.add_new_title" /></c:when>
                <c:otherwise><fmt:message key="products.edit_title" /></c:otherwise>
            </c:choose>
        </h2>
        <form method="post" action="${pageContext.request.contextPath}/admin/products/${empty product ? 'create' : 'edit'}" enctype="multipart/form-data">
            <c:if test="${not empty product}"><input type="hidden" name="id" value="${product.id}"></c:if>
            <div class="form-grid">
                <div class="form-group">
                    <label class="form-label"><fmt:message key="label.product_name_req" /></label>
                    <input type="text" name="name" class="form-control" required value="${product.name}">
                </div>
                <div class="form-group">
                    <label class="form-label"><fmt:message key="label.generic_name" /></label>
                    <input type="text" name="genericName" class="form-control" value="${product.genericName}">
                </div>
                <div class="form-group">
                    <label class="form-label"><fmt:message key="label.category" /></label>
                    <select name="categoryId" class="form-control">
                        <option value=""><fmt:message key="label.select_placeholder" /></option>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.id}" ${product.categoryId == cat.id ? 'selected' : ''}>${cat.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label"><fmt:message key="label.form" /></label>
                    <select name="form" class="form-control">
                        <option value=""><fmt:message key="label.select_placeholder" /></option>
                        <option value="Tablet" ${product.form == 'Tablet' ? 'selected' : ''}><fmt:message key="form.Tablet" /></option>
                        <option value="Capsule" ${product.form == 'Capsule' ? 'selected' : ''}><fmt:message key="form.Capsule" /></option>
                        <option value="Syrup" ${product.form == 'Syrup' ? 'selected' : ''}><fmt:message key="form.Syrup" /></option>
                        <option value="Injection" ${product.form == 'Injection' ? 'selected' : ''}><fmt:message key="form.Injection" /></option>
                        <option value="Cream" ${product.form == 'Cream' ? 'selected' : ''}><fmt:message key="form.Cream" /></option>
                        <option value="Gel" ${product.form == 'Gel' ? 'selected' : ''}><fmt:message key="form.Gel" /></option>
                        <option value="Inhaler" ${product.form == 'Inhaler' ? 'selected' : ''}><fmt:message key="form.Inhaler" /></option>
                        <option value="Solution" ${product.form == 'Solution' ? 'selected' : ''}><fmt:message key="form.Solution" /></option>
                        <option value="Liquid" ${product.form == 'Liquid' ? 'selected' : ''}><fmt:message key="form.Liquid" /></option>
                        <option value="Drops" ${product.form == 'Drops' ? 'selected' : ''}><fmt:message key="form.Drops" /></option>
                        <option value="Powder" ${product.form == 'Powder' ? 'selected' : ''}><fmt:message key="form.Powder" /></option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label"><fmt:message key="label.dosage" /></label>
                    <input type="text" name="dosage" class="form-control" placeholder="e.g. 500mg" value="${product.dosage}">
                </div>
                <div class="form-group">
                    <label class="form-label"><fmt:message key="label.barcode" /></label>
                    <input type="text" name="barcode" class="form-control" value="${product.barcode}">
                </div>
                <div class="form-group">
                    <label class="form-label"><fmt:message key="label.unit_req" /></label>
                    <select name="unit" class="form-control" required>
                        <option value="Box" ${product.unit == 'Box' ? 'selected' : ''}><fmt:message key="unit.Box" /></option>
                        <option value="Piece" ${product.unit == 'Piece' ? 'selected' : ''}><fmt:message key="unit.Piece" /></option>
                        <option value="Bottle" ${product.unit == 'Bottle' ? 'selected' : ''}><fmt:message key="unit.Bottle" /></option>
                        <option value="Tube" ${product.unit == 'Tube' ? 'selected' : ''}><fmt:message key="unit.Tube" /></option>
                        <option value="Pack" ${product.unit == 'Pack' ? 'selected' : ''}><fmt:message key="unit.Pack" /></option>
                        <option value="Vial" ${product.unit == 'Vial' ? 'selected' : ''}><fmt:message key="unit.Vial" /></option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label"><fmt:message key="label.shelf_location" /></label>
                    <input type="text" name="shelfLocation" class="form-control" placeholder="e.g. A1-S2" value="${product.shelfLocation}">
                </div>
                <div class="form-group">
                    <label class="form-label"><fmt:message key="label.min_stock_level" /></label>
                    <input type="number" name="minStockLevel" class="form-control" value="${empty product.minStockLevel ? 10 : product.minStockLevel}" min="0">
                </div>
                <div class="form-group">
                    <label class="form-label"><fmt:message key="label.product_image" /></label>
                    <input type="file" name="image" class="form-control" accept="image/*">
                </div>
            </div>
            <div class="form-group">
                <label class="form-label"><fmt:message key="label.description" /></label>
                <textarea name="description" class="form-control">${product.description}</textarea>
            </div>
            <div class="form-group" style="display:flex; gap: 1.5rem;">
                <label><input type="checkbox" name="requiresPrescription" ${product.requiresPrescription ? 'checked' : ''}> <fmt:message key="label.requires_prescription" /></label>
                <label><input type="checkbox" name="inactive" ${not product.active and not empty product ? 'checked' : ''}> <fmt:message key="label.mark_inactive" /></label>
            </div>
            <button type="submit" class="btn btn-primary"><fmt:message key="btn.save_product" /></button>
        </form>
    </div>
</div>
<%@ include file="../layout/footer.jsp" %>
</body></html>
