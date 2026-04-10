<%-- 
    Document   : checkout
    Created on : Mar 29, 2026, 4:44:11 PM
    Author     : sengy
--%>

<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Checkout</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS overrides -->
    <link href="css/styles.css" rel="stylesheet">
</head>

<body>

<div class="container mt-5">

    <h2>Checkout</h2>

    <form action="CheckoutServlet" method="post">

        <h5 class="mt-4">Shipping Information</h5>

        <input type="text" name="address" class="form-control mb-2" placeholder="Address" required>
        <input type="text" name="phone" class="form-control mb-2" placeholder="Phone" required>

        <h5 class="mt-4">Payment Method</h5>

        <select name="payment" class="form-control mb-3">
            <option>Cash</option>
            <option>Visa</option>
            <option>MasterCard</option>
            <option>E-Wallet</option>
        </select>

        <h5>Order Summary</h5>

        <p>Total: RM ${total}</p>
        <p>Shipping: RM ${shipping}</p>
        <p><strong>Final Total: RM ${finalTotal}</strong></p>

        <button class="btn btn-success mt-3 w-100">
            Confirm Order
        </button>

    </form>

</div>

</body>
</html>