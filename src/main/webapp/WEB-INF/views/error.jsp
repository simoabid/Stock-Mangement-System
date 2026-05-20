<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:if test="${empty sessionScope.userLang}"><c:set var="userLang" value="en" scope="session" /></c:if>
<fmt:setLocale value="${sessionScope.userLang}" /><fmt:setBundle basename="messages" />
<!DOCTYPE html>
<html lang="${sessionScope.userLang}" dir="${sessionScope.userLang == 'ar' ? 'rtl' : 'ltr'}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><fmt:message key="error.page_title" /> | PharmStock</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-color: #0b0f19;
            --card-bg: #161e31;
            --text-primary: #f3f4f6;
            --text-secondary: #9ca3af;
            --accent-color: #f43f5e;
            --accent-rgb: 244, 63, 94;
            --border-color: #24304f;
            --btn-bg: #1f2a45;
            --btn-hover: #29385c;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg-color);
            color: var(--text-primary);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
            overflow-x: hidden;
            position: relative;
        }

        /* Decorative background elements */
        body::before {
            content: '';
            position: absolute;
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, rgba(var(--accent-rgb), 0.15) 0%, rgba(var(--accent-rgb), 0) 70%);
            top: -100px;
            right: -100px;
            z-index: 0;
        }

        body::after {
            content: '';
            position: absolute;
            width: 450px;
            height: 450px;
            background: radial-gradient(circle, rgba(99, 102, 241, 0.1) 0%, rgba(99, 102, 241, 0) 70%);
            bottom: -150px;
            left: -150px;
            z-index: 0;
        }

        .container {
            max-width: 580px;
            width: 100%;
            background-color: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 20px;
            padding: 3rem 2rem;
            text-align: center;
            box-shadow: 0 20px 40px -15px rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(10px);
            z-index: 10;
            position: relative;
            animation: fadeIn 0.6s cubic-bezier(0.16, 1, 0.3, 1);
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .icon-container {
            width: 80px;
            height: 80px;
            background: rgba(var(--accent-rgb), 0.1);
            border: 2px dashed var(--accent-color);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 2rem;
            animation: spin 8s linear infinite;
        }

        @keyframes spin {
            100% {
                transform: rotate(360deg);
            }
        }

        .icon-container svg {
            width: 36px;
            height: 36px;
            color: var(--accent-color);
        }

        h1 {
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 1rem;
            letter-spacing: -0.5px;
            background: linear-gradient(135deg, #ffffff 30%, #a5b4fc 100%);
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        p {
            font-size: 1.1rem;
            color: var(--text-secondary);
            line-height: 1.6;
            margin-bottom: 2rem;
        }

        .error-details {
            background-color: rgba(0, 0, 0, 0.25);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 1.2rem;
            text-align: left;
            margin-bottom: 2.5rem;
            max-height: 150px;
            overflow-y: auto;
        }

        .error-title {
            font-size: 0.85rem;
            font-weight: 600;
            color: var(--accent-color);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 0.5rem;
        }

        .error-message {
            font-family: monospace;
            font-size: 0.9rem;
            color: #cbd5e1;
            word-break: break-word;
        }

        .btn-group {
            display: flex;
            gap: 1rem;
            justify-content: center;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0.75rem 1.75rem;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.2s ease;
            cursor: pointer;
        }

        .btn-primary {
            background-color: var(--accent-color);
            color: white;
            border: none;
            box-shadow: 0 4px 12px rgba(var(--accent-rgb), 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(var(--accent-rgb), 0.4);
            filter: brightness(1.1);
        }

        .btn-secondary {
            background-color: var(--btn-bg);
            color: var(--text-primary);
            border: 1px solid var(--border-color);
        }

        .btn-secondary:hover {
            background-color: var(--btn-hover);
            transform: translateY(-2px);
        }
    </style>
</head>
<body>

<div class="container">
    <div class="icon-container">
        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126zM12 15.75h.007v.008H12v-.008z" />
        </svg>
    </div>

    <h1><fmt:message key="error.heading" /></h1>
    <p><fmt:message key="error.text" /></p>

    <div class="error-details">
        <div class="error-title"><fmt:message key="error.detail_title" /></div>
        <div class="error-message">
            <c:out value="${pageContext.exception != null ? pageContext.exception.message : (requestScope['jakarta.servlet.error.message'] != null ? requestScope['jakarta.servlet.error.message'] : 'No details available')}" />
        </div>
    </div>

    <div class="btn-group">
        <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-primary"><fmt:message key="btn.go_dashboard" /></a>
        <button onclick="history.back()" class="btn btn-secondary"><fmt:message key="btn.go_back" /></button>
    </div>
</div>

</body>
</html>
