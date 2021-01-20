<%@page import="test.users.dao.UserDao"%>
<%@page import="test.users.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String id=(String)session.getAttribute("id");
	UserDto dto=UserDao.getInstance().getData(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/private/updateform.jsp</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<style>
	/*프로필 이미지를 작운 원형으로 만든다.*/
	#profileImage{
	width:50px;
	height: 50px;
	border: 1px solid #cecece;
	border-radius: 50%;
	}
	/*프로필 업로드 폼을 화면에 안보이게 숨긴다.*/
	#profileForm{
		display: none;
	}
</style>
</head>
<body>
	<jsp:include page="../../include/navbar.jsp"></jsp:include>
	<div class="container">
		<a href="javascript:" id="profileLink">
			<%if(dto.getProfile()!=null){%>
				<img id="profileImage" src="${pageContext.request.contextPath }<%=dto.getProfile() %>"/>
			<%} else{ %>
				<svg id="profileImage" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
					<path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z"/>
				</svg>
			<%} %>
		</a><br />
		<form action="${pageContext.request.contextPath }/users/private/update.jsp" method="post">
			<div class="form-group">
				<label for="id">아이디</label>
				<input class="form-control" type="text" id="id" value="<%=dto.getId() %>" disabled />
			</div>
			<div class="form-group">
				<label for="email">이메일</label>
				<input class="form-control" type="email" id="email" name="email" value="<%=dto.getEmail() %>" />
			</div>
			<button class="btn btn-primary" type="submit">수정</button>
			<button class="btn btn-danger" type="reset">취소</button>
		</form>
		<form action="profile_upload.jsp" method="post" enctype="multipart/form-data" id="profileForm">
			<div class="input-group">
				<input type="file" name="image" id="image" accept=".jpg, .jpeg, .png, .JPG, .JPEG, .PNG" /><br/>
				<button class="btn btn-primary" type="submit">업로드</button>
			</div>
		</form>

	</div>
	<script>
		// 프로필 링크를 클릭했을 때 실핼할 함수 등록
		$("#profileLink").on("click",function(){
			// 아이디가 image인 요소를 강제 클릭하기
			$("#image").click();
		});
		// 이미지를 선택했을 때 실행할 함수 등록 
		$("#image").on("change",function(){
			//폼을 강제 제출해서 선택된 이미지가 업로드 되도록 한다.
			$("#profileForm").submit();
		});
	</script>
</body>
</html>