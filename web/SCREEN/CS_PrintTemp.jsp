<%@page import="com.cgc.bean.UserBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css">
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>
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
                /*if(document.getElementById('job_id').value == ''){
                    alert('กรุณาใส่ข้อมูลเลขที่เอกสาร');
                }else*/
        document.report.submit();
            }
        </script>
    </head>

    <body onUnload="closepopup()">
        <form name="report" method="post" action="../JSP/CS_PrintTemp.jsp">
          <table  cellpadding="0"  cellspacing="0">
                <tr>
                    <td class="ftopleft"></td>
                    <td  class="ftopcenter" colspan="2"><b>รายงานการผลิตถ่านกัมมันต์ ประจำวัน</b>&nbsp;</td>
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
                                  <td colspan='2'>&nbsp;</td>
                              </tr><tr>
                                <td class='columnlabel'>วันที่การผลิต : &nbsp;</td>
                          <td class='columnobject'><!--<input name='job_id' type='text' id="job_id" value='' />
                                        &nbsp;<a href='javascript:;' onClick="openBrown('d_job_order_header','job_id')" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' /></a>-->
                          <input name='doc_date' type='text' id="doc_date" value='' size='10' readonly="readonly"/>
                                    &nbsp;<a id='date_1' ><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.gif' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField:'doc_date',ifFormat:'%d-%m-%Y',showsTime:false,button:'date_1',singleClick:true,step:1});</script>&nbsp;&nbsp;</td></tr>

                                <tr>
                                    <td colspan='2' class='blankspace' ></td>
                                </tr>

                                <tr>
                                    <td colspan='2' class='blankspace' align="right">
                                        <input type="button" class="cgcButton_11" name="myBut" value=" Export Data  " onClick="Chknull()"/>
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
