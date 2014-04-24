<%@page import="com.cgc.bean.UserBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Header</title>
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
    </head>
    <%
        UserBean userbean = (UserBean) session.getAttribute("user");
    %>
    <script language='javascript'>

        function linkpage(jsppage){
            var mfixcon="";
            with(document.btform){
                action = jsppage;
                submit();
            }
        }
        function Logout(){
            if(confirm('คุณต้องการออกจากระบบใช่หรือไม่')){
                document.submitForm.submit();
            }
        }

    </script>
    <head>
    <BODY BGCOLOR="#F7F7F7" LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0>
        <input type="hidden" id="logout"/>
        <TABLE BORDER=0 align="center" CELLPADDING=0 CELLSPACING=0>
            <TR>
                <TD COLSPAN=9 align="center"><img src="../IMAGES/HEADER/MAIN_9.png"/></TD>
            </TR>

            <TR valign="top">
                <TD width="50">&nbsp;</TD>
                <TD COLSPAN=5 align="center" valign="top">
                    <form name="submitForm" target="_top" action="../JSP/Logout.jsp">
                        <div>
                            <pre><a href="javascript:;" onClick="Logout()"><span class="style2">
                                 <img src="../IMAGES/exit_btn_48.png" width="21" height="21" border="0"/><strong>ออกจากระบบ</strong></span></a></pre>
                        </div>
                    </form>                
                </TD>
                <td width="454" class="company"><div align="left"><marquee behavior="scroll" direction="left"><%=userbean.getMessage_disp()%></marquee></div></td>
                <td width="350" valign="middle" class="company">                    
                    <div align="right">ผู้ใช้ : <%=userbean.getUsername()%> &nbsp; <script language="javascript">MyDate('tha')</script></div></td>
                <td width="96" class="columnobject">
                    <p align="right">&nbsp;</p>
                </td>
            </TR>
        </TABLE>
    </BODY>
</head>
</html>