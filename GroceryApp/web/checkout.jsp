<%-- 
    Document   : checkout
    Created on : Mar 29, 2026, 4:44:11 PM
    Author     : sengy
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Checkout</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .section-box {
            padding: 20px;
            border-radius: 10px;
            background: #f8f9fa;
            margin-bottom: 20px;
        }
    </style>
</head>

<body class="container mt-4">

<h2 class="mb-4">Checkout</h2>

<c:set var="displaySubtotal" value="${empty subtotal ? total : subtotal}" />
<c:set var="displayTax" value="${empty tax ? 0 : tax}" />

<!-- DELIVERY -->
<form method="get" action="CheckoutServlet" class="mb-3">
    <label for="deliveryType" class="form-label">Delivery</label>
    <select id="deliveryType" class="form-select" name="deliveryType" onchange="this.form.submit()">
        <option value="normal" ${deliveryType == 'normal' ? 'selected' : ''}>Normal</option>
        <option value="express" ${deliveryType == 'express' ? 'selected' : ''}>Express</option>
    </select>
</form>

<hr>

<h3>Order Summary</h3>

<table class="table table-bordered">
    <thead>
        <tr>
            <th>Product</th>
            <th>Quantity</th>
        </tr>
    </thead>
    <tbody>
        <c:choose>
            <c:when test="${not empty cartItems}">
                <c:forEach var="entry" items="${cartItems}">
                    <tr>
                        <td>${entry.key.name}</td>
                        <td>${entry.value}</td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="2" class="text-muted">Cart summary is not available.</td>
                </tr>
            </c:otherwise>
        </c:choose>
    </tbody>
</table>

<p>Subtotal: RM <fmt:formatNumber value="${displaySubtotal}" minFractionDigits="2" maxFractionDigits="2"/></p>
<p>Tax (6%): RM <fmt:formatNumber value="${displayTax}" minFractionDigits="2" maxFractionDigits="2"/></p>
<p>Shipping: RM <fmt:formatNumber value="${shipping}" minFractionDigits="2" maxFractionDigits="2"/></p>
<h4>Total: RM <fmt:formatNumber value="${finalTotal}" minFractionDigits="2" maxFractionDigits="2"/></h4>

<hr>

<h3>Payment</h3>

<form method="post" action="CheckoutServlet">

    <div class="section-box">
        <h4>Payment Method</h4>

        <div class="form-check">
            <input class="form-check-input" type="radio" name="paymentMethod" value="cash" checked onclick="togglePayment()">
            <label class="form-check-label">Cash</label>
        </div>

        <div class="form-check">
            <input class="form-check-input" type="radio" name="paymentMethod" value="debit" onclick="togglePayment()">
            <label class="form-check-label">Debit Card</label>
        </div>

        <div class="form-check">
            <input class="form-check-input" type="radio" name="paymentMethod" value="credit" onclick="togglePayment()">
            <label class="form-check-label">Credit Card</label>
        </div>

        <div class="form-check">
            <input class="form-check-input" type="radio" name="paymentMethod" value="ewallet" onclick="togglePayment()">
            <label class="form-check-label">E-Wallet</label>
        </div>
    </div>

    <div id="cashSection" class="section-box">
        <h5>Shipping Details</h5>
        <input id="cashAddress" class="form-control mb-2" name="address" placeholder="Address" required>
        <input id="cashPhone" class="form-control mb-2" name="phone" placeholder="Phone" required>
    </div>

    <div id="cardSection" class="section-box" style="display:none;">
        <h5>Card Payment</h5>

        <select class="form-select mb-2" name="cardType">
            <option value="visa">Visa</option>
            <option value="mastercard">MasterCard</option>
        </select>

        <input class="form-control mb-2" name="cardName" placeholder="Cardholder Name">
        <input class="form-control mb-2" name="cardNumber" placeholder="16-digit Card Number">
        <input class="form-control mb-2" name="expiry" placeholder="MM/YY">
        <input class="form-control mb-2" name="cvv" placeholder="CVV">
        <input class="form-control mb-2" name="cardAddress" placeholder="Billing Address">
    </div>

    <div id="ewalletSection" class="section-box" style="display:none;">
        <h5>E-Wallet</h5>

        <select class="form-select mb-2" name="walletType">
            <option value="tng">Touch 'n Go</option>
            <option value="grabpay">GrabPay</option>
        </select>

        <input class="form-control mb-2" name="walletPhone" placeholder="Wallet Phone Number">
    </div>

    <button type="submit" class="btn btn-success w-100">Confirm Order</button>

</form>

<c:if test="${not empty error}">
    <p class="text-danger mt-3">${error}</p>
</c:if>

<script>
function togglePayment() {
    var method = document.querySelector('input[name="paymentMethod"]:checked').value;
    var cashSection = document.getElementById("cashSection");
    var cardSection = document.getElementById("cardSection");
    var ewalletSection = document.getElementById("ewalletSection");
    var cashAddress = document.getElementById("cashAddress");
    var cashPhone = document.getElementById("cashPhone");

    cashSection.style.display = "none";
    cardSection.style.display = "none";
    ewalletSection.style.display = "none";

    cashAddress.required = false;
    cashPhone.required = false;

    if (method === "cash") {
        cashSection.style.display = "block";
        cashAddress.required = true;
        cashPhone.required = true;
    } else if (method === "debit" || method === "credit") {
        cardSection.style.display = "block";
    } else if (method === "ewallet") {
        ewalletSection.style.display = "block";
    }
}

togglePayment();
</script>

</body>
</html>