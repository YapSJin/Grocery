<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Order" %>
<%@ page import="model.Customer" %>
<%@ page import="model.Cart" %>
<%
Customer user = (Customer) session.getAttribute("user");
if (user == null) {
    response.sendRedirect("LoginServlet");
    return;
}

Cart cart = (Cart) session.getAttribute("cart");
int count = (cart == null) ? 0 : cart.getItems().size();
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <style>
        body {
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
                    <a class="btn btn-outline-light btn-nav" href="<%= request.getContextPath() %>/ProductServlet">Products</a>
                    <a class="btn btn-outline-light btn-nav" href="<%= request.getContextPath() %>/CartServlet">Cart (<%= count %>)</a>
                    <a class="btn btn-outline-light btn-nav" href="<%= request.getContextPath() %>/UserOrderServlet">Orders</a>
                    <a class="btn btn-danger btn-nav" href="<%= request.getContextPath() %>/LogoutServlet">Logout</a>
                    <a class="btn btn-outline-secondary btn-nav" href="<%= request.getContextPath() %>/AdminLoginServlet">Admin</a>
                </div>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>My Orders</h2>
            <a href="IndexServlet" class="btn btn-secondary">Back to Home</a>
        </div>

        <div class="table-responsive">
            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>Order ID</th>
                        <th>Total (RM)</th>
                        <th>Status</th>
                        <th>Order Date</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Order> orders = (List<Order>) request.getAttribute("orders");
                        if (orders != null && !orders.isEmpty()) {
                            for (Order order : orders) {
                    %>
                    <tr>
                        <td><%= order.getOrderId() %></td>
                        <td><%= order.getTotal() %></td>
                        <td><%= order.getStatus() != null ? order.getStatus() : "-" %></td>
                        <td><%= order.getOrderDate() != null ? order.getOrderDate() : "-" %></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="4" class="text-center">No orders found.</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

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