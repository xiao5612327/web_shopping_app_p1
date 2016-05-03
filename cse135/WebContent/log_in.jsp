<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ page import="cse135.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>log_in</title>
</head>
<body>
	<h1>Log In</h1>
	<form>
		Username:
		<input type='text' name='user_name' maxlength=20 size=25>
		<br> 
		<INPUT TYPE=SUBMIT VALUE="Log in">
	</form>
	<a href="sign_up.html">sign up</a>
	
	<%! public String checkEmpty(String name){
			String message = null;
			if(name == null)
				message = "please enter user name!";
			return message;
	}%>
	
	<%
		String user = request.getParameter("user_name");
		User getUser = new User();
		connectJDBC get_user = new connectJDBC();
		Boolean userName = get_user.getUsername(user, getUser);
		if(!userName){ 
			if(user == null){
				
			}else{%>
			<br>
				<h4 style="color:red">The provided name <%=user %> is not known.</h4>
			<% }	
	
		}
		else{
			session.setAttribute("user_name", user);
			session.setAttribute("roles", getUser.getRoles());
			session.setAttribute("shopping_list_count", 0);
			%>
			<script type="text/javascript">
			
            window.location.href = "ower_home_page.jsp";
        	</script>
		<% }
			
	%>
</body>
</html>