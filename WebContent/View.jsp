<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <!-- 프론트앤드 웹페이지에서 파라미터로 아이디를 전달받으면 MEMBER 테이블로부터
          해당 회원 정보를 읽어와서 화면으로 출력하는 JSP 웹 프로그램을 제작해 봅니다. -->
          
 <%
	request.setCharacterEncoding("utf-8");
 	String boardNum=request.getParameter("BOARDNUM");

 %>   
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>WebContent 폴더 안에 viewMemberList.jsp 소스 코딩</title>
</head>
<body>

	<%
		// 1. JDBC 드라이버 로딩
	   	// MySQL DB 8아래 버전은 com.mysql.jdbc.Driver을 사용했지만,
	   	// MySQL DB 8이상 버전은 com.mysql.cj.jdbc.Driver 로 사용합니다.
	   	Class.forName("com.mysql.cj.jdbc.Driver");
		System.out.println("드라이브 로딩 성공");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			String jdbcDriver = "jdbc:mysql://localhost:3306/jspmysqlteam1?characterEncoding=UTF-8&serverTimezone=UTC";
			String dbUser = "jspmysqlteamuser1";
			String dbPass = "jspmysqlteampw";
			System.out.println("DB 접속 성공");
			
			//select * from member where memberid = 'jang';
			String query = "select * from board where  BOARDNUM= '"+boardNum+"'";
			
			//2. 데이버 베이스 커넥션 생성
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			
			//3. Statement 생성
			pstmt = conn.prepareStatement(query);
			
			//4. 쿼리문 실행
			rs= pstmt.executeQuery(query);
			
			//5. 쿼리문 실행 결과 출력
			if(rs.next()){
				%>
				<table border="1">
				<tr>
					<td>번호</td>
					<td><%= rs.getString("BOARDNUM") %></td>
				</tr>
				<tr>
					<td>제목</td>
					<td><%= rs.getString("TITLE") %></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><%= rs.getString("CONTENT") %></td>
				</tr>
				<tr>
					<td>작성자</td>
					<td><%= rs.getString("WRITER") %></td>
				</tr>
				
				</table>
				
				<%
					} else{
				%>
				
				<%= boardNum %>에 해당하는 정보가 존재하지 않습니다
				
			<% 
				
			}
			
			
		} catch(SQLException ex) {
			out.println(ex.getMessage());
			ex.printStackTrace();
		} finally{
		      // 6. 사용한 Statement 종료

		      if(rs != null) try{
		         rs.close();
		      } catch(SQLException ex){
		         ex.printStackTrace();
		      }
		      
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
	  <form action="index.jsp">
         <input type="submit" value="처음으로">
      </form>

</body>
</html>