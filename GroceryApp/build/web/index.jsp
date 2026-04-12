<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.Product" %>
<%
    model.Customer user = (model.Customer) session.getAttribute("user");
    model.Cart cart = (model.Cart) session.getAttribute("cart");
    int cartCount = (cart == null) ? 0 : cart.getItems().size();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Grocery Store - Fresh Groceries Online</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="css/style.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        html, body {
            height: 100%;
        }
        
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
        }
        
        .navbar {
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            padding: 1rem 0;
        }
        
        .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
            letter-spacing: 0.5px;
        }
        
        .page-content {
            flex: 1;
            padding-top: 60px;
            padding-bottom: 40px;
        }
        
        /* Hero Section */
        .hero {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 60px 0;
            margin-bottom: 50px;
            border-radius: 0;
            text-align: center;
        }
        
        .hero h1 {
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }
        
        .hero p {
            font-size: 1.3rem;
            margin-bottom: 2rem;
            opacity: 0.95;
        }
        
        .hero .btn {
            padding: 12px 40px;
            font-size: 1.1rem;
            font-weight: 600;
        }
        
        /* Section Titles */
        .section-title {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 2rem;
            color: #333;
            position: relative;
            padding-bottom: 1rem;
        }
        
        .section-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 60px;
            height: 4px;
            background: #667eea;
            border-radius: 2px;
        }
        
        /* Product Cards */
        .product-card {
            transition: all 0.3s ease;
            border: none;
            border-radius: 12px;
            overflow: hidden;
        }
        
        .product-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 24px rgba(0,0,0,0.15);
        }
        
        .product-card img {
            height: 220px;
            object-fit: cover;
            background-color: #e9ecef;
        }
        
        .product-card .card-body {
            padding: 1.5rem;
        }
        
        .product-card .card-title {
            font-weight: 600;
            color: #333;
            margin-bottom: 0.5rem;
        }
        
        .price-badge {
            font-size: 1.3rem;
            font-weight: 700;
            color: #667eea;
        }
        
        .stock-info {
            font-size: 0.9rem;
            color: #666;
            margin-bottom: 1rem;
        }
        
        .quantity-input {
            border-radius: 6px;
            font-weight: 600;
        }
        
        .btn-add-cart {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-add-cart:hover {
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
            transform: scale(1.02);
        }
        
        /* Promotions Section */
        .promotions {
            background: white;
            padding: 3rem 2rem;
            border-radius: 12px;
            margin: 50px 0;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }
        
        .promotion-item {
            padding: 1.5rem;
            margin-bottom: 1rem;
            background: linear-gradient(135deg, #667eea15 0%, #764ba215 100%);
            border-left: 4px solid #667eea;
            border-radius: 8px;
            display: flex;
            align-items: center;
        }
        
        .promotion-item i {
            font-size: 2rem;
            color: #667eea;
            margin-right: 1.5rem;
            width: 50px;
            text-align: center;
        }
        
        .promotion-item p {
            margin: 0;
            font-size: 1rem;
            font-weight: 500;
            color: #333;
        }
        
        /* Footer */
        footer {
            background: #2c3e50;
            color: white;
            padding: 2rem;
            text-align: center;
            margin-top: auto;
            border-top: 1px solid #34495e;
        }
        
        .welcome-banner {
            background: #e8f4f8;
            padding: 1rem 1.5rem;
            border-radius: 8px;
            margin-bottom: 2rem;
            color: #667eea;
            font-weight: 500;
        }
        
        .no-products {
            text-align: center;
            padding: 3rem;
            color: #666;
        }
        
        .no-image-placeholder {
            height: 220px;
            background: linear-gradient(135deg, #e9ecef 0%, #dee2e6 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #999;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="IndexServlet">
            <img src="<%= request.getContextPath() %>/Image/logo.jpg" alt="Grocery Store Logo" height="40" class="me-2 rounded-circle" />
            <span>Grocery Store</span>
        </a>
        
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarNav">
            <div class="ms-auto d-flex gap-2">
                <a class="btn btn-outline-light" href="ProductServlet">
                    <i class="fas fa-products"></i> Products
                </a>
                <a class="btn btn-outline-light" href="CartServlet">
                    <i class="fas fa-shopping-cart"></i> Cart (<%= cartCount %>)
                </a>
                <% if (user != null) { %>
                    <a class="btn btn-outline-light" href="UserOrderServlet">
                        <i class="fas fa-history"></i> Orders
                    </a>
                    <a class="btn btn-danger" href="LogoutServlet">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                <% } else { %>
                    <a class="btn btn-outline-light" href="LoginServlet">
                        <i class="fas fa-sign-in-alt"></i> Login
                    </a>
                <% } %>
                <a class="btn btn-outline-secondary" href="AdminLoginServlet">
                    <i class="fas fa-lock"></i> Admin
                </a>
            </div>
        </div>
    </div>
</nav>

<div class="page-content">
    <!-- WELCOME MESSAGE -->
    <% if (user != null) { %>
        <div class="container">
            <div class="welcome-banner">
                <i class="fas fa-check-circle"></i> Welcome back, <%= user.getEmail() %>!
            </div>
        </div>
    <% } %>
    
    <!-- HERO SECTION -->
    <div class="hero">
        <div class="container">
            <h1><i class="fas fa-leaf"></i> Fresh & Organic Groceries</h1>
            <p>Quality groceries delivered fresh to your door</p>
            <a href="ProductServlet" class="btn btn-light btn-lg">
                <i class="fas fa-arrow-right me-2"></i>Start Shopping
            </a>
        </div>
    </div>

    <!-- FEATURED PRODUCTS SECTION -->
    <div class="container">
        <h2 class="section-title">Featured Products</h2>
        <div class="row g-4">


<%
    List<Product> products = (List<Product>) request.getAttribute("products");
    if (products != null && !products.isEmpty()) {
        for (Product p : products) {
%>
            <div class="col-md-4 col-sm-6">
                <div class="card product-card h-100">
                    <% if (p.getImage() != null && !p.getImage().isEmpty()) { %>
                        <img src="${pageContext.request.contextPath}/<%= p.getImage() %>" class="card-img-top" alt="<%= p.getName() %>">
                    <% } else { %>
                        <div class="no-image-placeholder">
                            <i class="fas fa-image" style="font-size: 2.5rem; opacity: 0.5;"></i>
                        </div>
                    <% } %>
                    
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title"><%= p.getName() %></h5>
                        
                        <div class="price-badge mb-2">RM <%= String.format("%.2f", p.getPrice()) %></div>
                        
                        <div class="stock-info mb-3">
                            <% if (p.getStock() > 0) { %>
                                <span class="badge bg-success"><i class="fas fa-check-circle me-1"></i>In Stock (<%= p.getStock() %>)</span>
                            <% } else { %>
                                <span class="badge bg-danger"><i class="fas fa-times-circle me-1"></i>Out of Stock</span>
                            <% } %>
                        </div>
                        
                        <form action="CartServlet" method="post" class="mt-auto">
                            <input type="hidden" name="id" value="<%= p.getId() %>">
                            <input type="hidden" name="action" value="add">
                            
                            <div class="input-group mb-3">
                                <span class="input-group-text">Qty:</span>
                                <input type="number" name="qty" value="1" min="1" max="<%= p.getStock() %>" class="form-control quantity-input">
                            </div>
                            
                            <button type="submit" class="btn btn-add-cart w-100" <%= p.getStock() <= 0 ? "disabled" : "" %>>
                                <i class="fas fa-cart-plus me-2"></i>Add to Cart
                            </button>
                        </form>
                    </div>
                </div>
            </div>
<%
        }
    } else {
%>
            <div class="col-12">
                <div class="no-products">
                    <i class="fas fa-inbox" style="font-size: 3rem; opacity: 0.3; display: block; margin-bottom: 1rem;"></i>
                    <p>No products available at the moment. Please check back later!</p>
                </div>
            </div>
<%
    }
%>
        </div>
    </div>

    <!-- PROMOTIONS SECTION -->
    <div class="container">
        <h2 class="section-title">Special Offers</h2>
        <div class="promotions">
            <div class="row">
                <div class="col-md-6">
                    <div class="promotion-item">
                        <i class="fas fa-truck"></i>
                        <p><strong>Free Delivery</strong> on orders above RM 1,000</p>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="promotion-item">
                        <i class="fas fa-tags"></i>
                        <p><strong>Festival Discounts</strong> up to 40% off selected items</p>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="promotion-item">
                        <i class="fas fa-leaf"></i>
                        <p><strong>100% Fresh</strong> organic products from local farms</p>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="promotion-item">
                        <i class="fas fa-headset"></i>
                        <p><strong>24/7 Support</strong> dedicated customer service team</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- FOOTER -->
<footer>
    <div class="container">
        <div class="row mb-3">
            <div class="col-md-4 mb-2">
                <h6><i class="fas fa-info-circle me-2"></i>About Us</h6>
                <p style="font-size: 0.9rem;">Quality groceries at your fingertips. Shop fresh, shop online.</p>
            </div>
            <div class="col-md-4 mb-2">
                <h6><i class="fas fa-phone me-2"></i>Contact</h6>
                <p style="font-size: 0.9rem;">Email: info@grocerystore.com<br>Phone: +60-1234567890</p>
            </div>
            <div class="col-md-4 mb-2">
                <h6><i class="fas fa-globe me-2"></i>Follow Us</h6>
                <p style="font-size: 0.9rem;"><a href="#" class="text-light me-2"><i class="fab fa-facebook"></i></a><a href="#" class="text-light me-2"><i class="fab fa-twitter"></i></a><a href="#" class="text-light"><i class="fab fa-instagram"></i></a></p>
            </div>
        </div>
        <hr style="opacity: 0.3;">
        <p style="margin: 0.5rem 0;">&copy; 2026 Grocery Store. All rights reserved.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
