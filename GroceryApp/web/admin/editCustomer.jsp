<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Customer"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Customer</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">

        <%
            Customer customer = (Customer) request.getAttribute("customer");
            if (customer == null) {
                response.sendRedirect("CustomerServlet?view=admin");
                return;
            }
        %>

        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card shadow">
                        <div class="card-header bg-warning text-dark">
                            <h3 class="text-center mb-0">Edit Customer</h3>
                        </div>
                        <div class="card-body p-4">
                            <form action="CustomerServlet" method="POST">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="id" value="<%= customer.getCustomerId() %>">
                                
                                <div class="mb-3">
                                    <label class="form-label">Full Name</label>
                                    <input type="text" name="name" class="form-control" value="<%= customer.getName() %>" required>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Email Address</label>
                                    <input type="email" name="email" class="form-control" value="<%= customer.getEmail() %>" required>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Password</label>
                                    <input type="text" name="password" class="form-control" value="<%= customer.getPassword() %>" required>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Address</label>
                                    <textarea name="address" class="form-control" rows="3" required><%= customer.getAddress() %></textarea>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Phone Number</label>
                                    <input type="text" name="phone" class="form-control" value="<%= customer.getPhone() %>" required>
                                </div>

                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn btn-warning">Update Customer</button>
                                    <a href="CustomerServlet?view=admin" class="btn btn-outline-secondary">Cancel</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
