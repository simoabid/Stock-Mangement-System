<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${sessionScope.userLang}" /><fmt:setBundle basename="messages" />
<!DOCTYPE html><html lang="${sessionScope.userLang}">
<head><title>${empty product ? 'Add' : 'Edit'} Product - PharmStock</title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"></head>
<body>
<%@ include file="../layout/header.jsp" %>
<div class="container" style="max-width: 800px;">
    <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-secondary btn-sm mb-1">&larr; Back</a>
    <div class="card">
        <h2>${empty product ? 'Add New Product' : 'Edit Product'}</h2>
        <form method="post" action="${pageContext.request.contextPath}/admin/products/${empty product ? 'create' : 'edit'}" enctype="multipart/form-data">
            <c:if test="${not empty product}"><input type="hidden" name="id" value="${product.id}"></c:if>
            <div class="form-grid">
                <div class="form-group">
                    <label class="form-label">Product Name *</label>
                    <input type="text" name="name" class="form-control" required value="${product.name}">
                </div>
                <div class="form-group">
                    <label class="form-label">Generic Name</label>
                    <input type="text" name="genericName" class="form-control" value="${product.genericName}">
                </div>
                <div class="form-group">
                    <label class="form-label">Category</label>
                    <select name="categoryId" class="form-control">
                        <option value="">-- Select --</option>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.id}" ${product.categoryId == cat.id ? 'selected' : ''}>${cat.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label">Form</label>
                    <select name="form" class="form-control">
                        <option value="">-- Select --</option>
                        <option ${product.form == 'Tablet' ? 'selected' : ''}>Tablet</option>
                        <option ${product.form == 'Capsule' ? 'selected' : ''}>Capsule</option>
                        <option ${product.form == 'Syrup' ? 'selected' : ''}>Syrup</option>
                        <option ${product.form == 'Injection' ? 'selected' : ''}>Injection</option>
                        <option ${product.form == 'Cream' ? 'selected' : ''}>Cream</option>
                        <option ${product.form == 'Gel' ? 'selected' : ''}>Gel</option>
                        <option ${product.form == 'Inhaler' ? 'selected' : ''}>Inhaler</option>
                        <option ${product.form == 'Solution' ? 'selected' : ''}>Solution</option>
                        <option ${product.form == 'Liquid' ? 'selected' : ''}>Liquid</option>
                        <option ${product.form == 'Drops' ? 'selected' : ''}>Drops</option>
                        <option ${product.form == 'Powder' ? 'selected' : ''}>Powder</option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label">Dosage</label>
                    <input type="text" name="dosage" class="form-control" placeholder="e.g. 500mg" value="${product.dosage}">
                </div>
                <div class="form-group">
                    <label class="form-label">Barcode</label>
                    <input type="text" name="barcode" class="form-control" value="${product.barcode}">
                </div>
                <div class="form-group">
                    <label class="form-label">Unit *</label>
                    <select name="unit" class="form-control" required>
                        <option ${product.unit == 'Box' ? 'selected' : ''}>Box</option>
                        <option ${product.unit == 'Piece' ? 'selected' : ''}>Piece</option>
                        <option ${product.unit == 'Bottle' ? 'selected' : ''}>Bottle</option>
                        <option ${product.unit == 'Tube' ? 'selected' : ''}>Tube</option>
                        <option ${product.unit == 'Pack' ? 'selected' : ''}>Pack</option>
                        <option ${product.unit == 'Vial' ? 'selected' : ''}>Vial</option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label">Shelf Location</label>
                    <input type="text" name="shelfLocation" class="form-control" placeholder="e.g. A1-S2" value="${product.shelfLocation}">
                </div>
                <div class="form-group">
                    <label class="form-label">Min Stock Level</label>
                    <input type="number" name="minStockLevel" class="form-control" value="${empty product.minStockLevel ? 10 : product.minStockLevel}" min="0">
                </div>
                <div class="form-group">
                    <label class="form-label">Product Image</label>
                    <input type="file" name="image" class="form-control" accept="image/*">
                </div>
            </div>
            <div class="form-group">
                <label class="form-label">Description</label>
                <textarea name="description" class="form-control">${product.description}</textarea>
            </div>
            <div class="form-group" style="display:flex; gap: 1.5rem;">
                <label><input type="checkbox" name="requiresPrescription" ${product.requiresPrescription ? 'checked' : ''}> Requires Prescription</label>
                <label><input type="checkbox" name="inactive" ${not product.active and not empty product ? 'checked' : ''}> Mark as Inactive</label>
            </div>
            <button type="submit" class="btn btn-primary">Save Product</button>
        </form>
    </div>
</div>
<%@ include file="../layout/footer.jsp" %>
</body></html>
