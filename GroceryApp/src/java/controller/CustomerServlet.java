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

        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            CustomerDAO.deleteCustomer(id);
            response.sendRedirect("CustomerServlet?view=admin");
            return;
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Customer customer = CustomerDAO.getCustomerById(id);
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("admin/editCustomer.jsp").forward(request, response);
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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        if (session.getAttribute("admin") == null) {
            response.sendRedirect("AdminLoginServlet");
            return;
        }

        String action = request.getParameter("action");
        if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");

            CustomerDAO.updateCustomer(id, name, email, password, address, phone);
            response.sendRedirect("CustomerServlet?view=admin");
        }
    }
}
