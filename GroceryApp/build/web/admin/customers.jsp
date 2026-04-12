<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Customer" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer List</title>
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
                <h2>Customers</h2>
                <a href="DashboardServlet" class="btn btn-secondary">Back to Dashboard</a>
            </div>

            <div class="table-responsive">
                <table class="table table-bordered table-striped">
                    <thead class="table-dark">
                        <tr>
                            <th>#</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Password</th>
                            <th>Address</th>
                            <th>Phone</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Customer> customers = (List<Customer>) request.getAttribute("customers");
                            if (customers != null && !customers.isEmpty()) {
                                for (Customer customer : customers) {
                        %>
                        <tr>
                            <td><%= customer.getCustomerId() %></td>
                            <td><%= customer.getName() != null ? customer.getName() : "-" %></td>
                            <td><%= customer.getEmail() %></td>
                            <td><%= customer.getPassword() != null ? customer.getPassword() : "-" %></td>
                            <td><%= customer.getAddress() != null ? customer.getAddress() : "-" %></td>
                            <td><%= customer.getPhone() != null ? customer.getPhone() : "-" %></td>
                            <td>
                                <a href="CustomerServlet?action=edit&id=<%= customer.getCustomerId() %>" class="btn btn-warning btn-sm">Edit</a>
                                <a href="CustomerServlet?action=delete&id=<%= customer.getCustomerId() %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this customer?')">Delete</a>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="6" class="text-center">No customers found.</td>
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
