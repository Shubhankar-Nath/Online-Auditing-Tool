<%-- 
    Document   : addCompanyDetails
    Created on : 9 Jun, 2017, 5:41:14 PM
    Author     : Shubhankar Nath
--%>

<%@page import="Others.NewIDGeneration"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Company Details</title>
    </head>
    <body>
        
        <%
            //Finfing the right C_id
            String lastID = new String();

            try
            {
                Class.forName("com.mysql.jdbc.Driver");  // MySQL database connection
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Audit?useSSL=false","root","1234");
                PreparedStatement pst = conn.prepareStatement("Select * from Company_Personal");
                ResultSet rs = pst.executeQuery();
                if (rs.last())//Fetching the last entry
                {
                    //System.out.println(rs.next());
                    lastID = rs.getString(1);
                    int buffer = Integer.valueOf(lastID.substring(4,9));
                    buffer++;
                }
                conn.close();
            }
            
            
            catch(Exception e)
            {
                System.out.println("Last Company ID could not be fetched");
                System.err.println(e.getClass().getName()+":"+e.getMessage());
                System.exit(0);
            }
        %>
        
        <%
            String C_id = NewIDGeneration.Generate(lastID);
            String C_Title = request.getParameter("C_Title");
            String C_Email = request.getParameter("C_Email");
            String C_Contact = request.getParameter("C_Contact");
            String C_Description = request.getParameter("C_Description");
            String C_Address = request.getParameter("C_Address");            

            try
            {
                Class.forName("com.mysql.jdbc.Driver");  // MySQL database connection
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Audit?useSSL=false","root","1234");
                PreparedStatement pst = conn.prepareStatement("Insert into Company_details values (?,?,?,?,?,?)");
                pst.setString(1, C_id);
                pst.setString(2, C_Title);
                pst.setString(3, C_Email);
                pst.setString(4, C_Contact);
                pst.setString(5, C_Description);
                pst.setString(6, C_Address);
                int rs = pst.executeUpdate();
                if (rs==1)
                {
                    out.print("Company Details Added Seccessfully<br>");
                    out.print("<button onClick=\"window.location='Dashboard.jsp';\" >Dashboard</button>");
                    out.print("<button onClick=\"window.location='addCompanyDetails.html';\">Add More</button>");
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
