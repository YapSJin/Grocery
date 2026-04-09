<%-- 
    Document   : register
    Created on : Mar 29, 2026, 4:43:48 PM
    Author     : sengy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <title>Grocery Store</title>

    <!-- Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <form action="RegisterServlet" method="post" class="card p-4 shadow">

    <h3 class="mb-3">Register</h3>

    <% if(request.getAttribute("error") != null) { %>
        <div class="alert alert-danger">
            <%= request.getAttribute("error") %>
        </div>
    <% } %>

    <div class="mb-3">
        <label>Email</label>
        <input type="email" name="email" class="form-control" required>
    </div>

    <div class="mb-3">
        <label>Password</label>
        <input type="password" name="password" class="form-control" required minlength="6">
    </div>
    
    <div class="mb-3">
        <label>Confirm Password</label>
        <input type="password" name="confirmPassword" class="form-control" required minlength="6">
    </div>
    
    <div class="mb-3">
        <label>Name</label>
        <input type="text" name="name" required class="form-control">
    </div>
    
    <div class="mb-3">
        <label>Address</label>
        <input type="text" name="address" required class="form-control">
    </div>

    <div class="mb-3">
        <label>Phone</label>
        <input type="text" name="phone" required class="form-control">
    </div>
    
    <button class="btn btn-success w-100">Register</button>

    <p class="mt-3 text-center">
        Already have account? <a href="LoginServlet">Login</a>
    </p>

</form>
    </body>
</html>
