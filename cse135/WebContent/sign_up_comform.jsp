<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ page import="cse135.*" %>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Comformation</title>
</head>
<body>
	<%
		String out_put_result = null;
		Boolean userName = true;
		String user = request.getParameter("user_name");
		//if(user.length() > 0){
			//userName = true;
		//}else
			//userName = false;

		Boolean ageRange = true;
		String age = request.getParameter("age");
		//if(age.length() >0){
		//	ageRange = true;
		//}
		//else
			//ageRange =false;
		
		if(ageRange == true && userName == true){
			
			out_put_result = "You have successfully signed up.";
			String state = request.getParameter("state");
			String roles = request.getParameter("role");

			connectJDBC input_user= new connectJDBC();
	 		input_user.submit(user, roles, age, state);
		}
		else{
			if(userName == false){
				out_put_result ="Your signup failed.\n name was not provided.";
			}else
				out_put_result ="Your signup failed.\n age is not real.";
		}
	%>
	<%=out_put_result%>
	<br>
	<a href="log_in.jsp">Back to Log in</a>


</body>
</html>