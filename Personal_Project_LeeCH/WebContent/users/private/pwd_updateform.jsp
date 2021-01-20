<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/private/pwd_updateform.jsp</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="../../include/navbar.jsp"></jsp:include>
	<div class="container">
		<form action="${pageContext.request.contextPath }/users/private/pwd_update.jsp" method="post" id="myForm">
			<div class="form-group">
				<label for="pwd">기존 비밀번호</label>
				<input class="form-control" type="password" id="pwd" name="pwd" />
				<div class="invalid-feedback" id="IdInvalid">기존 비밀번호와 다릅니다.</div>
			</div>
			<div class="form-group">
				<label for="newPwd">새 비밀번호</label>
				<input class="form-control" type="password" id="newPwd" name="newPwd" />
				<div class="invalid-feedback" id="IdInvalid">형식에 맞지 않는 비밀번호입니다.</div>
			</div>
			<div class="form-group">
				<label for="newPwd2">비밀번호 확인</label>
				<input class="form-control" type="password" id="newPwd2"/>
				<div class="invalid-feedback" id="IdInvalid">새 비밀번호와 다릅니다.</div>
			</div>
			<button class="btn btn-primary" type="submit">수정</button>
			<button class="btn btn-danger" type="reset">취소</button>
		</form>
	</div>
	<script>
		// 비밀번호를 검증할 정규 표현식
		let reg_pwd=/^.{5,10}$/;
		let isPwdValid=false;
		let isNewPwdValid=false;
		$("#pwd").on("input", function(){
			// 일단 모든 검증 클래스를 제거하고
			$("#pwd").removeClass("is-valid is-invalid");
			// 입력한 비밀번호를 읽어온다.
			let pwd=$("#pwd").val();
			$.ajax({
				url:"checkpwd.jsp",
				method:"GET",
				data:"pwd="+pwd,
				success:function(responseData){
					/*
						checkid.jsp 페이지에서 응답할때
						contextType="application/json"이라고 설정하면
						함수의 인자로 전달되는 responseData는 object이다.
						{isExist:true} or {isExist:false}
						형식의 object이기 때문에 바로 사용할 수 있다.
					*/
					console.log(responseData);
					if(responseData.isExist){
						$("#pwd").addClass("is-valid");
						isPwdValid=true;
					}else{
						$("#pwd").addClass("is-invalid");
						isPwdValid=false;
					}
				}
			});
		});
		$("#newPwd").on("input", function(){
			// 입력한 두 비밀번호를 읽어온다.
			let pwd=$("#newPwd").val();
			// 일단 모든 검증 클래스를 제거하고
			$("#newPwd").removeClass("is-valid is-invalid");
			if(!reg_pwd.test(pwd)){ // 만약 문자열의 길이가 4보다 작으면
				// 비밀번호가 유효하지 않다고 표시하고
				$("#newPwd").addClass("is-invalid");
				isNewPwdValid=false;
				// 함수를 종료한다.
				return;
			}else{
				$("#newPwd").addClass("is-valid");
				isNewPwdValid=true;
			}
		});
		$("#newPwd2").on("input", function(){
			// 입력한 두 비밀번호를 읽어온다.
			let pwd=$("#newPwd").val();
			let pwd2=$("#newPwd2").val();
			// 일단 모든 검증 클래스를 제거하고
			$("#newPwd2").removeClass("is-valid is-invalid");
			// 두 비밀번호가 같은지 확인해서
			if(pwd==pwd2){
				// 유효하다는 클래스 추가
				$("#newPwd2").addClass("is-valid");
				isNewPwdValid=true;
			} else{
				// 유효하지 않다는 클래스 추가
				$("#newPwd2").addClass("is-invalid");
				isNewPwdValid=false;
			}
		});
		$("#myForm").on("submit", function(){
			isFormValid=isPwdValid&&isNewPwdValid;
			// 만일 아이디를 제대로 입력하지 않았으면 폼전송을 막는다.
			if(!isFormValid){
				return false;
			}
		});
	</script>
</body>
</html>