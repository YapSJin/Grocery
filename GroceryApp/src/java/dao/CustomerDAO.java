/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import java.sql.*;
import model.Customer;

/**
 *
 * @author sengy
 */
public class CustomerDAO {
    
    // ✅ LOGIN
    public static Customer login(String email, String password) {

        try (Connection con = DBConnection.getConnection()) {

            String sql = "SELECT * FROM CUSTOMER WHERE EMAIL=? AND PASSWORD=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new Customer(
                        rs.getInt("CUSTOMER_ID"),   // ✅ match DB
                        rs.getString("EMAIL")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // ✅ REGISTER (FULL VERSION)
    public static boolean register(String name, String email, String password,
                                   String address, String phone) {

        try (Connection con = DBConnection.getConnection()) {

            // 🔒 CHECK DUPLICATE EMAIL
            String checkSql = "SELECT * FROM CUSTOMER WHERE EMAIL=?";
            PreparedStatement checkPs = con.prepareStatement(checkSql);
            checkPs.setString(1, email);

            ResultSet rs = checkPs.executeQuery();
            if (rs.next()) {
                return false; // email already exists
            }

            // ✅ INSERT FULL DATA
            String sql = "INSERT INTO CUSTOMER(NAME, EMAIL, PASSWORD, ADDRESS, PHONE) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, address);
            ps.setString(5, phone);

            int rows = ps.executeUpdate();

            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}
