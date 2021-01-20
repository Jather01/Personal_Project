<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/signup_form.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="../include/navbar.jsp"></jsp:include>
	<div class="container">
		<form action="${pageContext.request.contextPath }/users/signup.jsp" method="post" id="myForm">
			<div class="form-group">
				<label for="id">아이디</label>
				<input class="form-control" type="text" name="id" id="id" />
				<small class="form-text text-muted">영어 소문자로 시작하는 5~10글자의 아이디를 입력하세요</small>
				<div class="invalid-feedback" id="IdInvalid">형식에 맞지 않는 아이디입니다.</div>
				<div class="valid-feedback">사용할 수 있는 아이디입니다.</div>
				<button class="btn btn-secondary" id="isUseable" type="button">중복 확인</button>
			</div>
			<div class="form-group">
				<label for="pwd">비밀번호</label>
				<input class="form-control" type="password" name="pwd" id="pwd" />
				<small class="form-text text-muted">5~10글자의 비밀번호를 입력해주세요.</small>
			</div>
			<div class="form-group">
				<label for="pwd2">비밀번호 확인</label>
				<input class="form-control" type="password" name="pwd2" id="pwd2" />
				<div class="invalid-feedback">비밀번호를 확인 하세요</div>
			</div>
			<div class="form-group">
				<label for="email">이메일</label>
				<input class="form-control" type="text" name="email" id="email" />
			</div>
			<button class="btn btn-secondary" type="submit">가입</button>
		</form>
	</div>
	<script>
		// 아이디를 검증할 정규 표현식
		let reg_id=/^[a-z].{4,9}$/;
		// 비밀번호를 검증할 정규 표현식
		let reg_pwd=/^.{5,10}$/;
		// 이메일을 검증할 정규 표현식(정확히 하려면 javascript 이메일 정규 표현식 검색해서 사용)
		let reg_email=/@/;
		// 아이디와 비밀번호의 유효성 여부를 관리할 변수
		let isIdValid=false;
		let isPwdValid=false;
		let isEmailVaild=false;
		let isFormVaild=false;
		// 폼에 submit 이벤트가 일어났을 때 jquery를 활용해서 폼에 입력한 내용 검증하기
		// id가 myForm인 요소에 submit 이벤트가 일어났을 때 실행할 함수 등록
		$("#myForm").on("submit", function(){
			isFormValid=isIdValid&&isPwdValid&&isEmailValid;
			// 만일 아이디를 제대로 입력하지 않았으면 폼전송을 막는다.
			if(!isFormValid){
				return false;
			}
		});
		$("#pwd").on("input", function(){
			// 입력한 두 비밀번호를 읽어온다.
			let pwd=$("#pwd").val();
			// 일단 모든 검증 클래스를 제거하고
			$("#pwd").removeClass("is-valid is-invalid");
			if(!reg_pwd.test(pwd)){ // 만약 문자열의 길이가 4보다 작으면
				// 비밀번호가 유효하지 않다고 표시하고
				$("#pwd").addClass("is-invalid");
				isPwdValid=false;
				// 함수를 종료한다.
				return;
			}else{
				$("#pwd").addClass("is-valid");
				isPwdValid=true;
			}
		});
		$("#pwd2").on("input", function(){
			// 입력한 두 비밀번호를 읽어온다.
			let pwd=$("#pwd").val();
			let pwd2=$("#pwd2").val();
			// 일단 모든 검증 클래스를 제거하고
			$("#pwd2").removeClass("is-valid is-invalid");
			// 두 비밀번호가 같은지 확인해서
			if(pwd==pwd2){
				// 유효하다는 클래스 추가
				$("#pwd2").addClass("is-valid");
				isPwdValid=true;
			} else{
				// 유효하지 않다는 클래스 추가
				$("#pwd2").addClass("is-invalid");
				isPwdValid=false;
			}
		});
		$("#email").on("input", function(){
			// 입력한 두 비밀번호를 읽어온다.
			let email=$("#email").val();
			// 일단 모든 검증 클래스를 제거하고
			$("#email").removeClass("is-valid is-invalid");
			if(!reg_email.test(email)){ // 만약 문자열의 길이가 4보다 작으면
				// 비밀번호가 유효하지 않다고 표시하고
				$("#email").addClass("is-invalid");
				isEmailValid=false;
				// 함수를 종료한다.
				return;
			}else{
				$("#email").addClass("is-valid");
				isEmailValid=true;
			}
		});
		// id 중복확인
		$("#isUseable").on("click", function(){
			let id=$("#id").val();
			$.ajax({
				url:"checkid.jsp",
				method:"GET",
				data:"id="+id,
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
						alert("사용할 수 있는 아이디 입니다.");
						$("#id").addClass("is-valid");
						isIdValid=true;
					}else{
						alert("중복된 아이디 입니다.");
						$("#IdInvalid").text('중복된 아이디입니다.');
						$("#id").addClass("is-invalid");
						isIdValid=false;
					}
				}
			});
		});
		$("#id").on("input", function(){
			// 일단 모든 검증 클래스를 제거하고
			$("#id").removeClass("is-valid is-invalid");
			// 1. 입력한 아이디를 읽어온다.
			let id=$("#id").val();
			// 2. 서버에 ajax 요청으로 보내서 사용 가능 여부를 응답 받아서 반응을 보여준다.
			if(!reg_id.test(id)){ // 만약 문자열의 길이가 4보다 작으면
				// 아이디가 유효하지 않다고 표시하고
				$("#IdInvalid").text('형식에 맞지 않는 아이디입니다.');
				$("#id").addClass("is-invalid");
				isIdValid=false;
				// 함수를 종료한다.
				return;
			}
		});
	</script>
</body>
</html>