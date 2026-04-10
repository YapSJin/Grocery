/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.OrderDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Order;

public class OrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        if (session.getAttribute("admin") == null) {
            response.sendRedirect("AdminLoginServlet");
            return;
        }

        String view = request.getParameter("view");
        String action = request.getParameter("action");
        
        if ("edit".equals(action)) {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            Order order = OrderDAO.getOrderById(orderId);
            request.setAttribute("order", order);
            request.getRequestDispatcher("admin/editOrder.jsp").forward(request, response);
            return;
        }
        
        List<Order> orders = OrderDAO.getAllOrders();
        request.setAttribute("orders", orders);

        if ("admin".equals(view)) {
            request.getRequestDispatcher("admin/orders.jsp").forward(request, response);
        } else {
            response.sendRedirect("DashboardServlet");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("admin") == null) {
            response.sendRedirect("AdminLoginServlet");
            return;
        }

        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String action = request.getParameter("action");
        
        if ("delete".equals(action)) {
            OrderDAO.deleteOrder(orderId);
            response.sendRedirect("OrderServlet?view=admin");
            return;
        }
        
        String status = request.getParameter("status");
        OrderDAO.updateOrderStatus(orderId, status);

        response.sendRedirect("OrderServlet?view=admin");
    }
}
