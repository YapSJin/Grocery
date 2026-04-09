/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import dao.DBConnection;
import dao.ProductDAO;
import model.Product;
import model.Cart;
import model.Customer;
import java.io.PrintWriter;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author sengy
 */
public class CheckoutServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CheckoutServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckoutServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    HttpSession session = request.getSession();

    // 🔒 login check
    if (session.getAttribute("user") == null) {
        response.sendRedirect("LoginServlet");
        return;
    }

    Cart cart = (Cart) session.getAttribute("cart");

    if (cart == null || cart.getItems().isEmpty()) {
        response.sendRedirect("CartServlet");
        return;
    }

    double total = 0;

    for (Integer id : cart.getItems().keySet()) {
        int qty = cart.getItems().get(id);
        Product p = ProductDAO.getProductById(id);

        if (p != null) {
            total += p.getPrice() * qty;
        }
    }

    double shipping = (total >= 1000) ? 0 : 25;
    double finalTotal = total + shipping;

    request.setAttribute("total", total);
    request.setAttribute("shipping", shipping);
    request.setAttribute("finalTotal", finalTotal);

    request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    HttpSession session = request.getSession();
    
    Customer user = (Customer) session.getAttribute("user");  // ✅ ADD THIS
    
    if (user == null) {
    response.sendRedirect("LoginServlet");
    return;
    }
    
    Cart cart = (Cart) session.getAttribute("cart");

    if (cart == null || cart.getItems().isEmpty()) {
        response.sendRedirect("CartServlet");
        return;
    }

    Connection con = null;

        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false); // 🔥 START TRANSACTION

            double total = 0;

            // 1️⃣ Calculate total
            for (Integer id : cart.getItems().keySet()) {
                int qty = cart.getItems().get(id);
                Product p = ProductDAO.getProductById(id);
                total += p.getPrice() * qty;
            }

            // 2️⃣ Insert into ORDERS
            String orderSql = "INSERT INTO ORDERS (CUSTOMER_ID, TOTAL, STATUS) VALUES (?, ?, ?)";
            PreparedStatement orderPs = con.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);

            orderPs.setInt(1, user.getCustomerId());
            orderPs.setDouble(2, total);
            orderPs.setString(3, "Packaging");

            orderPs.executeUpdate();

            ResultSet rs = orderPs.getGeneratedKeys();
            int orderId = 0;

            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            // 3️⃣ Insert ORDERITEM + Update STOCK
            String itemSql = "INSERT INTO ORDERITEM (ORDER_ID, PRODUCT_ID, QUANTITY, PRICE) VALUES (?, ?, ?, ?)";
            String stockSql = "UPDATE PRODUCT SET STOCK = STOCK - ? WHERE PRODUCT_ID = ?";

            PreparedStatement itemPs = con.prepareStatement(itemSql);
            PreparedStatement stockPs = con.prepareStatement(stockSql);

            for (Integer id : cart.getItems().keySet()) {

                int qty = cart.getItems().get(id);
                Product p = ProductDAO.getProductById(id);

                // ❗ Prevent negative stock
                if (p.getStock() < qty) {
                    throw new ServletException("Insufficient stock for " + p.getName());
                }

                // Insert ORDERITEM
                itemPs.setInt(1, orderId);
                itemPs.setInt(2, id);
                itemPs.setInt(3, qty);
                itemPs.setDouble(4, p.getPrice());
                itemPs.addBatch();

                // Update PRODUCT stock
                stockPs.setInt(1, qty);
                stockPs.setInt(2, id);
                stockPs.addBatch();
            }

            itemPs.executeBatch();
            stockPs.executeBatch();

            con.commit(); // ✅ SUCCESS

            // 4️⃣ Clear cart
            session.removeAttribute("cart");

            // 5️⃣ Forward to success page
            request.setAttribute("total", total);
            request.getRequestDispatcher("success.jsp").forward(request, response);

        } catch (Exception e) {

            try {
                if (con != null) con.rollback(); // ❌ ROLLBACK
            } catch (Exception ex) {
                ex.printStackTrace();
            }

            throw new ServletException(e);

        } finally {
            try {
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
