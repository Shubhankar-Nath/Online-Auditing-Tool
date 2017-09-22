<%-- 
    Document   : addStandards
    Created on : 19 Jun, 2017, 3:21:46 PM
    Author     : Shubhankar Nath
--%>

<%@page import="SecurityFeatures.ActiveSessionCheck"%>
<%@page import="SecurityFeatures.RandStringGenerator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Standards</title>
        <link href="http://fonts.googleapis.com/css?family=Oswald:400,400" rel="stylesheet" type="text/css">
        <link rel="stylesheet" href="css/standardize.css">
        <link rel="stylesheet" href="css/addStandards.css">
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
        <div class="container _element js--header"></div>
        <button onClick="window.location='Dashboard.jsp';" class="_button _button-1">Dashboard</button>
        <p class="text text-1">Add to Question Bank</p>
        <button onClick="window.location='logout.jsp';" class="_button _button-2 js-logout">Log Out</button>
        <div class="container _container"></div>
        <form action="writeStandards.jsp" method="post">
            <p class="text text-2">Question:</p>
            <p class="text text-3">Recomended Evidence:</p>
            <input class="_input _input-1" type="text" name="Qb_Questions">
            <input class="_input _input-2" type="text" name="Qb_DocRecommended">
            <p class="text text-4">Buisness Unit Applicable:</p>
            <input class="_input _input-3" type="checkbox" name="Qb_BU_HR" value="1"><p class="text text-5">Human Resource</p>
            <input class="_input _input-4" type="checkbox" name="Qb_BU_IT" value="1"><p class="text text-6">IT</p>
            <input class="_input _input-5" type="checkbox" name="Qb_BU_Fin" value="1"><p class="text text-7">Finance</p>
            <input class="_input _input-6" type="checkbox" name="Qb_BU_Opr" value="1"><p class="text text-8">Operational</p>
            <input class="_input _input-7" type="checkbox" name="Qb_BU_Mrk" value="1"><p class="text text-9">Marketing</p>
            <input class="_input _input-8" type="checkbox" name="Qb_BU_Misc" value="1"><p class="text text-10">Miscellaneous</p>
            <p class="text text-11">Standard Applicable:</p>
            <input class="_input _input-9" type="checkbox" name="Qb_ISO" id="Qb_ISO" value="1" onchange="check1()"><p class="text text-12">ISO 27001</p>
            <input class="_input _input-10" type="checkbox" name="Qb_PCIDSS" id="Qb_PCIDSS" value="1" onchange="check2()"><p class="text text-13">PCI-DSS</p>
            <input class="_input _input-11" type="checkbox" name="Qb_SAP" id="Qb_SAP" value="1" onchange="check3()"><p class="text text-14">SAP</p>
            <p class="text text-15" id="Sec" style="display: none">Section:</p>
            <input class="_input _input-12" type="text" name="Qb_StdISO" id="Qb_StdISO" style="display: none">
            <input class="_input _input-13" type="text" name="Qb_StdPCIDSS" id="Qb_StdPCIDSS" style="display: none">
            <input class="_input _input-14" type="text" name="Qb_StdSAP" id="Qb_StdSAP" style="display: none">
            <input class="_button _button-3" type="submit" value="Submit">
        </form>
        <script src="js/addStandards.js" type="text/javascript" >
        </script>            
    </body>
</html>
