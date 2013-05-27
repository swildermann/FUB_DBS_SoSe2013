import java.sql.*;

public class SQLTest {
   // JDBC driver name and database URL
   static final String JDBC_DRIVER = "org.postgresql.Driver";  
   static final String DB_URL = "jdbc:postgresql://localhost/uni";

   //  Database credentials
   static final String USER = "jdbc";
   static final String PASS = "dbs2013";
   
   public static void main(String[] args) {
	   Connection conn = null;
	   Statement stmt = null;
	   try{
	      //STEP 2: Register JDBC driver
	      Class.forName("org.postgresql.Driver");
	
	      //STEP 3: Open a connection
	      System.out.println("Connecting to database...");
	      conn = DriverManager.getConnection(DB_URL,USER,PASS);
	
	      //STEP 4: Execute a query
	      System.out.println("Creating statement...");
	      stmt = conn.createStatement();
	      String sql;
	      sql = "SELECT * FROM zettel";
	      ResultSet rs = stmt.executeQuery(sql);
	
	      //STEP 5: Extract data from result set
	      while(rs.next()){
	         //Retrieve by column name
	         int id  = rs.getInt("zettel_id");
	         String modul = rs.getString("modul");
	         int nr = rs.getInt("zettel_nr");
	         String erreichte_pkt = rs.getString("erreichte_pkt");
	
	         //Display values
	         System.out.print("ID: " + id);
	         System.out.print(", Modul: " + modul);
	         System.out.print(", Zettel-Nr.: " + nr);
	         System.out.println(", Erreichte Punkte: " + erreichte_pkt);
	      }
	      //STEP 6: Clean-up environment
	      rs.close();
	      stmt.close();
	      conn.close();
	   } catch (SQLException se){
	      //Handle errors for JDBC
	      se.printStackTrace();
	   } catch (Exception e){
	      //Handle errors for Class.forName
	      e.printStackTrace();
	   }finally{
	      //finally block used to close resources
	      try{
	         if(stmt!=null)
	            stmt.close();
	      } catch (SQLException se2){
	   }// nothing we can do
	   try{
		   if(conn!=null)
			   conn.close();
		   } catch (SQLException se){
	         se.printStackTrace();
	      }//end finally try
	   }//end try
	   System.out.println("Goodbye!");
	}//end main
}//end SQLTest