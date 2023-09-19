<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="jdk.internal.org.objectweb.asm.tree.TryCatchBlockNode"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 
	request.setCharacterEncoding("utf-8");
	String boardNum = request.getParameter("BOARDNUM");
	String title = request.getParameter("TITLE");
	String content = request.getParameter("CONTENT");
	String writer = request.getParameter("WRITER");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		Class.forName("com.mysql.cj.jdbc.Driver");
		System.out.println("드라이버 로딩 성공");
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try{
			String jdbcDriver = "jdbc:mysql://localhost:3306/jspmysqlteam1?characterEncoding=UTF-8&serverTimezone=UTC";
			String dbUser = "jspmysqlteamuser1";
			String dbPass = "jspmysqlteampw";
			System.out.println("DB 접속 성공");
			
			// insert into member BOARD('1', 'test1', '1번 글 테스트입니다', 'jby1');
			String query = "insert into BOARD values(?, ?, ?, ?)";
			
			// 2. 데이터베이스 커넥션 생성
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			
			// 3. PreparedStatement 생성
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, boardNum);
			pstmt.setString(2, title);
			pstmt.setString(3, content);
			pstmt.setString(4, writer);
			
			// 4. 쿼리문 실행
			int resultInsert = pstmt.executeUpdate();
			
			// 5. 쿼리문 실행 결과 출력
	%>

			<%= resultInsert %>건의 데이터가 추가되었습니다.
			
	<%

		}catch(SQLException ex){
			out.println(ex.getMessage());
			ex.printStackTrace();
		} finally{
		      // 6. 사용한 Statement 종료
		      if(pstmt != null) try{
		    	  pstmt.close();
		      } catch(SQLException ex){
		         ex.printStackTrace();
		      }
		      
		      // 7. 커넥션 종료
		      if(conn != null) try{
		         conn.close();
		      } catch(SQLException ex){
		         ex.printStackTrace();
		      }
		   }
		
	%>
  


</body>
</html>