<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${sessionScope.userLang}" /><fmt:setBundle basename="messages" />
<!DOCTYPE html><html lang="${sessionScope.userLang}" dir="${sessionScope.userLang == 'ar' ? 'rtl' : 'ltr'}">
<head><title><fmt:message key="${empty category ? 'label.add' : 'label.edit'}" /> <fmt:message key="label.category" /> - PharmStock</title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"></head>
<body>
<%@ include file="../layout/header.jsp" %>
<div class="container" style="max-width: 500px;">
    <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-secondary btn-sm mb-1">&larr; <fmt:message key="btn.back" /></a>
    <div class="card">
        <h2>
            <c:choose>
                <c:when test="${empty category}"><fmt:message key="categories.add_new" /></c:when>
                <c:otherwise><fmt:message key="categories.edit_title" /></c:otherwise>
            </c:choose>
        </h2>
        <form method="post" action="${pageContext.request.contextPath}/admin/categories/${empty category ? 'create' : 'edit'}">
            <c:if test="${not empty category}"><input type="hidden" name="id" value="${category.id}"></c:if>
            <div class="form-group"><label class="form-label"><fmt:message key="label.name_req" /></label><input type="text" name="name" class="form-control" required value="${category.name}"></div>
            <div class="form-group"><label class="form-label"><fmt:message key="label.description" /></label><textarea name="description" class="form-control">${category.description}</textarea></div>
            <button type="submit" class="btn btn-primary"><fmt:message key="btn.save_category" /></button>
        </form>
    </div>
</div>
<%@ include file="../layout/footer.jsp" %>
</body></html>
