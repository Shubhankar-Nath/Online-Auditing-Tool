<%-- 
    Document   : createCampaign
    Created on : 5 Jul, 2017, 5:05:23 PM
    Author     : Shubhankar Nath
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="SecurityFeatures.ActiveSessionCheck"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Campaign</title>
        <link href="http://fonts.googleapis.com/css?family=Oswald:400,400" rel="stylesheet" type="text/css">
        <link rel="stylesheet" href="css/standardize.css">
        <link rel="stylesheet" href="css/createCampaign.css">
    </head>
    <body class="body page-addstandards clearfix">
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
        <div class="container container-1 "></div>
        <button onClick="window.location='Dashboard.jsp';" class="_button _button-1">Dashboard</button>
        <p class="text text-1">Create Campaign</p>
        <button onClick="window.location='logout.jsp';" class="_button _button-2">Log Out</button>
        
          
        <% 
            try
            {
                Class.forName("com.mysql.jdbc.Driver");  // MySQL database connection
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Audit?useSSL=false","root","1234");
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("Select * from company_details");
                Statement stmt1 = conn.createStatement();
                ResultSet rs1 = stmt1.executeQuery("Select * from auditor_details");                
        %>
        
        <div class="container container-2"></div>
        <form action="startCampaign.jsp" method="post">
            
            <p class="companyid js--company-i-d">Company Name:</p>
            <select class="_input _input-1" name="C_id">
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
            <p class="text text-2">Auditor Name:</p>
            <select class="_input _input-2" name="A_id">
                <%
                    // To get Company id with respect to the company name
                    while (rs1.next())
                    {
                        out.print("<option value ='");
                        out.print(rs1.getString("A_id"));
                        out.print("'>" + rs1.getString("A_FName") + " "+ rs1.getString("A_LName") + "</option>");
                    }
                %>   
            </select>
            <p class="text text-3">Business Unit Applicable:</p>
            <input class="_input _input-3" type="checkbox" name="Qb_BU_HR" value="1"><p class="text text-4">Human Resource</p>
            <input class="_input _input-4" type="checkbox" name="Qb_BU_IT" value="1"><p class="text text-5">IT</p>
            <input class="_input _input-5" type="checkbox" name="Qb_BU_Fin" value="1"><p class="text text-6">Finance</p>
            <input class="_input _input-6" type="checkbox" name="Qb_BU_Opr" value="1"><p class="text text-7">Operational</p>
            <input class="_input _input-7" type="checkbox" name="Qb_BU_Mrk" value="1"><p class="text text-8">Marketing</p>
            <input class="_input _input-8" type="checkbox" name="Qb_BU_Misc" value="1"><p class="text text-9">Miscellaneous</p>
            <p class="text text-10">Standard Applicable:</p>
            <input class="_input _input-9" type="checkbox" name="Qb_ISO" id="Qb_ISO" value="1" ><p class="text text-11">ISO 27001</p>
            <input class="_input _input-10" type="checkbox" name="QB_PCIDSS" id="Qb_PCIDSS" value="1" ><p class="text text-12">PCI-DSS</p>
            <input class="_input _input-11" type="checkbox" name="Qb_SAP" id="Qb_SAP" value="1" ><p class="text text-13">SAP</p>            
            <input class="_button _button-3" type="submit" value="Create">
            
        </form>
        <%
                conn.close();
            }
            catch(Exception e)
                {
                    System.out.println("New Campaign could not be created");
                    System.err.println(e.getClass().getName()+":"+e.getMessage());
                    System.exit(0);
                }    
        %>
    </body>
</html>