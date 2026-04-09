<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String admin = (String) session.getAttribute("admin");

if (admin == null) {
    response.sendRedirect(request.getContextPath() + "/AdminLoginServlet");
    return;
}
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Dashboard</title>
        
        <!-- Bootstrap layout -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        
        <!-- Admin Dashboard Styles -->
        <link href="${pageContext.request.contextPath}/styles/adminDashboard.css" rel="stylesheet">
    </head>
    <body>
        
    <!-- NAVBAR -->
    <nav class="navbar navbar-dark bg-dark">
        <div class="container-fluid d-flex align-items-center">
            <span class="navbar-brand mb-0 h1">Admin Dashboard</span>
            <img src="${pageContext.request.contextPath}/assets/logo.png" alt="Logo" style="height:40px; width:auto;" class="mx-auto">
            <a href="${pageContext.request.contextPath}/LogoutServlet" class="btn btn-danger">Logout</a>
        </div>
    </nav>

    <div class="container-fluid">

        <div class="row">

            <!-- SIDEBAR -->
            <div class="col-md-2 bg-light vh-100 p-3">
                <h5>Menu</h5>
                <hr>

                <a href="${pageContext.request.contextPath}/ProductServlet?view=admin" class="btn btn-outline-primary w-100 mb-2">
                    Manage Products
                </a>

                <a href="${pageContext.request.contextPath}/CustomerServlet?view=admin" class="btn btn-outline-info w-100 mb-2">
                    View Customers
                </a>

                <a href="${pageContext.request.contextPath}/OrderServlet?view=admin" class="btn btn-outline-info w-100 mb-2">
                    View Orders
                </a>

                <a href="${pageContext.request.contextPath}/admin/addProduct.jsp" class="btn btn-outline-success w-100 mb-2">
                    Add Product
                </a>

                <a href="${pageContext.request.contextPath}/ReportServlet" class="btn btn-outline-warning w-100 mb-2">
                    Sales Report
                </a>
            </div>

            <!-- MAIN CONTENT -->
            <div class="col-md-10 p-4">

                <h2>Welcome, Admin</h2>
                <p>Manage your grocery store system here.</p>

                <!-- DASHBOARD CARDS -->
                <div class="row">

                    <div class="col-md-4">
                        <div class="card text-white bg-primary mb-3">
                            <div class="card-body">
                                <h5>Total Products</h5>
                                <p class="fs-2"><strong><%= request.getAttribute("totalProducts") != null ? request.getAttribute("totalProducts") : 0 %></strong></p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="card text-white bg-success mb-3">
                            <div class="card-body">
                                <h5>Orders</h5>
                                <p class="fs-2"><strong><%= request.getAttribute("totalOrders") != null ? request.getAttribute("totalOrders") : 0 %></strong></p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="card text-white bg-danger mb-3">
                            <div class="card-body">
                                <h5>Customers</h5>
                                <p class="fs-2"><strong><%= request.getAttribute("totalCustomers") != null ? request.getAttribute("totalCustomers") : 0 %></strong></p>
                            </div>
                        </div>
                    </div>

                </div>

            </div>

        </div>

    </div>

    </body>
</html>
