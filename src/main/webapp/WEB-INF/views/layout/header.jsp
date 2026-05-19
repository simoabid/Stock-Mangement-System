<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:if test="${not empty param.lang}">
    <c:set var="userLang" value="${param.lang}" scope="session" />
</c:if>
<c:if test="${empty sessionScope.userLang}">
    <c:set var="userLang" value="en" scope="session" />
</c:if>
<fmt:setLocale value="${sessionScope.userLang}" />
<fmt:setBundle basename="messages" />

<div class="navbar">
    <div class="container navbar-content">
        <a href="${pageContext.request.contextPath}/dashboard" class="brand">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M19 14c1.49-1.46 3-3.21 3-5.5A5.5 5.5 0 0 0 16.5 3c-1.76 0-3 .5-4.5 2-1.5-1.5-2.74-2-4.5-2A5.5 5.5 0 0 0 2 8.5c0 2.3 1.5 4.05 3 5.5l7 7Z"/>
            </svg>
            <fmt:message key="app.name" />
        </a>

        <div class="nav-links">
            <c:if test="${sessionScope.user != null}">
                <a href="${pageContext.request.contextPath}/dashboard" class="nav-link"><fmt:message key="nav.dashboard" /></a>
                <a href="${pageContext.request.contextPath}/products" class="nav-link"><fmt:message key="nav.products" /></a>

                <c:if test="${sessionScope.user.role == 'ADMIN' || sessionScope.user.role == 'PHARMACIST'}">
                    <a href="${pageContext.request.contextPath}/admin/stock-entries" class="nav-link"><fmt:message key="nav.stock_entries" /></a>
                    <a href="${pageContext.request.contextPath}/admin/stock-exits" class="nav-link"><fmt:message key="nav.stock_exits" /></a>
                    <a href="${pageContext.request.contextPath}/admin/suppliers" class="nav-link"><fmt:message key="nav.suppliers" /></a>
                </c:if>

                <c:if test="${sessionScope.user.role == 'ADMIN'}">
                    <a href="${pageContext.request.contextPath}/admin/categories" class="nav-link"><fmt:message key="nav.categories" /></a>
                    <a href="${pageContext.request.contextPath}/admin/users" class="nav-link"><fmt:message key="nav.users" /></a>
                </c:if>

                <div style="display: flex; align-items: center; gap: 0.75rem;">
                    <span class="nav-link" style="color: var(--text-main); font-weight: 600;">${sessionScope.user.fullname}</span>
                    <span class="badge badge-info">${sessionScope.user.role}</span>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-secondary btn-sm"><fmt:message key="nav.logout" /></a>
                </div>
            </c:if>

            <c:if test="${sessionScope.user == null}">
                <a href="${pageContext.request.contextPath}/login" class="nav-link"><fmt:message key="nav.login" /></a>
                <a href="${pageContext.request.contextPath}/register" class="btn btn-primary btn-sm"><fmt:message key="nav.getstarted" /></a>
            </c:if>

            <div style="display: flex; gap: 0.4rem; align-items: center; margin-left: 0.5rem;">
                <a href="?lang=en" class="${sessionScope.userLang == 'en' ? 'font-bold' : ''}" style="text-decoration: none; color: var(--text-muted); font-size: 0.8rem;">EN</a>
                <span style="color: var(--border);">|</span>
                <a href="?lang=fr" class="${sessionScope.userLang == 'fr' ? 'font-bold' : ''}" style="text-decoration: none; color: var(--text-muted); font-size: 0.8rem;">FR</a>
                <span style="color: var(--border);">|</span>
                <a href="?lang=ar" class="${sessionScope.userLang == 'ar' ? 'font-bold' : ''}" style="text-decoration: none; color: var(--text-muted); font-size: 0.8rem;">AR</a>
                <button id="theme-toggle" class="btn btn-secondary btn-sm" style="margin-left: 0.3rem; padding: 0.3rem;">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path>
                    </svg>
                </button>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
<div class="main-content">