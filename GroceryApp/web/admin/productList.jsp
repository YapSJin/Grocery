<%-- 
    Document   : productList
    Created on : Mar 29, 2026, 4:44:57 PM
    Author     : sengy
--%>

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

    <h2 class="mb-4">Product Management</h2>

    <a href="addProduct.jsp" class="btn btn-success mb-3">+ Add Product</a>

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
                <a href="../ProductServlet?action=delete&id=<%= p.getId() %>"
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