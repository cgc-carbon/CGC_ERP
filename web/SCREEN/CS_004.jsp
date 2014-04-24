<%@page import="com.cgc.DB.MenuDAO"%>
<%@page import="com.cgc.bean.MenuBean"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <script type="text/javascript">
            function clearckbox()
            {
                for(i=0;i<document.getElementsByName("menu").length;i++)
                {
                    document.getElementsByName("menu")[i].checked =false;
                }
                openBrWindow('Priviledge',4,'Serch_Config.jsp');
            }
            function RunBox() { //v2.0
                var list = new Array();
                var box = String();
                box = "";
                list = document.getElementsByName("menu");
                for(i=0;i<list.length;i++){
                    if (document.getElementsByName("menu")[i].checked == true){
                        box = box + list[i].value+",";
                    }
                }
                box = box.substr(0, box.length-1);
                document.getElementById("box").value = box;
                confirmDialogSave(URLsend('chkNull,priviledge_id,name_t,remark,box','../JSP/CS_004.jsp'));
            }
        </script>
        <title>JSP Page</title>
    </head>
    <%!        MenuBean menuBean = new MenuBean();
        MenuDAO menuDAO = new MenuDAO();
        ArrayList<MenuBean> listMain, listSub;
        String text = "";
    %>
    <%
                text = "<div nowrap><ul>";
                listMain = new ArrayList<MenuBean>();
                listSub = new ArrayList<MenuBean>();
                listMain = menuDAO.selectDataMainList();
                for (MenuBean mainBean : listMain) {
                    text = text + "<li><font size='2'><input type='checkbox' value='" + mainBean.getMain_menu_id() + "' name='menu' id='" + mainBean.getMain_menu_id() + "'>" + " " + mainBean.getName_t() + " - " + mainBean.getMain_menu_id() + "</font></li><ul>\n";
                    listSub = menuDAO.selectDataSubList(mainBean.getMain_menu_id());
                    for (MenuBean subBean : listSub) {
                        text = text + "<li><font size='2'><input type='checkbox' value='" + subBean.getSub_menu_id() + "' name='menu' id='" + subBean.getSub_menu_id() + "'>" + " " + subBean.getName_t() + " - " + subBean.getSub_menu_id() + "</font></li>\n";
                    }
                    text = text + "</ul>";
                }
                text = text + "</ul></div>";


    %>
    <body onunload="closepopup()">
        <table  cellpadding="0"  cellspacing="0">
            <tr >
                <td class="ftopleft"></td>
                <td  class="ftopcenter" colspan="2">สิทธิ์การใช้งาน&nbsp;(CS_004)</td>
                <td class="ftopright"></td>
            </tr>
            <tr >
                <td class="fcenterleft"></td>
                <td  colspan="2" class="fcentercenter">
                    <div align="left">
                        <table  cellpadding="0" cellspacing="0" >
                            <tr>
                                <td colspan="2"  class="blankspace"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel"><b>รหัสสิทธิ์การใช้งาน*</b>&nbsp;</td>
                                <td class="columnobject">
                                    <input name='priviledge_id' type='text' id="priviledge_id" value='' size='10' />
                                    &nbsp;<a href='javascript:;' onclick="clearckbox()"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
                                    <input name='name_t' type='text' id="name_t" value='' size='30' />                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">หมายเหตุ&nbsp;</td>
                                <td class="columnobject"><textarea name='remark' cols='40' rows='5' id="remark"></textarea></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">กำหนดสิทธิ์การเข้าใช้งานระบบ&nbsp;</td>
                                <td class="columnobject"></td>
                            </tr>
                            <tr >
                                <td valign="top"  class="columnlabel">&nbsp;</td>
                                <td valign="top" >
                                    <div align="left">
                                        <table  class="large" border="0" cellpadding="0" cellspacing="0" >
                                            <tr>
                                                <td class="writeback"><%=text%></td>
                                            </tr>
                                        </table>
                                    </div></td>
                            </tr>
                            <tr>
                                <td colspan='2' class='blankspace'></td>
                            </tr>
                            <tr>
                                <td colspan='2' class='blankspace'><div align="center">
                                        <input type="hidden" id="chkNull" value="priviledge_id,name_t">
                                        <input type="hidden" id="chkstatus" value="1">
                                        <input type="hidden" id="box" value="">
                                        <a href="javascript:;" onclick="cancelAction()"><img alt=""  src="../IMAGES/BTN_CANCEL_90.png" width="80" height="30" border="0"></a>
                                        <a href="javascript:;" onClick="RunBox();">&nbsp; <img alt=""  src="../IMAGES/BTN_SAVE_90.png" width="80" height="30" border="0">&nbsp;</a>
                                    </div></td>
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
