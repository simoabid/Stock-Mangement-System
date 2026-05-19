<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${sessionScope.userLang}" /><fmt:setBundle basename="messages" />
<!DOCTYPE html><html lang="${sessionScope.userLang}">
<head><title>Users - PharmStock</title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"></head>
<body>
<%@ include file="../layout/header.jsp" %>
<div class="container">
    <div class="page-header"><h1>User Management</h1></div>
    <div class="table-responsive"><table>
        <thead><tr><th>Username</th><th>Full Name</th><th>Email</th><th>Role</th><th>Status</th><th>Joined</th><th>Action</th></tr></thead>
        <tbody>
            <c:forEach var="u" items="${users}">
                <tr>
                    <td><strong>${u.username}</strong></td>
                    <td>${u.fullname}</td>
                    <td>${u.email}</td>
                    <td><span class="badge badge-info">${u.role}</span></td>
                    <td><span class="badge ${u.active ? 'badge-success' : 'badge-danger'}">${u.active ? 'Active' : 'Disabled'}</span></td>
                    <td>${u.createdAt}</td>
                    <td>
                        <form method="post" action="${pageContext.request.contextPath}/admin/users/toggle">
                            <input type="hidden" name="id" value="${u.id}">
                            <button type="submit" class="btn ${u.active ? 'btn-warning' : 'btn-success'} btn-sm">${u.active ? 'Disable' : 'Enable'}</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table></div>
    <c:if test="${totalPages > 1}">
        <div class="pagination">
            <c:if test="${currentPage > 1}"><a href="?page=${currentPage-1}" class="btn btn-secondary btn-sm">&laquo;</a></c:if>
            <span>Page ${currentPage} / ${totalPages}</span>
            <c:if test="${currentPage < totalPages}"><a href="?page=${currentPage+1}" class="btn btn-secondary btn-sm">&raquo;</a></c:if>
        </div>
    </c:if>
</div>
<%@ include file="../layout/footer.jsp" %>
</body></html>
