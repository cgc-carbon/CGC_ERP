<%@page import="com.cgc.engine.Process_transaction"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%Process_transaction objcom = new Process_transaction();%>
<%!    String date_from, date_to;
%>            
<%
    date_from = (String) request.getParameter("doc_date_from");
    date_to = (String) request.getParameter("doc_date_to");
    System.out.println(request.getParameter("doc_date_from"));
    System.out.println(request.getParameter("doc_date_to"));
%>
<%=
    objcom.main_check(date_from, date_to)
%>