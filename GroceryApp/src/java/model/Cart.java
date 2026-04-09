/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.util.*;

/**
 *
 * @author sengy
 */
public class Cart {
    private Map<Integer, Integer> items = new HashMap<>();

    // ✅ Add with quantity
    public void add(int id, int qty) {
        items.put(id, items.getOrDefault(id, 0) + qty);
    }

    // ✅ Update quantity
    public void update(int id, int qty) {
        if (qty <= 0) {
            items.remove(id);
        } else {
            items.put(id, qty);
        }
    }

    // ✅ Remove item
    public void remove(int id) {
        items.remove(id);
    }

    public Map<Integer, Integer> getItems() {
        return items;
    }
}