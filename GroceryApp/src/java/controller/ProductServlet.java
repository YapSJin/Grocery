/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import dao.ProductDAO;
import model.Product;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;

/**
 *
 * @author sengy
 */
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
    maxFileSize = 1024 * 1024 * 10,      // 10 MB
    maxRequestSize = 1024 * 1024 * 100   // 100 MB
)
public class ProductServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        ProductDAO.checkAndAddImageColumn();
    }

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
            out.println("<title>Servlet ProductServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductServlet at " + request.getContextPath() + "</h1>");
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

        try {
            String action = request.getParameter("action");

            if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                ProductDAO.deleteProduct(id);
                response.sendRedirect(request.getContextPath() + "/ProductServlet?view=admin&deleted=1");
                return;
            }

            if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Product product = ProductDAO.getProductById(id);

                if (product == null) {
                    response.sendRedirect(request.getContextPath() + "/ProductServlet?view=admin&notfound=1");
                    return;
                }

                request.setAttribute("product", product);
                request.getRequestDispatcher("admin/editProduct.jsp").forward(request, response);
                return;
            }

            String keyword = request.getParameter("keyword");

            List<Product> products;

            if (keyword != null && !keyword.isEmpty()) {
                products = ProductDAO.searchProducts(keyword);  // 🔥 search
            } else {
                products = ProductDAO.getAllProducts();         // 🔥 default
            }

            request.setAttribute("products", products);

            // 🔥 IMPORTANT: decide which page
            String view = request.getParameter("view");

            if ("admin".equals(view)) {
                request.getRequestDispatcher("admin/productList.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("products.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
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

        // Ensure database column exists
        ProductDAO.checkAndAddImageColumn();

        try {
            String action = request.getParameter("action");

            String name = request.getParameter("name");
            String priceStr = request.getParameter("price");
            String stockStr = request.getParameter("stock");
            String description = request.getParameter("description");

            if (priceStr == null || stockStr == null) {
                throw new ServletException("Missing required parameters");
            }

            double price = Double.parseDouble(priceStr);
            int stock = Integer.parseInt(stockStr);

            if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String existingImage = request.getParameter("existingImage");
                String imagePath = existingImage;

                Part part = request.getPart("image");
                if (part != null && part.getSize() > 0) {
                    String fileName = getFileName(part);
                    if (fileName != null && !fileName.isEmpty()) {
                        imagePath = saveProductImage(part, fileName);
                    }
                }

                ProductDAO.updateProduct(id, name, price, stock, description, imagePath);
                response.sendRedirect(request.getContextPath() + "/ProductServlet?view=admin&updated=1");
                return;
            }

            if (name == null) {
                throw new ServletException("Missing required parameters");
            }

            // Image upload handling
            Part part = request.getPart("image");
            String imagePath = "";
            
            if (part != null && part.getSize() > 0) {
                String fileName = getFileName(part);
                if (fileName != null && !fileName.isEmpty()) {
                    imagePath = saveProductImage(part, fileName);
                }
            }

            ProductDAO.addProduct(name, price, stock, description, imagePath);
            // Redirect back with success message
            response.sendRedirect(request.getContextPath() + "/ProductServlet?view=admin&success=1");
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }

    private String saveProductImage(Part part, String fileName) throws IOException {
        // 1. Save to Deployment Directory (Immediate visibility)
        String uploadPath = getServletContext().getRealPath("/assets");
        if (uploadPath == null) {
            uploadPath = getServletContext().getRealPath("") + File.separator + "assets";
        }

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
        File fileToSave = new File(uploadDir, uniqueFileName);

        try (InputStream input = part.getInputStream()) {
            Files.copy(input, fileToSave.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }

        // 2. Try to save to Source Directory (Persistence across clean/build)
        try {
            String projectRoot = System.getProperty("user.dir");
            String permanentPath = projectRoot + File.separator + "web" + File.separator + "assets";
            File permanentDir = new File(permanentPath);
            if (permanentDir.exists() || permanentDir.mkdirs()) {
                File fileToPermanent = new File(permanentDir, uniqueFileName);
                Files.copy(fileToSave.toPath(), fileToPermanent.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }
        } catch (Exception e) {
            System.err.println("Could not save to permanent storage: " + e.getMessage());
        }

        return "assets/" + uniqueFileName;
    }

    private String getFileName(Part part) {
        if (part == null) return null;
        String contentDisp = part.getHeader("content-disposition");
        if (contentDisp == null) return null;
        
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                String name = s.substring(s.indexOf("=") + 2, s.length() - 1);
                // Fix for IE or paths in filename
                return new File(name).getName();
            }
        }
        return null;
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
