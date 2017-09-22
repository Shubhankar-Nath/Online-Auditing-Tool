<%-- 
    Document   : addContacts
    Created on : 16 Jun, 2017, 11:12:19 AM
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
        <title>Add Contacts</title>
        <link href="http://fonts.googleapis.com/css?family=Oswald:400,400" rel="stylesheet" type="text/css">
        <link rel="stylesheet" href="css/standardize.css">
        <link rel="stylesheet" href="css/addContacts.css">
    </head>

    <body class="body page-addcontacts clearfix">
        <div class="container "></div>
        <%
            String auditor = new String();
            String A_SessionInfo = (String)session.getAttribute("UserData");
            auditor = ActiveSessionCheck.UserCheck(A_SessionInfo);
            if (auditor==null)
            {
                out.print("<script>alert('Session no longer active');");
                out.print("window.location='index.html'</script>");
            }
        %>
            
        <% try
            {
                Class.forName("com.mysql.jdbc.Driver");  // MySQL database connection
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Audit?useSSL=false","root","1234");
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("Select * from company_details");                
        %>
        
        <form method ="post" action="addContactDetails.jsp">
            <p id="Title" class="fname ">Company Title:</p>
            <select name ="C_id" class="_input _input-5">                 
                <%
                    // To get Company id with respect to the company name
                    while (rs.next())
                    {
                        out.print("<option value ='");
                        out.print(rs.getString("C_id"));
                        out.print("'>" + rs.getString("C_Title") + "</option>");
                    }
                %>                
            </select>
            <p class="email ">Contact Name:</p>
            <input type="text" name="Comapny_PersonalName" class="_input _input-4" required />
            <p class="element element-2 ">Designation:</p>
            <input type="text" name="Comapny_PersonalDesignation" class="_input _input-3" required />
            <p class="element element-1 ">Phone Number:</p>
            <input type="text" name="Comapny_PersonalPhone" maxlength="12" class="_input _input-2" required />
            <p class="mail ">E-Mail:</p>
            <input type="text" name="Comapny_PersonalEmail" class="_input _input-1" required />
            <input type = "Submit" value ="Save" class="_button"/>
        </form>
            <p id="message" class="text js-message">" Enter details for new Contact in the company "</p>
        
        <%
                conn.close();
            }
            catch(Exception e)
                {
                    System.out.println("New Contact details could not be saved");
                    System.err.println(e.getClass().getName()+":"+e.getMessage());
                    System.exit(0);
                }    
        %>
                
    </body>
</html>
