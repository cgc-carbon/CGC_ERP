<%@page import="com.cgc.bean.UserBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <%
        UserBean userbean = (UserBean) session.getAttribute("user");
    %>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <script type="text/javascript">
            function ckvalue()
            {
                if(getId("passwordnew_1").value == getId("passwordnew_2").value && getId("passwordnew_1").value != getId("password").value && getId("passwordnew_2").value != getId("password").value)
                {
                    //alert("test2");
                    confirmDialogSave(URLsend('chkNull,username,password,passwordnew_1,passwordnew_2','../JSP/CS_006.jsp'))
                }
                else if(getId("passwordnew_1").value == getId("password").value && getId("passwordnew_2").value == getId("password").value )
                {
                    alert("คุณกรอกรหัสผ่านเหมือนเดิม กรุณากรอกรหัสผ่านใหม่ถ้าต้องการเปลี่ยนรหัสผ่าน");
                }
                else
                {
                    alert("คุณกรอก Password ไม่เหมือนกัน กรุณากรอกใหม่");
                }
            }
        </script>
    </head>

    <body>
        <input type="hidden" id="chkNull" value="passwordnew_1,passwordnew_2">
        <table  cellpadding="0"  cellspacing="0">
            <tr>
                <td class="ftopleft"></td>
                <td  class="ftopcenter" colspan="2">ผู้ใช้งาน&nbsp;(CS_006)</td>
                <td class="ftopright"></td>
            </tr>
            <tr >
                <td class="fcenterleft"></td>
                <td  colspan="2" class="fcentercenter">
                    <div align="center">
                        <table  cellpadding="0" cellspacing="0" >
                            <tr>
                                <td colspan="2"  class="blankspace"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel"><b>ผู้ใช้งาน*</b>&nbsp;</td>
                                <td class="columnobject">
                                    <input name="username" type="text" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">รหัสผ่านเดิม&nbsp;</td>
                                <td class="columnobject">
                                    <input name="password" type="password" id="password" value="" size="30"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">รหัสผ่านใหม่&nbsp;</td>
                                <td class="columnobject">
                                    <input name="passwordnew_1" type="password" id="passwordnew_1" value="" size="30"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">รหัสผ่านใหม่(อีกครั้ง)&nbsp;</td>
                                <td class="columnobject">
                                    <input name="passwordnew_2" type="password" id="passwordnew_2" value="" size="30"/>
                                </td>
                            </tr>

                            <tr>
                                <td colspan='2' class='blankspace'>
                                    <br>
                                    <div align="center">
                                        <a href="javascript:;" onclick="cancelAction()"><img alt=""  src="../IMAGES/BTN_CANCEL_90.png" width="80" height="30" border="0"></a>
                                        <a href="javascript:;" onClick="ckvalue()"><img alt=""  src="../IMAGES/BTN_SAVE_90.png" width="80" height="30" border="0"></a>
                                    </div>
                                    <br>
                                </td>
                            </tr>
                        </table>
                    </div></td>
                <td class="fcenterright"></td>
            </tr>
            <tr bordercolor="0069B3">
                <td class="ffootleft"></td>
                <td  class="ffootcenter" colspan="2"></td>
                <td class="ffootright"></td>
            </tr>
        </table>

    </body>
</html>