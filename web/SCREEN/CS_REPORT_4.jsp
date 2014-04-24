<%@page import="com.cgc.bean.UserBean"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <%!        UtiDatabase objuti = new UtiDatabase();
        String path, lookup;
    %>
    <%
        lookup = (String) request.getParameter("lookup");
        path = (String) request.getParameter("report_code");
    %>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>        
        <script type="text/javascript">
            var my_window = null;
            function openBrown(tableID,SentToShow){
                if(my_window == null){
                    my_window = window.open("../JSP/Search_Report.jsp?table="+tableID+"&sentdataToshow="+SentToShow,'','status=1,width=560,height=500');
                }else{
                    closepopup();
                    my_window = window.open("../JSP/Search_Report.jsp?table="+tableID+"&sentdataToshow="+SentToShow,'','status=1,width=560,height=500');
                }
            }
                   
            function CheckDate(){
                
                var da1 = new Date(document.report.date_f.value);
                var da2 = new Date(document.report.date_t.value);
                
                               
                var d1 = document.report.date_f.value;
                var d2 = document.report.date_t.value;
                //var p1 = document.report.param_f.value;
                //var p2 = document.report.param_t.value;         
                  
               
                if(da1 <= da2 || d1 == '' || d2 == ''){
                    if (d1 != '' || d2 != ''){
                        if(d1 != ''){
                            if(d2 == ''){
                                alert('กรุณาใส่ข้อมูลวันที่สิ้นสุดการออกรายงาน');
                            }else{
                                document.report.date_form.value = format_Date(d1);//dateFormat(da1.format,'yyyy-mm-dd').tostring;
                                document.report.date_to.value =  format_Date(d2);//dateFormat(da2,'yyyy-mm-dd').tostring;
                                document.report.submit();
                            }
                        }else if(d2 != ''){
                            if(d1 == '')
                            {
                                alert('กรุณาใส่ข้อมูลวันที่เริ่มต้นการออกรายงาน');
                            }else {
                                document.report.date_form.value = format_Date(d1);
                                document.report.date_to.value = format_Date(d2);
                                document.report.submit();
                            }
                        }
                    }
                } else 
                { 
                    document.report.date_form.value = format_Date(d1);
                    document.report.date_to.value = format_Date(d2);
                    document.report.submit();
                }
            }
                      
            function getStatus(){
                if(document.getElementById("radio1").checked){
                    document.getElementById("status").value = 0;
                }else if((document.getElementById("radio2").checked)){
                    document.getElementById("status").value = 1;
                }
            }

            function getStatus1(){
                if(document.getElementById("radio11").checked){
                    document.getElementById("status1").value = 0;
                }else if((document.getElementById("radio12").checked)){
                    document.getElementById("status1").value = 1;
                }
            }

            function getStatus2(){
                if(document.getElementById("radio13").checked){
                    document.getElementById("status2").value = 0;
                }else if((document.getElementById("radio14").checked)){
                    document.getElementById("status2").value = 1;
                }
            }
            
            function CheckPrint(){
                document.report.submit();
            }            
            
		   
        </script>
    </head>

    <body onUnload="closepopup()">
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <input type="hidden" name="report_code" value="<%=path%>">
            <input type="hidden" name="lookup" value="<%=lookup%>">
            <table  cellpadding="0"  cellspacing="0">
                <tr>
                    <td class="ftopleft"></td>
                    <td  class="ftopcenter" colspan="2">รายงาน 4 &nbsp;</td>
                    <td class="ftopright"></td>
                </tr>
                <tr >
                    <td class="fcenterleft"></td>
                    <td  colspan="2" class="fcentercenter">

                        <div align="center">
                            <input type="hidden" name="type_report" value="5">
                            <input type="hidden" name="date_form" value="">
                            <input type="hidden" name="date_to" value="">
                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="5"  class="blankspace"></td>
                                </tr>

                                <tr><td colspan='5'><b>กำหนดเงื่อนไข การออกรายงาน</b></td>
                                </tr>

                                <%if ((path.charAt(6) != '8') && (path.charAt(6) != '9')) {%>

                                <tr>
                                    <td width="153" class='columnobject'><div align="right">Date&nbsp;:&nbsp;</div></td>
                                    <td width="193" class='columnobject'><input name='date_f' type='text' id="date_f" value='' disabled/>
                                        &nbsp;<a id='date_1' href="javascript:;"><img name='IMAGE4' src='../IMAGES/BUTTON/MAIN/CALENDAR20.gif' border='0' align='absmiddle'></a>
                                        <script type='text/javascript'>Calendar.setup({inputField:'date_f',ifFormat:'%d-%m-%Y',showsTime:false,button:'date_1',singleClick:true,step:1});</script>                                    </td>
                                    <td width="71" class='columnobject'><div align="right">To&nbsp;:&nbsp;</div></td>
                                    <td width="338" class='columnobject'><input name='date_t' type='text' id="date_t" value='' disabled/>
                                        &nbsp;<a id='date_2' href="javascript:;"><img name='IMAGE4' src='../IMAGES/BUTTON/MAIN/CALENDAR20.gif' border='0' align='absmiddle'></a>
                                        <script type='text/javascript'>Calendar.setup({inputField:'date_t',ifFormat:'%d-%m-%Y',showsTime:false,button:'date_2',singleClick:true,step:1});</script>                                    </td>
                                </tr>                                
                                <tr>
                                    <td class="columnlabel">เงื่อนไขเพิ่มเติม รับเชื้อเพลิง </td>
                                    <td class="columnobject">&nbsp;&nbsp;
                                        <input type="hidden" id="status1" name="status1">
                                        <input type="radio" name="radio1" id="radio11" onClick="getStatus1()" checked>
                                        ไม่ใช้ 
                                        <input type="radio" name="radio1" id="radio12" onClick="getStatus1()">
                                        ใช้                                 
                                </tr>         
                                <tr>
                                    <td class="columnlabel">ประเภทเชื้อเพลิง*&nbsp;</td>
                                    <td class="columnobject">
                                        <%=objuti.ShowSelectBox("select product_id,name_t from m_fuel order by runno", "product_id", "name_t", "product_id")%>
                                        <input type="hidden" id="product_id" value="">
                                    </td>
                                </tr>           
                                <tr>
                                    <td class="columnlabel">เงื่อนไขเพิ่มเติม รับเชื้อเพลิง </td>
                                    <td class="columnobject">&nbsp;&nbsp;
                                        <input type="hidden" id="status2" name="status2">
                                        <input type="radio" name="radio2" id="radio13" onClick="getStatus2()" checked>
                                        ไม่ใช้ 
                                        <input type="radio" name="radio2" id="radio14" onClick="getStatus2()">
                                        ใช้                                 
                                </tr>         
                                <tr>
                                    <td class="columnlabel">ผู้ขาย/Supplier*&nbsp;</td>
                                    <td class="columnobject">
                                        <%=objuti.ShowSelectBox("select supplier_id,name_t from msupplier order by runno", "supplier_id", "name_t", "supplier_id")%>
                                        <input type="hidden" id="supplier_id" value="">
                                    </td>
                                </tr>                                  
                                <tr>
                                    <td class="columnlabel">เงื่อนไขเพิ่มเติม ฝ่ายผลิต (ด้านล่าง)</td>
                                    <td class="columnobject">&nbsp;&nbsp;
                                        <input type="hidden" id="status" name="status">
                                        <input type="radio" name="radio" id="radio1" onClick="getStatus()" checked>
                                        ไม่ใช้ 
                                        <input type="radio" name="radio" id="radio2" onClick="getStatus()">
                                        ใช้                                 
                                </tr>

                                <tr>
                                    <td class="columnlabel">ประเภทงาน*</td>
                                    <td class="columnobject"><%=objuti.ShowSelectBox("select job_type_id,name_t from vmjob_type order by runno", "job_type_id", "name_t", "job_type_id")%>&nbsp;</td>
                                </tr>   
                                <tr>
                                    <td class="columnlabel">กองที่(วัตถุดิบ)&nbsp;</td>
                                    <td class="columnobject">
                                        <%=objuti.ShowSelectBox("select location_id,name_t,print_count,runno from vmlocation order by print_count desc ,runno desc", "location_id", "location_id", "location_id")%>&nbsp;</td>
                                    </td>
                                </tr>   
                                <tr>
                                    <td colspan='5' class='blankspace' ></td>
                                </tr>

                                <tr>
                                    <td colspan='5' class='blankspace' align="right">
                                        <input type="button" class="cgcButton_11" name="myBut" value=" พิมพ์รายงาน  " onClick="CheckDate();"/>
                                    </td>
                                </tr>               

                                <input name='year_document' type='hidden' id="year_document" value='' />

                                <%} else {%>
                                <input name='job_type_id' type='hidden' id="job_type_id" value='' />
                                <input name='date_form' type='hidden' id="date_form" value='2556-11-01' />
                                <input name='date_to' type='hidden' id="date_to" value='2556-11-01' />
                                <input name='status' type='hidden' id="status" value='' />
                                <input name='status1' type='hidden' id="status" value='' />
                                <input name='status2' type='hidden' id="status" value='' />
                                <input name='location_id' type='hidden' id="location_id" value='' />
                                <tr>
                                    <td class="columnlabel">ปี พ.ศ.</td>
                                    <td class="columnobject"><%=objuti.ShowSelectBox("select year_document from vm_year_carbon_burn_out", "year_document", "year_document", "year_document")%>&nbsp;</td>
                                </tr>                                                                 

                                <tr>
                                    <td colspan='5' class='blankspace' ></td>
                                </tr>

                                <tr>
                                    <td colspan='5' class='blankspace' align="right">
                                        <input type="button" class="cgcButton_11" name="myBut" value=" พิมพ์รายงาน  " onClick="CheckPrint();"/>
                                    </td>
                                </tr>

                                <%}%>


                                <tr>
                                    <td colspan='5' class='blankspace' ></td>
                                </tr>
                            </table>
                        </div>

                    </td>
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