<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	Hellow Fastcampus.
 
<%
	// 카드를 화면에 노출할지 여부
	boolean cardDisplay = true;
	if (cardDisplay) {
%>
	<p>나의 카드에 이름은 : 송영문</p>
<%		
	}
	List<String> names = Arrays.asList("Servlet", "Spring", "Spring Boot");
	int count = 0;
	// names에 배열을 반복한다.
	for (String name : names) {
		count++;
		out.println("<h2>" + count + "</h2>");
%>
		<h1>Framework : <%= name %></h1>
<%
	}
%>	
	
</body>
</html>