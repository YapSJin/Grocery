<%@ page import="java.util.*,model.Product" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product Management</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="btn btn-secondary">
            &larr; Back to Dashboard
        </a>
        <h2 class="mb-0">Product Management</h2>
        <a href="${pageContext.request.contextPath}/admin/addProduct.jsp" class="btn btn-success">
            + Add Product
        </a>
    </div>

    <table class="table table-bordered table-hover">

        <thead class="table-dark">
            <tr>
                <th>ID</th>
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
            <td><%= p.getName() %></td>
            <td><%= p.getPrice() %></td>
            <td><%= p.getStock() %></td>
            <td><%= p.getDescription() %></td>
            <td>

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

</body>
</html>