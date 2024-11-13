import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class App {

    public static void main(String[] args) throws SQLException {
        String host = "jdbc:mysql://localhost:3306/";
        String dbName = "StoreFront";
        String mysqlURL = host + dbName;
        String userId = "root";
        String password = "root";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException cnfe) {
            System.out.println("Error loading driver: " + cnfe);
        }

        Connection connection = DriverManager.getConnection(mysqlURL, userId, password);
        // String query = "insert into Persons (PersonID, LastName, FirstName, Address, City)"
        //         + " values (1111, 'Sharma', 'Lokesh', 'Jaipur', 'Jaipur')";
        String query = "select * from Product";
        Statement stmt = connection.createStatement();
        ResultSet result = stmt.executeQuery(query);

        while(result.next()){
            System.out.println(result.getInt(1) + " " + result.getString(2) + " "
            + result.getString(3) + " " + result.getString(4));
        }

    }
}
