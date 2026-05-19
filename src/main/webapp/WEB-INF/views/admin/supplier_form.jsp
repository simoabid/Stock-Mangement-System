<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${sessionScope.userLang}" /><fmt:setBundle basename="messages" />
<!DOCTYPE html><html lang="${sessionScope.userLang}">
<head><title>${empty supplier ? 'Add' : 'Edit'} Supplier - PharmStock</title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"></head>
<body>
<%@ include file="../layout/header.jsp" %>
<div class="container" style="max-width: 600px;">
    <a href="${pageContext.request.contextPath}/admin/suppliers" class="btn btn-secondary btn-sm mb-1">&larr; Back</a>
    <div class="card">
        <h2>${empty supplier ? 'Add New Supplier' : 'Edit Supplier'}</h2>
        <form method="post" action="${pageContext.request.contextPath}/admin/suppliers/${empty supplier ? 'create' : 'edit'}">
            <c:if test="${not empty supplier}"><input type="hidden" name="id" value="${supplier.id}"></c:if>
            <div class="form-group"><label class="form-label">Company Name *</label><input type="text" name="name" class="form-control" required value="${supplier.name}"></div>
            <div class="form-group"><label class="form-label">Contact Person</label><input type="text" name="contactPerson" class="form-control" value="${supplier.contactPerson}"></div>
            <div class="form-grid">
                <div class="form-group"><label class="form-label">Phone</label><input type="text" name="phone" class="form-control" value="${supplier.phone}"></div>
                <div class="form-group"><label class="form-label">Email</label><input type="email" name="email" class="form-control" value="${supplier.email}"></div>
            </div>
            <div class="form-group"><label class="form-label">Address</label><textarea name="address" class="form-control">${supplier.address}</textarea></div>
            <div class="form-group"><label><input type="checkbox" name="inactive" ${not supplier.active and not empty supplier ? 'checked' : ''}> Mark as Inactive</label></div>
            <button type="submit" class="btn btn-primary">Save Supplier</button>
        </form>
    </div>
</div>
<%@ include file="../layout/footer.jsp" %>
</body></html>
