<%-- 
    Document   : addProduct
    Created on : Mar 29, 2026, 4:45:05 PM
    Author     : sengy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Product</title>
        
        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">

    <div class="container mt-5">

        <div class="row justify-content-center">
            <div class="col-md-6">

                <div class="card shadow">

                    <div class="card-header bg-dark text-white">
                        <h4>Add New Product</h4>
                    </div>

                    <div class="card-body">

                        <form action="../ProductServlet" method="post">

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

</body>
</html>
