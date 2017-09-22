<%-- 
    Document   : strartCampaign
    Created on : 10 Jul, 2017, 3:40:28 PM
    Author     : Shubhankar Nath
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="SecurityFeatures.ActiveSessionCheck"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>startCampaign</title>
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
        
        <%
            //For entry in database
            String C_id = request.getParameter("C_id");
            String A_id = request.getParameter("A_id");
            String Qb_BU_HR = request.getParameter("Qb_BU_HR");
            String Qb_BU_IT = request.getParameter("Qb_BU_IT");
            String Qb_BU_Fin = request.getParameter("Qb_BU_Fin");
            String Qb_BU_Opr = request.getParameter("Qb_BU_Opr");
            String Qb_BU_Mrk = request.getParameter("Qb_BU_Mrk");
            String Qb_BU_Misc = request.getParameter("Qb_BU_Misc");
            String Qb_ISO = request.getParameter("Qb_ISO");
            String QB_PCIDSS = request.getParameter("QB_PCIDSS");
            String Qb_SAP = request.getParameter("Qb_SAP");
            System.out.println("All data from form recieved");
            
            try
            {
                Class.forName("com.mysql.jdbc.Driver");  // MySQL database connection
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Audit?useSSL=false","root","1234");
                PreparedStatement pst = conn.prepareStatement("Insert into campaign_details ( C_id, A_id, Qb_BU_Misc, Qb_BU_Mrk, Qb_BU_Opr, Qb_BU_Fin, Qb_BU_IT, Qb_BU_HR, Qb_ISO, QB_PCIDSS, Qb_SAP, Status )"
                        + " values (?,?,?,?,?,?,?,?,?,?,?,?)");
                
                pst.setString(1, C_id);
                pst.setString(2, A_id);
                pst.setString(3, Qb_BU_Misc);
                pst.setString(4, Qb_BU_Mrk);
                pst.setString(5, Qb_BU_Opr);
                pst.setString(6, Qb_BU_Fin);
                pst.setString(7, Qb_BU_IT);
                pst.setString(8, Qb_BU_HR);
                pst.setString(9, Qb_ISO);
                pst.setString(10, QB_PCIDSS);
                pst.setString(11, Qb_SAP);
                pst.setString(12, "1"); 
                int rs = pst.executeUpdate();
                if (rs==1)
                {
                    System.out.println("Campaign entry made");
                    Statement stmt = conn.createStatement();
                    ResultSet ff = stmt.executeQuery("Select * from campaign_details");
                    ff.last();
                    RequestDispatcher rd=request.getRequestDispatcher("createQs.jsp");
                    request.setAttribute("campaign_id",ff.getString(1));  
                    rd.forward(request, response);
                }
            }
            
            catch(Exception e)
            {
                System.out.println("New Campaign entry could not be made");
                System.err.println(e.getClass().getName()+":"+e.getMessage());
                System.exit(0);
            }
        %>
    </body>
</html>
