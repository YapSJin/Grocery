/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import java.util.*;

/**
 *
 * @author sengy
 */
public class ReportDAO {
    
    public static Map<String, Object> getDailyReport() {
        return getReport("CURRENT_DATE");
    }

    public static Map<String, Object> getMonthlyReport() {
        return getReport("CURRENT_DATE - 30 DAYS");
    }

    public static Map<String, Object> getYearlyReport() {
        return getReport("CURRENT_DATE - 365 DAYS");
    }

    private static Map<String, Object> getReport(String condition) {

        Map<String, Object> map = new HashMap<>();

        try (Connection con = DBConnection.getConnection()) {

            String sql = "SELECT COUNT(*) AS total_orders, SUM(total) AS revenue " +
                         "FROM ORDERS WHERE DATE(order_date) >= " + condition;

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                map.put("totalOrders", rs.getInt("total_orders"));
                map.put("revenue", rs.getDouble("revenue"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return map;
    }
}
