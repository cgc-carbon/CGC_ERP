<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.UserBean"%>
<html>
    <head>
        <title></title>
        <script type="text/javascript" src="../JS/myAjaxFramework.js">
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
    </head>
    <body onUnload="closepopup()">
        <%UserBean userbean = (UserBean) session.getAttribute("user");%>
        <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
        <input type="hidden" id="chkNull" value="prd_place,name_t">
        <input type="hidden" id="status_u" value ="2">
        <input type = "hidden" id ="status_d" value ="3">
        <table  cellpadding="0"  cellspacing="0">
            <tr >
                <td class="ftopleft"></td>
                <td  class="ftopcenter" colspan="2">ทะเบียนเครื่องจักรผลิต&nbsp;(CS_201)</td>
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
                                <td class="columnlabel"><b>รหัสเครื่องจักรผลิต*</b>&nbsp;</td>
                                <td class="columnobject">
                                    <input type='text' name='prd_place' size='10' value='' id="prd_place" />
                                    &nbsp;<a href='javascript:;' onClick="openBrWindow('vmproduction_place',201,'Serch_Config.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
                                    <input type='text' name='name_t' size='30' value='' id="name_t" />
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel"><b>รหัสประเภทงาน*</b>&nbsp;</td>
                                <td class="columnobject">
                                    <input type='text' name='job_type_id' size='10' value='' id="job_type_id" />
                                    &nbsp;<a href='javascript:;' onClick="openBrWindow('mjob_type',206,'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
                                    <input type='text' name='job_name_t' size='30' value='' id="job_name_t" />
                                </td>
                            </tr>                           
                            <tr>
                                <td class="columnlabel">หมายเหตุ&nbsp;</td>
                                <td class="columnobject"><textarea name='remark' rows='5' cols='40' id="remark"></textarea></td>
                            </tr>

                            <tr>
                                <td colspan='2' class='blankspace'>
                                    <br>
                                    <div align="center">
                                        <a href="javascript:;" onClick="cancelAction()"><img alt=""  src="../IMAGES/BTN_CANCEL_90.png" width="80" height="30" border="0"></a>
                                        <a href="javascript:;" onClick="confirmDialogSave(URLsend('chkNull,prd_place,name_t,job_type_id,remark,username','../JSP/CS_201.jsp'))"><img alt=""  src="../IMAGES/BTN_SAVE_90.png" width="80" height="30" border="0"></a>
                                        <a href="javascript:;" onClick="confirmDialogDelete(URLsend('prd_place,name_t,job_type_id,remark,status_d,username','../JSP/CS_201.jsp'))"><img alt=""  src="../IMAGES/BTN_DEL_90.png" width="80" height="30" border="0"></a>
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
