<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%@page import="java.util.*, cse135.*" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>product_order</title>
</head>
<body>
<table>
	<%
		
		String user = (String) session.getAttribute("user_name");
		String roles;
		if(session.getAttribute("roles") == null)
			roles = "null";
		else
			roles = (String) session.getAttribute("roles");

		if ( user == null || user.trim().length() == 0 || roles.equals("null") ){
		%>
			<SCRIPT TYPE="text/javascript">
			alert("Not signed in!");
			window.location.href = "log_in.jsp"
			</SCRIPT>
		<%}
	%>
	
	<%
		String product = request.getParameter("updated_name");
		session.setAttribute("product_name", product);
		session.setAttribute("product_price", request.getParameter("updated_price"));

	%>
	<a href="shopping_cart.jsp" >Buy Shopping Cart</a>
	<br>
	<h1>Welcome: <%=user%></h1>
	<form action="log_in.jsp" method="post">
		<INPUT TYPE=SUBMIT VALUE="Log out">
	</form>
    <tr>     
        <td>
		<%@ page import="java.sql.*"%>


        <% 
        	Class.forName("org.postgresql.Driver");
            Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5433/shopping", "postgres", "Asdf!23");  
            Statement statement = connection.createStatement() ;
            ResultSet resultset; 
        %>
	<form action="order_process.jsp" method="post">
	 	<p>Product Picked: <%=product%></p>
		<p>
			Amount: <input type="text" size="10" name="amount" />
		<p />
		<input type="submit" value="Click to Order" />
	
	</form>

	    <H1>Products Shopping Cart</H1>
        <%-- -------- Product Table -------- --%>
		<%

			resultset = statement.executeQuery("select * from shopping_cart where user_id = '" +(int)session.getAttribute("user_id") + "'") ; 
        %>
        <!-- html table format -->
            <table border="1">
            <tr>                
            	<th>Name</th>
            	<th>Amount</th>
                <th>Price</th>
   
            </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                //loop to display the table
                while (resultset.next()) {
            %>

            <tr>
                <form action="product_order.jsp" method="POST">

                <%-- a id to track all insert delete and update --%>
                <td>
                    <input value="<%=resultset.getString("name")%>" name="shopping_cart_name" size="15"/>
                </td>
                
                <td>
                    <input value="<%=resultset.getString("amount")%>" name="shopping_cart_amount" size="15"/>
                </td>
                
                <td>
                    <input value="<%=resultset.getString("price")%>" name="shopping_cart_price" size="15"/>
                </td>

                </form>
                
            </tr>

            <%
                }
            %>
        
        </td>
    </tr>
</table>
</body>
</html>