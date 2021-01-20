<%@page import="test.users.dto.UserDto"%>
<%@page import="test.users.dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	// 폼 전송되는 가입할 회원 정보를 읽어온다.
	String id=request.getParameter("id");
	String pwd=request.getParameter("pwd");
	String email=request.getParameter("email");
	// UserDto 객체에 회원 정보를 담고
	UserDto dto=new UserDto();
	dto.setId(id);
	dto.setPwd(pwd);
	dto.setEmail(email);
	// UserDao 객체를 이용해서 DB에 저장한다.
	boolean isSuccess=UserDao.getInstance().insert(dto);
	// 결과를 응답하기
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/signup.jsp</title>
</head>
<body>
	<%if(isSuccess){ %>
		<script>
			alert("회원가입에 성공했습니다.");
			location.href="${pageContext.request.contextPath }/users/loginform.jsp";
		</script>
	<%}else{ %>
		<script>
			alert("회원가입에 실패 했습니다.");
			location.href="${pageContext.request.contextPath }/users/signup_form.jsp";
		</script>
	<%} %>
</body>
</html>