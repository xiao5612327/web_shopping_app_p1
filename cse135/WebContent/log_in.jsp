<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ page import="cse135.*" %>
<%@ page import="java.io.*,java.util.*" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Log In</h1>
	<form method="get">
		Username <input type='text' name='user_name' maxlength=20 size=25>
		<br> <INPUT TYPE=SUBMIT VALUE="Log in">
	</form>
	<a href="sign_up.html">sign up</a>
	
	<%
		String user = request.getParameter("user_name");
		connectJDBC get_user = new connectJDBC();
		Boolean userName = get_user.getUsername(user);
		
		if(!userName){ 
			if(user == null){
				
			}else{%>
			<br>
				user name does not exist;
			<% }	
	
		}
		else{%>
			<script type="text/javascript">
            window.location.href = "home_page.jsp";
        	</script>
		<% }
			
	%>
</body>
</html>