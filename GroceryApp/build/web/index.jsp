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
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="IndexServlet">Grocery Store</a>

        <div>
            <a class="btn btn-light" href="ProductServlet">Products</a>
            <a class="btn btn-light" href="CartServlet">Cart (<%= count %>)</a>
            <a class="btn btn-light" href="LoginServlet">Login</a>
            <a class="btn btn-light" href="AdminLoginServlet">Admin</a>
        </div>
    </div>
</nav>

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
</div>

<!-- PROMOTIONS -->
<div class="container mt-5">
    <h3>Promotions</h3>
    <ul>
        <li>Free delivery above RM 1000</li>
        <li>Festival discounts available</li>
    </ul>
</div>

<!-- FOOTER -->
<footer class="bg-dark text-white text-center p-3 mt-5">
    &copy; 2026 Grocery Store
</footer>

</body>
</html>
