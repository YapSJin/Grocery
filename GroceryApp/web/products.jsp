<%-- 
    Document   : products
    Created on : Mar 29, 2026, 8:36:13 PM
    Author     : sengy
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
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

<!DOCTYPE html>
<html>
<head>
    <title>Products</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Custom CSS overrides -->
    <link href="css/style.css" rel="stylesheet">
    <style>
        html, body {
            height: 100%;
            margin: 0;
        }
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            padding-top: 70px;
            padding-bottom: 180px;
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
        .page-content {
            flex: 1;
            padding-top: 20px;
            padding-bottom: 180px;
        }
    </style>
</head>

<body>

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
                <a class="btn btn-outline-light btn-nav" href="<%= request.getContextPath() %>/ProductServlet"><i class="fas fa-box-open"></i>Products</a>
                <a class="btn btn-outline-light btn-nav" href="<%= request.getContextPath() %>/CartServlet"><i class="fas fa-shopping-cart"></i>Cart (<%= count %>)</a>
                <% if (user != null) { %>
                    <a class="btn btn-outline-light btn-nav" href="<%= request.getContextPath() %>/UserOrderServlet"><i class="fas fa-history"></i>Orders</a>
                    <a class="btn btn-danger btn-nav" href="<%= request.getContextPath() %>/LogoutServlet"><i class="fas fa-sign-out-alt"></i>Logout</a>
                <% } else { %>
                    <a class="btn btn-outline-light btn-nav" href="<%= request.getContextPath() %>/LoginServlet"><i class="fas fa-sign-in-alt"></i>Login</a>
                <% } %>
                <a class="btn btn-outline-secondary btn-nav disabled" href="<%= request.getContextPath() %>/AdminLoginServlet" tabindex="-1" aria-disabled="true"><i class="fas fa-lock"></i>Admin</a>
            </div>
        </div>
    </div>
</nav>

<div class="page-content">
    <div class="container mt-5">

        <h2 class="mb-4">All Products</h2>
        
        <form action="ProductServlet" method="get" class="d-flex">
            <input type="text" name="keyword" class="form-control me-2" placeholder="Search...">
            <button class="btn btn-primary">Search</button>
        </form>
        
        <div class="row">

            <%
                List<Product> products = (List<Product>) request.getAttribute("products");

                if (products != null && !products.isEmpty()) {
                for (Product p : products) {
            %>

        <div class="col-md-4 mb-4">
            <div class="card shadow h-100">
                <% if (p.getImage() != null && !p.getImage().isEmpty()) { %>
                    <img src="${pageContext.request.contextPath}/<%= p.getImage() %>" class="card-img-top" alt="<%= p.getName() %>" style="height: 200px; object-fit: cover;">
                <% } else { %>
                    <div class="bg-secondary text-white text-center py-5">No Image</div>
                <% } %>
                <div class="card-body">
                    <h5 class="card-title"><%= p.getName() %></h5>

                    <p class="card-text">
                        Price: RM <%= p.getPrice() %><br>
                        Stock: <%= p.getStock() %><br>
                        <%= p.getDescription() %>
                    </p>

                    <!-- Add to Cart -->
                    <form action="CartServlet" method="post">
                        <input type="hidden" name="id" value="<%= p.getId() %>">

                        <!-- 🔥 Quantity input -->
                        <input type="number" name="qty" value="1" min="1" class="form-control mb-2">

                        <input type="hidden" name="action" value="add">

                        <button type="submit" class="btn btn-add-cart w-100">
                            Add to Cart
                        </button>
                    </form>
                </div>

            </div>
        </div>

        <%
                }
            } else {
        %>

        <p>No products available</p>

        <%
            }
        %>

    </div>

</div>
</div>

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