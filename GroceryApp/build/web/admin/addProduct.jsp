<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Product</title>
        
        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Admin Dashboard Styles -->
        <link href="${pageContext.request.contextPath}/css/adminDashboard.css" rel="stylesheet">
    </head>
    <body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container-fluid">
                <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/admin/dashboard.jsp">
                    <img src="${pageContext.request.contextPath}/Image/logo.jpg" alt="Logo" class="me-2">
                    <span class="mb-0 h1">Admin Dashboard</span>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNavbarNav" aria-controls="adminNavbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse justify-content-end" id="adminNavbarNav">
                    <a href="${pageContext.request.contextPath}/LogoutServlet" class="btn btn-outline-light btn-nav">Logout</a>
                </div>
        </div>
    </nav>

    <div class="container mt-5">

        <div class="row justify-content-center">
            <div class="col-md-6">

                <div class="card shadow">

                    <div class="card-header bg-dark text-white">
                        <h4>Add New Product</h4>
                    </div>

                    <div class="card-body">

                        <form action="${pageContext.request.contextPath}/ProductServlet" method="post" enctype="multipart/form-data">

                            <div class="mb-3">
                                <label>Product Name</label>
                                <input type="text" name="name" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label>Price (RM)</label>
                                <input type="number" step="0.01" name="price" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label>Stock</label>
                                <input type="number" name="stock" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label>Description</label>
                                <textarea name="description" class="form-control" rows="3"></textarea>
                            </div>

                            <div class="mb-3">
                                <label>Product Image</label>
                                <input type="file" name="image" class="form-control" accept="image/*" required>
                            </div>

                            <button class="btn btn-success w-100">Add Product</button>

                        </form>

                    </div>

                    <div class="card-footer text-center">
                        <a href="${pageContext.request.contextPath}/ProductServlet?view=admin">
                            Back to Product List
                        </a>                    
                    </div>

                </div>

            </div>
        </div>

    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
