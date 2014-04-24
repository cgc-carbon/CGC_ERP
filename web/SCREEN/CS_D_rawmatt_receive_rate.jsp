<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.Util.HeaderScreen_Report"%>
<%@page import="com.cgc.bean.DataBean_Screen_Report"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.DataBean_Screen_Process"%>
<%@page import="com.cgc.Util.HeaderScreen_Process"%>
<%@page import="com.cgc.bean.UserBean"%>
<html>
    <%!    String path, lookup, doc_eff_date, doc_no;
    %>
    <head>
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <META Http-Equiv="Cache-Control" Content="no-cache">
        <META Http-Equiv="Pragma" Content="no-cache">
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>
        <script type="text/javascript">
            function Chknull(){
                if(document.getElementById('doc_id').value == ''){
                    alert('กรุณาใส่ข้อมูลเลขที่เอกสาร');
                }else document.report.submit();
            }
            function Cal_quality(){
                var r = confirm("คุณต้องการวิเคราะห์ข้อมูลใช่หรือไม่")
                if(r)
                {
                    getSave(URLsend('chkNull,supplier_id,quality_id,year_text,select_rate,select_product_id,report_id,runner_id','../JSP/CS_D_rawmatt_receive_rate.jsp'))
                }
            }
            function cancle()
            {

                var r = confirm("คุณต้องการยกเลิกข้อมูลทั้งหมดหรือไม่")
                if(r)
                {
                    cancelAction();
                    
                }

            }
            
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css">
        <title>Insert title here</title>
    </head>
    <body onkeyup="chkEvent()">
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <%

                        UserBean userbean = (UserBean) session.getAttribute("user");
                        DataBean_Screen_Process objs_p = new DataBean_Screen_Process();
                        HeaderScreen_Process h_p = new HeaderScreen_Process();
                        objs_p = h_p.selectheaderscreen_process(objs_p, "CS_032");
                        // _______________________________________________________________report
                        DataBean_Screen_Report objr_p = new DataBean_Screen_Report();
                        HeaderScreen_Report r_p = new HeaderScreen_Report();
                        objr_p = r_p.Fn_Report(objr_p, "S507");
                        path = objr_p.getPath();
                        lookup = objr_p.getLookup();
                        doc_eff_date = objr_p.getDoc_eff_date();
                        doc_no = objr_p.getDoc_no();
                        //_______________________________________________________________report
%>
            <div id="toolTipLayer" style="position:absolute; visibility: hidden"></div>
            <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
            <input name="emp_id" type="hidden" id="emp_id" value="<%=userbean.getEmp_id()%>">
            <input name="dept_id" type="hidden" id="dept_id" value="<%=userbean.getDept_id()%>">
            <input type="hidden" id="chkNull" value="year_text,supplier_id,report_id,runner_id">
            <input type="hidden" id="status_a" value="1"><!-- เป็นการเพิ่มข้อมูลเข้าไป-->
            <input type="hidden" id="status_d" value="3"><!-- เป็นการ Delete ข้อมูลทั้งหมด -->
            <input type="hidden" id="status_cancle" value=""><!-- status_cancle = 1 คือค่าที่นำมา Edit แต่ถ้า ="" จะเป็นการ Insert -->
            <input type="hidden" id="child_ck" name="child_ck" value="">
            <!---------------------------------------------------report----------------------------->
            <input type="hidden" id="report_code" name="report_code"  value="<%=path%>">
            <input type="hidden" id="type_report" name="type_report" value="2">
            <input type="hidden" id="lookup" name="lookup" value="<%=lookup%>">
            <input type="hidden" id="doc_eff_date" name="doc_eff_date" value="<%=doc_eff_date%>">
            <input type="hidden" id="doc_no" name="doc_no" value="<%=doc_no%>">
            <div align="center">

                <table  cellpadding="0"  cellspacing="0">

                    <tr>
                        <td class="ftopleft"></td>
                        <td  class="ftopcenter" colspan="2">วิเคราะห์คุณภาพกะลาดิบของSupplier(CS_D_rawmatt_receive_rate)&nbsp;</td>
                        <td class="ftopright"></td>
                    </tr>
                    <tr >
                        <td class="fcenterleft"></td>
                        <td  colspan="2" class="fcentercenter">
                            <div align="center">
                                <table  cellpadding="0" cellspacing="0" >
                                    <tr>
                                        <td colspan="2" align="right"><b>หมายเลขเอกสาร : </b></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="right"><b>วันที่มีผลบังคับใช้ : </b></td>
                                    </tr>
                                    <tr>
                                        <td width="150" class="columnlabel"><b>เลขที่เอกสาร*</b>&nbsp;</td>
                                        <td width="607" class="columnobject">
                                            <input name='doc_id' type='text' id="doc_id" value='' size='20' readonly/>
                                            &nbsp;<a href='javascript:;' onClick="openBrWindow('vd_quality_rawmatt_receive_rate_header',312, '../JSP/Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหาข้อมูลที่ยังไม่ได้อนุมัติ' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a><!--&nbsp;<a id='date_1' ><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.gif' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField:'doc_date',ifFormat:'%d-%m-%Y',showsTime:false,button:'date_1',singleClick:true,step:1});</script>&nbsp;&nbsp;-->	          	</td>
                                    </tr>
                                    <tr>
                                      <td class="columnlabel">&nbsp;</td>
                                      <td class="columnobject"><input type="button" class="cgcButton_8" id="bt" value="ประมวลผล" onclick="Cal_quality()"></td>
                                    </tr>
                                    <tr>
                                      <td class="columnlabel">ช่วงเดือนการประเมิน</td>
                                      <td class="columnobject"><select name="select_rate" id="select_rate">
                                      	<option value="1">ม.ค.-เม.ย.</option>
                                        <option value="2">พ.ค.-ส.ค.</option>
                                        <option value="3">ก.ย.-ธ.ค.</option>
                                      </select>
                                        &nbsp;ปี
                                        <input type="text" name="year_text" id="year_text" size="10"/>&nbsp;&nbsp;&nbsp;&nbsp;ชนิดถ่าน
                                        <select name="select_product_id" id="select_product_id">
                                      	<option value="C">ถ่านกะลา</option>
                                        <option value="P">ถ่านไม่ยูคา</option>
                                        <option value="U">ถ่านกะลาปาล์ม</option>
                                      </select>                                    </td>
                                    </tr>
                                    <tr>
                                      <td class="columnlabel">ผู้ขาย*&nbsp;</td>
                                      <td class="columnobject"><input name='supplier_id' type='text' id="supplier_id" value='' size='20'  />                                        &nbsp;<a href='javascript:;' onClick="openBrWindow('msupplier',24, '../JSP/Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหาข้อมูลที่ยังไม่ได้อนุมัติ' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>
                                      <input name='supplier_id_desc' type='text' id="supplier_id_desc" value='' size='30' readonly/></td>
                                    </tr>
                                    <tr>
                                      <td class="columnlabel">รหัสด้านคุณภาพ</td>
                                      <td class="columnobject">
                                          <%= new UtiDatabase().ShowSelectBox("select quality_id,remark from m_quality_rawmatt_receive order by runno", "quality_id", "remark", "quality_id")%>
                                          
                                        &nbsp;&nbsp;&nbsp; </td>
                                    </tr>
                                    <tr>
                                      <td class="columnlabel">&nbsp;</td>
                                      <td class="columnobject">&nbsp;
                                          
                                        &nbsp;&nbsp;&nbsp; </td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel">ผู้วิเคราะห์&nbsp;</td>
                                        <td class="columnobject"><input name='report_id' type='text' id="report_id" value='' size='10' readonly/>
                                            <a href='javascript:;'onclick="openBrWindow('Vemployee', 29, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE6' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;
                                            <input name='report_id_desc' type='text' id="report_id_desc" value='' size='20' readonly/>
                                            <!--<input type="checkbox" name="prod_confirm" id="prod_confirm" value="N" onClick="Check_Confirm(this,'prod_dep')">
                                            ยืนยัน--></td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel">ผู้อนุมัติ</td>
                                        <td class="columnobject"><input name='runner_id' type='text' id="runner_id" value='' size='10' readonly/>
                                            <a href='javascript:;'onclick="openBrWindow('Vemployee1', 29, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE6' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;
                                            <input name='runner_id_desc' type='text' id="runner_id_desc" value='' size='20' readonly/>
                                            <!--<input type="checkbox" name="wh_confirm" id="wh_confirm" value="N" onClick="Check_Confirm(this,'wh_dep')">
                                            ยืนยัน--></td>
                                    </tr>
                                    <tr>
                                        <td colspan='2' class='blankspace'><br>
                                            <div align="center">
                                            <!-- <a href="javascript:;" onClick="cancle()"><img alt=""  src="../IMAGES/BTN_CANCEL_90.png" width="80" height="30" border="0"></a>
                                                 <a href="javascript:;" onClick="AddHeader()"><img alt=""  src="../IMAGES/BTN_SAVE_90.png" width="80" height="30" border="0"></a>
                                                 <a href="javascript:;" onClick="Delete()"><img alt=""  src="../IMAGES/BTN_DEL_90.png" width="80" height="30" border="0"></a>                <img src="../IMAGES/BTN_PRINT_90.png" width="80" height="30">-->&nbsp;&nbsp;&nbsp;                                            </div>                           </td>
                                    </tr>
                                    <tr>
                                        <td colspan='2' class='blankspace'><br>
                                            <div align="center">
                                                <a href="javascript:;" onClick="cancle()"><img alt=""  src="../IMAGES/BTN_CANCEL_90.png" width="80" height="30" border="0"></a>
                                                <a href="javascript:;" onClick="Cal_quality()"><img alt="ประมวณผล"  src="../IMAGES/BTN_SAVE_90.png" width="80" height="30" border="0"></a>
                                                <!--<a href="javascript:;" onClick="Delete()"><img alt=""  src="../IMAGES/BTN_DEL_90.png" width="80" height="30" border="0"></a>-->
                                                <a href="javascript:;"  onclick="Chknull()"><img alt="พิมพ์เอกสาร" src="../IMAGES/BTN_PRINT_90.png" width="80" height="30" border="0"></a>                                        </div>
                                            <br>                                  </td>
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
            </div>
        </form>
    </body>
</html>

