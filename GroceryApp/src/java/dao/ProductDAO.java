/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import dao.DBConnection;
import model.Product;

/**
 *
 * @author sengy
 */
public class ProductDAO {
    public static List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {

            String sql = "SELECT * FROM Product";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();   // ✅ FIXED

            while (rs.next()) {
                list.add(new Product(
                    rs.getInt("product_id"),
                    rs.getString("name"),
                    rs.getDouble("price"),
                    rs.getInt("stock"),
                    rs.getString("description")
                ));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public static int countProducts() {
        int count = 0;
        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT COUNT(*) FROM Product";
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
    
    public static void addProduct(String name, double price, int stock, String description) {

    try (Connection con = DBConnection.getConnection()) {

        String sql = "INSERT INTO Product(name, price, stock, description) VALUES (?, ?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(sql);

        ps.setString(1, name);
        ps.setDouble(2, price);
        ps.setInt(3, stock);
        ps.setString(4, description);

        ps.executeUpdate();

    } catch (Exception e) {
        e.printStackTrace();
    }
    }
    
    public static void updateProduct(int id, String name, double price, int stock, String description) {

    try (Connection con = DBConnection.getConnection()) {

        String sql = "UPDATE Product SET name=?, price=?, stock=?, description=? WHERE product_id=?";
        PreparedStatement ps = con.prepareStatement(sql);

        ps.setString(1, name);
        ps.setDouble(2, price);
        ps.setInt(3, stock);
        ps.setString(4, description);
        ps.setInt(5, id);

        ps.executeUpdate();

    } catch (Exception e) {
        e.printStackTrace();
    }
}
    public static void deleteProduct(int id) {

    try (Connection con = DBConnection.getConnection()) {

        String sql = "DELETE FROM Product WHERE product_id=?";
        PreparedStatement ps = con.prepareStatement(sql);

        ps.setInt(1, id);

        ps.executeUpdate();

    } catch (Exception e) {
        e.printStackTrace();
    }
}
    public static Product getProductById(int id) {

    Product p = null;

    try (Connection con = DBConnection.getConnection()) {

        String sql = "SELECT * FROM Product WHERE product_id=?";
        PreparedStatement ps = con.prepareStatement(sql);

        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            p = new Product(
                rs.getInt("product_id"),
                rs.getString("name"),
                rs.getDouble("price"),
                rs.getInt("stock"),
                rs.getString("description")
            );
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return p;
}
    public static List<Product> searchProducts(String keyword) {

    List<Product> list = new ArrayList<>();

    try (Connection con = DBConnection.getConnection()) {

        String sql = "SELECT * FROM Product WHERE name LIKE ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, "%" + keyword + "%");

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            list.add(new Product(
                rs.getInt("product_id"),
                rs.getString("name"),
                rs.getDouble("price"),
                rs.getInt("stock"),
                rs.getString("description")
            ));
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return list;
}
}
