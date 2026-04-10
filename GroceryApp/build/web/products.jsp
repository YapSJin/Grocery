<%-- 
    Document   : products
    Created on : Mar 29, 2026, 8:36:13 PM
    Author     : sengy
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%
model.Customer user = (model.Customer) session.getAttribute("user");
if (user != null) {
%>
    <p>Welcome, <%= user.getEmail() %></p>
<%
}
%>

<%
model.Cart cart = (model.Cart) session.getAttribute("cart");
int count = (cart == null) ? 0 : cart.getItems().size();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Products</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS overrides -->
    <link href="css/styles.css" rel="stylesheet">
    <style>
        html, body {
            height: 100%;
            margin: 0;
        }
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            padding-top: 70px;
            padding-bottom: 70px;
        }
        .navbar-fixed {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1030;
        }
        .footer-fixed {
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            z-index: 1030;
        }
        .page-content {
            flex: 1;
            padding-top: 20px;
        }
    </style>
</head>

<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark navbar-fixed">
    <div class="container">
        <a class="navbar-brand" href="IndexServlet">
            <img src="<%= request.getContextPath() %>/Image/logo.jpg" alt="Grocery Store Logo" height="40" class="me-2">
            Grocery Store
        </a>

        <div>
            <a class="btn btn-light" href="ProductServlet">Products</a>
            <a class="btn btn-light" href="CartServlet">Cart (<%= count %>)</a>
            <a class="btn btn-light" href="LoginServlet">Login</a>
            <a class="btn btn-light" href="AdminLoginServlet">Admin</a>
        </div>
    </div>
</nav>

<div class="page-content">
    <div class="container mt-5">

        <h2 class="mb-4">All Products</h2>
        
        <form action="ProductServlet" method="get" class="d-flex">
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
</div>

<!-- FOOTER -->
<footer class="bg-dark text-white text-center p-3 footer-fixed">
    &copy; 2026 Grocery Store
</footer>

</body>
</html>