package listener;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebListener;
import java.io.*;
import java.nio.file.*;
import java.util.logging.*;

@WebListener
public class ImageInitListener implements ServletContextListener {
    
    private static final Logger logger = Logger.getLogger(ImageInitListener.class.getName());
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        String deploymentPath = context.getRealPath("/assets");
        
        // Try to find the permanent project source directory
        String projectRoot = System.getProperty("user.dir");
        String permanentImagePath = projectRoot + File.separator + "web" + File.separator + "assets";
        
        logger.info("Application starting - initializing product images in /assets");
        
        try {
            // Create deployment directory if it doesn't exist
            File deploymentDir = new File(deploymentPath);
            if (!deploymentDir.exists()) {
                deploymentDir.mkdirs();
                logger.info("Created deployment image directory: " + deploymentPath);
            }
            
            File permanentDir = new File(permanentImagePath);
            if (!permanentDir.exists()) {
                logger.warning("Permanent image directory not found: " + permanentImagePath);
                return; // Nothing to copy
            }
            
            // Copy all images from permanent to deployment directory
            File[] imageFiles = permanentDir.listFiles();
            if (imageFiles != null) {
                int count = 0;
                for (File imageFile : imageFiles) {
                    if (imageFile.isFile()) {
                        Path source = imageFile.toPath();
                        Path destination = Paths.get(deploymentPath, imageFile.getName());
                        Files.copy(source, destination, StandardCopyOption.REPLACE_EXISTING);
                        count++;
                    }
                }
                logger.info("Successfully copied " + count + " product images to deployment directory");
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error initializing product images", e);
        }
    }
    
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Nothing to do when application shuts down
    }
}