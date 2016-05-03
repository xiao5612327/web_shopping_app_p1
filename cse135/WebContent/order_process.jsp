<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@page import="java.util.*, cse135.*" %>
<%@ page import="java.sql.*"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>order_process</title>
</head>
<body>
	<SCRIPT TYPE="text/javascript">
	function invalidAmount()
	{
		alert("Invalid Amount, you must choose at least 1.");
	}
	</SCRIPT>
	<% 
		String quantity = request.getParameter("amount");
		String product = (String)session.getAttribute("product_name");
		String price = (String)session.getAttribute("product_price");
		connectJDBC conn = new connectJDBC();
		if ( quantity == null || quantity.trim().length() == 0 )
		{ %>
			<script> invalidAmount(); </script>
			<script language="javascript">
   				window.location.href = "product_browsing.jsp"
			</script>
		<% }
		else{
			if(!conn.checkInt(quantity)){
				 %>
					<script> invalidAmount(); </script>
					<script language="javascript">
		   				window.location.href = "product_browsing.jsp"
					</script>
				<%
			}
			else{
				
	        	Class.forName("org.postgresql.Driver");
	            Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/shopping", "postgres", "Asdf!23");  
	            Statement statement = connection.createStatement() ;
	            ResultSet resultset; 
	            int amount = 0;
	        	
	            connection.setAutoCommit(false);

                  
                // Commit communicate with database
                connection.commit();
                connection.setAutoCommit(true);
	            //check if shopping have item already
	            resultset = statement.executeQuery("select * from shopping_cart where name = '" + product + "' and user_id = '"
        				+session.getAttribute("user_id") + "'");
	            if(resultset.next()){
	            	amount = resultset.getInt("amount");
	            	amount += Integer.parseInt(quantity);
	            	statement.execute("update shopping_cart SET amount = '" + amount + "' where name = '"+ product + "' and user_id = '"
	            				+session.getAttribute("user_id") + "'");
	            	
	            }else{
					int user = (int)session.getAttribute("user_id");
					conn.insertShopping(product, quantity, price, user);
	            }
			}	
		}
		
	%>
	<script language="javascript">
   		window.location.href = "product_browsing.jsp"
	</script>
</body>
</html>