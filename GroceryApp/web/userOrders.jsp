<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Order" %>
<%@ page import="model.Customer" %>
<%
Customer user = (Customer) session.getAttribute("user");
if (user == null) {
    response.sendRedirect("LoginServlet");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
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
</body>
</html>