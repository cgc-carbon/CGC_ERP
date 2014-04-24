<%@page import="com.cgc.Util.HeaderScreen_Report"%>
<%@page import="com.cgc.bean.DataBean_Screen_Report"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.DataBean_Screen_Process"%>
<%@page import="com.cgc.Util.HeaderScreen_Process"%>
<%@page import="com.cgc.bean.UserBean"%>
<html>
    <%!    String path, lookup, doc_eff_date, doc_no;
    %>
    <head>
        <META Http-Equiv="Cache-Control" Content="no-cache">
        <META Http-Equiv="Pragma" Content="no-cache">
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <!-- calendar stylesheet -->
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <!-- main calendar program -->
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <!-- language for the calendar -->
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <!-- the following script defines the Calendar.setup helper function, which makes
               adding a calendar a matter of 1 or 2 lines of code. -->
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>
        <script type="text/javascript">
            function Chknull(){
                if(document.getElementById('doc_id').value == ''){
                    alert('กรุณาใส่ข้อมูลเลขที่เอกสาร');
                }else document.report.submit();
            }
            function goAddChild(URLSend)
            {
                var arryChk = new Array;
                arryChk[0] = "chkNull"
                if(ChkParameter(arryChk))
                {
                    window.open(URLSend[0]);
                }

            }
            function cancle()
            {

                var SURL;
                var r = confirm("คุณต้องการยกเลิกข้อมูลทั้งหมดหรือไม่")
                if(r)
                {
                    if(getId("status_cancle").value == "1")
                    {
                        cancelAction();
                        getId("status_cancle").value = "";
                        getId("child_ck").value = "";
                        getId("show").innerHTML = "";
                        getId("doc_id").disabled = false;
                    }
                    else  if(getId("status_cancle").value == "1" && getId("child_ck").value == "1")
                    {
                        alert("มีการเปลี่ยนแปลงข้อมูลกรุณาบันทึกข้อมูล");
                    }
                    else{
                        SURL = "../JSP/CS_028_2.jsp?status_d=3&chk_all=1&username="+getId("username").value;
                        SURL = SURL+"&doc_id="+getId("doc_id").value;
                        Delete_Line_no(SURL)
                        cancelAction();
                        getId("status_cancle").value = "";
                        getId("child_ck").value = "";
                        getId("show").innerHTML = "";
                        getId("doc_id").disabled = false;
                    }
                    
                }

            }
            function ckall(Value)//ทำการกดปุ้ม check ทั้งหมดใช้หรือไม่
            {

                for(var i=0;i<document.getElementsByName("ckbox").length;i++)
                {
                    document.getElementsByName("ckbox")[i].checked = Value;
                }

            }
            function goDelChild()
            {
                showTableNonPopup("show", "doc_id", "../JSP/CS_Show028_2.jsp?doc_id=");
                setTimeout('showTableNonPopup("show", "doc_id", "../JSP/CS_Show028_2.jsp?doc_id=")', 1000);
                
            }
            function OpenEdit(URLSend)
            {
                window.open(URLSend[0]);
            }
            function AddHeader()
            {
                var r = confirm("คุณต้องการบันทึกหรือไม่")
                if(r)
                {
                    getSave(URLsend('chkNull,doc_id,document_confirm_flag,remark,return_complete_flag,username','../JSP/CS_027_2.jsp'));
                    getId("status_cancle").value = "";
                    getId("child_ck").value = "";
                    getId("show").innerHTML = "";
                    getId("return_complete_flag").value = "N";
                    getId("return_complete_flag").checked =false;
                    getId("document_confirm_flag").value = "N";
                    getId("document_confirm_flag").checked = false;
                    setTimeout('getId("total_weight").value = "0";getId("total_weight_chk").value = "0"',1000);
                    //setTimeout('window.location.reload()',1000);
                }
                
            }
            function Delete()
            {
                
            }
            function Unload()
            {
            }
            function OpenDoc_id(case_input)
            {
                if(case_input == 1){
                    openBrWindow('vd_carbon_burn_in_header_wh&stadment=and+complete_flag+=+\'N\'+and+doc_type+=+\'N\'', 27, '../JSP/Search_Doc_id.jsp');
                }else{
                    openBrWindow('vd_carbon_burn_in_header_wh&stadment=and+complete_flag+=+\'N\'+and+doc_type+=+\'Y\'', 27, '../JSP/Search_Doc_id.jsp');
                }
            }
             function Checkvalue(thisvalue){
                if(thisvalue){
                    getId("return_complete_flag").value = "Y";
                    getId("document_confirm_flag").value = "N";
                    getId("document_confirm_flag").checked = false;
                    alert("ทำการส่งเอกสารกลับเพื่อทำการแก้ไขข้อมูล");
                }else{
                    getId("return_complete_flag").value = "N"
                    getId("document_confirm_flag").value = "N";
                    getId("document_confirm_flag").checked = false;
                    //alert("เอกสารนี้สมบูรณ์เรียบร้อยแล้ว");
                }
            }
            function Checkvalue_document_confirm(objthis){
                if(objthis.checked){
                    alert("ยืนยันการแก้ไขเอกสาร");
                    objthis.value = "Y";
                    getId("return_complete_flag").value = "N";
                    getId("return_complete_flag").checked = false;
                }else{
                    objthis.value = "N";
                    getId("return_complete_flag").value = "N";
                    getId("document_confirm_flag").checked = false;
                }
                //alert(objthis.value);
            }
            
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css">
        <title>Insert title here</title>
    </head>
    <body onUnload="Unload()">
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <%
                UserBean userbean = (UserBean) session.getAttribute("user");
                DataBean_Screen_Process objs_p = new DataBean_Screen_Process();
                HeaderScreen_Process h_p = new HeaderScreen_Process();
                objs_p = h_p.selectheaderscreen_process(objs_p, "CS_027");
                UtiDatabase objuti = new UtiDatabase();
                // _______________________________________________________________report
                DataBean_Screen_Report objr_p = new DataBean_Screen_Report();
                HeaderScreen_Report r_p = new HeaderScreen_Report();
                objr_p = r_p.Fn_Report(objr_p, "S504");
                path = objr_p.getPath();
                lookup = objr_p.getLookup();
                doc_eff_date = objr_p.getDoc_eff_date();
                doc_no = objr_p.getDoc_no();
                //_______________________________________________________________report
%>
            <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
            <input type="hidden" id="date_ck" name="date_ck" value="">
            <input type="hidden" id="child_ck" name="child_ck" value="">
            <input type="hidden" id="chkNull" value="doc_id,doc_date,time_from,time_to,runner_id,shift,burn_no,wh_in,wh_out">
            <input type="hidden" id="status_a" value="1"><!-- เป็นการเพิ่มข้อมูลเข้าไป-->
            <input type="hidden" id="status_d" value="3"><!-- เป็นการ Delete ข้อมูลทั้งหมด -->
            <input type="hidden" id="status_cancle" value=""><!-- status_cancle = 1 คือค่าที่นำมา Edit แต่ถ้า ="" จะเป็นการ Insert -->
            <!---------------------------------------------------report----------------------------->
            <input type="hidden" id="report_code" name="report_code"  value="<%=path%>">
            <input type="hidden" id="type_report" name="type_report" value="2">
            <input type="hidden" id="lookup" name="lookup" value="<%=lookup%>">
            <input type="hidden" id="doc_eff_date" name="doc_eff_date" value="<%=doc_eff_date%>">
            <input type="hidden" id="doc_no" name="doc_no" value="<%=doc_no%>">
            <table  cellpadding="0"  cellspacing="0">
                <tr >
                    <td class="ftopleft"></td>
                    <td  class="ftopcenter" colspan="2">ใบบันทึกถ่านเติมเตา(คลังสินค้า)(CS_027_2)&nbsp;</td>
                    <td class="ftopright"></td>
                </tr>
                <tr>
                    <td class="fcenterleft"></td>
                    <td  colspan="2" class="fcentercenter">
                        <div align="left">
                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="2" align="right"><b>หมายเลขเอกสาร : <%=objs_p.getIso_no()%></b></td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="right"><b>วันที่มีผลบังคับใช้ : <%=objs_p.getEffective_date()%></b></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">ส่งเอกสารกลับเพื่อแก้ไขข้อมูล</td>
                                    <td class="columnobject"><input id="return_complete_flag" type="checkbox" onclick="Checkvalue(this.checked)" value="N" name="return_complete_flag"/></td>
                                </tr>
                                <tr>

                                    <td width="150" class="columnlabel"><b>เลขที่เอกสาร*</b>&nbsp;</td>
                                    <td width="607" class="columnobject">
                                        <input name='doc_id' type='text' id="doc_id" value='' size='15' readonly/>
                                        &nbsp;<a href='#' onClick="OpenDoc_id(1)"  ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหาที่ยังไม่ได้ยืนยัน' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
                                        <a href='#' onClick="OpenDoc_id(2)"  ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหาเอกสารที่ยืนยัน' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
                                        วันที่เอกสาร*&nbsp;
                                        <input name='doc_date' type='text' id="doc_date" value='' size='10' readonly="readonly"/>
                                        &nbsp;<a id='date_1'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.gif' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField:'doc_date',ifFormat:'%d-%m-%Y',showsTime:false,button:'date_1',singleClick:true,step:1});</script>&nbsp;&nbsp;                                </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">เวลา&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='time_from' type='text' id="time_from" value='' size='10' maxlength="5" />
                                        &nbsp;&nbsp;&nbsp;
                                        ถึง&nbsp;&nbsp;&nbsp;
                                        <input name='time_to' type='text' id="time_to" value='' size='10' maxlength="5" />                                </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">ผู้บันทึก&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='runner_id' type='text' id="runner_id" value='' size='10' readonly="readonly" />
                                        &nbsp;&nbsp;&nbsp;<a href='#' onClick="openBrWindow('Vemployee', 27, '../JSP/Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;<input name='runner_id_desc' type='text' id="runner_id_desc" value='' size='30' readonly="readonly" />                                </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">ช่วงเวลาทำงาน(กะ)&nbsp;</td>
                                    <td class="columnobject">
                                        <%=objuti.ShowSelectBox("select shift_id,name_t from mshift where shift_grp = '3' order by runno", "shift_id", "name_t", "shift")%>
                                        <!--select name='shift' id="shift">
                                            <option value='1'>เช้า</option><option value='2'>บ่าย</option><option value='3'>ดึก</option></select>-->&nbsp;&nbsp;&nbsp;
                                        หมายเลขเตาเผา&nbsp;
                                        <input name='burn_no' type='text' id="burn_no" value='' size='10' />                                </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">คลังจ่าย&nbsp;</td>
                                    <td class="columnobject">
                                        <input type="hidden" size="10" id="wh_in" name="wh_in" value="<%=objs_p.getWarehouse_begin_id()%>" ><input type="text" size="20"  id="wh_in_desc" name="wh_in_desc" value="<%=objs_p.getWarehouse_begin_name()%>">
                                        <a href='#' onClick="openBrWindow('Wh_bg&stadment=and+warehouse_id+=+\'<%=objs_p.getWarehouse_begin_id()%>\'', 23, '../JSP/Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>
                                        &nbsp;&nbsp;&nbsp;คลังรับ&nbsp;
                                        <input type="hidden" size="10"  id="wh_out" name="wh_out" value="<%=objs_p.getWarehouse_end_id()%>"><input type="text"  size="20"  id="wh_out_desc" name="wh_out_desc" value="<%=objs_p.getWarehouse_end_name()%>">
                                        <a href='#' onClick="openBrWindow('Wh_en&stadment=and+warehouse_id+=+\'<%=objs_p.getWarehouse_end_id()%>\'', 23, '../JSP/Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>                                                                      </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">Butane (เป้าหมาย)&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='bu' type='text' id="bu" value='' size='20' maxlength="50" />
                                        &nbsp;&nbsp;&nbsp;
                                        Iodine (เป้าหมาย)&nbsp;&nbsp;&nbsp;
                                        <input name='iod' type='text' id="iod" value='' size='20' maxlength="50" /><a href='#' onClick="openBrWindow('m_iodine', 27, '../JSP/Search_Config3.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>                                </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">ยืนยันเอกสาร</td>
                                    <td class="columnobject"><input id="document_confirm_flag" type="checkbox" onclick="Checkvalue_document_confirm(this)" value="N" name="document_confirm_flag"/></td>
                                </tr>
                                <tr>
                                    <td colspan='2' class='blankspace'></td>
                                </tr>
                                <tr>
                                    <td height="200" colspan="2" align="center">
                                        <div style="width:100%;">
                                            <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner">
                                                <tr>
                                                    <td colspan="4" class="h_multi">ข้อมูลถ่านเติมเตา</td>
                                                    <td colspan="5" class="btn_multi">
                                                        <input type='button' class="cgcButton_4" name='but1' value='  เพิ่ม  ' onClick="javascript:goAddChild(URLsend('doc_id,total_weight,status_a,username','CS_028_2.jsp'));"/>
                                                        <input type='button' class="cgcButton_3" name='but2' value='  ลบ  ' onclick='goDelChild()'/>                                                </td>
                                                </tr>
                                                <tr>
                                                    <td class="row3" width="3px"><input type="checkbox" name="chk_all" id="chk_all" value="chk_all" onClick="javascript:ckall(this.checked);"/></td>
                                                    <td class="row3" width="7%">ลำดับที่  </td>
                                                    <td class="row3" width="7%">ถังที่&nbsp;</td>
                                                    <td class="row3" width="10%">ไซโล&nbsp;</td>
                                                    <td class="row3" width="25%">ถ่าน&nbsp;</td>
                                                    <td class="row3" width="15%">กองที่&nbsp;</td>
                                                    <td class="row3" width="15%">น้ำหนักถัง+ถ่าน&nbsp;</td>
                                                    <td class="row3" width="10%">น้ำหนักถัง&nbsp;</td>
                                                    <td class="row3" width="10%">น้ำหนักถ่าน&nbsp;</td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div style="width:100%; height: 150px; overflow: auto;" id="show">                                    </div>                                </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="right">ผู้ปฏิบัติงาน
                                        <input name="operate_id" type="text" id="operate_id" size="10">
                                        <a href='#' onClick="openBrWindow('Vemployee1', 27, '../JSP/Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>
                                        <input type="text" name="operate_id_desc" id="operate_id_desc">
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;จำนวนถัง
                                        <input name="tank_qty" type="text" id="tank_qty" size="10">
                                        &nbsp;&nbsp;ถัง&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;น้ำหนักรวม*&nbsp;
                                        <input name='total_weight' type='text' id="total_weight" value='0' size='10' readonly="readonly"/>
                                        &nbsp;(Kg)
                                        <input name="total_weight_chk" type="hidden" id="total_weight_chk" value="0" size="10"/></td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;หมายเหตุ<input type="text" id="remark" name="remark" size="50"></td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="right"></td>
                                </tr>
                                <tr>
                                    <td colspan='2' class='blankspace'>
                                        <br>
                                        <div align="center">
                                            <a href="javascript:;" onClick="cancle()"><img alt=""  src="../IMAGES/BTN_CANCEL_90.png" width="80" height="30" border="0"></a>
                                            <a href="javascript:;" onClick="AddHeader()"><img alt=""  src="../IMAGES/BTN_SAVE_90.png" width="80" height="30" border="0"></a>
                                            <!--<a href="javascript:;" onClick="Delete()"><img alt=""  src="../IMAGES/BTN_DEL_90.png" width="80" height="30" border="0"></a>
                                            <a href="javascript:;"  onclick="Chknull()"><img alt="พิมพ์เอกสาร" src="../IMAGES/BTN_PRINT_90.png" width="80" height="30" border="0"></a>-->
                                        </div>
                                        <br>                                </td>
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