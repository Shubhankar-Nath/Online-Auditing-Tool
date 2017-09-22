<%-- 
    Document   : writeFormAuditor
    Created on : 19 Jul, 2017, 4:09:57 PM
    Author     : Shubhankar Nath
--%>

<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Write Auditor Form</title>
    </head>
    <body>
        <%
            String Q_id[] = request.getParameterValues("Q_id");
            String Q_Status[] = request.getParameterValues("Q_Status");
            String Q_Comment[] = request.getParameterValues("Q_Comment");
            String campaign_id = request.getParameter("campaign_id");
            int loopCount = Q_id.length;
            String sql = null;
            try
            {
                Class.forName("com.mysql.jdbc.Driver");  // MySQL database connection
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Audit?useSSL=false","root","1234");
                conn.setAutoCommit(false);
                Statement stmt=conn.createStatement();  
                for(int i=0;i<loopCount;i++)
                {
                    sql="Update Qs" + campaign_id + " set Q_Status= '" + Q_Status[i] +"' where Q_id='" + Q_id[i] + "'";
                    stmt.addBatch(sql);
                }
                int v[] =stmt.executeBatch();
                if(v[--loopCount]>0)
                {
                    out.print("<script>alert('Data Submitted');");
                    out.print("window.location='Dashboard.jsp'</script>");
                }
                conn.commit();
                conn.close();
            }
            catch(Exception e)
            {
                System.out.println("Cannot submit client data");
                System.err.println(e.getClass().getName()+":"+e.getMessage());
                System.exit(0);
            }
        %>
    </body>
</html>
