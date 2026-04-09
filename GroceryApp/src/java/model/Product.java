/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author sengy
 */
public class Product {
    private int id;
    private String name;
    private double price;
    private int stock;
    private String description;

    public Product(int id, String name, double price, int stock, String description) {
    this.id = id;
    this.name = name;
    this.price = price;
    this.stock = stock;
    this.description = description;
}

    public int getId() { return id; }
    public String getName() { return name; }
    public double getPrice() { return price; }
    public int getStock() { return stock; }
    public String getDescription() { return description; }
}
