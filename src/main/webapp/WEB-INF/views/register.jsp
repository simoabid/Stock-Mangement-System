<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:if test="${empty sessionScope.userLang}"><c:set var="userLang" value="en" scope="session" /></c:if>
<fmt:setLocale value="${sessionScope.userLang}" />
<fmt:setBundle basename="messages" />
<!DOCTYPE html>
<html lang="${sessionScope.userLang}" dir="${sessionScope.userLang == 'ar' ? 'rtl' : 'ltr'}">
<head>
    <title><fmt:message key="title.register" /></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <%@ include file="layout/header.jsp" %>
    <div class="container auth-container">
        <div class="card">
            <h2 style="text-align: center; margin-bottom: var(--spacing-lg);"><fmt:message key="register.header" /></h2>
            <c:if test="${not empty error}"><div class="alert alert-error">${error}</div></c:if>
            <form action="${pageContext.request.contextPath}/register" method="post">
                <div class="form-group">
                    <label class="form-label"><fmt:message key="label.username" /></label>
                    <input type="text" name="username" class="form-control" required placeholder="<fmt:message key='ph.username_new' />">
                </div>
                <div class="form-group">
                    <label class="form-label"><fmt:message key="label.fullname" /></label>
                    <input type="text" name="fullname" class="form-control" required placeholder="<fmt:message key='ph.fullname' />">
                </div>
                <div class="form-group">
                    <label class="form-label"><fmt:message key="label.email" /></label>
                    <input type="email" name="email" class="form-control" required placeholder="<fmt:message key='ph.email' />">
                </div>
                <div class="form-group">
                    <label class="form-label"><fmt:message key="label.password" /></label>
                    <input type="password" name="password" class="form-control" required placeholder="<fmt:message key='ph.password_new' />">
                </div>
                <div class="form-group" style="margin-top: var(--spacing-lg);">
                    <button type="submit" class="btn btn-primary btn-block"><fmt:message key="btn.register" /></button>
                </div>
            </form>
            <p style="text-align: center; margin-top: var(--spacing-md); font-size: 0.9rem;">
                <fmt:message key="register.hasaccount" /> <a href="${pageContext.request.contextPath}/login" style="color: var(--primary); font-weight: 600;"><fmt:message key="register.login_link" /></a>
            </p>
        </div>
    </div>
    <%@ include file="layout/footer.jsp" %>
</body>
</html>