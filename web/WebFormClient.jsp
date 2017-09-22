<%-- 
    Document   : WebFormClient
    Created on : 14 Jul, 2017, 3:33:49 PM
    Author     : Shubhankar Nath
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Web Form Client</title>
    </head>
    <body>
        <div>
        </div>
        <h2 align="center"> Client Form:</h2>
        <style>
            table, th, td 
            {
                border: 1px solid black;
                background-color: rgba(74, 118, 73, 0.20);
                border-collapse: collapse;
            }
            table 
            {
                border-spacing: 10px 0;
            }
            table th
            {
                background-color: rgb(38, 115, 38);
                color: white;
            }
            table, th,td
            {
                padding: 10px;
                border: 1px solid rgb(38, 115, 38);
            }
        </style>      
                
        <Form method ="post" action="writeFormClient.jsp">

        <%
            int loopCount=0;
            String campaign_id= request.getParameter("campaign_id");
            try
            {
                Class.forName("com.mysql.jdbc.Driver");  // MySQL database connection
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Audit?useSSL=false","root","1234");
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("Select * from Qs" + campaign_id + " where  Q_Status != 1");//where status in not checked to be OK
                while(rs.next())
                {
        %>

            <table style="width:100%">
            <col width="10">
            <col width="150">
            <col width="50">
            <col width="5">
            <col width="100">

            <tr>
                <th>Q_ID </th>
                <th>Question</th>
                <th>Document Recomended</th>
                <th>Result</th>
                <th>Comment</th>
            </tr>

            <tr>
                <td>
                    <input type="text" readonly style="width:90%" name ="Q_id" value="<% out.print( rs.getString(1));%>">                    
                </td>
                <td>
                    <% out.print( rs.getString(2));%>
                </td>
                <td>
                    <%out.print( rs.getString(3));%>
                </td>
                <td>
                    <select  name ="Result" width="90%" style="width: 50px">
                        <option value="No">No</option>
                        <option value="Yes">Yes</option>
                    </select>
                </td>
                <td>
                    <%out.print( rs.getString(5));%>
                </td>
            </tr>
        </table>
        <%
                }
                conn.close();
            }
            catch(Exception e)
                {
                    System.out.println("Cannot display client form");
                    System.err.println(e.getClass().getName()+":"+e.getMessage());
                    System.exit(0);
                }    
        %>
        <input type ="hidden" name ="campaign_id" value="<% out.print(campaign_id); %>">
        <input type="submit" value="Write Changes">
    </form>

    </body>
</html>
