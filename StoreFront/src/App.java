import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

public class App {

    public static void main(String[] args) throws SQLException {

            
        OrderService orderService = new OrderService();
        ProductService productService = new ProductService();
        CategoryService categoryService = new CategoryService();

        int userID= 1;
        System.out.println("Fetching shipped orders for user with ID: "+ userID);
        List<Order> orders= orderService.getShippedOrders(userID);
        for (Order order : orders) {
            System.out.println("OrderID: "+ order.getId() + ", Date: " + order.getOrderDate() + ", TotalAmount: " + order.getOrderTotal());

        }


          // Assignment 2: Batch Insert Product Images
          int productId = 3; // Example product ID
          List<String> imageUrls = Arrays.asList(
              "http://example.com/image1.jpg",
              "http://example.com/image2.jpg",
              "http://example.com/image3.jpg",
              "http://example.com/image4.jpg",
              "http://example.com/image5.jpg"
          );
          List<String> altText = Arrays.asList(
              "altText1",
              "altText2",
              "altText3",
              "altText4",
              "altText5"
          );
          System.out.println("Inserting product images for product ID: " + productId);
          productService.insertProductImage(productId, imageUrls,altText);
          System.out.println("Product images inserted successfully.");
  
          // Assignment 3: Delete Old Products Not Ordered in the Last Year
          System.out.println("Deleting products not ordered in the last year...");
          int deletedCount = productService.deleteOldProducts();
          System.out.println("Number of products deleted: " + deletedCount);
  
          // Assignment 4: Display Parent Categories with Child Count
          System.out.println("Displaying top parent categories with child counts:");
          List<Category> categories = categoryService.getTopParentCategories();
          for (Category category : categories) {
              System.out.println("Category Title: " + category.getTitle() + ", Child Count: " + category.getChildCount());
    }
}
}
