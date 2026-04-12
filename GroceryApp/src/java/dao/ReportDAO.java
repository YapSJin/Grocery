/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import java.util.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 *
 * @author sengy
 */
public class ReportDAO {
    
    public static Map<String, Object> getDailyReport() {
        LocalDate today = LocalDate.now();
        return getReport(Timestamp.valueOf(today.atStartOfDay()), Timestamp.valueOf(today.plusDays(1).atStartOfDay()));
    }

    public static Map<String, Object> getMonthlyReport() {
        LocalDateTime end = LocalDateTime.now();
        return getReport(Timestamp.valueOf(end.minusDays(30)), Timestamp.valueOf(end));
    }

    public static Map<String, Object> getYearlyReport() {
        LocalDateTime end = LocalDateTime.now();
        return getReport(Timestamp.valueOf(end.minusDays(365)), Timestamp.valueOf(end));
    }

    private static Map<String, Object> getReport(Timestamp startDate, Timestamp endDate) {

        Map<String, Object> map = new HashMap<>();

        try (Connection con = DBConnection.getConnection()) {

            String sql = "SELECT COUNT(*) AS total_orders, COALESCE(SUM(total), 0) AS revenue " +
                         "FROM ORDERS WHERE order_date >= ? AND order_date < ?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setTimestamp(1, startDate);
            ps.setTimestamp(2, endDate);
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
