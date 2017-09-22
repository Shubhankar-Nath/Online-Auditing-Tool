<%@page import="Others.Export"%>
<%
    //Handler opf ajax request
    String id = request.getParameter("camp_id");
    String reply=Export.writeXls(id);
    out.print(reply);
%>
