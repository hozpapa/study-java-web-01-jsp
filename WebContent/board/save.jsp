<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 한글 깨짐 방지 인코딩 설정
	request.setCharacterEncoding("utf-8");
	// 제목 입력 받은 값 변수에 담음
	String title = request.getParameter("title");
	// 내용
	String contents = request.getParameter("contents");
	// 검증
	boolean validate = true;
	// 성공여부
	boolean save = false;
	// 에러메세지
	String message = null;
	// null 또는 공백일 때 필수체크
	if (title == null || title.isEmpty()) {
		message = "제목을 입력해주세요.";
		validate = false;
	}
	// null 또는 공백일 때 필수체크
	if (validate && contents == null || contents.isEmpty()) {
		message = "내용을 입력해주세요.";
		validate = false;
	}
	// 모든 필수체크가 로직이 성공했다면..
	if (validate) {
		// DB에 접속을 하고 위에 내용을 저장하는 소스 구현
		Connection connection = null;
		PreparedStatement stmt = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// 데이터베이스 접속을 위한 정보 set
			String jdbcUrl = "jdbc:mysql://localhost:3306/profile";
			// db설치시 기입한 접속정보 set
			String user = "root";
			String password = "1234";
			// db 접속 커넥션을 획득
			connection = DriverManager.getConnection(jdbcUrl, user, password);
			String sql = "INSERT T_BOARD (TITLE, CONTENTS, REG_DATE) " +
				"VALUES (?, ?, NOW())";
			// sql 쿼리를 실행하기 위한 statemenet 획득
			stmt = connection.prepareStatement(sql);
			
			stmt.setString(1, title);
			stmt.setString(2, contents);
			// database에 INSERT 쿼리를 실행 후 결과를 리턴 받음
			int result = stmt.executeUpdate();
			if (result == 0) {
				message = "게시물 등록 중 오류가 발생했습니다.";
			} else {
				save = true;
			}
			// DB 커넥션 소스를 구현해야되요.
		} catch (Exception e) {
			e.printStackTrace();
			message = "게시물 등록 중 DATABASE 오류가 발생하였습니다.";
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script>
		// 성공실패에 대한 값을 set
		var save = <%=save%>;
		// 성공 또는 오류 메세지를 set
		var message = '<%=message%>';
		if (save) {
			alert('게시물 등록이 완료되었습니다.');
			location.href = '/board/list.jsp';
		} else {
			alert(message);
			history.back(-1);
		}
	</script>
</body>
</html>