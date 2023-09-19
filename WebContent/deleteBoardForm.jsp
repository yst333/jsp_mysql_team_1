<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>deleteBoardForm.jsp</title>
</head>
<body>
	<form action="deleteBoard.jsp" method="post">
		<table border="1">
				<tr>
					<td>게시글 번호 입력 삭제</td>
					<td> <input type="text" name="BOARDNUM" size="10"></td>
				</tr>
				<tr>
					<td colspan="2"> <input type="submit" value="삭제"></td>
					<td colspan="2"> <input type="reset" value="취소"></td>
				</tr>
		</table>
	</form>
</body>
</html>