<%-- 
    Document   : createQs
    Created on : 11 Jul, 2017, 2:32:09 PM
    Author     : Shubhankar Nath
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="SecurityFeatures.ActiveSessionCheck"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Question</title>
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

            //Hnadling campaign creation logic
            String Qb_BU_HR = request.getParameter("Qb_BU_HR");
            String Qb_BU_IT = request.getParameter("Qb_BU_IT");
            String Qb_BU_Fin = request.getParameter("Qb_BU_Fin");
            String Qb_BU_Opr = request.getParameter("Qb_BU_Opr");
            String Qb_BU_Mrk = request.getParameter("Qb_BU_Mrk");
            String Qb_BU_Misc = request.getParameter("Qb_BU_Misc");
            String Qb_ISO = request.getParameter("Qb_ISO");
            String QB_PCIDSS = request.getParameter("QB_PCIDSS");
            String Qb_SAP = request.getParameter("Qb_SAP");
            String campaign_id = (String)request.getAttribute("campaign_id");
                    System.out.println("Here: "+Qb_BU_IT);
            try
            {
                Class.forName("com.mysql.jdbc.Driver");  // MySQL database connection
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Audit?useSSL=false","root","1234");
                Statement stmt = conn.createStatement();
                
                String sql = "Create table Qs" + campaign_id + " (Q_id mediumint(8) primary key, Q_question text, Q_DocRecomended varchar(30), Q_Result text, "
                        + " Q_Comment text, Q_Status varchar(1) default '0', Q_StdISO varchar(15), Q_StdPCIDSS varchar(15), Q_StdSAP varchar(15) )";
                
                int i=stmt.executeUpdate(sql);
                if(i>0)
                {
                    System.out.println("Create table querry runned");
                }
                sql = "Insert into Qs" + campaign_id + " ( Q_id, Q_question, Q_DocRecomended, Q_StdISO, Q_StdPCIDSS, Q_StdSAP ) "
                        + " select Qb_ID, Qb_Questions, Qb_DocRecommended, Qb_StdISO, Q_StdPCIDSS, Qb_StdSAP from Question_bank"
                        + " where Qb_BU_Misc="+ Qb_BU_Misc +" or Qb_BU_Mrk=" + Qb_BU_Mrk +" or Qb_BU_Opr=" + Qb_BU_Opr+" or Qb_BU_Fin=" + Qb_BU_Fin
                        +" or Qb_BU_IT=" + Qb_BU_IT +" or Qb_BU_HR=" + Qb_BU_HR +" and (Qb_ISO=" + Qb_ISO +" or QB_PCIDSS=" + QB_PCIDSS +" or Qb_SAP=" + Qb_SAP+")";
                int j = stmt.executeUpdate(sql);
                if(j>0)
                {
                    System.out.println("Question table filled");
                    String otp = Others.OTP.generateOTP(campaign_id);
                    out.print("<br>Campaign ID: " + campaign_id);
                    out.print("<br>Password: " + otp );
                    out.print("<br><a href='Dashboard.jsp'><button>Dashboard</button></a>");
                    out.print("<br>Client form Link: <b> http://localhost:8080/Audit/ClientAuthForm.html<b>");
                }
                conn.close();
            }
            
            catch(Exception e)
            {
                System.out.println("New Questionare database could not be created");
                System.err.println(e.getClass().getName()+":"+e.getMessage());
                System.exit(0);
            }
        %>
            
        </body>
</html>
