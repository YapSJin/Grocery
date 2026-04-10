<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Order" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Order</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>Edit Order</h2>
                <a href="OrderServlet?view=admin" class="btn btn-secondary">Back to Orders</a>
            </div>

            <%
                Order order = (Order) request.getAttribute("order");
                if (order != null) {
            %>
            <div class="row">
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-header">
                            <h5>Order ID: <%= order.getOrderId() %></h5>
                        </div>
                        <div class="card-body">
                            <form action="OrderServlet" method="post">
                                <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                                
                                <div class="mb-3">
                                    <label for="customerId" class="form-label">Customer ID</label>
                                    <input type="text" class="form-control" id="customerId" value="<%= order.getCustomerId() %>" readonly>
                                </div>

                                <div class="mb-3">
                                    <label for="customerEmail" class="form-label">Customer Email</label>
                                    <input type="email" class="form-control" id="customerEmail" value="<%= order.getCustomerEmail() != null ? order.getCustomerEmail() : "-" %>" readonly>
                                </div>

                                <div class="mb-3">
                                    <label for="total" class="form-label">Total (RM)</label>
                                    <input type="number" class="form-control" id="total" value="<%= order.getTotal() %>" readonly step="0.01">
                                </div>

                                <div class="mb-3">
                                    <label for="orderDate" class="form-label">Order Date</label>
                                    <input type="text" class="form-control" id="orderDate" value="<%= order.getOrderDate() != null ? order.getOrderDate() : "-" %>" readonly>
                                </div>

                                <div class="mb-3">
                                    <label for="status" class="form-label">Status</label>
                                    <select name="status" id="status" class="form-select">
                                        <option value="Packaging" <%= "Packaging".equalsIgnoreCase(order.getStatus()) ? "selected" : "" %>>Packaging</option>
                                        <option value="Shipping" <%= "Shipping".equalsIgnoreCase(order.getStatus()) ? "selected" : "" %>>Shipping</option>
                                        <option value="Completed" <%= "Completed".equalsIgnoreCase(order.getStatus()) ? "selected" : "" %>>Completed</option>
                                    </select>
                                </div>

                                <div class="d-flex gap-2">
                                    <button type="submit" class="btn btn-primary">Update Status</button>
                                    <a href="OrderServlet?view=admin" class="btn btn-outline-secondary">Cancel</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <%
                } else {
            %>
            <div class="alert alert-danger" role="alert">
                Order not found!
            </div>
            <%
                }
            %>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
