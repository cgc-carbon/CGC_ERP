<%@page import="com.cgc.bean.UserBean"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.Util.HeaderScreen_Report"%>
<%@page import="com.cgc.bean.DataBean_Screen_Report"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <%!    String path, lookup, doc_eff_date, doc_no, report_username, sub_menu_id, report_cond1, report_cond2;
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
            
            function bt_report(){
                //alert(ChkDate(document.report.date_f.value, document.report.date_t.value));
                var submit_boolen = false;
                var param_to = document.report.param_t.value ,
                param_from = document.report.param_f.value,
                date_to = document.report.date_t.value,
                date_from = document.report.date_f.value;
                var chk_param  = (param_to == "" && param_from == "")?true:false;
                var chk_date = (date_to == "" && date_from == "")?true:false;
                if(chk_param == false && chk_date == true){
                    if(param_to != "" && param_from != ""){
                        submit_boolen = true;
                    }else{
                        alert("กรุณากรอกข้อมูลให้ครบ");
                    }
                }else if(chk_param == true && chk_date == false){
                    if(chk_date == false){
                        if(date_to != "" && date_from != ""){
                            if(!ChkDate(document.report.date_f.value, document.report.date_t.value)){
                                document.report.date_form.value = format_Date(date_from);//dateFormat(da1.format,'yyyy-mm-dd').tostring;
                                document.report.date_to.value =  format_Date(date_to);
                                submit_boolen = true;
                            }else{
                                alert("กรุณากรอกใส่วันที่ให้ถูกต้อง");
                            }
                        }else{
                            alert("กรุณากรอกวันที่ให้ครบ");
                        }
                    }
                }else if(chk_param == false && chk_date == false){
                    if(!chk_param){
                        if(param_to != "" && param_from != ""){
                            submit_boolen =true;
                        }else{
                            alert("กรุณากรอกข้อมูลให้ครบ");
                        }
                    }
                    if(!chk_date && submit_boolen){
                        if(date_to != "" && date_from != ""){
                            if(!ChkDate(document.report.date_f.value, document.report.date_t.value)){
                                document.report.date_form.value = format_Date(date_from);//dateFormat(da1.format,'yyyy-mm-dd').tostring;
                                document.report.date_to.value =  format_Date(date_to);
                                submit_boolen = true;
                            }else{
                                submit_boolen = false;
                                alert("กรุณากรอกใส่วันที่ให้ถูกต้อง");
                            }
                        }else{
                            submit_boolen = false;
                            alert("กรุณากอกวันที่ให้ครบ");
                        }
                    }
                }else{
                    submit_boolen = true;
                }
                if(submit_boolen){
                    //alert("test");
                    document.report.submit();
                }
            }
        </script>
    </head>

    <body onUnload="closepopup()">
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">

            <% UtiDatabase objuti = new UtiDatabase();
            %>

            <input type="hidden" name="report_code" value="<%=path%>">
            <input type="hidden" name="lookup" value="<%=lookup%>">
            <table  cellpadding="0"  cellspacing="0">
                <tr>
                    <td class="ftopleft"></td>
                    <td  class="ftopcenter" colspan="2">รายงาน 1&nbsp;</td>
                    <td class="ftopright"></td>
                </tr>
                <tr >
                    <td class="fcenterleft"></td>
                    <td  colspan="2" class="fcentercenter">
                        <%if (path.charAt(4) != '7') {%>
                        <div align="center">
                            <input type="hidden" name="type_report" value="1">
                            <input type="hidden" name="cond_report" value="1">
                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="2"  class="blankspace"></td>
                                </tr>
                                <tr>
                                    <td colspan='2' class='blankspace' ></td>
                                </tr>
                                
                                <tr>
                                    <td class="columnlabel"><b>ปี พ.ศ.*&nbsp;</b></td>                               
                                    <td colspan="3" class="columnobject">
                                        <%=objuti.ShowSelectBox("select price_year from vmproduct_price_year order by price_year desc", "price_year", "price_year", "price_year", "price_year", "-")%>

                                    </td>
                                </tr>                                

                                <tr>
                                    <td colspan='4' class='blankspace' align="right">
                                        <input type="button" class="cgcButton_11" name="myBut" value=" พิมพ์รายงาน  " onClick="javascript:document.report.submit();"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan='2' class='blankspace' ></td>
                                </tr>
                            </table>
                        </div>
                        <%} else {%>
                        <div align="center">
                            <input type="hidden" name="type_report" value="3">
                            <input type="hidden" name="cond_report" value="3">
                            <input type="hidden" name="date_form" value="">
                            <input type="hidden" name="date_to" value="">
                            <input type="hidden" name="report_cond1" value="<%=report_cond1%>">
                            <input type="hidden" name="report_cond2" value="<%=report_cond2%>">                            
                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="5"  class="blankspace"></td>
                                </tr>

                                <tr><td colspan='5'><b>กำหนดเงื่อนไข การออกรายงาน</b></td>
                                </tr>
                                <tr>
                                    <td width="180" class='columnobject'><div align="right">เลขที่เอกสารเริ่มต้น&nbsp;:&nbsp;</div></td>
                                    <td width="450" class='columnobject'>
                                        <input type='text' name='param_f' id="param_f" value='' />
                                        &nbsp; <a href='javascript:;' onClick="openBrown('<%=lookup%>','param_f')" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a></td>
                                    <td width="180" class='columnobject'><div align="right">เลขที่เอกสารสิ้นสุด&nbsp;:&nbsp;</div></td>
                                    <td width="450" class='columnobject'>
                                        <input type='text' name='param_t' id="param_t" value=''/>&nbsp;&nbsp;
                                        <a href='javascript:;' onClick="openBrown('<%=lookup%>','param_t')" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE2' width='20' height='20' border='0' align='middle' ></a>                                    </td>
                                </tr>
                                <tr>
                                    <td width="180" class='columnobject'><div align="right">วันที่เริ่มต้น&nbsp;:&nbsp;</div></td>
                                    <td width="450" class='columnobject'><input name='date_f' type='text' id="date_f" value='' disabled/>
                                        &nbsp;<a id='date_1' href="javascript:;"><img name='IMAGE4' src='../IMAGES/BUTTON/MAIN/CALENDAR20.gif' border='0' align='absmiddle'></a>
                                        <script type='text/javascript'>Calendar.setup({inputField:'date_f',ifFormat:'%d-%m-%Y',showsTime:false,button:'date_1',singleClick:true,step:1});</script>                                    </td>
                                    <td width="180" class='columnobject'><div align="right">ถึงวันที่&nbsp;:&nbsp;</div></td>
                                    <td width="450" class='columnobject'><input name='date_t' type='text' id="date_t" value='' disabled/>
                                        &nbsp;<a id='date_2' href="javascript:;"><img name='IMAGE4' src='../IMAGES/BUTTON/MAIN/CALENDAR20.gif' border='0' align='absmiddle'></a>
                                        <script type='text/javascript'>Calendar.setup({inputField:'date_t',ifFormat:'%d-%m-%Y',showsTime:false,button:'date_2',singleClick:true,step:1});</script>                                    </td>
                                </tr>
                                <!--tr>
                                    <td class="columnlabel">รหัสสินค้า&nbsp;</td>
                                    <td class="columnobject">
                                        <%=objuti.ShowSelectBox("select product_id,name_t,print_count,runno from mproduct order by print_count desc ,runno desc", "product_id", "product_id", "product_id")%>&nbsp;</td>
                                    </td>
                                </tr-->   

                                <tr>
                                    <td class="columnlabel">รหัสสินค้า*</td>
                                    <td class="columnobject"><input name="product_id" type="text" id="product_id" value="" size="20" readonly>&nbsp;&nbsp;<a href='#' onClick="openBrWindow('Vproduct', 301, '../JSP/Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
                                        <input type="hidden" name="product_id_desc" id="product_id_desc" value="" size="70"></td>
                                </tr>

                                <tr>
                                    <td class="columnlabel">ขนาดถ่าน (เงื่อนไขเพิ่มเติม บางรายงาน)&nbsp;</td>
                                    <td class="columnobject">                                        
                                        <%=objuti.ShowSelectBox("select size_id,name_t from m_carbon_size order by size_id", "size_id", "name_t", "spec_size")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">กองที่(วัตถุดิบ)&nbsp;</td>
                                    <td class="columnobject">
                                        <%=objuti.ShowSelectBox("select location_id,name_t,print_count,runno from vmlocation order by print_count desc ,runno desc", "location_id", "location_id", "location_id")%>&nbsp;</td>
                                    </td>
                                </tr>                                   

                                <input type="hidden" name="iod_value" value="-">

                                <td colspan='5' class='blankspace' ></td>
                                </tr>

                                <tr>
                                    <td colspan='5' class='blankspace' align="right">
                                        <input type="button" class="cgcButton_11" name="myBut" value=" พิมพ์รายงาน  " onClick="bt_report()"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan='5' class='blankspace' ></td>
                                </tr>
                            </table>
                        </div>
                        <%}%>
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