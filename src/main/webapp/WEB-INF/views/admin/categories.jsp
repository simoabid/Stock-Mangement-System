<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${sessionScope.userLang}" /><fmt:setBundle basename="messages" />
<!DOCTYPE html><html lang="${sessionScope.userLang}">
<head><title>Categories - PharmStock</title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"></head>
<body>
<%@ include file="../layout/header.jsp" %>
<div class="container" style="max-width: 800px;">
    <div class="page-header"><h1>Categories</h1><a href="${pageContext.request.contextPath}/admin/categories/create" class="btn btn-primary">+ Add Category</a></div>
    <c:if test="${param.msg == 'saved'}"><div class="alert alert-success">Category saved.</div></c:if>
    <c:if test="${param.msg == 'deleted'}"><div class="alert alert-success">Category deleted.</div></c:if>
    <div class="table-responsive"><table>
        <thead><tr><th>Name</th><th>Description</th><th>Actions</th></tr></thead>
        <tbody>
            <c:forEach var="cat" items="${categories}">
                <tr><td><strong>${cat.name}</strong></td><td>${cat.description}</td><td>
                    <a href="${pageContext.request.contextPath}/admin/categories/edit?id=${cat.id}" class="btn btn-secondary btn-sm">Edit</a>
                    <form method="post" action="${pageContext.request.contextPath}/admin/categories/delete" style="display:inline;" onsubmit="return confirm('Delete?')">
                        <input type="hidden" name="id" value="${cat.id}"><button type="submit" class="btn btn-danger btn-sm">Delete</button>
                    </form></td></tr>
            </c:forEach>
        </tbody>
    </table></div>
</div>
<%@ include file="../layout/footer.jsp" %>
</body></html>
