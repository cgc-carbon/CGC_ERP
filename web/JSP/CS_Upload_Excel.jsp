
<%@page import="com.cgc.upload.Uploadfile"%>
<%@page import="com.cgc.FileManagement.Writer_Excel_POI"%>
<%@page import="com.cgc.FileManagement.Read_Excel_POI"%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page  import="com.cgc.DB.CS_UPLOAD"%>
<%@page trimDirectiveWhitespaces="true" %>
<script>
    function goBack()
    {
        window.history.back()
    }
</script>
<%
    Uploadfile obj_upload = new Uploadfile();
    obj_upload.Uploadfile_Excel_To_DataBase(request,response);
    String result = obj_upload.getResult();
    out.println(result);    
%>

<body>
<tr>
    <td class="columnlabel">&nbsp;</td>
    <td class="columnobject">    
        <button onclick="goBack()">OK</button>
    </td>
</tr>    
</body>