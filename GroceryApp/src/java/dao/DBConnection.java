/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author sengy
 */
public class DBConnection {
    
    public static Connection getConnection() throws Exception {

        // Derby (JavaDB) connection
        String url = "jdbc:derby://localhost:1527/groceryDB";
        String username = "nbuser";
        String password = "nbuser";

        Class.forName("org.apache.derby.jdbc.ClientDriver");

        return DriverManager.getConnection(url, username, password);
    }
}
