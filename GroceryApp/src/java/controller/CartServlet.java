/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ProductDAO;
import java.io.IOException;
import model.Cart;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.LinkedHashMap;
import java.util.Map;
import model.Product;

/**
 *
 * @author sengy
 */
public class CartServlet extends HttpServlet {

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
            out.println("<title>Servlet CartServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartServlet at " + request.getContextPath() + "</h1>");
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

    // 🔒 Login check
    if (session.getAttribute("user") == null) {
        response.sendRedirect("LoginServlet");
        return;
    }

    Cart cart = (Cart) session.getAttribute("cart");

    if (cart == null) {
        request.setAttribute("cartItems", null);
        request.getRequestDispatcher("cart.jsp").forward(request, response);
        return;
    }

    // 🔥 JOIN with ProductDAO
    ProductDAO dao = new ProductDAO();

    Map<Product, Integer> cartItems = new LinkedHashMap<>();

    for (Map.Entry<Integer, Integer> entry : cart.getItems().entrySet()) {
        Product p = dao.getProductById(entry.getKey()); // YOU MUST HAVE THIS METHOD
        cartItems.put(p, entry.getValue());
    }

    request.setAttribute("cartItems", cartItems);

    request.getRequestDispatcher("cart.jsp").forward(request, response);
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

    // 🔒 Login check
    if (session.getAttribute("user") == null) {
        response.sendRedirect("LoginServlet");
        return;
    }

    String action = request.getParameter("action");
    int id = Integer.parseInt(request.getParameter("id"));

    Cart cart = (Cart) session.getAttribute("cart");
    if (cart == null) cart = new Cart();

    if ("add".equals(action)) {

        int qty = Integer.parseInt(request.getParameter("qty"));
        cart.add(id, qty);

        // ✅ stay on same page (NO redirect to cart)
        response.sendRedirect(request.getHeader("referer"));

    } else if ("update".equals(action)) {

        int qty = Integer.parseInt(request.getParameter("qty"));
        cart.update(id, qty);

        response.sendRedirect("CartServlet");

    } else if ("remove".equals(action)) {

        cart.remove(id);

        response.sendRedirect("CartServlet");
    }

    session.setAttribute("cart", cart);
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
