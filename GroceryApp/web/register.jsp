<%-- 
    Document   : register
    Created on : Mar 29, 2026, 4:43:48 PM
    Author     : sengy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Customer, model.Cart" %>
<!DOCTYPE html>
<html>
    <head>
    <title>Grocery Store</title>

    <!-- Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
            background-image: url('<%= request.getContextPath() %>/Image/register.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-color: #f8f9fa;
            padding-bottom: 160px;
        }
        main {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 120px 15px 80px;
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
            max-width: 520px;
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
                <h4>Register</h4>
            </div>
            <div class="card-body">
                <form action="RegisterServlet" method="post">
                    <% if(request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger">
                            <%= request.getAttribute("error") %>
                        </div>
                    <% } %>

                    <div class="mb-3">
                        <label>Email</label>
                        <input type="email" name="email" class="form-control" required>
                    </div>

                    <div class="mb-3">
                        <label>Password</label>
                        <input type="password" name="password" class="form-control" required minlength="6">
                    </div>
                    
                    <div class="mb-3">
                        <label>Confirm Password</label>
                        <input type="password" name="confirmPassword" class="form-control" required minlength="6">
                    </div>
                    
                    <div class="mb-3">
                        <label>Name</label>
                        <input type="text" name="name" required class="form-control">
                    </div>
                    
                    <div class="mb-3">
                        <label>Address</label>
                        <input type="text" name="address" required class="form-control">
                    </div>

                    <div class="mb-3">
                        <label>Phone</label>
                        <input type="text" name="phone" required class="form-control">
                    </div>
                    
                    <button class="btn btn-success w-100">Register</button>

                    <p class="mt-3 text-center">
                        Already have account? <a href="LoginServlet">Login</a>
                    </p>
                </form>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
