<%@ page import="java.util.*,model.Product" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product Management</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Admin Dashboard Styles -->
    <link href="${pageContext.request.contextPath}/css/adminDashboard.css" rel="stylesheet">
</head>
<body class="bg-light">

    <nav class="navbar navbar-dark bg-dark">
        <div class="container-fluid d-flex align-items-center">
            <span class="navbar-brand mb-0 h1">Admin Dashboard</span>
            <img src="${pageContext.request.contextPath}/Image/logo.jpg" alt="Logo" style="height:40px; width:auto;" class="mx-auto">
            <a href="${pageContext.request.contextPath}/LogoutServlet" class="btn btn-danger">Logout</a>
        </div>
    </nav>

<div class="container mt-5">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <a href="${pageContext.request.contextPath}/DashboardServlet" class="btn btn-secondary">
            &larr; Back to Dashboard
        </a>
        <h2 class="mb-0">Product Management</h2>
        <a href="${pageContext.request.contextPath}/admin/addProduct.jsp" class="btn btn-success">
            + Add Product
        </a>
    </div>

    <% if (request.getParameter("success") != null) { %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            Product added successfully!
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>

    <% if (request.getParameter("deleted") != null) { %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            Product deleted successfully!
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>

    <% if (request.getParameter("updated") != null) { %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            Product updated successfully!
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>

    <% if (request.getParameter("notfound") != null) { %>
        <div class="alert alert-warning alert-dismissible fade show" role="alert">
            Product not found.
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>

    <table class="table table-bordered table-hover">

        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Image</th>
                <th>Name</th>
                <th>Price (RM)</th>
                <th>Stock</th>
                <th>Description</th>
                <th>Action</th>
            </tr>
        </thead>

        <tbody>

<%
List<Product> products = (List<Product>) request.getAttribute("products");

if (products != null && !products.isEmpty()) {
    for (Product p : products) {
%>

        <tr>
            <td><%= p.getId() %></td>
            <td>
                <% if (p.getImage() != null && !p.getImage().isEmpty()) { %>
                    <img src="${pageContext.request.contextPath}/<%= p.getImage() %>" alt="<%= p.getName() %>" style="width: 50px; height: 50px; object-fit: cover;">
                <% } else { %>
                    <span class="text-muted">No image</span>
                <% } %>
            </td>
            <td><%= p.getName() %></td>
            <td><%= p.getPrice() %></td>
            <td><%= p.getStock() %></td>
            <td><%= p.getDescription() %></td>
            <td>

                <!-- EDIT -->
                <a href="${pageContext.request.contextPath}/ProductServlet?action=edit&id=<%= p.getId() %>"
                   class="btn btn-primary btn-sm me-1">
                    Edit
                </a>

                <!-- DELETE -->
                <a href="${pageContext.request.contextPath}/ProductServlet?action=delete&id=<%= p.getId() %>"
                   class="btn btn-danger btn-sm"
                   onclick="return confirm('Delete this product?');">
                    Delete
                </a>

            </td>
        </tr>

<%
    }
} else {
%>
        <tr>
            <td colspan="6" class="text-center">No products found</td>
        </tr>
<%
}
%>

        </tbody>
    </table>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>