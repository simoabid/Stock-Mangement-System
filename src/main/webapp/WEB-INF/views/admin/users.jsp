<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${sessionScope.userLang}" /><fmt:setBundle basename="messages" />
<!DOCTYPE html><html lang="${sessionScope.userLang}" dir="${sessionScope.userLang == 'ar' ? 'rtl' : 'ltr'}">
<head><title><fmt:message key="title.users" /> - PharmStock</title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"></head>
<body>
<%@ include file="../layout/header.jsp" %>
<div class="container">
    <div class="page-header"><h1><fmt:message key="users.title" /></h1></div>
    <div class="table-responsive"><table>
        <thead><tr><th><fmt:message key="label.username" /></th><th><fmt:message key="label.full_name" /></th><th><fmt:message key="label.email" /></th><th><fmt:message key="label.role" /></th><th><fmt:message key="label.status" /></th><th><fmt:message key="label.joined" /></th><th><fmt:message key="label.action" /></th></tr></thead>
        <tbody>
            <c:forEach var="u" items="${users}">
                <tr>
                    <td><strong><c:out value="${u.username}" /></strong></td>
                    <td><c:out value="${u.fullname}" /></td>
                    <td><c:out value="${u.email}" /></td>
                    <td><span class="badge badge-info"><fmt:message key="role.${u.role}" /></span></td>
                    <td><span class="badge ${u.active ? 'badge-success' : 'badge-danger'}"><fmt:message key="${u.active ? 'status.active' : 'status.disabled'}" /></span></td>
                    <td><c:out value="${u.createdAt}" /></td>
                    <td>
                        <form method="post" action="${pageContext.request.contextPath}/admin/users/toggle">
                            <input type="hidden" name="id" value="${u.id}">
                            <button type="submit" class="btn ${u.active ? 'btn-warning' : 'btn-success'} btn-sm"><fmt:message key="${u.active ? 'btn.disable' : 'btn.enable'}" /></button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table></div>
    <c:if test="${totalPages > 1}">
        <div class="pagination">
            <c:if test="${currentPage > 1}"><a href="?page=${currentPage-1}" class="btn btn-secondary btn-sm">&laquo;</a></c:if>
            <span><fmt:message key="products.page_of"><fmt:param value="${currentPage}" /><fmt:param value="${totalPages}" /></fmt:message></span>
            <c:if test="${currentPage < totalPages}"><a href="?page=${currentPage+1}" class="btn btn-secondary btn-sm">&raquo;</a></c:if>
        </div>
    </c:if>
</div>
<%@ include file="../layout/footer.jsp" %>
</body></html>
