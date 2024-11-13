import java.sql.Date;

public class Order {
 private int id;
 private Date orderDate;
 private double orderTotal;


 public void setId(int id) {
     this.id = id;
 }

 public void setOrderDate(Date orderDate) {
     this.orderDate = orderDate;
 }

 public void setOrderTotal(double orderTotal) {
     this.orderTotal = orderTotal;
 }

 public int getId() {
     return id;
 }
 public Date getOrderDate() {
     return orderDate;
 }
 public double getOrderTotal() {
     return orderTotal;
 }
}
