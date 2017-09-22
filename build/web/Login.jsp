<%-- 
    Document   : Login
    Created on : 26 May, 2017, 5:28:38 PM
    Author     : Shubhankar Nath
--%>

<%@page import="SecurityFeatures.Hashing_SHA256, SecurityFeatures.RandStringGenerator"%>
<%@page import="java.util.Random"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.security.MessageDigest, SecurityFeatures.ActiveSessionCheck" %>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
    </head>
    <body>

    <%
        String A_id =request.getParameter("A_id");
        String A_pass=request.getParameter("password");
        String Salt = new String();
        try
        {
            Class.forName("com.mysql.jdbc.Driver");  // MySQL database connection
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Audit?useSSL=false","root","1234");
            PreparedStatement pst = conn.prepareStatement("Select * from Auditor_Details where A_id=? ");
            pst.setString(1, A_id);
            ResultSet rs = pst.executeQuery();
            if (rs.next())//Means user Exists
            {
                Salt = rs.getString("A_Salt");
                String Password = A_pass+Salt;
                String A_PassHash = Hashing_SHA256.hash(Password);
                pst = conn.prepareStatement("Select * from Auditor_Details where A_id=? and A_PassHash=? ");
                pst.setString(1, A_id);
                pst.setString(2, A_PassHash);
                rs = pst.executeQuery();
                if (rs.next())
                {
                    String A_SessionInfo = session.getId();
                    A_SessionInfo=A_SessionInfo + RandStringGenerator.getRandString();
                    pst = conn.prepareStatement("Update Auditor_Details set A_SessionInfo=? where A_PassHash=? ");
                    pst.setString(1, A_SessionInfo );
                    pst.setString(2, A_PassHash);
                    int i=pst.executeUpdate();
                    if(i==1)
                    {
                        System.out.println("User Logged on");
                        session.setAttribute( "UserData", A_SessionInfo );
                        System.out.println("After writting: "+session.getAttribute( "UserData"));
                        request.getRequestDispatcher("Dashboard.jsp").forward(request, response);
                    }
                    else
                        out.print("Session ID Problem <br> Please try again or contact admin");
                }
            }
            else
                out.println("<center>Auditor ID does not Exist.</center>");
            conn.close();
        }

        catch(Exception e)
        {
            System.err.println(e.getClass().getName()+":"+e.getMessage());
            System.exit(0);
        }        

    %>
        
    </body>
</html>
