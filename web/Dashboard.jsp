<%-- 
    Document   : Dashboard
    Created on : 29 May, 2017, 12:14:03 PM
    Author     : Shubhankar Nath
--%>


<%@page import="SecurityFeatures.ActiveSessionCheck"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.*, java.sql.*, SecurityFeatures.ActiveSessionCheck "%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dashboard</title>
          <link rel="stylesheet" href="css/standardize.css">
          <link rel="stylesheet" href="css/dashboard-grid.css">
          <link rel="stylesheet" href="css/dashboard.css">
    </head>
    <body class="body page-dashboard clearfix">
        <%
            //to get the userdetails from session and time
            String auditor = new String();
            String A_SessionInfo = (String)session.getAttribute("UserData");
            auditor = ActiveSessionCheck.UserCheck(A_SessionInfo);
            if (auditor==null)
            {
                out.print("<script>alert('Session no longer active');");
                out.print("window.location='index.html'</script>");
            }
            GregorianCalendar time= new GregorianCalendar();
            int hour= time.get(Calendar.HOUR_OF_DAY);
        %>
        
        <div class="container _element"></div>
        <p class="text text-1">Hello <% out.print(auditor);%> !</p>
        <p class="text text-2"><span> <b>This is your Dashboard</b> <br>
                
        <%
            //greetings code
          if(hour<12)
            out.print("Good Morning, have a Good Day ahead!");
          else if(hour<17)
            out.print("Good Afternoon");
          else if (hour<20)
            out.print("Good Evening");
          else
            out.print("Good Night");
        %>
        </span></p>
        <button onClick="window.location='Dashboard.jsp';" class="_button _button-1">Dashboard</button>
        <button onClick="window.location='logout.jsp';" class="_button _button-2">Log Out</button>
        
        <div class="container _container"></div>
        <p class="text text-3">Chose your action:</p>
        <button onClick="window.location='CampaignInfo.jsp';" class="_button _button-3">Open Campaign Information</button>
        <button onClick="window.location='createCampaign.jsp';" class="_button _button-4">Create New Campaign</button>
        <button onClick="window.location='addCompanyDetails.html';" class="_button _button-5">Add Company Details</button>
        <button onClick="window.location='addContacts.jsp';" class="_button _button-6">Add Contact Details</button>
        <button onClick="window.location='addStandards.jsp';" class="_button _button-7">Add Standards to Question Bank</button>
    
    </body>
</html>
