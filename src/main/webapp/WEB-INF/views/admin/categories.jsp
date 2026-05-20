<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${sessionScope.userLang}" /><fmt:setBundle basename="messages" />
<!DOCTYPE html><html lang="${sessionScope.userLang}" dir="${sessionScope.userLang == 'ar' ? 'rtl' : 'ltr'}">
<head><title><fmt:message key="title.categories" /> - PharmStock</title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"></head>
<body>
<%@ include file="../layout/header.jsp" %>
<div class="container" style="max-width: 800px;">
    <div class="page-header"><h1><fmt:message key="categories.title" /></h1><a href="${pageContext.request.contextPath}/admin/categories/create" class="btn btn-primary"><fmt:message key="btn.add_category" /></a></div>
    <c:if test="${param.msg == 'saved'}"><div class="alert alert-success"><fmt:message key="categories.saved" /></div></c:if>
    <c:if test="${param.msg == 'deleted'}"><div class="alert alert-success"><fmt:message key="categories.deleted" /></div></c:if>
    <script>
        var msgConfirmDelete = '<fmt:message key="msg.confirm_delete" />';
    </script>
    <div class="table-responsive"><table>
        <thead><tr><th><fmt:message key="label.name" /></th><th><fmt:message key="label.description" /></th><th><fmt:message key="label.actions" /></th></tr></thead>
        <tbody>
            <c:forEach var="cat" items="${categories}">
                <tr><td><strong>${cat.name}</strong></td><td>${cat.description}</td><td>
                    <a href="${pageContext.request.contextPath}/admin/categories/edit?id=${cat.id}" class="btn btn-secondary btn-sm"><fmt:message key="btn.edit" /></a>
                    <form method="post" action="${pageContext.request.contextPath}/admin/categories/delete" style="display:inline;" onsubmit="return confirm(msgConfirmDelete)">
                        <input type="hidden" name="id" value="${cat.id}"><button type="submit" class="btn btn-danger btn-sm"><fmt:message key="btn.delete" /></button>
                    </form></td></tr>
            </c:forEach>
        </tbody>
    </table></div>
</div>
<%@ include file="../layout/footer.jsp" %>
</body></html>
