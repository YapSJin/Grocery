<%-- 
    Document   : products
    Created on : Mar 29, 2026, 8:36:13 PM
    Author     : sengy
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>

<!DOCTYPE html>
<html>
<head>
    <title>Products</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
    
    <div class="container mt-5">

        <div class="d-flex justify-content-between align-items-center mb-4">
            <a href="IndexServlet" class="btn btn-secondary">
                Back
            </a>
            <h2 class="mb-0">All Products</h2>
            <div></div>
        </div>
        
        <form action="ProductServlet" method="get" class="d-flex mb-4">
            <input type="text" name="keyword" class="form-control me-2" placeholder="Search...">
            <button class="btn btn-outline-primary">Search</button>
        </form>
        
        <div class="row">

            <%
                List<Product> products = (List<Product>) request.getAttribute("products");

                if (products != null && !products.isEmpty()) {
                for (Product p : products) {
            %>

        <div class="col-md-4 mb-4">
            <div class="card shadow h-100">

                <div class="card-body">
                    <h5 class="card-title"><%= p.getName() %></h5>

                    <p class="card-text">
                        Price: RM <%= p.getPrice() %><br>
                        Stock: <%= p.getStock() %><br>
                        <%= p.getDescription() %>
                    </p>

                    <!-- Add to Cart -->
                    <form action="CartServlet" method="post">
                        <input type="hidden" name="id" value="<%= p.getId() %>">

                        <!-- 🔥 Quantity input -->
                        <input type="number" name="qty" value="1" min="1" class="form-control mb-2">

                        <input type="hidden" name="action" value="add">

                        <button class="btn btn-success w-100">
                            Add to Cart
                        </button>
                    </form>
                </div>

            </div>
        </div>

        <%
                }
            } else {
        %>

        <p>No products available</p>

        <%
            }
        %>

    </div>

</div>

</body>
</html>