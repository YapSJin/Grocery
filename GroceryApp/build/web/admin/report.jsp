<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Order" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sales Report</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Admin Dashboard Styles -->
        <link href="${pageContext.request.contextPath}/css/adminDashboard.css" rel="stylesheet">
    </head>
    <body>

        <nav class="navbar navbar-dark bg-dark">
            <div class="container-fluid d-flex align-items-center">
                <span class="navbar-brand mb-0 h1">Admin Dashboard</span>
                <img src="${pageContext.request.contextPath}/Image/logo.jpg" alt="Logo" style="height:40px; width:auto;" class="mx-auto">
                <a href="${pageContext.request.contextPath}/LogoutServlet" class="btn btn-danger">Logout</a>
            </div>
        </nav>

        <div class="container mt-5">

            <h2>Sales Report</h2>

            <!-- Filter Buttons -->
            <div class="mb-3">
                <a href="ReportServlet?type=day" class="btn btn-primary">Daily</a>
                <a href="ReportServlet?type=month" class="btn btn-warning">Monthly</a>
                <a href="ReportServlet?type=year" class="btn btn-success">Yearly</a>
            </div>

            <%
                java.util.Map report = (java.util.Map) request.getAttribute("report");
            %>

            <div class="card p-4 shadow">

                <h4>Total Orders: <%= report.get("totalOrders") %></h4>
                <h4>Total Revenue: RM <%= report.get("revenue") %></h4>

            </div>

            <div class="card p-4 shadow mt-4">
                <h4>Order History</h4>
                <div class="table-responsive mt-3">
                    <table class="table table-bordered table-striped mb-0">
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
                                <td><%= order.getStatus() %></td>
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

            <a href="DashboardServlet" class="btn btn-secondary mt-3">Back</a>

        </div>    
    </body>
</html>
