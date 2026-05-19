<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${sessionScope.userLang}" /><fmt:setBundle basename="messages" />
<!DOCTYPE html><html lang="${sessionScope.userLang}">
<head><title>${empty category ? 'Add' : 'Edit'} Category - PharmStock</title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"></head>
<body>
<%@ include file="../layout/header.jsp" %>
<div class="container" style="max-width: 500px;">
    <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-secondary btn-sm mb-1">&larr; Back</a>
    <div class="card">
        <h2>${empty category ? 'Add New Category' : 'Edit Category'}</h2>
        <form method="post" action="${pageContext.request.contextPath}/admin/categories/${empty category ? 'create' : 'edit'}">
            <c:if test="${not empty category}"><input type="hidden" name="id" value="${category.id}"></c:if>
            <div class="form-group"><label class="form-label">Name *</label><input type="text" name="name" class="form-control" required value="${category.name}"></div>
            <div class="form-group"><label class="form-label">Description</label><textarea name="description" class="form-control">${category.description}</textarea></div>
            <button type="submit" class="btn btn-primary">Save Category</button>
        </form>
    </div>
</div>
<%@ include file="../layout/footer.jsp" %>
</body></html>
