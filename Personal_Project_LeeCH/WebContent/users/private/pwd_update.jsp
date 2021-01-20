<%@page import="test.users.dao.UserDao"%>
<%@page import="test.users.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String id=(String)session.getAttribute("id");
	String newPwd=request.getParameter("newPwd");
	String pwd=request.getParameter("pwd");
	UserDto dto=new UserDto();
	dto.setId(id);
	dto.setPwd(pwd);
	dto.setNewPwd(newPwd);
	boolean isSuccess=UserDao.getInstance().updatePwd(dto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/private/pwd_update.jsp</title>
</head>
<body>
	<%if(isSuccess){
		session.removeAttribute("id");%>
		<script>
			alert("<%=id %>님의 비밀번호를 수정했습니다.\n다시 로그인 해주시기 바랍니다.");
			location.href="${pageContext.request.contextPath }/users/loginform.jsp";
		</script>
	<%} else{%>
		<script>
			alert("비밀번호 수정에 실패했습니다.");
			location.href="${pageContext.request.contextPath }/users/private/pwd_updateform.jsp";
		</script>
	<% }%>

</body>
</html>