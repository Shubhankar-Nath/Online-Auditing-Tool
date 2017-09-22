<%-- 
    Document   : SignUp
    Created on : 31 May, 2017, 3:56:36 PM
    Author     : Shubhankar Nath
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import ="SecurityFeatures.Hashing_SHA256" %>
<%@page import = "java.sql.*, java.util.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Signup Page</title>
    </head>
<body>
    <% 
        //recieving all the parameters
        String code = new String();
        Random randomGenerator = new Random();
        for (int idx = 1; idx <= 3; ++idx)
        {
         int randomInt = randomGenerator.nextInt(100);
         code = code + String.valueOf(randomInt);
        }
        String A_id= "EmpA" + code ;
        String A_FName = request.getParameter("A_FName");
        String A_LName = request.getParameter("A_LName");
        String A_EMail = request.getParameter("A_EMail");
        String A_Contact = request.getParameter("A_Contact");
        String password = request.getParameter("password");
        String re_password = request.getParameter("re_password");
        String A_Salt = request.getParameter("A_Salt");
        String A_Designation = request.getParameter("A_Designation");
    %>

    <%
        //making database connections
        try
        {
            String A_PassHash = Hashing_SHA256.hash(password+A_Salt);
            Class.forName("com.mysql.jdbc.Driver");  // MySQL database connection
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Audit?useSSL=false","root","1234");
            PreparedStatement pst = conn.prepareStatement("Insert into Auditor_Details values (?,?,?,?,?,?,?,?,?)");
            pst.setString(1, A_id);
            pst.setString(2, A_FName);
            pst.setString(3, A_LName);
            pst.setString(4, A_EMail);
            pst.setString(5, A_Contact);
            pst.setString(6, A_Designation);
            pst.setString(7, A_PassHash);
            pst.setString(8, A_Salt);
            pst.setString(9, "00Not_Set00");
            int i = pst.executeUpdate();
            if(i==1)
            {
                out.print("<script>alert('User Details Added. Your Employee ID will be sent to your mail ');");
                out.print("window.location='index.html'; </script>");
            }
            else
            {
                out.print("<script>alert('Please Retry');");
                out.print("window.location='SignUp.html'; </script>");                
            }
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
