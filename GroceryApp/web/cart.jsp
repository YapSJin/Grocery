<%-- 
    Document   : cart
    Created on : Mar 29, 2026, 4:44:05 PM
    Author     : sengy
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.Map" %>
<%@ page import="model.Product" %>
<%
    model.Customer user = (model.Customer) session.getAttribute("user");
    model.Cart cart = (model.Cart) session.getAttribute("cart");
    int count = (cart == null) ? 0 : cart.getItems().size();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
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

    <h2 class="mb-4">Your Cart</h2>
    <a href="IndexServlet" class="btn btn-secondary mb-3">Back</a>

    <%
        Map<Product, Integer> cartItems =
                (Map<Product, Integer>) request.getAttribute("cartItems");

        double total = 0;

        if (cartItems != null && !cartItems.isEmpty()) {
    %>

    <table class="table table-bordered mt-3">
        <thead>
            <tr>
                <th>Product Image</th>
                <th>Name</th>
                <th>Price (RM)</th>
                <th>Quantity</th>
                <th>Subtotal</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>

        <%
            for (Map.Entry<Product, Integer> entry : cartItems.entrySet()) {
                Product p = entry.getKey();
                int qty = entry.getValue();
                double subtotal = p.getPrice() * qty;
                total += subtotal;
        %>

        <tr>
            <td>
                <% if (p.getImage() != null && !p.getImage().isEmpty()) { %>
                    <img src="${pageContext.request.contextPath}/<%= p.getImage() %>" alt="<%= p.getName() %>" style="width: 50px; height: 50px; object-fit: cover;">
                <% } else { %>
                    <span class="text-muted">No image</span>
                <% } %>
            </td>
            <td><%= p.getName() %></td>
            <td><%= p.getPrice() %></td>
            <td><%= qty %></td>
            <td><%= subtotal %></td>
            <td class="align-middle">

            <div class="d-flex align-items-center">
                <!-- UPDATE FORM -->
                <form action="CartServlet" method="post" class="d-flex me-2 mb-0">

                    <input type="hidden" name="id" value="<%= p.getId() %>">

                    <input type="number" name="qty" value="<%= qty %>" min="1" class="form-control me-2" style="width:80px">

                    <input type="hidden" name="action" value="update">

                    <button class="btn btn-warning btn-sm">Update</button>
                </form>

                <!-- REMOVE FORM -->
                <form action="CartServlet" method="post" class="mb-0">

                    <input type="hidden" name="id" value="<%= p.getId() %>">
                    <input type="hidden" name="action" value="remove">

                    <button class="btn btn-danger btn-sm">Remove</button>
                </form>
            </div>

            </td>
        </tr>

        <%
            }
        %>

        </tbody>
    </table>

    <h4>Total: RM <%= total %></h4>

    <a href="CheckoutServlet" class="btn btn-add-cart mt-3">
        Checkout
    </a>

    <%
        } else {
    %>

    <p>Your cart is empty.</p>

    <%
        }
    %>

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