<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Order" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order List</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>Orders</h2>
                <a href="DashboardServlet" class="btn btn-secondary">Back to Dashboard</a>
            </div>

            <div class="table-responsive">
                <table class="table table-bordered table-striped">
                    <thead class="table-dark">
                        <tr>
                            <th>Order ID</th>
                            <th>Customer ID</th>
                            <th>Customer Email</th>
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
                            <td><%= order.getCustomerId() %></td>
                            <td><%= order.getCustomerEmail() != null ? order.getCustomerEmail() : "-" %></td>
                            <td><%= order.getTotal() %></td>
                            <td>
                                <form action="OrderServlet" method="post" class="mb-0">
                                    <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                                    <select name="status" class="form-select form-select-sm" onchange="this.form.submit()">
                                        <option value="Packaging" <%= "Packaging".equalsIgnoreCase(order.getStatus()) ? "selected" : "" %>>Packaging</option>
                                        <option value="Shipping" <%= "Shipping".equalsIgnoreCase(order.getStatus()) ? "selected" : "" %>>Shipping</option>
                                        <option value="Completed" <%= "Completed".equalsIgnoreCase(order.getStatus()) ? "selected" : "" %>>Completed</option>
                                    </select>
                                </form>
                            </td>
                            <td><%= order.getOrderDate() != null ? order.getOrderDate() : "-" %></td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="6" class="text-center">No orders found.</td>
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
