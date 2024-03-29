<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ page import="cse135.*" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>shopping_cart</title>
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

		if ( user == null || user.trim().length() == 0 || roles.equals("null") || session.getAttribute("user_id") == null ){
		%>
			<SCRIPT TYPE="text/javascript">
			alert("Not signed in!");
			window.location.href = "log_in.jsp"
			</SCRIPT>
		<%}
	%>
	
	<br>
	<h1>Welcome: <%=user%></h1>
	<form action="log_in.jsp" method="post">
		<INPUT TYPE=SUBMIT VALUE="Log out">
	</form>
    <tr>     
        <td>
		<%@ page import="java.sql.*"%>

        <H1>Products Shopping Cart</H1>

        <% 
        	Class.forName("org.postgresql.Driver");
            Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5433/shopping", "postgres", "Asdf!23");  
            Statement statement = connection.createStatement() ;
            ResultSet resultset; 
        %>

        <%-- -------- Product Table -------- --%>
		<%
		resultset = statement.executeQuery("select * from shopping_cart where user_id = '" +(int)session.getAttribute("user_id") + "'") ; 
        %>
        <!-- html table format -->
            <table border="2">
            <tr>                
            	<th>Name</th>
            	<th>Amount</th>
                <th>Price</th>
                <th>Total Price</th>
   
            </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                //loop to display the table
                int total_price = 0;
            	int total_amount = 0;
            	int total_unit_price = 0;
                while (resultset.next()) {
                	
                	String amount = resultset.getString("amount");
                	String price = resultset.getString("price");
                	if(amount != null && amount.trim().length() != 0 && price != null && price.trim().length() != 0){
                		try{
                			total_amount += Integer.parseInt(amount);
                			total_unit_price += Integer.parseInt(price);
                			total_price += (Integer.parseInt(amount) * Integer.parseInt(price));
                		}catch(Exception e){
                			
                		}
                	}
            %>

            <tr>
                <form action="product_order.jsp" method="POST">

                <%-- a id to track all insert delete and update --%>
                <td>
                    <%=resultset.getString("name")%>
                </td>
                
                <td>
                    <%=resultset.getString("amount")%>
                </td>
                
                <td>
                    <%=resultset.getString("price")%>
                </td>

				<td></td>
                </form>
            </tr>

            <%
                }
            %>
            
            <tr>
            					<td>Total</td>
            					<td><%=total_amount%></td>
            					<td><%=total_unit_price%></td>
            					<td><%=total_price%></td>
            	
            </tr>
        </td>
    </tr>
</table>

<form name="myForm" action="confirmation.jsp" onsubmit="return validateForm()" method="post">
	Enter Your Credit Card Number here:
	<br>
	<input type='text' name='credit_card' maxlength=20 size=35>
		<SCRIPT TYPE="text/javascript">
		function validateForm() {
			var x = document.forms["myForm"]["credit_card"].value;
			if(x == null || x == "") {
				alert("Enter a valid credit card number.");
				return false;
			}
			if (Number(x) === parseInt(x, 10))
			{
			    return true;
			}
			else{
			    alert("Enter a valid credit card number.")
			    return false;
			}
		}
		</script>			
	<INPUT TYPE=SUBMIT VALUE="Purchase">
</form>
	
</body>
</html>