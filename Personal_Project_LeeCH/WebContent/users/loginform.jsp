<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/loginform.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
	html, body {
		height: 100%;
	}
	body {
		display: -ms-flexbox;
		display: flex;
		-ms-flex-align: center;
		align-items: center;
		padding-top: 40px;
		padding-bottom: 40px;
		background-color: #f5f5f5;
	}
	.form-signin {
		width: 100%;
		max-width: 330px;
		padding: 15px;
		margin: auto;
	}
	.form-signin .checkbox {
		font-weight: 400;
	}
	
	.form-signin .form-control {
		position: relative;
		box-sizing: border-box;
		height: auto;
		padding: 10px;
		font-size: 16px;
	}
	.form-signin .form-control:focus {
		z-index: 2;
	}
	.form-signin input[type="email"] {
		margin-bottom: -1px;
		border-bottom-right-radius: 0;
		border-bottom-left-radius: 0;
	}
	.form-signin input[type="password"] {
		margin-bottom: 10px;
		border-top-left-radius: 0;
		border-top-right-radius: 0;
	}
</style>
</head>
<body class="text-center">
	<%
		// GET 방식 파라미터 url이라는 이름으로 전달되는 값이 있는지 읽어와보기
	String url = request.getParameter("url");
	// 만일 넘어온 값이 없다면
	if (url == null) {
		// 로그인 후에 index 페이지로 가도록 절대 경로를 구성한다.
		String cPath = request.getContextPath();
		url = cPath + "/main.jsp";
	}
	boolean isSaved=false;
	//쿠키에 저장된 아이디와 비밀번호를 담을 변수
	String savedId = "";
	String savedPwd = "";
	//쿠키에 저장된 값을 위의 변수에 저장하는 코드를 작성해 보세요.
	Cookie[] cooks = request.getCookies();
	if (cooks != null) {
		isSaved=true;
		//반복문 돌면서 쿠키객체를 하나씩 참조해서 
		for (Cookie tmp : cooks) {
			//저장된 키값을 읽어온다.
			String key = tmp.getName();
			//만일 키값이 savedId 라면 
			if (key.equals("savedId")) {
				//쿠키 value 값을 savedId 라는 지역변수에 저장
				savedId = tmp.getValue();
			}
			if (key.equals("savedPwd")) {
				savedPwd = tmp.getValue();
			}

		}
	}
	%>
	<form class="form-signin" action="login.jsp" method="post">
		<img class="mb-4" src="${pageContext.request.contextPath }/images/ffxiv.png" alt="" width="144" height="144">
		<h1 class="h3 mb-3 font-weight-normal">로그인</h1>
		<%-- 원래 가려던 목적지 정보를 url이라는 파라미터 명으로 전송될 수 있도록 한다. --%>
		<input type="hidden" name="url" value="<%=url %>" />
		<label for="id" class="sr-only">아이디</label>
		<input class="form-control" type="text" name="id" id="id" value="<%=savedId%>" placeholder="아이디" required autofocus/>
		<label for="pwd" class="sr-only">비밀번호</label>
		<input class="form-control" type="password" name="pwd" id="pwd" value="<%=savedPwd%>" placeholder="비밀번호" required/>
		<div class="checkbox mb-3">
			<label>
				<input type="checkbox" name="isSave" value="yes" <%=isSaved?"checked":"" %>/>로그인 정보 저장
			</label>
		</div>
		<button class="btn btn-lg btn-primary btn-block" type="submit">로그인</button>
	</form>
</body>
</html>