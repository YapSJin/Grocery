<%-- 
    Document   : adminLogin
    Created on : Mar 29, 2026, 4:44:41 PM
    Author     : sengy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Login</title>
        
        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Custom CSS overrides -->
        <link href="../css/styles.css" rel="stylesheet">
        
        <style>
            html, body {
                height: 100%;
                margin: 0;
            }
            body {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
                background-image: url('<%= request.getContextPath() %>/Image/loginAdmin.jpg');
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;
                background-color: #f8f9fa;
            }
            main {
                flex: 1;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 90px 15px 90px;
            }
            .navbar-fixed {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                z-index: 1030;
            }
            .footer-fixed {
                position: fixed;
                bottom: 0;
                left: 0;
                right: 0;
                z-index: 1030;
            }
            .content-card {
                width: 100%;
                max-width: 420px;
            }
        </style>
    </head>
    <body>
<%
model.Customer user = (model.Customer) session.getAttribute("user");
if (user != null) {
%>
    <p>Welcome, <%= user.getEmail() %></p>
<%
}
%>

<%
model.Cart cart = (model.Cart) session.getAttribute("cart");
int count = (cart == null) ? 0 : cart.getItems().size();
%>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark navbar-fixed">
    <div class="container">
        <a class="navbar-brand" href="IndexServlet">
            <img src="<%= request.getContextPath() %>/Image/logo.jpg" alt="Grocery Store Logo" height="40" class="me-2">
            Grocery Store
        </a>

        <div>
            <a class="btn btn-light" href="ProductServlet">Products</a>
            <a class="btn btn-light" href="CartServlet">Cart (<%= count %>)</a>
            <a class="btn btn-light" href="LoginServlet">Login</a>
            <a class="btn btn-light" href="AdminLoginServlet">Admin</a>
        </div>
    </div>
</nav>

<main>
    <div class="content-card">
        <div class="card shadow">
            <div class="card-header text-center bg-dark text-white">
                <h4>Admin Login</h4>
            </div>
            <div class="card-body">
                <form action="AdminLoginServlet" method="post">
                    <div class="mb-3">
                        <label>Username</label>
                        <input type="text" name="username" class="form-control" required>
                    </div>

                    <div class="mb-3">
                        <label>Password</label>
                        <input type="password" name="password" class="form-control" required>
                    </div>

                    <button class="btn btn-primary w-100">Login</button>
                </form>

                <%
                    String error = request.getParameter("error");
                    if (error != null) {
                %>
                    <div class="alert alert-danger mt-3">
                        Invalid username or password
                    </div>
                <%
                    }
                %>
            </div>
            <div class="card-footer text-center">
                <a href="IndexServlet">Back to Home</a>
            </div>
        </div>
    </div>
</main>

<!-- FOOTER -->
<footer class="bg-dark text-white text-center p-3 footer-fixed">
    &copy; 2026 Grocery Store
</footer>

    </body>
</html>
