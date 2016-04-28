package cse135;

import java.sql.*;

public class connectJDBC {
   public String submit(String a) throws SQLException {
	   
      Connection c = null;
      Statement pstmt = null;
      
      try {
         Class.forName("org.postgresql.Driver");
         c = DriverManager
            .getConnection("jdbc:postgresql://localhost:5433/shopping",
            "postgres", "Asdf!23");
      } catch (Exception e) {
         e.printStackTrace();
         System.err.println(e.getClass().getName()+": "+e.getMessage());
         System.exit(0);
      }

      System.out.println(a);
      pstmt = c.createStatement();
      try {
          //String query= "INSERT INTO student (name) VALUES (?,);";  

   //pstmt.executeUpdate(query);


          c.close();  
   }
   catch(Exception e) {
	   e.printStackTrace();}
	

     
   
   return "good";
   }
}