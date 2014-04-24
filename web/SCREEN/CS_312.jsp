<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.UserBean"%>
<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--meta http-equiv="Content-Type" content="text/html; charset=UTF-8"-->
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
    </head>
    
    <body onUnload="closepopup()">
        
        <% UserBean userbean = (UserBean) session.getAttribute("user"); %>
        
        <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
        
        <table  cellpadding="0"  cellspacing="0">
            <tr >
                <td class="ftopleft"></td>
                <td  class="ftopcenter" colspan="2">ข้อความ&nbsp;(CS_312)</td>
                <td class="ftopright"></td>
            </tr>
            <tr>
                <td class="fcenterleft"></td>
                <td  colspan="2" class="fcentercenter">
                    <div align="center">
                        <table  cellpadding="0" cellspacing="0" >
                            <tr>
                                <td colspan="2"  class="blankspace"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel"><b>รหัสข้อความ*</b>&nbsp;</td>
                                <td class="columnobject">
                                    <input name='message_id' type='text' id="message_id" value='' size='10' />
                                    &nbsp;<a href='javascript:;' onClick="openBrWindow('vmessage',312,'Serch_Config.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">ข้อความ*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='message_detail' type='text' id="message_detail" value='' size='50' />                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">แสดงข้อความ*&nbsp;</td>
                                <td class="columnobject"><input type="hidden" name="status" id="status">
                                    <input type="radio" name="radio" id="radio1" value="radio" onClick="getStatus()" checked>
                                    แสดง
                                    <input type="radio" name="radio" id="radio2" value="radio" onClick="getStatus()">
                                    ไม่แสดง</td>
                            </tr>


                            <tr>
                                <td colspan='2' class='blankspace'></td>
                            </tr>
                            <tr>
                                <td colspan='2' class='blankspace'><div align="center">
                                        <input type="hidden" id="chkstatus" value="1"/>
                                        <input type="hidden" id="chkNull" value="message_id,message_detail">
                                        <a href="javascript:;" onClick="cancelAction()"><img alt=""  src="../IMAGES/BTN_CANCEL_90.png" width="80" height="30" border="0"></a>
                                        <a href="javascript:;" onClick="confirmDialogSave(URLsend('chkNull,message_id,message_detail,status,username', '../JSP/CS_312.jsp'))">&nbsp;<img alt=""  src="../IMAGES/BTN_SAVE_90.png" width="80" height="30" border="0">&nbsp;</a>
                                        <a href="javascript:;" onClick="confirmDialogDelete(URLsend('message_id,message_detail,status,chkstatus,username','../JSP/CS_312.jsp'))"><img alt=""  src="../IMAGES/BTN_DEL_90.png" width="80" height="30" border="0"></a></div></td>
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
    <script language="javascript">
        function getStatus(){
            if(document.getElementById("radio1").checked){
                document.getElementById("status").value = 0;
            }else if((document.getElementById("radio2").checked)){
                document.getElementById("status").value = 1;
            }
        }
    </script>
</html>
