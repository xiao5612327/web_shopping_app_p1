<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Products Browsing</title>
</head>
<body>
<table>
	<%
		session.setAttribute("product_name", null);
		String user = (String) session.getAttribute("user_name");
		String roles = (String) session.getAttribute("roles");

		if(user == null){%>
			<SCRIPT TYPE="text/javascript">
			alert("Request is invalid!");
			window.location.href = "log_in.jsp"
			</SCRIPT>
		<%}
		
	%>
	<a href="shopping_cart.jsp" >Buy Shopping Cart</a>
	<br>
	<h1>Welcome: <%=roles%> <%=user%></h1>
	
	<form action="log_in.jsp" method="post">
		<% session.setAttribute("user_name" , null);%>
		<INPUT TYPE=SUBMIT VALUE="Log out">
	</form>

    <tr>     
        <td>
		<%@ page import="java.sql.*"%>
		<% 
	        	Class.forName("org.postgresql.Driver");
	            Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5433/shopping", "postgres", "Asdf!23");  
	            Statement statement = connection.createStatement() ;
	            PreparedStatement pstmt = null;
	            ResultSet resultset; 
	            
	       	%>
	       	
	       	<%	
	       		resultset = statement.executeQuery("select * from users where user_name = '" + user + "'");
	       		if(resultset.next()){
	       	
	       			session.setAttribute("user_id", resultset.getInt("id"));
	       		}
	       		resultset = statement.executeQuery("select count(*) from categories") ;
				resultset.next();
				int rowCount = Integer.parseInt(resultset.getString(1));
				String[] categories = new String[rowCount];
				resultset = statement.executeQuery("select * from categories") ;
			%>
			

			<% 	
				int index = 0;
				String cat_id = "";
				while(resultset.next()){ 
					categories[index] = resultset.getString("category_name");
					cat_id = Integer.toString(resultset.getInt("id"));
					session.setAttribute(cat_id, categories[index]);
					session.setAttribute(categories[index], cat_id);

					index++;
				}
			%>
        
        	<h2>Search categories</h2>
            <% 	
            	index = 0;
				while(index < rowCount){ 
					index++;
			%>
					<form action="product_browsing.jsp" method="get">
						<input type="submit" value="<%= categories[index-1] %>" style="width:200px">
						<% if (request.getParameter("search") == null) { %>
								<input type="hidden" name="search" value=""/>
						<% }
						   else { %>
						   		<input type="hidden" name="search" value="<%=request.getParameter("search")%>"/>
						<% } %>
						<input type="hidden" name='category' value="<%= categories[index-1] %>">
						
					</form>
			<% } %>
					<form action="product_browsing.jsp" method="get">
						<input type="submit" value="All Categories" style="width:200px">
						<% if (request.getParameter("search") == null) { %>
								<input type="hidden" name="search" value=""/>
						<% }
						   else { %>
						   		<input type="hidden" name="search" value="<%=request.getParameter("search")%>"/>
						<% } %>
						<input type="hidden" name='category' value="">
						
					</form>
        </td>
       <td>

		
        <H1>Products Browsing</H1>
		
		
		<h2>Product Search</h2>
		<%    resultset = statement.executeQuery("select * from categories") ; %>
		<form action="product_browsing.jsp" method="post">
		  	<br> Search query: <input type='text' name='search'>
		  	<input type="submit" value="Search">
		</form>
        
        <%-- -------- Product Table -------- --%>
		<%
			Statement ps = null;
        	ResultSet rs; 
			String search = request.getParameter("search");
			String category;
			category = request.getParameter("category");
			ps= connection.createStatement() ;
			rs = ps.executeQuery("select * from categories where category_name = '"+category +"'" ); 
			
			if (category == null || category.equals(" ")){
		    	resultset = statement.executeQuery("select * from products where LOWER(product_name) like LOWER('%"+search+"%')"); 
			}else{

				if(rs.next()){
					resultset = statement.executeQuery("select * from products where LOWER(product_name) like LOWER('%"+search+"%') and category_id = '"+rs.getInt("id")+"'"); 
				}else{
					resultset = statement.executeQuery("select * from products"); 

				}
			}
        %>
        <!-- html table format -->
            <table border="1">
            <tr>                
            	<th>Name</th>
            	<th>SKU</th>
                <th>Category</th>
                <th>Price</th>
   
            </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                //loop to display the table
                while (resultset.next()) {
            %>

            <tr>
                <form action="product_order.jsp" method="POST">
                    <input type="hidden" name="action" value="update"/>

                <%-- a id to track all insert delete and update --%>
                <td>
                    <input value="<%=resultset.getString("product_name")%>" name="updated_name" size="15"/>
                </td>
                
                <td>
                    <input value="<%=resultset.getString("sku")%>" name="updated_sku" size="15"/>
                </td>
                
                <td>
                	<input value="<%=(String)session.getAttribute(resultset.getString("category_id")) %>" name="updated_category" size="15"/>
                </td>
                
                <td>
                    <input value="<%=resultset.getString("price")%>" name="updated_price" size="15"/>
                </td>
	

                <td><input type="submit" value="Buy"></td>
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