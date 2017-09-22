<%-- 
    Document   : CampaignInfo
    Created on : 20 Jul, 2017, 10:49:08 AM
    Author     : Shubhankar Nath
--%>

<%@page import="SecurityFeatures.ActiveSessionCheck"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Campaign Information</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    </head>
    <body>

        <%
            //Authentication
            String auditor = new String();
            String A_SessionInfo = (String)session.getAttribute("UserData");
            auditor = ActiveSessionCheck.UserCheck(A_SessionInfo);
            if (auditor==null)
            {
                out.print("<script>alert('Session no longer active');");
                out.print("window.location='index.html'</script>");
            }            
        %>
        <h1 align="center">Campaign Details</h1>
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
        
        
            
            <table style="width:100%">
            <col width="50">
            <col width="100">
            <col width="100">
            <col width="50">
            <col width="80">
            <col width="80">
            <tr>
                <th>Campaign ID</th>
                <th>Organization</th>
                <th>Auditor</th>
                <th>Status</th>
                <th>Export</th>
                <th>Edit</th>
            </tr>

            
            <%                
                try
                {
                    Class.forName("com.mysql.jdbc.Driver");  // MySQL database connection
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Audit?useSSL=false","root","1234");
                    conn.setAutoCommit(false);
                    conn.setHoldability(ResultSet.HOLD_CURSORS_OVER_COMMIT);
                    Statement stmt = conn.createStatement();
                    Statement stmt1 = conn.createStatement();
                    Statement stmt2 = conn.createStatement();
                    ResultSet rs=null;
                    rs = stmt.executeQuery("Select * from campaign_details" );//where status in not checked to be OK
                    while(rs.next())
                    {
                        ResultSet crs = stmt1.executeQuery("Select * from company_details where C_id='"+ rs.getString(2)+"'" );
                        ResultSet ars = stmt2.executeQuery("Select * from auditor_details where A_id='"+ rs.getString(3)+"'" );
                        crs.next();
                        ars.next();
                        {
            %>
            <Form method ="post" action="AuditorCheckForm.jsp">
            <tr>
                <td>
                    <input type="text" id="id<% out.print( rs.getString(1));%>" readonly style="width:90%" name ="campaign_id" value="<% out.print( rs.getString(1));%>">                    
                </td>
                <td>
                    <% out.print( crs.getString(2));%>
                </td>
                <td>
                    <% out.print( ars.getString(2)+" "+ars.getString(3));%>
                </td>
                <td>
                    <% out.print( rs.getString(13));%>
                </td>
                <td>
                    <input type ="button" value="Export Data" id="<% out.print( rs.getString(1));%>" onclick="saveFile(this);">
                </td>
                <td>
                    <input type="submit" value="Edit">
            </form>
                </td>
            </tr>
            <%
                        }
                    
                    crs.close();
                    ars.close();
                    }
                    rs.close();
                    conn.commit();
                    conn.close();
                }
                catch(Exception e)
                {
                    System.out.println("cannot open campaign info");
                    System.err.println(e.getClass().getName()+":"+e.getMessage());
                    System.exit(0);
                }    
            %>
            <script type="text/javascript">
               function saveFile(obj)
               {
                   var btnId= obj.id;
                   $.ajax({
                      type:"post",
                      url:"export.jsp",
                      data:{camp_id:btnId},
                      sucess: function(data){
                          alert("Successfully exported to Desktop");
                      }
                   });
               }
            </script>
    </body>
</html>
