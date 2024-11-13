import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoryService {
    public List<Category> getTopParentCategories() {
        List<Category> categories = new ArrayList<>();

        String query = "SELECT c1.Title, COUNT(c2.Id) AS ChildCount " +
                       "FROM Categories c1 " +
                       "LEFT JOIN Categories c2 ON c2.ParentCategoryId = c1.Id " +
                       "WHERE c1.ParentCategoryId IS NULL " +
                       "GROUP BY c1.Id, c1.Title " +
                       "ORDER BY c1.Title ASC";


          try (Connection conn = DatabaseHelper.getConnection();
                PreparedStatement ps = conn.prepareStatement(query)) {
               ResultSet rs = ps.executeQuery();
               while(rs.next()){
                Category category = new Category();
                category.setTitle(rs.getString("Title"));
                category.setChildCount(rs.getInt("ChildCount"));
                categories.add(category);
               }

        } catch (Exception e) {
            e.getMessage();
        }     
        
        return categories;
    }
}
