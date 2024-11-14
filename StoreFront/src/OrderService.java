import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class OrderService {

    public List<Order> getShippedOrders(int userId) {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT O.OrderID, O.OrderDate, O.TotalAmount FROM `Order` O INNER JOIN OrderItem OI  ON O.OrderID = OI.OrderID WHERE O.UserID = ? AND OI.Status = 'Shipped'  ORDER BY O.OrderDate ASC";

        try(Connection conn = DatabaseHelper.getConnection() ;
         PreparedStatement  ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                Order order = new Order();
                order.setId(rs.getInt("OrderID"));
                order.setOrderDate(rs.getDate("OrderDate"));
                order.setOrderTotal(rs.getDouble("TotalAmount"));
                orders.add(order);
            }
            
        } catch (Exception e) {
            e.getMessage();
        }

        return orders;
    }
}
