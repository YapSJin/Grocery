<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Product" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Edit Product</title>

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
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow">
                <div class="card-header bg-dark text-white">
                    <h4 class="mb-0">Edit Product</h4>
                </div>

                <div class="card-body">
                    <%
                        Product product = (Product) request.getAttribute("product");
                    %>

                    <form action="${pageContext.request.contextPath}/ProductServlet?action=update" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="id" value="<%= product.getId() %>">
                        <input type="hidden" name="existingImage" value="<%= product.getImage() != null ? product.getImage() : "" %>">

                        <div class="mb-3">
                            <label>Product Name</label>
                            <input type="text" name="name" class="form-control" value="<%= product.getName() %>" required>
                        </div>

                        <div class="mb-3">
                            <label>Price (RM)</label>
                            <input type="number" step="0.01" name="price" class="form-control" value="<%= product.getPrice() %>" required>
                        </div>

                        <div class="mb-3">
                            <label>Stock</label>
                            <input type="number" name="stock" class="form-control" value="<%= product.getStock() %>" required>
                        </div>

                        <div class="mb-3">
                            <label>Description</label>
                            <textarea name="description" class="form-control" rows="3"><%= product.getDescription() != null ? product.getDescription() : "" %></textarea>
                        </div>

                        <div class="mb-3">
                            <label>Current Image</label><br>
                            <% if (product.getImage() != null && !product.getImage().isEmpty()) { %>
                                <img src="${pageContext.request.contextPath}/<%= product.getImage() %>" alt="<%= product.getName() %>" style="width: 80px; height: 80px; object-fit: cover;" class="mb-2">
                            <% } else { %>
                                <div class="text-muted mb-2">No image</div>
                            <% } %>
                        </div>

                        <div class="mb-3">
                            <label>Replace Image</label>
                            <input type="file" name="image" class="form-control" accept="image/*">
                            <small class="text-muted">Leave blank to keep the current image.</small>
                        </div>

                        <button class="btn btn-primary w-100">Update Product</button>
                    </form>
                </div>

                <div class="card-footer text-center">
                    <a href="${pageContext.request.contextPath}/ProductServlet?view=admin">Back to Product List</a>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>