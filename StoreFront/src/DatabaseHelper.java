import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseHelper {
 
    private static final String URL = "jdbc:mysql://localhost:3306/StoreFront";
    private static final String userId = "root";
    private static final String password = "root";

    public static Connection getConnection() throws SQLException{
        return DriverManager.getConnection(URL, userId, password);
    }

    // connection closing
    public static void closeConnection(Connection conn){
        if(conn != null){
            try {
                conn.close();
            } catch (SQLException e) {
                e.getMessage();
            }
        }
    }
}
