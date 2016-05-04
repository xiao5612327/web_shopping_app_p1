<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<HTML>
    <HEAD>
    	<%@ page import="cse135.*" %>
        <TITLE>Products</TITLE>
    </HEAD>

    <BODY>
    
  	<SCRIPT TYPE="text/javascript">
	function invalidName()
	{
		alert("Invalid product name.");
	}
	</SCRIPT>
	
	<SCRIPT TYPE="text/javascript">
	function invalidSKU()
	{
		alert("Not a unique product SKU.");
	}
	</SCRIPT>
	
	<SCRIPT TYPE="text/javascript">
	function invalidCategory()
	{
		alert("No product category provided.");
	}
	</SCRIPT>
	
	<SCRIPT TYPE="text/javascript">
	function invalidPrice()
	{
		alert("Invalid product price.");
	}
	</SCRIPT>
	
	<SCRIPT TYPE="text/javascript">
	function inserted()
	{
		alert("Inserted new product.");
	}
	</SCRIPT>

<table>
    <tr>
        <td valign="top">
            <%-- -------- import page from home page -------- --%>
            <jsp:include page="ower_home_page.jsp" />
       
            <%-- -------- List of categories for saerch ------- --%>
            <%@ page import="java.sql.*"%>
            
            <% 
	        	Class.forName("org.postgresql.Driver");
	            Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5433/shopping", "postgres", "Asdf!23");  
	            Statement statement = connection.createStatement() ;
	            PreparedStatement pstmt = null;
	            ResultSet resultset; 
	       	%>
	       	
	       	<%	
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
					<form action="product.jsp" method="get">
						<input type="submit" value="<%= categories[index-1] %>"  style="width:200px">
						<% if (request.getParameter("search") == null) { %>
								<input type="hidden" name="search" value=""/>
						<% }
						   else { %>
						   		<input type="hidden" name="search" value="<%=request.getParameter("search")%>"/>
						<% } %>
						<input type="hidden" name='category' value="<%= categories[index-1] %>">
						
					</form>
			<% } %>
					<form action="product.jsp" method="get">
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
				

		
        <H1>Products</H1>

        <%-- -------- INSERT category -------- --%>
            <%
                String action = request.getParameter("action");
                
            	//do insert if insert called
                if (action != null && action.equals("insert")) {

                	//begin communicate with database
                    connection.setAutoCommit(false);
                	
                	// Do parameter checks
                	String insertName = request.getParameter("product_name");
					String insertSku = request.getParameter("product_sku");
					String insertCategory = request.getParameter("product_category");
					String insertPrice = request.getParameter("product_price");

					connectJDBC conn = new connectJDBC();
					int priceInt = -1;
					if ( insertPrice == null || insertPrice.trim().length() == 0 || !conn.checkInt(insertPrice)) {}
					else priceInt = Integer.parseInt(insertPrice);
					
					// Check product name
					// Check if valid name
					if ( insertName == null || insertName.trim().length() == 0 )
					{ %>
						<script> invalidName(); </script>
					<% }
					// Check if SKU isn't unique
					else if ( insertSku == null || insertSku.trim().length() == 0 || !conn.checkSKU(insertSku))
					{ %>
						<script> invalidSKU(); </script>
					<% }
					
					// Check if category wasn't provided
					else if ( insertCategory == null || insertCategory.trim().length() == 0 || insertCategory.equals(" "))
					{ %>
						<script> invalidCategory(); </script>
					<% }
					
					// Check if price is positive
					else if ( insertPrice == null || insertPrice.trim().length() == 0 || priceInt < 0)
					{ %>
						<script> invalidPrice(); </script>
					<% }
					
					else
					{
	                    // insert into category table
	                    pstmt = connection.prepareStatement("INSERT INTO products ( product_name, sku, price, category_id) VALUES (?,?,?,?)");
	                    		
	                    pstmt.setString(1, request.getParameter("product_name"));
	                    pstmt.setInt(2, Integer.parseInt(request.getParameter("product_sku")));
	                    pstmt.setInt(3, Integer.parseInt(request.getParameter("product_price")));
	                    String temp = (String)session.getAttribute(request.getParameter("product_category"));
	                    int ca_id = Integer.parseInt(temp);
	                    pstmt.setInt(4, ca_id);
	
	                    int row = pstmt.executeUpdate();
	 
	                    //end communicate with database
	                    connection.commit();
	                    connection.setAutoCommit(true);
	                    %> <script> inserted(); </script> <%
					}
                    
                }
            %>
		
		<%-- -------- UPDATE category -------- --%>
        <%
            // update is called
            if (action != null && action.equals("update")) {

            	// Begin communicate with database
                connection.setAutoCommit(false);

                // updata sql 
                pstmt = connection.prepareStatement("UPDATE products SET product_name = ?, sku = ?, price = ?, category_id = ? WHERE id=?");

                PreparedStatement pstmtShoppingCart = null;
                PreparedStatement pstmtHistory = null;
                
                pstmtHistory = connection.prepareStatement("UPDATE history SET data = ?, price = ? WHERE id=?");
                pstmtShoppingCart = connection.prepareStatement("UPDATE shopping_cart SET name = ?, price = ? WHERE id=?");


                pstmtHistory.setString(1, request.getParameter("updated_name"));
                pstmtHistory.setInt(2, Integer.parseInt(request.getParameter("updated_price")));
                pstmtHistory.setInt(3, Integer.parseInt(request.getParameter("id")));
                
                pstmtShoppingCart.setString(1, request.getParameter("updated_name"));
                pstmtShoppingCart.setInt(2, Integer.parseInt(request.getParameter("updated_price")));
                pstmtShoppingCart.setInt(3, Integer.parseInt(request.getParameter("id")));
                
                
                pstmt.setString(1, request.getParameter("updated_name"));
                pstmt.setInt(2, Integer.parseInt(request.getParameter("updated_sku")));
                pstmt.setInt(3, Integer.parseInt(request.getParameter("updated_price")));
                String temp1 = (String)session.getAttribute(request.getParameter("updated_category"));
                int ca_id = Integer.parseInt(temp1);
                pstmt.setInt(4, ca_id);
                pstmt.setInt(5, Integer.parseInt(request.getParameter("id")));
                int row = pstmt.executeUpdate();
                int rowShoppingCart = pstmtShoppingCart.executeUpdate();
                int rowHistory = pstmtHistory.executeUpdate();
                  
                // Commit communicate with database
                connection.commit();
                connection.setAutoCommit(true);
            }
        %>
            
        <%-- -------- DELETE catagory -------- --%>
        <%
            // Check if a delete is requested
            if (action != null && action.equals("delete")) {

                // Begin communicate with database
                connection.setAutoCommit(false);
                PreparedStatement pstmtShoppingCart = null;
                PreparedStatement pstmtHistory = null;
                
                pstmt = connection.prepareStatement("DELETE FROM products WHERE id = ?");
                pstmtHistory = connection.prepareStatement("DELETE FROM history WHERE id = ?");
                pstmtShoppingCart = connection.prepareStatement("DELETE FROM shopping_cart WHERE id = ?");

                pstmt.setInt(1, Integer.parseInt(request.getParameter("id")));
                pstmtHistory.setInt(1, Integer.parseInt(request.getParameter("id")));
                pstmtShoppingCart.setInt(1, Integer.parseInt(request.getParameter("id")));

                int rowHistory = pstmtHistory.executeUpdate();
                int rowShoppingCart = pstmtShoppingCart.executeUpdate();
                int row = pstmt.executeUpdate();


                // Commit communicate with database
                connection.commit();
                connection.setAutoCommit(true);
            }
        %>
            
		<%-- -------- Product Insert -------- --%>
		<H2>Product Insert</H2>
		<form action="product.jsp" method="post">
            <input type="hidden" name="action" value="insert"/>
			<br> Product name: <input type='text' name='product_name'>
			<br> Product SKU: <input type='text' name='product_sku'>
			<br> Category: <select name='product_category'>
					<option value=' '> </option>
					<% 	index = 0;
						while(index < rowCount){ 
							index++;
					%>
						<option value='<%= categories[index-1] %>'> <%= categories[index-1] %> </option>
					<% } %>
				</select>
			<br> Product price: <input type='text' name='product_price'>
			<% if (request.getParameter("search") == null) { %>
						<input type="hidden" name="search" value=""/>
			<% }
			   else { %>
					<input type="hidden" name="search" value="<%=request.getParameter("search")%>"/>
			<% } %>
			<% if (request.getParameter("category") == null) { %>
					<input type="hidden" name="category" value=""/>
			<% }
			   else { %>
			   		<input type="hidden" name="category" value="<%=request.getParameter("category")%>"/>
			<% } %>
			<input type="submit" value="Insert New Product">
		</form>
		
		<%-- -------- Product Search -------- --%>
		<h2>Product Search</h2>
		<form action="product.jsp" method="get">
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
                <form action="product.jsp" method="POST">
                    <input type="hidden" name="action" value="update"/>
					<input type="hidden" name="id" value="<%=resultset.getInt("id")%>"/>
					<% if (request.getParameter("search") == null) { %>
								<input type="hidden" name="search" value=""/>
					<% }
					   else { %>
					   		<input type="hidden" name="search" value="<%=request.getParameter("search")%>"/>
					<% } %>
					<% if (request.getParameter("category") == null) { %>
							<input type="hidden" name="category" value=""/>
					<% }
					   else { %>
					   		<input type="hidden" name="category" value="<%=request.getParameter("category")%>"/>
					<% } %>
                <%-- a id to track all insert delete and update --%>
                <td>
                    <input value="<%=resultset.getString("product_name")%>" name="updated_name" size="15"/>
                </td>
                
                <td>
                    <input value="<%=resultset.getString("sku")%>" name="updated_sku" size="15"/>
                </td>
                
                <td>
                	<select name='updated_category'>
                		<% 
                			String cate_id = resultset.getString("category_id");
                			String default_category = (String)session.getAttribute(cate_id); %>
						<option selected=<%=default_category%>><%=default_category%></option>
					<% 	index = 0;
						while(index < rowCount){ 
							index++;
							
							if(categories[index-1].equals(default_category))
								continue;
					%>
						<option value='<%= categories[index-1] %>'> <%= categories[index-1] %> </option>
					<% } %>
					</select>
                </td>
                
                <td>
                    <input value="<%=resultset.getString("price")%>" name="updated_price" size="15"/>
                </td>


                <td><input type="submit" value="Update"></td>
                </form>
                
                <form action="product.jsp" method="POST">
                    <input type="hidden" name="action" value="delete"/>
					<input type="hidden" name="id" value="<%=resultset.getInt("id")%>"/>
					<% if (request.getParameter("search") == null) { %>
								<input type="hidden" name="search" value=""/>
					<% }
					   else { %>
					   		<input type="hidden" name="search" value="<%=request.getParameter("search")%>"/>
					<% } %>
					<% if (request.getParameter("category") == null) { %>
							<input type="hidden" name="category" value=""/>
					<% }
					   else { %>
					   		<input type="hidden" name="category" value="<%=request.getParameter("category")%>"/>
					<% } %>
                    <%-- Button --%>
                <td><input type="submit" value="Delete"/></td>
                </form>
            </tr>

            <%
                }
            %>
        
        </td>
    </tr>
</table>
    </BODY>
</HTML>