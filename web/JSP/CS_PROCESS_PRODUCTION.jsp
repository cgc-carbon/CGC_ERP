<%@page import="com.cgc.engine.Process_production"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%Process_production objcom = new Process_production();%>
<%!    String job_id;
%>            
<%
    job_id = (String) request.getParameter("job_id");
    System.out.println(request.getParameter("job_id"));

%>
<%= objcom.main_check(job_id) %>