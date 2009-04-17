<%-- 
    Document   : index
    Created on : Apr 3, 2009, 9:02:29 AM
    Author     : corinna
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        
    <%-- start web service invocation --%>
    <%
    try {
	edu.lter.projectdb.ws.LTERprojectService service = new edu.lter.projectdb.ws.LTERprojectService();
	edu.lter.projectdb.ws.LTERproject port = service.getLTERprojectPort();
	 // TODO initialize WS operation arguments here
	java.lang.String projectId = "knb-lter-cap.10.1";
	// TODO process result here
	java.lang.String result = port.getProjectById(projectId);
	out.println(result);
    } catch (Exception ex) {
	// TODO handle custom exceptions here
    }
    %>
    <%-- end web service invocation --%>
    </body>
</html>
