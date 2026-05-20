<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${sessionScope.userLang}" /><fmt:setBundle basename="messages" />
<!DOCTYPE html><html lang="${sessionScope.userLang}" dir="${sessionScope.userLang == 'ar' ? 'rtl' : 'ltr'}">
<head><title><fmt:message key="title.suppliers" /> - PharmStock</title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"></head>
<body>
<%@ include file="../layout/header.jsp" %>
<div class="container">
    <div class="page-header"><h1><fmt:message key="suppliers.title" /></h1><a href="${pageContext.request.contextPath}/admin/suppliers/create" class="btn btn-primary"><fmt:message key="btn.add_supplier" /></a></div>
    <c:if test="${param.msg == 'saved'}"><div class="alert alert-success"><fmt:message key="suppliers.saved" /></div></c:if>
    <c:if test="${param.msg == 'deleted'}"><div class="alert alert-success"><fmt:message key="suppliers.deleted" /></div></c:if>
    <script>
        var msgConfirmDeleteSupplier = '<fmt:message key="msg.confirm_delete_supplier" />';
    </script>
    <div class="table-responsive"><table>
        <thead><tr><th><fmt:message key="label.name" /></th><th><fmt:message key="label.contact_person" /></th><th><fmt:message key="label.phone" /></th><th><fmt:message key="label.email" /></th><th><fmt:message key="label.address" /></th><th><fmt:message key="label.actions" /></th></tr></thead>
        <tbody>
            <c:forEach var="sup" items="${suppliers}">
                <tr><td><strong>${sup.name}</strong></td><td>${sup.contactPerson}</td><td>${sup.phone}</td><td>${sup.email}</td><td>${sup.address}</td><td>
                    <a href="${pageContext.request.contextPath}/admin/suppliers/edit?id=${sup.id}" class="btn btn-secondary btn-sm"><fmt:message key="btn.edit" /></a>
                    <form method="post" action="${pageContext.request.contextPath}/admin/suppliers/delete" style="display:inline;" onsubmit="return confirm(msgConfirmDeleteSupplier)">
                        <input type="hidden" name="id" value="${sup.id}"><button type="submit" class="btn btn-danger btn-sm"><fmt:message key="btn.delete" /></button>
                    </form></td></tr>
            </c:forEach>
        </tbody>
    </table></div>
</div>
<%@ include file="../layout/footer.jsp" %>
</body></html>
