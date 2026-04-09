/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author sengy
 */
public class Customer {
    
    private int customerId;   // ✅ match DB
    private String name;
    private String email;
    private String password;
    private String address;
    private String phone;

    // ✅ Constructor for login
    public Customer(int customerId, String email) {
        this.customerId = customerId;
        this.email = email;
    }

    // ✅ Full constructor (optional)
    public Customer(int customerId, String name, String email, String password, String address, String phone) {
        this.customerId = customerId;
        this.name = name;
        this.email = email;
        this.password = password;
        this.address = address;
        this.phone = phone;
    }

    // ✅ REQUIRED getter for checkout
    public int getCustomerId() {
        return customerId;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public String getAddress() {
        return address;
    }

    public String getPhone() {
        return phone;
    }

    // setters (optional but recommended)
    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public void setName(String name) {
        this.name = name;
    }
}