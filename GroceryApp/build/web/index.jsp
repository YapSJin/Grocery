<%-- 
    Document   : index
    Created on : Mar 29, 2026, 4:43:35 PM
    Author     : sengy
--%>
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

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.Product" %>
<!DOCTYPE html>
<html>
<head>
    <title>Grocery Store</title>

    <!-- Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS overrides -->
    <link href="css/styles.css" rel="stylesheet">
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
        }
        .navbar-fixed {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1030;
        }
        .footer-fixed {
            margin-top: auto;
        }
        .page-content {
            flex: 1;
            padding-top: 20px;
            padding-bottom: 20px;
        }
    </style>
</head>
<body>

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
            <% if (user != null) { %>
                <a class="btn btn-light" href="UserOrderServlet">Orders</a>
                <a class="btn btn-danger" href="LogoutServlet">Logout</a>
            <% } else { %>
                <a class="btn btn-light" href="LoginServlet">Login</a>
            <% } %>
            <a class="btn btn-light" href="AdminLoginServlet">Admin</a>
        </div>
    </div>
</nav>

<div class="page-content">
    <!-- HERO -->
    <div class="container mt-4">
        <div class="p-4 bg-light rounded">
            <h1>Welcome to Grocery Store</h1>
            <p>Fresh groceries delivered to your door.</p>
            <a href="ProductServlet" class="btn btn-primary">Shop Now</a>
        </div>
    </div>

    <!-- FEATURED PRODUCTS -->
    <div class="container mt-5">
        <h2>Featured Products</h2>

    <div class="row">

<%
List<Product> products = (List<Product>) request.getAttribute("products");

if (products != null && !products.isEmpty()) {
    for (Product p : products) {
%>

        <div class="col-md-4 mb-4">
            <div class="card shadow-sm">
                <% if (p.getImage() != null && !p.getImage().isEmpty()) { %>
                    <img src="${pageContext.request.contextPath}/<%= p.getImage() %>" class="card-img-top" alt="<%= p.getName() %>" style="height: 200px; object-fit: cover;">
                <% } else { %>
                    <div class="bg-secondary text-white text-center py-5">No Image</div>
                <% } %>
                <div class="card-body">
                    <h5 class="card-title"><%= p.getName() %></h5>
                    <p class="card-text">
                        Price: RM <%= p.getPrice() %><br>
                        Stock: <%= p.getStock() %>
                    </p>

                    <form action="CartServlet" method="post">
                        <input type="hidden" name="id" value="<%= p.getId() %>">

                        <!-- 🔥 Quantity input -->
                        <input type="number" name="qty" value="1" min="1" class="form-control mb-2">

                        <input type="hidden" name="action" value="add">

                        <button class="btn btn-success w-100">
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

    <!-- PROMOTIONS -->
    <div class="container mt-5">
        <h3>Promotions</h3>
        <ul>
            <li>Free delivery above RM 1000</li>
            <li>Festival discounts available</li>
        </ul>
    </div>
</div>

<!-- FOOTER -->
<footer class="bg-dark text-white text-center p-3 footer-fixed">
    &copy; 2026 Grocery Store
</footer>

</body>
</html>
