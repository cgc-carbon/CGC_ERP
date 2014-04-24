<%@page import="com.cgc.Util.HeaderScreen_Report"%>
<%@page import="com.cgc.bean.DataBean_Screen_Report"%>
<%@page import="com.cgc.bean.UserBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <%!    String path, lookup, doc_eff_date, doc_no, report_username,sub_menu_id,report_cond1,report_cond2;
    %>
    <%
        lookup = (String) request.getParameter("lookup");
        path = (String) request.getParameter("report_code");

        DataBean_Screen_Report objr_p = new DataBean_Screen_Report();
        HeaderScreen_Report r_p = new HeaderScreen_Report();
        objr_p = r_p.Fn_Report(objr_p, path);        
        sub_menu_id = objr_p.getSub_menu_id();        
        doc_eff_date = objr_p.getDoc_eff_date();
        doc_no = objr_p.getDoc_no();
        report_cond1 = objr_p.getReport_code1();
        report_cond2 = objr_p.getReport_code2();
    %>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css">
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <script type="text/javascript">
            var my_window = null;
            var t;
            function openBrown(tableID,SentToShow)
            {
                t = "../JSP/Search_Report.jsp?table="+tableID+"&sentdataToshow="+SentToShow;
                if(my_window == null)
                    my_window = window.open(t,'','status=1,width=560,height=500');
                else{
                    closepopup();
                    my_window = window.open(t,'','status=1,width=560,height=500');
                }
            }
            function Chknull(){
                if(document.getElementById('DOC_ID_desc').value == ''){
                    alert('กรุณาใส่ข้อมูลเลขที่เอกสาร');
                }else {
                    //report_username = document.getElementById('name').value + document.getElementById('name').value;
                    document.report.submit();
                }    
            }
        </script>
    </head>

    <body onunload="closepopup()">
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <input type="hidden" name="report_code" value="<%=path%>">
            <input type="hidden" name="sub_menu_id" value="<%=sub_menu_id%>">
            <input type="hidden" name="type_report" value="2">
            <input type="hidden" name="lookup" value="<%=lookup%>">
            <input type="hidden" name="doc_eff_date" value="<%=doc_eff_date%>">
            <input type="hidden" name="doc_no" value="<%=doc_no%>">
            <input type="hidden" name="report_cond1" value="<%=report_cond1%>">
            <input type="hidden" name="report_cond2" value="<%=report_cond2%>">
            <table  cellpadding="0"  cellspacing="0">
                <tr>
                    <td class="ftopleft"></td>
                    <td  class="ftopcenter" colspan="2">รายงาน 2&nbsp;</td>
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
                                <tr><td colspan='2'><b>กำหนดเงื่อนไข การออกรายงาน</b></td></tr>
                                <tr><td class='columnlabel'>DOC_ID : &nbsp;</td><td class='columnobject'><input name='DOC_ID_desc' type='text' id="DOC_ID_desc" value='' />
                                        &nbsp;<a href='javascript:;' onclick="openBrown('<%=lookup%>','DOC_ID_desc')" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='?????' name='IMAGE1' width='20' height='20' border='0' align='middle' /></a></td></tr>

                                <tr>
                                    <td colspan='2' class='blankspace' ></td>
                                </tr>

                                <tr>
                                    <td colspan='2'><b>ข้อมูลเพิ่มเติมการออกรายงาน</b></td>
                                </tr>


                                <tr>
                                    <td class="columnlabel">รหัสพนักงาน ผู้จัดทำรายงาน</td>
                                    <td class="columnobject">&nbsp;
                                        <label>
                                            <input type="text" name="emp_id" id="emp_id">
                                            <a href='javascript:;'><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' width='20' height='20' border='0' align='middle' onClick="openBrWindow('vemployee_fullname', 147, 'Search_Config2.jsp')" ></a>                   
                                        </label></td>
                                </tr>

                                <tr>
                                    <td class="columnlabel">ชื่อ - นามสกุล</td>
                                    <td class="columnobject">
                                        <label>
                                            &nbsp;&nbsp;<input type="text" name="name" id="name">
                                            <input type="text" name="lname" id="lname">
                                        </label></td>
                                </tr>  

                                <tr>
                                    <td colspan='2' class='blankspace' align="right">
                                        <input type="button" class="cgcButton_11" name="myBut" value=" พิมพ์รายงาน  " onclick="Chknull()"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan='2' class='blankspace' ></td>
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
        </form>
    </body>
</html>
