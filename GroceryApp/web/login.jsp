<%-- 
    Document   : login
    Created on : Mar 29, 2026, 4:43:42 PM
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
    <body class="bg-light">

    <div class="container mt-5">

        <div class="row justify-content-center">
            <div class="col-md-4">

                <div class="card shadow">
                    <div class="card-header text-center bg-dark text-white">
                        <h4>Login</h4>
                    </div>

                    <div class="card-body">

                        <form action="LoginServlet" method="post">

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
                                <input type="password" name="password" class="form-control" required>
                            </div>

                            <button class="btn btn-primary w-100">Login</button>

                        </form>

                    </div>

                    <div class="card-footer text-center">
                        No account? <a href="register.jsp">Register</a>
                    </div>
                </div>

            </div>
        </div>

    </div>
</html>
