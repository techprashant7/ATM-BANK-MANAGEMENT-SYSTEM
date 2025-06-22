

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
      <%@ page import="java.sql.*" %>
<%
    String dbURL = "jdbc:mysql://localhost:3306/banksystem?useSSL=false&allowPublicKeyRetrieval=true";
    String dbUser = "root";
    String dbPassword = "pr@sh@nt777777"; // Use your actual DB password

    Connection con = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(dbURL, dbUser, dbPassword);
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
    </body>
</html>
