import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;

public class ProductService {
    public void insertProductImage(int productId, List<String> imageUrls, List<String> alttext) {
        String query = "INSERT  INTO Image (ProductID, ImageUrl, AltText) VALUES(?,?,?)";
        try (Connection conn = DatabaseHelper.getConnection();
                PreparedStatement ps = conn.prepareStatement(query)) {
            for (int i = 0; i < imageUrls.size(); i++) {
                ps.setInt(1, productId);
                ps.setString(2, imageUrls.get(i));
                ps.setString(3, alttext.get(i));
            }

            ps.executeBatch();
            System.out.println("Image inserted successfully for product ID: " + productId);

        } catch (Exception e) {
            e.getMessage();
        }
    }

    public int deleteOldProducts() {
        int deletedCount = 0;
        String query = "DELETE FROM Products " +

                "WHERE ProductId NOT IN (" +

                "    SELECT DISTINCT ProductId " +

                "    FROM OrderItems oi " +

                "    JOIN Orders o ON oi.OrderId = o.OrderId " +

                "    WHERE o.OrderDate > DATE_SUB(NOW(), INTERVAL 1 YEAR)" +

                ")";

                try (Connection conn = DatabaseHelper.getConnection();
                PreparedStatement ps = conn.prepareStatement(query)) {
                    deletedCount = ps.executeUpdate();
                    System.out.println(deletedCount + " products deleted successfully");

            
        } catch (Exception e) {
            e.getMessage();
        }

        return deletedCount;
    }
}
