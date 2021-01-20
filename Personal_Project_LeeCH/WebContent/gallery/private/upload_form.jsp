<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/gallery/private/upload_form.jsp</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="../../include/navbar.jsp"></jsp:include>
	<div class="container">
		<form action="${pageContext.request.contextPath }/gallery/private/upload.jsp" method="post" enctype="multipart/form-data">
			<div class="form-group">
				<label for="caption">설명</label>
				<input class="form-control" type="text" name="caption" id="caption" />
			</div>
			<div class="form-group">
				<label for="image">이미지</label>
				<input type="file" class="form-control-file" name="image" id="image"
					 accept=".jpg, .jpeg, .png, .JPG, .JPEG, .PNG" />
			</div>
			<button class="btn btn-secondary" type="submit">업로드</button>
		</form>
	</div>
</body>
</html>