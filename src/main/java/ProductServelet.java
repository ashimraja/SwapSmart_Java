import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/products")
public class ProductServelet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Creating sample product data
        List<Product> products = new ArrayList<>();
        products.add(new Product(1, "Apple iPhone 14", "37,799", "iphone.jpg"));
        products.add(new Product(2, "Samsung Galaxy S22", "29,999", "iphone2.jpg"));

        // Manually build JSON string
        StringBuilder json = new StringBuilder();
        json.append("[");

        for (int i = 0; i < products.size(); i++) {
            Product product = products.get(i);
            json.append("{");
            json.append("\"id\":").append(product.getId()).append(",");
            json.append("\"name\":\"").append(product.getName()).append("\",");
            json.append("\"price\":\"").append(product.getPrice()).append("\",");
            json.append("\"image\":\"").append(product.getImage()).append("\"");
            json.append("}");

            if (i < products.size() - 1) {
                json.append(","); // Add comma between JSON objects
            }
        }

        json.append("]");

        // Send JSON response
        PrintWriter out = response.getWriter();
        out.write(json.toString());
        out.flush();
    }
}
//Product Class (A simple Java class to hold product details)
class Product {
 private int id;
 private String name;
 private String price;
 private String image;

 public Product(int id, String name, String price, String image) {
     this.id = id;
     this.name = name;
     this.price = price;
     this.image = image;
 }

 public int getId() { return id; }
 public String getName() { return name; }
 public String getPrice() { return price; }
 public String getImage() { return image; }
}