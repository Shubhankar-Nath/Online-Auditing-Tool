<%-- 
    Document   : addContactDetails
    Created on : 16 Jun, 2017, 2:12:51 PM
    Author     : Shubhankar Nath
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Contact details entering page</title>
    </head>
    <body>
        <%
            String C_id = request.getParameter("C_id");
            String Comapny_PersonalName = request.getParameter("Comapny_PersonalName");
            String Comapny_PersonalDesignation = request.getParameter("Comapny_PersonalDesignation");
            String Comapny_PersonalPhone = request.getParameter("Comapny_PersonalPhone");
            String Comapny_PersonalEmail = request.getParameter("Comapny_PersonalEmail");
             try
            {
                Class.forName("com.mysql.jdbc.Driver");  // MySQL database connection
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Audit?useSSL=false","root","1234");
                PreparedStatement pst = conn.prepareStatement("Insert into Company_personal values (?,?,?,?,?)");
                pst.setString(1, C_id);
                pst.setString(2, Comapny_PersonalName);
                pst.setString(3, Comapny_PersonalDesignation);
                pst.setString(4, Comapny_PersonalPhone);
                pst.setString(5, Comapny_PersonalEmail);
                int rs = pst.executeUpdate();
                if (rs==1)
                {
                    out.print("Company Details Added Seccessfully<br>");
                    out.print("<button onClick=\"window.location='Dashboard.jsp';\" >Dashboard</button>");
                    out.print("<button onClick=\"window.location='addContacts.html';\">Add More</button>");
                }
                conn.close();
            }
            
            catch(Exception e)
            {
                System.out.println("New Company details could not be added");
                System.err.println(e.getClass().getName()+":"+e.getMessage());
                System.exit(0);
            }           
        %>
    </body>
</html>
