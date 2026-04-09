/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Order;

/**
 * DAO for order-related queries.
 */
public class OrderDAO {
    public static List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT o.ORDER_ID, o.CUSTOMER_ID, c.EMAIL AS CUSTOMER_EMAIL, o.TOTAL, o.STATUS, o.ORDER_DATE " +
                         "FROM ORDERS o LEFT JOIN CUSTOMER c ON o.CUSTOMER_ID = c.CUSTOMER_ID " +
                         "ORDER BY o.ORDER_ID";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new Order(
                    rs.getInt("ORDER_ID"),
                    rs.getInt("CUSTOMER_ID"),
                    rs.getString("CUSTOMER_EMAIL"),
                    rs.getDouble("TOTAL"),
                    rs.getString("STATUS"),
                    rs.getTimestamp("ORDER_DATE")
                ));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public static void updateOrderStatus(int orderId, String status) {
        try (Connection con = DBConnection.getConnection()) {
            String sql = "UPDATE ORDERS SET STATUS = ? WHERE ORDER_ID = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, orderId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static List<Order> getOrdersByCustomerId(int customerId) {
        List<Order> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT ORDER_ID, CUSTOMER_ID, TOTAL, STATUS, ORDER_DATE FROM ORDERS WHERE CUSTOMER_ID = ? ORDER BY ORDER_DATE DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new Order(
                    rs.getInt("ORDER_ID"),
                    rs.getInt("CUSTOMER_ID"),
                    null, // customerEmail not needed here
                    rs.getDouble("TOTAL"),
                    rs.getString("STATUS"),
                    rs.getTimestamp("ORDER_DATE")
                ));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public static int countOrders() {
        int count = 0;
        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT COUNT(*) FROM ORDERS";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
}
