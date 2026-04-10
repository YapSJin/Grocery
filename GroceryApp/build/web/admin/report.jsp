<%-- 
    Document   : report
    Created on : Apr 8, 2026, 5:28:19 PM
    Author     : sengy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sales Report</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Custom CSS overrides -->
        <link href="../css/styles.css" rel="stylesheet">
    </head>
    <body>

        <div class="container mt-5">

            <h2>Sales Report</h2>

            <!-- Filter Buttons -->
            <div class="mb-3">
                <a href="ReportServlet?type=day" class="btn btn-primary">Daily</a>
                <a href="ReportServlet?type=month" class="btn btn-warning">Monthly</a>
                <a href="ReportServlet?type=year" class="btn btn-success">Yearly</a>
            </div>

            <%
                java.util.Map report = (java.util.Map) request.getAttribute("report");
            %>

            <div class="card p-4 shadow">

                <h4>Total Orders: <%= report.get("totalOrders") %></h4>
                <h4>Total Revenue: RM <%= report.get("revenue") %></h4>

            </div>

            <a href="DashboardServlet" class="btn btn-secondary mt-3">Back</a>

        </div>    
    </body>
</html>
