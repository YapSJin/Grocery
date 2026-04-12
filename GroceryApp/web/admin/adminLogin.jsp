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
        <!-- Font Awesome for Icons -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <!-- Custom CSS overrides -->
        <link href="../css/style.css" rel="stylesheet">
        
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
                padding-bottom: 220px;
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
        <a class="navbar-brand" href="<%= request.getContextPath() %>/IndexServlet">
            <img src="<%= request.getContextPath() %>/Image/logo.jpg" alt="Grocery Store Logo" height="40" class="me-2">
            Grocery Store
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <div class="d-flex flex-column flex-lg-row align-items-center gap-2">
                <a class="btn btn-outline-light btn-nav" href="<%= request.getContextPath() %>/ProductServlet">Products</a>
                <a class="btn btn-outline-light btn-nav" href="<%= request.getContextPath() %>/CartServlet">Cart (<%= count %>)</a>
                <% if (user != null) { %>
                    <a class="btn btn-outline-light btn-nav" href="<%= request.getContextPath() %>/UserOrderServlet">Orders</a>
                    <a class="btn btn-danger btn-nav" href="<%= request.getContextPath() %>/LogoutServlet">Logout</a>
                <% } else { %>
                    <a class="btn btn-outline-light btn-nav" href="<%= request.getContextPath() %>/LoginServlet">Login</a>
                <% } %>
                <a class="btn btn-outline-secondary btn-nav" href="<%= request.getContextPath() %>/AdminLoginServlet">Admin</a>
            </div>
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

                    <button type="submit" class="btn btn-primary btn-lg w-100">Login</button>
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
<footer class="footer-fixed">
    <div class="container">
        <div class="row mb-3">
            <div class="col-md-4 mb-2">
                <h6><i class="fas fa-info-circle me-2"></i>About Us</h6>
                <p style="font-size: 0.9rem;">Quality groceries at your fingertips. Shop fresh, shop online.</p>
            </div>
            <div class="col-md-4 mb-2">
                <h6><i class="fas fa-phone me-2"></i>Contact</h6>
                <p style="font-size: 0.9rem;">Email: info@grocerystore.com<br>Phone: +60-1234567890</p>
            </div>
            <div class="col-md-4 mb-2">
                <h6><i class="fas fa-globe me-2"></i>Follow Us</h6>
                <p style="font-size: 0.9rem;"><a href="#" class="me-2">Facebook</a><a href="#" class="me-2">Twitter</a><a href="#">Instagram</a></p>
            </div>
        </div>
        <hr style="opacity: 0.3;">
        <p style="margin: 0.5rem 0;">&copy; 2026 Grocery Store. All rights reserved.</p>
    </div>
</footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
