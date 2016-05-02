<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<body>
	<table>

	<%
		String user = (String) session.getAttribute("user_name");

	%>
	<br>
	<h1>Welcome: <%=user%></h1>
	
    <tr>     
        <td>
		<%@ page import="java.sql.*"%>

        <H1>Products Bought:</H1>

        <% 
        	Class.forName("org.postgresql.Driver");
            Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5433/shopping", "postgres", "Asdf!23");  
            Statement statement = connection.createStatement() ;
            Statement statement2 = connection.createStatement() ;
            Statement statement3 = connection.createStatement() ;
            Statement statement4 = connection.createStatement() ;

            ResultSet resultset; 
        	ResultSet product_ID; 
        	ResultSet user_ID; 

        %>

        <%-- -------- Product Table -------- --%>
		<%
			resultset = statement.executeQuery("select * from shopping_cart") ; 
        %>
        <!-- html table format -->
            <table border="1">
            <tr>                
            	<th>Name</th>
   
            </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                //loop to display the table
                while (resultset.next()) {
                	java.util.Date date = new java.util.Date();
                	
                	PreparedStatement stmt;
                	String name = resultset.getString("name");
                	String amount = resultset.getString("amount");
                	String price = resultset.getString("price");
					product_ID = statement2.executeQuery("select id from products where product_name = '"+name+"'");
					product_ID.next();
					user_ID = statement3.executeQuery("select id from users where user_name = '"+user+"'");
					user_ID.next();
				
					
					connection.setAutoCommit(false);
					
					stmt = connection.prepareStatement("insert into history (data, amount, price, product_id, user_name)"+
                			" values (? , ?, ?, ?, ?)");
					stmt.setString(1, date.toString());
					stmt.setInt(2, Integer.parseInt(amount));
					stmt.setInt(3, Integer.parseInt(price));
					stmt.setInt(4, Integer.parseInt(product_ID.getString("id")));
					stmt.setInt(5, Integer.parseInt(user_ID.getString("id")));
					
					 int rowCount = stmt.executeUpdate();
	                 
					 connection.commit();
	                 connection.setAutoCommit(true);
            %>

            <tr>
                <form action="product_order.jsp" method="POST">

                <%-- a id to track all insert delete and update --%>
                <td>
                    <%=resultset.getString("name")%>
                </td>

                </form>
            </tr>

            <%
                }
            connection.setAutoCommit(false);
        	PreparedStatement stmt1;

			stmt1 = connection.prepareStatement("TRUNCATE TABLE shopping_cart");

			
			 int rowCount = stmt1.executeUpdate();
             
			 connection.commit();
             connection.setAutoCommit(true);

            %>
        </td>
    </tr>
</table>
</body>
<br>
<a href="product_browsing.jsp" >Product Browsing</a>

</html>