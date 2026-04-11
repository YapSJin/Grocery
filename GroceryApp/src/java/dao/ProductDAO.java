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

    public static void checkAndAddImageColumn() {
        try (Connection con = DBConnection.getConnection()) {
            DatabaseMetaData meta = con.getMetaData();
            try (ResultSet rs = meta.getColumns(null, "NBUSER", "PRODUCT", "IMAGE")) {
                if (!rs.next()) {
                    try (Statement stmt = con.createStatement()) {
                        stmt.executeUpdate("ALTER TABLE PRODUCT ADD COLUMN image VARCHAR(255)");
                        System.out.println("Added 'image' column to PRODUCT table.");
                    }
                }
            } catch (Exception e) {
                try (ResultSet rs = meta.getColumns(null, null, "PRODUCT", "IMAGE")) {
                    if (!rs.next()) {
                        try (Statement stmt = con.createStatement()) {
                            stmt.executeUpdate("ALTER TABLE PRODUCT ADD COLUMN image VARCHAR(255)");
                            System.out.println("Added 'image' column to PRODUCT table (no schema).");
                        }
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("Error checking/adding 'image' column: " + e.getMessage());
        }
    }

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
                    rs.getString("description"),
                    rs.getString("image")
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
    
    public static void addProduct(String name, double price, int stock, String description, String image) throws Exception {

    try (Connection con = DBConnection.getConnection()) {

        String sql = "INSERT INTO Product(name, price, stock, description, image) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(sql);

        ps.setString(1, name);
        ps.setDouble(2, price);
        ps.setInt(3, stock);
        ps.setString(4, description);
        ps.setString(5, image);

        ps.executeUpdate();

    } catch (Exception e) {
        e.printStackTrace();
        throw e;
    }
    }
    
    public static void updateProduct(int id, String name, double price, int stock, String description, String image) throws Exception {

    try (Connection con = DBConnection.getConnection()) {

        String sql = "UPDATE Product SET name=?, price=?, stock=?, description=?, image=? WHERE product_id=?";
        PreparedStatement ps = con.prepareStatement(sql);

        ps.setString(1, name);
        ps.setDouble(2, price);
        ps.setInt(3, stock);
        ps.setString(4, description);
        ps.setString(5, image);
        ps.setInt(6, id);

        ps.executeUpdate();

    } catch (Exception e) {
        e.printStackTrace();
        throw e;
    }
}
    public static void deleteProduct(int id) throws Exception {

    try (Connection con = DBConnection.getConnection()) {

        String sql = "DELETE FROM Product WHERE product_id=?";
        PreparedStatement ps = con.prepareStatement(sql);

        ps.setInt(1, id);

        ps.executeUpdate();

    } catch (Exception e) {
        e.printStackTrace();
        throw e;
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
                rs.getString("description"),
                rs.getString("image")
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
                rs.getString("description"),
                rs.getString("image")
            ));
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return list;
}
}
