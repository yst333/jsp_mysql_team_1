<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("utf-8");
	String boardNum = request.getParameter("BOARDNUM");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>deleteBoard.jsp</title>
</head>
<body>
<%
	Class.forName("com.mysql.cj.jdbc.Driver");
	System.out.println("드라이버 접속 성공!");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try{
		String jdbcDriver = "jdbc:mysql://localhost:3306/jspmysqlteam1?characterEncoding=UTF-8&serverTimezone=UTC";
		String jdbcUser = "jspmysqlteamuser1";
		String jdbcPass = "jspmysqlteampw";
		System.out.println("DB 접속 성공!");
		
		int bn = Integer.parseInt(boardNum);
		conn = DriverManager.getConnection(jdbcDriver,jdbcUser,jdbcPass);
		
		//delete from BOARD where BOARDNUM = 1;
		String query = "delete from BOARD where BOARDNUM = ?";
		pstmt = conn.prepareStatement(query);
		pstmt.setInt(1, bn);
		
		int resultDelete = pstmt.executeUpdate();
		
		if(resultDelete==0){
%>
			<%=resultDelete %>는 존재하지 않는 데이터 입니다!			
<%
		}else{
%>
			<%=boardNum %>번의 게시글이 삭제되었습니다!
<%
		}
%>
<%
	}catch(SQLException ex){
		out.println(ex.getMessage());
		ex.printStackTrace();
	}finally{
	     
	      if(pstmt != null) try{
	    	  pstmt.close();
	      } catch(SQLException ex){
	         ex.printStackTrace();
	      }
	      
	      
	      if(conn != null) try{
	         conn.close();
	      } catch(SQLException ex){
	         ex.printStackTrace();
	      }
	   }
	
%>
			
</body>
</html>