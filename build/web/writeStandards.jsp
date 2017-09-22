<%-- 
    Document   : writeStandards
    Created on : 29 Jun, 2017, 2:13:56 PM
    Author     : Shubhankar Nath
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="SecurityFeatures.ActiveSessionCheck"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Write Standards</title>
        <link href="http://fonts.googleapis.com/css?family=Oswald:400,400" rel="stylesheet" type="text/css">
        <link rel="stylesheet" href="css/standardize.css">
        <link rel="stylesheet" href="css/addStandards.css">
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
        
        <div class="container _element"></div>
        <button onClick="window.location='Dashboard.jsp';" class="_button _button-1">Dashboard</button>
        <button onClick="window.location='logout.jsp';" class="_button _button-2">Log Out</button>
        
        <%
            String Qb_Questions = request.getParameter("Qb_Questions");
            String Qb_DocRecommended = request.getParameter("Qb_DocRecommended");
            String Qb_BU_HR = request.getParameter("Qb_BU_HR");
            String Qb_BU_IT = request.getParameter("Qb_BU_IT");
            String Qb_BU_Fin = request.getParameter("Qb_BU_Fin");
            String Qb_BU_Opr = request.getParameter("Qb_BU_Opr");
            String Qb_BU_Mrk = request.getParameter("Qb_BU_Mrk");
            String Qb_BU_Misc = request.getParameter("Qb_BU_Misc");
            String Qb_ISO = request.getParameter("Qb_ISO");
            String Qb_PCIDSS = request.getParameter("Qb_PCIDSS");
            String Qb_SAP = request.getParameter("Qb_SAP");
            String Qb_StdISO = request.getParameter("Qb_StdISO");
            String Qb_StdPCIDSS = request.getParameter("Qb_StdPCIDSS");
            String Qb_StdSAP = request.getParameter("Qb_StdSAP");
            
            try
            {
                Class.forName("com.mysql.jdbc.Driver");  // MySQL database connection
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Audit?useSSL=false","root","1234");
                PreparedStatement pst = conn.prepareStatement("Insert into question_bank (Qb_Questions,Qb_BU_Misc,Qb_BU_Mrk,Qb_BU_Opr,Qb_BU_Fin,Qb_BU_IT,Qb_BU_HR,Qb_DocRecommended,Qb_ISO,Qb_StdISO,Qb_PCIDSS,Qb_StdPCIDSS,Qb_SAP,Qb_StdSAP)"
                        + " values (?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                pst.setString(1, Qb_Questions);
                pst.setString(2, Qb_BU_Misc);
                pst.setString(3, Qb_BU_Mrk);
                pst.setString(4, Qb_BU_Opr);
                pst.setString(5, Qb_BU_Fin);
                pst.setString(6, Qb_BU_IT);
                pst.setString(7, Qb_BU_HR);
                pst.setString(8, Qb_DocRecommended);
                pst.setString(9, Qb_ISO);
                pst.setString(10, Qb_StdISO);
                pst.setString(11, Qb_PCIDSS);
                pst.setString(12, Qb_StdPCIDSS);
                pst.setString(13, Qb_SAP);
                pst.setString(14, Qb_StdSAP);
                
                int rs = pst.executeUpdate();
                if (rs==1)
                {
                    out.print("<div>");
                    out.print("Data Entered");
                    out.print("<button onClick=\"window.location='addStandards.jsp';\">Add More</button>");
                    out.print("</div>");
                }
                else
                {
                    out.print("<script>alert('Please Retry');");
                    out.print("window.location='sddStandards.jsp'; </script>");                
                }
                conn.close();
            }          
            catch(Exception e)
            {
                System.out.println("New Question could not be added");
                System.err.println(e.getClass().getName()+":"+e.getMessage());
                System.exit(0);
            } 
        %>
        
    </body>
</html>
