<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- 
	jsp 페이지 안에서의 주석 입니다.
	여기 작성한 내용은 jsp 페이지가 해석 하지 않습니다.
	클라이언트 웹브라우저에 출력되지 않습니다.
 --%>
<%-- 특정 jsp 페이지에 포함 시킬 내용을 jsp 페이지에 작성할 수 있습니다. --%>
<%
	// "thisPage"라는 파라미터 명으로 전달된 문자열 읽어오기
	String thisPage=request.getParameter("thisPage");
	if(thisPage==null) thisPage="";
%>
<style>
	a.nav-tag{
		color: #f8f9fa;
		background-color: #343a40;
	}
	a.nav-tag:active {
		color: #6c757d;
		background-color: #f8f9fa;
	}
	a.nav-tag:hover {
		color: #6c757d;
		background-color: #f8f9fa;
	}
</style>
<nav class="navbar navbar-dark bg-dark navbar-expand-sm fixed-top">
	<div class="container">
		<a class="navbar-brand" href="${pageContext.request.contextPath }/main.jsp">
			<img style="width:30px; heigth:30px;" src="${pageContext.request.contextPath }/images/ffxiv.png"></img>LCH</a>
		<div class="collapse navbar-collapse" id="topNav" style="margin-left: 60px">
			<ul class="nav mr-auto nav-tag" id="pills-tab">
				<li class="nav-item">
					<a class="nav-link nav-tag" href="${pageContext.request.contextPath }/cafe/list.jsp">카페 글 목록</a></li>
				</li>
				<li class="nav-item">
					<a class="nav-link nav-tag" href="${pageContext.request.contextPath }/file/list.jsp">자료실 목록</a></li>
				</li>
				<li class="nav-item">
					<a class="nav-link nav-tag" href="${pageContext.request.contextPath }/gallery/list.jsp">갤러리 목록</a></li>
				</li>
			</ul>
		</div>
		<%
			String id=(String)session.getAttribute("id");
			if(id==null){
		%>
			<a class="btn btn-success btn-sm" href="${pageContext.request.contextPath }/users/loginform.jsp">로그인</a>
			<a class="btn btn-danger btn-sm ml-1" href="${pageContext.request.contextPath }/users/signup_form.jsp">회원 가입</a>
		<%}else{ %>
			<span class="navbar-text">
				<a href="${pageContext.request.contextPath }/users/private/info.jsp"><%=id %></a>님 로그인 중...
				<a class="btn btn-danger btn-sm" href="${pageContext.request.contextPath }/users/logout.jsp">로그아웃</a>
			</span>
		<%} %>
	</div>
</nav>