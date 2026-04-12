<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Order" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order List</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Admin Dashboard Styles -->
        <link href="${pageContext.request.contextPath}/css/adminDashboard.css" rel="stylesheet">
    </head>
    <body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/admin/dashboard.jsp">
                <img src="${pageContext.request.contextPath}/Image/logo.jpg" alt="Logo" class="me-2">
                <span class="mb-0 h1">Admin Dashboard</span>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNavbarNav" aria-controls="adminNavbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-end" id="adminNavbarNav">
                <a href="${pageContext.request.contextPath}/LogoutServlet" class="btn btn-outline-light btn-nav">Logout</a>
            </div>
            </div>
        </nav>

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
                            <th>Actions</th>
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
                            <td><%= order.getStatus() %></td>
                            <td><%= order.getOrderDate() != null ? order.getOrderDate() : "-" %></td>
                            <td>
                                <form action="OrderServlet" method="get" style="display:inline;">
                                    <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                                    <input type="hidden" name="action" value="edit">
                                    <button type="submit" class="btn btn-primary btn-sm">Edit</button>
                                </form>
                                <form action="OrderServlet" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this order?');">
                                    <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                                    <input type="hidden" name="action" value="delete">
                                    <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                </form>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="7" class="text-center">No orders found.</td>
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
