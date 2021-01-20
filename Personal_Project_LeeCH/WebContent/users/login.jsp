<%@page import="test.users.dao.UserDao"%>
<%@page import="test.users.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	// 1. 폼전송되는 아이디와 비밀번호를 읽어온다.
	String id=request.getParameter("id");
	String pwd=request.getParameter("pwd");
	String url=request.getParameter("url");
	UserDto dto=new UserDto();
	dto.setId(id);
	dto.setPwd(pwd);
	// 2. DB에 실재로 존재하는 (유효한) 정보인지 확인한다.
	boolean isSuccess=UserDao.getInstance().isValid(dto);
	// 3. 유효한 정보이면 로그인 처리를 하고 응답 그렇지 않으면 아이디 혹은 비밀번호가 틀렸다고 응답
	//체크박스를 체크 하지 않았으면 null 이다. 
	String isSave=request.getParameter("isSave");
	if(isSave==null){
		//저장된 쿠키 삭제 
		Cookie idCook=new Cookie("savedId", id);
		idCook.setMaxAge(0);//삭제하기 위해 0 으로 설정 
		response.addCookie(idCook);
		
		Cookie pwdCook=new Cookie("savedPwd", pwd);
		pwdCook.setMaxAge(0);
		response.addCookie(pwdCook);
	} else{
		//아이디와 비밀번호를 쿠키에 저장
		Cookie idCook=new Cookie("savedId", id);
		idCook.setMaxAge(60*60*24);//하루동안 유지
		response.addCookie(idCook);
		
		Cookie pwdCook=new Cookie("savedPwd", pwd);
		pwdCook.setMaxAge(60*60*24);
		response.addCookie(pwdCook);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/login.jsp</title>
</head>
<body>
	<%if(isSuccess){ 
		session.setAttribute("id", id);%>
		<script>
			location.href="<%=url%>";
		</script>
	<%}else{ %>
		<script>
			alert("아이디 혹은 비밀번호를 다시 확인해주세요.");
			location.href="${pageContext.request.contextPath }/users/loginform.jsp?url=<%=url%>";
		</script>
	<%} %>
</body>
</html>