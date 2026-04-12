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
