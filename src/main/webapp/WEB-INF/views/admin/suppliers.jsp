<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${sessionScope.userLang}" /><fmt:setBundle basename="messages" />
<!DOCTYPE html><html lang="${sessionScope.userLang}">
<head><title>Suppliers - PharmStock</title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"></head>
<body>
<%@ include file="../layout/header.jsp" %>
<div class="container">
    <div class="page-header"><h1>Suppliers</h1><a href="${pageContext.request.contextPath}/admin/suppliers/create" class="btn btn-primary">+ Add Supplier</a></div>
    <c:if test="${param.msg == 'saved'}"><div class="alert alert-success">Supplier saved.</div></c:if>
    <c:if test="${param.msg == 'deleted'}"><div class="alert alert-success">Supplier deleted.</div></c:if>
    <div class="table-responsive"><table>
        <thead><tr><th>Name</th><th>Contact</th><th>Phone</th><th>Email</th><th>Status</th><th>Actions</th></tr></thead>
        <tbody>
            <c:forEach var="s" items="${suppliers}">
                <tr><td><strong>${s.name}</strong></td><td>${s.contactPerson}</td><td>${s.phone}</td><td>${s.email}</td>
                    <td><span class="badge ${s.active ? 'badge-success' : 'badge-secondary'}">${s.active ? 'Active' : 'Inactive'}</span></td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin/suppliers/edit?id=${s.id}" class="btn btn-secondary btn-sm">Edit</a>
                        <form method="post" action="${pageContext.request.contextPath}/admin/suppliers/delete" style="display:inline;" onsubmit="return confirm('Delete?')">
                            <input type="hidden" name="id" value="${s.id}"><button type="submit" class="btn btn-danger btn-sm">Delete</button>
                        </form>
                    </td></tr>
            </c:forEach>
        </tbody>
    </table></div>
</div>
<%@ include file="../layout/footer.jsp" %>
</body></html>
