<%-- 
    Document   : Login_Form
    Created on : Jul 14, 2017, 2:46:19 PM
    Author     : 500038996
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% 
             
        String pass = request.getParameter("pass");
      
        String campaign_id = request.getParameter("campaign_id");
           	 //loading drivers for mysql
        try
        {
            Class.forName("com.mysql.jdbc.Driver");

            //creating connection with the database 
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/Audit?useSSL=false","root","1234");
            PreparedStatement ps =con.prepareStatement("select pass from OTP_Details where campaign_id=? and pass=?");
            ps.setString(1, campaign_id);
            ps.setString(2, pass);
            ResultSet rs =ps.executeQuery();
            if(rs.next())
            {
                RequestDispatcher rp = request.getRequestDispatcher("WebFormClient.jsp");
                rp.forward(request, response);
            }
             else 
            {
               out.print("<script>alert('Incorrect Credentials');");
               out.print("window.location='ClientAuthForm.html'</script>");
            }
        
            con.close();
        }
        catch (Exception e)
        {           
            out.print(" Error Occured! Please Try again ");
            System.out.println("Client Form not authenticated");
            System.err.println(e.getClass().getName()+" : "+e.getMessage());
            System.exit(0);
        }      
       
      %>
    </body>
</html>
