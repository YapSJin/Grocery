/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 * Order model matching the ORDERS table.
 */
public class Order {
    private int orderId;
    private int customerId;
    private String customerEmail;
    private double total;
    private String status;
    private Timestamp orderDate;

    public Order(int orderId, int customerId, String customerEmail, double total, String status, Timestamp orderDate) {
        this.orderId = orderId;
        this.customerId = customerId;
        this.customerEmail = customerEmail;
        this.total = total;
        this.status = status;
        this.orderDate = orderDate;
    }

    public int getOrderId() {
        return orderId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public double getTotal() {
        return total;
    }

    public String getStatus() {
        return status;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }
}
