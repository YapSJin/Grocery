/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CustomerDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;

public class CustomerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        if (session.getAttribute("admin") == null) {
            response.sendRedirect("AdminLoginServlet");
            return;
        }

        String view = request.getParameter("view");
        List<Customer> customers = CustomerDAO.getAllCustomers();
        request.setAttribute("customers", customers);

        if ("admin".equals(view)) {
            request.getRequestDispatcher("admin/customers.jsp").forward(request, response);
        } else {
            response.sendRedirect("DashboardServlet");
        }
    }
}
