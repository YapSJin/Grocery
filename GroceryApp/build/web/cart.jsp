<%-- 
    Document   : cart
    Created on : Mar 29, 2026, 4:44:05 PM
    Author     : sengy
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.Map" %>
<%@ page import="model.Product" %>

<!DOCTYPE html>
<html>
<head>
    <title>Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<div class="container mt-5">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <a href="IndexServlet" class="btn btn-secondary">Back</a>
        <h2 class="mb-0">Your Cart</h2>
        <div>
            <%
                model.Customer currentUser = (model.Customer) session.getAttribute("user");
                if (currentUser != null) {
            %>
                <a href="UserOrderServlet" class="btn btn-outline-primary me-2">My Orders</a>
            <% } %>
        </div>
    </div>

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

    <a href="CheckoutServlet" class="btn btn-primary mt-3">
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

</body>
</html>