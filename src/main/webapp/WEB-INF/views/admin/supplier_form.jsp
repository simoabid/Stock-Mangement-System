<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${sessionScope.userLang}" /><fmt:setBundle basename="messages" />
<!DOCTYPE html><html lang="${sessionScope.userLang}" dir="${sessionScope.userLang == 'ar' ? 'rtl' : 'ltr'}">
<head><title><fmt:message key="${empty supplier ? 'label.add' : 'label.edit'}" /> <fmt:message key="label.supplier" /> - PharmStock</title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"></head>
<body>
<%@ include file="../layout/header.jsp" %>
<div class="container" style="max-width: 600px;">
    <a href="${pageContext.request.contextPath}/admin/suppliers" class="btn btn-secondary btn-sm mb-1">&larr; <fmt:message key="btn.back" /></a>
    <div class="card">
        <h2>
            <c:choose>
                <c:when test="${empty supplier}"><fmt:message key="suppliers.add_new" /></c:when>
                <c:otherwise><fmt:message key="suppliers.edit_title" /></c:otherwise>
            </c:choose>
        </h2>
        <form method="post" action="${pageContext.request.contextPath}/admin/suppliers/${empty supplier ? 'create' : 'edit'}">
            <c:if test="${not empty supplier}"><input type="hidden" name="id" value="${supplier.id}"></c:if>
            <div class="form-group"><label class="form-label"><fmt:message key="label.company_name_req" /></label><input type="text" name="name" class="form-control" required value="${supplier.name}"></div>
            <div class="form-group"><label class="form-label"><fmt:message key="label.contact_person" /></label><input type="text" name="contactPerson" class="form-control" value="${supplier.contactPerson}"></div>
            <div class="form-grid">
                <div class="form-group"><label class="form-label"><fmt:message key="label.phone" /></label><input type="text" name="phone" class="form-control" value="${supplier.phone}"></div>
                <div class="form-group"><label class="form-label"><fmt:message key="label.email" /></label><input type="email" name="email" class="form-control" value="${supplier.email}"></div>
            </div>
            <div class="form-group"><label class="form-label"><fmt:message key="label.address" /></label><textarea name="address" class="form-control">${supplier.address}</textarea></div>
            <div class="form-group"><label><input type="checkbox" name="inactive" ${not supplier.active and not empty supplier ? 'checked' : ''}> <fmt:message key="label.mark_inactive" /></label></div>
            <button type="submit" class="btn btn-primary"><fmt:message key="btn.save_supplier" /></button>
        </form>
    </div>
</div>
<%@ include file="../layout/footer.jsp" %>
</body></html>
