<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%!    String path;
    String lookup;
%>
<%
    path = (String) request.getParameter("report_code");
    lookup = (String) request.getParameter("lookup");
    UtiDatabase objuti = new UtiDatabase();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <!-- main calendar program -->
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <!-- language for the calendar -->
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <!-- the following script defines the Calendar.setup helper function, which makes
               adding a calendar a matter of 1 or 2 lines of code. -->
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>
        <script type="text/javascript" src="../JS/myAjaxFramework.js"></script>
        <script type="text/javascript">

            function openBrown(tableID){
                //alert("../JSP/Search_Report.jsp?table="+getId(tableID).value+"");
                window.open("../JSP/Search_Report.jsp?table="+tableID);
            }
            
            var my_window = null;
            function MM_openBrWindow(theURL,winName,features) { //v2.0
                if (my_window == null){
                    my_window = window.open(theURL,winName,features);
                }else{
                    closepopup();
                    my_window = window.open(theURL,winName,features);
                }
            }
           

            function CheckDate(){
                // alert("ok : " + format_Date(getId("date_f").value));
                if(getId("date_f").value != "" && getId("date_t").value != ""){
                    //if(!ChkDate(getId("date_f").value, getId("date_t").value)){
                    //date_form = format_Date(getId("date_f").value);
                    //date_to = format_Date(getId("date_t").value);
                    
                    document.report.date_form.value = format_Date(getId("date_f").value);//dateFormat(da1.format,'yyyy-mm-dd').tostring;
                    document.report.date_to.value =  format_Date(getId("date_t").value);
                    document.report.submit();
                    //}else{
                    //    alert("กรุณาใส่วันที่ให้ถูกต้อง");
                    //}
                    
                }else if(getId("date_f").value == "" && getId("date_t").value == ""){
                    document.report.submit();
                }else{
                    alert("กรุณาใส่วันที่ให้ครบ");
                }
            }
        </script>
    </head>
    <body onunload="closepopup()">
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <input type="hidden" name="report_code" value="<%=path%>">
            <input type="hidden" name="type_report" value="4">
            <input type="hidden" name="lookup" value="<%=lookup%>">
            <input type="hidden" name="date_form" value="">
            <input type="hidden" name="date_to" value="">            
            <table  cellpadding="0"  cellspacing="0">
                <tr>
                    <td class="ftopleft"></td>
                    <td  class="ftopcenter" colspan="2">รายงาน 3&nbsp;</td>
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
                                    <td colspan='2'><b>กำหนดเงื่อนไข การออกรายงาน</b></td>
                                </tr>
                                <tr>

                                </tr>
                                <!--tr>
                                    <td class='columnlabel'>Product ID : &nbsp;</td><td class='columnobject'><input name='product_id' type='text' id="product_id" value='' />
                                        &nbsp;<a href='javascript:;' onclick="javascript:openBrWindow('Mproduct',0,'Serch_Config.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='?????' name='IMAGE1' width='20' height='20' border='0' align='middle' /></a>
                                        <input type="hidden" id="name_t"/>

                                    </td>
                                </tr-->
                                <tr>
                                    <td class="columnlabel">รหัสสินค้า*</td>
                                    <td class="columnobject"><input name="product_id" type="text" id="product_id" value="" size="20" readonly>&nbsp;&nbsp;<a href='#' onClick="openBrWindow('Vproduct', 301, '../JSP/Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;
                                        <input type="hidden" name="product_id_desc" id="product_id_desc" value="" size="70"></td>
                                </tr>                                
                                <tr>
                                    <td class='columnlabel'>Product Group : &nbsp;</td><td class='columnobject'><input name='pgroup_id' type='text' id="pgroup_id" value='' />
                                        &nbsp;<a href='javascript:;' onclick="MM_openBrWindow('../JSP/SearchProductGroup.jsp?chk=0','','scrollbars=yes,width=560,height=500')" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='?????' name='IMAGE1' width='20' height='20' border='0' align='middle' /></a>
                                        <input type="hidden" id="name_t_pgroup"/><input type="hidden" id="remark_pgroup"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class='columnlabel'>Warehouse ID : &nbsp;</td><td class='columnobject'><input name='warehouse_id' type='text' id="warehouse_id" value='' />
                                        &nbsp;<a href='javascript:;' onclick="MM_openBrWindow('../JSP/SearchWareHouse.jsp?chk=0','','scrollbars=yes,width=560,height=500')" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='?????' name='IMAGE1' width='20' height='20' border='0' align='middle' /></a>
                                        <input type="hidden" id="name_t_warehouse"/><input type="hidden" id="remark_wh"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">Branch :&nbsp;</td>
                                    <td class="columnobject">
                                        <%=objuti.ShowSelectBox("select branch_id,name_t from mbranch order by runno desc", "branch_id", "name_t", "branch")%>
                                        <!--select name='shift' id="shift">
                                            <option value='1'>เช้า</option><option value='2'>บ่าย</option><option value='3'>ดึก</option></select>-->&nbsp;&nbsp;&nbsp;
                                    </td>
                                </tr>                                
                                <tr>
                                <tr>
                                    <td class="columnlabel">กองที่(วัตถุดิบ)&nbsp;</td>
                                    <td class="columnobject">
                                        <%=objuti.ShowSelectBox("select location_id,name_t,print_count,runno from vmlocation order by print_count desc ,runno desc", "location_id", "location_id", "location_id")%>&nbsp;</td>
                                    </td>
                                </tr>   
                                </tr>
                                <tr>
                                    <td class='columnobject'><div align="right">วันที่เริ่มต้น&nbsp;:&nbsp;</div></td>
                                    <td class='columnobject'><input name='date_f' type='text' id="date_f" value='' disabled/>
                                        &nbsp;<a id='date_1' href="javascript:;"><img name='IMAGE4' src='../IMAGES/BUTTON/MAIN/CALENDAR20.gif' border='0' align='absmiddle'></a>
                                        <script type='text/javascript'>Calendar.setup({inputField:'date_f',ifFormat:'%d-%m-%Y',showsTime:false,button:'date_1',singleClick:true,step:1});
                                        </script>                                    </td>
                                    <td class='columnobject'><div align="right">ถึงวันที่&nbsp;:&nbsp;</div></td>
                                    <td class='columnobject'><input name='date_t' type='text' id="date_t" value='' disabled/>
                                        &nbsp;<a id='date_2' href="javascript:;"><img name='IMAGE4' src='../IMAGES/BUTTON/MAIN/CALENDAR20.gif' border='0' align='absmiddle'></a>
                                        <script type='text/javascript'>Calendar.setup({inputField:'date_t',ifFormat:'%d-%m-%Y',showsTime:false,button:'date_2',singleClick:true,step:1});</script>                                    
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan='2' class='blankspace' ></td>
                                </tr>

                                <tr>
                                    <td colspan='2' class='blankspace' align="right">
                                        <input type="button" class="cgcButton_11" name="myBut" value=" พิมพ์รายงาน  " onclick="CheckDate()"/>
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
