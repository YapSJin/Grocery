<%-- 
    Document   : success
    Created on : Mar 29, 2026, 4:44:19 PM
    Author     : sengy
--%>

<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Order Success</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS overrides -->
    <link href="css/styles.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="card shadow p-4 text-center">

        <h2 class="text-success mb-3">✔ Order Confirmed</h2>

        <p>Thank you for your purchase.</p>

        <%
            String txn = "TXN" + System.currentTimeMillis();
            String date = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm")
                    .format(new java.util.Date());
        %>

        <hr>

        <h5>Transaction Details</h5>

        <p><strong>Transaction ID:</strong> <%= txn %></p>
        <p><strong>Date:</strong> <%= date %></p>

        <hr>

        <h5>Payment Summary</h5>

        <p>Total: RM ${total}</p>
        <p>Shipping: RM ${shipping}</p>
        <p><strong>Final Total: RM ${finalTotal}</strong></p>

        <hr>

        <p class="text-muted">
            Expected delivery within 3–5 working days.
        </p>

        <a href="IndexServlet" class="btn btn-primary mt-3">
            Back to Home
        </a>

    </div>

</div>

</body>
</html>