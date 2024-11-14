import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoryService {
    public List<Category> getTopParentCategories() {
        List<Category> categories = new ArrayList<>();

        String query = "SELECT c1.CategoryName, COUNT(c2.CategoryID) AS ChildCount " +
                       "FROM Category c1 " +
                       "LEFT JOIN Category c2 ON c2.ParentCategoryID = c1.CategoryID " +
                       "WHERE c1.ParentCategoryID IS NULL " +
                       "GROUP BY c1.CategoryID, c1.CategoryName " +
                       "ORDER BY c1.CategoryName ASC";


          try (Connection conn = DatabaseHelper.getConnection();
                PreparedStatement ps = conn.prepareStatement(query)) {
               ResultSet rs = ps.executeQuery();
               while(rs.next()){
                Category category = new Category();
                category.setTitle(rs.getString("CategoryName"));
                category.setChildCount(rs.getInt("ChildCount"));
                categories.add(category);
               }

        } catch (Exception e) {
            e.getMessage();
        }     
        
        return categories;
    }
}
