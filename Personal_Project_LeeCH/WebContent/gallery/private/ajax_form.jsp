<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/gallery/private/ajax_form.jsp</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<style>
	.img-wrapper img{
		width: 900px;
		height: 450px;
		object-fit: cover;
		margin-bottom: 50px;
	}
</style>
</head>
<body>
	<jsp:include page="../../include/navbar.jsp"></jsp:include>
	<div class="container">
		<form action="${pageContext.request.contextPath }/gallery/private/insert.jsp" method="post" id="insertForm">
			<input type="hidden" name="imagePath" id="imagePath" />
			<div class="form-group">
				<label for="caption">설명</label>
				<input class="form-control" type="text" name="caption" id="caption" />
			</div>
		</form>
		<form action="${pageContext.request.contextPath }/gallery/private/ajax_upload.jsp" method="post" id="ajaxForm" enctype="multipart/form-data">
			<div class="form-group">
				<label for="image">이미지</label>
				<input type="file" class="form-control-file" name="image" id="image"
					 accept=".jpg, .jpeg, .png, .JPG, .JPEG, .PNG" />
			</div>
		</form>
		<button class="btn btn-success" id="submitBtn" style="margin-bottom: 5px">등록</button>
		<div class="img-wrapper pagination justify-content-center">
			<img />
		</div>
	</div>
	<script src="${pageContext.request.contextPath }/js/jquery-3.5.1.js"></script>
	<!-- jquery form 플러그인 javascript 로딩 -->
	<script src="${pageContext.request.contextPath }/js/jquery.form.min.js"></script>
	<script>
		//form 플러그인을 이용해서 form 이 ajax 전송(페이지 전환없이) 되도록 한다.
		$("#ajaxForm").ajaxForm(function(data){
			console.log(data);
			// 로딩할 이미지의 경로 구성
			let src="${pageContext.request.contextPath }"+data.imagePath;
			// img 요소의 src속성으로 지정을 해서 이미지를 표시한다.
			$(".img-wrapper img").attr("src",src);
			// insertForm에 input type="hidden"에 value로 넣어준다.
			$("#imagePath").val(data.imagePath);
		});
		// 이미지를 선택하면 강제로 폼 전송 시키기
		$("#image").on("change",function(){
			$("#ajaxForm").submit();
		});
		// 버튼을 누르면 insertForm 강제 제출해서 이미지 정보가 저장되도록 한다.
		$("#submitBtn").on("click",function(){
			$("#insertForm").submit();
		});
	</script>
</body>
</html>