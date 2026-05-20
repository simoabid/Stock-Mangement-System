<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:if test="${empty sessionScope.userLang}"><c:set var="userLang" value="en" scope="session" /></c:if>
<fmt:setLocale value="${sessionScope.userLang}" />
<fmt:setBundle basename="messages" />
<!DOCTYPE html>
<html lang="${sessionScope.userLang}" dir="${sessionScope.userLang == 'ar' ? 'rtl' : 'ltr'}">
<head>
    <title><fmt:message key="title.login" /></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <%@ include file="layout/header.jsp" %>
    <div class="container auth-container">
        <div class="card">
            <h2 style="text-align: center; margin-bottom: var(--spacing-lg);"><fmt:message key="login.welcome" /></h2>
            <c:if test="${not empty error}"><div class="alert alert-error">${error}</div></c:if>
            <c:if test="${param.msg == 'Registered'}"><div class="alert alert-success"><fmt:message key="msg.registered_success" /></div></c:if>
            <c:if test="${param.msg == 'LoggedOut'}"><div class="alert alert-success"><fmt:message key="msg.logged_out" /></div></c:if>
            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="form-group">
                    <label class="form-label"><fmt:message key="label.username" /></label>
                    <input type="text" name="username" class="form-control" required placeholder="<fmt:message key='ph.username' />">
                </div>
                <div class="form-group">
                    <label class="form-label"><fmt:message key="label.password" /></label>
                    <input type="password" name="password" class="form-control" required placeholder="<fmt:message key='ph.password' />">
                </div>
                <div class="form-group" style="margin-top: var(--spacing-lg);">
                    <button type="submit" class="btn btn-primary btn-block"><fmt:message key="btn.signin" /></button>
                </div>
            </form>
            <p style="text-align: center; margin-top: var(--spacing-md); font-size: 0.9rem;">
                <fmt:message key="login.noaccount" /> <a href="${pageContext.request.contextPath}/register" style="color: var(--primary); font-weight: 600;"><fmt:message key="login.register_link" /></a>
            </p>
        </div>
    </div>
    <%@ include file="layout/footer.jsp" %>
</body>
</html>